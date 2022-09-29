Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0177C433FE
	for <git@archiver.kernel.org>; Thu, 29 Sep 2022 19:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiI2TUs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Sep 2022 15:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiI2TUq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2022 15:20:46 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221F14B0FF
        for <git@vger.kernel.org>; Thu, 29 Sep 2022 12:20:45 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id h18so1203423ilh.3
        for <git@vger.kernel.org>; Thu, 29 Sep 2022 12:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date;
        bh=kS7ihPMqceW/1gh+tAlFL90HSX2jVjwwcrGPDqaWk+4=;
        b=VMqH0v6n8TLJOPWWxNK4aepgMKOUlIVPyhsIW0Ob7t2l31kFr8wml61CBNDREXfsRt
         pyrWV++yHwifW+ppGSdrTljS+Nf6ighjJqzZqiRg+i4f0j2PLWvcEnwoYe1xVHkzPTZP
         4sQ34lr5hYf8mM3UHL3OysuXTT+4ddGhL+NxVPDe62BcZda+UAZpWy3wQJtFPhmN/1yH
         8DlBI5oEXLIq8BFaJnjSTKTmXYUyWKtEsg1oVG7ykfZcRZmy2WmaFohX1Ow4LmqJK42B
         xN3VV3bqG3qYjbS3QmEA29KLuFpIQVH7N7LCfPsGfSKNhE5nXcaRBzFktb+m7X4tH3Vi
         ch8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=kS7ihPMqceW/1gh+tAlFL90HSX2jVjwwcrGPDqaWk+4=;
        b=BtiIe+exGWqIOqP5jVduBb7MfZZjUtx5QqygU+IOPZqKvUh5WKwIH2X3UafEnpE+Dj
         cD5x8KCr5gPN33vwQCJTC5iLdzWzFwiaTwv/lOSsUQ0B70yxVo5CTp2mL69p3B4zHlIM
         CMIFKjDob2Eg25Sw/B+MxoSKuDkXTpNz9Tk7wp0aBxjM62/CWosgYBaN7G21AyAy5fn+
         r2VLYs1rrRBn3jWOR8Vuk1MfJ6bUSh/Z7ikl0NBfzpqZXM9drLG75tkKlpLbG5r3QbD9
         EowhXUL2453m42r7VI7SzR/dHdgzcwHVoLUMcwGVULjTRJdmeORILt3BwbqP6O0JMghD
         vNPA==
X-Gm-Message-State: ACrzQf1S7NC6jiRLbsdYaEOeEuBFsnGeW+6NkToO5r2eDUDNCgi1lbJd
        B2zZLLPO29/B2bCxRmgynd3f8pA87oKSLg==
X-Google-Smtp-Source: AMsMyM7BRsPcn1JJVOjg4TQIk7IwOvuV6p2nmjO1HGd+WdhrtLamD3n9l4EETbPQoBoyHzr0Rvd07w==
X-Received: by 2002:a05:6e02:180a:b0:2f6:9b06:a184 with SMTP id a10-20020a056e02180a00b002f69b06a184mr2573626ilv.137.1664479244225;
        Thu, 29 Sep 2022 12:20:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s20-20020a92ae14000000b002eab1925fd4sm165931ilh.73.2022.09.29.12.20.43
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 12:20:43 -0700 (PDT)
Date:   Thu, 29 Sep 2022 15:20:43 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Subject: [TOPIC 4/8] Commit `--filter`'s
Message-ID: <YzXwCz1udfrLehyo@nand.local>
References: <YzXvMRc6X60kjVeY@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YzXvMRc6X60kjVeY@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

# git clone --filter=commit:0 (jonathantanmy)

- Partial clone that can omit commits (we already support trees and
	blobs)
- Pros:
	 - Don't need all commits, save network and disk I/O. There's a repo
		 at Google that grows so quickly that having just commits is too
		 much
- Cons
	 - Git assumes that all of the commits are present locally; very
		 pervasive assumption.
			- Blobs don't have outlinks, not a problem. Tree depth is somewhat
				limited. Commits go all the back to the beginning of the repo
			-  `git bisect` without commits
			- Lose out on optimizations like `fetch` skipping negotiator,
				commit graph generation numbers
- Has everyone else thought about this?
- Peff: Compare to shallow clone (create a ‘graft' and pretend that the
	commit has no more parents). How do we handle the continuous N + 1
	fetching?  Jonathantanmy: Not a big issue, we can batch fetch. It's
	jumping around that's a problem
- Peff: What if the server sends the commit graph?
	 - Taylor: we could just send the generation number(s) of the parents
		 of the commits on the boundary of what you're sending.
	 - Emily: We can't verify it though, we'd have to just trust the
		 server
	 - Taylor: true, but that's the case even if you send the whole commit
		 graph, too
- Jrn: Partial clone - we know the server is there, so we still have a
	"full clone", but part of the "full clone" lives in the server. There
	are git services that don't need a full copy of the repo, e.g. for CI,
	we only need a view of the directories we're building.
- Two use cases for partial clone
	 - Shallow clone replacement: user only cares about a single commit
	 - Operation that involves history walking (e.g. git describe). We
		 might as well fetch all the commits (i.e., convert to tree or blob
		 filtering when we notice this operation). Are these operations
		 distinguishable?
- Rdamazio: What if all of the history walking happens only on the
	server? (e.g.  git blame). Jrnieder: For git blame specifically, that
	makes sense, but are you thinking of other things like git log?
	Rodrigo: Yes
- Johannes: That doesn't sound like it will scale. Stolee: At GitHub, we
	already do run blame on the server Rodrigo: At google, we precompute
	that
- Terry: More and more things want "stateless" operations (don't care
	about history) - that's probably the majority of use cases. There's
	also a popular use case of "1 week/month" of history. It would be
	great to not pay the penalty of fetching all commits. Today, we only
	have shallow clone, which pretends that history is different from what
	it actually is, and it's very difficult to maintain this on the server
	(sending not enough objects, sending too many objects). But filters
	are much easier to maintain.
- Victoria: Is this a replacement for shallow clones then? Terry: Yes.
- Stolee: 2 technical areas of apprehension
	 - VFS for git tried to do this by having only the initial commit and
		 fetching later objects one-by-one. Didn't work at all, was very
		 slow.
	 - Treeless clones - when traversing the tree, we keep refetching the
		 tree when we traverse it.
- We would have to drastically rework how GIt interacts with partial
	clones
- Taylor: Or we could teach the server to preempt the operations ("i'm
	going to run git log, send me the right things")
	 - Stolee: Or run it on the server
	 - Taylor: yes, that would be the other extreme approach to this
- Jrnieder: With treeless clones, we don't propagate the filter on the
	catch up fetch, and there are some code locations that assume that if
	we have a tree, we have all of its children. If anything, commit
	filters are even easier because we have nothing - so we can do "all or
	nothing"
	 - Stolee: I agree that it's simpler, but I still think it'll be
		 really slow.  So either, we need to do something much smarter than
		 object-by-object fetches, or to prevent users from running
		 problematic commands. We would eventually have to fix the problem
		 for treeless clones, so what if we start with full commit history,
			 but not all of the trees. We can fix that first before starting
			 on commit filters
	 - Jrnieder: I can see the need for all of the commits up until a
		 certain point in time, but I don't know if there's a need to solve
		 the general problem of omitting arbitrary commits e.g. jumping
		 around in bisect
- Rodrigo: We have some experience for doing this with Mercurial at
	Google - we hide the full history, users know they exist, but they can
	refetch if they wish. Stolee/Peff: That sounds like reimplementing
	shallow clone.
- Taylor: Is there any other kind of filter other than commit:0?
	Jonathantanmy: No plans yet.
- Peff: Wouldn't you need to implement the general case to do batching
	of commits in "git log"? Jonathantanmy: Maybe not, we could e.g. reuse
	the shallow clone protocol.  Managing ever growing pack index sizes on
	servers
- Some repositories have over 15 years of history with 1000 active
	developers, so pack indices can be between 1 and 2 GB. "GC pack"
	contains everything reachable from refs/heads/- and refs/tags/-
- Time-based slicing for repositories to allow smaller repositories.
	"Remove" history from before a certain point. Done by taking a shallow
	clone and using that as the new repository.
- What about folks who are only interested in the last week's history?
- Pack repositories based on time-based slicing.  Moving back to older
	history can fall back to older packs as necessary.
- Some people, like documentation folks, don't need the entire history
	and might be fine with a more limited environment.
- Chromium packs to three packs: one is a cruft/garbage pack, and the
	other are reachable objects.  refs/heads is packed into one pack, and
	refs/changes (PR-equivalent) are in the other.
- JGit doesn't have a reverse index yet
- Taylor: considering packing reverse index into main index.  The
	tension is that we need to make using multiple packs more flexible.
	Introduce bitmap chains when repacking to make things more stable and
	less expensive.
- Stolee: Consider older packs that are stable and only repack newer
	things.
- Peff: One reason not to have lots of packs on disk is missing out on
	deltas.  We could use thin packs on disk.
- Stolee: Future goal is to only include full delta chains in the stable
	packs.
- git gc –aggressive used to make really deep deltas and has been fixed
	to be less aggressive to avoid runtime performance costs.  Between 10
	and 50 shows real performance improvements but the old default was
	like 200.
- The original numbers were picked randomly without measurement.
- Patrick: GitLab maintenance architecture is evolving.  Each push is
	incremental (repack into one pack) or full repack (everything into one
	pack with deltas).
- Stable ordering for determining preferred objects (SHA ordering is not
	suitable).
