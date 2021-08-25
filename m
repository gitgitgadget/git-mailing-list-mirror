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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD9BC4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 09:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 103D361183
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 09:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239548AbhHYJJn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 05:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235904AbhHYJJm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 05:09:42 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0EDC061757
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 02:08:56 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id q11so8336774wrr.9
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 02:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XSBf/aAHXqJhg9StH69xfoXXIZ1sjrcbPQnVZ7UmDzA=;
        b=sfQq9b1Rx3ftLWOBKerEa6Fo6eGSPzHLKu2meyJAoMuBoFO5OIlyfZMxCDf2PhuAhZ
         Qm3e1g0zhSRgkQUSMir89HtCFMD5P4L3bBE6WSjvivvGCr7j0P2eA3KJNjcufIO4oeu9
         PwXBXrVY7drG4XpueWCatm1RZnsJTUnQ/NBFU1Ap1ZHQW51tKyNHx5GlIjs4EmJ4/+74
         uEpHG/a87b6ZaQ3uGwIblMBGXjXQ7mIaq4Avealuz6CiZe2Rdbq2fq0gcnIGqjmuxMpt
         lDvaT/DNrvq0xABbtDVtzt8CcR4zxhABjDvnxcMl/LFAosvxQn74Au7AGcZkrRalVcVN
         Bg1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XSBf/aAHXqJhg9StH69xfoXXIZ1sjrcbPQnVZ7UmDzA=;
        b=tAWLaqKf8reuvkcOosCqaqkuUEkxNKdaJVIIHp8WYjSFAcHpqY/d4rdtpdbxgwXeL/
         cBnc5HpoWolHs+coyueRpf4JB14BnN130ZTRrQyVG2XeuYgw632S2u3zu6CKtSBmB81W
         DPM5tDdYmsrCt1Zreo39r7haNOPe83r984LjHCXEuJFFiLvyE6eAP8u2MdhxI1xIyP7X
         FOUuoYTvOR0Bo3R78ULOKShXZihtW3kDCmIT5vIZYhYj7eINIKVIZ4tQw41NGXakE6vF
         jlWEC8/G80NzGk1jhxbMiOD/RuGXD/Kxy022m0PshsRCQg/Pag3vKmZqUxGyE4psFMWo
         l9nA==
X-Gm-Message-State: AOAM531e3L0O7DS8/v1jmgSutCHr+zfO6gLbbKgDQxbghTeaUsuqsJuS
        6YqJ/+MJEt3kX0M+1fm3y0xZdUru4Q0=
X-Google-Smtp-Source: ABdhPJx3c/2JtMicPRjcGemOqLw7Di4RRl8V3uOKqiuss+CdAENsJgvH4RP7DRVt9GyzR2Vp2ZKCEw==
X-Received: by 2002:a5d:508e:: with SMTP id a14mr24036494wrt.306.1629882535117;
        Wed, 25 Aug 2021 02:08:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f20sm523872wmb.32.2021.08.25.02.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 02:08:54 -0700 (PDT)
Message-Id: <48458437c4a6e0633643f383fb0bf14e710bc9a9.1629882532.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1025.git.1629882532.gitgitgadget@gmail.com>
References: <pull.1025.git.1629882532.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 Aug 2021 09:08:47 +0000
Subject: [PATCH 3/8] [GSOC] ref-filter: add ref_format to ref_array_item
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

Since we expect to move some global options to ref_format,
we may want check these global options in some functions
like populate_value(), but the problem is that these
functions cannot use ref_format, which means we may need
a deep call chain to pass ref_format to them, this will
be a bit cumbersome.

We can use another method: Add the ref_format member to
ref_array_item. Since we have successfully eliminated dummy
ref_format, this can ensure that the same ref_array can use
the same ref_format, so we pass ref_format through the call
chain when ref_array_item is initialized, we also add
ref_format member to ref_cbdata.

This will help us move the global options to ref_format later.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 builtin/branch.c       |  5 +++--
 builtin/for-each-ref.c |  4 ++--
 builtin/ls-remote.c    |  2 +-
 builtin/tag.c          |  4 ++--
 ref-filter.c           | 24 ++++++++++++++----------
 ref-filter.h           |  7 ++++---
 6 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 3b21c2b54b9..4c6e7ef5f10 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -427,7 +427,7 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 
 	memset(&array, 0, sizeof(array));
 
-	filter_refs(&array, filter, filter->kind | FILTER_REFS_INCLUDE_BROKEN);
+	filter_refs(&array, filter, format, filter->kind | FILTER_REFS_INCLUDE_BROKEN);
 
 	if (filter->verbose)
 		maxwidth = calc_maxwidth(&array, strlen(remote_prefix));
@@ -444,7 +444,8 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 	for (i = 0; i < array.nr; i++) {
 		strbuf_reset(&err);
 		strbuf_reset(&out);
-		if (format_ref_array_item(array.items[i], format, &out, &err))
+		array.items[i]->format = format;
+		if (format_ref_array_item(array.items[i], &out, &err))
 			die("%s", err.buf);
 		if (column_active(colopts)) {
 			assert(!filter->verbose && "--column and --verbose are incompatible");
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 8948b7bcd32..4a71caca929 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -79,7 +79,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 
 	filter.name_patterns = argv;
 	filter.match_as_path = 1;
-	filter_refs(&array, &filter, FILTER_REFS_ALL | FILTER_REFS_INCLUDE_BROKEN);
+	filter_refs(&array, &filter, &format, FILTER_REFS_ALL | FILTER_REFS_INCLUDE_BROKEN);
 	ref_array_sort(&sorting, &array);
 
 	if (!maxcount || array.nr < maxcount)
@@ -87,7 +87,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	for (i = 0; i < maxcount; i++) {
 		strbuf_reset(&err);
 		strbuf_reset(&output);
-		if (format_ref_array_item(array.items[i], &format, &output, &err))
+		if (format_ref_array_item(array.items[i], &output, &err))
 			die("%s", err.buf);
 		fwrite(output.buf, 1, output.len, stdout);
 		putchar('\n');
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 7fac069a29d..2dd19a8583d 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -133,7 +133,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 			continue;
 		if (!tail_match(pattern, ref->name))
 			continue;
-		item = ref_array_push(&ref_array, ref->name, &ref->old_oid);
+		item = ref_array_push(&ref_array, ref->name, &ref->old_oid, &dummy);
 		item->symref = xstrdup_or_null(ref->symref);
 	}
 
diff --git a/builtin/tag.c b/builtin/tag.c
index a0d4aa775e3..9a66c4d37a5 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -62,13 +62,13 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting,
 	if (verify_ref_format(format))
 		die(_("unable to parse format string"));
 	filter->with_commit_tag_algo = 1;
-	filter_refs(&array, filter, FILTER_REFS_TAGS);
+	filter_refs(&array, filter, format, FILTER_REFS_TAGS);
 	ref_array_sort(sorting, &array);
 
 	for (i = 0; i < array.nr; i++) {
 		strbuf_reset(&output);
 		strbuf_reset(&err);
-		if (format_ref_array_item(array.items[i], format, &output, &err))
+		if (format_ref_array_item(array.items[i], &output, &err))
 			die("%s", err.buf);
 		fwrite(output.buf, 1, output.len, stdout);
 		putchar('\n');
diff --git a/ref-filter.c b/ref-filter.c
index 88a3e06eea9..f4fa3102da6 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2167,22 +2167,24 @@ static const struct object_id *match_points_at(struct oid_array *points_at,
  * Callers can then fill in other struct members at their leisure.
  */
 static struct ref_array_item *new_ref_array_item(const char *refname,
-						 const struct object_id *oid)
+						 const struct object_id *oid,
+						 struct ref_format *format)
 {
 	struct ref_array_item *ref;
 
 	FLEX_ALLOC_STR(ref, refname, refname);
 	oidcpy(&ref->objectname, oid);
 	ref->rest = NULL;
-
+	ref->format = format;
 	return ref;
 }
 
 struct ref_array_item *ref_array_push(struct ref_array *array,
 				      const char *refname,
-				      const struct object_id *oid)
+				      const struct object_id *oid,
+				      struct ref_format *format)
 {
-	struct ref_array_item *ref = new_ref_array_item(refname, oid);
+	struct ref_array_item *ref = new_ref_array_item(refname, oid, format);
 
 	ALLOC_GROW(array->items, array->nr + 1, array->alloc);
 	array->items[array->nr++] = ref;
@@ -2226,6 +2228,7 @@ static int filter_ref_kind(struct ref_filter *filter, const char *refname)
 struct ref_filter_cbdata {
 	struct ref_array *array;
 	struct ref_filter *filter;
+	struct ref_format *format;
 	struct contains_cache contains_cache;
 	struct contains_cache no_contains_cache;
 };
@@ -2238,6 +2241,7 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 {
 	struct ref_filter_cbdata *ref_cbdata = cb_data;
 	struct ref_filter *filter = ref_cbdata->filter;
+	struct ref_format *format = ref_cbdata->format;
 	struct ref_array_item *ref;
 	struct commit *commit = NULL;
 	unsigned int kind;
@@ -2288,7 +2292,7 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 	 * to do its job and the resulting list may yet to be pruned
 	 * by maxcount logic.
 	 */
-	ref = ref_array_push(ref_cbdata->array, refname, oid);
+	ref = ref_array_push(ref_cbdata->array, refname, oid, format);
 	ref->commit = commit;
 	ref->flag = flag;
 	ref->kind = kind;
@@ -2401,7 +2405,7 @@ static void reach_filter(struct ref_array *array,
  * as per the given ref_filter structure and finally store the
  * filtered refs in the ref_array structure.
  */
-int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int type)
+int filter_refs(struct ref_array *array, struct ref_filter *filter, struct ref_format *format, unsigned int type)
 {
 	struct ref_filter_cbdata ref_cbdata;
 	int ret = 0;
@@ -2409,7 +2413,7 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
 
 	ref_cbdata.array = array;
 	ref_cbdata.filter = filter;
-
+	ref_cbdata.format = format;
 	if (type & FILTER_REFS_INCLUDE_BROKEN)
 		broken = 1;
 	filter->kind = type & FILTER_REFS_KIND_MASK;
@@ -2592,12 +2596,12 @@ static void append_literal(const char *cp, const char *ep, struct ref_formatting
 }
 
 int format_ref_array_item(struct ref_array_item *info,
-			  struct ref_format *format,
 			  struct strbuf *final_buf,
 			  struct strbuf *error_buf)
 {
 	const char *cp, *sp, *ep;
 	struct ref_formatting_state state = REF_FORMATTING_STATE_INIT;
+	struct ref_format *format = info->format;
 
 	state.quote_style = format->quote_style;
 	push_stack_element(&state.stack);
@@ -2644,9 +2648,9 @@ void pretty_print_ref(const char *name, const struct object_id *oid,
 	struct strbuf output = STRBUF_INIT;
 	struct strbuf err = STRBUF_INIT;
 
-	ref_item = new_ref_array_item(name, oid);
+	ref_item = new_ref_array_item(name, oid, format);
 	ref_item->kind = ref_kind_from_refname(name);
-	if (format_ref_array_item(ref_item, format, &output, &err))
+	if (format_ref_array_item(ref_item, &output, &err))
 		die("%s", err.buf);
 	fwrite(output.buf, 1, output.len, stdout);
 	putchar('\n');
diff --git a/ref-filter.h b/ref-filter.h
index 8f602583788..e95c055fb86 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -45,6 +45,7 @@ struct ref_array_item {
 	const char *symref;
 	struct commit *commit;
 	struct atom_value *value;
+	struct ref_format *format;
 	char refname[FLEX_ARRAY];
 };
 
@@ -109,7 +110,7 @@ struct ref_format {
  * as per the given ref_filter structure and finally store the
  * filtered refs in the ref_array structure.
  */
-int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int type);
+int filter_refs(struct ref_array *array, struct ref_filter *filter, struct ref_format *format, unsigned int type);
 /*  Clear all memory allocated to ref_array */
 void ref_array_clear(struct ref_array *array);
 /*  Used to verify if the given format is correct and to parse out the used atoms */
@@ -120,7 +121,6 @@ void ref_array_sort(struct ref_sorting *sort, struct ref_array *array);
 void ref_sorting_set_sort_flags_all(struct ref_sorting *sorting, unsigned int mask, int on);
 /*  Based on the given format and quote_style, fill the strbuf */
 int format_ref_array_item(struct ref_array_item *info,
-			  struct ref_format *format,
 			  struct strbuf *final_buf,
 			  struct strbuf *error_buf);
 /*  Parse a single sort specifier and add it to the list */
@@ -153,6 +153,7 @@ void pretty_print_ref(const char *name, const struct object_id *oid,
  */
 struct ref_array_item *ref_array_push(struct ref_array *array,
 				      const char *refname,
-				      const struct object_id *oid);
+				      const struct object_id *oid,
+				      struct ref_format *format);
 
 #endif /*  REF_FILTER_H  */
-- 
gitgitgadget

