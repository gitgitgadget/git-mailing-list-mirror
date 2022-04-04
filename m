Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66880C433EF
	for <git@archiver.kernel.org>; Mon,  4 Apr 2022 05:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237353AbiDDF3f (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Apr 2022 01:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbiDDF3d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 01:29:33 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4615821838
        for <git@vger.kernel.org>; Sun,  3 Apr 2022 22:27:38 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id 14so6071019ily.11
        for <git@vger.kernel.org>; Sun, 03 Apr 2022 22:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pyQ/KNF0dd3K7KiQuLG0DwEZZ/Z9lwFtv4v76Ut/C24=;
        b=K2ph1+UMcwVZt1O+mEcDw2JYftAIPyirTLI3pm7DXEEAadmsOcrynnUlQZSY3iNEFT
         fFQPom0wl42C6naYIWMQsrJ83KiFJub8MxI9fnA0Ozz5LefegCOROvLl7Cac2XnF/5NR
         0BSnDe52E3Kd0f4I/BcLE6FAJ8Kx+5wCkUQg31ZZT+zbOCu98XkCnHArOQbcZ9HDCJyx
         vZOyuaVCFgPhj19rSvbBj4aqy6zJ+4ofwVLDYuIvAfeFMLkkzCkIB8/6lNgZDzRkRZ6Z
         LrGKbsTuCNJNEpWvigLvKB9AIBSvPXHokPBp3fQchQYNY1RwzCM8CNnORgSPNk5EwxyG
         XDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pyQ/KNF0dd3K7KiQuLG0DwEZZ/Z9lwFtv4v76Ut/C24=;
        b=LqjM1tITp32YRaMpP8IaLCJ6NFiBSz17s2spAYIXLWMRHfzOKSUji5nwmvesXIJDc+
         vlGs4VQxRraz/qYQXqY5Btpjkz14sj4kddx9KY+scUgbMMNlsDbMH1uS0cqspnltcyba
         JyV+jS0nOai7D0pRBo+RlvECUWXiDv5T0bUWxzyCd5XW9rO67e8iFumDUl9IrQIOolRl
         Uc383lfmw24KEtFaUU0kkoSOokRxwAFkBQBsFWtRl2bsHMFTV3/IpuN2JhV8sonZ8PSV
         nEEbfWPF8clLvpjvMlPNdc8mWKW+skA0SmHbx7zzXeDTyikNV/UnkmcBfIzMznWDPEjh
         T5+w==
X-Gm-Message-State: AOAM5336d8zR96Q5gX+kDhY1HAWvIwv8c8AtYgE6DH3dPWaGDz2uN1aW
        e+5PiIXqjHzg1UKyedDWNKcv4TkuTsJvss1ptEM=
X-Google-Smtp-Source: ABdhPJw8PUFnq/xozALxH3Pftkm7vm3TlJFV0xbaAVemy0El6tzB0YrhiQ/gCIfW47ZrwMMbNAFboYpBk+ITITYB0ZI=
X-Received: by 2002:a92:6907:0:b0:2bc:4b18:e671 with SMTP id
 e7-20020a926907000000b002bc4b18e671mr4407314ilc.299.1649050057461; Sun, 03
 Apr 2022 22:27:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220403165038.52803-1-eantoranz@gmail.com> <xmqq5ynpu6uv.fsf@gitster.g>
In-Reply-To: <xmqq5ynpu6uv.fsf@gitster.g>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Mon, 4 Apr 2022 07:27:26 +0200
Message-ID: <CAOc6etac3tQdOzY1bF7qBVOJ_ndns-KOSum8w-Jie06Ynz_cWw@mail.gmail.com>
Subject: Re: [PATCH] blame: report correct number of lines in progress when
 using ranges
To:     Junio C Hamano <gitster@pobox.com>
Cc:     whydoubt@gmail.com, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 4, 2022 at 12:42 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Wow.  I am reasonably sure that this was broken since the
> introduction of the progress meter to "git blame".  Thanks for
> finding and fixing.

As the person who originally wrote said support, I feel like I
am just nurturing it. :-D

>
> Can we have a test, too, or is that too cumbersome to add for some
> reason?

Correct me if I'm wrong but it could be a little tricky because "progress
display" shows up only if it happens to "lose" a race. Progress is
skipped altogether if blame process goes too fast. Even if you run
blame on a file with a lot of history, if box is fast enough and info is
cached, it will fail to display progress. So, all in all, it would be like
trying to unit test output coming out of a race condition.

Let me know what you think.

>
> Thanks.
yw
