Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7EF0C433E0
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 15:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5501B64DF6
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 15:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbhBCPkh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 10:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233759AbhBCPh3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 10:37:29 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B1FC0617AB
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 07:35:04 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id 7so24889484wrz.0
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 07:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MgDPgj7GedDHVjjkk/EtAODaaSn6gWGGMNTT5xfwao8=;
        b=V+mKj7cJJyNtxgGouSqUoTiX7DRys5A6SO1HnXnj5SJuYTVVZNCaqSOYO5Fn2Ydgol
         xW0bX/iDw3soTZzEk8+YeVLYfL/PGW2zzxNNKGVlCDSEQRj9lSDSGEtNOxcJlfdhOUeM
         B2Rl2T6gp1qZgDYpIXHou+rixr/W/8Csf0hm7tb7myRcSX4P3leZy+C5XLSLpPEgSgim
         fdciuKA+xLQjOM7dQOpo9hAolK6DQnM/qzbxKSXpNIj4iAAG5I90C2G+otKAbdaVM1FV
         o/uZwbxQvSmaQzSiOLwYgB5pciP2GFWt9ZMUARM4goaolJHleRdngKw2uE+7ibZZZQGA
         vHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MgDPgj7GedDHVjjkk/EtAODaaSn6gWGGMNTT5xfwao8=;
        b=uOKeLQi4TL5JpiVJQXWSgn8XXVgznvvTdYNwRpx4kfmZyLVoBccFZTUNj8P8Zoyyi1
         Upukpb5Z7RGT6cDD7WBfKjJBYz52XpxCLz7v9aBDyBo16lRTubXIN73aaX6hbAD40sTb
         wurGHpvAslPldYksLSt67yIrhOTJUmF/gYxxAORbUZ8aOvsVmFllpi7WG/gJbU8QmNLb
         EZ0uuQUWrMFp/6hxYW0FE1/5uexTgO5RostYkXPnMY4SDC50Kx8Q5b8jrkMT3Oi65uIp
         bYMMOEAe1Dd+it58MYXZbQ8ilRg+3V77anXBi+neO9tCQSi5Cj350bfAeC0ZmMrm0yBe
         rWiQ==
X-Gm-Message-State: AOAM531Bk2VjG0UmUlIa2mdHk+JJiUKB0eGNgHCK/SlSpt7zf8/p/FuT
        CIAslXxImSMy1wRuajUGWM5Zr97wa5w=
X-Google-Smtp-Source: ABdhPJwjGhcmZwlLENWbnmKe5WjJqoVuD3bJ7Mc/vy5ThvAumzmgfVaRQ2+HEDiotgE7oenr76ZQOg==
X-Received: by 2002:a5d:4051:: with SMTP id w17mr4136063wrp.186.1612366502972;
        Wed, 03 Feb 2021 07:35:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q63sm3212479wma.43.2021.02.03.07.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 07:35:02 -0800 (PST)
Message-Id: <2ac66f07a59abe84c0105d5d97560fc3b22a9955.1612366490.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.860.v2.git.1612366490.gitgitgadget@gmail.com>
References: <pull.860.git.1612216941.gitgitgadget@gmail.com>
        <pull.860.v2.git.1612366490.gitgitgadget@gmail.com>
From:   "Kevin Willford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 03 Feb 2021 15:34:49 +0000
Subject: [PATCH v2 10/11] fsmonitor: allow all entries for a folder to be
 invalidated
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Kevin Willford <Kevin.Willford@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Kevin Willford <Kevin.Willford@microsoft.com>

Allow fsmonitor to report directory changes by reporting paths with a
trailing slash.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Kevin Willford <Kevin.Willford@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fsmonitor.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index 3105dc370ab..64deeda597e 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -190,13 +190,34 @@ int fsmonitor_is_trivial_response(const struct strbuf *query_result)
 	return is_trivial;
 }
 
-static void fsmonitor_refresh_callback(struct index_state *istate, const char *name)
+static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
 {
-	int pos = index_name_pos(istate, name, strlen(name));
+	int i, len = strlen(name);
+	if (name[len - 1] == '/') {
+
+		/*
+		 * TODO We should binary search to find the first path with
+		 * TODO this directory prefix.  Then linearly update entries
+		 * TODO while the prefix matches.  Taking care to search without
+		 * TODO the trailing slash -- because '/' sorts after a few
+		 * TODO interesting special chars, like '.' and ' '.
+		 */
+
+		/* Mark all entries for the folder invalid */
+		for (i = 0; i < istate->cache_nr; i++) {
+			if (istate->cache[i]->ce_flags & CE_FSMONITOR_VALID &&
+			    starts_with(istate->cache[i]->name, name))
+				istate->cache[i]->ce_flags &= ~CE_FSMONITOR_VALID;
+		}
+		/* Need to remove the / from the path for the untracked cache */
+		name[len - 1] = '\0';
+	} else {
+		int pos = index_name_pos(istate, name, strlen(name));
 
-	if (pos >= 0) {
-		struct cache_entry *ce = istate->cache[pos];
-		ce->ce_flags &= ~CE_FSMONITOR_VALID;
+		if (pos >= 0) {
+			struct cache_entry *ce = istate->cache[pos];
+			ce->ce_flags &= ~CE_FSMONITOR_VALID;
+		}
 	}
 
 	/*
-- 
gitgitgadget

