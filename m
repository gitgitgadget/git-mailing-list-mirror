Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CB4C433DB
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 17:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC79D238A1
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 17:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbhAIReV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jan 2021 12:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbhAIReU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jan 2021 12:34:20 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C592C061786
        for <git@vger.kernel.org>; Sat,  9 Jan 2021 09:33:40 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id t16so12065922wra.3
        for <git@vger.kernel.org>; Sat, 09 Jan 2021 09:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HqycJ9X+8llr1aZie4hnKvfPXOruNz5OFrrrmWmOQP4=;
        b=kOPLvNJCQPJKxUfh7meseMSABFGzG8a/DSmgjcTTJ/9em3q1oKcsogkghBkeTsUkEY
         6ast+hNNaJ0qsi77KQA/8Q77y3zK3eCKgV+gNyhW2bfBL5dps7XL4eFPIulV2/Xc8dXw
         pFJxUwEWHTbEpO/RxqxEe9KWVTIGb9KCuweJbvRysHh18pe2hB6+ZCbvlgsgpz1aGEG/
         4nL35lZxmYArIcVPU4UvU1/dp5FEDyuuQElBz+pquTHjhOIUfRSjJdaFAaKSkLD1HWR9
         vmmmIxHraJLxp2dYKuzXQgx7ditzkd+sjJXfsU6hDHlHbb12vBiEvU/NOjhQCN0HDQRM
         sjMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HqycJ9X+8llr1aZie4hnKvfPXOruNz5OFrrrmWmOQP4=;
        b=JtRb29aZ6a0GLUllCnKFOcTTsX7WJkasCqbicBkli01i249PQXmoyF6aPJur0jIp+K
         IsAcy+uLCVDHg8J4epfNtuACx6CeSFfWTRImbaYEsEkoIszhZV5Z8XZ3T1AFikNPpqMq
         7xK8fTYzsDWE+Y7C0YrBhcz/5RR4FNVT5JiEMzAKKGmyeodjzFucMc3miW1EwVl6IJcr
         IznFCvgEBHMzOJFbZZ0PJzGmtXZU2ZgHWCS5MIGeGKg9X01xcAkFX/zGvSVpbpF0UHAg
         zAy9JhFxOBj8F8Ew0dPe8Qxt+kvUhUAMiwgewTLsn9Dsh3NKumux55T6QuTF2DYvdCdc
         towQ==
X-Gm-Message-State: AOAM531po0SFHXAasE1uLzx5iFHs48mzXwuPibqFKtw4TVJTXM0P/ad/
        XHu5WDQ+FOEEX5/bBmuJNlv+ZUMpAIc=
X-Google-Smtp-Source: ABdhPJzXz6coxZL0A0oTadRVBn5mDX72Kidm4IqUu7ZNOkaGmyQ9IG5dfO1iVQZzic9UhpSADdbTqQ==
X-Received: by 2002:a5d:6204:: with SMTP id y4mr8933118wru.48.1610213619180;
        Sat, 09 Jan 2021 09:33:39 -0800 (PST)
Received: from szeder.dev (84-236-109-1.pool.digikabel.hu. [84.236.109.1])
        by smtp.gmail.com with ESMTPSA id m18sm17942096wrw.43.2021.01.09.09.33.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Jan 2021 09:33:38 -0800 (PST)
Date:   Sat, 9 Jan 2021 18:33:36 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Subject: Re: Is t5516 somehow flakey only on macOS?
Message-ID: <20210109173336.GS8396@szeder.dev>
References: <xmqq35zbgd2a.fsf@gitster.c.googlers.com>
 <CAPig+cQ3U4s0qmzoLL=ZBeSyCZm=QqjWz2P36ZUxMzNAyYn-WQ@mail.gmail.com>
 <X/mGnY3wR1fGoxcf@coredump.intra.peff.net>
 <X/mJ6gHrKVxQqPX4@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X/mJ6gHrKVxQqPX4@coredump.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 09, 2021 at 05:48:10AM -0500, Jeff King wrote:
> On Sat, Jan 09, 2021 at 05:34:05AM -0500, Jeff King wrote:
> 
> > For this _particular_ test, since we know that it is testing a v0-only
> > behavior, we might want to just loosen the test. This goes against the
> > point of adding it in 014ade7484 (upload-pack: send ERR packet for
> > non-tip objects, 2019-04-13), but it's the best we can do for now.
> > Something like this:
> 
> Since this issue has been languishing for a while now with several
> "something like this" patches, I've packaged it up into something more
> palatable. I think we should just apply this and move on. We may still
> run into other similar races, but I don't think this one is worth
> spending more mental effort on.
> 
> -- >8 --
> Subject: [PATCH] t5516: loosen "not our ref" error check
> 
> Commit 014ade7484 (upload-pack: send ERR packet for non-tip objects,
> 2019-04-13) added a test that greps the output of a failed fetch to make
> sure that upload-pack sent us the ERR packet we expected. But checking
> this is racy; despite the argument in that commit, the client may still
> be sending a "done" line when the server exits, causing it to die() on a

Nit: I think using the word "after" would make the problematic
sequence of events a tad clearer, i.e. "... after the server has
exited, ...".

> failed write() and never see the ERR packet at all.
> 
> This fails quite rarely on Linux, but more often on macOS. However, it
> can be triggered reliably with:
> 
> 	diff --git a/fetch-pack.c b/fetch-pack.c
> 	index 876f90c759..cf40de9092 100644
> 	--- a/fetch-pack.c
> 	+++ b/fetch-pack.c
> 	@@ -489,6 +489,7 @@ static int find_common(struct fetch_negotiator *negotiator,
> 	 done:
> 	 	trace2_region_leave("fetch-pack", "negotiation_v0_v1", the_repository);
> 	 	if (!got_ready || !no_done) {
> 	+		sleep(1);
> 	 		packet_buf_write(&req_buf, "done\n");
> 	 		send_request(args, fd[1], &req_buf);
> 	 	}

FWIW (not much?), I've run the test suite with that sleep(1) in place,
and there were no other test failures.

> This is a real user-visible race that it would be nice to fix, but it's
> tricky to do so: the client would have to speculatively try to read an
> ERR packet after hitting a write() error. And at least for this error,
> it's specific to v0 (since v2 does not enforce reachability at all).
> 
> So let's loosen to test to avoid annoying racy failures. If we
> eventually do the read-after-failed-write thing, we can tighten it. And
> if not, v0 will grow increasingly obsolete as servers support v2, so the
> utility of this test will decrease over time anyway.

Makes sense.  Back then when I investigated this issue the default
protocol was still v0; now that we default to v2 I agree its better to
work around the issue in the test instead of "fixing" the root cause
with that "trying to read ERR packet on error" hack.

Good, a year-and-a-half old entry checked off from my todo list :)
Thanks.

