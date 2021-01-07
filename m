Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9881CC433E9
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 16:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AB26233FC
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 16:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbhAGQdj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 11:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728735AbhAGQdh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 11:33:37 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304C9C0612FE
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 08:32:23 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d13so6191850wrc.13
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 08:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=2sQ7U1FWgBOX7rWhIg5mwDJ4gGLWmHnYWn6oA+HXRLA=;
        b=IqdMywB74uQbQePWMYVKi4HLn8qkLGyABEwxJu8/1cHh8K+HMuEr3qVc7XB1Sx55QF
         PdMUWarURR4APz7ZsrFOhZsR//sjlQ5rIIZiU/hnyOTe2Jd9/VX/AQOiBn2FFAVjih3Z
         /xYM0AVhwWtXT3gm1v3f49z1om3xLg+YoMdIZQ46AXA8JxECQzQsgC2cO/quV/R3+DB5
         BlcEODoDzv19PIsqcAvC9i+gbP82G84TY3j14Sbrt4RhB5j015G9yg33YcPZ3TEJeTwu
         XbIW26X6yOcRm6gfmGyVrbo3TJmLxDabqVhLrpdKf9IaxHcd75ODx+odW5OIzVZUOUlc
         1uFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=2sQ7U1FWgBOX7rWhIg5mwDJ4gGLWmHnYWn6oA+HXRLA=;
        b=gTNojeRCx0JvGf+c03f1R5TmP88w7N00tCV6aYIlktMc6gJMVfdh3LXeHqJnitDvhg
         c7g0Mm/61RJM2uq3NiX/TmNwsu5UnuUqqesWdjCB7c1hvFF/iUo3CdpcvheupGuKb2pj
         HkI1q5GD4yeiP8JIyEkNIZtDW0w7MkRlm4KxyK71thmoxGwjkGZPJH8mHsQ6Xbdd7et0
         mjhxgyC5cHEqjS93WmFZ3jjEg+LmUz5U22wUVTSx5hkQh3988Fqu51GGtbnOyClxS8F7
         xfJGGcmMcu+iFseZCNyk2dKNCMb4OJIHxnDwgMg0AerXM24NlLBDwMrM+wBNgxPfTta3
         NgSw==
X-Gm-Message-State: AOAM533Q8fOyd6lOPNNeADZXN14o3FmUVAmNypXMsRHyNAfXMjtV10Tq
        ckodyypaCjAvIMUP7qRAiLiO9SPdpU0=
X-Google-Smtp-Source: ABdhPJz7ggX6lD1j3/8W7KsoDN2yWKTa1WNJtcrQHRMIS/36aQ7FoZ9xSGsN+Tt16UaXW/p9jZkNgg==
X-Received: by 2002:adf:f5c5:: with SMTP id k5mr10060794wrp.286.1610037141806;
        Thu, 07 Jan 2021 08:32:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o8sm8917137wrm.17.2021.01.07.08.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 08:32:21 -0800 (PST)
Message-Id: <2532f5cc1898fa1652e828f26fb83c8b211a18f0.1610037132.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.829.v3.git.1610037131.gitgitgadget@gmail.com>
References: <pull.829.v2.git.1609729758.gitgitgadget@gmail.com>
        <pull.829.v3.git.1610037131.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Ren=C3=A9=20Scharfe?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Thu, 07 Jan 2021 16:32:10 +0000
Subject: [PATCH v3 09/10] cache-tree: use ce_namelen() instead of strlen()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>

Use the name length field of cache entries instead of calculating its
value anew.

Signed-off-by: René Scharfe <l.s.r@web.de>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 cache-tree.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 7da59b2aa07..4274de75bac 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -185,10 +185,12 @@ static int verify_cache(struct cache_entry **cache,
 		 * the cache is sorted.  Also path can appear only once,
 		 * which means conflicting one would immediately follow.
 		 */
-		const char *this_name = cache[i]->name;
-		const char *next_name = cache[i+1]->name;
-		int this_len = strlen(this_name);
-		if (this_len < strlen(next_name) &&
+		const struct cache_entry *this_ce = cache[i];
+		const struct cache_entry *next_ce = cache[i + 1];
+		const char *this_name = this_ce->name;
+		const char *next_name = next_ce->name;
+		int this_len = ce_namelen(this_ce);
+		if (this_len < ce_namelen(next_ce) &&
 		    strncmp(this_name, next_name, this_len) == 0 &&
 		    next_name[this_len] == '/') {
 			if (10 < ++funny) {
-- 
gitgitgadget

