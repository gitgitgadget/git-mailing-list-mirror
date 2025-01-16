Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1474C24A7C0
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 10:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737022919; cv=none; b=gJ78WcZbA/hrmsXbNhDi1MHxJflncpYFdD16Eb04irAe0DhGJgF+8e+cUpYl4PGNfAMAEt3KHIEeR9WhFfxSpFm5+AnuN999eastAIenKbMr5N/OHiaU2Qq02KEFuYBJRsOuazbGYmpIHhL4vGy4LHTHg5YDYb7gFSAyD83tWhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737022919; c=relaxed/simple;
	bh=6yq8tHLJJZn45S+scucyma03npGbOVdUWtUJUfRONd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oLSthHGrYGs8dwH55aXK8k/o8+MQUCK/y3b8Wb3nR1PFBGtCHPTf0U5feRQYdDxWaLb6kVHUwyHQQ6vzqKKwj7/WvI9VemGtBcQhwjpYeVSNQu4TTMsKhJAdxal7R2N7U2fuYpuOUpGvAJZNYw0WtsxUjs5VFSg+16BbFzV21Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=TwUdVQVV; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="TwUdVQVV"
Received: (qmail 12269 invoked by uid 109); 16 Jan 2025 10:21:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=6yq8tHLJJZn45S+scucyma03npGbOVdUWtUJUfRONd4=; b=TwUdVQVVZJ5Vc7kuSvFJg/TojBCoEIL8Zxer7PrjwtXA6juBZ1xsQYdOwyqjMGv+d9iP6lXaHhi/XmU8bZcyjNBJWljqUfG9VqpXd4ZonMrWuG//62Nl/aj/YuqGXP8JcgP3ObiPKAegNm3kVsX0iOq1Y7eyNokJxXJkgb+lFV77HL4Rj8IkEHggWseRU4D4tqVBpZBumcXwZTr13sb7WzdZPlX7A7pl8nmT2Qr4ciUDX4M+GvZmgrpgJfX+gQVK6fxaFVkkY8HsgR3jpFQaPJF7KMfW4fYvCVZh/6lb80jF15alYtFu6KjqFh/PaiE2wuPAimXxm6i8IDQSIIYk2A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Jan 2025 10:21:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23941 invoked by uid 111); 16 Jan 2025 10:21:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Jan 2025 05:21:59 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 16 Jan 2025 05:21:54 -0500
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Ross Goldberg <ross.goldberg@gmail.com>, git@vger.kernel.org,
	Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] ref-filter: share bases and is_base_tips between
 formatting and sorting
Message-ID: <20250116102154.GA724126@coredump.intra.peff.net>
References: <CAAEcvMovcZucuq4H70ouQzKS=_wHnBi1DqJ-4MMFVXX9XLEciw@mail.gmail.com>
 <6b824f05-6f16-4cd9-85b7-3b8b236158b4@web.de>
 <20250113051700.GA767856@coredump.intra.peff.net>
 <57066d48-ce68-42ec-8e94-4ef6c1eba920@web.de>
 <20250116095128.GA144555@coredump.intra.peff.net>
 <20250116100637.GB144555@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250116100637.GB144555@coredump.intra.peff.net>

On Thu, Jan 16, 2025 at 05:06:37AM -0500, Jeff King wrote:

> On Thu, Jan 16, 2025 at 04:51:28AM -0500, Jeff King wrote:
> 
> > Yet another option in the near term might be storing these ahead-behind
> > bits in the individual atoms. Since the point is to do a single
> > traversal, we'd have to marshal them into a unified data structure at
> > some point. But we already do that! In filter_ahead_behind() we convert
> > the string list into an array (and ironically do not even look at the
> > strings, only their "util" fields).
> > 
> > So something like this (only lightly tested) seems to work:
> 
> I compiled it without DEVELOPER=1, so I missed a few unused parameters.
> We'd want this on top:

And one final thought on this approach: if we do want to do it, perhaps
it would make sense to build on top of the patch you sent. I think yours
fixes the bug in a more direct and obvious way, and then my approach
would merely be internal reorganization on top.

At any rate, here is the is_base conversion for posterity.

diff --git a/ref-filter.c b/ref-filter.c
index 0de51f13e6..28d48ec585 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -236,6 +236,7 @@ static struct used_atom {
 			       S_FINGERPRINT, S_PRI_KEY_FP, S_TRUST_LEVEL } option;
 		} signature;
 		struct {
+			char *name;
 			struct commit *commit;
 		} base;
 		struct strvec describe_args;
@@ -908,18 +909,16 @@ static int ahead_behind_atom_parser(struct ref_format *format UNUSED,
 	return 0;
 }
 
-static int is_base_atom_parser(struct ref_format *format,
-			       struct used_atom *atom UNUSED,
+static int is_base_atom_parser(struct ref_format *format UNUSED,
+			       struct used_atom *atom,
 			       const char *arg, struct strbuf *err)
 {
-	struct string_list_item *item;
-
 	if (!arg)
 		return strbuf_addf_ret(err, -1, _("expected format: %%(is-base:<committish>)"));
 
-	item = string_list_append(&format->is_base_tips, arg);
-	item->util = lookup_commit_reference_by_name(arg);
-	if (!item->util)
+	atom->u.base.name = xstrdup(arg);
+	atom->u.base.commit = lookup_commit_reference_by_name(arg);
+	if (!atom->u.base.commit)
 		die("failed to find '%s'", arg);
 
 	return 0;
@@ -3137,14 +3136,20 @@ void filter_ahead_behind(struct repository *r,
 }
 
 void filter_is_base(struct repository *r,
-		    struct ref_format *format,
 		    struct ref_array *array)
 {
 	struct commit **bases;
 	size_t bases_nr = 0;
 	struct ref_array_item **back_index;
+	size_t atoms_nr;
 
-	if (!format->is_base_tips.nr || !array->nr)
+	atoms_nr = 0;
+	for (size_t i = 0; i < used_atom_cnt; i++) {
+		if (used_atom[i].atom_type == ATOM_ISBASE)
+			atoms_nr++;
+	}
+
+	if (!atoms_nr || !array->nr)
 		return;
 
 	CALLOC_ARRAY(back_index, array->nr);
@@ -3154,7 +3159,7 @@ void filter_is_base(struct repository *r,
 		const char *name = array->items[i]->refname;
 		struct commit *c = lookup_commit_reference_by_name_gently(name, 1);
 
-		CALLOC_ARRAY(array->items[i]->is_base, format->is_base_tips.nr);
+		CALLOC_ARRAY(array->items[i]->is_base, atoms_nr);
 
 		if (!c)
 			continue;
@@ -3164,15 +3169,21 @@ void filter_is_base(struct repository *r,
 		bases_nr++;
 	}
 
-	for (size_t i = 0; i < format->is_base_tips.nr; i++) {
-		struct commit *tip = format->is_base_tips.items[i].util;
-		int base_index = get_branch_base_for_tip(r, tip, bases, bases_nr);
+	for (size_t i = 0, j = 0; i < used_atom_cnt; i++) {
+		struct commit *tip;
+		int base_index;
+
+		if (used_atom[i].atom_type != ATOM_ISBASE)
+			continue;
+
+		tip = used_atom[i].u.base.commit;
+		base_index = get_branch_base_for_tip(r, tip, bases, bases_nr);
 
 		if (base_index < 0)
 			continue;
 
 		/* Store the string for use in output later. */
-		back_index[base_index]->is_base[i] = xstrdup(format->is_base_tips.items[i].string);
+		back_index[base_index]->is_base[j++] = xstrdup(used_atom[i].u.base.name);
 	}
 
 	free(back_index);
@@ -3264,8 +3275,7 @@ struct ref_sorting {
 };
 
 static inline int can_do_iterative_format(struct ref_filter *filter,
-					  struct ref_sorting *sorting,
-					  struct ref_format *format)
+					  struct ref_sorting *sorting)
 {
 	/*
 	 * Reference backends sort patterns lexicographically by refname, so if
@@ -3292,17 +3302,18 @@ static inline int can_do_iterative_format(struct ref_filter *filter,
 	for (size_t i = 0; i < used_atom_cnt; i++) {
 		if (used_atom[i].atom_type == ATOM_AHEADBEHIND)
 			return 0;
+		if (used_atom[i].atom_type == ATOM_ISBASE)
+			return 0;
 	}
 	return !(filter->reachable_from ||
-		 filter->unreachable_from ||
-		 format->is_base_tips.nr);
+		 filter->unreachable_from);
 }
 
 void filter_and_format_refs(struct ref_filter *filter, unsigned int type,
 			    struct ref_sorting *sorting,
 			    struct ref_format *format)
 {
-	if (can_do_iterative_format(filter, sorting, format)) {
+	if (can_do_iterative_format(filter, sorting)) {
 		int save_commit_buffer_orig;
 		struct ref_filter_and_format_cbdata ref_cbdata = {
 			.filter = filter,
@@ -3319,7 +3330,7 @@ void filter_and_format_refs(struct ref_filter *filter, unsigned int type,
 		struct ref_array array = { 0 };
 		filter_refs(&array, filter, type);
 		filter_ahead_behind(the_repository, &array);
-		filter_is_base(the_repository, format, &array);
+		filter_is_base(the_repository, &array);
 		ref_array_sort(sorting, &array);
 		print_formatted_ref_array(&array, format);
 		ref_array_clear(&array);
@@ -3662,6 +3673,5 @@ void ref_format_init(struct ref_format *format)
 
 void ref_format_clear(struct ref_format *format)
 {
-	string_list_clear(&format->is_base_tips, 0);
 	ref_format_init(format);
 }
diff --git a/ref-filter.h b/ref-filter.h
index 5f3dd6c931..0ba94df651 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -99,9 +99,6 @@ struct ref_format {
 	/* Internal state to ref-filter */
 	int need_color_reset_at_eol;
 
-	/* List of bases for is-base indicators. */
-	struct string_list is_base_tips;
-
 	struct {
 		int max_count;
 		int omit_empty;
@@ -114,7 +111,6 @@ struct ref_format {
 }
 #define REF_FORMAT_INIT {             \
 	.use_color = -1,              \
-	.is_base_tips = STRING_LIST_INIT_DUP, \
 }
 
 /*  Macros for checking --merged and --no-merged options */
@@ -210,7 +206,6 @@ void filter_ahead_behind(struct repository *r,
  * If this is not called, then any is-base atoms will be blank.
  */
 void filter_is_base(struct repository *r,
-		    struct ref_format *format,
 		    struct ref_array *array);
 
 void ref_filter_init(struct ref_filter *filter);
