Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE07EB64DB
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 14:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbjFTOWU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 10:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233308AbjFTOWF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 10:22:05 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4B8170D
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 07:22:01 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5707b429540so59210157b3.1
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 07:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1687270921; x=1689862921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XYIvwaeyCfnGcZ+Rkv3oFzN289BduwpaZY3t9Kykerk=;
        b=FvKowJHRfTkP4DxBJZK3YovgEcC1lJdCyQrmln9M/EMXnnFmr2jdy29jeZei7oIdih
         IjGhM0pz/7x65qw2d62qotxOGhRuWk+IvC4gCSP2UQPRgZLfuYKlcpQhOgrnwfp1Huii
         YjZ//nY9nP83z7C4fus8c5iublVDGn/PmHiM2GJcNNaR3MV+MviZSL3cfUxXxmoNUwhU
         LyA3ZfwhYq52mYXgcJRXj6Y6e6neWFkGhT7myMHNUUC71bBqpUY64SKyc4zCEjY4iDiI
         q/eksx8ottURdTbHG+UsYGUjj2Cp9qfsiBSbGSsgp3P2WHFT2nL0xFO1J39T2ckAQt8E
         dJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687270921; x=1689862921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XYIvwaeyCfnGcZ+Rkv3oFzN289BduwpaZY3t9Kykerk=;
        b=er1cn1jIHSaVC+80+HCgoZkvzOIel+/+QLMlFdOj8KpMOpSzEqFNq0iWB9eKR+/8Wr
         /MqX9Oz51HZzJrd3cbCEURPKBajQxm/YkWZUtEaF/pi66N+Z17cBsGK6FkEqHH+/N3EC
         2XAHms+FVkJlLFM+9toGOkB0BeuFFsd9dFwS4h25BxKUyOqGI4/oDFLWLEjCGMd+Vbt3
         GXAiQ+mQegtaZmB0XQgR8G47hDwghRglm9I8q6aa64ao3sRH8+ax3cMn6jCCTlmrvwK/
         9K1HH7OAGuusSlzsR/4bSnkLuxutkyNQWmPnA03c5+tNmuILRiS8HO6vfsprlGyqG0rq
         Sq2w==
X-Gm-Message-State: AC+VfDxpVuYSnJX/oTFwq5FaRJydIi1yTM0bW5QXxcobH51oEJKMVTVT
        aK3jSeTKfMrWBbuutFnabA7tvz5ocsXGgwnRXL5gJA5T
X-Google-Smtp-Source: ACHHUZ7MiBvWAJPB3zMgbs0L+jUTrhZM1XI5ckUTVMdAlC5gLaj4km7YFmH9o39YEioeCjlZT0i6pw==
X-Received: by 2002:a0d:d8d4:0:b0:570:704b:2e52 with SMTP id a203-20020a0dd8d4000000b00570704b2e52mr13527320ywe.0.1687270920940;
        Tue, 20 Jun 2023 07:22:00 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x7-20020a0dee07000000b0056dfbc37d9fsm516203ywe.50.2023.06.20.07.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 07:22:00 -0700 (PDT)
Date:   Tue, 20 Jun 2023 10:21:57 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 11/16] revision.h: store hidden refs in a `strvec`
Message-ID: <dd856a3982bbc01af7b79399808a5e3baace3899.1687270849.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1687270849.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1687270849.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In subsequent commits, it will be convenient to have a 'const char **'
of hidden refs (matching `transfer.hiderefs`, `uploadpack.hideRefs`,
etc.), instead of a `string_list`.

Convert spots throughout the tree that store the list of hidden refs
from a `string_list` to a `strvec`.

Note that in `parse_hide_refs_config()` there is an ugly const-cast used
to avoid an extra copy of each value before trimming any trailing slash
characters. This could instead be written as:

    ref = xstrdup(value);
    len = strlen(ref);
    while (len && ref[len - 1] == '/')
            ref[--len] = '\0';
    strvec_push(hide_refs, ref);
    free(ref);

but the double-copy (once when calling `xstrdup()`, and another via
`strvec_push()`) is wasteful.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/receive-pack.c |  4 ++--
 ls-refs.c              |  6 +++---
 refs.c                 | 11 ++++++-----
 refs.h                 |  4 ++--
 revision.c             |  2 +-
 revision.h             |  5 +++--
 upload-pack.c          | 10 +++++-----
 7 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 1a31a58367..1a8472eddc 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -90,7 +90,7 @@ static struct object_id push_cert_oid;
 static struct signature_check sigcheck;
 static const char *push_cert_nonce;
 static const char *cert_nonce_seed;
-static struct string_list hidden_refs = STRING_LIST_INIT_DUP;
+static struct strvec hidden_refs = STRVEC_INIT;
 
 static const char *NONCE_UNSOLICITED = "UNSOLICITED";
 static const char *NONCE_BAD = "BAD";
@@ -2619,7 +2619,7 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 		packet_flush(1);
 	oid_array_clear(&shallow);
 	oid_array_clear(&ref);
-	string_list_clear(&hidden_refs, 0);
+	strvec_clear(&hidden_refs);
 	free((void *)push_cert_nonce);
 	return 0;
 }
diff --git a/ls-refs.c b/ls-refs.c
index 6f490b2d9c..8c3181d051 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -72,7 +72,7 @@ struct ls_refs_data {
 	unsigned symrefs;
 	struct strvec prefixes;
 	struct strbuf buf;
-	struct string_list hidden_refs;
+	struct strvec hidden_refs;
 	unsigned unborn : 1;
 };
 
@@ -155,7 +155,7 @@ int ls_refs(struct repository *r, struct packet_reader *request)
 	memset(&data, 0, sizeof(data));
 	strvec_init(&data.prefixes);
 	strbuf_init(&data.buf, 0);
-	string_list_init_dup(&data.hidden_refs);
+	strvec_init(&data.hidden_refs);
 
 	git_config(ls_refs_config, &data);
 
@@ -197,7 +197,7 @@ int ls_refs(struct repository *r, struct packet_reader *request)
 	packet_fflush(stdout);
 	strvec_clear(&data.prefixes);
 	strbuf_release(&data.buf);
-	string_list_clear(&data.hidden_refs, 0);
+	strvec_clear(&data.hidden_refs);
 	return 0;
 }
 
diff --git a/refs.c b/refs.c
index b4b7165fc0..1f01fdf9e8 100644
--- a/refs.c
+++ b/refs.c
@@ -1427,7 +1427,7 @@ char *shorten_unambiguous_ref(const char *refname, int strict)
 }
 
 int parse_hide_refs_config(const char *var, const char *value, const char *section,
-			   struct string_list *hide_refs)
+			   struct strvec *hide_refs)
 {
 	const char *key;
 	if (!strcmp("transfer.hiderefs", var) ||
@@ -1438,22 +1438,23 @@ int parse_hide_refs_config(const char *var, const char *value, const char *secti
 
 		if (!value)
 			return config_error_nonbool(var);
-		ref = xstrdup(value);
+
+		/* drop const to remove trailing '/' characters */
+		ref = (char *)strvec_push(hide_refs, value);
 		len = strlen(ref);
 		while (len && ref[len - 1] == '/')
 			ref[--len] = '\0';
-		string_list_append_nodup(hide_refs, ref);
 	}
 	return 0;
 }
 
 int ref_is_hidden(const char *refname, const char *refname_full,
-		  const struct string_list *hide_refs)
+		  const struct strvec *hide_refs)
 {
 	int i;
 
 	for (i = hide_refs->nr - 1; i >= 0; i--) {
-		const char *match = hide_refs->items[i].string;
+		const char *match = hide_refs->v[i];
 		const char *subject;
 		int neg = 0;
 		const char *p;
diff --git a/refs.h b/refs.h
index 3c03b035a3..f091741bfa 100644
--- a/refs.h
+++ b/refs.h
@@ -816,7 +816,7 @@ int update_ref(const char *msg, const char *refname,
 	       unsigned int flags, enum action_on_err onerr);
 
 int parse_hide_refs_config(const char *var, const char *value, const char *,
-			   struct string_list *);
+			   struct strvec *);
 
 /*
  * Check whether a ref is hidden. If no namespace is set, both the first and
@@ -826,7 +826,7 @@ int parse_hide_refs_config(const char *var, const char *value, const char *,
  * the ref is outside that namespace, the first parameter is NULL. The second
  * parameter always points to the full ref name.
  */
-int ref_is_hidden(const char *, const char *, const struct string_list *);
+int ref_is_hidden(const char *, const char *, const struct strvec *);
 
 /* Is this a per-worktree ref living in the refs/ namespace? */
 int is_per_worktree_ref(const char *refname);
diff --git a/revision.c b/revision.c
index 89953592f9..7c9367a266 100644
--- a/revision.c
+++ b/revision.c
@@ -1558,7 +1558,7 @@ void init_ref_exclusions(struct ref_exclusions *exclusions)
 void clear_ref_exclusions(struct ref_exclusions *exclusions)
 {
 	string_list_clear(&exclusions->excluded_refs, 0);
-	string_list_clear(&exclusions->hidden_refs, 0);
+	strvec_clear(&exclusions->hidden_refs);
 	exclusions->hidden_refs_configured = 0;
 }
 
diff --git a/revision.h b/revision.h
index 25776af381..7f219cde62 100644
--- a/revision.h
+++ b/revision.h
@@ -10,6 +10,7 @@
 #include "decorate.h"
 #include "ident.h"
 #include "list-objects-filter-options.h"
+#include "strvec.h"
 
 /**
  * The revision walking API offers functions to build a list of revisions
@@ -95,7 +96,7 @@ struct ref_exclusions {
 	 * Hidden refs is a list of patterns that is to be hidden via
 	 * `ref_is_hidden()`.
 	 */
-	struct string_list hidden_refs;
+	struct strvec hidden_refs;
 
 	/*
 	 * Indicates whether hidden refs have been configured. This is to
@@ -110,7 +111,7 @@ struct ref_exclusions {
  */
 #define REF_EXCLUSIONS_INIT { \
 	.excluded_refs = STRING_LIST_INIT_DUP, \
-	.hidden_refs = STRING_LIST_INIT_DUP, \
+	.hidden_refs = STRVEC_INIT, \
 }
 
 struct oidset;
diff --git a/upload-pack.c b/upload-pack.c
index d3312006a3..1a213ed775 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -69,7 +69,7 @@ struct upload_pack_data {
 	struct object_array have_obj;
 	struct oid_array haves;					/* v2 only */
 	struct string_list wanted_refs;				/* v2 only */
-	struct string_list hidden_refs;
+	struct strvec hidden_refs;
 
 	struct object_array shallows;
 	struct string_list deepen_not;
@@ -127,7 +127,7 @@ static void upload_pack_data_init(struct upload_pack_data *data)
 {
 	struct string_list symref = STRING_LIST_INIT_DUP;
 	struct string_list wanted_refs = STRING_LIST_INIT_DUP;
-	struct string_list hidden_refs = STRING_LIST_INIT_DUP;
+	struct strvec hidden_refs = STRVEC_INIT;
 	struct object_array want_obj = OBJECT_ARRAY_INIT;
 	struct object_array have_obj = OBJECT_ARRAY_INIT;
 	struct oid_array haves = OID_ARRAY_INIT;
@@ -162,7 +162,7 @@ static void upload_pack_data_clear(struct upload_pack_data *data)
 {
 	string_list_clear(&data->symref, 1);
 	string_list_clear(&data->wanted_refs, 1);
-	string_list_clear(&data->hidden_refs, 0);
+	strvec_clear(&data->hidden_refs);
 	object_array_clear(&data->want_obj);
 	object_array_clear(&data->have_obj);
 	oid_array_clear(&data->haves);
@@ -1170,7 +1170,7 @@ static void receive_needs(struct upload_pack_data *data,
 
 /* return non-zero if the ref is hidden, otherwise 0 */
 static int mark_our_ref(const char *refname, const char *refname_full,
-			const struct object_id *oid, const struct string_list *hidden_refs)
+			const struct object_id *oid, const struct strvec *hidden_refs)
 {
 	struct object *o = lookup_unknown_object(the_repository, oid);
 
@@ -1465,7 +1465,7 @@ static int parse_want(struct packet_writer *writer, const char *line,
 
 static int parse_want_ref(struct packet_writer *writer, const char *line,
 			  struct string_list *wanted_refs,
-			  struct string_list *hidden_refs,
+			  struct strvec *hidden_refs,
 			  struct object_array *want_obj)
 {
 	const char *refname_nons;
-- 
2.41.0.44.gf2359540d2

