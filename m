Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92EEC433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 23:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD2D961026
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 23:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237446AbhIIXcw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 19:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbhIIXcv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 19:32:51 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92230C061574
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 16:31:41 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id b4so98297ilr.11
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 16:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3MhdgUGEAvimvR7CLEFCUcx9oSloienCheJ8wgmd81w=;
        b=afI2d+xqH0jNQ518loGX45xbEmAlpc527voaQAucgIu0VEa8JyKoLJH0MiPRlakH8E
         mdcMB+n/WxpSwcyhWyaa4EkdtsRXGbDKCSRvnXX4nIb6KbJBM8wbqgDZZluCpCqKaYq2
         pj3vevFNwgBnD/zqLatYgyY37q7G2urEHZAgPfzKBilvUOdrFLLD7uo4o0HgEH8udloh
         gxp8ugZkmjOtI2Yy3QiQJS8wragJIbU7mX6kyYPg6mesLXUmKI5CLxbnoJt4OcVUd4DH
         E8JGcIGElEAlKaYnYJRP2KtUZlv8SQUAdx/bvhAbwu857e5qriwcwc4uoDSImk9KE///
         0YDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3MhdgUGEAvimvR7CLEFCUcx9oSloienCheJ8wgmd81w=;
        b=XVsQ17VN85h+bgktjmqcVcKrtwEMXJr25c/ytE4Oh/4JIG2Qfxr/tCCPjzBT3xEIDz
         Q7pSwZLC3YSgFlmpn++HtELeF/p8Q+DZe0i2WBB8qdbJGVhynZZu0Voi2WAUe26K1zJJ
         jVvT9bbtrh17JV9eblAv3monkZEFppuyMJkcZYXAaZHA13LqOFOnF1X06S0EspMG/6O3
         yrm0wGHW5yuNX3+BzYIHgFac1Z1txAKMYp9jTKXbxQLsviCA2yr4DLW+L7Yeu2hFE9SM
         419m2jx6gPhkUXCSG/3K1G2IMjM/R7FAk8ZkVbt8obuhTtrPtMaLoVKP+isznYKOZ/kd
         ItpQ==
X-Gm-Message-State: AOAM532BzBQy4rgZDMq/98sqwtxmp1l5f22lLJEvM0IXDRDA5ma7MMLA
        rsJZPpnX62CN8jKMhMUMTSEUBfM+Xojd2tgc
X-Google-Smtp-Source: ABdhPJz5WfmsHjbukWum+MBlSJJB4ZcGE7vM5h7+NMRDf43vUTWC9E7jCfhk/GkczcEjKrMnlASGcQ==
X-Received: by 2002:a05:6e02:198d:: with SMTP id g13mr4226295ilf.319.1631230301027;
        Thu, 09 Sep 2021 16:31:41 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d12sm1547297iow.16.2021.09.09.16.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 16:31:40 -0700 (PDT)
Date:   Thu, 9 Sep 2021 19:31:40 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        avarab@gmail.com
Subject: Re: [PATCH 3/9] pack-write: refactor renaming in
 finish_tmp_packfile()
Message-ID: <YTqZXN8pVRtODQjb@nand.local>
References: <cover.1630461918.git.me@ttaylorr.com>
 <cover.1631157880.git.me@ttaylorr.com>
 <35052ef494dbc55119614f3e22742d8d814b21b1.1631157880.git.me@ttaylorr.com>
 <xmqqk0jpzgxu.fsf@gitster.g>
 <YTp3rYqxLE5/X521@nand.local>
 <xmqqilz9wcm9.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqilz9wcm9.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 09, 2021 at 04:30:38PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > In each of these three, I wasn't able to decide if you wanted these
> > addressed in a newer version of this series, or if you were happy enough
> > with the result to pick it up. I'm happy to send you a new version, but
> > don't want to clog your inbox if you were already planning on picking
> > this up.
>
> Well, it is often a no-cost operation to replace a topic that has
> been in 'seen' with a newer round, so you do not have to worry about
> my inbox.  As I often say, if it turns out to be a bad idea, I can
> just drop it from 'seen' as if I didn't see it ;-)
>
> Anyway.
>
> If a newer version will come, I'd love to see the review comments at
> least considered (be it from me or from anybody else) --- after all,
> if the original were good enough, reviewer(s) wouldn't have raised
> them as potential issues.
>
> Of course, "considered" is the key word.  No need to blindly follow;
> as long as there is a solid reason to justify why changing would be
> worsening the well-written original.

Agreed strongly :-). After reading through your review again, I felt
like the individual components were greater than the sum of their parts,
and that the v2 of this combined series is on the whole better than v1.

Thanks for taking the time to review it.

Thanks,
Taylor
