Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19521D8DFB
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 07:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740122763; cv=none; b=GAIL0yxz256cKrXqISjTtgJIeyXueEMBSyEOFaJ4vhVXksjE93AHLp4on7oOJXZFDIiUK8MBsKasO7a/aLL1/wYVREhMQuQyY8f1Szv1EC2TlYQFP3UKmCZCemkrLVre3k/Zum2ETqLIDU5haY5KN6JXZ1M2oowUeD/uqkd2qy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740122763; c=relaxed/simple;
	bh=ZkoiUdNG4XorpoHFQKWVsZhBMX2yWLS7QKt9XKI0Kkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hsrUZGRxo5C1m5g6iMQKCxxpr4jx9bF94CbR1Uj/3mcGOspqFFRAGcOtywOVOGXAP9JrR5eNeT1dkBPHYWz/g80JgE08b4ScuoijDFz053p8yvhWJ08kcyWKvLXhbvkmhVXzkOe89+zElw34jADWT3v9UyfWm4e17HoMI6JV5Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=MOBer2Bp; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="MOBer2Bp"
Received: (qmail 3131 invoked by uid 109); 21 Feb 2025 07:25:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ZkoiUdNG4XorpoHFQKWVsZhBMX2yWLS7QKt9XKI0Kkk=; b=MOBer2BpZZiHJjHTVbpZZH/PBjoqsbyD48JPN4Z/MNxvfjwVr9lkAtX9jzU8MS4b1Jq9Pi3t/M00I9n4RxIWlWthfX7VK36YloIZzZI7zBJqftNTzizSzH2SjUZjP4tmkiu0Ohtm0gmFs4nLCLXwnGeaDcYX0aeSdf9ApLPqYIQMpipDwLZoDXswOi/X+M0lQRoWFu1ObrvjeTGwzxdx9UNGWMluaNThsKjnAHF0HIO7/yGVTpr8yNe5jxifn0A5mvY0V+6C1ZCg1lULJUkyagws7s5Mc9g0opdjnkU4Ei8ehPyEsxmQe8MTiRDEE+sjNAZX0Mn0MEOWW6cNh3lrVw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 Feb 2025 07:25:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30741 invoked by uid 111); 21 Feb 2025 07:25:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Feb 2025 02:25:59 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 21 Feb 2025 02:25:58 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, Igor Todorovski <itodorov@ca.ibm.com>,
	Bence Ferdinandy <bence@ferdinandy.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Tags are no longer fetched when fetching specific commit
Message-ID: <20250221072558.GA572877@coredump.intra.peff.net>
References: <71075837-D0AA-4F01-9F5D-CA10BFE93B63@ca.ibm.com>
 <Z650WoqFwCSo6svH@nand.local>
 <xmqqv7tcl6hp.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv7tcl6hp.fsf@gitster.g>

On Fri, Feb 14, 2025 at 10:35:14AM -0800, Junio C Hamano wrote:

> Taylor Blau <me@ttaylorr.com> writes:
> 
> > So I think the right fix would really be something like:
> >
> > --- 8< ---
> > diff --git a/builtin/fetch.c b/builtin/fetch.c
> > index fe2b26c74a..0e63621e6c 100644
> > --- a/builtin/fetch.c
> > +++ b/builtin/fetch.c
> > @@ -1770,9 +1770,8 @@ static int do_fetch(struct transport *transport,
> >
> >  	if (tags == TAGS_SET || tags == TAGS_DEFAULT) {
> >  		must_list_refs = 1;
> > -		if (transport_ls_refs_options.ref_prefixes.nr)
> > -			strvec_push(&transport_ls_refs_options.ref_prefixes,
> > -				    "refs/tags/");
> 
> I guess the original "if we are giving prefixes already, then make
> sure we learn about tags" is because the semantics of the ref-prefix
> is peculiar, in that without _any_, there is no limitation and the
> remote end would advertise all its refs, but if there is even one,
> the remote end would advertise only the ones that match any prefix?

Yes, I think that is accurate. We must either add prefixes for all bits
of code interested in seeing the remote refs, or we must add none at
all.

And so just removing the conditional like this:

> > +		strvec_push(&transport_ls_refs_options.ref_prefixes,
> > +			    "refs/tags/");
> 
> So this change would make sure that, even if somebody else already
> added a prefix earlier, we would always ask about tags if we come
> into this block.  It also means when nobody has added a prefix
> before we reach here, we still add prefix to ask about tags.  The
> implication of which may be rather grave.  If a later code relied
> on us _not_ asking for tags here (because nobody is limiting the
> ls-refs request with prefix), after this change, that code will
> now see that there is some prefix requested already, and if we
> wanted to retain what that code does, we would need to adjust that
> code (and then the need for similar modification cascades X-<).

is not going to work. I _think_ for the reasons you're implying above,
but your mention of "if later code relied on us..." confused me.

It is really the _earlier_ code that we are screwing up here. If the
earlier block which conditionally added to ref_prefixes did not add
anything, then unconditionally adding "refs/tags/" means that the refs
that earlier code expected to find in the advertisement may not be
present.

Of course it is the later code which actually starts the fetch and looks
at the advertisement that will bear the effects of the missing refs. So
maybe that is what you meant by "later code". ;)

> I have to wonder if the first thing we should do is to update the
> logic to decide what ref prefixes to use, so that it does not do
> such an incremental strvec_push().  There are multiple questions in
> the form "Do we need to know about X?" the code path need to ask
> before deciding what prefixes to use, and before Bence's "We need to
> know about HEAD, because we want to know about its symref value",
> refs/tags hierarchy was one (and only?) thing we needed to ask
> about.  The bug under discussion smells like the result of how
> brittle the code's assumption about what prefixes other parts would
> want to ask.  This code did not assume there is anybody else, and
> that is why it broke when we started asking about HEAD.  Now we have
> two possible X's in that question (refs/tags and HEAD).  We may want
> to make sure the code is robust enough when we add the third one.

There are three spots, really: the refs we are fetching, the tags for
following, and now HEAD.

But they are not all equal. The decision of "can we limit the ref
advertisement at all" comes from the first one, the set of refs we are
fetching[1]. And then the other ancillary data must follow that lead
(either adding bits they are interested in, or not touching it at all if
we are going to see the whole advertisement).

So I think the bug is in adding the HEAD prefix: it should only happen
if we are otherwise limiting the advertisement. I.e., this should fix
the problem in this thread:

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 1c740d5aac..c80afc6477 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1777,7 +1777,8 @@ static int do_fetch(struct transport *transport,
 
 	if (uses_remote_tracking(transport, rs)) {
 		must_list_refs = 1;
-		strvec_push(&transport_ls_refs_options.ref_prefixes, "HEAD");
+		if (transport_ls_refs_options.ref_prefixes.nr)
+			strvec_push(&transport_ls_refs_options.ref_prefixes, "HEAD");
 	}
 
 	if (must_list_refs) {

as well as other possible ones (where asking for HEAD caused us to
suppress the advertisement for the refs we actually wanted to fetch;
though see my footnote below).

I do agree this dependency is subtle. I'm not sure how to make it less
awkward in the code, though. It's really a property of the protocol, and
not the code itself. So this:

> about.  The bug under discussion smells like the result of how
> brittle the code's assumption about what prefixes other parts would
> want to ask.  This code did not assume there is anybody else, and
> that is why it broke when we started asking about HEAD.  Now we have
> two possible X's in that question (refs/tags and HEAD).  We may want
> to make sure the code is robust enough when we add the third one.

is always going to have that brittle-ness. You can't just have every
spot register "I am interested in this prefix", because the _lack_ of
registering means something, too.

But it's less bad than one might think, because the primary decision
about whether to use prefixes at all happens first, and all three spots
are contained in a single function. We could perhaps add a boolean
"restrict_ref_prefixes" flag to make it a bit more obvious. But the code
would still look like:

  if (...some complicated logic...) {
	restrict_ref_prefixes = 1;
	strvec_push(&ref_prefixes, ...);
  }

  if (...we want tags...) {
	if (restrict_ref_prefixes)
		strvec_push(&ref_prefixes, "refs/tags/");
  }

  if (...we want HEAD...) {
	if (restrict_ref_prefixes)
		strvec_push(&ref_prefixes, "HEAD");
  }

That is perhaps a little more self-documenting, but it introduces a new
possible bug: that flag must be set if-and-only-if ref_prefixes is
non-empty. In the pseudo-code above that is not too bad, but in the real
code there are actually three branching paths which handle it. So it's
do-able, but I kind of wonder if a big comment explaining the situation
would make more sense.

-Peff

[1] One thing that I didn't dig into is why we would ever not pass ref
    prefixes at all. Skimming the code, I think we reach that state if
    we don't have any configure or command-line refspecs, and no
    branch-merge config. So something like:

      git init
      git fetch /path/to/some-repo.git

    But in that case I think we're just fetching HEAD into FETCH_HEAD?
    In which case we probably ought to just ask for HEAD, I'd think, to
    avoid pointless extra advertisement. And that's why the "other
    possible problems" I mentioned earlier might not exist. If we only
    hit the no-prefixes state when we're just fetching HEAD, then
    accidentally adding "HEAD" to the prefix list and limiting ourselves
    happens to do the right thing. ;)

    A patch like this:

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 1c740d5aac..3364546d2a 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1766,13 +1766,19 @@ static int do_fetch(struct transport *transport,
 					    branch->merge[i]->src);
 			}
 		}
+		/*
+		 * If there are no refs specified to fetch, then we just
+		 * fetch HEAD; mention that to narrow the advertisement.
+		 */
+		if (!transport_ls_refs_options.ref_prefixes.nr)
+			strvec_push(&transport_ls_refs_options.ref_prefixes,
+				    "HEAD");
 	}
 
 	if (tags == TAGS_SET || tags == TAGS_DEFAULT) {
 		must_list_refs = 1;
-		if (transport_ls_refs_options.ref_prefixes.nr)
-			strvec_push(&transport_ls_refs_options.ref_prefixes,
-				    "refs/tags/");
+		strvec_push(&transport_ls_refs_options.ref_prefixes,
+			    "refs/tags/");
 	}
 
 	if (uses_remote_tracking(transport, rs)) {

  does that limiting in a more explicit way, reducing the advertisement
  for this kind of HEAD-only fetch. And as a bonus, it means that we'll
  _always_ have the correct prefixes set, so further code for tags or
  HEAD can unconditionally append to the prefix list.

  It fixes the case that started this thread, and passes all the tests.

  But I'm not 100% sure that this is thinking through all of the cases.
  In particular, the one in this thread is fetching a raw sha1, which is
  why there's no refspec (and thus no ref prefix set). In that case
  asking for HEAD is actually pointless (assuming we don't care about
  tag following or setting a configured $remote/HEAD, we would not need
  any ref advertisement at all!). Asking for HEAD is not too bad an
  outcome, but I think the "right" answer is really to suppress the
  advertisement totally. There's not protocol support for that, though,
  so asking for HEAD as a default is maybe a not-too-bad workaround?

-Peff
