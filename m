Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7153D1FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 18:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756083AbcKVSru (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 13:47:50 -0500
Received: from mail-pg0-f41.google.com ([74.125.83.41]:36531 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756000AbcKVSro (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 13:47:44 -0500
Received: by mail-pg0-f41.google.com with SMTP id f188so10166817pgc.3
        for <git@vger.kernel.org>; Tue, 22 Nov 2016 10:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+XX1s9fyCdFjWN8/IB4QwELIYzcKR3R8wT99sdvTTP8=;
        b=RKsKRvjQvUjXlA6TrXViV2GrJvRMFaHzPTlyiXpChAUVk0oBrZ3cnH7ldwUHz0k1pa
         F59+DnbFJ0aTVQvNmeA3JPDAc+eL7tcNAlXoj8gNZRYy7oMfHm4wEbLX3L76zMjI+9FA
         0u7UiY4Juou87yvzmaALsRv8dAVA5+vtSAgBlJP8ZMGprPq9fnlTMIJx0tg3ErUfKjPD
         g+ehjzlSptUCGmk9GJgcyJ3pNBQNpZ5ZQlTIZttzumdzeAjjM1riJeoLfEv3mBf/QpFU
         RY1ci7kakPRru1DY947S5+w6+KwxXJxmxsUvCrNjcHc1MCDFzG7e6QppTSUgdS/AO4UY
         HFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+XX1s9fyCdFjWN8/IB4QwELIYzcKR3R8wT99sdvTTP8=;
        b=CahPFwj+ZbH+Glb+42rtm3oaFeSpW5jPBKpAXoAvFky2n5gvoZ1K8wChZIauH6yxcD
         86FSZksrq4cOEdc4z3EQaseEbqVOKtb98dwUWLjPCU7ZE35FVKPruBF1XB7rOXHhqRdK
         ne1epmuS5KD58o3+Y/A9hfo6C5g2Ds2QnQBkwlP2YuNJ3d8LPruLaz8++Cu47TrF5tyt
         lq+8Jwg2PTLhxDK9Ryk8v1S6zHASY7gFeWfyO/cyUbChnStHpbXdT3vWO4VAk5N718Kz
         wOXWyS467WRV1mPPROs+Rr6ibC+5weZvXwusEu5gct90RlIjKNWKuEMAOugwVOFUnu4a
         Q7xA==
X-Gm-Message-State: AKaTC00SLr4SyLpf7JvoTyF4ZkrRiQPsQVC7t4XNugVX5UWJCY57sdqLLlQmc09ECE2U26xz
X-Received: by 10.84.195.228 with SMTP id j91mr2419848pld.88.1479840414337;
        Tue, 22 Nov 2016 10:46:54 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id w5sm46932072pfl.31.2016.11.22.10.46.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Nov 2016 10:46:53 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        jonathantanmy@google.com, gitster@pobox.com
Subject: [PATCH v5 6/6] grep: search history of moved submodules
Date:   Tue, 22 Nov 2016 10:46:37 -0800
Message-Id: <1479840397-68264-7-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1479840397-68264-1-git-send-email-bmwill@google.com>
References: <1479499135-64269-1-git-send-email-bmwill@google.com>
 <1479840397-68264-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a submodule was renamed at any point since it's inception then if you
were to try and grep on a commit prior to the submodule being moved, you
wouldn't be able to find a working directory for the submodule since the
path in the past is different from the current path.

This patch teaches grep to find the .git directory for a submodule in
the parents .git/modules/ directory in the event the path to the
submodule in the commit that is being searched differs from the state of
the currently checked out commit.  If found, the child process that is
spawned to grep the submodule will chdir into its gitdir instead of a
working directory.

In order to override the explicit setting of submodule child process's
gitdir environment variable (which was introduced in '10f5c526')
`GIT_DIR_ENVIORMENT` needs to be pushed onto child process's env_array.
This allows the searching of history from a submodule's gitdir, rather
than from a working directory.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/grep.c                     | 20 +++++++++++++++++--
 t/t7814-grep-recurse-submodules.sh | 41 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 5918a26..2c727ef 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -547,6 +547,7 @@ static int grep_submodule_launch(struct grep_opt *opt,
 		name = gs->name;
 
 	prepare_submodule_repo_env(&cp.env_array);
+	argv_array_push(&cp.env_array, GIT_DIR_ENVIRONMENT);
 
 	/* Add super prefix */
 	argv_array_pushf(&cp.args, "--super-prefix=%s%s/",
@@ -615,8 +616,23 @@ static int grep_submodule(struct grep_opt *opt, const unsigned char *sha1,
 {
 	if (!is_submodule_initialized(path))
 		return 0;
-	if (!is_submodule_populated(path))
-		return 0;
+	if (!is_submodule_populated(path)) {
+		/*
+		 * If searching history, check for the presense of the
+		 * submodule's gitdir before skipping the submodule.
+		 */
+		if (sha1) {
+			const struct submodule *sub =
+					submodule_from_path(null_sha1, path);
+			if (sub)
+				path = git_path("modules/%s", sub->name);
+
+			if (!(is_directory(path) && is_git_directory(path)))
+				return 0;
+		} else {
+			return 0;
+		}
+	}
 
 #ifndef NO_PTHREADS
 	if (num_threads) {
diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index 9e93fe7..0507771 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -186,6 +186,47 @@ test_expect_success 'grep recurse submodule colon in name' '
 	test_cmp expect actual
 '
 
+test_expect_success 'grep history with moved submoules' '
+	git init parent &&
+	test_when_finished "rm -rf parent" &&
+	echo "foobar" >parent/file &&
+	git -C parent add file &&
+	git -C parent commit -m "add file" &&
+
+	git init sub &&
+	test_when_finished "rm -rf sub" &&
+	echo "foobar" >sub/file &&
+	git -C sub add file &&
+	git -C sub commit -m "add file" &&
+
+	git -C parent submodule add ../sub dir/sub &&
+	git -C parent commit -m "add submodule" &&
+
+	cat >expect <<-\EOF &&
+	dir/sub/file:foobar
+	file:foobar
+	EOF
+	git -C parent grep -e "foobar" --recurse-submodules >actual &&
+	test_cmp expect actual &&
+
+	git -C parent mv dir/sub sub-moved &&
+	git -C parent commit -m "moved submodule" &&
+
+	cat >expect <<-\EOF &&
+	file:foobar
+	sub-moved/file:foobar
+	EOF
+	git -C parent grep -e "foobar" --recurse-submodules >actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-\EOF &&
+	HEAD^:dir/sub/file:foobar
+	HEAD^:file:foobar
+	EOF
+	git -C parent grep -e "foobar" --recurse-submodules HEAD^ >actual &&
+	test_cmp expect actual
+'
+
 test_incompatible_with_recurse_submodules ()
 {
 	test_expect_success "--recurse-submodules and $1 are incompatible" "
-- 
2.8.0.rc3.226.g39d4020

