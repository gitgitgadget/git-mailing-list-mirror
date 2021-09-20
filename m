Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A102C433F5
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 07:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0481860F43
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 07:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbhITHj1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 03:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbhITHj0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 03:39:26 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677A7C061574
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 00:38:00 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id u15so27152703wru.6
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 00:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=blQ+cVm9OEZHapnbg1mSMctN+/I/DON69Z3kmJtfdew=;
        b=drwYpFK1V+RwxQ/QSSuRTiQwAkAPhKXffTWxoHK50DvsFMa70rb9THHkzR7vpJk798
         BKF2exVuanCPiYjCr8zPD/73DD1YWSRzkwxa2Xk8bE9CDpFm4bs28PL7yfkooQHMc0aQ
         z2VgMqYe+KL0650ZKXQyjVO8Y4ZJDGhZVVMXBlNmMMT4t9U7J4rm0SGCAJQNekHRlt0U
         75tovMHs3/k8QZGm2nZavdiIUjHzZxJnBUFo/4fJFKlQYN4c+jIrrj73OHzAeCJW4/p+
         JqrW8fTpl3EwEL6Ffvh8DT1fllDbJa6mQs+J3dde3j7D4YHRhixo+thBMo9ZEKuhYOlI
         8LvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=blQ+cVm9OEZHapnbg1mSMctN+/I/DON69Z3kmJtfdew=;
        b=XfMN6pouvcKCtZ4e3Jwb5kXx+zTD/5A3wSwznS3QrZQfgyj7AQgSV3Ntt4mElIKdWF
         78ma4XV0DP4QDfcgij3GJV6ePwJc/UdRCRu/fd+Nv+XRpjHkwAnPSkyllbepv0QWrbcJ
         bTz2d/Db4lcDygVXMc1bH3o55ApXSD0CZXw3BkOZ1ng1Je7VU4YMUIHqcyg1AjDkrtiq
         cWH2qVGvEnJC76COgYJsg0u4VOq6EnxSA51pInU1yNVQmP/lESPXagVxQDzFJUjnM730
         G8khi2kxEGnW6qv+YKfigaV4Db7/V4q3cMeBYvOmm053FOhZg2eIw3+Ib9y8KOUlvhMp
         xu2g==
X-Gm-Message-State: AOAM533LpeXPWOJEjhuufJElKikKap5mn1/VVNxWNQOtbp2Idwnpvlhv
        exG2jKnacWsGujqGBKFhVpTTIC7GwwE=
X-Google-Smtp-Source: ABdhPJyXozvu9hoP72Fnsug3hD5KkSHEQ5iyqV2yInyktdhH72C/R2blVW2oFoSCVQIyWfCM1w+g9A==
X-Received: by 2002:a5d:6b46:: with SMTP id x6mr26458701wrw.192.1632123479055;
        Mon, 20 Sep 2021 00:37:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c135sm18607114wme.6.2021.09.20.00.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 00:37:58 -0700 (PDT)
Message-Id: <22b69757e33d310e78232dbe520a1995486ec918.1632123476.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1042.git.1632123476.gitgitgadget@gmail.com>
References: <pull.1042.git.1632123476.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Sep 2021 07:37:53 +0000
Subject: [PATCH 1/4] refs: let repo_dwim_ref() learn get symref itself and ref
 flags
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

expand_ref() can use to resolve a ref to its fullname, A symref will
also be resolved to the fullref name it refers to. But sometimes we
want get symref itself. So add a need_symref parameter to
repo_dwim_ref() and expand_ref(), which can help us get symref its
fullref name. At the same time, we add ref_flags parameter to
expand_ref() and repo_dwim_ref(), when it is set, it can get the
ref's flag from refs_resolve_ref_unsafe(), which can help us provide
ref's flags for interfaces like pretty_print_ref() later.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 object-name.c |  6 +++---
 refs.c        | 15 ++++++++++-----
 refs.h        |  8 +++++---
 upload-pack.c |  2 +-
 4 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/object-name.c b/object-name.c
index fdff4601b2c..a8cb1d6ab14 100644
--- a/object-name.c
+++ b/object-name.c
@@ -803,7 +803,7 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
 
 	if (len == r->hash_algo->hexsz && !get_oid_hex(str, oid)) {
 		if (warn_ambiguous_refs && warn_on_object_refname_ambiguity) {
-			refs_found = repo_dwim_ref(r, str, len, &tmp_oid, &real_ref, 0);
+			refs_found = repo_dwim_ref(r, str, len, &tmp_oid, &real_ref, 0, 0, 0);
 			if (refs_found > 0) {
 				warning(warn_msg, len, str);
 				if (advice_enabled(ADVICE_OBJECT_NAME_WARNING))
@@ -854,11 +854,11 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
 
 	if (!len && reflog_len)
 		/* allow "@{...}" to mean the current branch reflog */
-		refs_found = repo_dwim_ref(r, "HEAD", 4, oid, &real_ref, 0);
+		refs_found = repo_dwim_ref(r, "HEAD", 4, oid, &real_ref, 0, 0, 0);
 	else if (reflog_len)
 		refs_found = repo_dwim_log(r, str, len, oid, &real_ref);
 	else
-		refs_found = repo_dwim_ref(r, str, len, oid, &real_ref, 0);
+		refs_found = repo_dwim_ref(r, str, len, oid, &real_ref, 0, 0, 0);
 
 	if (!refs_found)
 		return -1;
diff --git a/refs.c b/refs.c
index 8b9f7c3a80a..67618a09992 100644
--- a/refs.c
+++ b/refs.c
@@ -637,17 +637,19 @@ static char *substitute_branch_name(struct repository *r,
 }
 
 int repo_dwim_ref(struct repository *r, const char *str, int len,
-		  struct object_id *oid, char **ref, int nonfatal_dangling_mark)
+		  struct object_id *oid, char **ref, int nonfatal_dangling_mark,
+		  int *ref_flags, int need_symref)
 {
 	char *last_branch = substitute_branch_name(r, &str, &len,
 						   nonfatal_dangling_mark);
-	int   refs_found  = expand_ref(r, str, len, oid, ref);
+	int   refs_found  = expand_ref(r, str, len, oid, ref, ref_flags, need_symref);
 	free(last_branch);
 	return refs_found;
 }
 
 int expand_ref(struct repository *repo, const char *str, int len,
-	       struct object_id *oid, char **ref)
+	       struct object_id *oid, char **ref, int *ref_flags,
+	       int need_symref)
 {
 	const char **p, *r;
 	int refs_found = 0;
@@ -666,8 +668,11 @@ int expand_ref(struct repository *repo, const char *str, int len,
 					    fullref.buf, RESOLVE_REF_READING,
 					    this_result, &flag);
 		if (r) {
-			if (!refs_found++)
-				*ref = xstrdup(r);
+			if (!refs_found++) {
+				*ref = xstrdup(need_symref ? fullref.buf : r);
+				if (ref_flags)
+					*ref_flags = flag;
+			}
 			if (!warn_ambiguous_refs)
 				break;
 		} else if ((flag & REF_ISSYMREF) && strcmp(fullref.buf, "HEAD")) {
diff --git a/refs.h b/refs.h
index 48970dfc7e0..1f977bdb188 100644
--- a/refs.h
+++ b/refs.h
@@ -152,15 +152,17 @@ int refname_match(const char *abbrev_name, const char *full_name);
 struct strvec;
 void expand_ref_prefix(struct strvec *prefixes, const char *prefix);
 
-int expand_ref(struct repository *r, const char *str, int len, struct object_id *oid, char **ref);
+int expand_ref(struct repository *r, const char *str, int len, struct object_id *oid, char **ref,
+	       int *ref_flags, int need_symref);
 int repo_dwim_ref(struct repository *r, const char *str, int len,
-		  struct object_id *oid, char **ref, int nonfatal_dangling_mark);
+		  struct object_id *oid, char **ref, int nonfatal_dangling_mark,
+		  int *ref_flags, int need_symref);
 int repo_dwim_log(struct repository *r, const char *str, int len, struct object_id *oid, char **ref);
 static inline int dwim_ref(const char *str, int len, struct object_id *oid,
 			   char **ref, int nonfatal_dangling_mark)
 {
 	return repo_dwim_ref(the_repository, str, len, oid, ref,
-			     nonfatal_dangling_mark);
+			     nonfatal_dangling_mark, 0, 0);
 }
 int dwim_log(const char *str, int len, struct object_id *oid, char **ref);
 
diff --git a/upload-pack.c b/upload-pack.c
index 6ce07231d3d..dfbdd6d9466 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -975,7 +975,7 @@ static int process_deepen_not(const char *line, struct string_list *deepen_not,
 	if (skip_prefix(line, "deepen-not ", &arg)) {
 		char *ref = NULL;
 		struct object_id oid;
-		if (expand_ref(the_repository, arg, strlen(arg), &oid, &ref) != 1)
+		if (expand_ref(the_repository, arg, strlen(arg), &oid, &ref, 0, 0) != 1)
 			die("git upload-pack: ambiguous deepen-not: %s", line);
 		string_list_append(deepen_not, ref);
 		free(ref);
-- 
gitgitgadget

