Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F15C2BB85
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 00:07:53 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F90D20709
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 00:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Wmd9qLLX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F90D20709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=git-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgDMAHv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Apr 2020 20:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgDMAHv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Apr 2020 20:07:51 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB89C0A3BE0
        for <git@vger.kernel.org>; Sun, 12 Apr 2020 17:07:51 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id c23so3759930pgj.3
        for <git@vger.kernel.org>; Sun, 12 Apr 2020 17:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7U0SReTPeVgnbQiZXU49NGYjiPSYfQHrOq3eI2Aseh8=;
        b=Wmd9qLLXVGQt50CwK+V2jVDqr/9H3LWVzrYUmHX1OdKGPwyD5QHLkGjzg+CmikTTcH
         jADl7Me3tQORfrxm+IUQU+CCWbL4HVIYGOTVPzXLkSPb/XHlO6ZcJF8RUCgsR/d1Ecsm
         +z86t+JJ6fIHLxPCuXFpRqJYXx+76dXe7BUg5wlbr832/XEML63Yy7JOGbKrDln272ZQ
         GOh6jpg8u262cMujvboiBkg1khnXDdiwE6G47YlXg6zozRL61/tHsgCLRAgVn/fuzxBT
         kIAv16H5LxLlEozVz1Und234Hv5kke/8n166LqRG8E+dW0YA0bdql2mjKZG2R2gx9feK
         lxag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7U0SReTPeVgnbQiZXU49NGYjiPSYfQHrOq3eI2Aseh8=;
        b=BBTjdsG5R5D2qKniKnphow/vyjNBOCagNK7lEAf7Pf4I8Ucq0gRp9PxPfySrUPBGng
         M+6pDHpGHbSS/bzbWe+5Pr1ST9C6GMTWJtjffUGj9qJb9dmpwHUOiX5kGVzEJpq7I4ON
         HGOIb1+0Zcj0/J2HYNCytRR3k7OwS88s9Ti1wEhmoiVkKlN01M2RGdDhMzULhw3+dbUy
         TzgAdOtzmyhbPEOsbXtxKamqDFIrUc7N32JbtO4z2mY2iQZhZX7mKvhJtKwJtOIqPUdd
         gv2aP7pJgyfuZqT8/5HnxGAzIx/XKKzADNVi2UsDQ4L8geVG1ytCRSKDtXMqHK56bn4K
         povw==
X-Gm-Message-State: AGi0PuYMG71dIGW/E71mrNZrTXWwUU+vm75I6JW+/vLg8/GfQUWYvpll
        pdDQObJewuz4XFPOQGgTO5r8WMwq41J+8A==
X-Google-Smtp-Source: APiQypJRPvPCR2Gz5k+/vQVO0StLyXWjerK1kOhK6U/cm4+T06SWViE8wiGsgEyGg1cxHaiw4BzBPQ==
X-Received: by 2002:a63:1e59:: with SMTP id p25mr15045868pgm.219.1586736470545;
        Sun, 12 Apr 2020 17:07:50 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id w8sm7140481pfi.103.2020.04.12.17.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2020 17:07:49 -0700 (PDT)
Date:   Sun, 12 Apr 2020 18:07:48 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jnareb@gmail.com, garimasigit@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/3] revision: complicated pathspecs disable filters
Message-ID: <20200413000748.GA55122@syl.local>
References: <pull.609.git.1586566981.gitgitgadget@gmail.com>
 <9cc31c289aa785f026eec84452ed68e80505d95e.1586566981.git.gitgitgadget@gmail.com>
 <20200412222210.GA53057@syl.local>
 <xmqqa73gcp74.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa73gcp74.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 12, 2020 at 03:30:07PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > I certainly wouldn't complain about a comment here explaining these
> > three checks, but I suppose that the rationale is only a 'git blame'
> > away (and I guess that is faster now after this series ;-)).
> >
> >> +	if (revs->prune_data.has_wildcard)
> >> +		return;
> >> +	if (revs->prune_data.nr > 1)
> >> +		return;
> >> +	if (revs->prune_data.magic ||
> >> +	    (revs->prune_data.nr &&
> >> +	     revs->prune_data.items[0].magic))
>
> This says "any magic", but it is overly pessimistic to disable the
> optimization for "literal" magic.  That magic is the one that lets
> well written scripts to say "I have in a '$variable' that the user
> gave me as a pathname (not pathspec), and it may have a wildcard
> letter in it, but please treat it as a literal string" by prefixing
> ":(literal)" before that user-supplied data, so it is punishing well
> disciplined folks.

I hadn't thought of that, but it makes sense to me. How about something
like this squashed into this patch? I moved the if-chain that Stolee
introduced out to its own function, at least since they seem
well-contained and related to one another. I figure that this simplifies
the implementation of 'prepare_to_use_bloom_filter' by giving the reader
less to think about up-front.

diff --git a/revision.c b/revision.c
index 534c0bf996..15bf4ccff5 100644
--- a/revision.c
+++ b/revision.c
@@ -654,6 +654,18 @@ static void trace2_bloom_filter_statistics_atexit(void)
        jw_release(&jw);
 }

+static int has_bloom_key(struct pathspec *spec)
+{
+       if (spec->has_wildcard)
+               return 0;
+       if (spec->nr > 1)
+               return 0;
+       if ((spec->magic & ~PATHSPEC_LITERAL) ||
+           (spec->nr && spec->items[0].magic & ~PATHSPEC_LITERAL))
+               return 0;
+       return 1;
+}
+
 static void prepare_to_use_bloom_filter(struct rev_info *revs)
 {
        struct pathspec_item *pi;
@@ -665,13 +677,7 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
        if (!revs->commits)
            return;

-       if (revs->prune_data.has_wildcard)
-               return;
-       if (revs->prune_data.nr > 1)
-               return;
-       if (revs->prune_data.magic ||
-           (revs->prune_data.nr &&
-            revs->prune_data.items[0].magic))
+       if (!has_bloom_key(&revs->prune_data))
                return;

        repo_parse_commit(revs->repo, revs->commits->item);

> >> +		return;
> >> +
> >>  	repo_parse_commit(revs->repo, revs->commits->item);
> >>
> >>  	if (!revs->repo->objects->commit_graph)
> >> --
> >> gitgitgadget
> >
> >   Reviewed-by: Taylor Blau <me@ttaylorr.com>
> >
> > Thanks,
> > Taylor

Thanks,
Taylor
