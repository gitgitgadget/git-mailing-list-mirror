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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685D1C4320A
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 09:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 432EE61184
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 09:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239535AbhHYJJm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 05:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233248AbhHYJJl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 05:09:41 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7508C061757
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 02:08:55 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id m2so2876859wmm.0
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 02:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LjDYR1w4qdTIxeiUaAfZyvattLGrRqdvJL2R4qwJoiU=;
        b=q23b35qGhjxB//++6OjOcd7wyencxiYuJlIQ0ICZknT5c10IIHnVVlqXIfAak7Qir2
         gORg4E1H5qc+iNvue/k9No/nn4YGmojpCsi1TKXrNeM5nfAPtHDs14MrUjVNuzT5SUm3
         If93/w0cOUBaGZM7prfK3OloeQaBaSKC2VxygKfzelnJCte1P5tCP7ofB7LSlsjEdmbL
         wSn6cacGedwzdc2tnofNxt4Xfa4UjRUqgMCpT+5pgn6g4EZyASVw2I4YNyVmsh5oHB9Y
         2ThOI/LGw2P+lAwBUjXfMjTr6TtnqzLBDxwJG76NmqHv0pHA71JgmyXxbPwi2KTAbwpf
         2HJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LjDYR1w4qdTIxeiUaAfZyvattLGrRqdvJL2R4qwJoiU=;
        b=SZNcfc0BXM7gTrtg2wBtv/rGT9ZdBTxxaRi27zM/9GtPoNY//V3aJIrSAtOJzL/bFg
         dLNNxZlyAMHghazRrmiC1hPwSyngku3LLKbTO37DEPgtQCg5D4QRNRanGaJtnPxvqwRI
         RcsGEAs3ag2hnCe9pkuL+sMGGIMOnZCdecCWY3YAg3ZxOOdXsUeMkTVXKQrqdHJ+EY+W
         UQc7aEbxz+wVcA0KNXpES3XQ+8AFuYVWNtT318KElMjSV1w6YDXijYQrd9Aq8LoqCN2r
         IlSIvgL6oGcpsoywm7NhoM5tcvIj/ZUVDyRriHaPfR4l5OIo0kUgzVgUDOrOPLf2Cq5e
         NBbQ==
X-Gm-Message-State: AOAM5321CBC7A5HFNKYS9aiC0HVj2yKPnEFL98S8vmvzrBScKWbaJWa7
        IMRRDAtvn35vr2rMRzXzlmBFF2Qz7B8=
X-Google-Smtp-Source: ABdhPJz4YvhGKE2quZ8dHw0Wi6eQefXWmHMKVItnqU7S2lWXKeWtAkg5Bp8zpnGXaHX1xOtLs/EdxA==
X-Received: by 2002:a1c:2209:: with SMTP id i9mr1389115wmi.92.1629882534580;
        Wed, 25 Aug 2021 02:08:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v5sm20921101wru.37.2021.08.25.02.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 02:08:54 -0700 (PDT)
Message-Id: <97d4a0b3793240b1bd5e3bed5318611064d9ccb7.1629882532.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1025.git.1629882532.gitgitgadget@gmail.com>
References: <pull.1025.git.1629882532.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 Aug 2021 09:08:46 +0000
Subject: [PATCH 2/8] [GSOC] ref-filter: let parse_sorting_atom() use real
 ref_format
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

parse_sorting_atom() currently uses a "dummy" ref_format, because
it doesn't care about the details of real ref_format. But in fact,
we expect to save some state in ref_format, and we need to check
these statuses when executing some functions, e.g. in
verify_ref_format() we check format->quote_style and
format->need_color_reset_at_eol. And we intentionally want some
global options (e.g. need_tagged) to be added to struct ref_format,
so we need to care about ref_format details now, but the "dummy"
ref_format prevents the truly ref_format to record them correctly.

So let parse_sorting_atom() use the real ref_format, this requires us
to separate the work of parsing the sort atom from parse_ref_sorting().
Add an "arg" member to struct ref_sorting to record the name of the
sort atom, and parse_ref_sorting() only records the atom name, and
introduce a parse_ref_sorting_list() to traverse the ref_sorting
linked list and parsing each sort atom.

This will help us add some global options to struct ref_format later.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 builtin/branch.c       |  1 +
 builtin/for-each-ref.c |  1 +
 builtin/ls-remote.c    |  6 ++++--
 builtin/tag.c          |  1 +
 ref-filter.c           | 25 ++++++++++++++-----------
 ref-filter.h           |  3 +++
 6 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 72fafd301c5..3b21c2b54b9 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -751,6 +751,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		 */
 		if (list_empty(&sorting.list))
 			ref_default_sorting(&sorting);
+		parse_ref_sorting_list(&sorting, &format);
 		ref_sorting_set_sort_flags_all(&sorting, REF_SORTING_ICASE, icase);
 		ref_sorting_set_sort_flags_all(
 			&sorting, REF_SORTING_DETACHED_HEAD_FIRST, 1);
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 3cd38eacd7c..8948b7bcd32 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -73,6 +73,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 
 	if (list_empty(&sorting.list))
 		ref_default_sorting(&sorting);
+	parse_ref_sorting_list(&sorting, &format);
 	ref_sorting_set_sort_flags_all(&sorting, REF_SORTING_ICASE, icase);
 	filter.ignore_case = icase;
 
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 717ecde03d1..7fac069a29d 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -49,6 +49,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 		TRANSPORT_LS_REFS_OPTIONS_INIT;
 	int i;
 	struct string_list server_options = STRING_LIST_INIT_DUP;
+	struct ref_format dummy = REF_FORMAT_INIT;
 
 	struct remote *remote;
 	struct transport *transport;
@@ -136,9 +137,10 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 		item->symref = xstrdup_or_null(ref->symref);
 	}
 
-	if (!list_empty(&sorting.list))
+	if (!list_empty(&sorting.list)) {
+		parse_ref_sorting_list(&sorting, &dummy);
 		ref_array_sort(&sorting, &ref_array);
-
+	}
 	for (i = 0; i < ref_array.nr; i++) {
 		const struct ref_array_item *ref = ref_array.items[i];
 		if (show_symref_target && ref->symref)
diff --git a/builtin/tag.c b/builtin/tag.c
index 9d057b214e2..a0d4aa775e3 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -529,6 +529,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	}
 	if (list_empty(&sorting.list))
 		ref_default_sorting(&sorting);
+	parse_ref_sorting_list(&sorting, &format);
 	ref_sorting_set_sort_flags_all(&sorting, REF_SORTING_ICASE, icase);
 	filter.ignore_case = icase;
 	if (cmdmode == 'l') {
diff --git a/ref-filter.c b/ref-filter.c
index e9e3841c326..88a3e06eea9 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2656,30 +2656,33 @@ void pretty_print_ref(const char *name, const struct object_id *oid,
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
 
+void parse_ref_sorting_list(struct ref_sorting *sorting_list, struct ref_format *format) {
+	struct list_head *pos;
+	struct ref_sorting *entry;
+
+	list_for_each(pos, &sorting_list->list) {
+		entry = list_entry(pos, struct ref_sorting, list);
+		entry->atom = parse_sorting_atom(format, entry->arg);
+	}
+}
+
 /*  If no sorting option is given, use refname to sort as default */
 void ref_default_sorting(struct ref_sorting *sorting_list)
 {
-	static const char cstr_name[] = "refname";
-
 	struct ref_sorting *sorting = xcalloc(1, sizeof(*sorting));
 	list_add_tail(&sorting->list, &sorting_list->list);
-	sorting->atom = parse_sorting_atom(cstr_name);
+	sorting->arg = "refname";
 }
 
 void free_ref_sorting_list(struct ref_sorting *sorting_list) {
@@ -2707,7 +2710,7 @@ void parse_ref_sorting(struct ref_sorting *sorting_list, const char *arg)
 	if (skip_prefix(arg, "version:", &arg) ||
 	    skip_prefix(arg, "v:", &arg))
 		s->sort_flags |= REF_SORTING_VERSION;
-	s->atom = parse_sorting_atom(arg);
+	s->arg = arg;
 }
 
 int parse_opt_ref_sorting(const struct option *opt, const char *arg, int unset)
diff --git a/ref-filter.h b/ref-filter.h
index a502c2758e9..8f602583788 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -28,6 +28,7 @@ struct atom_value;
 struct ref_sorting {
 	struct list_head list;
 	int atom; /* index into used_atom array (internal) */
+	const char *arg;
 	enum {
 		REF_SORTING_REVERSE = 1<<0,
 		REF_SORTING_ICASE = 1<<1,
@@ -128,6 +129,8 @@ void parse_ref_sorting(struct ref_sorting *sorting_list, const char *arg);
 int parse_opt_ref_sorting(const struct option *opt, const char *arg, int unset);
 /*  Default sort option based on refname */
 void ref_default_sorting(struct ref_sorting *sorting_list);
+/* Parse every sort atom of ref_sorting list */
+void parse_ref_sorting_list(struct ref_sorting *sorting_list, struct ref_format *format);
 /* Free all ref_sorting items in sorting list */
 void free_ref_sorting_list(struct ref_sorting *sorting_list);
 /*  Function to parse --merged and --no-merged options */
-- 
gitgitgadget

