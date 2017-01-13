Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54B3E20756
	for <e@80x24.org>; Fri, 13 Jan 2017 17:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751224AbdAMR6N (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 12:58:13 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35807 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751023AbdAMR6L (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 12:58:11 -0500
Received: by mail-wm0-f65.google.com with SMTP id l2so13411976wml.2
        for <git@vger.kernel.org>; Fri, 13 Jan 2017 09:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hbE5munO1ScftpjNeWGxHdJxd3KCJF93zE3h2z+9yCo=;
        b=hAN9C/gdQwwnM1zTnsu7rSGHjgbO4sp+2VEGUI1vbetnO2CewOgGV/uB/h9X1aW1oj
         D/czjuD5/EyzPww9XE4EYAunToPv5n3lfKDrt7EBXywX0fMu8jD2fOVg7FkRCccv+ONR
         n2ld5JOmrieribSuS79ikWZ4hWEMTnhVFLHrOFvvlkgZull3qtlWKxv9grxNM3W3u9oo
         TK2gPJDxXoWJEIRlOOYdsRoZSK83ADA9K+cM+yT8EIZH0/4TTW8w3Ug06y6hmEyjX9wK
         Yg9rPL2hYY4DKwWJmlyAja35KutWuwIpD8fdr9xFy0QWzQsJJiHNGtJARDgXYDtfUz0e
         4bBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hbE5munO1ScftpjNeWGxHdJxd3KCJF93zE3h2z+9yCo=;
        b=i4RU4f8Dgh56sDRvp/CN+PlK6yE68hSoIovQ0iAY/jk97pyQtYUoSDguHXZSlhodoR
         6Fu4KK5z5Baut98/QKFeS/qRzGlvONrTJza7Ly0wCdwuJgKSOA7QIiU82Q6++gHi955M
         F1GEKLl8qQumsJdewJ7t3Pk1UWtgd2x3aQpa/52d5oZWdWhEertkXsum/pBeaEy7CXx8
         sDvGw8Yu734QSI0/wphh/2q8WqXzO/uhAOAp2nbd9k4QEP1EGNl6wivJ6hPNiPTUXe0n
         UYMTyO4lTJtkGl8ng0+mMzO/m1xc6grdUmTPm+TE2XzZh8TDXb3+q5vegbCnkEW6xmt3
         TYAg==
X-Gm-Message-State: AIkVDXLsTNt7dsoEG8yzTlfO4pea+NmEhLHxvzmYZiw99qO9DTIprD16+yKmmNckQNUYEQ==
X-Received: by 10.28.56.199 with SMTP id f190mr3045178wma.49.1484330285402;
        Fri, 13 Jan 2017 09:58:05 -0800 (PST)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([13.94.233.52])
        by smtp.gmail.com with ESMTPSA id c81sm5717357wmf.22.2017.01.13.09.58.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Jan 2017 09:58:04 -0800 (PST)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCHv3 1/2] builtin/commit.c: removes the PATH_MAX limitation via dynamic allocation
Date:   Fri, 13 Jan 2017 17:58:00 +0000
Message-Id: <20170113175801.39468-1-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.11.0.154.g5f5f154
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch removes the PATH_MAX limitation from the environment 
setting that points to a filename, we'd want to handle larger
paths anyway, so we switch to dynamic allocation. As a side effect 
of this patch we have also reduced the snprintf() calls, that 
may silently truncate results if the programmer is not careful.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
This is the third  version of the patch.

Changes from the first version: I have split the original commit in two, as discussed here
http://public-inbox.org/git/20161213132717.42965-1-gitter.spiros@gmail.com/.

Changes from the second version:
- Changed the commit message to clarify the purpose of the patch (
as suggested by Junio)
- drop the arg_array_clear call after exit(1)
https://public-inbox.org/git/xmqqtw95mfo3.fsf@gitster.mtv.corp.google.com/T/#m2e6405a8a78a8ca1ed770614c91398290574c4a1


 builtin/commit.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 0ed634b26..09bcc0f13 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -960,15 +960,15 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
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
 			exit(1);
 		}
+		argv_array_clear(&env);
 	}
 
 	if (!no_verify &&
@@ -1557,23 +1557,22 @@ static int run_rewrite_hook(const unsigned char *oldsha1,
 
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

