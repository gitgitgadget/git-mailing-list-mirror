Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47504C00A89
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 20:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F25C822226
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 20:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J42FBMUF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbgKBUoc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 15:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbgKBUny (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 15:43:54 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E29CC0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 12:43:54 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id s21so16084331oij.0
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 12:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R3C39cbVAfVBp4LfrVFtVfvoxVJX09siz6Mw9R93DkU=;
        b=J42FBMUFUWYyZ9jju4EO3GsBZOwDvv0vBllJe6cAfM28tAql+6v1kgmjW/6F0W8Zn+
         /CS2OvDPaI9ur+YYOcPokJgQvitRaZpFP3a5bRr/uWvVRwR9yiFuXUuIXdrkideo46Tk
         YAidCp432YyWD44UmVShmvIpsqbVtQIgevGtgvYEMPnU7jl3rKURTgt/a24gWpnpHurj
         x5TrVQXrBuJP/ti0pxuaj+x1pWNxrqoX0D1v8tGOUiAJVURD1otHv3BgRY+oAr9uHXVt
         Yte48TBFsIlcUJ9QCT/6/AhoYF9CeXtmu/IA39jin+o4XvynAbcOZJ5ZNU55VMEfWmaS
         Ypkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R3C39cbVAfVBp4LfrVFtVfvoxVJX09siz6Mw9R93DkU=;
        b=U/iSChqz+7kWMfAnBqS8XW781cPBtkUA3aPyTBglwz526PMABVhnVuK1+1j3bxsWJj
         m+ESqzUla3PNfVwOXpMvhqBzH974a0C8s1aDF6p/y+3JirtCo7LJ5Jjgylx9OuMAP/uj
         pjwhWcOxzG9wFpE8CUVtQBKUC4OSMRwNNRnNX8It9kn5XCe8Pkx6fzUp0D5EaHIE6Lfw
         aM5AtOaceecCP0nOyqtx/eBV9XzOdDhU9wBtfL7OF5Zr5+iLaCtutoYTsZFF6pDjQHYf
         Xw9VG7vdiD+4pRorsyy90n56XqEpHBmWtdXu4QCwaBsnRkRVwDABoM0q3/oIIWENM/Xs
         3k6A==
X-Gm-Message-State: AOAM533pIdOF13OmWdr6p+gAM6FqU0lAQcp5qr1KnJIIIEuLlr1yBRke
        VgGJHjbHafNyizB32x5mvCInUrMjRmdDYg==
X-Google-Smtp-Source: ABdhPJz6aRLuP73XScjIc1mI6Wrlr760pBIY+It4XDlSsc+bok8zI20zRpuL7VtBtTtYkspd73LuXQ==
X-Received: by 2002:aca:3b0a:: with SMTP id i10mr11821429oia.167.1604349833781;
        Mon, 02 Nov 2020 12:43:53 -0800 (PST)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id t27sm3848512otc.14.2020.11.02.12.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 12:43:53 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 04/20] merge-ort: use histogram diff
Date:   Mon,  2 Nov 2020 12:43:28 -0800
Message-Id: <20201102204344.342633-5-newren@gmail.com>
X-Mailer: git-send-email 2.29.0.471.ga4f56089c0
In-Reply-To: <20201102204344.342633-1-newren@gmail.com>
References: <20201102204344.342633-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have some ideas for using a histogram diff to improve content merges,
which fundamentally relies on the idea of a histogram.  Since the diffs
are never displayed to the user but just used internally for merging,
the typical user preference shouldn't matter anyway, and I want to make
sure that all my testing works with this algorithm.

Granted, I don't yet know if those ideas will pan out and I haven't even
tried any of them out yet, but it's easy to change the diff algorithm in
the future if needed or wanted.  For now, just set it to histogram.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index f5460a8a52..df97a54773 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -21,6 +21,7 @@
 #include "diffcore.h"
 #include "strmap.h"
 #include "tree.h"
+#include "xdiff-interface.h"
 
 struct merge_options_internal {
 	struct strmap paths;    /* maps path -> (merged|conflict)_info */
@@ -137,6 +138,9 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 
 	assert(opt->priv == NULL);
 
+	/* Default to histogram diff.  Actually, just hardcode it...for now. */
+	opt->xdl_opts = DIFF_WITH_ALG(opt, HISTOGRAM_DIFF);
+
 	/* Initialization of opt->priv, our internal merge data */
 	opt->priv = xcalloc(1, sizeof(*opt->priv));
 	/*
-- 
2.29.0.471.ga4f56089c0

