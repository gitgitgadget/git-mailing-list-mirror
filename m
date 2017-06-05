Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79EEF1F7D2
	for <e@80x24.org>; Mon,  5 Jun 2017 20:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751189AbdFEU0U (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 16:26:20 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35932 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbdFEU0T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 16:26:19 -0400
Received: by mail-pg0-f68.google.com with SMTP id v18so7460279pgb.3
        for <git@vger.kernel.org>; Mon, 05 Jun 2017 13:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y4uG9dh7v5X8RDkvg9MoqHhkOMYqpOzePAGf0TVQp34=;
        b=Z2YS+Cpnyyq045Ggt0zCpaCJCeUBqqHzg4XIzMODPmMy98IhZXI1U7F0wXvQJJ3vX+
         +g/O6AapgL/FQPhDq7fka/ExziI77lPvQOhm+V3ue4Sp4xWZm9J1KPEGz4cfdr9uW5OG
         j4CLwHgwuUHF0/1hc1o8hP7CNNtdjJIekTin81tW5Xt0AA4AfbWtndZgU5o62MWIGUIa
         atMHuODbdCOMAi+0o/f1YG5kfzmMDEzptz9uveiy1KutiRLj9bHnSnT1dQ6uOt2U1+wu
         G4VaoNaWYgGKvCM6sMNn3AT0la1EgwRyupWRNkD0c1s9nSi7juZXJEOrMRu16WD7Iln3
         oYNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y4uG9dh7v5X8RDkvg9MoqHhkOMYqpOzePAGf0TVQp34=;
        b=jCfZua74QkGDbhMXIx/30+jt8qaC6Ye5nxJb8IWmhvuDY+9CeWbkdOiySf1JTQHkGo
         4QgBJe227vsMs9zvGT6FUUyz03bvnaueKEtOqjahji6fjxDnJOG2rYeL0hN1AncJT2rA
         63RSZS5QzFLBt2kBGX9tK2QfqFh7cSc+cGhYXzfj0F+73QGiOdhjdWNScrxML7aOM4JG
         jPKDJorbDyt48Jv3izBY7jligTCRXfjcU6YBJKgTO4s54fF2Orikm+c3mQBuNEN5MhrC
         qdk+fJxinbLdEiD9CoZuNLeOx6O+HJgMfqJn875UmVsF/jKB08HULkJiItkw7VGxX2DA
         cYdQ==
X-Gm-Message-State: AODbwcChedeFZMtg4jtgMdPk3Mchju61J28gDJtT/14NurQPbIsMbZy1
        awk6+qQrXXawAA==
X-Received: by 10.84.233.141 with SMTP id l13mr17399528plk.298.1496694378917;
        Mon, 05 Jun 2017 13:26:18 -0700 (PDT)
Received: from prathampc-X550JX.domain.name ([116.73.72.60])
        by smtp.gmail.com with ESMTPSA id s10sm29840633pfi.16.2017.06.05.13.26.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Jun 2017 13:26:18 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH v2 1/2] submodule: port set_name_rev from shell to C
Date:   Tue,  6 Jun 2017 01:55:28 +0530
Message-Id: <20170605202529.22959-1-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <CAGZ79kYeJoVGRFyeGsXevo2JmDMoxf=tJubWcy5Qt==3QK=Hjg@mail.gmail.com>
References: <CAGZ79kYeJoVGRFyeGsXevo2JmDMoxf=tJubWcy5Qt==3QK=Hjg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since later on we want to port submodule subcommand status, and since
set_name_rev is part of cmd_status, hence this function is ported. It
has been ported to function print_name_rev in C, which calls get_name_rev
to get the revname, and after formatting it, print_name_rev prints it.
And hence in this way, the command `git submodule--helper print-name-rev
"sm_path" "sha1"` sets value of revname in git-submodule.sh

The function get_name_rev returns the stdout of the git describe
commands. Since there are four different git-describe commands used for
generating the name rev, four child_process are introduced, each successive
child process running only when previous has no stdout. The order of these
four git-describe commands is maintained the same as it was in the function
set_name_rev() in shell script.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
 builtin/submodule--helper.c | 67 +++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            | 16 ++---------
 2 files changed, 69 insertions(+), 14 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 566a5b6a6..3022118d1 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -219,6 +219,72 @@ static int resolve_relative_url_test(int argc, const char **argv, const char *pr
 	return 0;
 }
 
+enum describe_step {
+	step_bare = 0,
+	step_tags,
+	step_contains,
+	step_all_always,
+	step_end
+};
+
+static char *get_name_rev(int argc, const char **argv, const char *prefix)
+{
+	struct child_process cp;
+	struct strbuf sb = STRBUF_INIT;
+	enum describe_step cur_step;
+
+	for (cur_step = step_bare; cur_step < step_end; cur_step++) {
+		child_process_init(&cp);
+		prepare_submodule_repo_env(&cp.env_array);
+		cp.dir = argv[1];
+		cp.no_stderr = 1;
+
+		switch (cur_step) {
+			case step_bare:
+				argv_array_pushl(&cp.args, "git", "describe",
+						 argv[2], NULL);
+				break;
+			case step_tags:
+				argv_array_pushl(&cp.args, "git", "describe",
+						 "--tags", argv[2], NULL);
+				break;
+			case step_contains:
+				argv_array_pushl(&cp.args, "git", "describe",
+						 "--contains", argv[2], NULL);
+				break;
+			case step_all_always:
+				argv_array_pushl(&cp.args, "git", "describe",
+						 "--all", "--always", argv[2],
+						 NULL);
+				break;
+			default:
+				BUG("unknown describe step '%d'", cur_step);
+		}
+
+		if (!capture_command(&cp, &sb, 0) && sb.len) {
+			strbuf_strip_suffix(&sb, "\n");
+			return strbuf_detach(&sb, NULL);
+		}
+	}
+
+	strbuf_release(&sb);
+	return NULL;
+}
+
+static int print_name_rev(int argc, const char **argv, const char *prefix)
+{
+	char *namerev;
+	if (argc != 3)
+		die("print-name-rev only accepts two arguments: <path> <sha1>");
+
+	namerev = get_name_rev(argc, argv, prefix);
+	if (namerev && namerev[0])
+		printf(" (%s)", namerev);
+	printf("\n");
+
+	return 0;
+}
+
 struct module_list {
 	const struct cache_entry **entries;
 	int alloc, nr;
@@ -1212,6 +1278,7 @@ static struct cmd_struct commands[] = {
 	{"relative-path", resolve_relative_path, 0},
 	{"resolve-relative-url", resolve_relative_url, 0},
 	{"resolve-relative-url-test", resolve_relative_url_test, 0},
+	{"print-name-rev", print_name_rev, 0},
 	{"init", module_init, SUPPORT_SUPER_PREFIX},
 	{"remote-branch", resolve_remote_submodule_branch, 0},
 	{"push-check", push_check, 0},
diff --git a/git-submodule.sh b/git-submodule.sh
index c0d0e9a4c..091051891 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -758,18 +758,6 @@ cmd_update()
 	}
 }
 
-set_name_rev () {
-	revname=$( (
-		sanitize_submodule_env
-		cd "$1" && {
-			git describe "$2" 2>/dev/null ||
-			git describe --tags "$2" 2>/dev/null ||
-			git describe --contains "$2" 2>/dev/null ||
-			git describe --all --always "$2"
-		}
-	) )
-	test -z "$revname" || revname=" ($revname)"
-}
 #
 # Show commit summary for submodules in index or working tree
 #
@@ -1041,14 +1029,14 @@ cmd_status()
 		fi
 		if git diff-files --ignore-submodules=dirty --quiet -- "$sm_path"
 		then
-			set_name_rev "$sm_path" "$sha1"
+			revname=$(git submodule--helper print-name-rev "$sm_path" "$sha1")
 			say " $sha1 $displaypath$revname"
 		else
 			if test -z "$cached"
 			then
 				sha1=$(sanitize_submodule_env; cd "$sm_path" && git rev-parse --verify HEAD)
 			fi
-			set_name_rev "$sm_path" "$sha1"
+			revname=$(git submodule--helper print-name-rev "$sm_path" "$sha1")
 			say "+$sha1 $displaypath$revname"
 		fi
 
-- 
2.13.0

