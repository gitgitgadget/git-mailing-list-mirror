Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE88C2B9F4
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 02:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE5F96112D
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 02:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbhFWC6S (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 22:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhFWC6S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 22:58:18 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3EEC061574
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 19:56:01 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id k16so1524654ios.10
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 19:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Ul9oCuY9gGFBAu8ZBpa61xX2OPQ9+9F0lE5xbFDuiDw=;
        b=rhChM9HDm0m/V91fj4ufxuoD2Zdkkt48CyweBq3hf6sD07ErN4tiyNtEDmWYpxMB9y
         Q/ZdZ4aHn8/RzejVtO0zJQrZJY05yq/fNmmgIsqjHNpZNBwI8q6KorPy1gcYum/x7t9c
         KQByqjEZuleyCvKI8QkAOQnPPsNEZVjWsuRyZJZ3ByxwBD3hl0ZV8JAlX8lFw1uSIZhV
         yJVigrtTXOj5yFdZAtrT6jRmMHD2L6RSetNg/5ESBrqZGplloHF8b1k0e10KRSjj0Iv6
         VZepZcBOGJkFG+5n0ezdDSOB5TOz85vJYC4hk+6WObVmOXkkK/U7g5F55poHVoB/B/Hm
         rxaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Ul9oCuY9gGFBAu8ZBpa61xX2OPQ9+9F0lE5xbFDuiDw=;
        b=koJ2tN8vM95tnMSD4Zb6lAvK/vnNe4ZER//bPQptnLn/ZQSVJldlXA3BtFMMb+9A/Q
         JB32eOis3v4f+GMtSmMguXif269dzDHAGfIDwt27OAZzM8TUkoe5Q6YCioT+BH90Q2Qn
         c+ZZiQtji2zWt2mU5Nln/+tCXqq8thn4a1ogWcB55YCEAPrLRFhZ658TvgyBd0EDGkAN
         w3h2HrKKYWoBZ0BQJeJupyVq41jjPKMFW/CYMCksaDoXXs5k582imB5voFLC8J4CEret
         bn7GwqTUWCMk3QarVIXH1aL31gydHXJGouUomKlcF8gS0m/e52Yijv68tpXRhSpzSH2W
         ucPg==
X-Gm-Message-State: AOAM530wGHutv3Nfz3buZyh02F2RCRR36hqG21nvJJHmdIQoEKfv5ur1
        m/Z/RG2/CZPoVeyNvZLfdkJdgQ==
X-Google-Smtp-Source: ABdhPJyIRFK1TXj7GgmbsJYseR1phvoeBqnV8emaW+tqNy0FJv2dqyTo3ImLR//oPztdDTo4Ci9ViA==
X-Received: by 2002:a05:6602:219a:: with SMTP id b26mr344200iob.69.1624416960489;
        Tue, 22 Jun 2021 19:56:00 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:827b:778a:e73b:3ade])
        by smtp.gmail.com with ESMTPSA id e14sm8557497ilq.32.2021.06.22.19.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 19:56:00 -0700 (PDT)
Date:   Tue, 22 Jun 2021 22:55:59 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Josh Steadmon <steadmon@google.com>, szeder.dev@gmail.com
Subject: Re: [PATCH] trace2: log progress time and throughput
Message-ID: <YNKiv2Ar77xAxixz@nand.local>
References: <20200512214420.36329-1-emilyshaffer@google.com>
 <871r8w3sxu.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871r8w3sxu.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 21, 2021 at 03:24:47AM +0200, Ævar Arnfjörð Bjarmason wrote:
> > [...]
> > @@ -320,6 +321,22 @@ void stop_progress(struct progress **p_progress)
> >  {
> >  	finish_if_sparse(*p_progress);
> >
> > +	if (p_progress && *p_progress) {
> > +		trace2_data_intmax("progress", the_repository, "total_objects",
> > +				   (*p_progress)->total);
>
> We start progress bars for various things in git, yet the trace2 data
> calls every such progress bar with a total "total_objects", even though
> we may not be counting anything to do with objects.
>
> Wouldn't simply s/total_objects/total/ make more sense here, do you rely
> on the name of the current key?

Yeah, I think that the latter of just "total" makes more sense here. I
was going to comment on the fact that "(*p_progress)->total" could be
written simply as "*p_progress->total", but I'm (a) not sure that I
actually prefer the latter to the former, and (b) I find that kind of
style comment generally useless.

But it may make sense to sidestep the whole thing and have a "struct
progress *progress = *p_progress" (that is assigned after we check
p_progress to make sure it's non-NULL) like in stop_progress_msg, which
would clean up a lot of this.

--- 8< ---

Subject: [PATCH] progress.c: avoid repeatedly dereferencing p_progress

stop_progress() takes a double-pointer to a "progress" struct, and
dereferences it twice in each use except one (checking whether
*p_progress is NULL or not).

Mirror the implementation of stop_progress_msg() below by having a local
single-pointer to a progress struct (which is the dereference of
p_progress) to avoid repeatedly dereferencing it.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 progress.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/progress.c b/progress.c
index 680c6a8bf9..390c76b22a 100644
--- a/progress.c
+++ b/progress.c
@@ -319,21 +319,25 @@ static void finish_if_sparse(struct progress *progress)

 void stop_progress(struct progress **p_progress)
 {
+	struct progress *progress;
+
 	if (!p_progress)
 		BUG("don't provide NULL to stop_progress");

-	finish_if_sparse(*p_progress);
+	progress = *p_progress;

-	if (*p_progress) {
+	finish_if_sparse(progress);
+
+	if (progress) {
 		trace2_data_intmax("progress", the_repository, "total_objects",
-				   (*p_progress)->total);
+				   progress->total);

-		if ((*p_progress)->throughput)
+		if (progress->throughput)
 			trace2_data_intmax("progress", the_repository,
 					   "total_bytes",
-					   (*p_progress)->throughput->curr_total);
+					   progress->throughput->curr_total);

-		trace2_region_leave("progress", (*p_progress)->title, the_repository);
+		trace2_region_leave("progress", progress->title, the_repository);
 	}

 	stop_progress_msg(p_progress, _("done"));
--
2.31.1.163.ga65ce7f831

