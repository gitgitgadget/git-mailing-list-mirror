Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F009CC4338F
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 13:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D21D660F94
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 13:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238890AbhG3NdS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 09:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239000AbhG3NdR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 09:33:17 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CE6C06175F
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 06:33:09 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id d6so5569479edt.7
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 06:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=8v6SS2mlnMeZ36xfPT557YyLQVhM8L+MTtD5uGXC3+M=;
        b=WigMzLic8C3dUYdVeCQdeM03Bi03S3mAKg7JtKJu9ofijyBf6CUTlOHuEW5eYdCtDp
         95dlS0mxpEzKK6cbUQqzFouIWPCWy5BFn7L9q7JNNDW0VDxaR5ZvH5Mea1DzEL9MDy5D
         xD2UmCWknohctRcILjyq0Nyni/ItFPYx49fUUAt9L/0ffbmLIm8aDT6eziISfKaQBqV7
         UG+ijtS2MPURorJHBclChRab+y1+ACMzYVDIRQ77aq0TYNutioqYl09YJ2z4oJNex6/R
         EdVdtt4qznC9Ahuqvn9mwM7DN+D0sj8dbeiIDqWygLHfqXhOdKppbx1uvW2yRjxZzps9
         Z33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=8v6SS2mlnMeZ36xfPT557YyLQVhM8L+MTtD5uGXC3+M=;
        b=Dpt2VAZTjLZyg0KEU3qdFWuszZ8XzIiyl9VMY5roBHAqIXaC4HQEwOar8omJGi/Fmh
         fAPtgZR3fjaJvtGgXnQdrNooADrVCMZq8UJ4KsMim2heZH0Hf7q6TA6ZxVOncenymxj+
         Z9+sTwZzAJV98MyEL8MeXq/w72XN6n7qsBQHJm1q1MMB6WKs70+omQj0+23x5SvQLhfL
         wj1kb3iDmytalZ1fK8OMl4yXR4A3IaJI0iTeD+xp93Cj/z2E1oNKXOp9k+RoIP2NnrZP
         2CcaHiiaC15xiUbuyh44mzUJ39DmYqqyA77/YcTjF0rNA0ku4tpfFJAGOnUJffT2YC8b
         VwqQ==
X-Gm-Message-State: AOAM5306yFvljjiFuh4waNQ9gI9blRCr32nfGxTNX8mAfVijS/dhVdTU
        v3ll5R9Za0cGdye0Kl930iA=
X-Google-Smtp-Source: ABdhPJxI5QzzO0YR9qOYySdTJWNHIFO//XnvY31Nl/z6YFY2E97hBbfb4BAlZlE/2NcXimT2aWtlsQ==
X-Received: by 2002:a05:6402:4d1:: with SMTP id n17mr2938328edw.337.1627651988242;
        Fri, 30 Jul 2021 06:33:08 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id p23sm720667edw.94.2021.07.30.06.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 06:33:07 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren <newren@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 4/7] merge-ort: switch our strmaps over to using
 memory pools
Date:   Fri, 30 Jul 2021 15:30:07 +0200
References: <pull.990.git.1627044897.gitgitgadget@gmail.com>
 <pull.990.v2.git.1627531121.gitgitgadget@gmail.com>
 <dd8839b284330892a3bbcafbc03d71489fc9b01f.1627531121.git.gitgitgadget@gmail.com>
 <YQLJOsvATnTBd9pB@coredump.intra.peff.net>
 <CABPp-BHzJ365Jed38s-VQb2PqRy7t=58sZwgmeVG=mqKeA2neg@mail.gmail.com>
 <YQMLBW6LAZmQ8nDz@coredump.intra.peff.net>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YQMLBW6LAZmQ8nDz@coredump.intra.peff.net>
Message-ID: <87bl6kq631.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 29 2021, Jeff King wrote:

> On Thu, Jul 29, 2021 at 12:37:52PM -0600, Elijah Newren wrote:
>
>> > Arguably, the existence of these function indirections is perhaps a sign
>> > that the strmap API should provide a version of the clear functions that
>> > takes "partial / not-partial" as a parameter.
>> 
>> Are you suggesting a modification of str{map,intmap,set}_clear() to
>> take an extra parameter, or removing the
>> str{map,intmap,set}_partial_clear() functions and introducing new
>> functions that take a partial/not-partial parameter?  I think you're
>> suggesting the latter, and that makes more sense to me...but I'm
>> drawing blanks trying to come up with a reasonable function name.
>
> It does seem a shame to add the "partial" parameter to strmap_clear(),
> just because most callers don't need it (so they end up with this
> inscrutable "0" parameter).
>
> What if there was a flags field? Then it could be combined with the
> free_values parameter. The result is kind of verbose in two ways:
>
>  - now strset_clear(), etc, need a "flags" parameter, which they didn't
>    before (and is just "0" most of the time!)
>
>  - now "strmap_clear(foo, 1)" becomes "strmap_clear(foo, STRMAP_FREE_VALUES)".
>    That's a lot longer, though arguably it's easier to understand since
>    the boolean is explained.
>
> Having gone through the exercise, I am not sure it is actually making
> anything more readable (messy patch is below for reference).

I've got some WIP patches for string-list.h and strmap.h to make the API
nicer, and it's probably applicable to strset.h too.

I.e. I found when using strset.h that it was a weird API to use, because
unlike string-list.h it didn't pay attention to your "dup" field when
freeing, you had to do it explicitly.

And then in e.g. merge-ort.c there's this "strdup dance" pattern where
we flip the field back and forth.

The below diff is exctracted from that WIP work, with the relevant two
API headers and then two changed API users for show (the tree-wide
changes are much larger).

I think making the promise I make in the updated docs at "We guarantee
that the `clearfunc`[...]" in string-list.h makes for particularly nice
API behavior.

 builtin/remote.c | 37 ++++++++++++++++++++---------------
 merge-ort.c      | 32 +++++++-----------------------
 string-list.h    | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 strmap.h         | 13 +++++++++++++
 4 files changed, 98 insertions(+), 43 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 7f88e6ce9de..ec1dbd49f71 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -340,10 +340,24 @@ static void read_branches(void)
 
 struct ref_states {
 	struct remote *remote;
-	struct string_list new_refs, stale, tracked, heads, push;
+
+	struct string_list new_refs;
+	struct string_list stale;
+	struct string_list tracked;
+	struct string_list heads;
+	struct string_list push;
+
 	int queried;
 };
 
+#define REF_STATES_INIT { \
+	.new_refs = STRING_LIST_INIT_DUP, \
+	.stale = STRING_LIST_INIT_DUP, \
+	.tracked = STRING_LIST_INIT_DUP, \
+	.heads = STRING_LIST_INIT_DUP, \
+	.push = STRING_LIST_INIT_DUP, \
+}
+
 static int get_ref_states(const struct ref *remote_refs, struct ref_states *states)
 {
 	struct ref *fetch_map = NULL, **tail = &fetch_map;
@@ -355,9 +369,6 @@ static int get_ref_states(const struct ref *remote_refs, struct ref_states *stat
 			die(_("Could not get fetch map for refspec %s"),
 				states->remote->fetch.raw[i]);
 
-	states->new_refs.strdup_strings = 1;
-	states->tracked.strdup_strings = 1;
-	states->stale.strdup_strings = 1;
 	for (ref = fetch_map; ref; ref = ref->next) {
 		if (!ref->peer_ref || !ref_exists(ref->peer_ref->name))
 			string_list_append(&states->new_refs, abbrev_branch(ref->name));
@@ -406,7 +417,6 @@ static int get_push_ref_states(const struct ref *remote_refs,
 
 	match_push_refs(local_refs, &push_map, &remote->push, MATCH_REFS_NONE);
 
-	states->push.strdup_strings = 1;
 	for (ref = push_map; ref; ref = ref->next) {
 		struct string_list_item *item;
 		struct push_info *info;
@@ -449,7 +459,6 @@ static int get_push_ref_states_noquery(struct ref_states *states)
 	if (remote->mirror)
 		return 0;
 
-	states->push.strdup_strings = 1;
 	if (!remote->push.nr) {
 		item = string_list_append(&states->push, _("(matching)"));
 		info = item->util = xcalloc(1, sizeof(struct push_info));
@@ -483,7 +492,6 @@ static int get_head_names(const struct ref *remote_refs, struct ref_states *stat
 	refspec.force = 0;
 	refspec.pattern = 1;
 	refspec.src = refspec.dst = "refs/heads/*";
-	states->heads.strdup_strings = 1;
 	get_fetch_map(remote_refs, &refspec, &fetch_map_tail, 0);
 	matches = guess_remote_head(find_ref_by_name(remote_refs, "HEAD"),
 				    fetch_map, 1);
@@ -905,7 +913,7 @@ static void clear_push_info(void *util, const char *string)
 {
 	struct push_info *info = util;
 	free(info->dest);
-	free(info);
+	/* note: fixed memleak here */
 }
 
 static void free_remote_ref_states(struct ref_states *states)
@@ -1159,7 +1167,7 @@ static int get_one_entry(struct remote *remote, void *priv)
 		string_list_append(list, remote->name)->util =
 				strbuf_detach(&url_buf, NULL);
 	} else
-		string_list_append(list, remote->name)->util = NULL;
+		string_list_append(list, remote->name);
 	if (remote->pushurl_nr) {
 		url = remote->pushurl;
 		url_nr = remote->pushurl_nr;
@@ -1179,10 +1187,9 @@ static int get_one_entry(struct remote *remote, void *priv)
 
 static int show_all(void)
 {
-	struct string_list list = STRING_LIST_INIT_NODUP;
+	struct string_list list = STRING_LIST_INIT_DUP;
 	int result;
 
-	list.strdup_strings = 1;
 	result = for_each_remote(get_one_entry, &list);
 
 	if (!result) {
@@ -1212,7 +1219,7 @@ static int show(int argc, const char **argv)
 		OPT_BOOL('n', NULL, &no_query, N_("do not query remotes")),
 		OPT_END()
 	};
-	struct ref_states states;
+	struct ref_states states = REF_STATES_INIT;
 	struct string_list info_list = STRING_LIST_INIT_NODUP;
 	struct show_info info;
 
@@ -1334,8 +1341,7 @@ static int set_head(int argc, const char **argv)
 	if (!opt_a && !opt_d && argc == 2) {
 		head_name = xstrdup(argv[1]);
 	} else if (opt_a && !opt_d && argc == 1) {
-		struct ref_states states;
-		memset(&states, 0, sizeof(states));
+		struct ref_states states = REF_STATES_INIT;
 		get_remote_ref_states(argv[0], &states, GET_HEAD_NAMES);
 		if (!states.heads.nr)
 			result |= error(_("Cannot determine remote HEAD"));
@@ -1374,14 +1380,13 @@ static int set_head(int argc, const char **argv)
 static int prune_remote(const char *remote, int dry_run)
 {
 	int result = 0;
-	struct ref_states states;
+	struct ref_states states = REF_STATES_INIT;
 	struct string_list refs_to_prune = STRING_LIST_INIT_NODUP;
 	struct string_list_item *item;
 	const char *dangling_msg = dry_run
 		? _(" %s will become dangling!")
 		: _(" %s has become dangling!");
 
-	memset(&states, 0, sizeof(states));
 	get_remote_ref_states(remote, &states, GET_REF_STATES);
 
 	if (!states.stale.nr) {
diff --git a/merge-ort.c b/merge-ort.c
index ec0c5904211..53ed78e7a01 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -432,16 +432,6 @@ struct conflict_info {
 	assert((ci) && !(mi)->clean);        \
 } while (0)
 
-static void free_strmap_strings(struct strmap *map)
-{
-	struct hashmap_iter iter;
-	struct strmap_entry *entry;
-
-	strmap_for_each_entry(map, &iter, entry) {
-		free((char*)entry->key);
-	}
-}
-
 static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 					  int reinitialize)
 {
@@ -455,13 +445,11 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 		reinitialize ? strset_partial_clear : strset_clear;
 
 	/*
-	 * We marked opti->paths with strdup_strings = 0, so that we
-	 * wouldn't have to make another copy of the fullpath created by
-	 * make_traverse_path from setup_path_info().  But, now that we've
-	 * used it and have no other references to these strings, it is time
-	 * to deallocate them.
+	 * We used the the pattern of re-using already allocated
+	 * strings strmap_clear_strings() in make_traverse_path from
+	 * setup_path_info(). Deallocate them.
 	 */
-	free_strmap_strings(&opti->paths);
+	strmap_clear_strings(&opti->paths, 0);
 	strmap_func(&opti->paths, 1);
 
 	/*
@@ -472,15 +460,10 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 	strmap_func(&opti->conflicted, 0);
 
 	/*
-	 * opti->paths_to_free is similar to opti->paths; we created it with
-	 * strdup_strings = 0 to avoid making _another_ copy of the fullpath
-	 * but now that we've used it and have no other references to these
-	 * strings, it is time to deallocate them.  We do so by temporarily
-	 * setting strdup_strings to 1.
+	 * opti->paths_to_free is similar to opti->paths; it's memory
+	 * we borrowed and need to free with string_list_clear_strings().
 	 */
-	opti->paths_to_free.strdup_strings = 1;
-	string_list_clear(&opti->paths_to_free, 0);
-	opti->paths_to_free.strdup_strings = 0;
+	string_list_clear_strings(&opti->paths_to_free, 0);
 
 	if (opti->attr_index.cache_nr) /* true iff opt->renormalize */
 		discard_index(&opti->attr_index);
@@ -2664,7 +2647,6 @@ static int collect_renames(struct merge_options *opt,
 	 * and have no other references to these strings, it is time to
 	 * deallocate them.
 	 */
-	free_strmap_strings(&collisions);
 	strmap_clear(&collisions, 1);
 	return clean;
 }
diff --git a/string-list.h b/string-list.h
index 0d6b4692396..9eeea996888 100644
--- a/string-list.h
+++ b/string-list.h
@@ -109,6 +109,9 @@ void string_list_init_dup(struct string_list *list);
  */
 void string_list_init(struct string_list *list, int strdup_strings);
 
+void string_list_cmp_init(struct string_list *list, int strdup_strings,
+			  compare_strings_fn cmp);
+
 /** Callback function type for for_each_string_list */
 typedef int (*string_list_each_func_t)(struct string_list_item *, void *);
 
@@ -129,14 +132,66 @@ void filter_string_list(struct string_list *list, int free_util,
  */
 void string_list_clear(struct string_list *list, int free_util);
 
+/**
+ * Free a string list initialized without `strdup_strings = 1`, but
+ * where we also want to free() the strings. You usually want to just
+ * use string_list_clear() after initializing with
+ * `STRING_LIST_INIT_DUP' instead.
+ *
+ * Useful to free e.g. a string list whose strings came from
+ * strbuf_detach() or other memory that we didn't initially allocate
+ * on the heap, but which we now manage.
+ *
+ * Under the hood this is identical in behavior to temporarily setting
+ * `strbuf_strings` to `1` for the duration of this function call, but
+ * without the verbosity of performing that dance yourself.
+ */
+void string_list_clear_strings(struct string_list *list, int free_util);
+
+/**
+ * Clear only the `util` pointer, but not the `string`, even if
+ * `strdup_strings = 1` is set. Useful for the idiom of doing e.g.:
+ *
+ *    string_list_append(&list, str + offs)->util = str;
+ *
+ * Where we add a string at some offset, own the string (so
+ * effectively `strdup_strings = `), but can't free() the string
+ * itself at the changed offset, but need to free the original data in
+ * `util` instead.
+ */
+void string_list_clear_util(struct string_list *list);
+
 /**
  * Callback type for `string_list_clear_func`.  The string associated
  * with the util pointer is passed as the second argument
  */
 typedef void (*string_list_clear_func_t)(void *p, const char *str);
 
-/** Call a custom clear function on each util pointer */
-void string_list_clear_func(struct string_list *list, string_list_clear_func_t clearfunc);
+/**
+ * Like string_list_clear() except that it first calls a custom clear
+ * function on each util pointer.
+ *
+ * We guarantee that the `clearfunc` will be called on all util
+ * pointers in a list before we proceed to free the first string or
+ * util pointer, i.e. should you need to it's OK to peek at other util
+ * items in the list itself, or to otherwise iterate it from within
+ * the `clearfunc`.
+ *
+ * You do not need to free() the passed-in util pointer itself,
+ * i.e. after calling all `clearfunc` this has the seme behavior as
+ * string_list_clear() called with with `free_util = 1`.
+ */
+void string_list_clear_func(struct string_list *list,
+			    string_list_clear_func_t clearfunc);
+
+/**
+ * Like string_list_clear_func() but free the strings too, using the
+ * same dance as described for string_list_clear_strings()
+ * above. You'll usually want to initialize with
+ * `STRING_LIST_INIT_DUP` and use string_list_clear_strings() instead.
+ */
+void string_list_clear_strings_func(struct string_list *list,
+				    string_list_clear_func_t clearfunc);
 
 /**
  * Apply `func` to each item. If `func` returns nonzero, the
diff --git a/strmap.h b/strmap.h
index 1e152d832d6..337f6278e86 100644
--- a/strmap.h
+++ b/strmap.h
@@ -51,12 +51,25 @@ void strmap_init_with_options(struct strmap *map,
  */
 void strmap_clear(struct strmap *map, int free_values);
 
+/**
+ * To strmap_clear() what string_list_clear_strings() is to
+ * string_list_clear(). I.e. free your keys too, which we used as-is
+ * without `strdup_strings = 1`.
+ */
+void strmap_clear_strings(struct strmap *map, int free_values);
+
 /*
  * Similar to strmap_clear() but leaves map->map->table allocated and
  * pre-sized so that subsequent uses won't need as many rehashings.
  */
 void strmap_partial_clear(struct strmap *map, int free_values);
 
+/**
+ * To strmap_partial_clear() what string_list_clear_strings() is to
+ * string_list_clear(). See strmap_clear_strings() above.
+ */
+void strmap_partial_clear_strings(struct strmap *map, int free_values);
+
 /*
  * Insert "str" into the map, pointing to "data".
  *
