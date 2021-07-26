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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7089EC4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 03:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40C5D60F02
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 03:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbhGZCqg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Jul 2021 22:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbhGZCq1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jul 2021 22:46:27 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B74C061757
        for <git@vger.kernel.org>; Sun, 25 Jul 2021 20:26:56 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id b9so8508917wrx.12
        for <git@vger.kernel.org>; Sun, 25 Jul 2021 20:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Vezs4xT1ETCWct8/IDaeJ+FFZp+VkcOQO3uAoqrt5u8=;
        b=Vgcp+/6BdD2k2PCYAF9Y27YdB/2HgrqZNHiNDAghLzPahtNHYSdjKenr8y7qXJM8Zr
         tohsUG9IzpIVzQhl8Xgh2kxb7tyS3o5y6S7PmgEsS1650pqDkidJ4m4C35vboP5rQ+sW
         pBsrQB4dYpi8dqh2qIlsKm+JjYMly2aboU6gLqKIy4OOzQgybnpMV2Fhuecv7z5JfqPX
         awj3MdBd4I+rnHZUyxGpxJdnKQbsiQNm3gO/MWnC5ZmWfLL2XK2k+fL2NGog6i01t7qR
         L/4v2xH5hTpMcg1qYJmhic9lwT4DL40fZy1yZsay0GKPc5+NkUGeqM12eCF3dogwOtQB
         H0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Vezs4xT1ETCWct8/IDaeJ+FFZp+VkcOQO3uAoqrt5u8=;
        b=GDl1JwDIP0+bIFnBhUbby4RdIgOkGCYg/Xbzlq13Bjxt9Ny8wK43BZcQW9n/hfOEN5
         g4LRLAYFXcdnJgfBgFsA1waN2yU0cTI2RA4nbaMatXKShSGB8tTbzBm33lMIiEOQ/xQ/
         TemTMfg7OvIhviGeKePvV47xN8cSya9WZWFmrp++VMxg9gbLMZBSoh+sio2NWUV9eftj
         uBAgZph3T9X0UUmpu1AgCrfZCmKiXX0mS4OIJunnN5sjvbSg2bTaUXwVfuSGCKhMSXkJ
         EqNCnHtDJSL+DypVFGGsQ2m+3vjU1E5OVEEQX2gvfLrCYJtWT8n1fcJ+4iuJq5GZVNpm
         soqw==
X-Gm-Message-State: AOAM5334AgI+t45zFvsm9/TVBfgznRyRwf4n6xGMkjEP6t6q/1HXVdYL
        k/0PQjTZ+g/jrpnmPi0EZZ7YVLkMfJg=
X-Google-Smtp-Source: ABdhPJz7Kg7tAGZmkaIVt6rockpRm4YUN6w4Big8HKsX+HQYdl3n3LkrA0+wi+eHpwCddqwEEnc4KQ==
X-Received: by 2002:adf:e652:: with SMTP id b18mr5046217wrn.349.1627270014808;
        Sun, 25 Jul 2021 20:26:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d18sm6673878wrp.54.2021.07.25.20.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jul 2021 20:26:54 -0700 (PDT)
Message-Id: <0aa398e8a8f7e87d2af05a12f6a008486efae92d.1627270010.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1000.v4.git.1627270010.gitgitgadget@gmail.com>
References: <pull.1000.v3.git.1627136061.gitgitgadget@gmail.com>
        <pull.1000.v4.git.1627270010.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Jul 2021 03:26:49 +0000
Subject: [PATCH v4 4/5] [GSOC] ref-filter: use non-const ref_format in
 *_atom_parser()
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
        Jacob Keller <jacob.keller@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Use non-const ref_format in *_atom_parser(), which can help us
modify the members of ref_format in *_atom_parser().

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 builtin/tag.c |  2 +-
 ref-filter.c  | 44 ++++++++++++++++++++++----------------------
 ref-filter.h  |  4 ++--
 3 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 82fcfc09824..452558ec957 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -146,7 +146,7 @@ static int verify_tag(const char *name, const char *ref,
 		      const struct object_id *oid, void *cb_data)
 {
 	int flags;
-	const struct ref_format *format = cb_data;
+	struct ref_format *format = cb_data;
 	flags = GPG_VERIFY_VERBOSE;
 
 	if (format->format)
diff --git a/ref-filter.c b/ref-filter.c
index ce6c2115016..f944160c5ce 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -226,7 +226,7 @@ static int strbuf_addf_ret(struct strbuf *sb, int ret, const char *fmt, ...)
 	return ret;
 }
 
-static int color_atom_parser(const struct ref_format *format, struct used_atom *atom,
+static int color_atom_parser(struct ref_format *format, struct used_atom *atom,
 			     const char *color_value, struct strbuf *err)
 {
 	if (!color_value)
@@ -264,7 +264,7 @@ static int refname_atom_parser_internal(struct refname_atom *atom, const char *a
 	return 0;
 }
 
-static int remote_ref_atom_parser(const struct ref_format *format, struct used_atom *atom,
+static int remote_ref_atom_parser(struct ref_format *format, struct used_atom *atom,
 				  const char *arg, struct strbuf *err)
 {
 	struct string_list params = STRING_LIST_INIT_DUP;
@@ -311,7 +311,7 @@ static int remote_ref_atom_parser(const struct ref_format *format, struct used_a
 	return 0;
 }
 
-static int objecttype_atom_parser(const struct ref_format *format, struct used_atom *atom,
+static int objecttype_atom_parser(struct ref_format *format, struct used_atom *atom,
 				  const char *arg, struct strbuf *err)
 {
 	if (arg)
@@ -323,7 +323,7 @@ static int objecttype_atom_parser(const struct ref_format *format, struct used_a
 	return 0;
 }
 
-static int objectsize_atom_parser(const struct ref_format *format, struct used_atom *atom,
+static int objectsize_atom_parser(struct ref_format *format, struct used_atom *atom,
 				  const char *arg, struct strbuf *err)
 {
 	if (!arg) {
@@ -343,7 +343,7 @@ static int objectsize_atom_parser(const struct ref_format *format, struct used_a
 	return 0;
 }
 
-static int deltabase_atom_parser(const struct ref_format *format, struct used_atom *atom,
+static int deltabase_atom_parser(struct ref_format *format, struct used_atom *atom,
 				 const char *arg, struct strbuf *err)
 {
 	if (arg)
@@ -355,7 +355,7 @@ static int deltabase_atom_parser(const struct ref_format *format, struct used_at
 	return 0;
 }
 
-static int body_atom_parser(const struct ref_format *format, struct used_atom *atom,
+static int body_atom_parser(struct ref_format *format, struct used_atom *atom,
 			    const char *arg, struct strbuf *err)
 {
 	if (arg)
@@ -364,7 +364,7 @@ static int body_atom_parser(const struct ref_format *format, struct used_atom *a
 	return 0;
 }
 
-static int subject_atom_parser(const struct ref_format *format, struct used_atom *atom,
+static int subject_atom_parser(struct ref_format *format, struct used_atom *atom,
 			       const char *arg, struct strbuf *err)
 {
 	if (!arg)
@@ -376,7 +376,7 @@ static int subject_atom_parser(const struct ref_format *format, struct used_atom
 	return 0;
 }
 
-static int trailers_atom_parser(const struct ref_format *format, struct used_atom *atom,
+static int trailers_atom_parser(struct ref_format *format, struct used_atom *atom,
 				const char *arg, struct strbuf *err)
 {
 	atom->u.contents.trailer_opts.no_divider = 1;
@@ -402,7 +402,7 @@ static int trailers_atom_parser(const struct ref_format *format, struct used_ato
 	return 0;
 }
 
-static int contents_atom_parser(const struct ref_format *format, struct used_atom *atom,
+static int contents_atom_parser(struct ref_format *format, struct used_atom *atom,
 				const char *arg, struct strbuf *err)
 {
 	if (!arg)
@@ -430,7 +430,7 @@ static int contents_atom_parser(const struct ref_format *format, struct used_ato
 	return 0;
 }
 
-static int raw_atom_parser(const struct ref_format *format, struct used_atom *atom,
+static int raw_atom_parser(struct ref_format *format, struct used_atom *atom,
 				const char *arg, struct strbuf *err)
 {
 	if (!arg)
@@ -442,7 +442,7 @@ static int raw_atom_parser(const struct ref_format *format, struct used_atom *at
 	return 0;
 }
 
-static int oid_atom_parser(const struct ref_format *format, struct used_atom *atom,
+static int oid_atom_parser(struct ref_format *format, struct used_atom *atom,
 			   const char *arg, struct strbuf *err)
 {
 	if (!arg)
@@ -461,7 +461,7 @@ static int oid_atom_parser(const struct ref_format *format, struct used_atom *at
 	return 0;
 }
 
-static int person_email_atom_parser(const struct ref_format *format, struct used_atom *atom,
+static int person_email_atom_parser(struct ref_format *format, struct used_atom *atom,
 				    const char *arg, struct strbuf *err)
 {
 	if (!arg)
@@ -475,7 +475,7 @@ static int person_email_atom_parser(const struct ref_format *format, struct used
 	return 0;
 }
 
-static int refname_atom_parser(const struct ref_format *format, struct used_atom *atom,
+static int refname_atom_parser(struct ref_format *format, struct used_atom *atom,
 			       const char *arg, struct strbuf *err)
 {
 	return refname_atom_parser_internal(&atom->u.refname, arg, atom->name, err);
@@ -492,7 +492,7 @@ static align_type parse_align_position(const char *s)
 	return -1;
 }
 
-static int align_atom_parser(const struct ref_format *format, struct used_atom *atom,
+static int align_atom_parser(struct ref_format *format, struct used_atom *atom,
 			     const char *arg, struct strbuf *err)
 {
 	struct align *align = &atom->u.align;
@@ -544,7 +544,7 @@ static int align_atom_parser(const struct ref_format *format, struct used_atom *
 	return 0;
 }
 
-static int if_atom_parser(const struct ref_format *format, struct used_atom *atom,
+static int if_atom_parser(struct ref_format *format, struct used_atom *atom,
 			  const char *arg, struct strbuf *err)
 {
 	if (!arg) {
@@ -559,7 +559,7 @@ static int if_atom_parser(const struct ref_format *format, struct used_atom *ato
 	return 0;
 }
 
-static int head_atom_parser(const struct ref_format *format, struct used_atom *atom,
+static int head_atom_parser(struct ref_format *format, struct used_atom *atom,
 			    const char *arg, struct strbuf *unused_err)
 {
 	atom->u.head = resolve_refdup("HEAD", RESOLVE_REF_READING, NULL, NULL);
@@ -570,7 +570,7 @@ static struct {
 	const char *name;
 	info_source source;
 	cmp_type cmp_type;
-	int (*parser)(const struct ref_format *format, struct used_atom *atom,
+	int (*parser)(struct ref_format *format, struct used_atom *atom,
 		      const char *arg, struct strbuf *err);
 } valid_atom[] = {
 	[ATOM_REFNAME] = { "refname", SOURCE_NONE, FIELD_STR, refname_atom_parser },
@@ -653,7 +653,7 @@ struct atom_value {
 /*
  * Used to parse format string and sort specifiers
  */
-static int parse_ref_filter_atom(const struct ref_format *format,
+static int parse_ref_filter_atom(struct ref_format *format,
 				 const char *atom, const char *ep,
 				 struct strbuf *err)
 {
@@ -2556,9 +2556,9 @@ static void append_literal(const char *cp, const char *ep, struct ref_formatting
 }
 
 int format_ref_array_item(struct ref_array_item *info,
-			   const struct ref_format *format,
-			   struct strbuf *final_buf,
-			   struct strbuf *error_buf)
+			  struct ref_format *format,
+			  struct strbuf *final_buf,
+			  struct strbuf *error_buf)
 {
 	const char *cp, *sp, *ep;
 	struct ref_formatting_state state = REF_FORMATTING_STATE_INIT;
@@ -2602,7 +2602,7 @@ int format_ref_array_item(struct ref_array_item *info,
 }
 
 void pretty_print_ref(const char *name, const struct object_id *oid,
-		      const struct ref_format *format)
+		      struct ref_format *format)
 {
 	struct ref_array_item *ref_item;
 	struct strbuf output = STRBUF_INIT;
diff --git a/ref-filter.h b/ref-filter.h
index baf72a71896..74fb423fc89 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -116,7 +116,7 @@ void ref_array_sort(struct ref_sorting *sort, struct ref_array *array);
 void ref_sorting_set_sort_flags_all(struct ref_sorting *sorting, unsigned int mask, int on);
 /*  Based on the given format and quote_style, fill the strbuf */
 int format_ref_array_item(struct ref_array_item *info,
-			  const struct ref_format *format,
+			  struct ref_format *format,
 			  struct strbuf *final_buf,
 			  struct strbuf *error_buf);
 /*  Parse a single sort specifier and add it to the list */
@@ -137,7 +137,7 @@ void setup_ref_filter_porcelain_msg(void);
  * name must be a fully qualified refname.
  */
 void pretty_print_ref(const char *name, const struct object_id *oid,
-		      const struct ref_format *format);
+		      struct ref_format *format);
 
 /*
  * Push a single ref onto the array; this can be used to construct your own
-- 
gitgitgadget

