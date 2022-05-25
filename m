Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E562C433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 00:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242854AbiEYAO5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 20:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiEYAO4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 20:14:56 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66CFC64BD0
        for <git@vger.kernel.org>; Tue, 24 May 2022 17:14:55 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id n2-20020a9d6f02000000b0060b22af84d4so2146323otq.1
        for <git@vger.kernel.org>; Tue, 24 May 2022 17:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GL/b+eVr/HygwKHZ0G/+x7Mv/y/vB0VNOyyB8tZrP9k=;
        b=uqlwfigv+KvTEq2t2FdtQk1Agxw7D5MAz/y1oT8loffhrXQqhhzffXe/qCcVRSQPR5
         +rVKokPYuRyqfgAunvwVBdY1+Z0ZC2FuIK2TLef08f6B7BMWZFgScBAiq7uo4bfC7Em/
         Qo523b3Iwww8UOwNlqnkC5LRk1bt5OBVUW/R1NYzpiUBdN/IQl28jb+Cadq6wVNF+tRX
         jvVuyjZR7DfQjUC3iuvav3DeJ7Ez+v0w3FjWPGA3iqEOaSWHAuyy+B4MXFOdX6u7etQ9
         jKTMV9f5ak35TirVq9EJKtVV/S/oU8GyHYekMJXNjDk2HgVAsbfIhLuhAo+wml1A7D04
         OI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GL/b+eVr/HygwKHZ0G/+x7Mv/y/vB0VNOyyB8tZrP9k=;
        b=l4ph0sQVlWhdXvcOsd+a7UFCbsq/yrEwqeZLdaHDb9XKOBrzQcXjdHtigWyXTlMtnA
         7AF0cTMQ1hDHFo0ifDo99O+bkP2QNnZTMNhAwDBvaANFeP9aaZnMmxFO970J4FXLj3Yc
         XLUCm/22zMUq2xTRJfJpbFNm0MoPnPhdg2tfkhB2U2vbhiAiLf6MqFIfkCjeZ/BKzV3p
         RgW+7zoISOMu3ymDOzwfeGh7Wo43igAZL7c+/EQv+VjIZ6shEgim8/x+uuimGrle4Jf5
         Lw9YRoABz59B/qAGZN9o8o9GQtEoFBUDwaYHXe4uGdZzFSmGhC73ZVQDgJ69kI8nCa8y
         APAA==
X-Gm-Message-State: AOAM5307km2i50rEao5FTcWB8fN2ff9ZVQJjjf+/SQaPXcBwOnq+WHiy
        oLh3LTT4ocVcqz6t7cf3ac0jcA==
X-Google-Smtp-Source: ABdhPJxlPu61i7fLvwLePvVvPFPbaHyCxuehJonTEolK/KKv7N0zsrrja+AdG6Te/aedxlMpFcoozg==
X-Received: by 2002:a05:6830:44a7:b0:606:6bcc:f4c7 with SMTP id r39-20020a05683044a700b006066bccf4c7mr11354241otv.198.1653437694678;
        Tue, 24 May 2022 17:14:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e205-20020a4a55d6000000b0035eb4e5a6ccsm6039214oob.34.2022.05.24.17.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 17:14:54 -0700 (PDT)
Date:   Tue, 24 May 2022 20:14:52 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, vdye@github.com, jonathantanmy@google.com
Subject: Re: [PATCH v2 3/4] builtin/pack-objects.c: ensure included
 `--stdin-packs` exist
Message-ID: <Yo10/KlseGJeY6uQ@nand.local>
References: <cover.1652458395.git.me@ttaylorr.com>
 <cover.1653418457.git.me@ttaylorr.com>
 <cdc3265ec27f04accc433d9e4e54ac0edc3b3746.1653418457.git.me@ttaylorr.com>
 <xmqq1qwifv1c.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1qwifv1c.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 24, 2022 at 03:03:11PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > Calling `is_pack_valid()` early on makes it substantially less likely
> > that we will have to deal with a pack going away, since we'll have an
> > open file descriptor on its contents much earlier.
>
> Sorry for asking a stupid question (or two), but I am confused.

No such thing as a stupid question, so your apology is not necessary in
the slightest :).

> This does make sure that we can read and use the contents of the
> packfile even when somebody else removes it from the disk by
> ensuring that
>
>  (1) we have an open file descriptor to it, so that we could open
>      mmap window into it at will; or
>
>  (2) we have a mmap window that covers all of it (this should be the
>      norm on platforms with vast address space); or
>
>  (3) we are in the same state as (1) by opening the packfile to
>      validate the pack right now.
>
> and during the pack-object we are running (aka "repack"), we can
> continue to read from that pack that may have already disappeared
> from the disk.
>
> But is that sufficient?  Are we writing the resulting new pack(s)
> out in such a way that the repository is healthy without the pack
> we noticed is disappearing?  How do we ensure that?

It's sufficient in the sense that we're writing out all of the objects
we were asked to (from pack-objects's perspective). Of course, if the
"simultaneous writer" is just removing packs right after they are
opened, that will produce an obviously-broken state. But assuming that
repack isn't removing objects it shouldn't (which I think is a safe
assumption from pack-objects' perspective, since all it cares about is
writing packs that contain the desired set of objects), then we are OK.

Thanks,
Taylor
