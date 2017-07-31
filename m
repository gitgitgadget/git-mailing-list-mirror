Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E069C1F991
	for <e@80x24.org>; Mon, 31 Jul 2017 20:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751676AbdGaU4y (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 16:56:54 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36562 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751706AbdGaU4w (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 16:56:52 -0400
Received: by mail-pf0-f195.google.com with SMTP id t83so2705296pfj.3
        for <git@vger.kernel.org>; Mon, 31 Jul 2017 13:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1xIbZB4S1PnZ/2lMk5u3+dEu2nsLxKRQewHhVaRHD34=;
        b=A7u6NE7c/xnwHOrOMro9EpnAuf95zHv+1xGiay6pVnn/0QOF1r1jUxFrDE2N5Qk51K
         a/OZYfedwoK0Iu7P7W8zahCcYW28jSRmWCK+YljwT5icRJDBBfbiDQ5hmj5bJpoFKtn9
         8tUydR7gvg/m7pZiPxHMm1Vi4L16Sg702vMSpzkqo3ayO7qtLZe595T9Z5u24nmiYsPV
         0ulfLQqgQLn7E6kqQ/nmQgaGTiTrVG9d5CIIDMBNAVOE+nACe5Zw/Smkn0AnpAL30A2+
         ogYYH4eHqsWYuUrbOtL9R0E/Gt4/9F6ygTWfsiOggNl4dFlDd/Ss4On8wwcd9x9EJUGH
         j9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1xIbZB4S1PnZ/2lMk5u3+dEu2nsLxKRQewHhVaRHD34=;
        b=RCN3YhY+BhIVt+P4MoKLriOQod8qDcr2U8tSmSaCqKLiM+z5p4ZmW0zNUf0gXYtOTT
         8Ycxyt7UzjdfSUdFlkN9VXpFybHfoqqqKBCeDpb500V3VK39sp2utvcvaYU0Nx9QkYa2
         xSbpI06B28ErArjcW1b0IBtJ3Hm63nM1DDqKu6TAKp47LZBhsLOVWhTFojQMpa4+25BE
         /BdL7HZVETAyyg4Uyw9ZHVNfxj7CpSP/8VaJD0bI9UzZX0fQY4zW+G4Hx91SXPCPHmaS
         yuuu5A+W2SX7oSWWjanOcG2thfdrzSduzx5usmqjYwL/UQlXtlLi9g0XCpVccfcLHG5s
         Emww==
X-Gm-Message-State: AIVw11013XgSYQH+dfPCUDW2mPTZMXpvMHF6IHvW/5PWfUKm9YIajBbu
        WD6EY3tDst8HciMHZPHp+w==
X-Received: by 10.99.185.75 with SMTP id v11mr17574183pgo.189.1501534611318;
        Mon, 31 Jul 2017 13:56:51 -0700 (PDT)
Received: from localhost.localdomain ([2405:205:6182:3b53:5da6:3508:cb8e:5545])
        by smtp.gmail.com with ESMTPSA id 16sm52881007pfq.151.2017.07.31.13.56.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 31 Jul 2017 13:56:50 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH 03/13] submodule: port set_name_rev() from shell to C
Date:   Tue,  1 Aug 2017 02:26:11 +0530
Message-Id: <20170731205621.24305-4-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170731205621.24305-1-pc44800@gmail.com>
References: <20170731205621.24305-1-pc44800@gmail.com>
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
In this new version, the following changes have been made:
* The variable namerev from print_name_rev is now freed at the end of the 
  function.

 builtin/submodule--helper.c | 64 +++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            | 16 ++----------
 2 files changed, 66 insertions(+), 14 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index e41572f7a..2cb72d68e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -244,6 +244,69 @@ static char *get_submodule_displaypath(const char *path, const char *prefix)
 	}
 }
 
+static char *get_name_rev(const char *sub_path, const char* object_id)
+{
+	struct strbuf sb = STRBUF_INIT;
+	const char ***d;
+
+	static const char *describe_bare[] = {
+		NULL
+	};
+
+	static const char *describe_tags[] = {
+		"--tags", NULL
+	};
+
+	static const char *describe_contains[] = {
+		"--contains", NULL
+	};
+
+	static const char *describe_all_always[] = {
+		"--all", "--always", NULL
+	};
+
+	static const char **describe_argv[] = {
+		describe_bare, describe_tags, describe_contains,
+		describe_all_always, NULL
+	};
+
+	for (d = describe_argv; *d; d++) {
+		struct child_process cp = CHILD_PROCESS_INIT;
+		prepare_submodule_repo_env(&cp.env_array);
+		cp.dir = sub_path;
+		cp.git_cmd = 1;
+		cp.no_stderr = 1;
+
+		argv_array_push(&cp.args, "describe");
+		argv_array_pushv(&cp.args, *d);
+		argv_array_push(&cp.args, object_id);
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
+	free(namerev);
+	return 0;
+}
+
 struct module_list {
 	const struct cache_entry **entries;
 	int alloc, nr;
@@ -1242,6 +1305,7 @@ static struct cmd_struct commands[] = {
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

