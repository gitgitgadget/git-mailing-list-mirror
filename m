Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9624BC432BE
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 09:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B2BC610CD
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 09:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239447AbhHYJJl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 05:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235904AbhHYJJl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 05:09:41 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB74C0613C1
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 02:08:55 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id h4so5107099wro.7
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 02:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fsaoL+6Pqer72FU5kYg8C0inGt5ue3iTSQcHJXS750k=;
        b=B2Df1t/ezfvYFigb5lz3CmwFAuI5XOJWM+JODXP8rvwCe70VTAXIR4vX2ki3niUyui
         ch7yiIjhFnbGhRYjxK2L1SXaVOxJgQqYOiZyPZCbcYNNbashwVFlCTc1ZlIt5uHMA8SL
         VV8sAZNo+WwFdh342M9Ge3hXlNCrT5DY46ao5c2UIDPGkaR0y9oPfpnPWHs6GB3NAxjY
         5MYaJV4bM6QuYLxSGH92e93iXvqDPOz2ujG8TefaBOqrb/73qKLUdkaQDrUTHuu6j03x
         +XlykNJWMhMXAWIqW7lobLsSVM8hbEExgCJaSYWWfZOLzGs9LgoGRqXGtLlvhoQ07DID
         AFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fsaoL+6Pqer72FU5kYg8C0inGt5ue3iTSQcHJXS750k=;
        b=HM/dnBDF7JAJvL5zozCTLe6WZPSabF1RRyZzC738PfNTnMJb+8aB9Wu9uu8EOl2/A2
         xeav3DJ1j3OyjV1ZSnmwcxP00NlOyQn7H5WlghmKb8774xQ48peep6aPr7SJPvlTDqn8
         94zXfYr7qDR1F7zG/gSafKs9mr40CDOsj1JpupjG21hv7sk0Nz3VBZi7V3YH67Lzjx2e
         JBkiLIPitoBuu0K8+R/Bqi92p79zPAluOACAEcHkLLvtLQyl7lNS0D0GM8Cgi7hNyGdB
         HljczvDsUUTzHBVblWNvaAynGIndwcePe7maxT9wpCu2g1d/KoAeNiZgisDSnlmnVrUc
         7jqQ==
X-Gm-Message-State: AOAM53354J0nf9Jk5TQHvQBExGLBBNVw9/V3ZdmKjmb6MeoLozHP1wfh
        GC2AR0IIbvddA+BvnAHS4UhXKvpBQpU=
X-Google-Smtp-Source: ABdhPJxAHMqywHqyHP1hdy5J4z/IBgwPUsDMXyy0p1JRFhdm4eZjl5IfqO+UyAYR0w+ym48/rnMLHA==
X-Received: by 2002:a5d:464c:: with SMTP id j12mr6737446wrs.27.1629882533975;
        Wed, 25 Aug 2021 02:08:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j7sm4715435wmi.37.2021.08.25.02.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 02:08:53 -0700 (PDT)
Message-Id: <e68635cda515a9cd504c1d7366e9c353ab2adb2e.1629882532.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1025.git.1629882532.gitgitgadget@gmail.com>
References: <pull.1025.git.1629882532.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 Aug 2021 09:08:45 +0000
Subject: [PATCH 1/8] [GSOC] ref-filter: use list api to replace ref_sorting
 linked list
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.email>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

struct ref_sorting is connected by the internal singly linked list,
it is very difficult to use, and each node is added by the head
insertion method but we can only traverse it forward.

Replace it with list api, which is easy to use and introduce a
free_ref_sorting_list() which can free all ref_sorting item and
solve the problem of memory leak.

This will help the logic of ref-filter become clearer.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 builtin/branch.c       | 20 +++++++++++---------
 builtin/for-each-ref.c | 15 ++++++++-------
 builtin/ls-remote.c    | 12 ++++++------
 builtin/tag.c          | 19 +++++++++++--------
 ref-filter.c           | 42 ++++++++++++++++++++++++++++--------------
 ref-filter.h           |  8 +++++---
 6 files changed, 69 insertions(+), 47 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index b23b1d1752a..72fafd301c5 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -77,7 +77,7 @@ define_list_config_array(color_branch_slots);
 static int git_branch_config(const char *var, const char *value, void *cb)
 {
 	const char *slot_name;
-	struct ref_sorting **sorting_tail = (struct ref_sorting **)cb;
+	struct ref_sorting *sorting_tail = (struct ref_sorting *)cb;
 
 	if (!strcmp(var, "branch.sort")) {
 		if (!value)
@@ -624,7 +624,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	enum branch_track track;
 	struct ref_filter filter;
 	int icase = 0;
-	static struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
+	struct ref_sorting sorting;
 	struct ref_format format = REF_FORMAT_INIT;
 
 	struct option options[] = {
@@ -665,7 +665,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_MERGED(&filter, N_("print only branches that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
 		OPT_COLUMN(0, "column", &colopts, N_("list branches in columns")),
-		OPT_REF_SORT(sorting_tail),
+		OPT_REF_SORT(&sorting),
 		OPT_CALLBACK(0, "points-at", &filter.points_at, N_("object"),
 			N_("print only branches of the object"), parse_opt_object_name),
 		OPT_BOOL('i', "ignore-case", &icase, N_("sorting and filtering are case insensitive")),
@@ -678,11 +678,12 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	memset(&filter, 0, sizeof(filter));
 	filter.kind = FILTER_REFS_BRANCHES;
 	filter.abbrev = -1;
+	INIT_LIST_HEAD(&sorting.list);
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(builtin_branch_usage, options);
 
-	git_config(git_branch_config, sorting_tail);
+	git_config(git_branch_config, &sorting);
 
 	track = git_branch_track;
 
@@ -748,12 +749,12 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		 * local branches 'refs/heads/...' and finally remote-tracking
 		 * branches 'refs/remotes/...'.
 		 */
-		if (!sorting)
-			sorting = ref_default_sorting();
-		ref_sorting_set_sort_flags_all(sorting, REF_SORTING_ICASE, icase);
+		if (list_empty(&sorting.list))
+			ref_default_sorting(&sorting);
+		ref_sorting_set_sort_flags_all(&sorting, REF_SORTING_ICASE, icase);
 		ref_sorting_set_sort_flags_all(
-			sorting, REF_SORTING_DETACHED_HEAD_FIRST, 1);
-		print_ref_list(&filter, sorting, &format);
+			&sorting, REF_SORTING_DETACHED_HEAD_FIRST, 1);
+		print_ref_list(&filter, &sorting, &format);
 		print_columns(&output, colopts, NULL);
 		string_list_clear(&output, 0);
 		return 0;
@@ -864,5 +865,6 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	} else
 		usage_with_options(builtin_branch_usage, options);
 
+	free_ref_sorting_list(&sorting);
 	return 0;
 }
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 89cb6307d46..3cd38eacd7c 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -17,7 +17,7 @@ static char const * const for_each_ref_usage[] = {
 int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 {
 	int i;
-	struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
+	struct ref_sorting sorting;
 	int maxcount = 0, icase = 0;
 	struct ref_array array;
 	struct ref_filter filter;
@@ -39,7 +39,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		OPT_INTEGER( 0 , "count", &maxcount, N_("show only <n> matched refs")),
 		OPT_STRING(  0 , "format", &format.format, N_("format"), N_("format to use for the output")),
 		OPT__COLOR(&format.use_color, N_("respect format colors")),
-		OPT_REF_SORT(sorting_tail),
+		OPT_REF_SORT(&sorting),
 		OPT_CALLBACK(0, "points-at", &filter.points_at,
 			     N_("object"), N_("print only refs which points at the given object"),
 			     parse_opt_object_name),
@@ -51,6 +51,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 
+	INIT_LIST_HEAD(&sorting.list);
 	memset(&array, 0, sizeof(array));
 	memset(&filter, 0, sizeof(filter));
 
@@ -70,15 +71,15 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	if (verify_ref_format(&format))
 		usage_with_options(for_each_ref_usage, opts);
 
-	if (!sorting)
-		sorting = ref_default_sorting();
-	ref_sorting_set_sort_flags_all(sorting, REF_SORTING_ICASE, icase);
+	if (list_empty(&sorting.list))
+		ref_default_sorting(&sorting);
+	ref_sorting_set_sort_flags_all(&sorting, REF_SORTING_ICASE, icase);
 	filter.ignore_case = icase;
 
 	filter.name_patterns = argv;
 	filter.match_as_path = 1;
 	filter_refs(&array, &filter, FILTER_REFS_ALL | FILTER_REFS_INCLUDE_BROKEN);
-	ref_array_sort(sorting, &array);
+	ref_array_sort(&sorting, &array);
 
 	if (!maxcount || array.nr < maxcount)
 		maxcount = array.nr;
@@ -96,6 +97,6 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	ref_array_clear(&array);
 	free_commit_list(filter.with_commit);
 	free_commit_list(filter.no_commit);
-	UNLEAK(sorting);
+	free_ref_sorting_list(&sorting);
 	return 0;
 }
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 1794548c711..717ecde03d1 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -54,7 +54,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	struct transport *transport;
 	const struct ref *ref;
 	struct ref_array ref_array;
-	static struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
+	static struct ref_sorting sorting;
 
 	struct option options[] = {
 		OPT__QUIET(&quiet, N_("do not print remote URL")),
@@ -68,7 +68,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 		OPT_BIT(0, "refs", &flags, N_("do not show peeled tags"), REF_NORMAL),
 		OPT_BOOL(0, "get-url", &get_url,
 			 N_("take url.<base>.insteadOf into account")),
-		OPT_REF_SORT(sorting_tail),
+		OPT_REF_SORT(&sorting),
 		OPT_SET_INT_F(0, "exit-code", &status,
 			      N_("exit with exit code 2 if no matching refs are found"),
 			      2, PARSE_OPT_NOCOMPLETE),
@@ -79,13 +79,12 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	};
 
 	memset(&ref_array, 0, sizeof(ref_array));
+	INIT_LIST_HEAD(&sorting.list);
 
 	argc = parse_options(argc, argv, prefix, options, ls_remote_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 	dest = argv[0];
 
-	UNLEAK(sorting);
-
 	if (argc > 1) {
 		int i;
 		CALLOC_ARRAY(pattern, argc);
@@ -137,8 +136,8 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 		item->symref = xstrdup_or_null(ref->symref);
 	}
 
-	if (sorting)
-		ref_array_sort(sorting, &ref_array);
+	if (!list_empty(&sorting.list))
+		ref_array_sort(&sorting, &ref_array);
 
 	for (i = 0; i < ref_array.nr; i++) {
 		const struct ref_array_item *ref = ref_array.items[i];
@@ -149,6 +148,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	}
 
 	ref_array_clear(&ref_array);
+	free_ref_sorting_list(&sorting);
 	if (transport_disconnect(transport))
 		return 1;
 	return status;
diff --git a/builtin/tag.c b/builtin/tag.c
index 452558ec957..9d057b214e2 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -178,7 +178,7 @@ static const char tag_template_nocleanup[] =
 static int git_tag_config(const char *var, const char *value, void *cb)
 {
 	int status;
-	struct ref_sorting **sorting_tail = (struct ref_sorting **)cb;
+	struct ref_sorting *sorting_tail = (struct ref_sorting *)cb;
 
 	if (!strcmp(var, "tag.gpgsign")) {
 		config_sign_tag = git_config_bool(var, value);
@@ -438,7 +438,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
 	struct ref_filter filter;
-	static struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
+	struct ref_sorting sorting;
 	struct ref_format format = REF_FORMAT_INIT;
 	int icase = 0;
 	int edit_flag = 0;
@@ -472,7 +472,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		OPT_WITHOUT(&filter.no_commit, N_("print only tags that don't contain the commit")),
 		OPT_MERGED(&filter, N_("print only tags that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only tags that are not merged")),
-		OPT_REF_SORT(sorting_tail),
+		OPT_REF_SORT(&sorting),
 		{
 			OPTION_CALLBACK, 0, "points-at", &filter.points_at, N_("object"),
 			N_("print only tags of the object"), PARSE_OPT_LASTARG_DEFAULT,
@@ -487,7 +487,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 
 	setup_ref_filter_porcelain_msg();
 
-	git_config(git_tag_config, sorting_tail);
+	INIT_LIST_HEAD(&sorting.list);
+	git_config(git_tag_config, &sorting);
 
 	memset(&opt, 0, sizeof(opt));
 	memset(&filter, 0, sizeof(filter));
@@ -526,9 +527,9 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 			die(_("--column and -n are incompatible"));
 		colopts = 0;
 	}
-	if (!sorting)
-		sorting = ref_default_sorting();
-	ref_sorting_set_sort_flags_all(sorting, REF_SORTING_ICASE, icase);
+	if (list_empty(&sorting.list))
+		ref_default_sorting(&sorting);
+	ref_sorting_set_sort_flags_all(&sorting, REF_SORTING_ICASE, icase);
 	filter.ignore_case = icase;
 	if (cmdmode == 'l') {
 		int ret;
@@ -539,11 +540,13 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 			run_column_filter(colopts, &copts);
 		}
 		filter.name_patterns = argv;
-		ret = list_tags(&filter, sorting, &format);
+		ret = list_tags(&filter, &sorting, &format);
 		if (column_active(colopts))
 			stop_column_filter();
 		return ret;
 	}
+	free_ref_sorting_list(&sorting);
+
 	if (filter.lines != -1)
 		die(_("-n option is only allowed in list mode"));
 	if (filter.with_commit)
diff --git a/ref-filter.c b/ref-filter.c
index 93ce2a6ef2e..e9e3841c326 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2534,14 +2534,16 @@ static int compare_refs(const void *a_, const void *b_, void *ref_sorting)
 {
 	struct ref_array_item *a = *((struct ref_array_item **)a_);
 	struct ref_array_item *b = *((struct ref_array_item **)b_);
-	struct ref_sorting *s;
+	struct ref_sorting *s = ref_sorting;
+	struct list_head *pos;
 
-	for (s = ref_sorting; s; s = s->next) {
-		int cmp = cmp_ref_sorting(s, a, b);
+	list_for_each_prev(pos, &s->list) {
+		int cmp = cmp_ref_sorting(list_entry(pos, struct ref_sorting, list),
+						     a, b);
 		if (cmp)
 			return cmp;
 	}
-	s = ref_sorting;
+
 	return s && s->sort_flags & REF_SORTING_ICASE ?
 		strcasecmp(a->refname, b->refname) :
 		strcmp(a->refname, b->refname);
@@ -2550,11 +2552,15 @@ static int compare_refs(const void *a_, const void *b_, void *ref_sorting)
 void ref_sorting_set_sort_flags_all(struct ref_sorting *sorting,
 				    unsigned int mask, int on)
 {
-	for (; sorting; sorting = sorting->next) {
+	struct list_head *pos;
+	struct ref_sorting *entry;
+
+	list_for_each(pos, &sorting->list) {
+		entry = list_entry(pos, struct ref_sorting, list);
 		if (on)
-			sorting->sort_flags |= mask;
+			entry->sort_flags |= mask;
 		else
-			sorting->sort_flags &= ~mask;
+			entry->sort_flags &= ~mask;
 	}
 }
 
@@ -2667,24 +2673,32 @@ static int parse_sorting_atom(const char *atom)
 }
 
 /*  If no sorting option is given, use refname to sort as default */
-struct ref_sorting *ref_default_sorting(void)
+void ref_default_sorting(struct ref_sorting *sorting_list)
 {
 	static const char cstr_name[] = "refname";
 
 	struct ref_sorting *sorting = xcalloc(1, sizeof(*sorting));
-
-	sorting->next = NULL;
+	list_add_tail(&sorting->list, &sorting_list->list);
 	sorting->atom = parse_sorting_atom(cstr_name);
-	return sorting;
 }
 
-void parse_ref_sorting(struct ref_sorting **sorting_tail, const char *arg)
+void free_ref_sorting_list(struct ref_sorting *sorting_list) {
+	struct list_head *pos, *tmp;
+	struct ref_sorting *item;
+
+	list_for_each_safe(pos, tmp, &sorting_list->list) {
+		item = list_entry(pos, struct ref_sorting, list);
+		list_del(pos);
+		free(item);
+	}
+}
+
+void parse_ref_sorting(struct ref_sorting *sorting_list, const char *arg)
 {
 	struct ref_sorting *s;
 
 	CALLOC_ARRAY(s, 1);
-	s->next = *sorting_tail;
-	*sorting_tail = s;
+	list_add_tail(&s->list, &sorting_list->list);
 
 	if (*arg == '-') {
 		s->sort_flags |= REF_SORTING_REVERSE;
diff --git a/ref-filter.h b/ref-filter.h
index c15dee8d6b9..a502c2758e9 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -26,7 +26,7 @@
 struct atom_value;
 
 struct ref_sorting {
-	struct ref_sorting *next;
+	struct list_head list;
 	int atom; /* index into used_atom array (internal) */
 	enum {
 		REF_SORTING_REVERSE = 1<<0,
@@ -123,11 +123,13 @@ int format_ref_array_item(struct ref_array_item *info,
 			  struct strbuf *final_buf,
 			  struct strbuf *error_buf);
 /*  Parse a single sort specifier and add it to the list */
-void parse_ref_sorting(struct ref_sorting **sorting_tail, const char *atom);
+void parse_ref_sorting(struct ref_sorting *sorting_list, const char *arg);
 /*  Callback function for parsing the sort option */
 int parse_opt_ref_sorting(const struct option *opt, const char *arg, int unset);
 /*  Default sort option based on refname */
-struct ref_sorting *ref_default_sorting(void);
+void ref_default_sorting(struct ref_sorting *sorting_list);
+/* Free all ref_sorting items in sorting list */
+void free_ref_sorting_list(struct ref_sorting *sorting_list);
 /*  Function to parse --merged and --no-merged options */
 int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset);
 /*  Get the current HEAD's description */
-- 
gitgitgadget

