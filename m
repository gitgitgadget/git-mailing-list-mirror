Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D95C6FD18
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 04:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbjDYECa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 00:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbjDYEC2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 00:02:28 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF5A9755
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 21:02:27 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-63b7b54642cso3914614b3a.0
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 21:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682395347; x=1684987347;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=q+vruQcGsLHQdHhwQju6CxLhQTd/+u/V1f/vDiPTa8c=;
        b=so9/FDehm8ueocBxrhsju8vAeMCvgdjfzuJcjkQE+raeZsLufJf+H21JeD49JCrhhy
         82BWK6HkhzWM02sNgBXMuyIb7gpgyHylDoeynKC/7YvEdGDxYwxmTZKfypJn+9297Lie
         qe0Ucho2dNdcIk6knjRAtBvg5X3fhgU9aFkJgQgXp9DKvF/4FafL4RT9y9hvpCAzVEx6
         wqni70mK/NHua1j+M0VI6v+/rHjd0YEq6WSNpMCezmWanNGMzRJLQA1XwBEnQkquC6PU
         nawZNawCGVVBwCoU8tt/Fy/8TPpr29GdRQKUhqer/V2keN8+cfGjs9vD/lG86fO3OIS1
         8PaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682395347; x=1684987347;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q+vruQcGsLHQdHhwQju6CxLhQTd/+u/V1f/vDiPTa8c=;
        b=Uf4WJJoUOERI7Aq36c9x9/QLe2Ym2xKTipyIbIIPpwPgpUMfTTv3mPnf4zNQZHqJj8
         jkg5IH3ckrJhfqoFkhgQzoC/r/1JfOn6vtbN410nCnRl6tZ3zg0CorKp9xr4Lq6YKGgY
         GYDt6hjrsCVuHCz4sxyLApux+aEA6ryzSqo6gLox7EPoke81eG6gz1EfwIlRY+5ndywy
         Top+1gQqI9pSIbc2Ui4X4Q6YQeP8DwvvA2sNYJGYgNNDASUakKYSBOLZh8qFH8KFpIro
         4SMuD8PZiIxkt5Q9DhX9sY/qiMs9zhSqA3upzeIwOTtWnHqxalv9j1wrn09hKdxjZpPZ
         16RA==
X-Gm-Message-State: AAQBX9f3uGIlPxTA7QPgV1iCWt7QpUdssP6L1xJjqEOv1k1XGd5BWjO0
        jt5gEK6mqYlOB/bNZcwz5TI=
X-Google-Smtp-Source: AKy350adzdIC0Bypmq0huoaxxj2JpjmE2HNO110C2JYMflX7mQ6F7BsOpnSJiWIr4ff0CmqkestTnQ==
X-Received: by 2002:a05:6a20:7d8e:b0:f2:bfe1:4867 with SMTP id v14-20020a056a207d8e00b000f2bfe14867mr13808907pzj.17.1682395346781;
        Mon, 24 Apr 2023 21:02:26 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id r5-20020a63e505000000b0051b7bcb6162sm7076581pgh.81.2023.04.24.21.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 21:02:26 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Zeger-Jan van de Weg <zegerjan@gitlab.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH] [RFC] transport: add --show-service option
References: <pull.1523.git.1682342241825.gitgitgadget@gmail.com>
Date:   Mon, 24 Apr 2023 21:02:25 -0700
Message-ID: <xmqq354o8v8u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: ZheNing Hu <adlternative@gmail.com>
>
> Without using protocol v2, the git server needs to send a pktline
> "# service=$servicename" to the git client first. This often
> requires the git server to implement it independently, but it can
> be delegated to the `git receive-pack` and `git upload-pack` to complete
> the work proactively. Therefore, the `--show-service` option is added
> to `git receive-pack` and `git upload-pack`, which can be used to send
> the "# service=$servicename" pktline, making the logic of the git
> server more concise.
>
> Note that this `--show-service` option can only be used together with
> `--http-backend-info-refs` and it is not applicable when using protocol v2.
>
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---

The above is a very well written description of why we _can_ do
this, but it is unclear why we would _want_ to do this.  What do we
gain by letting the individual services to declare "we are serving
this!"?  Do we lose an extra fork & process (it does not seem to be
the case)?
