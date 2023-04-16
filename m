Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1333BC77B73
	for <git@archiver.kernel.org>; Sun, 16 Apr 2023 18:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjDPSlA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Apr 2023 14:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjDPSk7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2023 14:40:59 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28EACE74
        for <git@vger.kernel.org>; Sun, 16 Apr 2023 11:40:58 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2a8aea2a610so8960951fa.3
        for <git@vger.kernel.org>; Sun, 16 Apr 2023 11:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681670455; x=1684262455;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wqYq7wuBB6HstTpXtce6TWyaHUi3KI6qWmjzubuv7w4=;
        b=nu6+RgHOAGeDhbv7W7Dugv7Au5e6e9WdbPUf/eNDQBgPiFVMaIGFHnvOcF6RqDtnlM
         A8QbA2r8WEm0Q6V7yp+8hm1nWJ2wkAeE9pPvjefXMC8XEiqK4XKtImBF0VMHeTUL8hF1
         5go5Pq19l6Shh4risTXI0zcDBIoKDEIRYTWd80E0UHFFGT7douKblRlnZEHBHJtz+v/T
         ytq0J4KBzRcLez0uda5HmduLZRzV/AmNW19jPcBr8f3llkGZ7V9rjQygRwJ9KvsKIt/0
         qmjLPiSRbNfj552T+jBfPjBHIi9CyCbPFMsaBNkVO4R9twYY88hhhaxKq0HsDpJtGF5R
         +/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681670455; x=1684262455;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wqYq7wuBB6HstTpXtce6TWyaHUi3KI6qWmjzubuv7w4=;
        b=e3YSVHpg2lHdgb4Z/8whsBl4BOciNzBFcjQKbt9KOYVgugnM7tItF5tc9tTZluw5bw
         LhyJ87yMdK2EQ1NpoBg09kcoymE4jLZgiYWeyXKet6r9y3JUmj9l5c2JjjY89Asqn6Gu
         yMxJaicVgWoRQAg0tbFEwBY1u19EeHg8wT08ERdZrL08T5TUBEGB8r0fxkV0m59wxWAr
         3XdSLsHeOB6+QX8fKauWeAndM5KIHiMjOWONfj5Xsdb7cQzR+3P039EgXoKcJwC85q7o
         ap3bb6crV09kzz34m3UhykzziNClweZz9zZwKu40ikKYedWCoFAaVdQ+ZdUp/Xqt2A+Z
         qJMQ==
X-Gm-Message-State: AAQBX9cFV1JYIFVVaivQjAPhedEqSK0B4XzxHUPfHL+v9FhGrF//MCI8
        Llp+o85NJWWW/E24awoFqRrhKGHrAfczat+46tydXNEQwvpAsg==
X-Google-Smtp-Source: AKy350YwODtp6Kmf0WuIcd4t6vl9fgpggsdE74c2LUbMgaVB5KxxgbOiz19nNMKNzpyjdyW6GNKkSVhMArJsFthtMS8=
X-Received: by 2002:a19:5214:0:b0:4eb:1192:ce6f with SMTP id
 m20-20020a195214000000b004eb1192ce6fmr1444470lfb.13.1681670455388; Sun, 16
 Apr 2023 11:40:55 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Ma=C3=ABl_Nison?= <nison.mael@gmail.com>
Date:   Sun, 16 Apr 2023 20:40:43 +0200
Message-ID: <CANiF4iAaWB9j+Mma0-yfp6GvoQuM4k_OBAXn0keR+vCg8PQjmA@mail.gmail.com>
Subject: Glob patterns w/ **; zero or more?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I noticed that, in a repo with a single `main.c` file, `git ls-files
'./**/main.c'` (note the surrounding quotes, to avoid shell globbing)
returns no result even though `git ls-files main.c` does. It however
can find any `main.c` file located in a subdirectory, suggesting `**`
is interpreted as "one or more" rather than "zero or more". Can you
confirm it'd be a bug? I checked in both 2.38 and 2.40.

For reference, the documentation is explicit that `**` is "zero or
more", not "one or more", and it matches the behaviour from other glob
implementations (emphasis mine):

> A slash followed by two consecutive asterisks then a slash matches ***zer=
o or
> more directories***. For example, "a/**/b" matches "a/b", "a/x/b", "a/x/y=
/b" and so on.

Also quoting the bash documentation for reference:

> globstar
> If set, the pattern =E2=80=98**=E2=80=99 used in a filename expansion con=
text will match all files
> and zero or more directories and subdirectories. If the pattern is follow=
ed by
> a =E2=80=98/=E2=80=99, only directories and subdirectories match.
