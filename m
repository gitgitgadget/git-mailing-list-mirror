Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74814C433FE
	for <git@archiver.kernel.org>; Thu, 29 Sep 2022 19:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiI2TUI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Sep 2022 15:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiI2TUF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2022 15:20:05 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D4F49B79
        for <git@vger.kernel.org>; Thu, 29 Sep 2022 12:20:00 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id y141so1683667iof.5
        for <git@vger.kernel.org>; Thu, 29 Sep 2022 12:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date;
        bh=8FRwfeu7ZplhFScw842TzxpXg5hIHVLSE2Lz8cLhayo=;
        b=2E2vWpQfbmeS9z6u6cLUpp+/Pxjzpj7mSyigpQRNT0Fo94A67qVKXkvlng0j7AWNVp
         Dx50EJ61KdKYIymdOSiW3o3ZgdIcW5O1Jbfa46YYYiJexuzpW75JpI/Mq3gfh5sDcMTw
         wgJuLoKx+T3iJ8V/c5IA8XDyDGBJYculYpXsnDWitFfWi9fA7WBnDvrP4p84HVUgXWgG
         grhe6crg8fhugJDXne6cndW6qfpKHdgLxQnuPeyWQk81exa/b251ZfjnhXj0brwzJEKX
         LRO/zXl3IXH031m4hVRmw0TvxMBDLUFuyUXEG3XJsoTlGyij8yYhBfxzMCnx6hG1Zk4i
         GJkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=8FRwfeu7ZplhFScw842TzxpXg5hIHVLSE2Lz8cLhayo=;
        b=Wu/x8ansl4uKiEAsSi4c7vjTL1hfAPyOD+TOoYSRCs6kGnLtulguhNaW2KRzZE0WCo
         QYJ2RtJ9CHaq6B5c6JEdOM8dOTxXyQe+fdR8JEytIB3WcG2j5iR521HXOnyqEN77xzye
         v1NkDk2RaB34NKEPcLN8tUzN8xw/FC9OjSgkdeiuwsWW4fAVm/DD1m2wYgYnX++adZqy
         0QJhZDILzDz2xKpGaX/4KiOYVKKnfIyK0Zn5Sw+7cA0xzKGFHUy5E8if+niAcF/1he0m
         +aSI6V7PDcxRe9gxAfKMWkuiTvJ19bnRrudVjRr3Bx+HyejhlZYWaF01HZ8XE4Wb5gzV
         Tb8Q==
X-Gm-Message-State: ACrzQf1JVp68ZljJhn/jYNDjJWEV8MANLAnXsBTyFLWG61PWQ32Q2/sV
        qOpQ/jiv2I6jwrv4wqziPlRurB/VKTVZCQ==
X-Google-Smtp-Source: AMsMyM7MKNLgFKaLRV3Pk2gqFJgPs1rBNC7oRQ/AjvuDin54AP4i5J4KPepCvS4pGtgKXoo7Ls+jgQ==
X-Received: by 2002:a05:6602:483:b0:68a:b5f2:a508 with SMTP id y3-20020a056602048300b0068ab5f2a508mr2153657iov.97.1664479199883;
        Thu, 29 Sep 2022 12:19:59 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m20-20020a0566022e9400b00688eee7588asm124210iow.32.2022.09.29.12.19.59
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 12:19:59 -0700 (PDT)
Date:   Thu, 29 Sep 2022 15:19:58 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Subject: [TOPIC 2/8] State of SHA-256 transition
Message-ID: <YzXv3r1OONqxAvih@nand.local>
References: <YzXvMRc6X60kjVeY@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YzXvMRc6X60kjVeY@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

# SHA-256 transition (brian)

- (brian) Functional version of "state four" implementation with only
	SHA-256 in the repository
- Interop work (to use sha1 and sha256) is mostly stalled, brian is
	mostly not working on it at the moment
- Current implementation is partially functional, though failing a lot
	of tests.  Can write SHA-256 objects into the repo, according to the
	transition, will write a loose mapping between SHA-1 and SHA-256,
	along with index v3 with the hashes for both
- When you index a pack, computes both hashes and stores them in the
	loose object store or pack
- Tricky part is when you're indexing a pack, you don't always get all
	blobs before all trees, before all commits, etc.
- In order to rewrite a commit from SHA-256 -> SHA-1, you need all
	reachable objects before in order to compute the hash. Try to look up
	in a temporary lookup table ahead of time, and lazily hash the object
	we're going to get and come back to it later.
- "Rewind the pack" to compute the proper objects, which works
- For submodules (currently unwritten), going to send both hashes over
	the wire, but unfortunately no way to validate those in real time. If
	your submodules are checked out, rewritten automatically.
- brian working on it slowly as they get to it, hopes that their
	employer will devote more time to it
- Wants to also work on libgit2 at the same time, since it doesn't yet
	understand SHA-256, though they hope that somebody else will work on
	it, since they are tired of writing SEGVs :-).
- (demetr): what if you have a remote that speaks only SHA-1?
	 - Goal is to have that information come over the pipe, and rewrite
		 into SHA-256 upon entering the new objects into the repository
- (demetr): can you then push a converted-into-SHA-256 repository back
	to a SHA-1 repo
	 - Goal is to be able to do that, unless you have a SHA-1 collision,
		 in which case it won't work.
	 - No major hosting platform yet supports only SHA-256 repositories,
		 though maybe Gitolite and CGit do
- (Peff): so, in the worst case, index-pack takes twice as long?
	 - brian: depends on how many are blob objects, since only takes a
		 single pass
	 - Will try to rewrite objects in as few passes as possible
	 - May need multiple passes in order to visit objects in topological
		 order
	 - Actually: worst case is N where N is the maximum tree depth
- (Stolee): what you really need is reverse-topo order on the object
	graph
	 - brian: yes, would be nice if the server sent them in that order.
		 But the server doesn't know how to do that.
- (Emily): so for something like shallow/partial-clone, the server needs
	to be able to do SHA-256 for you to compute it yourself?
	 - brian: there will be a capability, since data needs to come over
		 the pipe for submodules, and could be extended for shallow and
		 partial clones as well. Would fit into protocol v2, and will be
		 essential for submodules, so will have to exist regardless.
	 - Hopefully server has that information, though how that expensive
		 will be to compute is highly dependent.
- (jrn): submodules have to be updated, do you have an idea of what that
	protocol change will look like?
	 - brian: fuzzy idea, but nothing concrete yet
	 - (jrn): this reminds me of the early days of partial clones where we
		 talked about "promised" objects at the edge and associated metadata
- (Toon): so no interop, but is there a way to do a single step
	conversion from SHA-1 to SHA-256?
	 - brian: yes, you can use fast-export and fast-import. Currently any
		 signatures references are broken, but in the future would like to
		 update them (that code exists, but it hasn't been upstreamed)
	 - doesn't quite work with smoothly submodules, since you have to
		 rewrite them first, then generate a set of marks, and then export
		 and import
	 - verified with git/git, resulting index isn't substantially larger
		 (basically 32 bytes per object, along with slightly larger commit
		 and tree objects)
- (demetr): Could be significantly larger if you have a zillion commits
	 - brian: we'd have other problems before then :-).
- (Elijah): common in commit messages to refer back to earlier commits.
	Do we want to rewrite those?
	 - brian: maybe, depends on future plans if/when we deprecate earlier
		 hash algos
	 - (jrn): Don't have a good way to retroactively change commit
		 messages, but we do have git notes. First instinct is to use notes
		 for this kind of historical reference info
	 - (Terry): annotated tags?
	 - (Elijah): filter-repo does this kind of commit message munging
