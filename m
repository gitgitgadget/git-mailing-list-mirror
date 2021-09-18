Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90678C433F5
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 19:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7657660F70
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 19:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238328AbhIRTdR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Sep 2021 15:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236332AbhIRTdP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Sep 2021 15:33:15 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2BBC061574
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 12:31:51 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id t1so13191029pgv.3
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 12:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qnqOkI31GeLljbB4WqZ/drBHY/AOebIdt+UdoPHqAJw=;
        b=E18carW9TKkXrYR0DCXMt8z0gVJJxBCjfyZwt4aRFVBOwdV9cf1H+olmDSOKI6lSMr
         hRUfbEBBvqw94aqTb9/1nQ01Fg9hzWtbjh6IQ2dkTsykqGwEeLWMEzIL7indfukGTNwP
         cxFjshG+fmT8YQiSKdKNQKQUJMmfS9CIX/ZcXouRMP5/zpWkvhef4+UVfsS1Oa84vUYV
         NnLqiyanD7xwa2Ccye7vlI7LEs1AaEwNvcAuJB3U2LIFVoIJKSr0CFii/q1oyhZR1bgz
         Lc4sVI6CkrgpOQfVjAGL+W7IrZEeg90NnrcTEPtEQxeaKTPq4CaBBx351fcNxFhTisc/
         hTog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qnqOkI31GeLljbB4WqZ/drBHY/AOebIdt+UdoPHqAJw=;
        b=GgbpnrifPJZpyDz2HI42i5+1Aq3KeZxo7mFSzVpyaE+uJGAdMeZt4AxLYJ/dw+YMGX
         PCo6XajfQnj48iE5I0TQXPthzSR5Zb3zqPLom1AIHWesItUyzd2R5znJH1NAO2IWPq58
         /pT0a/GDB8W4GC9TQG7JEj6D/yQwDS3irTLrE9mBPrM9W4ArW576I44cGP5dIyFKJ4J1
         pZGP0tLe7rKuVSTyM/tAbugTUUQQ1PZHUdBZatmeL02kabkdW8srtc04SDHGR51w+3rE
         6ph6BwrFIRmRTnQgds7uqGAX4nICsa8U8LElUdHUhv79AXxGxKbcnWKy7H/AMdVfAnk1
         17eA==
X-Gm-Message-State: AOAM531gU6oQuGr39ynTS4JJQXTgRB53WWcPDWzD82UbrvX23latqdK2
        xz3HqO6F4RSJI3ZKySE5i2rSRizjMyA=
X-Google-Smtp-Source: ABdhPJzo4WipOa5REJRCuIWa3GZ77rDx7Ec0c5inBFpS0bFACNZVuqqpEmml0rOPJAUy0HYhAfx+Pg==
X-Received: by 2002:a63:5914:: with SMTP id n20mr15831268pgb.164.1631993510669;
        Sat, 18 Sep 2021 12:31:50 -0700 (PDT)
Received: from localhost.localdomain ([49.204.135.121])
        by smtp.gmail.com with ESMTPSA id j6sm9861979pgh.17.2021.09.18.12.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 12:31:50 -0700 (PDT)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>
Subject: [PATCH v2 1/1] submodule--helper: fix incorrect newlines in an error message
Date:   Sun, 19 Sep 2021 01:01:16 +0530
Message-Id: <20210918193116.310575-2-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.32.0.385.gc00617bc03.dirty
In-Reply-To: <20210918193116.310575-1-kaartic.sivaraam@gmail.com>
References: <20210805192803.679948-1-kaartic.sivaraam@gmail.com>
 <20210918193116.310575-1-kaartic.sivaraam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A refactoring[1] done as part of the recent conversion of
'git submodule add' to builtin, changed the error message
shown when a Git directory already exists locally for a submodule
name. Before the refactoring, the error used to appear like so:

  --- START OF OUTPUT ---
  $ git submodule add ../sub/ subm
  A git directory for 'subm' is found locally with remote(s):
    origin        /me/git-repos-for-test/sub
  If you want to reuse this local git directory instead of cloning again from
    /me/git-repos-for-test/sub
  use the '--force' option. If the local git directory is not the correct repo
  or you are unsure what this means choose another name with the '--name' option.
  ---  END OF OUTPUT  ---

After the refactoring the error started appearing like so:

  --- START OF OUTPUT ---
  $ git submodule add ../sub/ subm
  A git directory for 'subm' is found locally with remote(s):  origin     /me/git-repos-for-test/sub
  fatal: If you want to reuse this local git directory instead of cloning again from
  /me/git-repos-for-test/sub
  use the '--force' option. If the local git directory is not the correct repo
  or if you are unsure what this means, choose another name with the '--name' option.

  ---  END OF OUTPUT  ---

As one could observe the remote information is printed along with the
first line rather than on its own line. Also, there's an additional
newline following output.

Make the error message consistent with the error message that used to be
printed before the refactoring.

This also moves the 'fatal:' prefix that appears in the middle of the
error message to the first line as it would more appropriate to have
it in the first line. The output after the change would look like:

  --- START OF OUTPUT ---
  $ git submodule add ../sub/ subm
  fatal: A git directory for 'subm' is found locally with remote(s):
    origin        /me/git-repos-for-test/sub
  If you want to reuse this local git directory instead of cloning again from
    /me/git-repos-for-test/sub
  use the '--force' option. If the local git directory is not the correct repo
  or you are unsure what this means choose another name with the '--name' option.
  ---  END OF OUTPUT  ---

[1]: https://lore.kernel.org/git/20210710074801.19917-5-raykar.ath@gmail.com/#t

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 builtin/submodule--helper.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 414fcb63ea..236da214c6 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2775,7 +2775,7 @@ struct add_data {
 };
 #define ADD_DATA_INIT { .depth = -1 }
 
-static void show_fetch_remotes(FILE *output, const char *sm_name, const char *git_dir_path)
+static void show_fetch_remotes(struct strbuf *msg, const char *sm_name, const char *git_dir_path)
 {
 	struct child_process cp_remote = CHILD_PROCESS_INIT;
 	struct strbuf sb_remote_out = STRBUF_INIT;
@@ -2791,7 +2791,7 @@ static void show_fetch_remotes(FILE *output, const char *sm_name, const char *gi
 		while ((next_line = strchr(line, '\n')) != NULL) {
 			size_t len = next_line - line;
 			if (strip_suffix_mem(line, &len, " (fetch)"))
-				fprintf(output, "  %.*s\n", (int)len, line);
+				strbuf_addf(msg, "  %.*s\n", (int)len, line);
 			line = next_line + 1;
 		}
 	}
@@ -2823,20 +2823,28 @@ static int add_submodule(const struct add_data *add_data)
 
 		if (is_directory(submod_gitdir_path)) {
 			if (!add_data->force) {
-				fprintf(stderr, _("A git directory for '%s' is found "
-						  "locally with remote(s):"),
-					add_data->sm_name);
-				show_fetch_remotes(stderr, add_data->sm_name,
+				struct strbuf msg = STRBUF_INIT;
+				char *die_msg;
+
+				strbuf_addf(&msg, _("A git directory for '%s' is found "
+						    "locally with remote(s):\n"),
+					    add_data->sm_name);
+
+				show_fetch_remotes(&msg, add_data->sm_name,
 						   submod_gitdir_path);
 				free(submod_gitdir_path);
-				die(_("If you want to reuse this local git "
-				      "directory instead of cloning again from\n"
-				      "  %s\n"
-				      "use the '--force' option. If the local git "
-				      "directory is not the correct repo\n"
-				      "or if you are unsure what this means, choose "
-				      "another name with the '--name' option.\n"),
-				    add_data->realrepo);
+
+				strbuf_addf(&msg, _("If you want to reuse this local git "
+						    "directory instead of cloning again from\n"
+						    "  %s\n"
+						    "use the '--force' option. If the local git "
+						    "directory is not the correct repo\n"
+						    "or you are unsure what this means choose "
+						    "another name with the '--name' option."),
+					    add_data->realrepo);
+
+				die_msg = strbuf_detach(&msg, NULL);
+				die("%s", die_msg);
 			} else {
 				printf(_("Reactivating local git directory for "
 					 "submodule '%s'\n"), add_data->sm_name);
-- 
2.32.0.385.gc00617bc03.dirty

