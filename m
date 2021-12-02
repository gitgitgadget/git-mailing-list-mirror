Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11903C433EF
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 14:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358744AbhLBOs7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 09:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358685AbhLBOse (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 09:48:34 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2E2C061757
        for <git@vger.kernel.org>; Thu,  2 Dec 2021 06:45:11 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id m15so27280565pgu.11
        for <git@vger.kernel.org>; Thu, 02 Dec 2021 06:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O+cbsQE9xDUjcjQHZKFwUSpnMvssbsaYKWlxbENigpY=;
        b=hMgzxazckaVbO5l7ZTgdCMH+YozmijA7Q8j3D34r8dki3j8+NBw9ZdwoyEwhZmpgdA
         237oc8IhpNknWkjpN7FwZXt0wpsqoiyqBdRyIy5gzKI0XON/6UKOB0rA9CiNzMrpbWuz
         x3KqKJ/x4maxprCIOjKQQ/A1LcV9V9XnqNolcfW0tU6vJTQZz5uaUdwnoerN0ByC1ZkR
         LphoKKsvSgGsIPfdWP7z1fFhU/Lj3zfIqHvSI4E6gS2CEiclRcKIEltrJ1H7IlsDWoWK
         AW1wrRQkX407iUhGYLG8zI8SCdTqfpzGwT4WNISKLlaeZ6YwDWT7C/Kni2X9q365DhYu
         DmIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O+cbsQE9xDUjcjQHZKFwUSpnMvssbsaYKWlxbENigpY=;
        b=yzX0x6586Gw9mYGqzOrcLpqxUoiKTveCkdze0W7c2SVqAxjyZI7DcSMSIdH/2X5+Io
         qu7/sV3fQl5nA0YM/H8LAw4OrWhr1PS2/xbvn/3xQnmmUMlql334pxdGKghghYQNqmVV
         f6PPPk9GQpgKVWk/VZP4XQFBjavoJceQEeVckZLbIAuMwHpQkfcGWifpGpBKP9wy0UEg
         UNkTTil3pnR5hG8MEiYvBcDP/lTeCRgiPdD+6U3feAkG5Lwpn1Sw7jzIDAi4LCcYmAPA
         N2CByK+iEh19L+GNVGHHCsFGxmDcwBfqjTAzUYYCQaQM88rIAEsDjvZspvoLnsSo2w/J
         UF0A==
X-Gm-Message-State: AOAM531yJ5MoWD3Y5S/TpOlMakdpSzW/WCsC3kFpYzFr0PMlTTokz+Dv
        m8cubccxMqIbResXvjM/SwEMUyByJrI=
X-Google-Smtp-Source: ABdhPJxI2ZcWDMNrUK7EyUVePUmVDMRV01z7drG4aGEqJHotFXr3HTdjK4szOdlTbLV6Vrf9YNv2VA==
X-Received: by 2002:a65:4cc7:: with SMTP id n7mr9811718pgt.179.1638456310917;
        Thu, 02 Dec 2021 06:45:10 -0800 (PST)
Received: from LAPTOP-FJDAS7G4.localdomain ([157.40.224.105])
        by smtp.gmail.com with ESMTPSA id mp12sm2784451pjb.39.2021.12.02.06.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 06:45:10 -0800 (PST)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     git@vger.kernel.org
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: [RFC PATCH 1/1] push: make '-u' have default arguments
Date:   Thu,  2 Dec 2021 20:13:54 +0530
Message-Id: <20211202144354.17416-2-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211202144354.17416-1-chakrabortyabhradeep79@gmail.com>
References: <20211202144354.17416-1-chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For now, -u in 'push' command requires two arguments (<repository>
and <refspec>) to successfully track upstream branch. In most cases,
users want to set an upstream branch for the local branch they are
currently on and the short names of these two branches are same in
most of the cases. There are plenty of configurations to set default
branches for push but again users can't run argumentless pull, rebase
etc. So it will be good to have '-u' having default arguments.

This commit gives ability to '-u' to have default arguments. 'git push
-u' runs normally if <repository> and <refspec> are given. But
if those are not given then it tries to get the value of <repository>
from 'branch.<current_branch>.remote'. If not found, it sets 'origin'
as the value of <repository>. <refspec> would be the current branch's
short name.

However 'git push -u --all' work normally as before.

Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
---
 Documentation/git-push.txt |  6 +++++
 builtin/push.c             | 48 ++++++++++++++++++++++++++++----------
 t/t5523-push-upstream.sh   | 11 +++++++++
 3 files changed, 53 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 2f25aa3a29..e1a8b41818 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -375,6 +375,12 @@ Specifying `--no-force-if-includes` disables this behavior.
 	upstream (tracking) reference, used by argument-less
 	linkgit:git-pull[1] and other commands. For more information,
 	see `branch.<name>.merge` in linkgit:git-config[1].
++
+If you use -u without any arguments (i.e. no <repository> and <refspec>),
+it will first try to get the <repository> from current branch's remote
+configuration (i.e. from `branch.<name>.remote`). If not found, it will set
+`origin` as the value of <repository> and <refspec> will be the current
+branch's refspec.
 
 --[no-]thin::
 	These options are passed to linkgit:git-send-pack[1]. A thin transfer
diff --git a/builtin/push.c b/builtin/push.c
index 4b026ce6c6..2e417a06ad 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -527,6 +527,25 @@ static int git_push_config(const char *k, const char *v, void *cb)
 	return git_default_config(k, v, NULL);
 }
 
+static struct remote *pushremote_get_remote(const char *repo)
+{
+	struct remote *remote = pushremote_get(repo);
+	if (!remote) {
+		if (repo)
+			die(_("bad repository '%s'"), repo);
+		die(_("No configured push destination.\n"
+		    "Either specify the URL from the command-line or configure a remote repository using\n"
+		    "\n"
+		    "    git remote add <name> <url>\n"
+		    "\n"
+		    "and then push using the remote name\n"
+		    "\n"
+		    "    git push <name>\n"));
+	}
+
+	return remote;
+}
+
 int cmd_push(int argc, const char **argv, const char *prefix)
 {
 	int flags = 0;
@@ -537,6 +556,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	struct string_list push_options_cmdline = STRING_LIST_INIT_DUP;
 	struct string_list *push_options;
 	const struct string_list_item *item;
+	struct remote *default_remote = NULL;
 	struct remote *remote;
 
 	struct option options[] = {
@@ -603,23 +623,27 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	if (tags)
 		refspec_append(&rs, "refs/tags/*");
 
+	if ((argc == 0) && (flags & TRANSPORT_PUSH_SET_UPSTREAM) && !(flags & TRANSPORT_PUSH_ALL)) {
+		struct branch *branch = branch_get(NULL);
+		if (branch) {
+			argc += 2;
+			default_remote = pushremote_get_remote(repo);
+			argv[0] = default_remote->name;
+			argv[1] = branch->name;
+		}
+	}
+
 	if (argc > 0) {
 		repo = argv[0];
 		set_refspecs(argv + 1, argc - 1, repo);
 	}
 
-	remote = pushremote_get(repo);
-	if (!remote) {
-		if (repo)
-			die(_("bad repository '%s'"), repo);
-		die(_("No configured push destination.\n"
-		    "Either specify the URL from the command-line or configure a remote repository using\n"
-		    "\n"
-		    "    git remote add <name> <url>\n"
-		    "\n"
-		    "and then push using the remote name\n"
-		    "\n"
-		    "    git push <name>\n"));
+	if (default_remote) {
+		remote = default_remote;
+		default_remote = NULL;
+	}
+	else {
+		remote = pushremote_get_remote(repo);
 	}
 
 	if (remote->mirror)
diff --git a/t/t5523-push-upstream.sh b/t/t5523-push-upstream.sh
index fdb4292056..69970b6263 100755
--- a/t/t5523-push-upstream.sh
+++ b/t/t5523-push-upstream.sh
@@ -60,6 +60,17 @@ test_expect_success 'push -u :topic_2' '
 	check_config topic_2 upstream refs/heads/other2
 '
 
+test_expect_success 'push -u' '
+	git push -u &&
+	check_config main upstream refs/heads/main
+'
+
+test_expect_success 'push -u --dry-run' '
+	git push -u upstream main:other &&
+	git push -u --dry-run &&
+	check_config main upstream refs/heads/other
+'
+
 test_expect_success 'push -u --all' '
 	git branch all1 &&
 	git branch all2 &&
-- 
2.17.1

