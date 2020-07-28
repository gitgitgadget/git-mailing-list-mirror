Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F66C433EA
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 20:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DEF8207F5
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 20:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6CdPCLu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729226AbgG1Upp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 16:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729195AbgG1Upn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 16:45:43 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490A7C0619D2
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 13:45:43 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f7so19573290wrw.1
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 13:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9vQZ4ifXHtx/wRNoLsdQs2xlgnxyqNe13TYnGQaQWtI=;
        b=K6CdPCLuTh3S90HvhspB3AOCmaFZN3vv9ThDMCPZS+rGMKxKYGBp+h4EURRroBSr4O
         a9UTLatj2bikZoNi1fBdIBciYoBcg+mdxLRE07trI18IbiuBuKe/60yNGJZ28n4x9oUR
         jgKM2mxYeC+9+BDy1W3hbsgOngQcjW3P/JS9CdJnfE53vxdGbbLhuU8AzN3dLUTaO8KP
         /I6V8czzJAbfm4LTjjh7oZv75mNHNdCL7VgJvPDDK6ANI6dqdYztdJ8gb1JDYYBudLSh
         sDZH8vIw5tmrf9TDR6wmbspSacSL52sE/vtuTs2+KOLnI5/yaXLafjBXdKAnM/Ae76Pn
         MFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9vQZ4ifXHtx/wRNoLsdQs2xlgnxyqNe13TYnGQaQWtI=;
        b=Yke9NZmoK7QDc6eOe5W+bXESWntqqNH2ldooszcZKJKFQFSkEYaKq5Kl2AYk06038c
         KlVnDJfbEP7gSTzNsKlsbMIaWp6RCuO43p6ZhQubcQDKn49rS2LjjPYOZ+KS8z2yFWgc
         ofc2pulZTJSJBAXpDzyktw8fdQ4pN0KxBzZMi/jxyvUxJB8Nd6pCooTCmF8SU07VUy+b
         GZwKxIvT+WnHKw0JNYSFu1TVVk11H1jor/ZisRF2zWIpyzCzcBTtApO8KAYfaU4metr1
         TSbfh2F7BJYyT8JXHP8E9nxmH08DfL7r5oBKgc9kLjP6B9kosZA6uXdQPkYvFS0jaSTf
         MRag==
X-Gm-Message-State: AOAM532dDI1w8AfAKE0aWs8vEl3HJGZfI3J6YSWCDOIqhnQhIZbPv0Vu
        llaQtuzLTgAKS8+7K2rHzbbFPxq/
X-Google-Smtp-Source: ABdhPJxF3JOEX6AbxQKO9vurjnd/SS6YCdd8n3HcA2NFIycC5E2ssFY0SllVE3QDdROuY/PWJuHxVQ==
X-Received: by 2002:adf:fe05:: with SMTP id n5mr19081951wrr.237.1595969141785;
        Tue, 28 Jul 2020 13:45:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m16sm18791325wrr.71.2020.07.28.13.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 13:45:41 -0700 (PDT)
Message-Id: <bbb8db27024298ed7264cee71e92376f62ac1073.1595969140.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.824.git.git.1595969139.gitgitgadget@gmail.com>
References: <pull.824.git.git.1595969139.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Jul 2020 20:45:38 +0000
Subject: [PATCH 1/2] Remove doubled words in various comments
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 fsmonitor.c                            | 2 +-
 t/t5510-fetch.sh                       | 2 +-
 t/t6046-merge-skip-unneeded-updates.sh | 2 +-
 t/t8014-blame-ignore-fuzzy.sh          | 2 +-
 wt-status.c                            | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index 932bd9012d..ed796e3e03 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -217,7 +217,7 @@ void refresh_fsmonitor(struct index_state *istate)
 				 * Need to use a char * variable because static
 				 * analysis was suggesting to use strbuf_addbuf
 				 * but we don't want to copy the entire strbuf
-				 * only the the chars up to the first NUL
+				 * only the chars up to the first NUL
 				 */
 				buf = query_result.buf;
 				strbuf_addstr(&last_update_token, buf);
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index a66dbe0bde..7456c567cd 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -797,7 +797,7 @@ test_configured_prune true  true  unset unset pruned pruned \
 	"--prune origin refs/tags/*:refs/tags/* +refs/heads/*:refs/remotes/origin/*"
 
 # --prune-tags on its own does nothing, needs --prune as well, same
-# for for fetch.pruneTags without fetch.prune
+# for fetch.pruneTags without fetch.prune
 test_configured_prune unset unset unset unset kept kept     "--prune-tags"
 test_configured_prune unset unset true unset  kept kept     ""
 test_configured_prune unset unset unset true  kept kept     ""
diff --git a/t/t6046-merge-skip-unneeded-updates.sh b/t/t6046-merge-skip-unneeded-updates.sh
index 1ddc9e6626..5a2d07e516 100755
--- a/t/t6046-merge-skip-unneeded-updates.sh
+++ b/t/t6046-merge-skip-unneeded-updates.sh
@@ -661,7 +661,7 @@ test_setup_4a () {
 }
 
 # NOTE: For as long as we continue using unpack_trees() without index_only
-#   set to true, it will error out on a case like this claiming the the locally
+#   set to true, it will error out on a case like this claiming that the locally
 #   modified file would be overwritten by the merge.  Getting this testcase
 #   correct requires doing the merge in-memory first, then realizing that no
 #   updates to the file are necessary, and thus that we can just leave the path
diff --git a/t/t8014-blame-ignore-fuzzy.sh b/t/t8014-blame-ignore-fuzzy.sh
index 6e61882b6f..e68e6115a6 100755
--- a/t/t8014-blame-ignore-fuzzy.sh
+++ b/t/t8014-blame-ignore-fuzzy.sh
@@ -248,7 +248,7 @@ Final
 EOF
 
 # The first line of b matches best with the last line of a, but the overall
-# match is better if we match it with the the first line of a.
+# match is better if we match it with the first line of a.
 title11="Piggy in the middle"
 cat <<EOF >a11
 abcdefg
diff --git a/wt-status.c b/wt-status.c
index c560cbe860..20f2075868 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -2035,7 +2035,7 @@ static void wt_porcelain_print(struct wt_status *s)
  *   [# branch.upstream <upstream><eol>
  *   [# branch.ab +<ahead> -<behind><eol>]]
  *
- *      <commit> ::= the current commit hash or the the literal
+ *      <commit> ::= the current commit hash or the literal
  *                   "(initial)" to indicate an initialized repo
  *                   with no commits.
  *
-- 
gitgitgadget

