Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0E5C6FD1D
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 13:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjCON02 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 09:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjCON00 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 09:26:26 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C4C7D87
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 06:26:19 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id ek18so44380823edb.6
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 06:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678886778;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yR+1H2JRNEqpoq1iT32wIj4ghYN6ZcRqspyjdNaWMSE=;
        b=pn7/1Ip4b49c3pALBDx+hO220AJNJPR+HXZ6rmkwtkTkA9e+tKfNBeUQw9ypB30kl2
         H4fPTYmgOa1MZcK57KufNe4MVHPbp/KzmaAstsj8qVLEcsTrx6Wrb9phnjN/1WGBSGkH
         kMFHptVWK6GOPBxQktZTYfTass3hWERHQwt2E1xox+Yn3YJve1t8UupQppOs2sFCGcNO
         SrzmUzZXkiMvuNH2Z0LPEDyP/qrReUylhiXTTzWVssvUR+WyH1bH05XZu76o6Yt+ND7O
         A0GYHKS1aGPZZkycy4QcDG3nsxTjmh5k2CEOjfg1NSVksLiABQ+FMcBAQswl8I/LPJ26
         dZjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678886778;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yR+1H2JRNEqpoq1iT32wIj4ghYN6ZcRqspyjdNaWMSE=;
        b=NG/DNesy9/0fVzGO3mdcuSgG2+V/R9iHTeYJ7kxEJnfOdS29VmxNyy7BpMLVc1jNES
         kBGKHkc0rCdYWFIAWEa58cPKGdLQwKHWB5elX7+3oD7PO/zM8ANcu1bngSd8r4N6EXce
         kjaVvuWIIYK0w2yahUmFAGwV3oH2IIkyr1HwkYjfaZq+AgK9VTtoeAiyExU8GS8xfC3l
         lAg3UQ2ayNTAeIlLh/M69AY3Tj2bHBMV78H3sRRAnq6ilzA7k0CbvI/TZsQ+pNN/ajl1
         hrLqxAmulK/BxUEWRTTDzwt8rdLZ20N0cgpCE/jp9B6Uvv+3+CY4xzpTpWdTVFKQHDbK
         MKdQ==
X-Gm-Message-State: AO0yUKUzgNQzKaMUEi+xVECKa1nQ1WB/+rGa7T1Cncr+duwersse3/k8
        /an77BMmuYVzAxfHTSspQDRuI91I0Qc=
X-Google-Smtp-Source: AK7set+p0twmM605y+pHc83ZZaP19Jw6rO4RuMXOmNti0tJt3L9vMLxP2XXrf9oBiWFf82UAaozwKA==
X-Received: by 2002:a05:6402:4cd:b0:4fd:2b05:aa2 with SMTP id n13-20020a05640204cd00b004fd2b050aa2mr2635293edw.42.1678886777705;
        Wed, 15 Mar 2023 06:26:17 -0700 (PDT)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id i19-20020a508713000000b004af62273b66sm2453710edb.18.2023.03.15.06.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 06:26:17 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pcR8y-002waM-1u;
        Wed, 15 Mar 2023 14:26:16 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        vdye@github.com, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 0/8] ref-filter: ahead/behind counting, faster
 --merged option
Date:   Wed, 15 Mar 2023 14:22:54 +0100
References: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
 <pull.1489.v2.git.1678468863.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <pull.1489.v2.git.1678468863.gitgitgadget@gmail.com>
Message-ID: <230315.86lejyxi13.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 10 2023, Derrick Stolee via GitGitGadget wrote:

> At $DAYJOB, we have used a custom 'ahead-behind' builtin in our fork of Git
> for lots of reasons. The main goal of the builtin is to compare multiple
> references against a common base reference. The comparison is number of
> commits that are in each side of the symmtric difference of their reachable
> sets. A commit C is "ahead" of a commit B by the number of commits in B..C
> (reachable from C but not reachable from B). Similarly, the commit C is
> "behind" the commit B by the number of commits in C..B (reachable from B but
> not reachable from C).

I have a local change to get rid of the various "the_repository" macros,
which a merge of this in "seen" conflicted with (semantically).

The below patch on top of "seen" will fix it, could you please squash it
in in the appropriate places?

Aside from a desire to get rid of "the_repository" macros this also
makes your own code consistent, i.e. you use repo_clear_commit_marks(),
but then use parse_commit() instead of the repo_parse_commit() in the
same function.

It also makes the new API more future-proof, I don't think we should be
adding new code that implicitly uses "the_repository" to our libraries
if we can help it, much better to pass it down, even if all the current
users are built-in that end up using "the_repository".

diff --git a/builtin/branch.c b/builtin/branch.c
index 21526d9883a..7c7dba839cf 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -448,7 +448,7 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 	if (verify_ref_format(format))
 		die(_("unable to parse format string"));
 
-	filter_ahead_behind(format, &array);
+	filter_ahead_behind(the_repository, format, &array);
 	ref_array_sort(sorting, &array);
 
 	for (i = 0; i < array.nr; i++) {
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 1cdf8eb5a6b..e097f44e226 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -102,7 +102,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 
 	filter.match_as_path = 1;
 	filter_refs(&array, &filter, FILTER_REFS_ALL);
-	filter_ahead_behind(&format, &array);
+	filter_ahead_behind(the_repository, &format, &array);
 
 	ref_array_sort(sorting, &array);
 
diff --git a/builtin/tag.c b/builtin/tag.c
index 8652d5edd47..7e2f686600a 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -67,7 +67,7 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting,
 		die(_("unable to parse format string"));
 	filter->with_commit_tag_algo = 1;
 	filter_refs(&array, filter, FILTER_REFS_TAGS);
-	filter_ahead_behind(format, &array);
+	filter_ahead_behind(the_repository, format, &array);
 	ref_array_sort(sorting, &array);
 
 	for (i = 0; i < array.nr; i++) {
diff --git a/commit-reach.c b/commit-reach.c
index 0abd43801fc..4a2216b8ae0 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -977,8 +977,9 @@ static void free_bit_array(struct commit *c)
 	*bitmap = NULL;
 }
 
-void ahead_behind(struct commit **commits, size_t commits_nr,
-		  struct ahead_behind_count *counts, size_t counts_nr)
+void ahead_behind(struct repository *r, struct commit **commits,
+		  size_t commits_nr, struct ahead_behind_count *counts,
+		  size_t counts_nr)
 {
 	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
 	size_t width = (commits_nr + BITS_IN_EWORD - 1) / BITS_IN_EWORD;
@@ -1024,7 +1025,7 @@ void ahead_behind(struct commit **commits, size_t commits_nr,
 		for (p = c->parents; p; p = p->next) {
 			struct bitmap *bitmap_p;
 
-			parse_commit(p->item);
+			repo_parse_commit(r, p->item);
 
 			bitmap_p = init_bit_array(p->item, width);
 			bitmap_or(bitmap_p, bitmap_c);
@@ -1039,7 +1040,7 @@ void ahead_behind(struct commit **commits, size_t commits_nr,
 	}
 
 	/* STALE is used here, PARENT2 is used by insert_no_dup(). */
-	repo_clear_commit_marks(the_repository, PARENT2 | STALE);
+	repo_clear_commit_marks(r, PARENT2 | STALE);
 	clear_bit_arrays(&bit_arrays);
 	clear_prio_queue(&queue);
 }
diff --git a/commit-reach.h b/commit-reach.h
index f871b5dcce9..2269fab8261 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -131,7 +131,8 @@ struct ahead_behind_count {
  * Given an array of commits and an array of ahead_behind_count pairs,
  * compute the ahead/behind counts for each pair.
  */
-void ahead_behind(struct commit **commits, size_t commits_nr,
-		  struct ahead_behind_count *counts, size_t counts_nr);
+void ahead_behind(struct repository *r, struct commit **commits,
+		  size_t commits_nr, struct ahead_behind_count *counts,
+		  size_t counts_nr);
 
 #endif
diff --git a/ref-filter.c b/ref-filter.c
index 4125ec3fd3a..cdc054beede 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2462,7 +2462,7 @@ static void reach_filter(struct ref_array *array,
 	free(to_clear);
 }
 
-void filter_ahead_behind(struct ref_format *format,
+void filter_ahead_behind(struct repository *r, struct ref_format *format,
 			 struct ref_array *array)
 {
 	struct commit **commits;
@@ -2502,7 +2502,7 @@ void filter_ahead_behind(struct ref_format *format,
 		commits_nr++;
 	}
 
-	ahead_behind(commits, commits_nr, array->counts, array->counts_nr);
+	ahead_behind(r, commits, commits_nr, array->counts, array->counts_nr);
 	free(commits);
 }
 
diff --git a/ref-filter.h b/ref-filter.h
index 7e8bff3864e..1a757b49233 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -163,7 +163,7 @@ struct ref_array_item *ref_array_push(struct ref_array *array,
  *
  * If this is not called, then any ahead-behind atoms will be blank.
  */
-void filter_ahead_behind(struct ref_format *format,
+void filter_ahead_behind(struct repository *r, struct ref_format *format,
 			 struct ref_array *array);
 
 #endif /*  REF_FILTER_H  */
