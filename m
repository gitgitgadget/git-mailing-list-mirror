Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EC518C332
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 09:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737021093; cv=none; b=AS0odKq/T7mfZCDEaT4SbF6MElT6kbC+bb9ZsfDP8atgp+Dgzyjwjh4AsWhJZRGxTMtwHggnGKBgHM2v2AzWrsKkSur4WG6kpbq2gnJcfg/VXgbG9TNVcjFqVGRBANwg6lZtt67bCNOQp7VAICwGQ117mNTejbMAzPYxCNNmINI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737021093; c=relaxed/simple;
	bh=j6+js/+VTTfUhbfq4hUJ5yUt4Sf4SePUiIXkzpRDUeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sy+lcGMcaDLL5kF8IbHM5M5XH5hlkJnhnlimwy4ycBszbkzBOGHiSgnR61ULD12khvGez30qKGokhmNt72KoL7Lr6RVhJh+GxaToGy7zISZRvZoZw3vjSOmFJ1MS20790NgZM45T12OEgUN17ZaO2KXqmP5kwRorlTEpBSMl63g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=hPvZQKCg; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="hPvZQKCg"
Received: (qmail 12152 invoked by uid 109); 16 Jan 2025 09:51:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=j6+js/+VTTfUhbfq4hUJ5yUt4Sf4SePUiIXkzpRDUeM=; b=hPvZQKCgVsSCFKXEMCGPv2LOiz3NMWOrsm8mPYnaJ8giXQNpl/FW0HDhOg1Wh08lKKZju/58HlqjKvsV0nmPDT3u2CnkXc9U0+TImJehWk5o/E7LxkdZPWX6ASktw+n6YLFRmhTA45strWXMAGeSXwZLHzOCa5oNu/zaA5N/MCCQke0k0CIhX2MPngpYH0AOGBn85uq5Q0xe8gYjuT7jfgBzf/nTXun0cjufEjCnfTiseX0ED0k2hSPYQadt0L0vijFuxFMMT7PO7+tHGaCFTzWmjZ0iRcI6Q9/fvnVMLxJXrXNF7LDdYwNzV/9Q5+3tHiJSs7sqAg96a2dSE5FWoA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Jan 2025 09:51:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23558 invoked by uid 111); 16 Jan 2025 09:51:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Jan 2025 04:51:33 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 16 Jan 2025 04:51:28 -0500
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Ross Goldberg <ross.goldberg@gmail.com>, git@vger.kernel.org,
	Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] ref-filter: share bases and is_base_tips between
 formatting and sorting
Message-ID: <20250116095128.GA144555@coredump.intra.peff.net>
References: <CAAEcvMovcZucuq4H70ouQzKS=_wHnBi1DqJ-4MMFVXX9XLEciw@mail.gmail.com>
 <6b824f05-6f16-4cd9-85b7-3b8b236158b4@web.de>
 <20250113051700.GA767856@coredump.intra.peff.net>
 <57066d48-ce68-42ec-8e94-4ef6c1eba920@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <57066d48-ce68-42ec-8e94-4ef6c1eba920@web.de>

On Tue, Jan 14, 2025 at 07:55:03PM +0100, René Scharfe wrote:

> A totally different thing that bugs me: Calling ahead-behind an atom is
> weird; it's more of a molecule.  It should be possible to add separate
> ahead and behind atoms, with scalar values, that we then could sort
> separately, preferably numerically instead of lexically.

Yeah, I agree that would be the most flexible way to do it. I'm not sure
if people would find it useful or not (I've never even used the
ahead-behind atom myself).

> > So one solution would be to make the use of that context struct more
> > explicit, and require ref_sorting callers to provide a format struct.
> > Like the patch below, which also passes your tests.
> 
> Did that in the first version of the patch.  It works, but keeps the
> cause of the issue unaddressed: The separation of used_atom and the
> string_lists, which together represent the parsed items.

Right. I think the end goal is: all pieces of data together in a
non-global struct. Anything short of that has to choose the least-bad
option. ;)

In a sense, having _anything_ global means that there is little point in
having a struct at all (since it is still not safe to be called twice).
But it feels like that's a necessary step on the way, and getting rid of
the struct is a step backwards.

I dunno. I still have dreams about rewriting ref-filter completely for
better clarity and efficiency.

> I'm not convinced that ref_format is the right place for them, but
> haven't thought this through, admittedly.  struct ref_filter and a
> new dedicated struct would be alternatives.  Moving used_atom will be
> painful in any case.

Yet another option in the near term might be storing these ahead-behind
bits in the individual atoms. Since the point is to do a single
traversal, we'd have to marshal them into a unified data structure at
some point. But we already do that! In filter_ahead_behind() we convert
the string list into an array (and ironically do not even look at the
strings, only their "util" fields).

So something like this (only lightly tested) seems to work:

diff --git a/ref-filter.c b/ref-filter.c
index 23054694c2..4c10b6fe75 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -235,6 +235,9 @@ static struct used_atom {
 			enum { S_BARE, S_GRADE, S_SIGNER, S_KEY,
 			       S_FINGERPRINT, S_PRI_KEY_FP, S_TRUST_LEVEL } option;
 		} signature;
+		struct {
+			struct commit *commit;
+		} base;
 		struct strvec describe_args;
 		struct refname_atom refname;
 		char *head;
@@ -892,17 +895,14 @@ static int rest_atom_parser(struct ref_format *format UNUSED,
 }
 
 static int ahead_behind_atom_parser(struct ref_format *format,
-				    struct used_atom *atom UNUSED,
+				    struct used_atom *atom,
 				    const char *arg, struct strbuf *err)
 {
-	struct string_list_item *item;
-
 	if (!arg)
 		return strbuf_addf_ret(err, -1, _("expected format: %%(ahead-behind:<committish>)"));
 
-	item = string_list_append(&format->bases, arg);
-	item->util = lookup_commit_reference_by_name(arg);
-	if (!item->util)
+	atom->u.base.commit = lookup_commit_reference_by_name(arg);
+	if (!atom->u.base.commit)
 		die("failed to find '%s'", arg);
 
 	return 0;
@@ -3088,18 +3088,31 @@ void filter_ahead_behind(struct repository *r,
 			 struct ref_array *array)
 {
 	struct commit **commits;
-	size_t commits_nr = format->bases.nr + array->nr;
+	size_t bases_nr, commits_nr;
 
-	if (!format->bases.nr || !array->nr)
+	if (!array->nr)
 		return;
 
+	bases_nr = 0;
+	for (size_t i = 0; i < used_atom_cnt; i++) {
+		if (used_atom[i].atom_type == ATOM_AHEADBEHIND)
+			bases_nr++;
+	}
+
+	if (!bases_nr)
+		return;
+
+	commits_nr = bases_nr + array->nr;
+
 	ALLOC_ARRAY(commits, commits_nr);
-	for (size_t i = 0; i < format->bases.nr; i++)
-		commits[i] = format->bases.items[i].util;
+	for (size_t i = 0, j = 0; i < used_atom_cnt; i++) {
+		if (used_atom[i].atom_type == ATOM_AHEADBEHIND)
+			commits[j++] = used_atom[i].u.base.commit;
+	}
 
-	ALLOC_ARRAY(array->counts, st_mult(format->bases.nr, array->nr));
+	ALLOC_ARRAY(array->counts, st_mult(bases_nr, array->nr));
 
-	commits_nr = format->bases.nr;
+	commits_nr = bases_nr;
 	array->counts_nr = 0;
 	for (size_t i = 0; i < array->nr; i++) {
 		const char *name = array->items[i]->refname;
@@ -3108,8 +3121,8 @@ void filter_ahead_behind(struct repository *r,
 		if (!commits[commits_nr])
 			continue;
 
-		CALLOC_ARRAY(array->items[i]->counts, format->bases.nr);
-		for (size_t j = 0; j < format->bases.nr; j++) {
+		CALLOC_ARRAY(array->items[i]->counts, bases_nr);
+		for (size_t j = 0; j < bases_nr; j++) {
 			struct ahead_behind_count *count;
 			count = &array->counts[array->counts_nr++];
 			count->tip_index = commits_nr;
@@ -3277,9 +3290,12 @@ static inline int can_do_iterative_format(struct ref_filter *filter,
 	 * - filtering on reachability
 	 * - including ahead-behind information in the formatted output
 	 */
+	for (size_t i = 0; i < used_atom_cnt; i++) {
+		if (used_atom[i].atom_type == ATOM_AHEADBEHIND)
+			return 0;
+	}
 	return !(filter->reachable_from ||
 		 filter->unreachable_from ||
-		 format->bases.nr ||
 		 format->is_base_tips.nr);
 }
 
@@ -3647,7 +3663,6 @@ void ref_format_init(struct ref_format *format)
 
 void ref_format_clear(struct ref_format *format)
 {
-	string_list_clear(&format->bases, 0);
 	string_list_clear(&format->is_base_tips, 0);
 	ref_format_init(format);
 }
diff --git a/ref-filter.h b/ref-filter.h
index 754038ab07..d048317802 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -99,9 +99,6 @@ struct ref_format {
 	/* Internal state to ref-filter */
 	int need_color_reset_at_eol;
 
-	/* List of bases for ahead-behind counts. */
-	struct string_list bases;
-
 	/* List of bases for is-base indicators. */
 	struct string_list is_base_tips;
 
@@ -117,7 +114,6 @@ struct ref_format {
 }
 #define REF_FORMAT_INIT {             \
 	.use_color = -1,              \
-	.bases = STRING_LIST_INIT_DUP, \
 	.is_base_tips = STRING_LIST_INIT_DUP, \
 }
 

We should be able to do the same thing with is_base_tips, but I've left
it as an exercise for the reader. ;)

-Peff
