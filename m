Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21887EB64DA
	for <git@archiver.kernel.org>; Mon, 10 Jul 2023 21:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbjGJVNE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jul 2023 17:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbjGJVMm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2023 17:12:42 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BC8C4
        for <git@vger.kernel.org>; Mon, 10 Jul 2023 14:12:36 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-c4dd86f5d78so7239651276.0
        for <git@vger.kernel.org>; Mon, 10 Jul 2023 14:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689023555; x=1691615555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nziK9Irby7MFLeFsDzsjjg/lY2fCbTtP1sERtDetdhw=;
        b=I+kV6PH51ipTjpSTEWmsOd/sR7RJ2G6vdhrxN9orTbLxQO83m8PQ2clHENWHu0NL5b
         WwSgE2z08xSdEsJuVAe+4qr/2ezgNA+a5bsz6QQPp8fFwrJf+StzrgWSZ/GjfHwmn04t
         RVSy/t9+ohlReDoIUILki3NQps7pTDnBS7hIueVbqyffvJlRBSbS7hh4R43iAL3wguER
         /sqp2/c5a/LdXvb586qR/xccWQnJ2usMQsBVTxQvgjMcNShtViN29ZDwWmi72Swi8wD8
         7wFwHFcPzW+LVLQLMhmr6/bWrMk47vDxveSNFDPKCZYNIqXX2CCzf09m2oUKjd1S0QHl
         AQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689023555; x=1691615555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nziK9Irby7MFLeFsDzsjjg/lY2fCbTtP1sERtDetdhw=;
        b=KIQHagk8Q5NPyOemB7+Rd7kpMpKezNklAPvoqVSs7LX/VhcSwzRl7JI/Itq4uYAIx4
         r9n+jEO0V2LPv/weURxNxE4zbl0HieW2s0ZaCnaFTsypO+YV7jL+cxtOUg/N5XJsQMc3
         yelxqJmo3cuIdsXjpUEAQ5QEuFnsa8Y5nIeD+mg387Oj061H4y528/JclfDeVueAXMPY
         W87ziIinAdXw7yq+WERwa458JP/XUA59Bh3/a7gcWeguhyZdoL+z8cQI6ZZUQORr+td8
         B9U3ffcaGteJXvoGBXuYu1j5L3e4phdNnfiD5GN3qZx5f69BffW1LpbRs8DW3PCc2dV6
         RaOg==
X-Gm-Message-State: ABy/qLa/Zymnm3b/tojKgu85yqu8ySutz/6jlgDzIZiHlJ+c28Np6ndA
        Debv2U6mwd5bF4iXm7ohg5JORBMXc6T62JkugeX5cQ==
X-Google-Smtp-Source: APBJJlHUfTaH0PAzZ7swnbHMKeh4nxw05BnfT+leUnstvyco+bzN22LSVuuEOR4ha+/XuqAu0g7CbA==
X-Received: by 2002:a25:7495:0:b0:c42:53eb:1599 with SMTP id p143-20020a257495000000b00c4253eb1599mr11960405ybc.16.1689023555262;
        Mon, 10 Jul 2023 14:12:35 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w18-20020a25ac12000000b00c4d8c48d7c0sm148426ybi.7.2023.07.10.14.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 14:12:35 -0700 (PDT)
Date:   Mon, 10 Jul 2023 17:12:33 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 11/16] revision.h: store hidden refs in a `strvec`
Message-ID: <a5093d52008898353623613f0b42752c1a58f9aa.1689023520.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1689023520.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1689023520.git.me@ttaylorr.com>
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
index faa8f84c5a1..56e8b4e6af4 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -91,7 +91,7 @@ static struct object_id push_cert_oid;
 static struct signature_check sigcheck;
 static const char *push_cert_nonce;
 static const char *cert_nonce_seed;
-static struct string_list hidden_refs = STRING_LIST_INIT_DUP;
+static struct strvec hidden_refs = STRVEC_INIT;
 
 static const char *NONCE_UNSOLICITED = "UNSOLICITED";
 static const char *NONCE_BAD = "BAD";
@@ -2621,7 +2621,7 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 		packet_flush(1);
 	oid_array_clear(&shallow);
 	oid_array_clear(&ref);
-	string_list_clear(&hidden_refs, 0);
+	strvec_clear(&hidden_refs);
 	free((void *)push_cert_nonce);
 	return 0;
 }
diff --git a/ls-refs.c b/ls-refs.c
index 65d1fa9029e..9291ddfdf8c 100644
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
 
@@ -156,7 +156,7 @@ int ls_refs(struct repository *r, struct packet_reader *request)
 	memset(&data, 0, sizeof(data));
 	strvec_init(&data.prefixes);
 	strbuf_init(&data.buf, 0);
-	string_list_init_dup(&data.hidden_refs);
+	strvec_init(&data.hidden_refs);
 
 	git_config(ls_refs_config, &data);
 
@@ -198,7 +198,7 @@ int ls_refs(struct repository *r, struct packet_reader *request)
 	packet_fflush(stdout);
 	strvec_clear(&data.prefixes);
 	strbuf_release(&data.buf);
-	string_list_clear(&data.hidden_refs, 0);
+	strvec_clear(&data.hidden_refs);
 	return 0;
 }
 
diff --git a/refs.c b/refs.c
index 7e5cd84bf28..64dabc40cae 100644
--- a/refs.c
+++ b/refs.c
@@ -1429,7 +1429,7 @@ char *shorten_unambiguous_ref(const char *refname, int strict)
 }
 
 int parse_hide_refs_config(const char *var, const char *value, const char *section,
-			   struct string_list *hide_refs)
+			   struct strvec *hide_refs)
 {
 	const char *key;
 	if (!strcmp("transfer.hiderefs", var) ||
@@ -1440,22 +1440,23 @@ int parse_hide_refs_config(const char *var, const char *value, const char *secti
 
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
index 1ca1cdb9da5..fa3ce4b0bc1 100644
--- a/refs.h
+++ b/refs.h
@@ -820,7 +820,7 @@ int update_ref(const char *msg, const char *refname,
 	       unsigned int flags, enum action_on_err onerr);
 
 int parse_hide_refs_config(const char *var, const char *value, const char *,
-			   struct string_list *);
+			   struct strvec *);
 
 /*
  * Check whether a ref is hidden. If no namespace is set, both the first and
@@ -830,7 +830,7 @@ int parse_hide_refs_config(const char *var, const char *value, const char *,
  * the ref is outside that namespace, the first parameter is NULL. The second
  * parameter always points to the full ref name.
  */
-int ref_is_hidden(const char *, const char *, const struct string_list *);
+int ref_is_hidden(const char *, const char *, const struct strvec *);
 
 /* Is this a per-worktree ref living in the refs/ namespace? */
 int is_per_worktree_ref(const char *refname);
diff --git a/revision.c b/revision.c
index af11d599d35..a15b18fc8e6 100644
--- a/revision.c
+++ b/revision.c
@@ -1561,7 +1561,7 @@ void init_ref_exclusions(struct ref_exclusions *exclusions)
 void clear_ref_exclusions(struct ref_exclusions *exclusions)
 {
 	string_list_clear(&exclusions->excluded_refs, 0);
-	string_list_clear(&exclusions->hidden_refs, 0);
+	strvec_clear(&exclusions->hidden_refs);
 	exclusions->hidden_refs_configured = 0;
 }
 
diff --git a/revision.h b/revision.h
index 25776af3815..7f219cde62f 100644
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
index 946074920a8..cfb61ccbb5c 100644
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
 
@@ -1471,7 +1471,7 @@ static int parse_want(struct packet_writer *writer, const char *line,
 
 static int parse_want_ref(struct packet_writer *writer, const char *line,
 			  struct string_list *wanted_refs,
-			  struct string_list *hidden_refs,
+			  struct strvec *hidden_refs,
 			  struct object_array *want_obj)
 {
 	const char *refname_nons;
-- 
2.41.0.343.gdff068c469f

