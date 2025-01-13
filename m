Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2162A1487FE
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 05:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736745432; cv=none; b=k+XkeAIyVJpM0tiyFvxGILgADFTXXw63t/HVXnoxG4LRFCEzpEmGYD0TK597K9zVBleSvb8ICA8SGyoocIPQVISI9dhwy+t8+4B9+mLMTZ8YWJTuJMqDWZeUCrKKMiI6hj+wTEAH92UqA/lWkTJnUHG6svuTjIpR8RYPSFqHDRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736745432; c=relaxed/simple;
	bh=qVOKzAvUHuOnvxZ5lZunWQhqHFYNzil1ndpExyDH7+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CjZWiwNKmr8PlLw+IcCJgmb4zg4yxR9sCBFDGsz9kWf9NgwVrtWDhG5yM2tkzk22/mg2zYxVkj9evQ0J0nCMcIoA0SCxkHX5lSYrlYd7hlwjUZ+rqAw2Iyr9vUJjuORX+yv1/3TNdP0N/8wIFBaqmp55MOVmnUfTwWljm40L/ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Rph7xPAx; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Rph7xPAx"
Received: (qmail 11452 invoked by uid 109); 13 Jan 2025 05:17:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=qVOKzAvUHuOnvxZ5lZunWQhqHFYNzil1ndpExyDH7+s=; b=Rph7xPAxe3vyEbpbC4a79ZGmIUh3BGBZe9DsoyruC9sejyZedtQ9tq2KDEN7RNDKfHQKdIFMJRhF+f5Wi8MLo4cZ4TzYXv1bIXaRsWlL+IZAsj8HqB7IrS2cYkEcLmiceyCwnZbfnDFG5pvpw0+58Wd2vSLKGP1fWlwM/dh6COmcCTDDPeVWODilIbrb23zzZnu3Mmaq9g/mM5i0R4ixskRpMsuGBqY5S98iE0l+TR2j42jiFSbX9/LaSR0HTssEcFoAW+vF4Epx+/S0tBxjj1Zor33YLAQkw4pMlbchs1p/ailBxz9rHxB7t9HJ0NEAwAnENA+1lpuvpNZ9w+HMEw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 13 Jan 2025 05:17:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16813 invoked by uid 111); 13 Jan 2025 05:17:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 13 Jan 2025 00:17:05 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 13 Jan 2025 00:17:00 -0500
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Ross Goldberg <ross.goldberg@gmail.com>, git@vger.kernel.org,
	Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] ref-filter: share bases and is_base_tips between
 formatting and sorting
Message-ID: <20250113051700.GA767856@coredump.intra.peff.net>
References: <CAAEcvMovcZucuq4H70ouQzKS=_wHnBi1DqJ-4MMFVXX9XLEciw@mail.gmail.com>
 <6b824f05-6f16-4cd9-85b7-3b8b236158b4@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6b824f05-6f16-4cd9-85b7-3b8b236158b4@web.de>

On Sun, Jan 12, 2025 at 11:01:52AM +0100, René Scharfe wrote:

> verify_ref_format() parses a ref-filter format string and stores
> recognized items in the static array "used_atom".  For
> "ahead-behind:<committish>" and "is-base:<committish>" it stores the
> committish part in string_lists that are part of struct ref_format.
> 
> ref_sorting_options() also parses bare ref-filter format items and also
> stores recognized ones in "used_atom".  The committish parts go to a
> dummy struct ref_format in parse_sorting_atom(), though, and are leaked
> and forgotten.
>
> If verify_ref_format() is called before ref_sorting_options(), like in
> git for-each-ref, then all works well if the sort key is included in the
> format string.  If it isn't then sorting cannot work as the committishes
> are missing.
>
> If ref_sorting_options() is called first, like in git branch, then we
> have the additional issue that if the sort key is included in the format
> string then filter_ahead_behind() and filter_is_base() can't see their
> committishes, will not generate any results for them and thus they will
> for expanded to empty strings.

Good analysis. The sorting and formatting are definitely tied in subtle
ways, and not all code takes that into account.

The dummy ref_format here is one such problem. Another is that we don't
do the equivalent of verify_ref_format() on the sorting fields. Most of
what it does is probably superfluous, but for example it's supposed to
reject some atoms that have parsers. So:

  $ git for-each-ref --format='%(rest)'
  fatal: this command reject atom %(rest)

but:

  $ git for-each-ref --sort=rest
  [...no error...]

That's somewhat orthogonal, but it may influence the direction of our
solution.

> Fix those issues by making the string_lists static, like their sibling
> "used_atom".  This way they can all be shared for handling both
> ref-filter format strings and sorting options in the same command.
> And since struct ref_format no longer contains any allocated members,
> remove the now unnecessary ref_format_init() and ref_format_clear().

Hmm. So this certainly fixes the problem. But is it where we want to go
in the long run?

For now there is no program that uses more than one ref-filter format.
But it seems like an obvious interface that would want to be lib-ified
eventually. We are not there yet because of the static global used_atoms
array. But the obvious path forward is to have a context struct
representing one ref-filter iteration.

I think the intent was that ref_format would be that context struct,
though arguably it is a little funny since it forces the sorting and
formatting to be joined (OTOH, that is very much how the code works,
since it wants to share results between the two for efficiency).

So one solution would be to make the use of that context struct more
explicit, and require ref_sorting callers to provide a format struct.
Like the patch below, which also passes your tests.

I dunno. Your patch is deleting more code, which is nice. But I think in
the long run we'd end up replacing it. But maybe making a clean slate
now would make that easier? I could go either way.

---
 builtin/branch.c       |  2 +-
 builtin/for-each-ref.c |  2 +-
 builtin/ls-remote.c    |  4 +++-
 builtin/tag.c          |  2 +-
 ref-filter.c           | 19 ++++++++-----------
 ref-filter.h           |  2 +-
 6 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 6e7b0cfddb..0c3f35cd0a 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -875,7 +875,7 @@ int cmd_branch(int argc,
 		 * local branches 'refs/heads/...' and finally remote-tracking
 		 * branches 'refs/remotes/...'.
 		 */
-		sorting = ref_sorting_options(&sorting_options);
+		sorting = ref_sorting_options(&sorting_options, &format);
 		ref_sorting_set_sort_flags_all(sorting, REF_SORTING_ICASE, icase);
 		ref_sorting_set_sort_flags_all(
 			sorting, REF_SORTING_DETACHED_HEAD_FIRST, 1);
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 715745a262..4f247efe57 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -80,7 +80,7 @@ int cmd_for_each_ref(int argc,
 	if (verify_ref_format(&format))
 		usage_with_options(for_each_ref_usage, opts);
 
-	sorting = ref_sorting_options(&sorting_options);
+	sorting = ref_sorting_options(&sorting_options, &format);
 	ref_sorting_set_sort_flags_all(sorting, REF_SORTING_ICASE, icase);
 	filter.ignore_case = icase;
 
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 42f34e1236..ed38b82346 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -61,6 +61,7 @@ int cmd_ls_remote(int argc,
 	const struct ref *ref;
 	struct ref_array ref_array;
 	struct ref_sorting *sorting;
+	struct ref_format format = REF_FORMAT_INIT;
 	struct string_list sorting_options = STRING_LIST_INIT_DUP;
 
 	struct option options[] = {
@@ -155,7 +156,7 @@ int cmd_ls_remote(int argc,
 		item->symref = xstrdup_or_null(ref->symref);
 	}
 
-	sorting = ref_sorting_options(&sorting_options);
+	sorting = ref_sorting_options(&sorting_options, &format);
 	ref_array_sort(sorting, &ref_array);
 
 	for (i = 0; i < ref_array.nr; i++) {
@@ -173,6 +174,7 @@ int cmd_ls_remote(int argc,
 		status = 1;
 	transport_ls_refs_options_release(&transport_options);
 
+	ref_format_clear(&format);
 	strvec_clear(&pattern);
 	string_list_clear(&server_options, 0);
 	return status;
diff --git a/builtin/tag.c b/builtin/tag.c
index c4bd145831..a5240f66e2 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -574,7 +574,7 @@ int cmd_tag(int argc,
 			die(_("options '%s' and '%s' cannot be used together"), "--column", "-n");
 		colopts = 0;
 	}
-	sorting = ref_sorting_options(&sorting_options);
+	sorting = ref_sorting_options(&sorting_options, &format);
 	ref_sorting_set_sort_flags_all(sorting, REF_SORTING_ICASE, icase);
 	filter.ignore_case = icase;
 	if (cmdmode == 'l') {
diff --git a/ref-filter.c b/ref-filter.c
index 23054694c2..f5d0c448ed 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -3536,23 +3536,19 @@ void pretty_print_ref(const char *name, const struct object_id *oid,
 	free_array_item(ref_item);
 }
 
-static int parse_sorting_atom(const char *atom)
+static int parse_sorting_atom(struct ref_format *format, const char *atom)
 {
-	/*
-	 * This parses an atom using a dummy ref_format, since we don't
-	 * actually care about the formatting details.
-	 */
-	struct ref_format dummy = REF_FORMAT_INIT;
 	const char *end = atom + strlen(atom);
 	struct strbuf err = STRBUF_INIT;
-	int res = parse_ref_filter_atom(&dummy, atom, end, &err);
+	int res = parse_ref_filter_atom(format, atom, end, &err);
 	if (res < 0)
 		die("%s", err.buf);
 	strbuf_release(&err);
 	return res;
 }
 
-static void parse_ref_sorting(struct ref_sorting **sorting_tail, const char *arg)
+static void parse_ref_sorting(struct ref_format *format,
+			      struct ref_sorting **sorting_tail, const char *arg)
 {
 	struct ref_sorting *s;
 
@@ -3567,17 +3563,18 @@ static void parse_ref_sorting(struct ref_sorting **sorting_tail, const char *arg
 	if (skip_prefix(arg, "version:", &arg) ||
 	    skip_prefix(arg, "v:", &arg))
 		s->sort_flags |= REF_SORTING_VERSION;
-	s->atom = parse_sorting_atom(arg);
+	s->atom = parse_sorting_atom(format, arg);
 }
 
-struct ref_sorting *ref_sorting_options(struct string_list *options)
+struct ref_sorting *ref_sorting_options(struct string_list *options,
+					struct ref_format *format)
 {
 	struct string_list_item *item;
 	struct ref_sorting *sorting = NULL, **tail = &sorting;
 
 	if (options->nr) {
 		for_each_string_list_item(item, options)
-			parse_ref_sorting(tail, item->string);
+			parse_ref_sorting(format, tail, item->string);
 	}
 
 	/*
diff --git a/ref-filter.h b/ref-filter.h
index 754038ab07..1531bf1762 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -168,7 +168,7 @@ int format_ref_array_item(struct ref_array_item *info,
 /* Release a "struct ref_sorting" */
 void ref_sorting_release(struct ref_sorting *);
 /*  Convert list of sort options into ref_sorting */
-struct ref_sorting *ref_sorting_options(struct string_list *);
+struct ref_sorting *ref_sorting_options(struct string_list *, struct ref_format *);
 /*  Function to parse --merged and --no-merged options */
 int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset);
 /*  Get the current HEAD's description */
