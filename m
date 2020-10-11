Return-Path: <SRS0=tPyM=DS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B308AC43457
	for <git@archiver.kernel.org>; Sun, 11 Oct 2020 10:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7118E2078A
	for <git@archiver.kernel.org>; Sun, 11 Oct 2020 10:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9nYZe57"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgJKKMl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Oct 2020 06:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgJKKMk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Oct 2020 06:12:40 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF36C0613CE
        for <git@vger.kernel.org>; Sun, 11 Oct 2020 03:12:40 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b8so2290998wrn.0
        for <git@vger.kernel.org>; Sun, 11 Oct 2020 03:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1F5trvZZdVn0cyGSodlVJXFoupNIxVyFr9OBOuC6spE=;
        b=M9nYZe57FPURwoEpr2ARSVb5fhIvluK2tyUbtK46oM0UXxyeiDnwWG+ldBbu+jGbhu
         3mse+zpq4R4INR3kHAAxvpS7gL79ThGeiXi9Y7dhXhGmzByAhrXiuNORPJzZI6fzJY5I
         0m4untJ7po/Df31Ql5FH3UvlQqfRph/qSGivwjl27qrrqKAYkfVlpi8eS+CWmuY68ure
         pjCslnJXAqgopGhMuAH7rjCdK/9RNqge4CgEEm5zJpbnnTyhTC2hct9t2XjPJ0UiIH50
         UJtglWNzmTyE6CRr4nDZvcHxQW4aeynDogdZ7R0Pb82QeHKhPQmfQg/7GVXNTeJraznn
         v+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1F5trvZZdVn0cyGSodlVJXFoupNIxVyFr9OBOuC6spE=;
        b=kYjRenPCYaFUSDf95TAf8dlLyo+gdweq37znvoCXW4wbrgdC7pQGvIx8Eqt1J/UjpQ
         Oa0JBAcfwF862kBZ2SiJdn4YA0T3JjN7m1+xYnAj4SrQHaCJV3WKGEkgY5mM5hnYH3tg
         T9L1F1E/Wy9lzCCRZDGIG00Uv+QFyP3PPxkKNP1Vyr6UfuoHzNsmRIpAS4JjwpjqjNNJ
         e2/WtU92D7vD236LKdShNdsE3lGfHDp+mGKgcfo9qxHQ0uYy6GurMA8Ou6cTqgjtnS2A
         ilaq8BHEN3Mv8nRFcTnLFkhG/KD0K4Jtq16ideiYeje48DHxT5ha5d1RRM/G/6SLG12y
         tC2Q==
X-Gm-Message-State: AOAM53081utV8OLtVnaaEgjuuHSCT08uZBlurBq1Uxc47KNETOYIWBri
        nB74S4b/EcXufhMYxR+7waUu5x/cIrnAiA==
X-Google-Smtp-Source: ABdhPJwXMoJGBaT4MJpW6oLZj6qEKF6ekE2GIvitpw5hufHjdy0fWpdv9CKGl5+qRAzCgzQlKa8Qug==
X-Received: by 2002:a05:6000:10cd:: with SMTP id b13mr19926197wrx.4.1602411158611;
        Sun, 11 Oct 2020 03:12:38 -0700 (PDT)
Received: from contrib-buster.auto1.local ([79.140.120.253])
        by smtp.gmail.com with ESMTPSA id f8sm7363093wrw.85.2020.10.11.03.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2020 03:12:37 -0700 (PDT)
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, gitster@pobox.com,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [PATCH v3] worktree: teach `list` to annotate locked worktree
Date:   Sun, 11 Oct 2020 10:11:52 +0000
Message-Id: <20201011101152.5291-2-rafaeloliveira.cs@gmail.com>
X-Mailer: git-send-email 2.29.0.rc0.253.gc238dab514
In-Reply-To: <20201011101152.5291-1-rafaeloliveira.cs@gmail.com>
References: <20201010185521.23032-1-rafaeloliveira.cs@gmail.com>
 <20201011101152.5291-1-rafaeloliveira.cs@gmail.com>
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
remove such a worktree, or would realize that
"git worktree remove -f -f <path>" is required.

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
index 32e8440cde..6a6b7c4ad1 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -97,7 +97,8 @@ list::
 List details of each working tree.  The main working tree is listed first,
 followed by each of the linked working trees.  The output details include
 whether the working tree is bare, the revision currently checked out, and the
-branch currently checked out (or "detached HEAD" if none).
+branch currently checked out (or "detached HEAD" if none), and "locked" if
+the worktree is locked.
 
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
index 52585ec2aa..b85bd2655d 100755
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
+	grep "/locked  *[0-9a-f].* locked$" out &&
+	! grep "/unlocked  *[0-9a-f].* locked$" out
+'
+
 test_expect_success 'bare repo setup' '
 	git init --bare bare1 &&
 	echo "data" >file1 &&
-- 
2.29.0.rc0.253.gc238dab514

