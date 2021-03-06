Return-Path: <SRS0=58cf=IE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF622C43331
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 19:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D4B4650DA
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 19:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbhCFTfb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Mar 2021 14:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbhCFTfS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Mar 2021 14:35:18 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5074C06174A
        for <git@vger.kernel.org>; Sat,  6 Mar 2021 11:35:17 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id y124-20020a1c32820000b029010c93864955so1383195wmy.5
        for <git@vger.kernel.org>; Sat, 06 Mar 2021 11:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H8fi1Lus64w77i6PGkYGPRUgqUGl8V27vNlrXTmX4M8=;
        b=HS/P6kIpFyOrF/ZY+SOl34P94TRzjsfAihrqCetqCzyDUYBX5q3cllseUlmqIEjdt5
         sxDjFPc8jW8wfE3xnDJYED7w5FVa4Jsr7hCorfdiWaBn2xXs+juYhnUn1spM3RNKenil
         IAvSVyPg+4LZwpfCrOWcHdnxoCLxGn0n7kSrMztOUdxYD0Q4ekQ1+cK9g24WIyLRNebn
         xmfgkrbLXWOOtgqhfvcfw+MXsf4cAAqN7cjB9sZkmqTFwqHhI6g0MQPISD9JpEPtI6BZ
         yEv/A479mS974LpQzjore2T49Pp81m2qpuXssDhrGMtmtDsa5nn1nOjO4aLw78Y+kBLL
         +jTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H8fi1Lus64w77i6PGkYGPRUgqUGl8V27vNlrXTmX4M8=;
        b=FYi/4K3Eb4XARmpI1u9jwI3S5yVt4tfPLqukp80K4tL+pDEd02J1YF6skxAvZK1IcY
         mK17RcU0BJvfehzKFA+g++d+EfHIoylGrvRUF/ucyNhmwEPeAQfLsfyW/E/r+UqTFJs9
         TKS3lg2bNv2fiUcZ9L8ZvceS+CnweWYpaStE9JKZimv01PcuUzGcBbnM2+eNoII0/wlv
         A5P5TQlD1JbK4pzp6Bo7LMb62FgB7qD2BU9QrVLMUsD2zHcGmmtsZhrS3epnUJU7noGa
         +3ar3hXN4WuV1gSiMPUFcHkOF2v5ICeluoQMxzIcuxr3947xQbaQJrYMXQOalH6g3NvB
         cNWQ==
X-Gm-Message-State: AOAM533uLvQhW3oBGFepcLXuGuOqzj+XI6U+vVmcPVctXg6P77879Ktb
        nvSXr1NxA3mnepBh+XLoLDFO9hEv3j33iA==
X-Google-Smtp-Source: ABdhPJx1J0CK1jwGU3ATm3SLzryJh5QIl7GM4DnHSNgBNadeE2iFT3xk/87RjT6mmDrOL3/RGIp5Dg==
X-Received: by 2002:a05:600c:4f14:: with SMTP id l20mr13791917wmq.71.1615059316259;
        Sat, 06 Mar 2021 11:35:16 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a5sm9951578wrs.35.2021.03.06.11.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 11:35:15 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/7] merge-ort: move cmp_cache_name_compare() from tree.c
Date:   Sat,  6 Mar 2021 20:34:55 +0100
Message-Id: <20210306193458.20633-5-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <1240014568-3675-1-git-send-email-pclouds@gmail.com>
References: <1240014568-3675-1-git-send-email-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the cmp_cache_name_compare() function from tree.c. Now that we've
stopped using it in builtin/ls-files.c the merge-ort.c code is its
only user, let's just have it own it instead of having this API which
straddles tree.h and cache-tree.h in tree.c itself.

See these commits for its recent introduction in merge-ort.c::

 - 70912f66de7 (tree: enable cmp_cache_name_compare() to be used
   elsewhere, 2020-12-13)

 - ef2b3693870 (merge-ort: add implementation of
   record_conflicted_index_entries(), 2020-12-13)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 merge-ort.c | 10 ++++++++++
 tree.c      | 11 -----------
 tree.h      |  2 --
 3 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 603d30c5217..d7b3ced1bec 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -3099,6 +3099,16 @@ static int checkout(struct merge_options *opt,
 	return ret;
 }
 
+static int cmp_cache_name_compare(const void *a_, const void *b_)
+{
+	const struct cache_entry *ce1, *ce2;
+
+	ce1 = *((const struct cache_entry **)a_);
+	ce2 = *((const struct cache_entry **)b_);
+	return cache_name_stage_compare(ce1->name, ce1->ce_namelen, ce_stage(ce1),
+				  ce2->name, ce2->ce_namelen, ce_stage(ce2));
+}
+
 static int record_conflicted_index_entries(struct merge_options *opt,
 					   struct index_state *index,
 					   struct strmap *paths,
diff --git a/tree.c b/tree.c
index a6c12f2745a..c1bde9314d0 100644
--- a/tree.c
+++ b/tree.c
@@ -1,5 +1,4 @@
 #include "cache.h"
-#include "cache-tree.h"
 #include "tree.h"
 #include "object-store.h"
 #include "blob.h"
@@ -96,16 +95,6 @@ int read_tree_recursive(struct repository *r,
 	return ret;
 }
 
-int cmp_cache_name_compare(const void *a_, const void *b_)
-{
-	const struct cache_entry *ce1, *ce2;
-
-	ce1 = *((const struct cache_entry **)a_);
-	ce2 = *((const struct cache_entry **)b_);
-	return cache_name_stage_compare(ce1->name, ce1->ce_namelen, ce_stage(ce1),
-				  ce2->name, ce2->ce_namelen, ce_stage(ce2));
-}
-
 struct tree *lookup_tree(struct repository *r, const struct object_id *oid)
 {
 	struct object *obj = lookup_object(r, oid);
diff --git a/tree.h b/tree.h
index 84d66b45538..34549c86c9f 100644
--- a/tree.h
+++ b/tree.h
@@ -28,8 +28,6 @@ void free_tree_buffer(struct tree *tree);
 /* Parses and returns the tree in the given ent, chasing tags and commits. */
 struct tree *parse_tree_indirect(const struct object_id *oid);
 
-int cmp_cache_name_compare(const void *a_, const void *b_);
-
 #define READ_TREE_RECURSIVE 1
 typedef int (*read_tree_fn_t)(const struct object_id *, struct strbuf *, const char *, unsigned int, int, void *);
 
-- 
2.31.0.rc0.126.g04f22c5b82

