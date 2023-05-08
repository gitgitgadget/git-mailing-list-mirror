Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC88C77B7F
	for <git@archiver.kernel.org>; Mon,  8 May 2023 22:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234458AbjEHWAx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 18:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234522AbjEHWA3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 18:00:29 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEC24EFC
        for <git@vger.kernel.org>; Mon,  8 May 2023 15:00:24 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-b99f0a0052fso6888020276.3
        for <git@vger.kernel.org>; Mon, 08 May 2023 15:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683583223; x=1686175223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zvrzQZXuFLZVzyzSdbpkeKnq1Mi6dpkY47xXRlfYQiQ=;
        b=YLt74zwW0OQQBReGh4TRIHfOppLwHY50Ee0eFq8ibjo5jbgVvildNBJfKi1HjDJa4u
         Op3q9gJ/zjubHfcLj0M63FaRzFZoO3r0sBwu/zFnwboL22NRuuE3Z9XeCS+uSMT5+EuH
         fOlOBlNp7kzAiTDr1nDu4CvHVfRZLMk7T78j9QRQ6i7MiDUzvwPGQb5EfgsgOKHE41Ol
         tsMxLhWa8/M5Ks7MseYBm3UL3aGHyklaUzdQTYeu9bKic+GZVYiFNF6orm6kOJAa3Zmj
         szX9L7A/aW608XzoRUX/SY72cvdRiHd9nbNL/WWnbgn1OLjxNywkOgLk0Ivxj+Wyl+za
         mQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683583223; x=1686175223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zvrzQZXuFLZVzyzSdbpkeKnq1Mi6dpkY47xXRlfYQiQ=;
        b=I+REBdiYR17uCHcgcuJXPk5qzvVEVmPZVy3irDTy1yhGxZClO+P2gSqGxxl+ZVJgqK
         K359a9E5xvYMjNloreoPOXnYB0pP816mIgEI6rTerCB+d1EtFrpixAw4WaBu25MTi2yP
         u05aCiBAtr/Fc5bx9+XNAbYN4Sn/2o19meTxYCKSaZGxvndOxH6J1iO8h0wmgUOvI3kM
         bJTR/cal45qSxMexm641qFYJIWHnV2TPEMHeQkt40UVON2kRKCSKlwJ1+CCMT+WOx9sk
         xoURpuJ9XJVTWfJkwHBjyBFft/K0BhAd2xfgCqf8JC5yFkIfl9tJmbYq6Bnd+t6u+3za
         Kf3Q==
X-Gm-Message-State: AC+VfDzMrEzpnMy7sKFTg8fw1a7anv0EBsJd25WoLDRANE3LjJxptsai
        e6nuQQzgpkStwY+gP07ZhdLCAvh3lePl5RX4Ldluyg==
X-Google-Smtp-Source: ACHHUZ4fVc9ejpl3aTRFg6oNztC1PIajZCeb5kc91yR0rbrtwbJZrqjUP4q6e/WWZluAoi8pj0/AmQ==
X-Received: by 2002:a25:fc0a:0:b0:b8f:5639:cb8a with SMTP id v10-20020a25fc0a000000b00b8f5639cb8amr13722518ybd.9.1683583216870;
        Mon, 08 May 2023 15:00:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d204-20020a251dd5000000b00b9a7db655ecsm2635062ybd.23.2023.05.08.15.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 15:00:16 -0700 (PDT)
Date:   Mon, 8 May 2023 18:00:15 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 11/15] revision.h: store hidden refs in a `strvec`
Message-ID: <5b9814ad8c75029f836f051394ab387517ac3803.1683581621.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1683581621.git.me@ttaylorr.com>
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
index d22180435c..064df74715 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -89,7 +89,7 @@ static struct object_id push_cert_oid;
 static struct signature_check sigcheck;
 static const char *push_cert_nonce;
 static const char *cert_nonce_seed;
-static struct string_list hidden_refs = STRING_LIST_INIT_DUP;
+static struct strvec hidden_refs = STRVEC_INIT;
 
 static const char *NONCE_UNSOLICITED = "UNSOLICITED";
 static const char *NONCE_BAD = "BAD";
@@ -2618,7 +2618,7 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 		packet_flush(1);
 	oid_array_clear(&shallow);
 	oid_array_clear(&ref);
-	string_list_clear(&hidden_refs, 0);
+	strvec_clear(&hidden_refs);
 	free((void *)push_cert_nonce);
 	return 0;
 }
diff --git a/ls-refs.c b/ls-refs.c
index c7ad39611a..d3d7e13e5a 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -71,7 +71,7 @@ struct ls_refs_data {
 	unsigned symrefs;
 	struct strvec prefixes;
 	struct strbuf buf;
-	struct string_list hidden_refs;
+	struct strvec hidden_refs;
 	unsigned unborn : 1;
 };
 
@@ -154,7 +154,7 @@ int ls_refs(struct repository *r, struct packet_reader *request)
 	memset(&data, 0, sizeof(data));
 	strvec_init(&data.prefixes);
 	strbuf_init(&data.buf, 0);
-	string_list_init_dup(&data.hidden_refs);
+	strvec_init(&data.hidden_refs);
 
 	git_config(ls_refs_config, &data);
 
@@ -196,7 +196,7 @@ int ls_refs(struct repository *r, struct packet_reader *request)
 	packet_fflush(stdout);
 	strvec_clear(&data.prefixes);
 	strbuf_release(&data.buf);
-	string_list_clear(&data.hidden_refs, 0);
+	strvec_clear(&data.hidden_refs);
 	return 0;
 }
 
diff --git a/refs.c b/refs.c
index 538bde644e..ec4d5b9101 100644
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
index d672d636cf..a7751a1fc9 100644
--- a/refs.h
+++ b/refs.h
@@ -810,7 +810,7 @@ int update_ref(const char *msg, const char *refname,
 	       unsigned int flags, enum action_on_err onerr);
 
 int parse_hide_refs_config(const char *var, const char *value, const char *,
-			   struct string_list *);
+			   struct strvec *);
 
 /*
  * Check whether a ref is hidden. If no namespace is set, both the first and
@@ -820,7 +820,7 @@ int parse_hide_refs_config(const char *var, const char *value, const char *,
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
index e8f6de9684..30b5b5919d 100644
--- a/revision.h
+++ b/revision.h
@@ -9,6 +9,7 @@
 #include "commit-slab-decl.h"
 #include "ident.h"
 #include "list-objects-filter-options.h"
+#include "strvec.h"
 
 /**
  * The revision walking API offers functions to build a list of revisions
@@ -94,7 +95,7 @@ struct ref_exclusions {
 	 * Hidden refs is a list of patterns that is to be hidden via
 	 * `ref_is_hidden()`.
 	 */
-	struct string_list hidden_refs;
+	struct strvec hidden_refs;
 
 	/*
 	 * Indicates whether hidden refs have been configured. This is to
@@ -109,7 +110,7 @@ struct ref_exclusions {
  */
 #define REF_EXCLUSIONS_INIT { \
 	.excluded_refs = STRING_LIST_INIT_DUP, \
-	.hidden_refs = STRING_LIST_INIT_DUP, \
+	.hidden_refs = STRVEC_INIT, \
 }
 
 struct oidset;
diff --git a/upload-pack.c b/upload-pack.c
index 08633dc121..d77d58bdde 100644
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
@@ -126,7 +126,7 @@ static void upload_pack_data_init(struct upload_pack_data *data)
 {
 	struct string_list symref = STRING_LIST_INIT_DUP;
 	struct string_list wanted_refs = STRING_LIST_INIT_DUP;
-	struct string_list hidden_refs = STRING_LIST_INIT_DUP;
+	struct strvec hidden_refs = STRVEC_INIT;
 	struct object_array want_obj = OBJECT_ARRAY_INIT;
 	struct object_array have_obj = OBJECT_ARRAY_INIT;
 	struct oid_array haves = OID_ARRAY_INIT;
@@ -161,7 +161,7 @@ static void upload_pack_data_clear(struct upload_pack_data *data)
 {
 	string_list_clear(&data->symref, 1);
 	string_list_clear(&data->wanted_refs, 1);
-	string_list_clear(&data->hidden_refs, 0);
+	strvec_clear(&data->hidden_refs);
 	object_array_clear(&data->want_obj);
 	object_array_clear(&data->have_obj);
 	oid_array_clear(&data->haves);
@@ -1169,7 +1169,7 @@ static void receive_needs(struct upload_pack_data *data,
 
 /* return non-zero if the ref is hidden, otherwise 0 */
 static int mark_our_ref(const char *refname, const char *refname_full,
-			const struct object_id *oid, const struct string_list *hidden_refs)
+			const struct object_id *oid, const struct strvec *hidden_refs)
 {
 	struct object *o = lookup_unknown_object(the_repository, oid);
 
@@ -1453,7 +1453,7 @@ static int parse_want(struct packet_writer *writer, const char *line,
 
 static int parse_want_ref(struct packet_writer *writer, const char *line,
 			  struct string_list *wanted_refs,
-			  struct string_list *hidden_refs,
+			  struct strvec *hidden_refs,
 			  struct object_array *want_obj)
 {
 	const char *refname_nons;
-- 
2.40.1.477.g956c797dfc

