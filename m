Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79B5E20323
	for <e@80x24.org>; Sat, 18 Mar 2017 10:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751164AbdCRKMf (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 06:12:35 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33585 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751208AbdCRKM3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 06:12:29 -0400
Received: by mail-pg0-f67.google.com with SMTP id 79so4407135pgf.0
        for <git@vger.kernel.org>; Sat, 18 Mar 2017 03:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JTWGTXbzjBOibhtSXGtu2hcp0doLZHMuPkX5n2rySOg=;
        b=imi2DahEd8wqHJetcOJLwWYdtCERNAEU3i6BUkVUFW+4+MVwLtWN3QYS1K1n0VbWTQ
         M72WeLufHtYHGiNebyyIp9eQBi09BLWMU886sluJ7d7d/ZTS/knON2lKRr+wgvAsAk1g
         3xScl9VNhFhzivPSoixwKdlfglsLniUp9HSU+YEvn/iLpFcNPggTwEPZBilroprN6oFe
         Ca8joVhZlYoqYcl8ZqHgXsL0nCdSEWlQao1Hoj/YPiCrdTLgs91UfDzUHGYBMOCIsNfp
         0Sc+8A+1T9W7rUYA403znxbcllIUPx/ytImx/ztwbkdedh0GkHoGFkf8aBPwttuIejvY
         vL1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JTWGTXbzjBOibhtSXGtu2hcp0doLZHMuPkX5n2rySOg=;
        b=lIwmB6OV3JDLdxQvJ2urNEzAFkUWTsfvkoIbLNr34uVKUI7Sytb7JNRCQTWtTwuW5V
         QOd5D8b2eTkrUSKmEO9H2aG0NwTFcqvvvSuexwb8f0AS718PnOwJSeFFLbqhPZRRJ4Cl
         ovKw0s62gjLDeidDv31OrCLX40EpT5blv6pBzChfalkmpashwf6wneY2d5GqxuHi+40q
         USNYoN59xP5k6qZkR/AOZYdaxNu0BA+Roz34Ylom+naOGKsMkzabS7pPEbTfwgwS9xiO
         p/aqlXJlem7S7lnCl301/85CphJzpO6zF8yBjyizdjUQm1ih5uXr/3PIbI80NCjEq7gG
         7X7Q==
X-Gm-Message-State: AFeK/H379LhPcgWOR/kYmeDM+OMfEStOq3EMhZJNIdDik6LYQEf2wWt9M1spsMSiM4od0Q==
X-Received: by 10.98.37.69 with SMTP id l66mr12696078pfl.156.1489831938004;
        Sat, 18 Mar 2017 03:12:18 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id n185sm21900541pga.9.2017.03.18.03.12.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Mar 2017 03:12:17 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 18 Mar 2017 17:12:12 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 03/12] revision.c: --indexed-objects add objects from all worktrees
Date:   Sat, 18 Mar 2017 17:11:44 +0700
Message-Id: <20170318101153.6901-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170318101153.6901-1-pclouds@gmail.com>
References: <20170217141908.18012-1-pclouds@gmail.com>
 <20170318101153.6901-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the result of single_worktree flag never being set (no way to up
until now). To get objects from current index only, set single_worktree.

The other add_index_objects_to_pending's caller is mark_reachable_objects()
(e.g. "git prune") which also mark objects from all indexes.
---
 revision.c       | 21 +++++++++++++++++++++
 t/t5304-prune.sh |  9 +++++++++
 2 files changed, 30 insertions(+)

diff --git a/revision.c b/revision.c
index 98146f179f..db8021ed26 100644
--- a/revision.c
+++ b/revision.c
@@ -19,6 +19,7 @@
 #include "dir.h"
 #include "cache-tree.h"
 #include "bisect.h"
+#include "worktree.h"
 
 volatile show_early_output_fn_t show_early_output;
 
@@ -1291,8 +1292,28 @@ static void do_add_index_objects_to_pending(struct rev_info *revs,
 
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
+		struct index_state istate = {0};
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

