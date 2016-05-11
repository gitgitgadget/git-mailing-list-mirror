From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 7/7] clone: allow specification of submodules to be cloned
Date: Tue, 10 May 2016 17:59:57 -0700
Message-ID: <1462928397-1708-8-git-send-email-sbeller@google.com>
References: <1462928397-1708-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, pclouds@gmail.com,
	Stefan Beller <sbeller@google.com>
To: jrnieder@gmail.com, gitster@pobox.com, Jens.Lehmann@web.de
X-From: git-owner@vger.kernel.org Wed May 11 03:00:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0IVu-00028Y-VV
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 03:00:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537AbcEKBAY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 21:00:24 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:32933 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446AbcEKBAS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 21:00:18 -0400
Received: by mail-pf0-f176.google.com with SMTP id 206so11782531pfu.0
        for <git@vger.kernel.org>; Tue, 10 May 2016 18:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YcnfViL32lixG3VpRJZShnPbvWfXs7C6BcaoCH9BVUQ=;
        b=MsCVO1HXyLuXKIj/NoL8pD3dmCCD/XSNbs2DkgajsYqAn8oKzK5GVGZyLrDYsi0fGh
         ajpjxpB+4ZBxbLIWX/JE6MId9eSuyenSdBEUrXBBVM7FKOj/QjV7PmN8U3VHteajaaZy
         9IsaaKbaeq8LE9QUa5ewsLHpbNt1fYOYvJAm4KIBuqYBrpk/N7ze39zLEIJiJVl8ZGXL
         Ch4WhrU+SA91whoG8E4R1XnYUHKM6kxH7B126J9Y4HN48mwIAGQEXYV74S/VhugVamGr
         9rpYcfyirOTGd7XrpW//6f42++ozBrJh1GK4GSZ8m0u9LJtz3U+k6UhFf3x9dKFHg3kh
         AFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YcnfViL32lixG3VpRJZShnPbvWfXs7C6BcaoCH9BVUQ=;
        b=eJSD7VOP3g+CL0r585VX+4GGG98BaAOfxTmJNrpxWoU+0EkQlbguGNwn8Z2/mFMada
         XU4jWNNgY4qgqi7HCqSXI60g4TkNK0guR39tlznywvviU2VqxL+HmONGlbM28GyJ4AZd
         hcQtSiPjk0ynPBneZawGp+mCIdBgmqHifyvst8TzR/uJFiwUGEJoMS7mnALOy1Yx/sKK
         3K9VZE1TmmW1lI7lxJTIsxjR8Q0bCwkwD8D79v2nHG4YYsGc918LProbXZAG1Dt2Es0F
         2b06LrKSPBEd55ozdEOPMwXEXha1dkoV0nNrwfPb891LM8d8ExgVTLylPf4SVsbRumc7
         qTGA==
X-Gm-Message-State: AOPr4FVc5NfsRjFSlXSSGdOwWhgtQvEBl0Q17A5C5c6EB/0JgjrlGjk3pZ2ZtpaRXsl2U/ar
X-Received: by 10.98.14.93 with SMTP id w90mr706642pfi.69.1462928417312;
        Tue, 10 May 2016 18:00:17 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:69ac:db78:a0d1:60da])
        by smtp.gmail.com with ESMTPSA id bf4sm7274753pac.4.2016.05.10.18.00.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 10 May 2016 18:00:16 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.35.g58985d9.dirty
In-Reply-To: <1462928397-1708-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294213>

This allows to specify a subset of all available submodules to be
initialized and cloned. It is unrelated to the `--recursive` option,
i.e. the user may still want to give `--recursive` as an option.

Originally `--recursive` implied to initialize all submodules, this
changes as well with the new option, such that only the specified
submodules are cloned, and their submodules (i.e. subsubmodules)
are cloned in full as the submodule specification is not passed on.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-clone.txt | 26 +++++++++++----
 builtin/clone.c             | 40 +++++++++++++++++++++--
 t/t7400-submodule-basic.sh  | 79 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 136 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 45d74be..4a9e8bb 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -14,7 +14,8 @@ SYNOPSIS
 	  [-o <name>] [-b <name>] [-u <upload-pack>] [--reference <repository>]
 	  [--dissociate] [--separate-git-dir <git dir>]
 	  [--depth <depth>] [--[no-]single-branch]
-	  [--recursive | --recurse-submodules] [--jobs <n>] [--] <repository>
+	  [--recursive | --recurse-submodules] [--jobs <n>]
+	  [--init-submodule <submodulespec>] [--] <repository>
 	  [<directory>]
 
 DESCRIPTION
@@ -205,12 +206,23 @@ objects from the source repository into a pack in the cloned repository.
 
 --recursive::
 --recurse-submodules::
-	After the clone is created, initialize all submodules within,
-	using their default settings. This is equivalent to running
-	`git submodule update --init --recursive` immediately after
-	the clone is finished. This option is ignored if the cloned
-	repository does not have a worktree/checkout (i.e. if any of
-	`--no-checkout`/`-n`, `--bare`, or `--mirror` is given)
+	After the clone is created, initialize and clone all submodules
+	within, using their default settings. This is equivalent to
+	running `git submodule update --recursive --init <submodulespec>`
+	immediately after the clone is finished. This option is ignored
+	if the cloned repository does not have a worktree/checkout (i.e.
+	if any of `--no-checkout`/`-n`, `--bare`, or `--mirror` is given)
+
+--init-submodule::
+	After the clone is cloned, initialize and clone specified
+	submodules within, using their default settings. It is possible
+	to give multiple specifications by giving this argument multiple
+	times or by giving a comma separated list. This is equivalent to
+	running `git submodule update <submodulespec>` immediately
+	after the clone is finished. To specify submodules you can use
+	their path, name or labels, see linkgit:git-submodules[1]. This
+	option will be recorded in the repository config as
+	`submodule.updateGroup`.
 
 --separate-git-dir=<git dir>::
 	Instead of placing the cloned repository where it is supposed
diff --git a/builtin/clone.c b/builtin/clone.c
index 6576ecf..fa2f989 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -52,6 +52,22 @@ static struct string_list option_config;
 static struct string_list option_reference;
 static int option_dissociate;
 static int max_jobs = -1;
+static struct string_list init_submodules;
+
+static int init_submodules_cb(const struct option *opt, const char *arg, int unset)
+{
+	struct string_list_item *item;
+	struct string_list sl = STRING_LIST_INIT_DUP;
+
+	if (unset)
+		return -1;
+
+	string_list_split(&sl, arg, ',', -1);
+	for_each_string_list_item(item, &sl)
+		string_list_append((struct string_list *)opt->value, item->string);
+
+	return 0;
+}
 
 static struct option builtin_clone_options[] = {
 	OPT__VERBOSITY(&option_verbosity),
@@ -100,6 +116,8 @@ static struct option builtin_clone_options[] = {
 			TRANSPORT_FAMILY_IPV4),
 	OPT_SET_INT('6', "ipv6", &family, N_("use IPv6 addresses only"),
 			TRANSPORT_FAMILY_IPV6),
+	OPT_CALLBACK(0, "init-submodule", &init_submodules, N_("string"),
+			N_("clone specific submodules"), init_submodules_cb),
 	OPT_END()
 };
 
@@ -731,13 +749,22 @@ static int checkout(void)
 	err |= run_hook_le(NULL, "post-checkout", sha1_to_hex(null_sha1),
 			   sha1_to_hex(sha1), "1", NULL);
 
-	if (!err && option_recursive) {
+	if (!err && (option_recursive || init_submodules.nr > 0)) {
 		struct argv_array args = ARGV_ARRAY_INIT;
-		argv_array_pushl(&args, "submodule", "update", "--init", "--recursive", NULL);
+		struct string_list_item *item;
+		argv_array_pushl(&args, "submodule", "update", NULL);
+
+		argv_array_pushf(&args, "--init");
+
+		if (option_recursive)
+			argv_array_pushf(&args, "--recursive");
 
 		if (max_jobs != -1)
 			argv_array_pushf(&args, "--jobs=%d", max_jobs);
 
+		for_each_string_list_item(item, &init_submodules)
+			argv_array_push(&args, item->string);
+
 		err = run_command_v_opt(args.argv, RUN_GIT_CMD);
 		argv_array_clear(&args);
 	}
@@ -876,6 +903,15 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		option_no_checkout = 1;
 	}
 
+	if (init_submodules.nr > 0) {
+		struct string_list_item *item;
+		struct strbuf sb = STRBUF_INIT;
+		for_each_string_list_item(item, &init_submodules) {
+			strbuf_addf(&sb, "submodule.updateGroup=%s", item->string);
+			string_list_append(&option_config, strbuf_detach(&sb, 0));
+		}
+	}
+
 	if (!option_origin)
 		option_origin = "origin";
 
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 41e65c2..e7b6c1f 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1192,4 +1192,83 @@ test_expect_success 'submodule update --init-default-group' '
 	test_cmp expect actual
 '
 
+cat <<EOF > expected
+-sub0
+ sub1 (test2)
+-sub2
+ sub3 (test2)
+EOF
+
+test_expect_success 'clone --init-submodule works' '
+	test_when_finished "rm -rf super super_clone" &&
+	git clone --recurse-submodules --init-submodule \*bit1 labeledsuper super_clone &&
+	(
+		cd super_clone &&
+		git submodule status |cut -c 1,43- >../actual
+	) &&
+	test_cmp actual expected
+'
+
+cat <<EOF > expect
+ sub0 (test2)
+ sub1 (test2)
+-sub2
+ sub3 (test2)
+EOF
+test_expect_success 'clone with multiple --init-submodule options' '
+	test_when_finished "rm -rf super super_clone" &&
+	git clone --recurse-submodules --init-submodule=\*bit1 --init-submodule ./sub0 labeledsuper super_clone &&
+	(
+		cd super_clone &&
+		git submodule status |cut -c1,43- >../actual
+	) &&
+	test_cmp expect actual
+'
+
+cat <<EOF > expect
+ submoduleA (test2)
+-submoduleB
+EOF
+
+cat <<EOF > expect2
+ submoduleA (test2)
+-submoduleB
+ submoduleC (test2)
+EOF
+
+test_expect_success 'clone and subsequent updates correctly auto-initialize submodules' '
+	test_when_finished "rm -rf super super_clone" &&
+	mkdir super &&
+	pwd=$(pwd) &&
+	(
+		cd super &&
+		git init &&
+		git submodule add --label LA file://"$pwd"/sub1 submoduleA &&
+		git submodule add file://"$pwd"/sub1 submoduleB &&
+		git commit -a -m "create repository with submodules groups"
+	) &&
+	git clone --recurse-submodules --init-submodule=\*LA super super_clone &&
+	(
+		cd super_clone &&
+		git submodule status |cut -c1,43- >../actual
+	) &&
+	test_cmp expect actual &&
+	(
+		cd super &&
+		git init &&
+		git submodule add --label LA file://"$pwd"/sub1 submoduleC &&
+		git commit -a -m "add another labled submodule"
+	) &&
+	(
+		cd super_clone &&
+		# obtain the new superproject
+		git pull &&
+		# submoduleC should just appear as it has the label LA
+		# which was configured in git clone
+		git submodule update --init-default-group &&
+		git submodule status |cut -c1,43- >../actual
+	) &&
+	test_cmp expect2 actual
+'
+
 test_done
-- 
2.8.0.35.g58985d9.dirty
