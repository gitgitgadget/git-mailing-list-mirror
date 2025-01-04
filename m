Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA06FC133
	for <git@vger.kernel.org>; Sat,  4 Jan 2025 00:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735950719; cv=none; b=TokOouYrRsYM3SW4VZGq9IKD6AumHt2J5qD7m+PFeZyh8/ODyUdU4+0fGwtUZX9BHlBd92DcL5gDlPuOfeXNJzb35nY47WDBVjj4e78RonO/M2m1NxzvS4trbvwsXBu0LMYiQ3q6g23BTtqA5wHrc7aqqbGW2fdfr4HIAdj4dSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735950719; c=relaxed/simple;
	bh=luP73v76KrX3IIFoHIdtYGwvYHCQF0S4XAYOnJX34Tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GfCLlHiSqI1WqkZq1gXQYVHDcg2mp8is5sJki1sfJJFQ94MuQdA6wvENf9FI9kXzj2fYl5uL1i0E7EnwSr0v7LOelRLR5+SLBCqSEbRJ2+fLKZiXqWKH8SzJY1c+S/Sfun9VWZrQA3Xp7x5E4BLU+v5F3402/rT1cDkJKCWdCsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=cear5/36; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="cear5/36"
Received: (qmail 20960 invoked by uid 109); 4 Jan 2025 00:31:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=luP73v76KrX3IIFoHIdtYGwvYHCQF0S4XAYOnJX34Tw=; b=cear5/36cES8RLfkga6APoyNK2GYJTs0VpdzSdDDK/hUimsQKAlljjrQEvRKcAvLp3sJltO8FNanFWVqInbf1fH8Jii6h+RZ9K9R3pNzr0JJUV5l66kWdW2TRrZQ1oSqFler9JZXBqTEZ/oGtpIROXkwAV+vXY2uvLcxYJpsPwDaErgqPzhTnHGKfb8IgAeAp6Tc1s2FE9+d3QMJbmesP+YwOtyMAAWHzPwbc/U6Ga02bH4Z2MPynHfih1uUGWw6+Y72mYapa2wTx5heN1ZXRSMu9ShyxY47QXGaja/5tbI2M6St3SaqSUDho5PCCeHoow3z9SwUejS1c8oZdqO/bA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 04 Jan 2025 00:31:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7690 invoked by uid 111); 4 Jan 2025 00:31:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 Jan 2025 19:31:54 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 3 Jan 2025 19:31:54 -0500
From: Jeff King <peff@peff.net>
To: Wink Saville <wink@saville.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [BUGREPORT] git diff-tree --cc SEGFAUTs
Message-ID: <20250104003154.GB3244554@coredump.intra.peff.net>
References: <CAKk8isqpAXLoiXxOP3uAc00M+OM0FaU3Uhnt5R1FnFMD=xGARg@mail.gmail.com>
 <20250103204624.GE3212696@coredump.intra.peff.net>
 <CAKk8isrz1NQ=3=2aZ3tANymo0eSsCy=r6W5yKgn6gxmOom54CA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKk8isrz1NQ=3=2aZ3tANymo0eSsCy=r6W5yKgn6gxmOom54CA@mail.gmail.com>

On Fri, Jan 03, 2025 at 03:34:58PM -0800, Wink Saville wrote:

> But having to protect yourself is unobvious and especially if it isn't necessary
> when using the `fetch_paths_generic`.
> 
> In addition, from strbuf.h `buf` is never NULL:
> 
> "
> * strbufs have some invariants that are very important to keep in mind:
>  *
>  *  - The `buf` member is never NULL, so it can be used in any usual C
>  *    string operations safely. strbufs _have_ to be initialized either by
>  *    `strbuf_init()` or by `= STRBUF_INIT` before the invariants, though.
>  *
> "
> 
> So I'd say this could be considered a bug in git at least in how
> combine_diff_path
> is being managed. I assume you agree that neither find_paths_generic or
> find_paths_multitree are adhering to at least that strbuf invariant and I wonder
> if the other strbuf invariants are being upheld.

The strbuf invariant can only be held on strbufs which have been
initialized, and this one has not. I don't think it's wrong to have
variables which not (yet) been initialized. It can make for a fragile
interface, though, if uninitialized struct members are exposed widely.

I'm not sure how wide this case is. It's mostly an internal combine-diff
data structure, though it looks like it gets exposed to other code in a
few spots (though nobody outside of combine-diff.c currently looks at
the parent paths at all).

So I wouldn't call it a bug, as the internals of Git are not part of the
public interface and there is no user-visible behavior problem without
patching. But I doubt anybody would object to a patch making the API
less fragile if it can be done cheaply and easily. And strbufs are
designed to be cheap to initialize. So something like (completely
untested):

diff --git a/combine-diff.c b/combine-diff.c
index 641bc92dbd..452b5f5beb 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -67,9 +67,9 @@ static struct combine_diff_path *intersect_paths(
 			p->parent[n].mode = q->queue[i]->one->mode;
 			p->parent[n].status = q->queue[i]->status;
 
+			strbuf_init(&p->parent[n].path, 0);
 			if (combined_all_paths &&
 			    filename_changed(p->parent[n].status)) {
-				strbuf_init(&p->parent[n].path, 0);
 				strbuf_addstr(&p->parent[n].path,
 					      q->queue[i]->one->path);
 			}
@@ -92,9 +92,7 @@ static struct combine_diff_path *intersect_paths(
 			/* p->path not in q->queue[]; drop it */
 			*tail = p->next;
 			for (j = 0; j < num_parent; j++)
-				if (combined_all_paths &&
-				    filename_changed(p->parent[j].status))
-					strbuf_release(&p->parent[j].path);
+				strbuf_release(&p->parent[j].path);
 			free(p);
 			continue;
 		}
@@ -1645,9 +1643,7 @@ void diff_tree_combined(const struct object_id *oid,
 		struct combine_diff_path *tmp = paths;
 		paths = paths->next;
 		for (i = 0; i < num_parent; i++)
-			if (rev->combined_all_paths &&
-			    filename_changed(tmp->parent[i].status))
-				strbuf_release(&tmp->parent[i].path);
+			strbuf_release(&tmp->parent[i].path);
 		free(tmp);
 	}
 

might help the uninitialized-pointer issue. OTOH it is not really
solving the more fundamental problem, which is that p->parent[i].path is
only sometimes useful (we do not fill it in if it would just be the same
as p->path, so the patch only changes it from uninitialized memory into
an empty strbuf).

And that is probably not something we want to change, as allocating
duplicates of each path may be expensive. Probably we'd be better to
encapsulate it in a function which falls back to p->path automatically.
But then, AFAICT there are only two sites (both inside combine-diff.c)
which look at it, so it would mostly be hypothetical future-proofing. I
dunno.

> So, should this bug be "closed" and a new one "created"?
> 
> Actually, using the mailing list to identify bugs and initially discuss
> them, seems fine. But is there a place where there is a list of current bugs and
> their state?

No, there's no bug tracker for the project[1]. Discussion may lead to a
patch or not, which may be applied or not, but there is no formal
classification of "open" or "fixed" or "won't fix".

-Peff

[1] Some folks seem to be using:

      https://git.issues.gerritcodereview.com/issues?q=status:open

    but I don't know how active it is. I never use it and had to dig out
    the link to https://crbug.com, which now redirects there, from a
    message from 2017. There's some recent activity, but I wouldn't
    count on opening something there to get wide attention.
