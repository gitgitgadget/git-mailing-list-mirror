Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B60C4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 08:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6AF4610CC
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 08:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238535AbhHMIYL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 04:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238817AbhHMIXy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 04:23:54 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F77BC0612A9
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 01:23:26 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id h24-20020a1ccc180000b029022e0571d1a0so6365080wmb.5
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 01:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QSepH9LUA1lxdb6GQVSFkbpmiFYQKBWi3we7F+hr07Q=;
        b=qgENPGWN/TZIq4Y3YDQnmmsk4TUdquOZSNaCOCE0STaSwxQBX6XlsFcqLxwwpkY9Nq
         orrHCfNz5Y9JidReBMnGBZ9m1jPD3l77h6T8KkgNcWo2qJcw/HDvSdLF0jhRa3/K6Yco
         RBPgs7uTsU+7QhwA21q1UcOcuK3wy+nabMmc/acWQsj4yJCyFaGomHEUE4Z/qSYgdh/K
         SVrhDgOabuldnQeq4ywetJ4ClAGSjZpLHrOMiFbiHo2egWWCGAmpFjgE8GNEEaiGsIOf
         xXtfuDhq5KHFAhZMzhfRGskX0oyb907fzJ9LPF4hJrQfIK4iqxGcb0LD07Yq63xdPLtR
         TDlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QSepH9LUA1lxdb6GQVSFkbpmiFYQKBWi3we7F+hr07Q=;
        b=dTpCZqwZdQW03DwpiFOB6rsCScAl8LUo32bGJU1La6SoUbwpDAXjJgetlKXCfegtFA
         OfdCBJo6ENtQ0s7jF9wQWa4jgrBqQ9ozM35pXFLlhk6h3Sipcm8YhQhmso3RKw9E6l8n
         r1DkALapf+ovx2rdcbSv2KmgpMLMD1Nlz70hvwr8pDMZoahJB6JqxGbNA2PaBzELc8X0
         tGeFHeJ1ChG/PWQXJ4aobiYzHrCvQ6CHe6Sj6ZVbPqS57DYhL29CcjIFNUhpf8Ho8CvQ
         xbtv0vkba/RptScmhmxBjPQk5Ic4GrmCj0ylcf27CQrVb7jv2M5BemKnhsjxmh6adof1
         NZJw==
X-Gm-Message-State: AOAM533VawnO3bZCKBoGldTGQjPC1zXu+vW+qLGH80uv2zRd1uAR+FFV
        +U+yp654j1zkgPufzSyq3aczZwIEiwY=
X-Google-Smtp-Source: ABdhPJyIrv45TnZoaKKot21QdCOsNgR3IVSY93ZvWe6qY8k1cgMCqtjgMOKPL67wVBI6bJQqVjyytA==
X-Received: by 2002:a05:600c:225a:: with SMTP id a26mr1446739wmm.189.1628843004917;
        Fri, 13 Aug 2021 01:23:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c10sm738301wml.44.2021.08.13.01.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 01:23:24 -0700 (PDT)
Message-Id: <31acac9fde7d7239303255ccee2a3f066b2b5f6b.1628842990.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1016.git.1628842990.gitgitgadget@gmail.com>
References: <pull.1016.git.1628842990.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Aug 2021 08:23:04 +0000
Subject: [PATCH 21/27] [GSOC] ref-filter: remove second parsing in
 format_ref_array_item
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

We parsed format string in verify_ref_format() and stored the parsed
atom in used_atom array. But in format_ref_array_item() we have
another round of parsing format string. This affects performance.

Introducing the struct parsed_atom_list which can save the current
atom's start and end address in format string and its index in
used_atom. All parsed_atom_list entry are linked together in the
form of linked list, and the head node of the linked list is stored
in struct ref_format. We can use clear_parsed_atom_list() to clear
the nodes on the linked list.

This can bring 1.9% performance improvement for git cat-file --batch.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 builtin/branch.c       |  2 ++
 builtin/cat-file.c     |  3 +++
 builtin/for-each-ref.c |  3 ++-
 builtin/tag.c          |  2 ++
 builtin/verify-tag.c   |  2 ++
 ref-filter.c           | 45 +++++++++++++++++++++++++++++++++---------
 ref-filter.h           | 11 +++++++++++
 7 files changed, 58 insertions(+), 10 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index b23b1d1752a..e361f8cc661 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -459,6 +459,7 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 	strbuf_release(&err);
 	strbuf_release(&out);
 	ref_array_clear(&array);
+	clear_parsed_atom_list(&format->parsed_atom_head);
 	free(to_free);
 }
 
@@ -678,6 +679,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	memset(&filter, 0, sizeof(filter));
 	filter.kind = FILTER_REFS_BRANCHES;
 	filter.abbrev = -1;
+	INIT_LIST_HEAD(&format.parsed_atom_head);
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(builtin_branch_usage, options);
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 77b470687e1..7205b21fb29 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -421,6 +421,7 @@ static int batch_objects(struct batch_options *batch, const struct option *optio
 		strbuf_release(&output);
 		free_global_resource();
 		strbuf_release(&err);
+		clear_parsed_atom_list(&batch->format.parsed_atom_head);
 		return 0;
 	}
 
@@ -457,6 +458,7 @@ static int batch_objects(struct batch_options *batch, const struct option *optio
 	strbuf_release(&output);
 	free_global_resource();
 	strbuf_release(&err);
+	clear_parsed_atom_list(&batch->format.parsed_atom_head);
 	warn_on_object_refname_ambiguity = save_warning;
 	return retval;
 }
@@ -534,6 +536,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 
 	batch.buffer_output = -1;
 	batch.format.cat_file_mode = 1;
+	INIT_LIST_HEAD(&batch.format.parsed_atom_head);
 	argc = parse_options(argc, argv, prefix, options, cat_file_usage, 0);
 
 	if (opt) {
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 89cb6307d46..6e22d80d5b5 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -53,8 +53,8 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 
 	memset(&array, 0, sizeof(array));
 	memset(&filter, 0, sizeof(filter));
-
 	format.format = "%(objectname) %(objecttype)\t%(refname)";
+	INIT_LIST_HEAD(&format.parsed_atom_head);
 
 	git_config(git_default_config, NULL);
 
@@ -96,6 +96,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	ref_array_clear(&array);
 	free_commit_list(filter.with_commit);
 	free_commit_list(filter.no_commit);
+	clear_parsed_atom_list(&format.parsed_atom_head);
 	UNLEAK(sorting);
 	return 0;
 }
diff --git a/builtin/tag.c b/builtin/tag.c
index 452558ec957..549339cbbe4 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -78,6 +78,7 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting,
 	strbuf_release(&output);
 	ref_array_clear(&array);
 	free(to_free);
+	clear_parsed_atom_list(&format->parsed_atom_head);
 
 	return 0;
 }
@@ -493,6 +494,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	memset(&filter, 0, sizeof(filter));
 	filter.lines = -1;
 	opt.sign = -1;
+	INIT_LIST_HEAD(&format.parsed_atom_head);
 
 	argc = parse_options(argc, argv, prefix, options, git_tag_usage, 0);
 
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index f45136a06ba..8b0a2b2587c 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -39,6 +39,7 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
+	INIT_LIST_HEAD(&format.parsed_atom_head);
 	git_config(git_verify_tag_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, verify_tag_options,
@@ -73,5 +74,6 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 		if (format.format)
 			pretty_print_ref(name, &oid, &format);
 	}
+	clear_parsed_atom_list(&format.parsed_atom_head);
 	return had_error;
 }
diff --git a/ref-filter.c b/ref-filter.c
index 6e904389d6b..771804c06f0 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1051,6 +1051,7 @@ int verify_ref_format(struct ref_format *format)
 	for (cp = format->format; *cp && (sp = find_next(cp)); ) {
 		struct strbuf err = STRBUF_INIT;
 		const char *color, *ep = strchr(sp, ')');
+		struct parsed_atom_list *e;
 		int at;
 
 		if (!ep)
@@ -1059,6 +1060,12 @@ int verify_ref_format(struct ref_format *format)
 		at = parse_ref_filter_atom(format, sp + 2, ep, &err);
 		if (at < 0)
 			die("%s", err.buf);
+		e = xmalloc(sizeof(*e));
+		e->beg = sp + 2;
+		e->end = ep;
+		e->at = at;
+		list_add_tail(&e->list, &format->parsed_atom_head);
+
 		if (need_parse_buffer(used_atom[at].atom_type))
 			format->can_skip_parse_buffer = 0;
 		if (reject_atom(format->cat_file_mode, used_atom[at].atom_type))
@@ -2649,26 +2656,32 @@ int format_ref_array_item(struct ref_array_item *info,
 			  struct strbuf *final_buf,
 			  struct strbuf *error_buf)
 {
-	const char *cp, *sp, *ep;
+	const char *cp, *sp;
+	struct list_head *item;
 	struct ref_formatting_state state = REF_FORMATTING_STATE_INIT;
 	int ret;
 
 	state.quote_style = format->quote_style;
 	push_stack_element(&state.stack);
 	info->can_skip_parse_buffer = format->can_skip_parse_buffer;
-	for (cp = format->format; *cp && (sp = find_next(cp)); cp = ep + 1) {
+
+	cp = format->format;
+
+	list_for_each(item, &format->parsed_atom_head) {
 		struct atom_value *atomv;
-		int pos;
+		struct parsed_atom_list *e =
+			list_entry(item, struct parsed_atom_list, list);
 
-		ep = strchr(sp, ')');
-		if (cp < sp)
-			append_literal(cp, sp, &state);
-		pos = parse_ref_filter_atom(format, sp + 2, ep, error_buf);
-		if (pos < 0 || (ret = get_ref_atom_value(info, pos, &atomv, error_buf)) ||
+		if (cp < e->beg - 2)
+			append_literal(cp, e->beg - 2, &state);
+		if ((ret = get_ref_atom_value(info, e->at, &atomv, error_buf)) ||
 		    atomv->handler(atomv, &state, error_buf)) {
 			pop_stack_element(&state.stack);
 			return ret ? ret : -1;
 		}
+		cp = e->end + 1;
+		if (!*cp)
+			break;
 	}
 	if (*cp) {
 		sp = cp + strlen(cp);
@@ -2716,10 +2729,12 @@ static int parse_sorting_atom(const char *atom)
 	 * This parses an atom using a dummy ref_format, since we don't
 	 * actually care about the formatting details.
 	 */
+	int res;
 	struct ref_format dummy = REF_FORMAT_INIT;
 	const char *end = atom + strlen(atom);
 	struct strbuf err = STRBUF_INIT;
-	int res = parse_ref_filter_atom(&dummy, atom, end, &err);
+
+	res = parse_ref_filter_atom(&dummy, atom, end, &err);
 	if (res < 0)
 		die("%s", err.buf);
 	strbuf_release(&err);
@@ -2792,3 +2807,15 @@ int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset)
 
 	return 0;
 }
+
+void clear_parsed_atom_list(struct list_head *parsed_atom_head)
+{
+	struct list_head *pos, *tmp;
+	struct parsed_atom_list *item;
+
+	list_for_each_safe(pos, tmp, parsed_atom_head) {
+		item = list_entry(pos, struct parsed_atom_list, list);
+		list_del(pos);
+		free(item);
+	}
+}
diff --git a/ref-filter.h b/ref-filter.h
index 8cae9f576d5..2b871f9ed4f 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -73,6 +73,13 @@ struct ref_filter {
 		verbose;
 };
 
+struct parsed_atom_list {
+	const char *beg;
+	const char *end;
+	int at;
+	struct list_head list;
+};
+
 struct ref_format {
 	/*
 	 * Set these to define the format; make sure you call
@@ -87,6 +94,7 @@ struct ref_format {
 	int can_skip_parse_buffer;
 	/* Internal state to ref-filter */
 	int need_color_reset_at_eol;
+	struct list_head parsed_atom_head;
 };
 
 #define REF_FORMAT_INIT { .use_color = -1, .can_skip_parse_buffer = 1 }
@@ -118,6 +126,9 @@ void ref_array_clear(struct ref_array *array);
 void free_global_resource(void);
 /* Free ref_array_item's value */
 void free_ref_array_item_value(struct ref_array_item *item);
+/* Clear the parsed_atom_list in ref_format*/
+void clear_parsed_atom_list(struct list_head *parsed_atom_head);
+
 /*  Used to verify if the given format is correct and to parse out the used atoms */
 int verify_ref_format(struct ref_format *format);
 /*  Sort the given ref_array as per the ref_sorting provided */
-- 
gitgitgadget

