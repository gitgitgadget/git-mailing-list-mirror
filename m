Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B3DB20899
	for <e@80x24.org>; Wed, 23 Aug 2017 12:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754027AbdHWMht (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 08:37:49 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35213 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753834AbdHWMhr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 08:37:47 -0400
Received: by mail-pg0-f67.google.com with SMTP id m133so1398211pga.2
        for <git@vger.kernel.org>; Wed, 23 Aug 2017 05:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eYPFRr2ObF95DotmevyGM3PFAnt1GucVgLyaq+oDNbU=;
        b=WD+mnSWF/8SZ1LDzr58Ns8byF1c1DJVRI4CRq58agmOuOOSqjMEQwaoyrCP/9BUSye
         glmexTh5YvMthGXmH9qBVVhKtfdFsjaN0zx+ohv/es8lkQaumB277sBn1oMPXt3jmfLu
         3NtZ+ZDMKN7tTarMlVzgpyJ18LBu8U5GMOODKTalyMDKdLVWXYv9CDWzrlzKqq50a9hl
         hbE0Pqm5Y+dB4FPI9b6A1Jz32i4LduN9Ip6FRuWYAILisc9mYDrvl48Qd0/sgoZyctpV
         8wSo4OrHiq8pJ/Q3wGDsudfCwHeoYttnLQzBTRmcK8Ac5oD4GfxXOCTNkw0GHfggfnTa
         oH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eYPFRr2ObF95DotmevyGM3PFAnt1GucVgLyaq+oDNbU=;
        b=Z0PqwiRISizapfBUakSagLM7QNTmECWEO3k1J7e0z+qaUNf4Zx1ETKc2IzPZHTBpYf
         GUFfCtDNJz3pQUFLud8eT0v8hVNRbICggjL09pgNzL8bcI1yoHLqAnGAztQqPcb500zf
         hSkAIAqpXMTXCl4q4LfySEisj2v5kzYEmBwckj7BtdFE4jpQ7KZ2K42TNgl5rK93AxZq
         ezhWkFrQ5tozTXbxHJBrErdnvFdrlR4oDCOYzzobBVVrbgT5VVdneq+6rj/UNNKqfqT6
         L/oTW3v5+trx5vHLChkvTRJAVsdZT9qDtuX++XETFMSzq60JADOLzsRHXo3wQVVAEfYN
         4zUg==
X-Gm-Message-State: AHYfb5iOiaBGTuMfsohPYAuoqBE6Jfq5KEQbxYJfHbaFy+IvS64tYcgF
        7Zt776Ct0arodgbY
X-Received: by 10.98.156.150 with SMTP id u22mr2600681pfk.237.1503491867263;
        Wed, 23 Aug 2017 05:37:47 -0700 (PDT)
Received: from ash ([115.72.183.215])
        by smtp.gmail.com with ESMTPSA id 86sm3142245pfm.105.2017.08.23.05.37.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Aug 2017 05:37:46 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 23 Aug 2017 19:37:42 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 04/16] revision.c: --indexed-objects add objects from all worktrees
Date:   Wed, 23 Aug 2017 19:36:52 +0700
Message-Id: <20170823123704.16518-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170823123704.16518-1-pclouds@gmail.com>
References: <20170823123704.16518-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the result of single_worktree flag never being set (no way to up
until now). To get objects from current index only, set single_worktree.

The other add_index_objects_to_pending's caller is mark_reachable_objects()
(e.g. "git prune") which also mark objects from all indexes.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 revision.c       | 21 +++++++++++++++++++++
 t/t5304-prune.sh |  9 +++++++++
 2 files changed, 30 insertions(+)

diff --git a/revision.c b/revision.c
index 6c46ad6c8a..f35cb49af5 100644
--- a/revision.c
+++ b/revision.c
@@ -19,6 +19,7 @@
 #include "dir.h"
 #include "cache-tree.h"
 #include "bisect.h"
+#include "worktree.h"
 
 volatile show_early_output_fn_t show_early_output;
 
@@ -1290,8 +1291,28 @@ static void do_add_index_objects_to_pending(struct rev_info *revs,
 
 void add_index_objects_to_pending(struct rev_info *revs, unsigned int flags)
 {
+	struct worktree **worktrees, **p;
+
 	read_cache();
 	do_add_index_objects_to_pending(revs, &the_index);
+
+	if (revs->single_worktree)
+		return;
+
+	worktrees = get_worktrees(0);
+	for (p = worktrees; *p; p++) {
+		struct worktree *wt = *p;
+		struct index_state istate = { NULL };
+
+		if (wt->is_current)
+			continue; /* current index already taken care of */
+
+		if (read_index_from(&istate,
+				    worktree_git_path(wt, "index")) > 0)
+			do_add_index_objects_to_pending(revs, &istate);
+		discard_index(&istate);
+	}
+	free_worktrees(worktrees);
 }
 
 static int add_parents_only(struct rev_info *revs, const char *arg_, int flags,
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index 133b5842b1..cba45c7be9 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -283,4 +283,13 @@ test_expect_success 'prune: handle alternate object database' '
 	git -C B prune
 '
 
+test_expect_success 'prune: handle index in multiple worktrees' '
+	git worktree add second-worktree &&
+	echo "new blob for second-worktree" >second-worktree/blob &&
+	git -C second-worktree add blob &&
+	git prune --expire=now &&
+	git -C second-worktree show :blob >actual &&
+	test_cmp second-worktree/blob actual
+'
+
 test_done
-- 
2.11.0.157.gd943d85

