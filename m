Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 094DE1F404
	for <e@80x24.org>; Tue, 28 Aug 2018 21:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbeH2BOZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 21:14:25 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:37988 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbeH2BOZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 21:14:25 -0400
Received: by mail-it0-f66.google.com with SMTP id p129-v6so4470016ite.3
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 14:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JyHY5JhqY7dn62kFCFCxi5GEqZ3ALz0vpKQI/5l20oA=;
        b=YI3Gcnp1zjVjIY0RM0fhQAEcmFCHV610LHrD/mAcMDl/78D9ahVLQPyROztkDekRGP
         yeJQ+IU9LHD0D6TkELgGB4yJGCefeR2flOAeN/23yME1BJLCy2tkst6/m2YVmdaHrFUX
         jKdl6w8ysLbKvBAahPOdTgVOLavYE0z9Kqwo1RRxbvYo9A4M6bs3Q4jsTXetTFXdFuGk
         LjC/702EDQiHqgU1wB7EMF/GRJ/qAqr9aA4rXjH9wvCmqCAr5mzXUulkKsPP73eoeG4s
         oEoAMcjkapHklw80gHOcU5mXLS00f6isCYSKCR50UuMtXTLJ0IkHVgLLDQ2EcwDQw9At
         c/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=JyHY5JhqY7dn62kFCFCxi5GEqZ3ALz0vpKQI/5l20oA=;
        b=UNR+ip+wH80k4JX+WOP0XAXMSssxGGX4j32Ctq78HAZnwdC1vLGhefYWW+fRgOH2bX
         EfjCrBprKE6W6pEyVuVqGwka7ot2xeGeCHpPEO8FOZDUnv4HXUWhJ263tjYtKlA1YG2J
         pfgWqHoMNW5X/GAaG2PMHm43RNhsjlSNbdE+nqnMTuH92gR7ghtsiPgNZCHKtzZYqaa5
         f0mjUB4nPRy2fcCIXA3QCXpccZabEMdKzGmCpwuF49kyytwu0PDrGQEP+YIRPcvv+aqS
         idB3NYtBuxKyQ6Ijrekl3aVRz52QiuZEidt+HqlEuJD424qCGxudAStbcecKDAttpOaG
         GG5g==
X-Gm-Message-State: APzg51Aal4b636vYLkBScHgD+ad/hkmk1XurPqcdsU1olsYZgM6wBnMj
        tD9GOSUf63l7RoHzaKTQCHmPQg56
X-Google-Smtp-Source: ANB0VdaGgr1vS+vn6j5kkWN6jzsf+4FKhvYAipsb4H6x6Yha1ojDJZyS91+YBYjGjfu3X9D9MZzI8A==
X-Received: by 2002:a24:fe44:: with SMTP id w65-v6mr2988626ith.122.1535491254132;
        Tue, 28 Aug 2018 14:20:54 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id o1-v6sm1090344iop.12.2018.08.28.14.20.53
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 28 Aug 2018 14:20:53 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 9/9] worktree: delete .git/worktrees if empty after 'remove'
Date:   Tue, 28 Aug 2018 17:20:26 -0400
Message-Id: <20180828212026.21989-10-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1
In-Reply-To: <20180828212026.21989-1-sunshine@sunshineco.com>
References: <20180828212026.21989-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For cleanliness, "git worktree prune" deletes the .git/worktrees
directory if it is empty after pruning is complete.

For consistency, make "git worktree remove <path>" likewise delete
.git/worktrees if it is empty after the removal.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/worktree.c       |  8 +++++++-
 t/t2028-worktree-move.sh | 12 ++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index a95fe67da6..c4abbde2b8 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -62,6 +62,11 @@ static int delete_git_dir(const char *id)
 	return ret;
 }
 
+static void delete_worktrees_dir_if_empty(void)
+{
+	rmdir(git_path("worktrees")); /* ignore failed removal */
+}
+
 static int prune_worktree(const char *id, struct strbuf *reason)
 {
 	struct stat st;
@@ -149,7 +154,7 @@ static void prune_worktrees(void)
 	}
 	closedir(dir);
 	if (!show_only)
-		rmdir(git_path("worktrees"));
+		delete_worktrees_dir_if_empty();
 	strbuf_release(&reason);
 }
 
@@ -918,6 +923,7 @@ static int remove_worktree(int ac, const char **av, const char *prefix)
 	 * from here.
 	 */
 	ret |= delete_git_dir(wt->id);
+	delete_worktrees_dir_if_empty();
 
 	free_worktrees(worktrees);
 	return ret;
diff --git a/t/t2028-worktree-move.sh b/t/t2028-worktree-move.sh
index 1b5079e8fa..33c0337733 100755
--- a/t/t2028-worktree-move.sh
+++ b/t/t2028-worktree-move.sh
@@ -173,4 +173,16 @@ test_expect_success 'remove locked worktree (force)' '
 	git worktree remove --force --force gumby
 '
 
+test_expect_success 'remove cleans up .git/worktrees when empty' '
+	git init moog &&
+	(
+		cd moog &&
+		test_commit bim &&
+		git worktree add --detach goom &&
+		test_path_exists .git/worktrees &&
+		git worktree remove goom &&
+		test_path_is_missing .git/worktrees
+	)
+'
+
 test_done
-- 
2.19.0.rc1.350.ge57e33dbd1

