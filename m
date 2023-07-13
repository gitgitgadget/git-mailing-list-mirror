Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026BBC0015E
	for <git@archiver.kernel.org>; Thu, 13 Jul 2023 04:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233855AbjGMEmr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jul 2023 00:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbjGMEmn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2023 00:42:43 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C976FCF
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 21:42:42 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3a3e1152c23so286176b6e.2
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 21:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689223361; x=1691815361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+tnRpy7hMi7m8JWoWC3tBjyGzH6ftc7CP8t+iwWGFWE=;
        b=cIUhjjxsl1X1+eA5BUfsoOrxhIzmFqnrfCGcwnGbGjH2Z+IuRU1qulAmiz9OCiJxHp
         e/Pfk74f+SpdT0AiRNLgv41pcIs7xg321+fRT0VIyKS55+vi8RvHb2oESsUxAXQGhbSg
         OOBzQ/Z7jQQPl0rkMds6kw4AElA26U/irHbhpEoGHbWjPIlsyKKwjhSOB8LhrcdDCWdm
         +n7sVt/frSk0cBJaG1Iv/ZL092lpdw3zqC8clWXLTPW+ZskcYxLnVmuqiowPeVhNzfBg
         NrGzq2JUj92p3ScCq2SDu/2x/f3/e4+MHiwD3M/j0AlXtlMwiGERqXpbzk5S2+tReHU8
         /QwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689223361; x=1691815361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+tnRpy7hMi7m8JWoWC3tBjyGzH6ftc7CP8t+iwWGFWE=;
        b=PWe8pDszaWDXpuZkCkqX1YnHkU7I9SgvXlHuOgtocKkPbdzjpCfZ8ZcFr4euGshLNn
         gBnl/wAuRaMJIMbR72EYghAvLUDSqMw9E8cZCGWnwfcFN+otNe2Qs82PLtXA6GJAtyux
         Es+EVu6Z1Y3BOxvKIi+T6zWhQuSbAbbVBYyExwZlXzRJn986QSzR3SKhNnlq56UjHl8R
         Lczap4POWbYHGghudNkMhVR7TXmraXx/87pnAv+XSjUFPorFdAyksUeumQ1WDeqkeir8
         dKvF+CpuhFpyAaBo4j0VXKb+vNEwkY+Z2lqK3cMhuab+4MWUMp48QBVXWZL5yr7AGlez
         T73g==
X-Gm-Message-State: ABy/qLY/A9ELzgiXqfXebX3OXFsGd0FcSwQnEKZYg213R9bhe3+ygYLg
        hmqIMZIvIVPdEiICq3vjUCSd2OPV0xU=
X-Google-Smtp-Source: APBJJlF67sPf74XDG+7dPrQpZsBvfWdyOWqvxRIovv/E4ksG39b2VUlv64qfRZ8zcK8ClmRlLDFI6w==
X-Received: by 2002:a05:6358:6f8f:b0:133:7c4:e752 with SMTP id s15-20020a0563586f8f00b0013307c4e752mr1185782rwn.26.1689223361164;
        Wed, 12 Jul 2023 21:42:41 -0700 (PDT)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id g13-20020a170902cd0d00b001ae5d21f760sm4843040ply.146.2023.07.12.21.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 21:42:39 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, git@matthieu-moy.fr, christiwald@gmail.com,
        john@keeping.me.uk, philipoakley@iee.email,
        phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v5 1/3] wt-status: don't show divergence advice when committing
Date:   Wed, 12 Jul 2023 22:41:13 -0600
Message-ID: <20230713044128.3771818-2-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230713044128.3771818-1-alexhenrie24@gmail.com>
References: <20230707054257.3366355-1-alexhenrie24@gmail.com>
 <20230713044128.3771818-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the user is in the middle of making a commit, they are not yet at
the point where they are ready to think about integrating their local
branch with the corresponding remote branch or force-pushing over the
remote branch. Don't include advice on how to deal with divergent
branches in the commit template, to avoid giving the impression that the
divergence needs to be dealt with immediately. Similar advice will be
printed when it is most relevant, that is, if the user does try to push
without first reconciling the two branches.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 builtin/checkout.c |  2 +-
 remote.c           |  6 ++++--
 remote.h           |  3 ++-
 t/t7508-status.sh  | 10 ++++------
 wt-status.c        |  3 ++-
 5 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index fd6ee8c272..c278c2169d 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -916,7 +916,7 @@ static void report_tracking(struct branch_info *new_branch_info)
 	struct strbuf sb = STRBUF_INIT;
 	struct branch *branch = branch_get(new_branch_info->name);
 
-	if (!format_tracking_info(branch, &sb, AHEAD_BEHIND_FULL))
+	if (!format_tracking_info(branch, &sb, AHEAD_BEHIND_FULL, 1))
 		return;
 	fputs(sb.buf, stdout);
 	strbuf_release(&sb);
diff --git a/remote.c b/remote.c
index a81f2e2f17..d79aae0d76 100644
--- a/remote.c
+++ b/remote.c
@@ -2258,7 +2258,8 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
  * Return true when there is anything to report, otherwise false.
  */
 int format_tracking_info(struct branch *branch, struct strbuf *sb,
-			 enum ahead_behind_flags abf)
+			 enum ahead_behind_flags abf,
+			 int show_divergence_advice)
 {
 	int ours, theirs, sti;
 	const char *full_base;
@@ -2321,7 +2322,8 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 			       "respectively.\n",
 			   ours + theirs),
 			base, ours, theirs);
-		if (advice_enabled(ADVICE_STATUS_HINTS))
+		if (show_divergence_advice &&
+		    advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git pull\" to merge the remote branch into yours)\n"));
 	}
diff --git a/remote.h b/remote.h
index 929c7c676d..cdc8b1db42 100644
--- a/remote.h
+++ b/remote.h
@@ -380,7 +380,8 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 		       const char **upstream_name, int for_push,
 		       enum ahead_behind_flags abf);
 int format_tracking_info(struct branch *branch, struct strbuf *sb,
-			 enum ahead_behind_flags abf);
+			 enum ahead_behind_flags abf,
+			 int show_divergence_advice);
 
 struct ref *get_local_heads(void);
 /*
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 36567708f5..845af287d7 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -847,7 +847,6 @@ test_expect_success 'dry-run of partial commit excluding new file in index' '
 On branch main
 Your branch and '\''upstream'\'' have diverged,
 and have 1 and 2 different commits each, respectively.
-  (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
   (use "git restore --staged <file>..." to unstage)
@@ -1013,7 +1012,7 @@ test_expect_success 'status -s submodule summary' '
 '
 
 test_expect_success 'status submodule summary (clean submodule): commit' '
-	cat >expect <<EOF &&
+	cat >expect-status <<EOF &&
 On branch main
 Your branch and '\''upstream'\'' have diverged,
 and have 2 and 2 different commits each, respectively.
@@ -1033,12 +1032,13 @@ Untracked files:
 
 no changes added to commit (use "git add" and/or "git commit -a")
 EOF
+	sed "/git pull/d" expect-status > expect-commit &&
 	git commit -m "commit submodule" &&
 	git config status.submodulesummary 10 &&
 	test_must_fail git commit --dry-run >output &&
-	test_cmp expect output &&
+	test_cmp expect-commit output &&
 	git status >output &&
-	test_cmp expect output
+	test_cmp expect-status output
 '
 
 cat >expect <<EOF
@@ -1065,7 +1065,6 @@ test_expect_success 'commit --dry-run submodule summary (--amend)' '
 On branch main
 Your branch and '\''upstream'\'' have diverged,
 and have 2 and 2 different commits each, respectively.
-  (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
   (use "git restore --source=HEAD^1 --staged <file>..." to unstage)
@@ -1558,7 +1557,6 @@ test_expect_success 'git commit --dry-run will show a staged but ignored submodu
 On branch main
 Your branch and '\''upstream'\'' have diverged,
 and have 2 and 2 different commits each, respectively.
-  (use "git pull" to merge the remote branch into yours)
 
 Changes to be committed:
   (use "git restore --staged <file>..." to unstage)
diff --git a/wt-status.c b/wt-status.c
index bcd0ef8044..e3e3732ea2 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1186,7 +1186,8 @@ static void wt_longstatus_print_tracking(struct wt_status *s)
 
 	t_begin = getnanotime();
 
-	if (!format_tracking_info(branch, &sb, s->ahead_behind_flags))
+	if (!format_tracking_info(branch, &sb, s->ahead_behind_flags,
+				  !s->commit_template))
 		return;
 
 	if (advice_enabled(ADVICE_STATUS_AHEAD_BEHIND_WARNING) &&
-- 
2.41.0

