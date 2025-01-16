Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31430161321
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 10:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737022001; cv=none; b=eLPZq6Rujor6eNyFep+5gjeL+CEk853ZLKDEb7xEw+GSJe4NDQO4Y0VMlSeyNbc8NPQTiq4T3pk86g02J8+LxYJaYvCuvN/DZXHkhTYptXNG9O5xrRiC242Fbr4A5zzaaFcRhpSlfDudFc/T7gSl0AZckYyfH0KgFXC7KaxrfQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737022001; c=relaxed/simple;
	bh=xrGgTgBJF2fKzUaghIbfq4ikzA4VgmWitkVoTpJolJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJPfVcPSE9350KDkGqjHvnepJdT45hqBJMLuXzpIQIo7rsuviOAsiKzYd+HagrHmBO9LyZm0DJ112Xhx0fTDhORzt9hKfftIBqJybghLX54l0XOtYzr5oPC23Q9rdjqzCoJmvXwFPgAleiAobNUMbEp47H0zmg5RWWohf9agHt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=BVG3P5wz; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="BVG3P5wz"
Received: (qmail 12212 invoked by uid 109); 16 Jan 2025 10:06:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=xrGgTgBJF2fKzUaghIbfq4ikzA4VgmWitkVoTpJolJo=; b=BVG3P5wzVyRd8ar/qCf2NnXF+bPjovneIajZkYyeJyr8ZsciObeLdQxSqQ9pR/lYfn0mpq+S/cxvaNSKS5Jgd+rZ4Ubmtt7xMijfAWBDVx/aM2lAxscED9Erb9IvNZK5pXR1TjmJmOt2kDRu9xHKn9FsDbOTcMy9P6LOoIHTh82vD+WIPrbXWqLAMM/7pQsL7obAsv3Eno0We/LcOOQP/E9XcAYuxhhDLS5jW9fLA+b5wrG+LH9EycZ7NNXHYdXy4lki3zKspncjcO2GTqcnSkxtwjDRc264TxXxe+MdncebwtGntqjb7VGZGDQhl697s/jha/8iwy8pQfDDF+NPFQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Jan 2025 10:06:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23727 invoked by uid 111); 16 Jan 2025 10:06:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Jan 2025 05:06:42 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 16 Jan 2025 05:06:37 -0500
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Ross Goldberg <ross.goldberg@gmail.com>, git@vger.kernel.org,
	Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] ref-filter: share bases and is_base_tips between
 formatting and sorting
Message-ID: <20250116100637.GB144555@coredump.intra.peff.net>
References: <CAAEcvMovcZucuq4H70ouQzKS=_wHnBi1DqJ-4MMFVXX9XLEciw@mail.gmail.com>
 <6b824f05-6f16-4cd9-85b7-3b8b236158b4@web.de>
 <20250113051700.GA767856@coredump.intra.peff.net>
 <57066d48-ce68-42ec-8e94-4ef6c1eba920@web.de>
 <20250116095128.GA144555@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250116095128.GA144555@coredump.intra.peff.net>

On Thu, Jan 16, 2025 at 04:51:28AM -0500, Jeff King wrote:

> Yet another option in the near term might be storing these ahead-behind
> bits in the individual atoms. Since the point is to do a single
> traversal, we'd have to marshal them into a unified data structure at
> some point. But we already do that! In filter_ahead_behind() we convert
> the string list into an array (and ironically do not even look at the
> strings, only their "util" fields).
> 
> So something like this (only lightly tested) seems to work:

I compiled it without DEVELOPER=1, so I missed a few unused parameters.
We'd want this on top:

diff --git a/builtin/branch.c b/builtin/branch.c
index 6e7b0cfddb..fbb9536282 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -473,7 +473,7 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 	if (verify_ref_format(format))
 		die(_("unable to parse format string"));
 
-	filter_ahead_behind(the_repository, format, &array);
+	filter_ahead_behind(the_repository, &array);
 	ref_array_sort(sorting, &array);
 
 	if (column_active(colopts)) {
diff --git a/ref-filter.c b/ref-filter.c
index 4c10b6fe75..0de51f13e6 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -894,7 +894,7 @@ static int rest_atom_parser(struct ref_format *format UNUSED,
 	return 0;
 }
 
-static int ahead_behind_atom_parser(struct ref_format *format,
+static int ahead_behind_atom_parser(struct ref_format *format UNUSED,
 				    struct used_atom *atom,
 				    const char *arg, struct strbuf *err)
 {
@@ -3084,7 +3084,6 @@ static void reach_filter(struct ref_array *array,
 }
 
 void filter_ahead_behind(struct repository *r,
-			 struct ref_format *format,
 			 struct ref_array *array)
 {
 	struct commit **commits;
@@ -3319,7 +3318,7 @@ void filter_and_format_refs(struct ref_filter *filter, unsigned int type,
 	} else {
 		struct ref_array array = { 0 };
 		filter_refs(&array, filter, type);
-		filter_ahead_behind(the_repository, format, &array);
+		filter_ahead_behind(the_repository, &array);
 		filter_is_base(the_repository, format, &array);
 		ref_array_sort(sorting, &array);
 		print_formatted_ref_array(&array, format);
diff --git a/ref-filter.h b/ref-filter.h
index d048317802..5f3dd6c931 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -201,7 +201,6 @@ struct ref_array_item *ref_array_push(struct ref_array *array,
  * If this is not called, then any ahead-behind atoms will be blank.
  */
 void filter_ahead_behind(struct repository *r,
-			 struct ref_format *format,
 			 struct ref_array *array);
 
 /*

Getting rid of the ref_format argument to filter_ahead_behind makes it
even more plain that we are operating on magic global data behind the
scenes. ;) So in that sense this is all the same step back that I was
complaining about from your patch; eventually we'd need to pass the
used_atom array to filter_ahead_behind() via some struct. But somehow it
seems less bad to me because it is all being folded into the existing
global structure.

-Peff
