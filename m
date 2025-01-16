Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991A61DE3CF
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 12:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737031997; cv=none; b=jkh8eqdW9sBkwGTYWki1IT5RiLoRoX8hrE8dKaYqFUJZlIvTDf9qON9VDQFmeQJEJLhOnqgyotPhJDVygkYFcSQ2OkyZOwDKHTQXpIuL59KKBmIxx0PtFdyvd4lXvPZC1NYXgi1vkUp+UAG94If0ZoNDO6sbcOWmP/NsFIPldZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737031997; c=relaxed/simple;
	bh=pALPHti0G1XMNLs5fqFC6tdgRx5C+/odO1eSFKXqm3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLvydZx92fh1x0pBQwH/BCjjsXRiRdy9dx7XjWO9EGJvvlZxR8b3oEujlD/lGa1ZqGcvgMWBfTnZfLxLOHJVho0U1Knntn+zwxYD3ti3WwJFk8aMgO2+H9xuaDAB/6VsOvIFAB0pZk6ZyrY4wHepq3iUVuYUSFiSMP+c8S9ySIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=P3K7hfvS; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="P3K7hfvS"
Received: (qmail 13574 invoked by uid 109); 16 Jan 2025 12:53:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=pALPHti0G1XMNLs5fqFC6tdgRx5C+/odO1eSFKXqm3k=; b=P3K7hfvSwFav7+PpFQvvp7ge4HswjAU5klJRa4pzkV4eNXL99je7eq5NpA4qgFL5iHFRAZgHCGT/VZ7FqWAg86aKgT69a++q1XP1Z/Y2zT264BmUbs9SxQxfRTJ2ltTF6vAnckkyHqnTId1VeULZ5HaPA6GMnDe5t6//EKpqFqi6yvEUTjc47WyI1i6yT9S3zFmpj6fxc6La9UKplxukZaRjIbncxiVsVMiNVRZWKssR8r+DcZUA/O3f69gq34NZaO2uXJFbpPoxktbJ+fMopXHKY33Pa/dNpeeAwfbixkjYnYspxubuNJRW1U3SdCJzyxYj6P00Yfv2ivXR7uB8NQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Jan 2025 12:53:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25806 invoked by uid 111); 16 Jan 2025 12:53:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Jan 2025 07:53:14 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 16 Jan 2025 07:53:13 -0500
From: Jeff King <peff@peff.net>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Askar Safin <safinaskar@zohomail.com>, git <git@vger.kernel.org>
Subject: Re: [bug] "git bisect old v3.0" takes 21 mins on Linux repo
Message-ID: <20250116125313.GA2301268@coredump.intra.peff.net>
References: <19461b87a5c.5a2ea74016716.8214238482389812984@zohomail.com>
 <CALnO6CAzN1oeT4tMjJ1Qm4dW0xdVkVKHJ39oJTX8R8E614FH6g@mail.gmail.com>
 <20250116105246.GF773990@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250116105246.GF773990@coredump.intra.peff.net>

On Thu, Jan 16, 2025 at 05:52:46AM -0500, Jeff King wrote:

> That clear_distance() call likewise iterates through the list to clear
> the COUNTED flags from each. I guess we might be able to traverse down
> from the tip of the commit we're operating on, clearing flags there.
> Since that's how the flags are set in count_distance().
> 
> I suspect it's still quadratic, though, because count_distance() is
> traversing separately for each (and in the worst case everything is
> reachable from it). But it might still improve things in practice.

Apparently I'm good at suspecting. Here's a patch to make
clear_distance() walk the same commits as count_distance(), including
the string-of-pearls recursion avoidance:

diff --git a/bisect.c b/bisect.c
index 1a9069c9ad..ecf656316b 100644
--- a/bisect.c
+++ b/bisect.c
@@ -69,12 +69,28 @@ static int count_distance(struct commit_list *entry)
 	return nr;
 }
 
-static void clear_distance(struct commit_list *list)
+static void clear_distance(struct commit_list *entry)
 {
-	while (list) {
-		struct commit *commit = list->item;
+	while (entry) {
+		struct commit *commit = entry->item;
+		struct commit_list *p;
+
+		if (commit->object.flags & UNINTERESTING)
+			break;
+		if (!(commit->object.flags & COUNTED))
+			break;
+
 		commit->object.flags &= ~COUNTED;
-		list = list->next;
+
+		p = commit->parents;
+		entry = p;
+		if (p) {
+			p = p->next;
+			while (p) {
+				clear_distance(p);
+				p = p->next;
+			}
+		}
 	}
 }
 
@@ -338,7 +354,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 		if (bisect_flags & FIND_BISECTION_FIRST_PARENT_ONLY)
 			BUG("shouldn't be calling count-distance in fp mode");
 		weight_set(p, count_distance(p));
-		clear_distance(list);
+		clear_distance(p);
 
 		/* Does it happen to be at half-way? */
 		if (!(bisect_flags & FIND_BISECTION_ALL) &&

It cuts Askar's case on my machine from 16m51s to 9m34s. So a big
improvement but still...not great.

I suspect that the whole bisection count algorithm needs to be rewritten
to all run in a single traversal. I guess if you iterate over the
commits in reverse-topo order, you should be able to just compute each
distance as "d(commit) = 1; d(commit) += d(p) for parents(commit)". But
it's not a problem I've thought a lot about, so I'm probably missing
some subtlety.

At any rate, an easier way to time this is:

  git rev-list --bisect v3.0..v6.13-rc7

which is the expensive part of what git-bisect is doing under the hood.

-Peff
