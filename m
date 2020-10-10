Return-Path: <SRS0=cZ0k=DR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E1BC433DF
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 23:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 644712075E
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 23:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6/0Kh5V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731365AbgJJW4J (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Oct 2020 18:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730366AbgJJS4X (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Oct 2020 14:56:23 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06841C0613BD
        for <git@vger.kernel.org>; Sat, 10 Oct 2020 11:56:23 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id h5so3831580wrv.7
        for <git@vger.kernel.org>; Sat, 10 Oct 2020 11:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VEaBIwzLUD5E1HcAIXzVpQoRg2iNk1DzUMd50rKnNaU=;
        b=l6/0Kh5V4MqScsfy6LaDkKCKpb/oMmG/iCBZPl7rUDMro1/I2s2V0cQfOfcgSxydtk
         gzy5tkLJaJkM7j1qnK9ZbGVewpAOAS7G3vuf9CIf6dPirIsogzUthteWOpRKw4WB5yee
         DLpiSfO3fOlCsNvNcoVzYBvV6Hw7GEj4pd8o3axBbaPXAUX0HQuP3sG8rkwONPxVcvcm
         5rczuLhs+8w4vfeGLIcvCPDYfi3srbLfZYeqkI0SbpudtM9IFOaXJ/HXYIjbZ1n7jIq6
         UMN6ZNfyj1Gzo+YTwHuIZg4uCk8xQW/wJv5xNoLhSWdg0xuupWRPa1HsSJz190qV4u4w
         MtNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VEaBIwzLUD5E1HcAIXzVpQoRg2iNk1DzUMd50rKnNaU=;
        b=WUTjrcN4kAfdzglXJt8+J5WGuEi1LZ0Zq6pfyg5eMNOtJ7nkqz4zZoDf5UCBunGByB
         V7g6FZo0sKK/YKkevnjh/eNDgeUX4s083tzqzpONni4YoSSQh7g3MeWMfe+VIItZvh8Y
         58Q7x2X3VPScq+TQbJBHGgts983K5sce4t6ji8Hsu+n8MSSSdvo9G6sGyq5ai9mDQE2u
         mosJcR9QXe/VHr4HzKuZOnUFjnIcd26rd6NpHc1G031oI6uWBYF6fJLRNqR7k6bAgZba
         2pju3uEFqgBJJStf5aCXOoa5k/CEBWGigwehaP6S4pNKop5wy9SeIjBx3Q4ND9IJOgPm
         nVkg==
X-Gm-Message-State: AOAM5314AKoRuYtu6qRWC8EQ3uvdGHspKglOsV41ptUNFtIPPuQGCw0U
        gEkU3KuD0mBXSjqVDw+peGF5WZFbldiGDQ==
X-Google-Smtp-Source: ABdhPJxSEPuUaMtRhYY35BaLhIFlxgYRg1gBAaFqNgYFS0HtkXNy3ECDU0eVuBkQToqox6uBQmfjEA==
X-Received: by 2002:adf:fa41:: with SMTP id y1mr22373546wrr.213.1602356181393;
        Sat, 10 Oct 2020 11:56:21 -0700 (PDT)
Received: from contrib-buster.auto1.local ([79.140.120.253])
        by smtp.gmail.com with ESMTPSA id u5sm19620325wru.63.2020.10.10.11.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2020 11:56:20 -0700 (PDT)
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, gitster@pobox.com,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [PATCH v2 1/1] worktree: teach `list` to annotate locked worktree
Date:   Sat, 10 Oct 2020 18:55:21 +0000
Message-Id: <20201010185521.23032-2-rafaeloliveira.cs@gmail.com>
X-Mailer: git-send-email 2.29.0.rc0.253.gc238dab514
In-Reply-To: <20201010185521.23032-1-rafaeloliveira.cs@gmail.com>
References: <20200928154953.30396-1-rafaeloliveira.cs@gmail.com>
 <20201010185521.23032-1-rafaeloliveira.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "git worktree list" shows the absolute path to the working tree,
the commit that is checked out and the name of the branch. It is not
immediately obvious which of the worktrees, if any, are locked.

"git worktree remove" refuses to remove a locked worktree with
an error message. If "git worktree list" told which worktrees
are locked in its output, the user would not even attempt to
remove such a worktree or would know how to use
`git worktree remove -f -f <path>`

Teach "git worktree list" to append "locked" to its output.
The output from the command becomes like so:

    $ git worktree list
    /path/to/main             abc123 [master]
    /path/to/worktree         456def (detached HEAD)
    /path/to/locked-worktree  123abc (detached HEAD) locked

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
---
 Documentation/git-worktree.txt |  3 ++-
 builtin/worktree.c             |  5 ++++-
 t/t2402-worktree-list.sh       | 10 ++++++++++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 32e8440cde..40ef4c18c5 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -97,7 +97,8 @@ list::
 List details of each working tree.  The main working tree is listed first,
 followed by each of the linked working trees.  The output details include
 whether the working tree is bare, the revision currently checked out, and the
-branch currently checked out (or "detached HEAD" if none).
+branch currently checked out (or "detached HEAD" if none). For a locked
+worktree the `locked` annotation is also shown.
 
 lock::
 
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 99abaeec6c..ce56fdaaa9 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -676,8 +676,11 @@ static void show_worktree(struct worktree *wt, int path_maxlen, int abbrev_len)
 		} else
 			strbuf_addstr(&sb, "(error)");
 	}
-	printf("%s\n", sb.buf);
 
+	if (!is_main_worktree(wt) && worktree_lock_reason(wt))
+		strbuf_addstr(&sb, " locked");
+
+	printf("%s\n", sb.buf);
 	strbuf_release(&sb);
 }
 
diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
index 52585ec2aa..74275407ee 100755
--- a/t/t2402-worktree-list.sh
+++ b/t/t2402-worktree-list.sh
@@ -61,6 +61,16 @@ test_expect_success '"list" all worktrees --porcelain' '
 	test_cmp expect actual
 '
 
+test_expect_success '"list" all worktress with locked annotation' '
+	test_when_finished "rm -rf locked unlocked out && git worktree prune" &&
+	git worktree add --detach locked master &&
+	git worktree add --detach unlocked master &&
+	git worktree lock locked &&
+	git worktree list >out &&
+	grep "/locked *[0-9a-f].* locked" out &&
+	! grep "/unlocked *[0-9a-f].* locked" out
+'
+
 test_expect_success 'bare repo setup' '
 	git init --bare bare1 &&
 	echo "data" >file1 &&
-- 
2.29.0.rc0.253.gc238dab514

