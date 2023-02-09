Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71261C05027
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 00:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjBIACd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 19:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjBIACZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 19:02:25 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DB4977B
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 16:02:24 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id pb12-20020a17090b3c0c00b0023086f62807so164610pjb.2
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 16:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NmBBXJHCXpbYnel3K3C7IJf0ydfzcb1xIWdlOlgOx3E=;
        b=QFaY5z50niXRJAD8lecsGXlIUJOIf/NU+qbKTq3Oa7Css0h7lh2gNf8XvN7DRvwnoe
         NZZqg8bMNx7TJ3iTI0NWhHxybMhlAY0l05AJDuuWgDvw/4MTvYr2R+5IkVlm2Gp5215o
         Yi2LVuafd8I4m+FAUpNvagOB3RPc0P/kj86WcyIKzePMF/BPuARgC6igTn5ObW4HGIC6
         vkGOVwJ0gPx951BkBzYNh8u0qSg6wPbWu7QI4qiJCrY31ttPBikL30ssoM7sXi9HxNlM
         eQjLW6ZbScd0pzz855pbWBA1FA9ANEZJiITwLJvPdDWNVOdhQsoIHN6j2o9n78h9N9px
         t5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NmBBXJHCXpbYnel3K3C7IJf0ydfzcb1xIWdlOlgOx3E=;
        b=wMfNxEcEhL4j1Hgku6Z0+4ZoI08+eyMV9AfhhIo1td7U4Op0QntrX2djWWzyzjCdHt
         9I/eKQOXxCS0hSit6n/0EM0ZvqrHikKugXAqfcg81eJg5J4APmoONubZeHZfpCvd2kvb
         vktf+5ybdmtYWR3s1lvLFbwf2nUGy9vxEGoFELRqSIJIWlL6AWRy6j3rqM+M2MWs8i8m
         gO1dQA9ICw9rY9VmmiI1Fxmr8f++YO4lUmfYQ5laAQrRuwgOZ+tV5oDcxUQe1P57EO6J
         xbGZHqIgi1iTWTZY/rPZNjSxIHlMyo/sUnQl1HCywqgvy1HMegpVWPtIsu3TB0ywNw5l
         I3+A==
X-Gm-Message-State: AO0yUKUD5BCugGmCoYbVFgfgNgQ6uE/bxcJ3e2sjJ6TTJ3bwA837rw5B
        6ZPNi0dyDwWYaRq6ySudo8GYUHWKvcGD0fSl2vZ/m2q5YGTlozbUW13ZSwRrOEzhrIZptRS/WTd
        TYn5wrIRbT4Bl9tpSUscK9fJZhtaUA8/WRGepQ46K979VTySloLb86m3IWnkl2i4tUw==
X-Google-Smtp-Source: AK7set/WcxVCszWIpM8w7J2xpl/j/RUCkEGQwgEMAbQdkd+62AZMXcvf0P4yUSS4wUkE4BKHKcdLR2pfimolnVc=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:903:258e:b0:192:63c3:7b5f with SMTP
 id jb14-20020a170903258e00b0019263c37b5fmr2332902plb.28.1675900943602; Wed,
 08 Feb 2023 16:02:23 -0800 (PST)
Date:   Thu,  9 Feb 2023 00:02:10 +0000
In-Reply-To: <20230207181706.363453-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230207181706.363453-1-calvinwan@google.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <20230209000212.1892457-5-calvinwan@google.com>
Subject: [PATCH v8 4/6] submodule: refactor is_submodule_modified()
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, avarab@gmail.com,
        chooglen@google.com, newren@gmail.com, jonathantanmy@google.com,
        phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor out submodule status logic and error messages that will be
used in a future patch.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 submodule.c | 65 ++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 23 deletions(-)

diff --git a/submodule.c b/submodule.c
index 768d4b4cd7..426074cebb 100644
--- a/submodule.c
+++ b/submodule.c
@@ -28,6 +28,10 @@ static int config_update_recurse_submodules = RECURSE_SUBMODULES_OFF;
 static int initialized_fetch_ref_tips;
 static struct oid_array ref_tips_before_fetch;
 static struct oid_array ref_tips_after_fetch;
+#define STATUS_PORCELAIN_START_ERROR \
+	N_("could not run 'git status --porcelain=2' in submodule %s")
+#define STATUS_PORCELAIN_FAIL_ERROR \
+	N_("'git status --porcelain=2' failed in submodule %s")
 
 /*
  * Check if the .gitmodules file is unmerged. Parsing of the .gitmodules file
@@ -1870,6 +1874,40 @@ int fetch_submodules(struct repository *r,
 	return spf.result;
 }
 
+static int verify_submodule_git_directory(const char *path)
+{
+	const char *git_dir;
+	struct strbuf buf = STRBUF_INIT;
+
+	strbuf_addf(&buf, "%s/.git", path);
+	git_dir = read_gitfile(buf.buf);
+	if (!git_dir)
+		git_dir = buf.buf;
+	if (!is_git_directory(git_dir)) {
+		if (is_directory(git_dir))
+			die(_("'%s' not recognized as a git repository"), git_dir);
+		strbuf_release(&buf);
+		/* The submodule is not checked out, so it is not modified */
+		return 0;
+	}
+	strbuf_release(&buf);
+	return 1;
+}
+
+static void prepare_status_porcelain(struct child_process *cp,
+			     const char *path, int ignore_untracked)
+{
+	strvec_pushl(&cp->args, "status", "--porcelain=2", NULL);
+	if (ignore_untracked)
+		strvec_push(&cp->args, "-uno");
+
+	prepare_submodule_repo_env(&cp->env);
+	cp->git_cmd = 1;
+	cp->no_stdin = 1;
+	cp->out = -1;
+	cp->dir = path;
+}
+
 static int parse_status_porcelain(char *str, size_t len,
 				  unsigned *dirty_submodule,
 				  int ignore_untracked)
@@ -1915,33 +1953,14 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 	struct strbuf buf = STRBUF_INIT;
 	FILE *fp;
 	unsigned dirty_submodule = 0;
-	const char *git_dir;
 	int ignore_cp_exit_code = 0;
 
-	strbuf_addf(&buf, "%s/.git", path);
-	git_dir = read_gitfile(buf.buf);
-	if (!git_dir)
-		git_dir = buf.buf;
-	if (!is_git_directory(git_dir)) {
-		if (is_directory(git_dir))
-			die(_("'%s' not recognized as a git repository"), git_dir);
-		strbuf_release(&buf);
-		/* The submodule is not checked out, so it is not modified */
+	if (!verify_submodule_git_directory(path))
 		return 0;
-	}
-	strbuf_reset(&buf);
-
-	strvec_pushl(&cp.args, "status", "--porcelain=2", NULL);
-	if (ignore_untracked)
-		strvec_push(&cp.args, "-uno");
 
-	prepare_submodule_repo_env(&cp.env);
-	cp.git_cmd = 1;
-	cp.no_stdin = 1;
-	cp.out = -1;
-	cp.dir = path;
+	prepare_status_porcelain(&cp, path, ignore_untracked);
 	if (start_command(&cp))
-		die(_("Could not run 'git status --porcelain=2' in submodule %s"), path);
+		die(_(STATUS_PORCELAIN_START_ERROR), path);
 
 	fp = xfdopen(cp.out, "r");
 	while (strbuf_getwholeline(&buf, fp, '\n') != EOF) {
@@ -1956,7 +1975,7 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 	fclose(fp);
 
 	if (finish_command(&cp) && !ignore_cp_exit_code)
-		die(_("'git status --porcelain=2' failed in submodule %s"), path);
+		die(_(STATUS_PORCELAIN_FAIL_ERROR), path);
 
 	strbuf_release(&buf);
 	return dirty_submodule;
-- 
2.39.1.519.gcb327c4b5f-goog

