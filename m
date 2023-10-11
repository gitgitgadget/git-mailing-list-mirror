Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41ABBCD98C7
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 05:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjJKFuu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 01:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjJKFut (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 01:50:49 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BF6B9
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 22:50:47 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d9a6399cf78so522003276.0
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 22:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697003447; x=1697608247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4JWPCAf7TvcNoXp7O8n2oAKFNsTIAwbr7f05zPu+9OQ=;
        b=c9jjZqI4TxNHYZfVbY0AcBENjP8z450WYt4moMzthjSjfIFgPoqFUvTpK76VmGFixN
         MPPakY8a5gWKiSbOf6UmHpCtYgQNXEaXxxMk77sckY5r0je6Zrb4PKq4KnPIZELndtrn
         RNqbJOhsG2VZvSpICw0pRbrpY9qGl+zHS8LcQjxCPfRVw+I4dh5ymt6nzvJyXu2GknHL
         NkQwnGLzeanm2K88m49mgOEyqjm5vrNUIQpSP/ZQ8rYNZvVr/PhayEmgLN6fWr7u61ac
         JMScowHH68WGJP0ghNcT213wopR3E3TDxPU0CUz/zZuRSQE+7gMylE2iVIzxp99cPcHf
         w3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697003447; x=1697608247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4JWPCAf7TvcNoXp7O8n2oAKFNsTIAwbr7f05zPu+9OQ=;
        b=rXzzTM4TdkTJo0qT43dMP21e9aRIYMHy8V5Meyid5zK5048681OM7CwWjd+AEmdI++
         6Ns2hwR1YrVKXfGeMdkEIVDiBwfu0b7XvEAb+ldFrAxKX4Euwh6QYKAZSYfyd6GUS5Al
         Btiif6OeC4+YjAUSfECv7wxaPgA3a7OP2SgRKr3ll0PsdR6IoO6MS0nj5snVYX11GSpb
         zbr+r+02gQYKt5+0kY9l2RHjog7LKD/7YxMewP4yGFQlYfCW5eVFx/Jcs0+hvYQ+jR3M
         yYrABaSdYzFbGIq+OGW8C+yaYqn/th5ffjFvJ5WtsYcbEpZEbsUtysWj9yraXBi9EKWv
         Gl6Q==
X-Gm-Message-State: AOJu0Yzrrfl7j5fa9WwkTLYFJOB+Vp2oufK1FrdBIzxBTA2orx+pxf86
        pwYcLS8n2dDdwLDgWaYneZzRpd5qIkCwF9ljjztVU6ZR8FcG
X-Google-Smtp-Source: AGHT+IFsPjmCpvlSyBhWshzaT0eR0hEGoGbDEXjtZb0DIVqPKGS2W9DMicvZnJmyGhmOyyADR2yaXpLyvXvhsXH31lI=
X-Received: by 2002:a25:ad66:0:b0:d9a:52dc:15d6 with SMTP id
 l38-20020a25ad66000000b00d9a52dc15d6mr3037671ybe.2.1697003446625; Tue, 10 Oct
 2023 22:50:46 -0700 (PDT)
MIME-Version: 1.0
References: <20231009011546.509-1-naomi.ibeh69@gmail.com> <xmqqlecbzl5e.fsf@gitster.g>
 <CACS=G2yUGGJwD05KOFZK+AV3TSNDvDEfC=pFRsLwKX_-dgt+gA@mail.gmail.com> <xmqq34yiqfoh.fsf@gitster.g>
In-Reply-To: <xmqq34yiqfoh.fsf@gitster.g>
From:   Naomi Ibe <naomi.ibeh69@gmail.com>
Date:   Wed, 11 Oct 2023 06:50:30 +0100
Message-ID: <CACS=G2wXkz9OyR5e0ADzWVy3ejibF-Js=sdJYJDRMh8qskO-9A@mail.gmail.com>
Subject: Re: [PATCH 1/1] [OUTREACHY] Fixed add.c file to conform to guidelines
 when using die() listed in issue #635
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Okay then, I'll work with these guidelines in mind. Thank you very much

On Tue, Oct 10, 2023 at 11:24=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Naomi Ibe <naomi.ibeh69@gmail.com> writes:
>
> > Thank you very much! I'd definitely make those changes on my next patch=
.
>
> [administrivia] do not top post.
>
> > Should I begin work on version 2 or should I still wait for additional
> > input on the version 1?
>
> There is no "rule", but based on observations on how people behave,
> e.g.
>
>  * for a small patch like this that can be given a good review in 10
>    minutes or so, those who do not do so within the first 3 days
>    will probably not do so.
>
>  * once a reasonably thorough review is given, those who haven't
>    responded to the patch and do not have much else to say are
>    unlikely to respond.
>
>  * on the other hand, after such a review is given, those who do not
>    agree with the review tend to respond rather quickly, to get
>    their voice in before it becomes too late.
>
> I would say it would be good to start working on it right away and
> use a couple of days reviewing it yourself before posting it.
