Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B073AC433F5
	for <git@archiver.kernel.org>; Thu, 29 Sep 2022 19:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiI2TVh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Sep 2022 15:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiI2TVe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2022 15:21:34 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF0C13A073
        for <git@vger.kernel.org>; Thu, 29 Sep 2022 12:21:32 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id i9so939346ilv.9
        for <git@vger.kernel.org>; Thu, 29 Sep 2022 12:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date;
        bh=6yQNG0GaWxZsesa0W4J0QVJB3crP61tgRioltuqIwpE=;
        b=FBBbW2xCZ31f8CEu4CbgPciqfvJ8htALO8FVmVdykoKqlI9SNJohu3gFt2bb2SVCnW
         t9plrrFQfbBfqez1tz+XxlEJREVzmrrgt0cCQmY7fjjrcMqQkHOQS8e1YjOElhhq9nl1
         Hb9/3CJePM9Ve+MLwOYCIQ6qKe8jQMXYZzZ4UcAKUYqK9JvgF5i6cAjByHWbYKOpkI6a
         g+xWNkwt9d0lbQRjeCZYmsB4cDtlzKQAlDAxE5xshqrclW0hXafBzP0IDnFKKvWPOxct
         r7kbtUohJDWMHwBcWNOyWJmkjVsR+ZZVsm+5H4Vy8kBv1yS6s+sAyKdQMGt9Vs8fF8hd
         T3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=6yQNG0GaWxZsesa0W4J0QVJB3crP61tgRioltuqIwpE=;
        b=li1VREAXIo2TiIbeFVvpyd9YUDBXTMblwemlfqPDBDqi28C2P+oLWPaGlt/k/fYUIT
         rj75q3R0lwDC61HKU9BzErSxuKVSK/uvDfVkqM75YcB2Gj/cHBgIZxDyWX4XPAPZ7DXS
         qW+v6mI3gOZ6TWcdlWPeGljDLZpdqnYaT8WY3DWnFoDqZ+DPRvMjSRp7e5rKfn3pXahM
         Ly86FFTOiNAinBoEaVbvUStJ1uZgqIFSsw5+v6xpTEX0/j0to6wSGPrY5q9zoRsCDHs3
         vTL2EFHbNBRlo+R4c0qlhPthIcxvN2n/q1WuIX8ce5tlPKX1kGx59ilHNF7IboaTnqYO
         0poQ==
X-Gm-Message-State: ACrzQf09BYZj32HtLiCp1wAXVZssV8HV6OT27Q4YKZ8+4Vgyi8R42Qxx
        uOect4YH5/ff7GlglgclrYdZf+0J29HuSg==
X-Google-Smtp-Source: AMsMyM5n6uS/nEdbf3KOF+Hy624v0WAPUvDdxWuSiYEOjEC/wnLGMto+1Dwtd2wJ8wLwuz6xUjS8WA==
X-Received: by 2002:a05:6e02:16c6:b0:2f9:78:19a4 with SMTP id 6-20020a056e0216c600b002f9007819a4mr2391426ilx.310.1664479291742;
        Thu, 29 Sep 2022 12:21:31 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u13-20020a02b1cd000000b0035671c2e249sm78598jah.146.2022.09.29.12.21.31
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 12:21:31 -0700 (PDT)
Date:   Thu, 29 Sep 2022 15:21:30 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Subject: [TOPIC 6/8] State of sparsity work
Message-ID: <YzXwOsaoCdBhHsX1@nand.local>
References: <YzXvMRc6X60kjVeY@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YzXvMRc6X60kjVeY@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

# State of sparsity developments and future plans (Victoria)

- (Victoria) Integrating commands with sparse index, making them
	compatible with sparse indexes, not un-sparsifying the index before
	executing themselves
- Have worked on some more recently
- GSoC student has worked on a handful as well
- Near-term future is about finding commands that need to touch the
	index, don't support sparse index, and then make them compatible
- In some cases, that is going to require expanding the index to be
	non-sparse, especially if you are touching something outside of the
	sparsity cone
	 - That is somewhat straightforward
- More interesting questions: what is the future of sparsity? Recently,
	Elijah pushed a change to make sparse-checkout's cone mode the default
	(nice, since it is required by sparse index)
- As we move forward, what should we change the defaults of?
	 - Sparse index for sparse checkouts in cone mode?
- Scalar as a testing ground for larger features, including sparse index
	 - Could make sparse index the default in Scalar for cone-mode sparse
		 checkouts, and then see how it goes
	 - Or, could just go for it sooner (after we have integrated sparse
		 index with enough commands)
- A handful of internal, logistical things that would have to happen for
	sparse index to become the default. Currently, commands are assumed to
	not work with the sparse index.
- Question for everybody: what is a good balance between pushing sparse
	index, and waiting to introduce it to more users by holding off on
	changing the default.
- (Stolee): sparse checkout and submodules became a difficulty when
	mentoring their GSoC student.
- (JTan): possible to decouple sparse index and cone-mode sparse
	checkouts from each other? This would be easy to test - turn it on,
	all of the test suite automatically uses it. Jrnieder: This sounds ok
	for the filesystem, but I don't know how this would work for this
		"VFS-backed Git" idea on the spreadsheet. (other things…)
- (Stolee): We need cone mode today because they're the only way to
	definitively say that we've reached the boundary. But we can also
	expand the idea of "cone" to allow more paths (files instead of
	directories) in the cone.
- (Taylor): What do we need to tell subcommands to assume that sparse
	index is supported? (Victoria) Gut feeling for the most part.
	(Jrnieder): I'd prefer this to happen sooner rather than later. This
	is easier for maintainability since we don't have to worry about
	commands being in two possible modes of operation. We can break these
	incompatible APIs by renaming them to prevent them from being misused
	by new commands.
- (Victoria): So just break things that always use the full index?
	Sounds ok.  (Stolee) This sounds similar to the_index macros, which
	we've tried to remove for the most part but we've stopped. Doing this
	conversion everywhere sounds extremely difficult - we've done an audit
	on this. (Jrnieder): Oh, I just meant renaming the API without
	changing semantics. Intentionally break everything.
- (Victoria): We'd need to write new tests for lots of commands because
	the existing tests don't actually interact with the "sparse" parts of
	the index.
- (Ævar): Is this just a matter of telling `git init` to initialize a
	sparse index? (Stolee): No, we need to force the tests to work on
	sparse directory entries.
- (Jrnieder): This sounds like a good fit for feature.experimental
- (VIctoria): Is sparse index a good git default instead of just "for
	large repos"? I'd think yes. (Jrnieder) Yes I think any sparse
	checkout user would want this. (Stolee): LIterally every command that
	touches the index has been converted (used for Microsoft Office
	monorepo), so it's just a matter of doing this for the whole project.
- (Elijah): I would like partial filters from sparse patterns.
	--filter=blob:none doesn't let you disconnect from the server.
	 - (Jrnieder) The DX of sparse checkout + blob:none has been pretty
		 good.  (Elijah): but you need to stay connected to the server.
		 (Jrnieder) Ah, thanks for explaining, sorry for the confusion
		 (Elijah) It would be great to have "sparse clone"s and have
		 commands that work just inside of that cone when disconnected. Make
		 "grep", "log", etc respect the sparse pattern
	 - (Stolee): We've thought about this, but it is very expensive on the
		 server side and makes bitmaps unusable. Alternatively, we could
		 start with blob:none and then backfill. That sounds more promising,
		 but that's not just a plain partial clone.
	 - (Jonathantanmy): FYI there's a protocol feature that already allows
		 clones to specify a sparse filter (referencing a blob with sparse
		 patterns that's present on the server), but I don't know of any
		 implementation that has this enabled.
	 - (Jrnieder): Can we delete this? (Github folks): We don't like it,
		 we invented the uploadpackfilter config to disable it :) Is this
		 just cleanup?  (Jrnieder): Yes, and this dead end will stop being a
		 distraction.
	 - (Peff) We could already implement most of the backfilling using
		 current commands, but that might skip over some delta-ing
		 optimizations. We could have a protocol change to provide the path
		 as a hint to the server.
