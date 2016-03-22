From: Stefan Beller <sbeller@google.com>
Subject: [RFC_PATCHv4 6/7] clone: allow specification of submodules to be cloned
Date: Mon, 21 Mar 2016 19:06:11 -0700
Message-ID: <1458612372-10966-7-git-send-email-sbeller@google.com>
References: <1458612372-10966-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: Jens.Lehmann@web.de, sschuberth@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 22 03:06:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiBiQ-0000gs-0N
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 03:06:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758226AbcCVCGe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 22:06:34 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33451 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758141AbcCVCGd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 22:06:33 -0400
Received: by mail-pf0-f171.google.com with SMTP id 4so156851090pfd.0
        for <git@vger.kernel.org>; Mon, 21 Mar 2016 19:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Af1CSqs1cDtTHY2G4Ll2y4AoHhmitglJ8skEV4kThh0=;
        b=eHPSYhyXLyGlF4whF8c0CfMyFn6PUkF22qBFGSDRTWv9RzL9mXTMliY1b/oRE+X33V
         PyE+huJwMjUYle/VlPyNQOvDGY+3WsBRTwl8jPTIZSvs743qKV1P/cJHjbDWQHTroJd5
         z0oVlRrHiGbQCGEp3FZ6davfSETFwX03i6hTe5aYueBWCWz6tyP84eLBufYwwXBrFd3V
         I3yB0p+5JA0Z1VqfKUl+y4Z5iXwZc1ykCAqrLloWDYoZZQaDWz5rQGEKvvClofY1PKBB
         gCZzFmbjXK47J0ITq12HKexkIdZXVThBPv8/ArgV2OQ9pRUUCXy5cyZPohwH8xYhQ5oE
         8HDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Af1CSqs1cDtTHY2G4Ll2y4AoHhmitglJ8skEV4kThh0=;
        b=d6GvkGLYdY5ud7p2u6rtpb1cm8kKOV24IPArxNOwSGLM0j45hk1eWy477+zbL/vVoU
         Oj2oR4pGbil5ZWbDFl1Fik/cNpViqrIY++gEFHyqj26/YSOXaHB5vsi35h9MLHXojlA5
         jo2TgZeawSxgQVnRFADXs6eHiE1WS8ygza+FaQeH67p+4IyxgRb6kL0lUBdTGNCV7IDQ
         Bw2L8/4INWo243O6Ct3JIdjwwKpl915btavt7gcTEIxFl6GEBMAVj4xnioj3w3Lk6Gq6
         g2xPfMK4Z/0tcnfrHmeMxrXa8UDYD3uNx7XokxH2Br81wf0kdmPFyAyRURp0pn/tVqlv
         4ffQ==
X-Gm-Message-State: AD7BkJL1phdvf10pxXaqkgiQSdAvH8GMZ4zhitM/l043t5Yy2EOI5xW1pQF4AStl/c7XkT2O
X-Received: by 10.98.10.20 with SMTP id s20mr49719149pfi.109.1458612392158;
        Mon, 21 Mar 2016 19:06:32 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:f1b0:8994:3428:87f7])
        by smtp.gmail.com with ESMTPSA id by3sm43686286pab.39.2016.03.21.19.06.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 21 Mar 2016 19:06:31 -0700 (PDT)
X-Mailer: git-send-email 2.7.0.rc0.45.g6b4c145
In-Reply-To: <1458612372-10966-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289482>

This is in line with clone being the contraction of
    mkdir <path> && cd <path>
    git init
    git config
    git fetch
    git submodule update

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-clone.txt |   6 ++
 builtin/clone.c             |  40 ++++++++++++-
 t/t7400-submodule-basic.sh  | 134 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 177 insertions(+), 3 deletions(-)

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
index b004fb4..e2af9b8 100644
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
 
@@ -723,17 +741,24 @@ static int checkout(void)
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
 
+		if (option_recursive) {
+			argv_array_pushf(&args, "--init");
+			argv_array_pushf(&args, "--recursive");
+		}
 		if (max_jobs != -1)
 			argv_array_pushf(&args, "--jobs=%d", max_jobs);
 
 		err = run_command_v_opt(args.argv, RUN_GIT_CMD);
 		argv_array_clear(&args);
 	}
-
+out:
 	return err;
 }
 
@@ -868,6 +893,15 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		option_no_checkout = 1;
 	}
 
+	if (init_submodules.nr > 0) {
+		struct string_list_item *item;
+		struct strbuf sb = STRBUF_INIT;
+		for_each_string_list_item(item, &init_submodules) {
+			strbuf_addf(&sb, "submodule.actionOnLabel=%s", item->string);
+			string_list_append(&option_config, strbuf_detach(&sb, 0));
+		}
+	}
+
 	if (!option_origin)
 		option_origin = "origin";
 
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index dc45551..58da5c4 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1147,4 +1147,138 @@ test_expect_success 'Change labels in .git/config' '
 	test_cmp actual expected
 '
 
+cat <<EOF > expected
+submodule
+submodule1
+submodule2
+-submodule3
+EOF
+
+test_expect_success 'submodule update auto-initializes submodules' '
+	test_when_finished "rm -rf super super_clone" &&
+	mkdir super &&
+	pwd=$(pwd) &&
+	(
+		cd super &&
+		git init &&
+		git submodule add --label labelA file://"$pwd"/example2 submodule &&
+		git submodule add --name specialSnowflake file://"$pwd"/example2 submodule1 &&
+		git submodule add file://"$pwd"/example2 submodule2 &&
+		git submodule add file://"$pwd"/example2 submodule3 &&
+		git commit -a -m "create repository with 4 submodules, one is labeled"
+	) &&
+	git clone super super_clone &&
+	(
+		cd super_clone &&
+		git config submodule.actionOnLabel \*labelA &&
+		git config --add submodule.actionOnLabel :specialSnowflake &&
+		git config --add submodule.actionOnLabel ./submodule2 &&
+		git submodule update &&
+		git submodule status |cut -c1,42-52 | tr -d " " >../actual
+	) &&
+	test_cmp actual expected
+'
+
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
+test_expect_success 'clone with multiple --init-submodule options' '
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
+
 test_done
-- 
2.7.0.rc0.45.g6b4c145
