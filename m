Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D176311C36
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 06:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771567208; cv=none; b=fBbzOrLxiNKW9sSgi+t2YuHKwtmMxe6FvdC6ZiMOqBJsK3V2CU/pXkxwQc13RvQ8X6fOgpeqd8rTHdM4+5lHeM2MomR1YdWC3D3/RxGyKirj+T4MhapUSJ9sWwDmNz2ldhPZDuGTv1bw0qek3bHmNJDFDHvmQYmvFpPtnnEsYQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771567208; c=relaxed/simple;
	bh=JjWc3vDc/EQKRFVETKs8XIAni+jyKpYiz8qDNvm6A5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ihv9qDyBquRkZsGTqx5oyhomnsjhHUcLSEfVWXVfgSdBLEmoYmlWzlaHuXBGQwOUgMeKQC8R2M/ZrndJ1jorpIiM5Og4zujkU5YZlqd32bHEWnzK8Jh8ZtrQFCM7SI3DNr38qSPsb2J1ZpdHSamr6obcg/cpyOzjkfaCWidWxlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=H1krn38I; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="H1krn38I"
Received: (qmail 11210 invoked by uid 109); 20 Feb 2026 06:00:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=JjWc3vDc/EQKRFVETKs8XIAni+jyKpYiz8qDNvm6A5M=; b=H1krn38IYJ2hKkQafedUgqIyeDCqzAlOzfvoeg3xJEmygoNteTz+OXG9ScfA6RkCaRdYp+2VEHg5DkZJe6Owyy2padMixuNMFwa0a7Mo2Fb2AKbjicg26eUnzp1/IWAd/iKKLEnaljSVfg/5zodIN8S1xW3sySOj2G03T5yy8cPLaN/LyEWckFAjG6bLC1lWyjR09ENbrLkV+zGj3UwLtgMYwrNN/JSIDvOovtpOCYrfBMWdFHGsVrlvPojaBn96G3VAgEw9UIFeKjOm9jOQOv4B8YyNkmA20Eq/McYnTHyWLqPux9RtjcmPue30vM46c7q5VVmiRLrPcE+lRAoOdQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 20 Feb 2026 06:00:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20155 invoked by uid 111); 20 Feb 2026 06:00:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 20 Feb 2026 01:00:08 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 20 Feb 2026 01:00:03 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Collin Funk <collin.funk1@gmail.com>, git@vger.kernel.org
Subject: [PATCH] ref-filter: clarify lstrip/rstrip component counting
Message-ID: <20260220060003.GA26256@coredump.intra.peff.net>
References: <20260215085755.GA86262@coredump.intra.peff.net>
 <20260215090052.GA695631@coredump.intra.peff.net>
 <xmqqqzqjckgu.fsf@gitster.g>
 <20260219112149.GA3529@coredump.intra.peff.net>
 <xmqq8qco5zpm.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8qco5zpm.fsf@gitster.g>

On Thu, Feb 19, 2026 at 10:56:53AM -0800, Junio C Hamano wrote:

> > Is it worth rewriting to the "slashes" form above for clarity? I was
> > afraid to touch it just to shut up Coverity, but now we have two
> > confused people.
> 
> Yup, I think the answer to my "what does p mean?" question is "by
> itself p has *no* meaning, but (p-refname) is maintained to be the
> number of non-slash bytes we scanned so far, while i is the number
> of slashes."
> 
> And from that point of view, your "count slashes in the most stupid
> way that even 5 year old understands" certainly does make the result
> far easier to read.

Here it is in patch form. Probably not worth as many words as I wrote in
the commit message, but most of it is just summarizing our earlier
findings.

I do notice that this function may not do what we want for
"/absolute/ref/name" or for "refs//with//double//slashes". But I don't
think it should see either of those, as it would always get normalized
refnames from Git itself. So I think we can ignore it for now.

-- >8 --
Subject: [PATCH] ref-filter: clarify lstrip/rstrip component counting

When a strip option to the %(refname) placeholder is asked to leave N
path components, we first count up the path components to know how many
to remove. That happens with a loop like this:

	/* Find total no of '/' separated path-components */
	for (i = 0; p[i]; p[i] == '/' ? i++ : *p++)
		;

which is a little hard to understand for two reasons.

First, the dereference in "*p++" is seemingly useless, since nobody
looks at the result. And static analyzers like Coverity will complain
about that. But removing the "*" will cause gcc to complain with
-Wint-conversion, since the two sides of the ternary do not match (one
is a pointer and the other an int).

Second, it is not clear what the meaning of "p" is at each iteration of
the loop, as its position with respect to our walk over the string
depends on how many slashes we've seen. The answer is that by itself, it
doesn't really mean anything: "p + i" represents the current state of
our walk, with "i" counting up slashes, and "p" by itself essentially
meaningless.

None of this behaves incorrectly, but ultimately the loop is just
counting the slashes in the refname. We can do that much more simply
with a for-loop iterating over the string and a separate slash counter.

We can also drop the comment, which is somewhat misleading. We are
counting slashes, not components (and a comment later in the function
makes it clear that we must add one to compensate). In the new code it
is obvious that we are counting slashes here.

Signed-off-by: Jeff King <peff@peff.net>
---
 ref-filter.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index ac32b0e6bb..6bbb6fac18 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2176,19 +2176,20 @@ static inline char *copy_advance(char *dst, const char *src)
 static int normalize_component_count(const char *refname, int len)
 {
 	if (len < 0) {
-		int i;
-		const char *p = refname;
+		int slashes = 0;
+
+		for (const char *p = refname; *p; p++) {
+			if (*p == '/')
+				slashes++;
+		}
 
-		/* Find total no of '/' separated path-components */
-		for (i = 0; p[i]; p[i] == '/' ? i++ : *p++)
-			;
 		/*
 		 * The number of components we need to strip is now
 		 * the total minus the components to be left (Plus one
 		 * because we count the number of '/', but the number
 		 * of components is one more than the no of '/').
 		 */
-		len = i + len + 1;
+		len = slashes + len + 1;
 	}
 	return len;
 }
-- 
2.53.0.528.g678f28d038

