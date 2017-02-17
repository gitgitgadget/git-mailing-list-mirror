Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97D2920136
	for <e@80x24.org>; Fri, 17 Feb 2017 14:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934369AbdBQOTu (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 09:19:50 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33850 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934423AbdBQOTn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 09:19:43 -0500
Received: by mail-pg0-f66.google.com with SMTP id v184so5074203pgv.1
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 06:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aY489bfxjvduLElTguXL7GbYIRjdCDXKmcqJ3KO2BQs=;
        b=Sa0ZIFQjfj4lS9kyv9LXWU4gUvhKLrqGp0DCkKQ3Bs92b9m+5EpTCukrgF03X3sOQ5
         aOY6tgBGAzhR4a7f1wRoAV/8w/DFhZ74f0wyhxHegrlb5b92P3QtqicTVg6MMMwtq4Xj
         oXVYWy9r308dcKwWN0j8ScEsPTX2CTFWtxXD8moK4S/dp8aEUprEO5Vl5OIren2cryjT
         LkTu20n59PNHWYHe1fEjT1qkR6UgHvWaSLR6kQ7fDWVEFDeqSQZXVGv1TJRmizQncls4
         efNhw8rBNNTHvlhpd9OnCifgi7UF25HkgTajyR6a8uBXMPtZXJ3lm4RJLnEHFzE7a/M6
         hQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aY489bfxjvduLElTguXL7GbYIRjdCDXKmcqJ3KO2BQs=;
        b=HJCXn5uw5IEo9sF0lZzAqEnYB6D4q6eZXwMjjAwqm/W1Xyn3CBU9/NimTWpru/sqYV
         mGm2q0cHD2CA1MtNScXM7y9k6HNeu0hLrbCJWRs8lwIS5zkutidQNdncTJySjgEhKqD+
         Ef3WFLtqdurpTeAkrXoV3hJgRZxV+MRJEX9+XWXt0f9SSqB6TSl8KCY0RB53s+oq1Abz
         d9bXW7gYjR4NDsI4Ff3XU8YlYZxK2VaFHg8WCc7S+CLm6Z0VeA5iRjqVrdt/Eo53ntdT
         G0ff4ttX1kv4v75GSq1ADhnPtCsT4pJRCkIPhUIWwX+1SOOIkfwpN7ptufnBO4usB0yP
         zdxA==
X-Gm-Message-State: AMke39m0JNRx63UaWV8LjnkzvnBuUY3JQOgJvR6J4gMQ4glQ3HQ+w+VSzEurtfGjeWcoEg==
X-Received: by 10.84.254.66 with SMTP id a2mr11516543pln.57.1487341182366;
        Fri, 17 Feb 2017 06:19:42 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id b190sm20022227pfa.110.2017.02.17.06.19.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Feb 2017 06:19:41 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 17 Feb 2017 21:19:37 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 03/15] revision.c: --indexed-objects add objects from all worktrees
Date:   Fri, 17 Feb 2017 21:18:56 +0700
Message-Id: <20170217141908.18012-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170217141908.18012-1-pclouds@gmail.com>
References: <20170217141908.18012-1-pclouds@gmail.com>
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
index ece868a25..d82f72ff3 100644
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
index 133b5842b..cba45c7be 100755
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

