Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDC8D1F461
	for <e@80x24.org>; Thu, 29 Aug 2019 18:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbfH2S2L (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 14:28:11 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34359 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729726AbfH2S2L (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Aug 2019 14:28:11 -0400
Received: by mail-wr1-f65.google.com with SMTP id s18so4469679wrn.1
        for <git@vger.kernel.org>; Thu, 29 Aug 2019 11:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lkitX9/Yct+qYCp+CzaX96mAr/7OypfSkTJZmiskgng=;
        b=qqahmYp9lcrBm0mVBtbrDmYw567JEQ82eCOxSKZAxCPWmUvih5Bs7nGZMF9BvDtr67
         Ag/1xzxuABj7myqzvPqPMrBdPq3uindHBQHCPOYruy2FYFgP2WJzfOBDu/xSCrY9GeGU
         i1n78eYQt6PoobDmCXUf4uLm3RYgwqv8bOYnLOBx165nR7pk5Qm/EY+yi3B9WYVxuF70
         VcSUDN7QwG9o1CUqZo2cry6i4a3Eszcyk14Rhv9IpXV6UYUH6qI27kasFYESbcxOVZdF
         C9oqNp7PGVz3mUoY7pDtVwH+fXOmb15iax2P6AiKLCH7jy+MJB1sA0EnoIUhi2xg+otc
         Zq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lkitX9/Yct+qYCp+CzaX96mAr/7OypfSkTJZmiskgng=;
        b=EQyjx5JEVS93vqjLS53kHCAvfPVbnjm+dZh8afe5SXUM/YLN5wj+oZjOojYnXMlE/S
         1dEQUQdPk3oOlITa4VWhpziTjod8dnHlx/p2MFE8bXM4AhoYdaJpZsF4jx6NI3dVBTA4
         32jD3eM9RLlVYzWBrUqnrBLi0BnIBTNpcNGXfMH/BED1zSJb9aOyedVbYlFwKmwldnLB
         4cjg+by7zZml297/UxkuH9rkwMTxz3mqgJ4TLtIcM5L3bNcPxeubckuw8yj9XcsXTz2r
         VRRE5dVgkIOByjel2hzBiBbeJvst9rOl6X8Et9wI5DZR/gkCOCWgr8wzCqzsqxEMMPvK
         7w9Q==
X-Gm-Message-State: APjAAAVXLkBCeqDFnT3T5MPvRP8M0GF3WwCCC708JH0SiYrJEqVZ8+5d
        PDLJTqOSEwgQpfCptu51ox+EAoUn
X-Google-Smtp-Source: APXvYqxDBjFYA7zogv+Ti/okBZVfNKZx4wPcLjHXQFIecQ0/LXM3os0mk+e4Wo3Cgk5TsyMl3o2ahQ==
X-Received: by 2002:adf:ea8f:: with SMTP id s15mr5971398wrm.222.1567103288971;
        Thu, 29 Aug 2019 11:28:08 -0700 (PDT)
Received: from localhost ([2.31.128.175])
        by smtp.gmail.com with ESMTPSA id c11sm2088361wrs.86.2019.08.29.11.28.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Aug 2019 11:28:08 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Joel Teichroeb <joel@teichroeb.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 2/3] merge: use refresh_and_write_cache
Date:   Thu, 29 Aug 2019 19:27:47 +0100
Message-Id: <20190829182748.43802-3-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.194.ge5444969c9
In-Reply-To: <20190829182748.43802-1-t.gummerer@gmail.com>
References: <20190827101408.76757-1-t.gummerer@gmail.com>
 <20190829182748.43802-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the 'refresh_and_write_cache()' convenience function introduced in
the last commit, instead of refreshing and writing the index manually
in merge.c

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/merge.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index e2ccbc44e2..0148d938c9 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -688,16 +688,13 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 			      struct commit_list *remoteheads,
 			      struct commit *head)
 {
-	struct lock_file lock = LOCK_INIT;
 	const char *head_arg = "HEAD";
 
-	hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
-	refresh_cache(REFRESH_QUIET);
-	if (write_locked_index(&the_index, &lock,
-			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
+	if (refresh_and_write_cache(REFRESH_QUIET, SKIP_IF_UNCHANGED) < 0)
 		return error(_("Unable to write index."));
 
 	if (!strcmp(strategy, "recursive") || !strcmp(strategy, "subtree")) {
+		struct lock_file lock = LOCK_INIT;
 		int clean, x;
 		struct commit *result;
 		struct commit_list *reversed = NULL;
@@ -860,12 +857,8 @@ static int merge_trivial(struct commit *head, struct commit_list *remoteheads)
 {
 	struct object_id result_tree, result_commit;
 	struct commit_list *parents, **pptr = &parents;
-	struct lock_file lock = LOCK_INIT;
 
-	hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
-	refresh_cache(REFRESH_QUIET);
-	if (write_locked_index(&the_index, &lock,
-			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
+	if (refresh_and_write_cache(REFRESH_QUIET, SKIP_IF_UNCHANGED) < 0)
 		return error(_("Unable to write index."));
 
 	write_tree_trivial(&result_tree);
-- 
2.23.0.rc2.194.ge5444969c9

