Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679A41A0B0C
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 14:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730385836; cv=none; b=XyZaU5RoUdOJir9chu67yNUGaN2FXQ4Ger4tjMl/M6FGRcm+ekd0lWLBXoP0DGycpgbHm0/YdP5NZJE4ABjuy4+2rG3QmBpbc7w9v0ESzzS4g2U0FM+71BQgTc2jDPzynGweBobZeTEzWn2hfSfzYr3grzh4Eq1FRDXX8I/PUUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730385836; c=relaxed/simple;
	bh=rpw9RsKT9H0m6OMWubJcr2P9iSXC7bmIUa0tmwt8Spo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QaE6GZlDnke35ZriFq2PyAULNeolTuweA7MWrKofGicrVVmjqAxlt5AgebzAE2b+9OBchG+W0NgVo7fvW66Btu8kY8pI9BQEEqolsLJJF9evePU2mkovF1371wnET8f4M23RYtvywrzN45mW3qC8fMW3pSXoT6tNnlxW0xEpXuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=STxAeMni; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="STxAeMni"
Received: (qmail 19856 invoked by uid 109); 31 Oct 2024 14:43:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=rpw9RsKT9H0m6OMWubJcr2P9iSXC7bmIUa0tmwt8Spo=; b=STxAeMniz92Vy5FshWHDR1zvVFOmWckd/sCdpC0R2GBtOThacLdPpCH52t6G1alO76uacba78YZE3VjWRHnsy7P3BNYP9TLTWP5kwI9F82paVkfNejwEe+zAdgimHO6Zs11PQUeDgzLeeNJwT1Fi+/PRl+FEMOvljrtmENu7qkyYOPh0GBCMgPa6XZGMWcxNpe1kVuYn+IJ16jdzVMz/1L/rCJliWjcxb0FenABxQbYJ+lcESH520Y3IAGzZVULOgdzeVvsqzn/8rZWM+PLD5O4DZUJ6DWlq+nyNclSQf5sqiuK2Q5aSEaaX66HvavMheLw7BnNoaiiEvORNjGLc2w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 31 Oct 2024 14:43:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1983 invoked by uid 111); 31 Oct 2024 14:43:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 31 Oct 2024 10:43:51 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 31 Oct 2024 10:43:51 -0400
From: Jeff King <peff@peff.net>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: Benno Evers <benno@bmevers.de>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	git@vger.kernel.org
Subject: Re: [PATCH] setlocalversion: Add workaround for "git describe"
 performance issue
Message-ID: <20241031144351.GA1720940@coredump.intra.peff.net>
References: <309549cafdcfe50c4fceac3263220cc3d8b109b2.1730337435.git.jpoimboe@kernel.org>
 <87bjz0k17c.fsf@prevas.dk>
 <20241031114210.GA593548@coredump.intra.peff.net>
 <20241031122456.GB593548@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241031122456.GB593548@coredump.intra.peff.net>

On Thu, Oct 31, 2024 at 08:24:56AM -0400, Jeff King wrote:

> We have to feed at least one commit with the "within" flag into the
> traversal so that it can let us end things. But I don't think it really
> matters if that commit is the one we found, or if it's a parent of one
> that we happened to pass "within" bits down to.
> 
> So I think we can just set "gave_up_on" to the final element we found
> (whether from max_candidates or from finding every possible name). I.e.,
> what I showed earlier, or what you were proposing.

Hmph. So I don't think this is quite true, but now I'm puzzled again.

It is accurate to say that we must make sure _some_ commit with the
those flag bits set remains in "list". And I don't think it matters if
it's the candidate we found, or its parent.

But there's other stuff happening in that loop, after we process that
max candidate (where we'd proposed to break) but before we hit the next
possible candidate. Stuff like adding onto the depth of the other
candidates. Josh's example doesn't show that because it only has one
candidate, but I could imagine a case where it does matter (though I
didn't construct one).

So I'd have thought that this:

diff --git a/builtin/describe.c b/builtin/describe.c
index 7330a77b38..b0f645c41d 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -366,6 +366,12 @@ static void describe_commit(struct object_id *oid, struct strbuf *dst)
 		struct commit_name **slot;
 
 		seen_commits++;
+
+		if (match_cnt == max_candidates) {
+			gave_up_on = c;
+			break;
+		}
+
 		slot = commit_names_peek(&commit_names, c);
 		n = slot ? *slot : NULL;
 		if (n) {
@@ -381,10 +387,6 @@ static void describe_commit(struct object_id *oid, struct strbuf *dst)
 				if (n->prio == 2)
 					annotated_cnt++;
 			}
-			else {
-				gave_up_on = c;
-				break;
-			}
 		}
 		for (cur_match = 0; cur_match < match_cnt; cur_match++) {
 			struct possible_tag *t = &all_matches[cur_match];

would do it, by just finishing out the loop iteration and bailing on the
next commit. After all, that commit _could_ be a candidate itself. But
it causes a test in t6120 to fail. We have a disjoint history like this:

                 B
                 o
                  \
    o-----o---o----x
          A

and we expect that "x" is described as "A-3" (because we are including
the disjoint B). But after the patch above and with --candidates=2
(since there are only two tags and part of our goal is to limit
candidates to the number of tags), we find "B-4". Which is worse (at
least by some metrics).

I think this comes from 30b1c7ad9d (describe: don't abort too early when
searching tags, 2020-02-26). And given the problem description there, I
can see how quitting early in a disjoint history will give you worse
answers. But the patch above is triggering a case that already _could_
trigger.

So it feels like 30b1c7ad9d is incomplete. Without any patches, if I
limit it to --candidates=2 but make A^ a tag, then it gets the same
wrong answer (for the exact same reason). And I don't see a way to make
it correct without losing the ability to break out of the traversal
early when we hit max_candidates (which is obviously a very important
optimization in general). But maybe I'm missing something.

I do think my patch above is not introducing a new problem that wasn't
already there. It's just that the toy repo, having so few tags, means
any logic to reduce max_candidates will trigger there.

+cc the author of 30b1c7ad9d for any wisdom

-Peff
