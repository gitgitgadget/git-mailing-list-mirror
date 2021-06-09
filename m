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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09481C48BCF
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 16:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3F9A613AC
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 16:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235665AbhFIQOB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 12:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbhFIQOB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 12:14:01 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EF6C061574
        for <git@vger.kernel.org>; Wed,  9 Jun 2021 09:12:06 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id t4-20020a1c77040000b029019d22d84ebdso4650573wmi.3
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 09:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SZGQ943rib04/eVNIKdq6fOG3+lsHpv0pHGs42Vf0XU=;
        b=ctox0XM0fnE14Jb0LMQfRUmdQTYQwi+yCBN9SbmXMB441JPGqpZeIo8BlMvzWZMu2T
         3Hi61ehS+BCLB/u8T46u6S7kxoQ4DwfzlXCVqTZ/4LEw48bGN/8+y8rQ9ySuvfUrJCUz
         e9s2J2UhK6d12CNSDMKftZ/Im5FX9GopY9vc8lv3DvNDOIcrXLrtXC8FmID7Ft8WEZHu
         TcvpX18uaeS3RSbzXYVRvxoEAvztPlAnBD/+cox5PugqwjlQ9VVcyWSZigiagZMupu8/
         4meV+BCmfb6/gt7UmqUcGRFYMz1G8nkDKf/FdBkkUCqEyb0cXdObeKLf/VvZjaD5e9WC
         3rzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SZGQ943rib04/eVNIKdq6fOG3+lsHpv0pHGs42Vf0XU=;
        b=hlYAdk+XRwE8L3z3i2Toyp3qxDMofWZ1L0ToZcUO2BjNzuWviqjPYgJBAolBPPv4zk
         f34B25MdiiS21hUv0OFdKZ6nVIM5p78hDYFR5QfMdr/rfFf8XAWFcnef9HXJHMTrr+32
         /ofRy4J37qoOnia2TlNokB3nVXiRx9u8JIY0AKFXmBkjKAvWCU5uZuUwnPMjkeApG9oL
         v0os3+j0Js0ymAoiwF92J90GAIneD7xtp70mImiNrNy0C2CHYl6xDXIPNJ1KNQI/i24Q
         w05aOrItBM/uFqESQoYADgx4WN1uGQFR5ML3oT+WRfUGZ6+b2K1cdwMVfiruUopifiFW
         H7iQ==
X-Gm-Message-State: AOAM532RknDiJNcwzXP9VbBTPObWe4mZd2NwfhK1FxmCl5PoZqtR7IUm
        L14nj2hBcELm14PBDSiDw+303Mguo/A=
X-Google-Smtp-Source: ABdhPJysfzgepZc8d3TuqDnsDw32VvYcKsFIT15gpPbWEF8LHzb2S3K3+iFNXE/VyWdeNRzQG4lRPw==
X-Received: by 2002:a1c:1dd5:: with SMTP id d204mr10579099wmd.140.1623255124894;
        Wed, 09 Jun 2021 09:12:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f14sm5688611wmq.10.2021.06.09.09.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 09:12:04 -0700 (PDT)
Message-Id: <c99d1d070a182d09013792d724d6a62bb9a7c0a2.1623255121.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.976.v2.git.1623255121.gitgitgadget@gmail.com>
References: <pull.976.git.1623163082.gitgitgadget@gmail.com>
        <pull.976.v2.git.1623255121.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Jun 2021 16:12:00 +0000
Subject: [PATCH v2 3/4] [GSOC] ref-filter: use non-const ref_format in
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
index 82fcfc098242..452558ec9575 100644
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
index 7822be903071..af8c15aef44d 100644
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
@@ -649,7 +649,7 @@ struct atom_value {
 /*
  * Used to parse format string and sort specifiers
  */
-static int parse_ref_filter_atom(const struct ref_format *format,
+static int parse_ref_filter_atom(struct ref_format *format,
 				 const char *atom, const char *ep,
 				 struct strbuf *err)
 {
@@ -2546,9 +2546,9 @@ static void append_literal(const char *cp, const char *ep, struct ref_formatting
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
@@ -2593,7 +2593,7 @@ int format_ref_array_item(struct ref_array_item *info,
 }
 
 void pretty_print_ref(const char *name, const struct object_id *oid,
-		      const struct ref_format *format)
+		      struct ref_format *format)
 {
 	struct ref_array_item *ref_item;
 	struct strbuf output = STRBUF_INIT;
diff --git a/ref-filter.h b/ref-filter.h
index baf72a718965..74fb423fc89f 100644
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

