Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7D1C7EE23
	for <git@archiver.kernel.org>; Wed,  7 Jun 2023 10:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239700AbjFGKmE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jun 2023 06:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239596AbjFGKlx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2023 06:41:53 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23380AA
        for <git@vger.kernel.org>; Wed,  7 Jun 2023 03:41:51 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-565ba53f434so80021497b3.3
        for <git@vger.kernel.org>; Wed, 07 Jun 2023 03:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1686134510; x=1688726510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZxNxpSZm9oCdX8mEdMdkkC305eB3R6MykgDz8PVoIOE=;
        b=M7Zyu6HnZmSlkNy+sLwbWepCLPC/nkclX5d9GtDbplfMbImEFgLn+FiFWHGDBypIRu
         pFnlanBD+gjGTEXjlHQhCGyp98FzLhSxz3BEg6SzElIecavk1s9G3f7T3Jd6hU6d4U3o
         gFa0FRcRbBln52/kHFoKk7zXlL2hw6Yc0WUq8DCPs8c+qaNr7t17kdGEE2YDMGpSNItV
         OEfNRMj+5kMeMF2gbA8jfBsN76cOnVSygEJAtBRhyJWABHPchjfrT+JraJVJWVktkIBe
         o4xkSrfgVi9k7xl3cAkyQArLaYqs/mwy7d2dmXRIYuKXue6V7UEo54XC/SVtYd5s5hKy
         W/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686134510; x=1688726510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZxNxpSZm9oCdX8mEdMdkkC305eB3R6MykgDz8PVoIOE=;
        b=cDR5c3WIX/4x2u9e8/yvPnLnOzS1xNJ0ETevMd8Mq3sBpwvfw9rtYlNxEL91+kOIuK
         +lCaxo+MPZirYEFDp7l1FoYKQjR7glr6N/fJdvfOC97/agesrr3uvmnTHB46GFU54lUH
         WoT77ueElJcKhUk1gp3Rs5Nf2iB0BMBS7gvwh5x0rBQqkOishTztX9J8u+QoacCztW55
         P6sRksVXMGkOhi989P0Lk17DtYEZOA5VErkudrYfbU/oOoOaNyqPK9jYKwS/10mo1D/l
         vMK0APH1bFK39zBO0vF8n3fBXN9sqEX3HlUjqMFSVYqJsQj1ewvzYBB1rk0CIbwdQ+Vr
         m/3A==
X-Gm-Message-State: AC+VfDyIjdzSl69C+BYQeTEmnc0BTo+yD9vyXONV7so3fSJozURAOlgP
        ATmpy9TtxoewAvKBjLia/qWgcRrl8DUS66IUnNhUfAF7
X-Google-Smtp-Source: ACHHUZ7NqNIfRHJUW9p1EXveGT2VTXpT5FcWlsla24xPNg+jwbpsUwnX0XqsoRiOcc3epugIIa4zGg==
X-Received: by 2002:a0d:ebd2:0:b0:565:cf47:7331 with SMTP id u201-20020a0debd2000000b00565cf477331mr7474469ywe.2.1686134510206;
        Wed, 07 Jun 2023 03:41:50 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w205-20020a817bd6000000b005569567aac1sm4633642ywc.106.2023.06.07.03.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 03:41:49 -0700 (PDT)
Date:   Wed, 7 Jun 2023 06:41:47 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 11/16] revision.h: store hidden refs in a `strvec`
Message-ID: <0ff542eaefd5142056b484901a3c22e2a590b07e.1686134440.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1686134440.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1686134440.git.me@ttaylorr.com>
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
index 31828748dc..94f035fa22 100644
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
2.41.0.16.g26cd413590

