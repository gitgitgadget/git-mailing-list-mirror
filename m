Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70E211FF40
	for <e@80x24.org>; Thu,  1 Dec 2016 01:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933486AbcLAB24 (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 20:28:56 -0500
Received: from mail-pg0-f44.google.com ([74.125.83.44]:33030 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933344AbcLAB2y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 20:28:54 -0500
Received: by mail-pg0-f44.google.com with SMTP id 3so88307512pgd.0
        for <git@vger.kernel.org>; Wed, 30 Nov 2016 17:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+XX1s9fyCdFjWN8/IB4QwELIYzcKR3R8wT99sdvTTP8=;
        b=W683ublAm02MM8XUtt/i7INmkAXxiR0F7nejsdkiVA2PZuNY6HmKzsclfuPtsF+4Jr
         FyIgOJergCpkHqzUegdyXGxv+LcBHWHsmSlGCCQHtQ0J96nOqaJVWOCpEC3vuIZJNOt4
         a+XNTO24+RLDWnO48cMJ+xNSu6msdCzGw5DN/WzrTJUvTTOjZ4qr/kqGHZwhKosoJNpA
         eiiZl8m+LnjHu+MawW/dMdn3cNmq1Mxopwx64rQIGHJ2N/6Cf4I3tVFi2OM0rgFN3Ir6
         GwmS714qeHGIHiz+we0Dt5KdzzRqxx0aaRZ6a32Hu7Mfy3pXJ2oDCFJFppEuhXWfnfkB
         Jopg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+XX1s9fyCdFjWN8/IB4QwELIYzcKR3R8wT99sdvTTP8=;
        b=gtPXnpadqNowl2LKyqNiqPUSXrFuf8c+RjDeMKk5T/kkBMuhVP6lHSnEVypWHp+iKV
         5UQksU2/0+d2WqmuBdXAIKraTwECuljn8zWeXmlZcNGcIyHeEjIFTwTcVe7Ex9bbk0T/
         suXyIJ8y8/XsBJpPlX5bsWsP6onj5LX/IwhHsY2mcOmlT2b4YmfiEy+58UUP+DMbxRqa
         VOP883I9pPGBqnanV/5syREiCv3DF1BizZdoJTG63wBpFlEp6Hk2br4Eq72JHXdTW0+f
         omEPQYiBFWOkUWB83RFH4yZioHtVC9AoYAk/eiUshLDbFYtJWIvScIDXKTq3YLT3c18X
         Yq6g==
X-Gm-Message-State: AKaTC00fBcbW0qMmaD1Qc3evatEo5pPkGLCBGvCH+4NU+UwKeu9vJ93mJUi2tUVw4CBLMgYs
X-Received: by 10.84.209.140 with SMTP id y12mr77819704plh.74.1480555733811;
        Wed, 30 Nov 2016 17:28:53 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id i194sm87872386pgc.46.2016.11.30.17.28.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Nov 2016 17:28:52 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, peff@peff.net,
        sbeller@google.com, jonathantanmy@google.com, gitster@pobox.com
Subject: [PATCH v6 6/6] grep: search history of moved submodules
Date:   Wed, 30 Nov 2016 17:28:34 -0800
Message-Id: <1480555714-186183-7-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1480555714-186183-1-git-send-email-bmwill@google.com>
References: <1479840397-68264-1-git-send-email-bmwill@google.com>
 <1480555714-186183-1-git-send-email-bmwill@google.com>
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

