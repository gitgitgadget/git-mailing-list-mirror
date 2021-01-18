Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE591C433E0
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 21:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 959FE22CAD
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 21:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389767AbhARVHg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 16:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390382AbhARVD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 16:03:26 -0500
Received: from dandelion.mymedia.su (unknown [IPv6:2604:180:2:1574::c9e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA6BC061757
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 13:02:38 -0800 (PST)
Received: from dandelion.mymedia.su (localhost.localdomain [127.0.0.1])
        by dandelion.mymedia.su (8.15.2/8.15.2/Debian-3) with ESMTP id 10IL0Cpj024965;
        Tue, 19 Jan 2021 00:00:12 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=guriev.su; s=default;
        t=1611003612; bh=8LoMYy/oGuEbUzN1IumqXtI+233r7DEb+IBkBT/B6p8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=QLXSyD6zPClsKSfg0jNbHkZwkyJbmqunGfvu28tV2jR3x9/q52hxDNqYXZtivMfot
         +sjA3WoP98vyRIxbnaWNwOH/W698tYX6G8S3+5Xh3sv2bm4YIIH9Acsb3oU6cPDEn8
         f2OOAtkuQLd8EzRgGm6amJQxcElwAGX/lzk2ex4A=
Received: (from mymedia@localhost)
        by dandelion.mymedia.su (8.15.2/8.15.2/Submit) id 10IL0CAX024964;
        Tue, 19 Jan 2021 00:00:12 +0300
From:   Nicholas Guriev <nicholas@guriev.su>
To:     git@vger.kernel.org
Subject: [RFC PATCH v2 3/3] doc: describe new difftool.tabbed feature
Date:   Tue, 19 Jan 2021 00:00:03 +0300
Message-Id: <20210118210003.3071205-4-nicholas@guriev.su>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210118210003.3071205-1-nicholas@guriev.su>
References: <2fb58fd30ae730ccd3e88ec51b5fe6d80ab7a8c7.camel@guriev.su>
 <20210118210003.3071205-1-nicholas@guriev.su>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

And related the `--tabbed` command line option and the
GIT_DIFFTOOL_TABBED environment variable.
---
 Documentation/config/difftool.txt |  6 ++++++
 Documentation/git-difftool.txt    | 19 +++++++++++++++----
 Documentation/git.txt             |  4 ++++
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/difftool.txt b/Documentation/config/difftool.txt
index 6762594480..ac609aee66 100644
--- a/Documentation/config/difftool.txt
+++ b/Documentation/config/difftool.txt
@@ -12,3 +12,9 @@ difftool.<tool>.cmd::
 
 difftool.prompt::
 	Prompt before each invocation of the diff tool.
+
+difftool.tabbed::
+	Show compared files in different tabs using single invocation of
+	the diff tool. Must be a boolean value. Only the following tools
+	are currently supported: vimdiff and related, meld. Tools with
+	overridden command line will ignore this configuration variable.
diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index 484c485fd0..1b7a5345ad 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -69,6 +69,13 @@ with custom merge tool commands and has the same value as `$MERGED`.
 --tool-help::
 	Print a list of diff tools that may be used with `--tool`.
 
+--[no-]tabbed::
+	Open compared files in different tabs using single invocation
+	of the diff tool. This overrides configuration or environment.
+	Currently, only the following tools are supported: vimdiff and
+	related, meld. Tools with overridden command line will ignore
+	this option.
+
 --[no-]symlinks::
 	'git difftool''s default behavior is create symlinks to the
 	working tree when run in `--dir-diff` mode and the right-hand
@@ -95,10 +102,11 @@ instead.  `--no-symlinks` is the default on Windows.
 	`diff.tool`, `merge.tool` until a tool is found.
 
 --[no-]trust-exit-code::
-	'git-difftool' invokes a diff tool individually on each file.
-	Errors reported by the diff tool are ignored by default.
-	Use `--trust-exit-code` to make 'git-difftool' exit when an
-	invoked diff tool returns a non-zero exit code.
+	'git-difftool' invokes a diff tool individually on each file
+	unless tabbed mode is active. Errors reported by the diff tool
+	are ignored by default. Use `--trust-exit-code` to make
+	'git-difftool' exit immediately when an invoked diff tool
+	returns a non-zero exit code.
 +
 'git-difftool' will forward the exit code of the invoked tool when
 `--trust-exit-code` is used.
@@ -128,6 +136,9 @@ See the `--tool=<tool>` option above for more details.
 difftool.prompt::
 	Prompt before each invocation of the diff tool.
 
+difftool.tabbed::
+	Configure default value of the `--tabbed` option. See above.
+
 difftool.trustExitCode::
 	Exit difftool if the invoked diff tool returns a non-zero exit status.
 +
diff --git a/Documentation/git.txt b/Documentation/git.txt
index a6d4ad0818..d7cd6650c9 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -583,6 +583,10 @@ For each path `GIT_EXTERNAL_DIFF` is called, two environment variables,
 `GIT_DIFF_PATH_TOTAL`::
 	The total number of paths.
 
+`GIT_DIFFTOOL_TABBED`::
+	Run the diff tool in tabbed mode opening all compared files
+	together. It must contain a boolean value.
+
 other
 ~~~~~
 `GIT_MERGE_VERBOSITY`::
-- 
2.27.0

