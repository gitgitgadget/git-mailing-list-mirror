Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52E3F20179
	for <e@80x24.org>; Sun,  3 Jul 2016 08:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752432AbcGCIAf (ORCPT <rfc822;e@80x24.org>);
	Sun, 3 Jul 2016 04:00:35 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:55588 "EHLO
	homiemail-a21.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752202AbcGCIAL convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 3 Jul 2016 04:00:11 -0400
Received: from homiemail-a21.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a21.g.dreamhost.com (Postfix) with ESMTP id 482D8300074;
	Sun,  3 Jul 2016 00:58:38 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-type:content-transfer-encoding; s=novalis.org; bh=d6wJu
	A9v0qqTCPJjwgLxRELn9VQ=; b=SwDhix+7UGiKkzSwQrvDGV1aURmQm/Z7RaW7f
	zuZtvuJJ9b9leeKR6U8/ppkFjE3ksqxCH/PvAKbPZy0YACWqtQZwdIlZd2pD3hwv
	uYZuB13eePSpfLc8qZ9Mq6AqjpEdgZbwbRUvDg2AHlm3+ZZKKpo5ICGmm+Qhvk8X
	OXtyMY=
Received: from frank.cable.rcn.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com [207.38.164.98])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: novalis@novalis.org)
	by homiemail-a21.g.dreamhost.com (Postfix) with ESMTPSA id 9CD4F30007B;
	Sun,  3 Jul 2016 00:58:37 -0700 (PDT)
From:	David Turner <novalis@novalis.org>
To:	git@vger.kernel.org, pclouds@gmail.com, kmaggg@gmail.com
Cc:	David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v14 12/21] update-index: enable/disable watchman support
Date:	Sun,  3 Jul 2016 03:58:04 -0400
Message-Id: <1467532693-20017-13-git-send-email-novalis@novalis.org>
X-Mailer: git-send-email 2.8.0.rc4.11.g9232872.dirty
In-Reply-To: <1467532693-20017-1-git-send-email-novalis@novalis.org>
References: <1467532693-20017-1-git-send-email-novalis@novalis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-index-helper.txt |  3 +++
 Documentation/git-update-index.txt |  6 ++++++
 builtin/update-index.c             | 15 +++++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/Documentation/git-index-helper.txt b/Documentation/git-index-helper.txt
index 2982e03..b2ca511 100644
--- a/Documentation/git-index-helper.txt
+++ b/Documentation/git-index-helper.txt
@@ -18,6 +18,9 @@ each with a submodule, you might need four index-helpers.  (In practice,
 this is only worthwhile for large indexes, so only use it if you notice
 that git status is slow).
 
+If you want the index-helper to accelerate untracked file checking,
+run git update-index --watchman before using it.
+
 OPTIONS
 -------
 
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index c6cbed1..6736487 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -19,6 +19,7 @@ SYNOPSIS
 	     [--ignore-submodules]
 	     [--[no-]split-index]
 	     [--[no-|test-|force-]untracked-cache]
+	     [--[no-]watchman]
 	     [--really-refresh] [--unresolve] [--again | -g]
 	     [--info-only] [--index-info]
 	     [-z] [--stdin] [--index-version <n>]
@@ -176,6 +177,11 @@ may not support it yet.
 --no-untracked-cache::
 	Enable or disable untracked cache feature. Please use
 	`--test-untracked-cache` before enabling it.
+
+--watchman::
+--no-watchman::
+	Enable or disable watchman support. This is, at present,
+	only useful with git index-helper.
 +
 These options take effect whatever the value of the `core.untrackedCache`
 configuration variable (see linkgit:git-config[1]). But a warning is
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 1c94ca5..55722b9 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -914,6 +914,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 {
 	int newfd, entries, has_errors = 0, nul_term_line = 0;
 	enum uc_mode untracked_cache = UC_UNSPECIFIED;
+	int use_watchman = -1;
 	int read_from_stdin = 0;
 	int prefix_length = prefix ? strlen(prefix) : 0;
 	int preferred_index_format = 0;
@@ -1012,6 +1013,8 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			    N_("test if the filesystem supports untracked cache"), UC_TEST),
 		OPT_SET_INT(0, "force-untracked-cache", &untracked_cache,
 			    N_("enable untracked cache without testing the filesystem"), UC_FORCE),
+		OPT_BOOL(0, "watchman", &use_watchman,
+			N_("use or not use watchman to reduce refresh cost")),
 		OPT_END()
 	};
 
@@ -1149,6 +1152,18 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		die("Bug: bad untracked_cache value: %d", untracked_cache);
 	}
 
+	if (use_watchman > 0) {
+		the_index.last_update    = xstrdup("");
+		the_index.cache_changed |= WATCHMAN_CHANGED;
+#ifndef USE_WATCHMAN
+		warning(_("git was built without watchman support, so this "
+			  "command will probably not result in any speedup."));
+#endif
+	} else if (!use_watchman) {
+		the_index.last_update    = NULL;
+		the_index.cache_changed |= WATCHMAN_CHANGED;
+	}
+
 	if (active_cache_changed) {
 		if (newfd < 0) {
 			if (refresh_args.flags & REFRESH_QUIET)
-- 
1.9.1

