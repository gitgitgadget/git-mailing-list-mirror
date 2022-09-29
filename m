Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDB5C433FE
	for <git@archiver.kernel.org>; Thu, 29 Sep 2022 19:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiI2TWB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Sep 2022 15:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiI2TV5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2022 15:21:57 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE986142E22
        for <git@vger.kernel.org>; Thu, 29 Sep 2022 12:21:54 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id a2so1185533iln.13
        for <git@vger.kernel.org>; Thu, 29 Sep 2022 12:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date;
        bh=FCvzLFEpofE0/Mf8M7v5rsJBSWOSx0KxwOEwNdNAxKE=;
        b=ns8SK5Est1QtRQzr3ZAfSBSxhJireuIj0HTAxMrOciUfgtImUeRdVZfzgiDBl4aU0I
         T5r/eAGeaW7ridkg4gIiDR5tOwhTJdavxoHAksWI5h93vjTml+prxSfgK4Y7x+sCkrgM
         ZLOpE/0pU3HUXKaJAeL4+oTZvTUsfpHwCfXnKGni6ProYjlOsXY7OZrv748gsMSMzcZ7
         faZaSTjAZ0rYvkZt02QUZlqZamJQbVxO/xHwTSxq0HzXgbmauyDYok33z6SI+0G9+MdB
         uQy3H2E8hxMXdXHTJRn8zPUqOtwiTC2IEhL6bhq53gOf0eYjk/+q14cFpnrD0jJdpu8J
         teoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=FCvzLFEpofE0/Mf8M7v5rsJBSWOSx0KxwOEwNdNAxKE=;
        b=H+sMFEKGkfJN9q+PUWYfevEcFd5bXuExmc2DpYTIEGPbYolWadXXeXp1DQaAauS9PJ
         vQ1r8LbJzpMgVw24lRoeBvN8CRIaHBsq6lGtNW9TloX9kqQLq03N0K0xwsjMpRNxhukU
         1Sg0lRA/VaB2XQBs0qprUzfVyewYW2BRbiGJAmUuZXzaDlS7o1KBRwyiLKiQ0AVfj/oE
         +QLhMXW9QqqrV/NPUV4HalfCR5K+lPMhD8Rz1ivt6ycA6LwmL95AYOESXgFZF3qGQJ5X
         ym4h6ThpcR6Z576A0sN+njWq3nYrEuSfALS8joYxSxrz88HVbJCYGmClMhrhRLDeGUOE
         mbug==
X-Gm-Message-State: ACrzQf08YFd9iY+leXBE++Jw4FgEvPxG2iIvNYqrq+YgoEOQzMGXihJJ
        4xax9+qZbSH78zyUTYTeiFdLJCh+eTPu5Q==
X-Google-Smtp-Source: AMsMyM5g1cXixr8vXl6dW3fLHobroX2ehrhosq5IE23ThK1iMF1rVILhZl2Wc9WaSzwXrzum7OBULQ==
X-Received: by 2002:a05:6e02:1414:b0:2ea:c7b9:efda with SMTP id n20-20020a056e02141400b002eac7b9efdamr2533111ilo.202.1664479313865;
        Thu, 29 Sep 2022 12:21:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y4-20020a056e02118400b002eacd14e68esm170237ili.71.2022.09.29.12.21.53
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 12:21:53 -0700 (PDT)
Date:   Thu, 29 Sep 2022 15:21:52 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Subject: [TOPIC 7/8] Speeding up the connectivity check
Message-ID: <YzXwUEre3PP22FDU@nand.local>
References: <YzXvMRc6X60kjVeY@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YzXvMRc6X60kjVeY@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

# Ideas for speeding up object connectivity checks in git-receive-pack
(Patrick Steinhardt)

- Patrick: At GitLab we've noticed some repositories have become slow
	with a lot of references.
- Initially I thought it was the object negotiation.
- The connectivity checks seem to be the culprit. The connectivity check
	is implemented quite naively. "git rev-list <commits> --not --all"
- A while ago I tried to optimize it. Stop walking when you reach an
	existing object. List feedback was that I had not gotten the semantics
	right, since that existing object is not necessarily pointed to by a
	ref and not everything it references is necessarily present in the
	repository.
- Trial 2: optimize rev-list. Sped up connectivity check by 60-70%! But
	the motivating repositories had grown, so it was still too slow.
- How do other people do it, with millions of references?
- Terry: Yes, we've seen this problem.
- Just the setup time for the revision walk takes a long time. Initially
	we weren't using reachability bitmaps; using those also helped. Then
	using subsets of references — first HEAD, then refs/heads/-, …
- Jrnieder: Initially we did this for reachability checks; do
	connectivity checks do it, too? Terry: Yes, Demetr did that.
- Demetr: When the connectivity check fails, we fall back to a fuller
	set of refs.
- Patrick: Many of our references are not even visible to the public. If
	Git makes configurable which refs are part of the connectivity check,
	that would already make things faster in our case.
- Taylor: Did you experiment with reachability bitmaps? Am I remembering
	correctly that they made things slower?
- Patrick: We did some experiments with reachability bitmaps, but not
	specifically for this problem. In those experiments they did make some
	things slower.
	 - Taylor: one thing that you could do is make the bitmap traversal by
		 building up a complete bitmap of the boundary between haves and
		 wants instead of a bitmap of all of the haves. Involves far less
		 object traversal, and there are some clever ways to do this.
	 - Taylor: As long as you can quickly determine the boundary between
		 the haves and wants for a given request, the connectivity check
		 should be as fast as you need.
- Peff: One difference between how Git and JGit does this is JGit is
	building up a structure of "what is reachable". You could persist a
	bitmap representing "here's everything that's reachable from this
	repository" and subtract that out; that would help with many cases.
	The problem with one reachability bitmap like that is that it goes
	stale whenever someone pushes something. But you could make a set of
	"pseudo-merge bitmaps" for each group of 10,000 refs or so. Especially
	if you're clever about which refs you do that for, that can be a
		significant improvement ("these 2,000,000 refs haven't been touched
		for a year, so I can use this bitmap and don't even have to examine
			them").
- Terry: There are two ways that unreachable objects appear. One is by
	branches being deleted or rewound. The other is failed pushes where
	objects were persisted and the ref update didn't succeed. I wanted to
	distinguish between objects that are "applied" and "unapplied", became
	very thorny. And with that, on a branch rewind, we can calculate what
	just became unreachable.
- Waleed Khan: Object negotiation with bloom filters paper
	 - Kleppman and Howard 2020
	 - Blog post
		 https://martin.kleppmann.com/2020/12/02/bloom-filter-hash-graph-sync.html
	 - Paper https://arxiv.org/abs/2012.00472
	 - Quote: "Unlike the skipping algorithm used by Git, our algorithm
		 never unnecessarily sends any commits that the other side already
		 has, and the Bloom filters are very compact, even for large commit
		 histories." Alternative ways to write to VFS-backed worktrees (e.g.
		 write($HASH) instead of write(<bytes>))
- Google tried to use the sparse-index to control what gets materialized
	by in a VFS-like system. What if we replaced the write() syscall +
	writing bytes and write a hash instead. It could save a lot, e.g. in
	an online IDE.
- Stolee: The "write" analog of FSMonitor for VFS-for-Git is the
	post-index-change hook. We suppress the writes by manipulating the
	index and then communicating the write back to the VFS.
- Jrnieder: This is bigger than just the "write()" call; if we have a
	git-aware filesystem, we can be much less wasteful than we are today.
	E.g. FSMonitor can only make `git status` so fast because we still
	have to stat(), but with a VFS, we could ask the VFS what has changed.
- Do we think this is useful for anything other than a VFS? Do we still
	want this even if it's only useful for VFS?
- Stolee: We could make FSMonitor more git-aware e.g. it doesn't know
	about writes that we make. JeffH: We also can't say "ignore .o files,
	i only care about source files". That also helps greatly. Writing a
	hash instead of the contents is probably about as expensive, most of
	the savings are in avoiding the stat() calls. This also sounds racy.
- Emily: Another reason to do this work is that this is a good jumping
	off point to libify the Git internals. Is there any reason not to do
	that? Jrnieder: To make this concrete: do you mean for example
	creating a worktree.h with a vtable of worktree operations and having
	things talk to that instead of the FS? Emily: Yes. Things like that
	are the reason why we have libgit2, so what if Git could just ship its
	own library. Bmc: Libgit2 is used in lots of places like the Rust
	package manager (Cargo). The problem is that Git is GPLv2, which is
	not usable by lots of folks.
- Stolee: The stance of the Git project is that the API is the CLI, not
	individual files. But I think this is a good thing to have for the
	project as a whole, even just internally.
- We can finally have unit tests!!??!
