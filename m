Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD29C10F1B
	for <git@archiver.kernel.org>; Wed, 28 Dec 2022 03:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbiL1DeL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Dec 2022 22:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiL1DeF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2022 22:34:05 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA00DF18
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 19:34:04 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id d10so9836057pgm.13
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 19:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5lLCKphQZBYFABg9gCMTxMqlBCFZGv6IrToYe8SMFwo=;
        b=cedL3NdsQ6GgJ4b9lHhlK76zgACF3mTCJD5eHbZa3EhpB9m1t11rvUxJ+F23xT+dwL
         i6mqiPmqrUozpDS0jKv8+4BnkA9yK9YTRAQ50UC9487bweE3p2k+pn0XFoHn19tp6SwA
         sdHD8qK3JEvLuRT6urbWplmiWRlElwC6ucvsO8r0PGrZXkFVo6VfNEF70yezvj7H5SP4
         LS4VqiYGs9nFv1iZwR4b9f6Qkt7bUkqKqD459R4bbbGpxZRMhn75zxHrY2/XzW1i82Re
         57JCgb9vG2iqyi4xqFnmgZb8NY2w/UVYp9g2Wxkj23swkVfjL6tbE//G2BionwncASkx
         gIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5lLCKphQZBYFABg9gCMTxMqlBCFZGv6IrToYe8SMFwo=;
        b=GREwX7ZGKBL0+EYHd97Pd+UkVoH7dQsZTrmCgDaUJwQReMFAEutLJ2rH6Jed9IMIbR
         TprEu+TDxOIWn/Q1JsYMVZkAxFu6DHFoW9oz/fXqIvEf07xn0B6NMHNaYPdiba/0mK1F
         MuWYgBVFoGa9BnUpFvgzR6pMzH2ty6XASbps3EvtfgUIP1UbFVN8Hw/jxdhmpR/B0OCD
         gF223oG0iuZCdNQ7nrpQhKBfdkVFLZ/TVxJH+kl5xcJpuQLhj+5B5GeiHZDvFiivaOBZ
         AI2AwPBebBfiuOWC/BAqG07GQnKCRHd/UYAij5eIM8DaQpjXxXQUMCKJLpd3+smkPP36
         +6/w==
X-Gm-Message-State: AFqh2kqFFW83l7lD9rX+5PGtNpgj+JJG3U+wP31O7GykOteFD5ezI2fR
        HUk/CfRQUN1SY8xmxX6N6zA=
X-Google-Smtp-Source: AMrXdXvE+1TCoYU++pAhrKA8RdEEvCPIrY7zp92yiIL0GQkmJPuKcYcm0/GR7V3g7HeUGKwAVloMkg==
X-Received: by 2002:a05:6a00:be2:b0:56b:fa67:1f7f with SMTP id x34-20020a056a000be200b0056bfa671f7fmr24910070pfu.19.1672198443817;
        Tue, 27 Dec 2022 19:34:03 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id v1-20020aa799c1000000b005817b2a0c6dsm1456195pfi.104.2022.12.27.19.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 19:34:03 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     <rsbecker@nexbridge.com>, <git@vger.kernel.org>
Subject: Re: [BUG] fatal: transport 'file' not allowed during submodule add
References: <00f901d91a47$09400110$1bc00330$@nexbridge.com>
Date:   Wed, 28 Dec 2022 12:34:03 +0900
In-Reply-To: <00f901d91a47$09400110$1bc00330$@nexbridge.com>
        (rsbecker@nexbridge.com's message of "Tue, 27 Dec 2022 18:00:32
        -0500")
Message-ID: <xmqqilhwp5g4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<rsbecker@nexbridge.com> writes:

> As of 2.39.0, I am now getting fatal: transport 'file' not allowed when
> performing a submodule add after a clone -l. The simple reproduce of this
> is:
> ...
> This happens for any submodule add on the same system. Some online research
> indicates that there was a security patch to git causing this, but I can't
> find it. This does not seem correct to me or how this improves security.
> Help please - this is causing some of my workflows to break.

Thanks for reporting, Randall.

This suspiciously sounds like what a1d4f67c (transport: make
`protocol.file.allow` be "user" by default, 2022-07-29) is doing
deliberately.  Taylor, does this look like a corner case the 2.30.6
updates forgot to consider?

Thanks.
