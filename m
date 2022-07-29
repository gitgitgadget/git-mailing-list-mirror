Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822DFC19F29
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 10:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235871AbiG2KNK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 06:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235840AbiG2KNC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 06:13:02 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022108211C
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 03:13:00 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id q22so467808pfn.9
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 03:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=atlDfg1foabhhTZLmnsD28rOmc+iC4glHa9thVBxofo=;
        b=fbPEBNZqT9uyIz5l2WCgTHTgUvRGhMc0uMM7QqSv93b40Feoh2JHZGY9TLk1jwmmbB
         pTJivQdYznnfeNcVHiAqP2R56H8fSrLu0G4gT4BIct1lk2RrX84CKRKsN8P4F89hBOTr
         cjX9Vu0ZQs5rG09GuHMlMtUfvrqQIg2Ch04U2a+yfWiSkwUaJSzLw+/SrBePo2v8G8HM
         1sRpPTydlQ8HqXI1folGQ/fvtZ8mKjTCDq5RPlwqmIGUr5X2+5kJ6irrsiCyigR6nYEo
         Ul1XWxZrHBXQKGh0BAsCW8vg8W2eaMR4HXnz01QVnYyIg57GxODBMnULGf2GGDvot/ix
         bDYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=atlDfg1foabhhTZLmnsD28rOmc+iC4glHa9thVBxofo=;
        b=m2KjWZ5r3lVCZoP2d/4Zqrk3t2TVd3s3n7ULCYZZ9ECi7Q6iYf4ZJE8QpRV3+87FUt
         ZTgds0T+pb04PTKoeaT5fjU51mx/jKFeet+adV5X9LxKr44jpg0EqtczDo8lpWYXjugT
         iDdV39CqxJVA8MDqVj2a0oFJAges2jLc4uVW0vuxfOoCtia/j/UMg3QU1GyZs61CQWIB
         pBejd0f6Ug9Icnj+IiZ/Z2hgxdkjkpvg4VRNLogCHvN1snWYlRcQgzDlEsquNm/OhhRV
         t0CavK6PSuRGDcE+RpKwe/QBCuGvwnevCThsOfs0KFowOY5EKqkjh5lf+LAQLITkUpl/
         18vA==
X-Gm-Message-State: AJIora/32N1fryeDsSK0YufTR3HFqoTGzgP/eZxqEWGPdxlOdyWi7xnf
        oGwhIXf2elZro4lOmy0RXg4XupHztTneMg==
X-Google-Smtp-Source: AGRyM1tdywHQCmyH6M1aPbwe5JGObSPcr7aRyDSMCu5l3wMGOSUaEXocyQH/Ge1ishRtj6OJsJDqWQ==
X-Received: by 2002:a63:5c22:0:b0:41a:56e8:27d with SMTP id q34-20020a635c22000000b0041a56e8027dmr2386539pgb.22.1659089580049;
        Fri, 29 Jul 2022 03:13:00 -0700 (PDT)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090322cf00b0016c4fb6e0b2sm3207797plg.55.2022.07.29.03.12.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jul 2022 03:12:59 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH 7/9] refs: get error message via refs_update_ref_extended()
Date:   Fri, 29 Jul 2022 18:12:43 +0800
Message-Id: <20220729101245.6469-8-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20220729101245.6469-1-worldhello.net@gmail.com>
References: <20220729101245.6469-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

The last parameter for "refs_update_ref_extended()" is an enum
"action_on_err", and we can not use this function to get the specific
error message. Extend this function again to get error message.

We will use the function "refs_update_ref_extended()" to reimplement
the function "files_copy_or_rename_ref()" in later commit.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 refs.c | 50 +++++++++++++++++++++++++-------------------------
 refs.h |  2 +-
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/refs.c b/refs.c
index e53f011e6b..60c741a584 100644
--- a/refs.c
+++ b/refs.c
@@ -1185,11 +1185,29 @@ int refs_update_ref(struct ref_store *refs, const char *msg,
 		    enum action_on_err onerr)
 {
 	struct reflog_info reflog_info;
+	struct strbuf err = STRBUF_INIT;
+	int ret;
 
 	reflog_info.msg = (char *)msg;
 	reflog_info.old_oid = NULL;
-	return refs_update_ref_extended(refs, refname, new_oid, old_oid,
-					flags, &reflog_info, onerr);
+	ret = refs_update_ref_extended(refs, refname, new_oid, old_oid,
+				       flags, &reflog_info, &err);
+	if (ret) {
+		const char *str = _("update_ref failed for ref '%s': %s");
+
+		switch (onerr) {
+		case UPDATE_REFS_MSG_ON_ERR:
+			error(str, refname, err.buf);
+			break;
+		case UPDATE_REFS_DIE_ON_ERR:
+			die(str, refname, err.buf);
+			break;
+		case UPDATE_REFS_QUIET_ON_ERR:
+			break;
+		}
+	}
+	strbuf_release(&err);
+	return ret;
 }
 
 int refs_update_ref_extended(struct ref_store *refs,
@@ -1198,37 +1216,19 @@ int refs_update_ref_extended(struct ref_store *refs,
 			     const struct object_id *old_oid,
 			     unsigned int flags,
 			     const struct reflog_info *reflog_info,
-			     enum action_on_err onerr)
+			     struct strbuf *err)
 {
 	struct ref_transaction *t = NULL;
-	struct strbuf err = STRBUF_INIT;
-	int ret = 0;
 
-	t = ref_store_transaction_begin(refs, &err);
+	t = ref_store_transaction_begin(refs, err);
 	if (!t ||
 	    ref_transaction_update_extended(t, refname, new_oid, old_oid,
-					    flags, reflog_info, &err) ||
-	    ref_transaction_commit(t, &err)) {
-		ret = 1;
+					    flags, reflog_info, err) ||
+	    ref_transaction_commit(t, err)) {
 		ref_transaction_free(t);
-	}
-	if (ret) {
-		const char *str = _("update_ref failed for ref '%s': %s");
-
-		switch (onerr) {
-		case UPDATE_REFS_MSG_ON_ERR:
-			error(str, refname, err.buf);
-			break;
-		case UPDATE_REFS_DIE_ON_ERR:
-			die(str, refname, err.buf);
-			break;
-		case UPDATE_REFS_QUIET_ON_ERR:
-			break;
-		}
-		strbuf_release(&err);
 		return 1;
 	}
-	strbuf_release(&err);
+
 	if (t)
 		ref_transaction_free(t);
 	return 0;
diff --git a/refs.h b/refs.h
index 0f21ba259f..85832c4863 100644
--- a/refs.h
+++ b/refs.h
@@ -825,7 +825,7 @@ int refs_update_ref_extended(struct ref_store *refs,
 			     const struct object_id *old_oid,
 			     unsigned int flags,
 			     const struct reflog_info *reflog_info,
-			     enum action_on_err onerr);
+			     struct strbuf *err);
 int update_ref(const char *msg, const char *refname,
 	       const struct object_id *new_oid, const struct object_id *old_oid,
 	       unsigned int flags, enum action_on_err onerr);
-- 
2.36.1.25.gc87d5ad63a.dirty

