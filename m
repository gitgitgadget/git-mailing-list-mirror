Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482B331B833
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 20:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758571515; cv=none; b=VmjtUuqlVSDocARr0JLxdHwGBm344ME+aY8nfk6E2tOOWlbmwP8h1GPsXaDO8QWUx6V8Ewl8GxaDGGrqCx6MMKordxw3DWoez/n0N9WZYrak6+/yRl/0Np0QePo98JBXWp98khdAaryLPqpzQamAndLTTlS9jSNqBivLZ+NOmNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758571515; c=relaxed/simple;
	bh=tVCB6HJtRyCNOtKmCltUYGM7k4wKG6Pt0jZt/PYqf0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jpnG/zY8Xl52SB5fNc8D+kDqE9c/L3bhXaVSyKjqb836DxgC1O2/JfpeTPVp0DCybidH9nE0SG7c89HQS+nxCJ1/FiinZb75Xr314GssJtZWoLS5S0f3t12dM7jwdICArbQTQeSiy1/jsqH2+JiFHcqI3YSC2g1SqyocRqeEp90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=JKerlRG3; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="JKerlRG3"
Received: (qmail 162416 invoked by uid 109); 22 Sep 2025 20:05:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=tVCB6HJtRyCNOtKmCltUYGM7k4wKG6Pt0jZt/PYqf0E=; b=JKerlRG3VraIT5dMFjtcNYN2yZIiZkjOaJf6sssmMz1hnIQ68P4p6VF4DdBolAn26BiII8DaulrOqqK66Zhecs+bm58xYetw/hSQBt6tgbmx5M6yldhVEzFnRHA5K7RlSt5GuQsRYHajLEsOJEaKR4ik752wP5FwVgBW1c0BvqXQ+MZ8e/6Im80lGod4VZMhd4tk4mCBbUJRQ6kKAna9sqvf26dKsUQ7OhKBMrXdow/vlxuOeGihoc/dPU61wLutJzmzSW7t6+uXK2ZwytvKGO7+fpS336OH8WF1fT/PEZM3pH2GjTw1VJXdMDpIdSXtNUO/MKOQHlT7BPqW/p4ziw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 22 Sep 2025 20:05:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 259653 invoked by uid 111); 22 Sep 2025 20:05:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 22 Sep 2025 16:05:10 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 22 Sep 2025 16:05:10 -0400
From: Jeff King <peff@peff.net>
To: Sainan <sainan@calamity.inc>
Cc: Simon Richter <Simon.Richter@hogyros.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Could Git be smarter about object reuse?
Message-ID: <20250922200510.GC2205919@coredump.intra.peff.net>
References: <pmKix6R7b3WVLrcK6ig1Lh7RhrB5G4Hm5yam_fEoC839aatB-OjJEmSJJ-weErGEnt4Mvgf5slxgu6Pm1xlGZ4mr_i4MIAAEMYy8DjJnWgk=@calamity.inc>
 <f478fc6f-77ab-4d4e-a8d9-2d44622ba8dd@hogyros.de>
 <2RWL_muy24EPDZ9wWFx-WZfu4Br_F2LenvcVJbKewfSVYipYM3qmeEIgV-6o4EbL39ZjMXtLHbVFOCPcBdHHVAU-0BrgBtuQ9BdRjS_2niE=@calamity.inc>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2RWL_muy24EPDZ9wWFx-WZfu4Br_F2LenvcVJbKewfSVYipYM3qmeEIgV-6o4EbL39ZjMXtLHbVFOCPcBdHHVAU-0BrgBtuQ9BdRjS_2niE=@calamity.inc>

On Mon, Sep 22, 2025 at 10:49:07AM +0000, Sainan wrote:

> > The receiver sends a list of commits it has
> 
> This alone is not enough because if I'm amending a commit, it doesn't
> have the new commit(s), but it does have the previous commit(s), so
> the fact of blobs/trees being reusable is missed.

Pushing doesn't dig into every possible blob/tree within each commit to
look for duplicates. Doing that is very expensive in the most general
case (you'd have to walk the entire object graph to check if some old
commit mentions the blob you are about to send). So there are some
heuristics about how much to dig.

We can simulate this case in a single repo like this:

  git init
  # or any big file; we want it to be obvious when it is sent
  dd if=/dev/urandom bs=1M count=10 >rand.bin
  git add rand.bin

  # now make one commit
  git commit -m one
  one=$(git rev-parse HEAD)

  # and an amended one with the same tree
  git commit --amend -m two
  two=$(git rev-parse HEAD)

If we pushed $one to a server, and then tried to push $two the server
will tell us it has $one already. And push will feed this to
pack-objects:

  echo ^$one >input
  echo $two >>input

And now we can run that same pack-objects locally to see the output:

  $ git pack-objects --stdout --revs --thin --no-progress <input | wc -c
  10489164

So that demonstrates the issue. Interestingly, we used to suppress the
duplicate long ago. If I use Git v2.0.5, for example, we send only 147
bytes. Bisecting turns up the culprit as 2dacf26d09 (pack-objects: use
--objects-edge-aggressive for shallow repos, 2014-12-24). The subject is
a bit misleading there. It is enabling the "aggressive" form _only_ for
shallow repos, whereas it had been used for both before that. 

And the reasoning there is better explained by 1684c1b219 (rev-list: add
an option to mark fewer edges as uninteresting, 2014-12-24), which says:

    In commit fbd4a70 (list-objects: mark more commits as edges in
    mark_edges_uninteresting - 2013-08-16), we marked an increasing number
    of edges uninteresting.  This change, and the subsequent change to make
    this conditional on --objects-edge, are used by --thin to make much
    smaller packs for shallow clones.

    Unfortunately, they cause a significant performance regression when
    pushing non-shallow clones with lots of refs (23.322 seconds vs.
    4.785 seconds with 22400 refs).  Add an option to git rev-list,
    --objects-edge-aggressive, that preserves this more aggressive behavior,
    while leaving --objects-edge to provide more performant behavior.
    Preserve the current behavior for the moment by using the aggressive
    option.

Under the hood this is being handled by calls to rev-list. So we could
see the objects more directly like this:

  # this shows the blob; we are not doing any edge reporting at all
  git rev-list --objects ^$one $two

  # this is what pack-objects does by default; it also shows the blob
  git rev-list --objects-edge ^$one $two

  # and this is the more aggressive form that does suppress the blob
  git rev-list --objects-edge-aggressive ^$one $two

So I think there are a few things to ponder here:

  1. Possibly our heuristics could be smarter.

     This case is easy because it's the tree of a commit we know the
     other side has. We could detect it without digging into any trees
     by just marking the tree pointer of each uninteresting commit as
     also uninteresting. I'm actually a little surprised we don't do
     that already.

     But there are more complex --amend cases, too. E.g., you might have
     changed a nearby file, and the trees would be different (but the
     blob may still be unchanged). To detect that we'd have to walk the
     whole tree of the commit that the other side claims not to have.
     And I suspect that's what --object-edge-aggressive is doing, and
     why it would be expensive if the other side has a lot of refs.

     But possibly we could be do the aggressive thing on just the tip of
     a server-side ref when we are force-pushing over it. That would
     help with amends, rebases, and so forth.

  2. It would be nice if there was a knob for the user to turn, so they
     can spend more CPU time to find duplicates that might make the push
     smaller. There is a knob for rev-list, as shown above. But I don't
     think you can control how pack-objects behaves (aside from lying
     to it by passing --shallow), nor can you convince git-push itself
     to trigger pack-objects with specific options. But you could
     imagine a config option that would you do:

       git -c pack.aggressiveEdges=true push ...

     or something. It might be reasonable to turn on all the time in
     repos with few refs, or you could do a one-off like the command
     above if you saw that a push was going to be big.

And finally, there is one more trick up our sleeve: reachability
bitmaps. The idea there is that we store bitmaps of which objects are
reachable from which commit, which lets us answer object-graph questions
quickly. And in particular it lets us produce a full set difference
between the reachable objects in two commits.

So doing:

  git repack -adb

before running pack-objects (or git-push) will also produce the desired
pack. The downside is that generating bitmaps is relatively expensive
(much more CPU than the push would have used in the first place). In
theory the results can then be amortized across many pushes, but the
tradeoff isn't always great for a local repository which mostly packs to
push (it's much better on a server that will serve many clones and
fetches).

-Peff
