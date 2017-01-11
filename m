Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 849A41FEB3
	for <e@80x24.org>; Wed, 11 Jan 2017 07:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762123AbdAKHKi (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jan 2017 02:10:38 -0500
Received: from mail-wj0-f193.google.com ([209.85.210.193]:34348 "EHLO
        mail-wj0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761542AbdAKHKh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2017 02:10:37 -0500
Received: by mail-wj0-f193.google.com with SMTP id qs7so52065826wjc.1
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 23:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=01abKmR+6BhGhmciN7tybF4+L4cUQ8z/uPfxJITSM2c=;
        b=hyZ8RoKijb9s+UQb0AO3jneVXEpnI0I5XHbPxEiUJSIGoY7MNqiU0R0IEuc6lzFwnb
         33Nr/+JKtzsRDfvfRJBaFwbcY0F5TjjX3RRvvR3PXA6VQanquW6+8eGA9Lj1HHdy09CG
         RjrrD+rJur2dnsO5PXR9CgK3giNuILT+d/uFYQfoZG2igcuLOKy5XGvSEme1A86TDLgR
         ecNkJbwfUcrIDBv/mZY/UcMpjKdZBc79QxfxeRAklC676X1SAIP4uM9ZBlID1YdMw/Us
         DeTkEly81JzNbkXaPxGK702+5u/YxXMzspVJUUHkHmEwJmF9EN1KiEn8bmwSMFgE7xwh
         skDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=01abKmR+6BhGhmciN7tybF4+L4cUQ8z/uPfxJITSM2c=;
        b=N6d/aKro7VLTb05GoWsmkKrjZOC09N/zXk7mpgYSJOLfvqhxHKVeYLzxsvDoky9gM+
         yj4jvVdsTtuBxEbFzQCcRoe93kMCFMl2JzrAchsTL3b4PSKZ2G42w1+sKzBIjzYVhPq3
         1rvf4CrNiS/+EvB1KelpcM1IHs2+91ykz6kzj4dl1Q7TNyyytqZT3RBQ5wo53cJ5hkIM
         Z+eb6FK4b6BQ1MdsdS4Vr8QT++t5TpnkT+w0rkeDa9c3z9AXv7sJ24j3RgYynSvY8i+r
         AkEcky0RtBzDQlgPJGJQt4bhc4sneYWyQzT4nKvBdIM413/YRexVrObDld6+o2e+alzZ
         RkUA==
X-Gm-Message-State: AIkVDXJ0WLmoRHzzdpYTYR9ugQMFM+j+/DsOO2ugavWgBMO3IBEpBDORFmVOagkLFaW6wg==
X-Received: by 10.194.113.129 with SMTP id iy1mr3990802wjb.127.1484118635278;
        Tue, 10 Jan 2017 23:10:35 -0800 (PST)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([13.94.233.52])
        by smtp.gmail.com with ESMTPSA id d64sm28163333wmh.3.2017.01.10.23.10.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jan 2017 23:10:34 -0800 (PST)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCHv2 1/2] builtin/commit.c: drop use snprintf via dynamic allocation
Date:   Wed, 11 Jan 2017 07:10:31 +0000
Message-Id: <20170111071032.27797-1-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.11.0.154.g5f5f154
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In general snprintf is bad because it may silently truncate results if we're
wrong. In this patch where we use PATH_MAX, we'd want to handle larger
paths anyway, so we switch to dynamic allocation.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
This is the second version of the patch.

I have split the original commit in two, as discussed here
http://public-inbox.org/git/20161213132717.42965-1-gitter.spiros@gmail.com/.

 builtin/commit.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 0ed634b26..09bcc0f13 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -960,15 +960,16 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		return 0;
 
 	if (use_editor) {
-		char index[PATH_MAX];
-		const char *env[2] = { NULL };
-		env[0] =  index;
-		snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", index_file);
-		if (launch_editor(git_path_commit_editmsg(), NULL, env)) {
+		struct argv_array env = ARGV_ARRAY_INIT;
+
+		argv_array_pushf(&env, "GIT_INDEX_FILE=%s", index_file);
+		if (launch_editor(git_path_commit_editmsg(), NULL, env.argv)) {
 			fprintf(stderr,
 			_("Please supply the message using either -m or -F option.\n"));
+			argv_array_clear(&env);
 			exit(1);
 		}
+		argv_array_clear(&env);
 	}
 
 	if (!no_verify &&
@@ -1557,23 +1558,22 @@ static int run_rewrite_hook(const unsigned char *oldsha1,
 
 int run_commit_hook(int editor_is_used, const char *index_file, const char *name, ...)
 {
-	const char *hook_env[3] =  { NULL };
-	char index[PATH_MAX];
+	struct argv_array hook_env = ARGV_ARRAY_INIT;
 	va_list args;
 	int ret;
 
-	snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", index_file);
-	hook_env[0] = index;
+	argv_array_pushf(&hook_env, "GIT_INDEX_FILE=%s", index_file);
 
 	/*
 	 * Let the hook know that no editor will be launched.
 	 */
 	if (!editor_is_used)
-		hook_env[1] = "GIT_EDITOR=:";
+		argv_array_push(&hook_env, "GIT_EDITOR=:");
 
 	va_start(args, name);
-	ret = run_hook_ve(hook_env, name, args);
+	ret = run_hook_ve(hook_env.argv,name, args);
 	va_end(args);
+	argv_array_clear(&hook_env);
 
 	return ret;
 }
-- 
2.11.0.154.g5f5f154

