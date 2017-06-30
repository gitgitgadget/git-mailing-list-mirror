Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76FB4201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 19:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752670AbdF3Tt2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 15:49:28 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35278 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752719AbdF3Try (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 15:47:54 -0400
Received: by mail-pf0-f193.google.com with SMTP id s66so18060109pfs.2
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 12:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IEl25AYhpESDF17rG72PTwFBOu0NX/lWkRMifME0lsk=;
        b=ilMxIBCPgrciB2LSRj8SVKbmNTL1dzgUP5ox9PsZD6T7EKcST0KJsS3ftDfkrFqYAK
         IFvg467Lh4Z96jtD5ezo2uuNI97/zolXRYeMuGDBtjsretN70vkAlRU78D3mdmPyL2Bl
         czOKmlTw0wIJMmMJT9+HleGAa3FrBz9rD09syO96EJUqMO7GXL3EMubga6PvEB+I8w29
         U4YUwZFLoB3c4I4HlgNiOEaXGGQd2+6eq083olNrzaFqwNJhRCov18m1UZFDNQEy7iK7
         Mp/yEzkWnE15dwl1GbaK3hsAf8FU9WfdSsKWjGk51UTT8fS5Rw3Ud7MjpwtJhme6fU0+
         1OCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IEl25AYhpESDF17rG72PTwFBOu0NX/lWkRMifME0lsk=;
        b=Rg8iyBZZ6GZfnjITlOtclUf/OLHYUg7n4JHEb4R2kmFSHDNyfML5Mx95Am65EJkvSh
         Cw1evqd1WGDZ7FcNHgXSFifI6RmyLDO1vLnJ9X8d1nHP7UkMlYhfafLe1sq3nM/sojUc
         uYi4m1k2qN+D8X/r1ynA4Hef7SxjqdZEolQRhaPtQMYorN459fxAX1YAEVBvjI3p1R8W
         VU4EXNiDMi8P6Vly2CCclFgI8SPTZbxHgtNNaNhCg7VhlntMnlZs3tscOZCZxZVauVCE
         EI2R48U2aehgB7Og9jv5yubLgDGUPEcQeJQBdbIvMRhC0+70C9yXMUFMS+e258PHkA2d
         xnGg==
X-Gm-Message-State: AKS2vOzJhp83DbfsvoW+auAE+IZ5X5z5hIjkc6luaD2WLKoezJ9z7YlQ
        roQc8pbFQM7s+OTg
X-Received: by 10.98.214.195 with SMTP id a64mr24168854pfl.40.1498852073420;
        Fri, 30 Jun 2017 12:47:53 -0700 (PDT)
Received: from prathampc-X550JX.domain.name ([116.73.72.60])
        by smtp.gmail.com with ESMTPSA id g10sm20972131pfc.38.2017.06.30.12.47.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 12:47:53 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com, gitster@pobox.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH 3/5 v3] submodule: port set_name_rev() from shell to C
Date:   Sat,  1 Jul 2017 01:17:25 +0530
Message-Id: <20170630194727.29787-3-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170630194727.29787-1-pc44800@gmail.com>
References: <CAME+mvUrr8EA-6jbCZdpB7dMZ5CN3RyY7yoRoUBoiZw=sH6Ysw@mail.gmail.com>
 <20170630194727.29787-1-pc44800@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Function set_name_rev() is ported from git-submodule to the
submodule--helper builtin. The function get_name_rev() generates the
value of the revision name as required, and the function
print_name_rev() handles the formating and printing of the obtained
revision name.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
 builtin/submodule--helper.c | 69 +++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            | 16 ++---------
 2 files changed, 71 insertions(+), 14 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c4286aac5..4103e40e4 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -244,6 +244,74 @@ static char *get_submodule_displaypath(const char *path, const char *prefix)
 	}
 }
 
+enum describe_step {
+	step_bare,
+	step_tags,
+	step_contains,
+	step_all_always,
+	step_end
+};
+
+static char *get_name_rev(const char *sub_path, const char* object_id)
+{
+	struct strbuf sb = STRBUF_INIT;
+	enum describe_step cur_step;
+
+	for (cur_step = step_bare; cur_step < step_end; cur_step++) {
+		struct child_process cp = CHILD_PROCESS_INIT;
+		prepare_submodule_repo_env(&cp.env_array);
+		cp.dir = sub_path;
+		cp.git_cmd = 1;
+		cp.no_stderr = 1;
+
+		switch (cur_step) {
+			case step_bare:
+				argv_array_pushl(&cp.args, "describe",
+						 object_id, NULL);
+				break;
+			case step_tags:	
+				argv_array_pushl(&cp.args, "describe",
+						 "--tags", object_id, NULL);
+				break;
+			case step_contains:
+				argv_array_pushl(&cp.args, "describe",
+						 "--contains", object_id,
+						 NULL);
+				break;
+			case step_all_always:
+				argv_array_pushl(&cp.args, "describe",
+						 "--all", "--always",
+						 object_id, NULL);
+				break;
+			default:
+				BUG("unknown describe step '%d'", cur_step);
+		}
+
+		if (!capture_command(&cp, &sb, 0) && sb.len) {
+			strbuf_strip_suffix(&sb, "\n");
+			return strbuf_detach(&sb, NULL);
+		}
+
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
+	namerev = get_name_rev(argv[1], argv[2]);
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
@@ -1242,6 +1310,7 @@ static struct cmd_struct commands[] = {
 	{"relative-path", resolve_relative_path, 0},
 	{"resolve-relative-url", resolve_relative_url, 0},
 	{"resolve-relative-url-test", resolve_relative_url_test, 0},
+	{"print-name-rev", print_name_rev, 0},
 	{"init", module_init, SUPPORT_SUPER_PREFIX},
 	{"remote-branch", resolve_remote_submodule_branch, 0},
 	{"push-check", push_check, 0},
diff --git a/git-submodule.sh b/git-submodule.sh
index e131760ee..e988167e0 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -759,18 +759,6 @@ cmd_update()
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
@@ -1042,14 +1030,14 @@ cmd_status()
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

