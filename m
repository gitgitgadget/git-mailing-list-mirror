Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBADC4361B
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 19:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C465721E92
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 19:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408584AbgLNTRw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 14:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395515AbgLNTRs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 14:17:48 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84953C0613D6
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 11:17:08 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id r3so17580080wrt.2
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 11:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=48lGBbObFRGKN4nTZYcg+Spo9THsI5se885GJiMmriQ=;
        b=Z1p8Tm3wz95KMApCzpJrRUkIeGZdKqF0KGQllu5kjGTUWaGoVOE8KGqUTzkH2tSjAG
         I0yMyOd41hg5s96KPzIPsCmRY9RHLUM0Gnun079OP1Dv1n5sS72P0ZCKUqVAtC/yT37n
         Jgi7LPwzPzLv/weeYbT7jUHC7zaFDhM/umpCczDGf+XDbAoUuN8uahN4pUyF52IViDhL
         2HbmmmAcBfn0yDYe+Q6Asq/GDin3UkhAubkxZxc3LNG4WnDeen/eevf5HdMnDyfm2TGF
         7CbvK5zGMlQWDcwn6joG8NhMFvLt+LiPhJP/atKi7L3pYZhy8aSBfmA71GCZicoSj8Jg
         kwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=48lGBbObFRGKN4nTZYcg+Spo9THsI5se885GJiMmriQ=;
        b=P6G0fW2gLDt6hsK7MhqQVIUqoF4CtsXFFM0mhaoaBiBsHdN23rrTmYfS0VaKb56fOY
         skGN/TheCvnDWdChHVvk4FWTXVteQO4qr7L668I1AxIQAK6d2Eu6blWaZZypi6KeUPMX
         QVNo7bLqyqAnztxUhkWrgxut6B2NNDRUv2T6/0BLC9j/5ePCMIuP6p45k7ZF+Fdd3kL0
         oVTXP4TIjI2wmhvDkg7Px1ZHiGIBu3JmGT6FI4jO0WABOGuKgXkh9w++aSlrx5AG/2EF
         +B+/zoUgAUTvmQ+JYhGq5drNznKxOywfeGOTD6zne6qmAKvIk8tz1QHZ8QHAJiYVKtrN
         41zg==
X-Gm-Message-State: AOAM530xGSgsVaueG+os+68xnlFmCyQhONrJKAtZHVGx8JCreBb11+3X
        OfWQQ/kUhWRqgk8QLrXfD1fOi9j9KVkd+Q==
X-Google-Smtp-Source: ABdhPJyijAldrWAQMEiMWKYWBghnpaQx0zwtdDpZ2aH+n0cbA6waYtfrcyAfygnYG5fEQmG/gRFF7A==
X-Received: by 2002:adf:cd8f:: with SMTP id q15mr29612615wrj.79.1607973427253;
        Mon, 14 Dec 2020 11:17:07 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s13sm32078616wmj.28.2020.12.14.11.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 11:17:06 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/2] refs: move is_pseudoref_syntax() earlier in the file
Date:   Mon, 14 Dec 2020 20:16:59 +0100
Message-Id: <20201214191700.16405-2-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201210125321.19456-2-avarab@gmail.com>
References: <20201210125321.19456-2-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This move is needed by a subsequent change to the expand_ref()
function, which will make use of these functions.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/refs.c b/refs.c
index 392f0bbf68b..3ec5dcba0be 100644
--- a/refs.c
+++ b/refs.c
@@ -630,6 +630,25 @@ int repo_dwim_ref(struct repository *r, const char *str, int len,
 	return refs_found;
 }
 
+static int is_pseudoref_syntax(const char *refname)
+{
+	const char *c;
+
+	for (c = refname; *c; c++) {
+		if (!isupper(*c) && *c != '-' && *c != '_')
+			return 0;
+	}
+
+	return 1;
+}
+
+static int is_main_pseudoref_syntax(const char *refname)
+{
+	return skip_prefix(refname, "main-worktree/", &refname) &&
+		*refname &&
+		is_pseudoref_syntax(refname);
+}
+
 int expand_ref(struct repository *repo, const char *str, int len,
 	       struct object_id *oid, char **ref)
 {
@@ -716,25 +735,6 @@ static int is_per_worktree_ref(const char *refname)
 	       starts_with(refname, "refs/rewritten/");
 }
 
-static int is_pseudoref_syntax(const char *refname)
-{
-	const char *c;
-
-	for (c = refname; *c; c++) {
-		if (!isupper(*c) && *c != '-' && *c != '_')
-			return 0;
-	}
-
-	return 1;
-}
-
-static int is_main_pseudoref_syntax(const char *refname)
-{
-	return skip_prefix(refname, "main-worktree/", &refname) &&
-		*refname &&
-		is_pseudoref_syntax(refname);
-}
-
 static int is_other_pseudoref_syntax(const char *refname)
 {
 	if (!skip_prefix(refname, "worktrees/", &refname))
-- 
2.29.2.222.g5d2a92d10f8

