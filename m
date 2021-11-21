Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44233C433F5
	for <git@archiver.kernel.org>; Sun, 21 Nov 2021 00:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237359AbhKUAuU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Nov 2021 19:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237302AbhKUAuL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Nov 2021 19:50:11 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A79AC061757
        for <git@vger.kernel.org>; Sat, 20 Nov 2021 16:47:07 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id b12so25320300wrh.4
        for <git@vger.kernel.org>; Sat, 20 Nov 2021 16:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Zn2pluaaPf4nCJdurmQT9dENP+qQU+JMTqpsfX/z46A=;
        b=ARj/AcLbg+5lXzkO7ksHMjDNcrsIG34FmXQOWbcfxz3AVSubEcnCwSeHvuS25RU3TJ
         O0nyX+GHfXaDEl1MxzoWvOfZGxD93eWCclBri5qdiap9do0rmIomsv6nG2QZ4XU9pX+W
         pr+dkRiAReW8PYPV4jfHPox9W+cIeskJTq/W7cURUfTywOmLQhqtdMduL7WLkmN9XMM3
         OgYiPahMmXw+y+wVWWLmnpMhhox5zoU58nIXXLAH5bDUyaXyx671VJ+uGvWZzv6r49qv
         lUN/B/uRnggHBbrlMNZTEu7AFIPgQkjXO9TrClnso+/T61t2CCJInN8fpnAF77A80vzi
         bD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Zn2pluaaPf4nCJdurmQT9dENP+qQU+JMTqpsfX/z46A=;
        b=ka8dQNNTGdwdHo4aMEEXYTNawVk20qrEEx+M/K4wlyTLVIJEo/Z8tcbDUqXh0USCn2
         PxYnQ1K1T15ZayibqnTnBaR4jaf0YJ7GXkG81Qe52+Mrg+Zc9ji/RvwArpZ44w1mL3f5
         bXRdBhNsONkx8uZZAxNns+AtbH6wSUJgo8sSJmeGS982BdhqkpCJ0qCwMbV/mqOLRh9V
         TsATbp1KNhXk3CA9t2Xux/oetFIWhP6cjLqNJR7DrRKM6HPTD37259KlXfyxTt+7T92b
         DlSwU9uS79U7XU9I85S0QONlG4hdn+P13T6EdNRlWlrS8isbxEKbKHo2rK4Ms0Fkt2p+
         0NKw==
X-Gm-Message-State: AOAM530OBW0E5ZUacU7UQ3PW9VeY7v0b9jv5QDYPRYBl7AQdPpWnJM1R
        je9WQLEUE7M7YRaI1meiv2s4OtyBbt8=
X-Google-Smtp-Source: ABdhPJyYzcwaetSr18YP47QLb4usqv/t35ElxmTeVABGjYcYyCNjPg603Bgc4eZvvroszFH2dcQdIw==
X-Received: by 2002:adf:e109:: with SMTP id t9mr21703361wrz.387.1637455626008;
        Sat, 20 Nov 2021 16:47:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d8sm4192397wrm.76.2021.11.20.16.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 16:47:05 -0800 (PST)
Message-Id: <93005b17c2880407872340d4927007db0d9e97b6.1637455620.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com>
References: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 21 Nov 2021 00:46:59 +0000
Subject: [PATCH 7/8] stash: do not attempt to remove current working directory
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/stash.c      | 13 ++++++++-----
 t/t2501-cwd-empty.sh |  2 +-
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index a0ccc8654df..556287cdb56 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1404,7 +1404,8 @@ static int create_stash(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
-static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int quiet,
+static int do_push_stash(const struct pathspec *ps, const char *stash_msg,
+			 const char *prefix, int quiet,
 			 int keep_index, int patch_mode, int include_untracked)
 {
 	int ret = 0;
@@ -1485,8 +1486,10 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 			struct child_process cp = CHILD_PROCESS_INIT;
 
 			cp.git_cmd = 1;
+			if (prefix)
+				strvec_pushl(&cp.args, "-C", prefix, NULL);
 			strvec_pushl(&cp.args, "clean", "--force",
-				     "--quiet", "-d", NULL);
+				     "--quiet", "-d", ":/", NULL);
 			if (include_untracked == INCLUDE_ALL_FILES)
 				strvec_push(&cp.args, "-x");
 			if (run_command(&cp)) {
@@ -1656,8 +1659,8 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 		die(_("--pathspec-file-nul requires --pathspec-from-file"));
 	}
 
-	return do_push_stash(&ps, stash_msg, quiet, keep_index, patch_mode,
-			     include_untracked);
+	return do_push_stash(&ps, stash_msg, prefix, quiet, keep_index,
+			     patch_mode, include_untracked);
 }
 
 static int save_stash(int argc, const char **argv, const char *prefix)
@@ -1693,7 +1696,7 @@ static int save_stash(int argc, const char **argv, const char *prefix)
 		stash_msg = strbuf_join_argv(&stash_msg_buf, argc, argv, ' ');
 
 	memset(&ps, 0, sizeof(ps));
-	ret = do_push_stash(&ps, stash_msg, quiet, keep_index,
+	ret = do_push_stash(&ps, stash_msg, prefix, quiet, keep_index,
 			    patch_mode, include_untracked);
 
 	strbuf_release(&stash_msg_buf);
diff --git a/t/t2501-cwd-empty.sh b/t/t2501-cwd-empty.sh
index 20e1b6adede..ff4e7cd89fa 100755
--- a/t/t2501-cwd-empty.sh
+++ b/t/t2501-cwd-empty.sh
@@ -236,7 +236,7 @@ test_expect_success 'clean does not remove cwd incidentally' '
 	test_path_is_dir untracked
 '
 
-test_expect_failure 'stash does not remove cwd incidentally' '
+test_expect_success 'stash does not remove cwd incidentally' '
 	git checkout foo/bar/baz &&
 	test_when_finished "git clean -fdx" &&
 
-- 
gitgitgadget

