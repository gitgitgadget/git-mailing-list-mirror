Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A8FC432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 04:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81C4B6101C
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 04:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhHZE33 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 00:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhHZE32 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 00:29:28 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77A4C061757
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 21:28:41 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id c129-20020a1c35870000b02902e6b6135279so1340137wma.0
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 21:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+6deMlDfv9ppABDgoPZ+fUCEjR9BCAFjj1c7bS5gr6w=;
        b=OjXDIwPWEa44UTYmHGPLmg44+rodlGJFKc4hIDzzLaGHJYNUN7jfWTRuH5zSZ9szan
         8iDosIwxJMqVHS2vhwvbte2Vnh0TWWdzQ4xKWLeRq3cT1oiYhvcMXYRXL7Ods8SbKcOo
         Vp+bzKAxrgjkeKBT0mFvtokjrF9U7nzq7NBcyaDUJQ0lehLu8gq4tuJbA3EbtOMvSUGa
         PBLld3BXnA0nSFoMuJnuQ6RqrtcuLC6WxJ3g7q9vGggK0NBv66kVxMkdhxlgTHO35k2O
         PcOjgwAqNO1fuL/w/i32YAUsBWXK2nCYQLvpO7Rsr2A4MeInP81WQaO307JcIniS6OlA
         FyOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+6deMlDfv9ppABDgoPZ+fUCEjR9BCAFjj1c7bS5gr6w=;
        b=KkUuvcaD5SN0CxOvDJtpCvmhgpOaknTMsnoVd6DfKByo9K9xQel80aCxAgdcnBRpGG
         XkK4GfjaX5xlRnqJAYKmqzBFZhWufqH5EIEmcFRyv7xYRd+o3/Ip3QSjMwb2rZvfg8s5
         I4j8fFJirlkKBPQxECf90p4lpkZF8qrjgi9GGdiaKPB4gDAXfczjPluoOmkjqV7boKnN
         XZUId8NGsxnsbNsmuH2ce2cxw6cJpy+Wl2FGuHJoERfkvZLTCjJfFMPHL3rRMIAckuRb
         mJthYQJrLmc3r+TESMLSlb68iQfc80SxjyMKoqgOHAMW2n63jjDauedSpimWsm/Mm/18
         +xZA==
X-Gm-Message-State: AOAM533ZC5KY2u888FH8a2cT5FB7hTaKoywUIU4g7ZHg6d3wQYaZ49aF
        AOcBt+D9waPmvgeeWCSfoQ6T2bl8jLU=
X-Google-Smtp-Source: ABdhPJxoypPcsQGliWy1YonvocM3x/1WBHz/uoLgnNFE7fe5YGmh0zlsIC0OstMi6krZGGeF1eFgNA==
X-Received: by 2002:a7b:cb01:: with SMTP id u1mr1524141wmj.152.1629952120434;
        Wed, 25 Aug 2021 21:28:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o8sm1310562wmp.42.2021.08.25.21.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 21:28:40 -0700 (PDT)
Message-Id: <pull.1074.v2.git.git.1629952119446.gitgitgadget@gmail.com>
In-Reply-To: <pull.1074.git.git.1629736918861.gitgitgadget@gmail.com>
References: <pull.1074.git.git.1629736918861.gitgitgadget@gmail.com>
From:   "Maksym Sobolyev via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 26 Aug 2021 04:28:39 +0000
Subject: [PATCH v2] Make ident dynamic, not just a hardcoded value of "$Id".
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philip Oakley <philipoakley@iee.email>,
        Maksym Sobolyev <sobomax@gmail.com>,
        Maksym Sobolyev <sobomax@sippysoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Maksym Sobolyev <sobomax@sippysoft.com>

This allows ident to be something like $FreeBSD$ so it provides matching
functionality for repos migrated from CVS / SVN.

This works by allowing ident to have a parameter, i.e.:

* ident=MyCustomId

In .gitattributes.

Signed-off-by: Maksym Sobolyev <sobomax@sippysoft.com>
---
    Make ident dynamic, not just a hardcoded value of "$Id".
    
    This allows ident to be something like $FreeBSD$ so it provides matching
    functionality for repos migrated from CVS / SVN.
    
    This works by allowing ident to have a parameter, i.e.:
    
    * ident=MyCustomId
    
    In .gitattributes.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1074%2Fsobomax%2Fpr-custom_ident-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1074/sobomax/pr-custom_ident-v2
Pull-Request: https://github.com/git/git/pull/1074

Range-diff vs v1:

 1:  52e0adde935 ! 1:  16713788a26 Make ident dynamic, not just a hardcoded value of "$Id".
     @@ Commit message
      
          Signed-off-by: Maksym Sobolyev <sobomax@sippysoft.com>
      
     + ## Documentation/gitattributes.txt ##
     +@@ Documentation/gitattributes.txt: sign `$` upon checkout.  Any byte sequence that begins with
     + `$Id:` and ends with `$` in the worktree file is replaced
     + with `$Id$` upon check-in.
     + 
     ++The `ident` attribute can also provide an optional value,
     ++which if supplied is going to be used for expansion instead of
     ++the string `Id`.
     ++
     ++------------------------
     ++*.[ch]		ident=FreeBSD
     ++------------------------
     ++
     + 
     + `filter`
     + ^^^^^^^^
     +
       ## builtin/checkout--worker.c ##
      @@ builtin/checkout--worker.c: static void packet_to_pc_item(const char *buffer, int len,
       			      struct parallel_checkout_item *pc_item)


 Documentation/gitattributes.txt         |   8 ++
 builtin/checkout--worker.c              |  17 +++-
 convert.c                               | 114 +++++++++++++++---------
 convert.h                               |   7 +-
 parallel-checkout.c                     |  11 ++-
 parallel-checkout.h                     |   8 +-
 t/t2082-parallel-checkout-attributes.sh |   7 +-
 7 files changed, 116 insertions(+), 56 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 83fd4e19a41..9e486f3e8d3 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -382,6 +382,14 @@ sign `$` upon checkout.  Any byte sequence that begins with
 `$Id:` and ends with `$` in the worktree file is replaced
 with `$Id$` upon check-in.
 
+The `ident` attribute can also provide an optional value,
+which if supplied is going to be used for expansion instead of
+the string `Id`.
+
+------------------------
+*.[ch]		ident=FreeBSD
+------------------------
+
 
 `filter`
 ^^^^^^^^
diff --git a/builtin/checkout--worker.c b/builtin/checkout--worker.c
index fb9fd13b73c..61ba39402ad 100644
--- a/builtin/checkout--worker.c
+++ b/builtin/checkout--worker.c
@@ -9,7 +9,7 @@ static void packet_to_pc_item(const char *buffer, int len,
 			      struct parallel_checkout_item *pc_item)
 {
 	const struct pc_item_fixed_portion *fixed_portion;
-	const char *variant;
+	const char *variant, *ident_action;
 	char *encoding;
 
 	if (len < sizeof(struct pc_item_fixed_portion))
@@ -19,7 +19,8 @@ static void packet_to_pc_item(const char *buffer, int len,
 	fixed_portion = (struct pc_item_fixed_portion *)buffer;
 
 	if (len - sizeof(struct pc_item_fixed_portion) !=
-		fixed_portion->name_len + fixed_portion->working_tree_encoding_len)
+		fixed_portion->name_len + fixed_portion->working_tree_encoding_len +
+		fixed_portion->ident_action_len)
 		BUG("checkout worker received corrupted item");
 
 	variant = buffer + sizeof(struct pc_item_fixed_portion);
@@ -43,11 +44,21 @@ static void packet_to_pc_item(const char *buffer, int len,
 	pc_item->ce->ce_namelen = fixed_portion->name_len;
 	pc_item->ce->ce_mode = fixed_portion->ce_mode;
 	memcpy(pc_item->ce->name, variant, pc_item->ce->ce_namelen);
+	variant += pc_item->ce->ce_namelen;
 	oidcpy(&pc_item->ce->oid, &fixed_portion->oid);
 
+	if (fixed_portion->ident_action_len) {
+		ident_action = xmemdupz(variant,
+					fixed_portion->ident_action_len);
+		variant += fixed_portion->ident_action_len;
+	} else {
+		ident_action = NULL;
+	}
+
 	pc_item->id = fixed_portion->id;
 	pc_item->ca.crlf_action = fixed_portion->crlf_action;
-	pc_item->ca.ident = fixed_portion->ident;
+	pc_item->ca.ident_action.id = ident_action;
+	pc_item->ca.ident_action.id_len = fixed_portion->ident_action_len;
 	pc_item->ca.working_tree_encoding = encoding;
 }
 
diff --git a/convert.c b/convert.c
index 0d6fb3410ae..1e8940bf9d7 100644
--- a/convert.c
+++ b/convert.c
@@ -1056,7 +1056,12 @@ static int read_convert_config(const char *var, const char *value, void *cb)
 	return 0;
 }
 
-static int count_ident(const char *cp, unsigned long size)
+#define ID_STR "Id"
+
+#define GIT_MAX_IDENT_LEN 255
+
+static int count_ident(const char *cp, unsigned long size,
+		       const struct ident_action *idact)
 {
 	/*
 	 * "$Id: 0000000000000000000000000000000000000000 $" <=> "$Id$"
@@ -1069,13 +1074,13 @@ static int count_ident(const char *cp, unsigned long size)
 		size--;
 		if (ch != '$')
 			continue;
-		if (size < 3)
+		if (size < idact->id_len + 1)
 			break;
-		if (memcmp("Id", cp, 2))
+		if (memcmp(idact->id, cp, idact->id_len))
 			continue;
-		ch = cp[2];
-		cp += 3;
-		size -= 3;
+		ch = cp[idact->id_len];
+		cp += idact->id_len + 1;
+		size -= idact->id_len + 1;
 		if (ch == '$')
 			cnt++; /* $Id$ */
 		if (ch != ':')
@@ -1099,11 +1104,11 @@ static int count_ident(const char *cp, unsigned long size)
 }
 
 static int ident_to_git(const char *src, size_t len,
-			struct strbuf *buf, int ident)
+			struct strbuf *buf, const struct ident_action *idact)
 {
 	char *dst, *dollar;
 
-	if (!ident || (src && !count_ident(src, len)))
+	if (!idact->id || (src && !count_ident(src, len, idact)))
 		return 0;
 
 	if (!buf)
@@ -1122,17 +1127,18 @@ static int ident_to_git(const char *src, size_t len,
 		len -= dollar + 1 - src;
 		src  = dollar + 1;
 
-		if (len > 3 && !memcmp(src, "Id:", 3)) {
-			dollar = memchr(src + 3, '$', len - 3);
+		if (len > idact->id_len + 1 && !memcmp(src, idact->id, idact->id_len) && src[idact->id_len + 1] == ':') {
+			dollar = memchr(src + idact->id_len + 1, '$', len - (idact->id_len + 1));
 			if (!dollar)
 				break;
-			if (memchr(src + 3, '\n', dollar - src - 3)) {
+			if (memchr(src + idact->id_len + 1, '\n', dollar - src - (idact->id_len + 1))) {
 				/* Line break before the next dollar. */
 				continue;
 			}
 
-			memcpy(dst, "Id$", 3);
-			dst += 3;
+			memcpy(dst, idact->id, idact->id_len);
+			dst[idact->id_len] = '$';
+			dst += idact->id_len + 1;
 			len -= dollar + 1 - src;
 			src  = dollar + 1;
 		}
@@ -1143,16 +1149,16 @@ static int ident_to_git(const char *src, size_t len,
 }
 
 static int ident_to_worktree(const char *src, size_t len,
-			     struct strbuf *buf, int ident)
+			     struct strbuf *buf, const struct ident_action *idact)
 {
 	struct object_id oid;
 	char *to_free = NULL, *dollar, *spc;
 	int cnt;
 
-	if (!ident)
+	if (!idact->id)
 		return 0;
 
-	cnt = count_ident(src, len);
+	cnt = count_ident(src, len, idact);
 	if (!cnt)
 		return 0;
 
@@ -1161,7 +1167,7 @@ static int ident_to_worktree(const char *src, size_t len,
 		to_free = strbuf_detach(buf, NULL);
 	hash_object_file(the_hash_algo, src, len, "blob", &oid);
 
-	strbuf_grow(buf, len + cnt * (the_hash_algo->hexsz + 3));
+	strbuf_grow(buf, len + cnt * (the_hash_algo->hexsz + idact->id_len + 1));
 	for (;;) {
 		/* step 1: run to the next '$' */
 		dollar = memchr(src, '$', len);
@@ -1172,14 +1178,14 @@ static int ident_to_worktree(const char *src, size_t len,
 		src  = dollar + 1;
 
 		/* step 2: does it looks like a bit like Id:xxx$ or Id$ ? */
-		if (len < 3 || memcmp("Id", src, 2))
+		if (len < idact->id_len + 1 || memcmp(idact->id, src, idact->id_len))
 			continue;
 
 		/* step 3: skip over Id$ or Id:xxxxx$ */
-		if (src[2] == '$') {
-			src += 3;
-			len -= 3;
-		} else if (src[2] == ':') {
+		if (src[idact->id_len] == '$') {
+			src += idact->id_len + 1;
+			len -= idact->id_len + 1;
+		} else if (src[idact->id_len] == ':') {
 			/*
 			 * It's possible that an expanded Id has crept its way into the
 			 * repository, we cope with that by stripping the expansion out.
@@ -1187,18 +1193,18 @@ static int ident_to_worktree(const char *src, size_t len,
 			 * on checkout, which won't go away by stash, but let's keep it
 			 * for git-style ids.
 			 */
-			dollar = memchr(src + 3, '$', len - 3);
+			dollar = memchr(src + idact->id_len + 1, '$', len - (idact->id_len + 1));
 			if (!dollar) {
 				/* incomplete keyword, no more '$', so just quit the loop */
 				break;
 			}
 
-			if (memchr(src + 3, '\n', dollar - src - 3)) {
+			if (memchr(src + idact->id_len + 1, '\n', dollar - src - (idact->id_len + 1))) {
 				/* Line break before the next dollar. */
 				continue;
 			}
 
-			spc = memchr(src + 4, ' ', dollar - src - 4);
+			spc = memchr(src + idact->id_len + 2, ' ', dollar - src - (idact->id_len + 2));
 			if (spc && spc < dollar-1) {
 				/* There are spaces in unexpected places.
 				 * This is probably an id from some other
@@ -1215,7 +1221,8 @@ static int ident_to_worktree(const char *src, size_t len,
 		}
 
 		/* step 4: substitute */
-		strbuf_addstr(buf, "Id: ");
+		strbuf_addstr(buf, idact->id);
+		strbuf_addstr(buf, ": ");
 		strbuf_addstr(buf, oid_to_hex(&oid));
 		strbuf_addstr(buf, " $");
 	}
@@ -1286,11 +1293,21 @@ static struct convert_driver *git_path_check_convert(struct attr_check_item *che
 	return NULL;
 }
 
-static int git_path_check_ident(struct attr_check_item *check)
+static struct ident_action git_path_check_ident(struct attr_check_item *check)
 {
+	struct ident_action idact = {.id = NULL, .id_len = 0};
 	const char *value = check->value;
 
-	return !!ATTR_TRUE(value);
+	if (!ATTR_UNSET(value) && !ATTR_FALSE(value)) {
+		if (ATTR_TRUE(value))
+			idact.id = ID_STR;
+		else
+			idact.id = value;
+		idact.id_len = strlen(idact.id);
+		if (idact.id_len > GIT_MAX_IDENT_LEN)
+			die(_("ident value length exceeds GIT_MAX_IDENT_LEN"));
+	}
+	return idact;
 }
 
 static struct attr_check *check;
@@ -1313,7 +1330,7 @@ void convert_attrs(struct index_state *istate,
 	ca->crlf_action = git_path_check_crlf(ccheck + 4);
 	if (ca->crlf_action == CRLF_UNDEFINED)
 		ca->crlf_action = git_path_check_crlf(ccheck + 0);
-	ca->ident = git_path_check_ident(ccheck + 1);
+	ca->ident_action = git_path_check_ident(ccheck + 1);
 	ca->drv = git_path_check_convert(ccheck + 2);
 	if (ca->crlf_action != CRLF_BINARY) {
 		enum eol eol_attr = git_path_check_eol(ccheck + 3);
@@ -1433,7 +1450,7 @@ int convert_to_git(struct index_state *istate,
 			len = dst->len;
 		}
 	}
-	return ret | ident_to_git(src, len, dst, ca.ident);
+	return ret | ident_to_git(src, len, dst, &ca.ident_action);
 }
 
 void convert_to_git_filter_fd(struct index_state *istate,
@@ -1450,7 +1467,7 @@ void convert_to_git_filter_fd(struct index_state *istate,
 
 	encode_to_git(path, dst->buf, dst->len, dst, ca.working_tree_encoding, conv_flags);
 	crlf_to_git(istate, path, dst->buf, dst->len, dst, ca.crlf_action, conv_flags);
-	ident_to_git(dst->buf, dst->len, dst, ca.ident);
+	ident_to_git(dst->buf, dst->len, dst, &ca.ident_action);
 }
 
 static int convert_to_working_tree_ca_internal(const struct conv_attrs *ca,
@@ -1462,7 +1479,7 @@ static int convert_to_working_tree_ca_internal(const struct conv_attrs *ca,
 {
 	int ret = 0, ret_filter = 0;
 
-	ret |= ident_to_worktree(src, len, dst, ca->ident);
+	ret |= ident_to_worktree(src, len, dst, &(ca->ident_action));
 	if (ret) {
 		src = dst->buf;
 		len = dst->len;
@@ -1810,7 +1827,8 @@ struct ident_filter {
 	struct stream_filter filter;
 	struct strbuf left;
 	int state;
-	char ident[GIT_MAX_HEXSZ + 5]; /* ": x40 $" */
+	const struct ident_action *idact;
+	char ident[GIT_MAX_HEXSZ + GIT_MAX_IDENT_LEN + 3]; /* ": x40 $" */
 };
 
 static int is_foreign_ident(const char *str)
@@ -1847,13 +1865,16 @@ static int ident_filter_fn(struct stream_filter *filter,
 			   char *output, size_t *osize_p)
 {
 	struct ident_filter *ident = (struct ident_filter *)filter;
-	static const char head[] = "$Id";
+	const struct ident_action *idact = ident->idact;
 
 	if (!input) {
 		/* drain upon eof */
 		switch (ident->state) {
 		default:
-			strbuf_add(&ident->left, head, ident->state);
+			if (ident->state > 0)
+				strbuf_addch(&ident->left, '$');
+			if (ident->state > 1)
+				strbuf_add(&ident->left, idact->id, ident->state - 1);
 			/* fallthrough */
 		case IDENT_SKIPPING:
 			/* fallthrough */
@@ -1885,22 +1906,26 @@ static int ident_filter_fn(struct stream_filter *filter,
 			if (ch != '\n' && ch != '$')
 				continue;
 			if (ch == '$' && !is_foreign_ident(ident->left.buf)) {
-				strbuf_setlen(&ident->left, sizeof(head) - 1);
+				strbuf_setlen(&ident->left, idact->id_len + 1);
 				strbuf_addstr(&ident->left, ident->ident);
 			}
 			ident->state = IDENT_DRAINING;
 			continue;
 		}
 
-		if (ident->state < sizeof(head) &&
-		    head[ident->state] == ch) {
+		if ((ident->state == 0 && ch == '$') ||
+		    (ident->state > 0 && ident->state < idact->id_len + 1 &&
+		     idact->id[ident->state - 1] == ch)) {
 			ident->state++;
 			continue;
 		}
 
-		if (ident->state)
-			strbuf_add(&ident->left, head, ident->state);
-		if (ident->state == sizeof(head) - 1) {
+		if (ident->state) {
+			strbuf_addch(&ident->left, '$');
+			if (ident->state > 1)
+				strbuf_add(&ident->left, idact->id, ident->state - 1);
+		}
+		if (ident->state == idact->id_len + 1) {
 			if (ch != ':' && ch != '$') {
 				strbuf_addch(&ident->left, ch);
 				ident->state = 0;
@@ -1935,7 +1960,7 @@ static struct stream_filter_vtbl ident_vtbl = {
 	ident_free_fn,
 };
 
-static struct stream_filter *ident_filter(const struct object_id *oid)
+static struct stream_filter *ident_filter(const struct object_id *oid, const struct ident_action *idact)
 {
 	struct ident_filter *ident = xmalloc(sizeof(*ident));
 
@@ -1944,6 +1969,7 @@ static struct stream_filter *ident_filter(const struct object_id *oid)
 	strbuf_init(&ident->left, 0);
 	ident->filter.vtbl = &ident_vtbl;
 	ident->state = 0;
+	ident->idact = idact;
 	return (struct stream_filter *)ident;
 }
 
@@ -1963,8 +1989,8 @@ struct stream_filter *get_stream_filter_ca(const struct conv_attrs *ca,
 	if (classify_conv_attrs(ca) != CA_CLASS_STREAMABLE)
 		return NULL;
 
-	if (ca->ident)
-		filter = ident_filter(oid);
+	if (ca->ident_action.id)
+		filter = ident_filter(oid, &(ca->ident_action));
 
 	if (output_eol(ca->crlf_action) == EOL_CRLF)
 		filter = cascade_filter(filter, lf_to_crlf_filter());
diff --git a/convert.h b/convert.h
index 5ee1c322058..a02632e8104 100644
--- a/convert.h
+++ b/convert.h
@@ -76,11 +76,16 @@ enum convert_crlf_action {
 
 struct convert_driver;
 
+struct ident_action {
+	const char *id;
+	int id_len;
+};
+
 struct conv_attrs {
 	struct convert_driver *drv;
 	enum convert_crlf_action attr_action; /* What attr says */
 	enum convert_crlf_action crlf_action; /* When no attr is set, use core.autocrlf */
-	int ident;
+	struct ident_action ident_action; /* What ident says */
 	const char *working_tree_encoding; /* Supported encoding or default encoding if NULL */
 };
 
diff --git a/parallel-checkout.c b/parallel-checkout.c
index ddc0ff3c064..f9a3f2ff25b 100644
--- a/parallel-checkout.c
+++ b/parallel-checkout.c
@@ -403,13 +403,15 @@ static void send_one_item(int fd, struct parallel_checkout_item *pc_item)
 	size_t name_len = pc_item->ce->ce_namelen;
 	size_t working_tree_encoding_len = working_tree_encoding ?
 					   strlen(working_tree_encoding) : 0;
+	const char *ident_action_id = pc_item->ca.ident_action.id;
+	size_t ident_action_len = pc_item->ca.ident_action.id_len;
 
 	/*
 	 * Any changes in the calculation of the message size must also be made
 	 * in is_eligible_for_parallel_checkout().
 	 */
 	len_data = sizeof(struct pc_item_fixed_portion) + name_len +
-		   working_tree_encoding_len;
+		   working_tree_encoding_len + ident_action_len;
 
 	data = xmalloc(len_data);
 
@@ -417,7 +419,7 @@ static void send_one_item(int fd, struct parallel_checkout_item *pc_item)
 	fixed_portion->id = pc_item->id;
 	fixed_portion->ce_mode = pc_item->ce->ce_mode;
 	fixed_portion->crlf_action = pc_item->ca.crlf_action;
-	fixed_portion->ident = pc_item->ca.ident;
+	fixed_portion->ident_action_len = ident_action_len;
 	fixed_portion->name_len = name_len;
 	fixed_portion->working_tree_encoding_len = working_tree_encoding_len;
 	/*
@@ -434,6 +436,11 @@ static void send_one_item(int fd, struct parallel_checkout_item *pc_item)
 		variant += working_tree_encoding_len;
 	}
 	memcpy(variant, pc_item->ce->name, name_len);
+	variant += name_len;
+	if (ident_action_len) {
+		memcpy(variant, ident_action_id, ident_action_len);
+		variant += ident_action_len;
+	}
 
 	packet_write(fd, data, len_data);
 
diff --git a/parallel-checkout.h b/parallel-checkout.h
index 80f539bcb77..c3c282f516b 100644
--- a/parallel-checkout.h
+++ b/parallel-checkout.h
@@ -76,9 +76,9 @@ struct parallel_checkout_item {
 
 /*
  * The fixed-size portion of `struct parallel_checkout_item` that is sent to the
- * workers. Following this will be 2 strings: ca.working_tree_encoding and
- * ce.name; These are NOT null terminated, since we have the size in the fixed
- * portion.
+ * workers. Following this will be 3 strings: ca.working_tree_encoding, ca.name
+ * and ca.ident_action.id; These are NOT null terminated, since we have the size
+ * in the fixed portion.
  *
  * Note that not all fields of conv_attrs and cache_entry are passed, only the
  * ones that will be required by the workers to smudge and write the entry.
@@ -88,7 +88,7 @@ struct pc_item_fixed_portion {
 	struct object_id oid;
 	unsigned int ce_mode;
 	enum convert_crlf_action crlf_action;
-	int ident;
+	size_t ident_action_len;
 	size_t working_tree_encoding_len;
 	size_t name_len;
 };
diff --git a/t/t2082-parallel-checkout-attributes.sh b/t/t2082-parallel-checkout-attributes.sh
index 25254579618..822957a8dc8 100755
--- a/t/t2082-parallel-checkout-attributes.sh
+++ b/t/t2082-parallel-checkout-attributes.sh
@@ -20,16 +20,19 @@ test_expect_success 'parallel-checkout with ident' '
 	(
 		cd ident &&
 		echo "A ident" >.gitattributes &&
+		echo "C ident=MyCusomVeryLongAndWordyId" >>.gitattributes &&
 		echo "\$Id\$" >A &&
 		echo "\$Id\$" >B &&
+		echo "\$MyCusomVeryLongAndWordyId\$" >C &&
 		git add -A &&
 		git commit -m id &&
 
-		rm A B &&
+		rm A B C &&
 		test_checkout_workers 2 git reset --hard &&
 		hexsz=$(test_oid hexsz) &&
 		grep -E "\\\$Id: [0-9a-f]{$hexsz} \\\$" A &&
-		grep "\\\$Id\\\$" B
+		grep "\\\$Id\\\$" B &&
+		grep -E "\\\$MyCusomVeryLongAndWordyId: [0-9a-f]{$hexsz} \\\$" C
 	)
 '
 

base-commit: 225bc32a989d7a22fa6addafd4ce7dcd04675dbf
-- 
gitgitgadget
