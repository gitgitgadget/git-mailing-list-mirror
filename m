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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1CEC4320E
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 07:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D211600D3
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 07:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbhHQHP3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 03:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234275AbhHQHP0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 03:15:26 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68544C0613CF
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 00:14:53 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r6so27111870wrt.4
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 00:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=woILMgSiLm64c3txo/J9qWJxAkBA+I43w0V+oZzWMng=;
        b=iIvE9YUVCUmXBfzQRbheWcbMQXL1cs8WE0YIdpHneTazDCkFqZj3GCkK01W0PPQqom
         CE1aMjgsOxS11OGHbuMiYuzXGCEuaOtLMEsxtxzJy18fffP6Uy5Cd+3l1ECer+Ii+FwT
         J0RRJTm7PVHTMJ+nsy5f3N2mCv0LQG9iuvK33cjKi8Efv1PHHQbvS/jOGaOV2a7DKYTD
         jD5L7dyYg7FNCw5xYUFDpbBKIfVCEToveWAYjS+ewG/oi1xIz7U4mYrpoZj7WgxO+e2x
         AyNK596gJNQtdfeogJvEoht9v/ERBrXwrmMRH9lEaJKn7supPUdJCgwJIus/LuqVMtTD
         7QCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=woILMgSiLm64c3txo/J9qWJxAkBA+I43w0V+oZzWMng=;
        b=C4mYgokVyvQJwSGWZGlEL7pSttylBqdGWq/plPFR6zIPzsJtXoCO+PZYL1RE4DdC9a
         tENa3qEWO2HRctU2voUDAMK7fD4beJ78NbGM8ecf2J9+oMrM4SZXBX4TM7GkHBGymXzh
         twvGBV/uOB1FIAl3/Ab8kVWffqdhVqcjY7Qpu2EUr4WgKzPPi1UMe4LeqTTPg6qOPmG6
         S6yKldsehgCoSBnxmEmG9B9Atl6xyPzWH5J4XsuOBRZUB96Kwbbw5qXcG//kgb6NVBci
         A2Tc53fvUcfOQD4/SSl3hJiKtpNcRuj0HnZjnp/nsKp9FGcRtY5XhvyPNVZGEXgeK01l
         UAnQ==
X-Gm-Message-State: AOAM533qSqRA4swgXZc4S8YUjw/vmEIYf/WAI/VmoyrMmFWpTGQEfkqL
        xjXBlBUNtbtICo1AFWVYFC4SRGhQI+o=
X-Google-Smtp-Source: ABdhPJwBH1wW6ulsuloM82xmE9bedPRaqwfpzNdXd95JsfTTWwomRyWWNiGGyP07bqnL0Wruywzr5Q==
X-Received: by 2002:a5d:4e0d:: with SMTP id p13mr2171470wrt.274.1629184491842;
        Tue, 17 Aug 2021 00:14:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a9sm1342555wrv.37.2021.08.17.00.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 00:14:51 -0700 (PDT)
Message-Id: <ce7f5329560a8ec29630e03e91b9f630d71a8391.1629184489.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1020.git.1629184489.gitgitgadget@gmail.com>
References: <pull.1020.git.1629184489.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Aug 2021 07:14:46 +0000
Subject: [PATCH 2/5] [GSOC] ref-filter: remove second parsing in
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
in struct ref_format. Create clear_parsed_atom_list() which can used
to clear the nodes on the linked list.

This can bring performance improvement.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 builtin/branch.c       |  2 ++
 builtin/for-each-ref.c |  3 ++-
 builtin/tag.c          |  2 ++
 builtin/verify-tag.c   |  2 ++
 ref-filter.c           | 45 +++++++++++++++++++++++++++++++++---------
 ref-filter.h           | 11 +++++++++++
 6 files changed, 55 insertions(+), 10 deletions(-)

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
index 65ba00633dc..76a31fb79b1 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1035,6 +1035,7 @@ int verify_ref_format(struct ref_format *format)
 	for (cp = format->format; *cp && (sp = find_next(cp)); ) {
 		struct strbuf err = STRBUF_INIT;
 		const char *color, *ep = strchr(sp, ')');
+		struct parsed_atom_list *e;
 		int at;
 
 		if (!ep)
@@ -1043,6 +1044,12 @@ int verify_ref_format(struct ref_format *format)
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
 		if (reject_atom(used_atom[at].atom_type))
@@ -2615,25 +2622,31 @@ int format_ref_array_item(struct ref_array_item *info,
 			  struct strbuf *final_buf,
 			  struct strbuf *error_buf)
 {
-	const char *cp, *sp, *ep;
+	const char *cp, *sp;
+	struct list_head *item;
 	struct ref_formatting_state state = REF_FORMATTING_STATE_INIT;
 
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
-		if (pos < 0 || get_ref_atom_value(info, pos, &atomv, error_buf) ||
+		if (cp < e->beg - 2)
+			append_literal(cp, e->beg - 2, &state);
+		if (get_ref_atom_value(info, e->at, &atomv, error_buf) ||
 		    atomv->handler(atomv, &state, error_buf)) {
 			pop_stack_element(&state.stack);
 			return -1;
 		}
+		cp = e->end + 1;
+		if (!*cp)
+			break;
 	}
 	if (*cp) {
 		sp = cp + strlen(cp);
@@ -2681,10 +2694,12 @@ static int parse_sorting_atom(const char *atom)
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
@@ -2757,3 +2772,15 @@ int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset)
 
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
index 5bceae1dac9..df54836a643 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -72,6 +72,13 @@ struct ref_filter {
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
@@ -85,6 +92,7 @@ struct ref_format {
 	int can_skip_parse_buffer;
 	/* Internal state to ref-filter */
 	int need_color_reset_at_eol;
+	struct list_head parsed_atom_head;
 };
 
 #define REF_FORMAT_INIT { .use_color = -1, .can_skip_parse_buffer = 1 }
@@ -112,6 +120,9 @@ struct ref_format {
 int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int type);
 /*  Clear all memory allocated to ref_array */
 void ref_array_clear(struct ref_array *array);
+/* Clear the parsed_atom_list in ref_format*/
+void clear_parsed_atom_list(struct list_head *parsed_atom_head);
+
 /*  Used to verify if the given format is correct and to parse out the used atoms */
 int verify_ref_format(struct ref_format *format);
 /*  Sort the given ref_array as per the ref_sorting provided */
-- 
gitgitgadget

