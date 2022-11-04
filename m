Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857E1C43219
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 21:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiKDVtI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 17:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiKDVtG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 17:49:06 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F179843AD3
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 14:49:05 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id p141so4842958iod.6
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 14:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fl4ewedRLzHNOI+i4Uqi2Pjkwq4jHNEsra1nuEEbX9w=;
        b=mSQRZNHOvWo2OMtre7esmddbswzbbYqd2xp7vlo24kDszEOUOXM1GVFWdu+lewKpFT
         /yNDHzrn7vijzwU0rpTcaCnHa/Fm4eQ4tJfZGdnOWwSGsS7G1afRTdnVAvkYvBas9uie
         sgrBMdMyvkM0uwd7ODr01Y/Dq23Zf44v1wkok561jhDjX4NxJ/0R8CuTbBadjwbu2qiT
         Z9KRj+bvYiZ4PQRnX038fIeB8GdbpqYy8yVYfi2Raw5RJUrROFYgKIijV72ws70iOHiD
         TcyQ9B6mHud49hkck/28P/VclhQBpuQVTxCltxgsTvTIwab04DhI5ZpC+g+Q9W1c4EFQ
         Kh6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fl4ewedRLzHNOI+i4Uqi2Pjkwq4jHNEsra1nuEEbX9w=;
        b=GKGurXwrL/3JRa30OTFM1lxxZ+ThsfjEJYq1bmXzcqARtTvSr05j1/fIcmCqCeivQ1
         6UKVnuRZNWyTjYwBchpV/hJ2YyWjgyw6VFSCVgdkRvUVs7+YMvEGx9FrSOG5QR/hcOo7
         twqnk2wtMqBCZKrj3YABAm5JrW4Zv8drfcZjy84eW3xtPYKccP8QtHMjKZrF2GrLHBV1
         ta4LRxNURcrdn3BMr9Wu0ke4v+8s+x3fUXDpVAsXYUhqCMIU0ysrsQSm6EABmcI+9KfE
         fDsQgNOFnwEof3dJtdr7PYS1a2KXoJL6mbsBiQWFEmNJwLC5bdN25N54P2UqdGlNyEj9
         MOSQ==
X-Gm-Message-State: ACrzQf0ekCKp3MmvxfH2v17Vy8rU/EyQTDE3OVIQ3XWYj6akRTlS6y4Q
        d4zXRzQbuZn7wrrMkKlTI9ZnjgybDODrr9Tb
X-Google-Smtp-Source: AMsMyM6EPi2AxC88H00816n0Md3nG2mllw/L8kk/HiynJxhTWrZTXRZyWxiTemlor/nPUOcgTKZ9ow==
X-Received: by 2002:a02:6385:0:b0:36e:ba59:5ded with SMTP id j127-20020a026385000000b0036eba595dedmr22878551jac.247.1667598545345;
        Fri, 04 Nov 2022 14:49:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s13-20020a0566022bcd00b006bbea9f45cesm71998iov.38.2022.11.04.14.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 14:49:04 -0700 (PDT)
Date:   Fri, 4 Nov 2022 17:49:03 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        y@nand.local
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 0/2] rebase: stop setting GIT_REFLOG_ACTION
Message-ID: <Y2WIz5qvjQMfXPgP@nand.local>
References: <pull.1405.git.1667575142.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1405.git.1667575142.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 04, 2022 at 03:19:00PM +0000, Phillip Wood via GitGitGadget wrote:
> This is a follow up to pw/rebase-reflog-fixes that moves away from using
> GIT_REFLOG_ACTION internally. This conflicts with patches 12 & 14 in [1]. As
> this series replaces the code being changed in those patches I think the
> best solution would be to just drop them.

Thanks, I appreciate the updated round.

The conflict you noted in [1] is a perfect example of why I dislike
queuing sweeping leak cleanups like in that series. Those two patches
need to get dropped in order to queue this series. OK, except what
happens if a different part of [1] marks a test as leak-free when that
is no longer the case because of something in this series?

I haven't queued this topic yet, so perhaps all of this is moot with
respect to these particular two series. But in general, such a problem
is not hard to imagine.

It is greatly appreciated to err on the side of smaller, more targeted
series instead of sweeping changes when they can be avoided.

Thanks,
Taylor
