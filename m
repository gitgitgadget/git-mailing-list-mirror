Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF744E95A91
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 08:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345456AbjJIIDc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 04:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345449AbjJIIDb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 04:03:31 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CBF94
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 01:03:29 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9a9f139cd94so698116466b.2
        for <git@vger.kernel.org>; Mon, 09 Oct 2023 01:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696838608; x=1697443408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wBSuyTtccpdEcLn/oNJNs1/kUSpk2q6WCNEaPGktrpg=;
        b=YcCkpXXjZ4jt7CiCgFZXFR86CpSWcKDcwUOjjsTDGRxGn5f98Z7a12qu5qqyBNPmBR
         A1+qT2msc+3DCGuuWZzbb653aekJKkroZzNH4l4FFt33iqLQ5RNdAdTEaIeje81iPBWb
         8hCL2hzesKWzXJHqPpchn3HWEp+fm8NBWA/TCoCHrp7EAMAD/eTdW8XXy0sMKPL6Z2RV
         DJwE+daBJqoXTXYbpRomvHjmD6QdBuxqfEuA1GCA1QULrxHPsKA0pfy+BUmiDeip2RxL
         mgDFLzEd1S3qhkoy+nheTF1CjBPUPmsEdiO8muTQLrBW6fQLf3pwI9nc1f/N8bzfQkA5
         FlvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696838608; x=1697443408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wBSuyTtccpdEcLn/oNJNs1/kUSpk2q6WCNEaPGktrpg=;
        b=KVR3Mgod4vd5dQO92A0XqEIDsz1EvwivCkWqGjvkH6qpSsDlGhpPlG73EwLTVISh1W
         t9pCd1uO7+ADJy3J4c87tGg/me7vjNny21+y4yXW7XBd/SR0hAhIGhNYh/C6TVmk9r/r
         hqeWVbhH1cMFgJWWRfwW3hYzDu8DCitWuV85E7iBnYz65cZ0ekbGNte9XB2zBuqb0CP3
         VSXe+fzAyY0fMqOOLG2VpnCrVmPYO1voNtO8l9joORt6zmhE7qj3yfDRkoWGJPAkqrcL
         QE0qtpUP4KV/fcnHdbJ+Ml/blmHdNkd6c1HvvAoqlKHl2GzRi5yeDxzY+21SDSdRft2B
         ftVg==
X-Gm-Message-State: AOJu0YwESE4xj4IaNzgoVAPg+RXgztDUyyL6zTQjfOuInnsP7sXHFwZW
        kSu0RWqjjLYMrXpBvfbt5HrH/YxJOEJk6Y+62Vk=
X-Google-Smtp-Source: AGHT+IHMQ9ZiyBCAfh+S+uOEENdHAMOdtSVv8YcRE2kTT5XTuA5uUEjwXYIiky4zl9a19R5cgKe5jz7Yy24XM4aNc1I=
X-Received: by 2002:a17:907:7631:b0:9a2:256a:65cd with SMTP id
 jy17-20020a170907763100b009a2256a65cdmr10967437ejc.4.1696838607949; Mon, 09
 Oct 2023 01:03:27 -0700 (PDT)
MIME-Version: 1.0
References: <20231009011842.1956-1-naomi.ibeh69@gmail.com> <CAP8UFD3HZOMJTxW5EkUwKu48GebSKX3-EPD8tjGEQnE2MGaZ7w@mail.gmail.com>
 <CACS=G2xfUYVmvhZ_r447uArW-_6yK0r7V9BkzX7i+E7MvruA9Q@mail.gmail.com>
In-Reply-To: <CACS=G2xfUYVmvhZ_r447uArW-_6yK0r7V9BkzX7i+E7MvruA9Q@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 9 Oct 2023 10:03:16 +0200
Message-ID: <CAP8UFD3Cj7nC704Rti8jBp6VxBJDxsBpf_8vvordW8MWXc_GDA@mail.gmail.com>
Subject: Re: [PATCH 0/1] *** EDITED add.c ***
To:     Naomi Ibe <naomi.ibeh69@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 9, 2023 at 9:46=E2=80=AFAM Naomi Ibe <naomi.ibeh69@gmail.com> w=
rote:
>
> Okay I understand it better now ,can I do anything about it? Or should
> I leave it as is?.

I think you should send a version 2 of the patch (so without a cover
letter) taking into account the comments I made about it. You might
want to wait a bit before sending version 2 though, so that others
might have time to read your patch and give you more feedback about
it.

> It's my first time using the "git patch

I guess you mean `git format-patch`.

> and "git send-email"
> commands, so it was a real struggle understanding the proper way to
> get things setup.

Yeah, it's not easy to set things up, but once that's done it should
be much easier. To make things even easier, you could perhaps save
somewhere the commands that you have previously used. And to improve
or make changes to those commands, you could take a look at the
documentation for `git format-patch` and `git send-email` which have a
number of interesting options, and take note of those interesting
options.
