Return-Path: <SRS0=qItC=6C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979F7C38A29
	for <git@archiver.kernel.org>; Sat, 18 Apr 2020 16:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 741FE22244
	for <git@archiver.kernel.org>; Sat, 18 Apr 2020 16:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEm/zWT5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgDRQEC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Apr 2020 12:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727783AbgDRQDz (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 18 Apr 2020 12:03:55 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6C0C0610D5
        for <git@vger.kernel.org>; Sat, 18 Apr 2020 09:03:55 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id w65so2655629pfc.12
        for <git@vger.kernel.org>; Sat, 18 Apr 2020 09:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JYboaKpjAoYwIKr0RNOYcugoTKy6HS62FUf5oeWWZHc=;
        b=DEm/zWT5GICEGJB5EESzXuzcY90Pc//t4X9aRtChwKkBIUgvqz4ePzeHQ1SIuVQlf/
         w8HT6T0h0Oz7RPGFdPzavzg/GhxzX3VjR4nXeJpQV92G7WBLPotoVVIcnGOvUXuab9cm
         Z1pwnJeo36mvNrmkQyQFeuC/RJtMPn7EeCDyLRUDmAMf9GTecTZpQiDw/7JPi9jVs/dI
         sB8x4Vaghfr3RcDcnjZMGggzYebPkaAYzvdPKNv/rA7k5o0bCrIFOaYYNbhtFVSkf4mA
         FZXM/xWITC4nJEEKI+7lwXDct9raFbmCW5ivmoshw5mXmc/xyiA1QVdzosqp61+svh+0
         FVNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JYboaKpjAoYwIKr0RNOYcugoTKy6HS62FUf5oeWWZHc=;
        b=heUzE8ELYa8AHzCNtqbFnyPz6aHqheYpmmSWcpleBZJkK84sH2+s884b19BTnCJ20c
         /oKVYtgVH9f+Mq+qV3IpLL8JAH/e/Wo86c7VThHCefeZXPMouvZmpdk47ab/QBe8ZhVi
         u6r/JQCi2aFk7RUG7T89QF1CHp6n4nBDhEq8PXPoch7n22SXj5G7gTmUKmKnamXw9iix
         JFETfD9Wk79WWGlxwjLsevwQE2UK8v+Ls5K/bE+q/DrdAahmTdmc4OpEjbDtOhb6FmkL
         E5VTSmw3vW7VtVpS+IQD9mlmEEKxqbFRHc7yTU6bXMw54JJ4jocu0uN224Zum4EwqmG0
         bybw==
X-Gm-Message-State: AGi0PuY6Yce4V/6GgYr1Ra/DOgpVfPx3cBMWSQ0/diAMZiAfQ2YfsXpA
        s7qNldByqIT1Wy2xUYrwUJY=
X-Google-Smtp-Source: APiQypKCXKEmSpziPp/2olqZdrrCpIaMOrTVPuVUn2ftwJqEvAHvgO+LED+XtGmWzdHVfcHmfGsDBw==
X-Received: by 2002:aa7:96c1:: with SMTP id h1mr8868674pfq.212.1587225834604;
        Sat, 18 Apr 2020 09:03:54 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id i187sm22461649pfg.33.2020.04.18.09.03.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Apr 2020 09:03:54 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v13 6/8] refs.c: refactor to reuse ref_is_hidden()
Date:   Sat, 18 Apr 2020 12:03:32 -0400
Message-Id: <20200418160334.15631-7-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200414123257.27449-1-worldhello.net@gmail.com>
References: <20200414123257.27449-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Add new function `ref_is_matched()` to reuse `ref_is_hidden()`. Will use
this function for `receive-pack` to check commands with specific
prefixes.

Test case t5512 covered this change.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 refs.c | 13 +++++++++----
 refs.h |  1 +
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 1ab0bb54d3..a20f56a463 100644
--- a/refs.c
+++ b/refs.c
@@ -1388,14 +1388,14 @@ int parse_hide_refs_config(const char *var, const char *value, const char *secti
 	return 0;
 }
 
-int ref_is_hidden(const char *refname, const char *refname_full)
+int ref_matches(struct string_list *match_refs, const char *refname, const char *refname_full)
 {
 	int i;
 
-	if (!hide_refs)
+	if (!match_refs)
 		return 0;
-	for (i = hide_refs->nr - 1; i >= 0; i--) {
-		const char *match = hide_refs->items[i].string;
+	for (i = match_refs->nr - 1; i >= 0; i--) {
+		const char *match = match_refs->items[i].string;
 		const char *subject;
 		int neg = 0;
 		const char *p;
@@ -1421,6 +1421,11 @@ int ref_is_hidden(const char *refname, const char *refname_full)
 	return 0;
 }
 
+int ref_is_hidden(const char *refname, const char *refname_full)
+{
+	return ref_matches(hide_refs, refname, refname_full);
+}
+
 const char *find_descendant_ref(const char *dirname,
 				const struct string_list *extras,
 				const struct string_list *skip)
diff --git a/refs.h b/refs.h
index 545029c6d8..d02c72d3ad 100644
--- a/refs.h
+++ b/refs.h
@@ -739,6 +739,7 @@ int parse_hide_refs_config(const char *var, const char *value, const char *);
  * parameter always points to the full ref name.
  */
 int ref_is_hidden(const char *, const char *);
+int ref_matches(struct string_list *, const char *, const char *);
 
 enum ref_type {
 	REF_TYPE_PER_WORKTREE,	  /* refs inside refs/ but not shared       */
-- 
2.24.1.15.g448c31058d.agit.4.5

