From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 5/5] builtin/clone: Configure submodule.autoInitialize via --init-submodule
Date: Fri, 22 Jan 2016 16:31:43 -0800
Message-ID: <1453509103-16470-6-git-send-email-sbeller@google.com>
References: <1453509103-16470-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, Jens.Lehmann@web.de,
	jrnieder@gmail.com, sschuberth@gmail.com
X-From: git-owner@vger.kernel.org Sat Jan 23 01:32:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMm7f-0006pu-7T
	for gcvg-git-2@plane.gmane.org; Sat, 23 Jan 2016 01:32:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755740AbcAWAcE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 19:32:04 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36719 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755670AbcAWAby (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 19:31:54 -0500
Received: by mail-pa0-f42.google.com with SMTP id yy13so49276882pab.3
        for <git@vger.kernel.org>; Fri, 22 Jan 2016 16:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PZjwyB3z2KmVmqzMf/aG+BM2wo+/NeBOQYuOjUvkl6c=;
        b=G6nX41gw2WsXY0Y0G0SL13eDcsxqimQgEzwCd3vb5xnuHuRMhSTxBh5wcIHGH0hdlr
         5wgJYcCC8KrxoBZMHD6xefxF6UX2Em2ItFusb9I85WpftD3YOvb+D/jjcMETZayr3KFh
         /+vwMDfWSBn9xIf6hkf9e3B7EpvzROZHfcsPSSOnwKCWWDHf4+U42cIYhQnRXiNcFnBq
         E7XvAekDHo2HCgjnpxDrsfhZ/D1XpJ3bbBxqPR6ebk1hpen7T8M/XhvvPXNa0zUC7bvi
         +Sow9r4HtRpr5Vc/RmoOZevORLYnWEEHkphANL8l8So/VKZU9LaVrjlMUinhPSuclfuT
         gcwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PZjwyB3z2KmVmqzMf/aG+BM2wo+/NeBOQYuOjUvkl6c=;
        b=l/+sBw2bR+jifcPXNUqkoq2J4ELaUVlIX0lSo2K5sVmAqQiw7MSj8UNotK+Vb3nqjx
         ZUCkEN/RJQttgw8w1eAKCHUPITocoH/Tf1+joxzJA+9F9f2c9jVUjzOEyzLIupgYx127
         RCz+yi3Atw71t3AgMXGM4Pfbge9cKD5JOLohB4IL4x84BME3qawsQTQ/SvAFEj3KeVoD
         B8CUoEyNT0h50u+bd3JnkKmaSik7D1mxd3AUunAMbtZuxjOns1pYVsX+oxqOpXdL1L2B
         ZryTuj2vBWmFMBzd7ICmvwYOUzlDyF68h3goNFBxbcs3WN8CjfFiBP4MwDsHABi3/U0u
         Puyw==
X-Gm-Message-State: AG10YOQz60SeT2RkiP+8UOTPwxYg0UG0m9Bf3FHFhqqCwBjGWW5hWRRQje2y/RBhfOP2R1dJ
X-Received: by 10.67.2.10 with SMTP id bk10mr8432632pad.26.1453509113907;
        Fri, 22 Jan 2016 16:31:53 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:add1:48d1:6b77:ed16])
        by smtp.gmail.com with ESMTPSA id qz9sm12165141pab.39.2016.01.22.16.31.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 22 Jan 2016 16:31:53 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.42.g77a36b9.dirty
In-Reply-To: <1453509103-16470-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284616>

When invoking clone with the --init-submodule option, the choice will be
recorded in the submodule.autoInitialize config option.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-clone.txt |   6 +++
 builtin/clone.c             |  40 ++++++++++++++++--
 t/t7400-submodule-basic.sh  | 101 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 144 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 6db7b6d..4baf444 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -214,6 +214,12 @@ objects from the source repository into a pack in the cloned repository.
 	repository does not have a worktree/checkout (i.e. if any of
 	`--no-checkout`/`-n`, `--bare`, or `--mirror` is given)
 
+--init-submodule::
+	After the repository is cloned, specified submodules are cloned.
+	It is possible to give multiple specifications by repeating the
+	argument. This option will be recorded in the repository config
+	as `submodule.autoInitialize`.
+
 --separate-git-dir=<git dir>::
 	Instead of placing the cloned repository where it is supposed
 	to be, place the cloned repository at the specified directory,
diff --git a/builtin/clone.c b/builtin/clone.c
index b004fb4..3c37c3d 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -51,6 +51,22 @@ static struct string_list option_config;
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
@@ -95,6 +111,8 @@ static struct option builtin_clone_options[] = {
 		   N_("separate git dir from working tree")),
 	OPT_STRING_LIST('c', "config", &option_config, N_("key=value"),
 			N_("set config inside the new repository")),
+	OPT_CALLBACK(0, "init-submodule", &init_submodules, N_("string"),
+			N_("clone specific submodules"), init_submodules_cb),
 	OPT_END()
 };
 
@@ -723,9 +741,17 @@ static int checkout(void)
 	err |= run_hook_le(NULL, "post-checkout", sha1_to_hex(null_sha1),
 			   sha1_to_hex(sha1), "1", NULL);
 
-	if (!err && option_recursive) {
+	if (err)
+		goto out;
+
+	if (option_recursive || init_submodules.nr > 0) {
 		struct argv_array args = ARGV_ARRAY_INIT;
-		argv_array_pushl(&args, "submodule", "update", "--init", "--recursive", NULL);
+		argv_array_pushl(&args, "submodule", "update", NULL);
+
+		if (option_recursive) {
+			argv_array_pushf(&args, "--init");
+			argv_array_pushf(&args, "--recursive");
+		}
 
 		if (max_jobs != -1)
 			argv_array_pushf(&args, "--jobs=%d", max_jobs);
@@ -733,7 +759,7 @@ static int checkout(void)
 		err = run_command_v_opt(args.argv, RUN_GIT_CMD);
 		argv_array_clear(&args);
 	}
-
+out:
 	return err;
 }
 
@@ -867,6 +893,14 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			die(_("--bare and --separate-git-dir are incompatible."));
 		option_no_checkout = 1;
 	}
+	if (init_submodules.nr > 0) {
+		struct string_list_item *item;
+		struct strbuf sb = STRBUF_INIT;
+		for_each_string_list_item(item, &init_submodules) {
+			strbuf_addf(&sb, "submodule.autoInitialize=%s", item->string);
+			string_list_append(&option_config, strbuf_detach(&sb, 0));
+		}
+	}
 
 	if (!option_origin)
 		option_origin = "origin";
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index e1ade1e..e83f403 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1064,4 +1064,105 @@ test_expect_success 'submodule update auto-initializes submodules' '
 	test_cmp actual expected
 '
 
+cat <<EOF > expected
+submodule
+-submodule1
+EOF
+
+test_expect_success 'clone --init-submodule works' '
+	test_when_finished "rm -rf super super_clone" &&
+	mkdir super &&
+	pwd=$(pwd) &&
+	(
+		cd super &&
+		git init &&
+		git submodule add --label labelA file://"$pwd"/example2 submodule &&
+		git submodule add file://"$pwd"/example2 submodule1 &&
+		git commit -a -m "create repository with 2 submodules, one is in a group"
+	) &&
+	git clone --init-submodule \*labelA super super_clone &&
+	(
+		cd super_clone &&
+		git submodule status |cut -c1,42-52 | tr -d " " >../actual
+	) &&
+	test_cmp actual expected
+'
+
+cat <<EOF > expected
+-submodule1
+submoduleA
+-submoduleB
+submoduleC
+-submoduleD
+submoduleE
+EOF
+
+test_expect_success 'clone initializes submodules correctly with more than one --init-submodule option' '
+	test_when_finished "rm -rf super super_clone" &&
+	mkdir super &&
+	pwd=$(pwd) &&
+	(
+		cd super &&
+		git init &&
+		git submodule add --label groupA file://"$pwd"/example2 submoduleA &&
+		git submodule add --label groupB file://"$pwd"/example2 submoduleB &&
+		git submodule add --label groupC file://"$pwd"/example2 submoduleC &&
+		git submodule add --label groupD --name submoduleE file://"$pwd"/example2 submoduleD &&
+		git submodule add --label groupE --name submoduleD file://"$pwd"/example2 submoduleE &&
+		git submodule add file://"$pwd"/example2 submodule1 &&
+		git commit -a -m "create repository with submodules groups"
+	) &&
+	git clone --init-submodule=\*groupA --init-submodule ./submoduleC --init-submodule :submoduleD super super_clone &&
+	(
+		cd super_clone &&
+		git submodule status |cut -c1,42-52 | tr -d " " >../actual
+	) &&
+	test_cmp actual expected
+'
+
+cat <<EOF > expected1
+submoduleA
+-submoduleB
+EOF
+
+cat <<EOF > expected2
+submoduleA
+-submoduleB
+submoduleC
+EOF
+
+test_expect_success 'clone and subsequent updates correctly auto-initialize submodules' '
+	test_when_finished "rm -rf super super_clone" &&
+	mkdir super &&
+	pwd=$(pwd) &&
+	(
+		cd super &&
+		git init &&
+		git submodule add --label LA file://"$pwd"/example2 submoduleA &&
+		git submodule add file://"$pwd"/example2 submoduleB &&
+		git commit -a -m "create repository with submodules groups"
+	) &&
+	git clone --init-submodule=\*LA super super_clone &&
+	(
+		cd super_clone &&
+		git submodule status |cut -c1,42-52 | tr -d " " >../actual
+	) &&
+	test_cmp actual expected1 &&
+	(
+		cd super &&
+		git init &&
+		git submodule add --label LA file://"$pwd"/example2 submoduleC &&
+		git commit -a -m "add another labled submodule"
+	) &&
+	(
+		cd super_clone &&
+		# obtain the new superproject
+		git pull &&
+		# submoduleC should just appear as it has the label LA
+		# which was configured to autoInitialize in git clone
+		git submodule update &&
+		git submodule status |cut -c1,42-52 | tr -d " " >../actual
+	) &&
+	test_cmp actual expected2
+'
 test_done
-- 
2.7.0.rc0.42.g77a36b9.dirty
