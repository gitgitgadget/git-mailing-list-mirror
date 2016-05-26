From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/2] submodule update: learn `--[no-]recommend-shallow` option
Date: Wed, 25 May 2016 17:06:33 -0700
Message-ID: <20160526000633.27223-3-sbeller@google.com>
References: <20160526000633.27223-1-sbeller@google.com>
Cc: gitster@pobox.com, jrnieder@gmail.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 26 02:06:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5ip9-0003EO-Qr
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 02:06:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752108AbcEZAGr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 20:06:47 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:35970 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752041AbcEZAGo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 20:06:44 -0400
Received: by mail-pf0-f175.google.com with SMTP id f144so11332385pfa.3
        for <git@vger.kernel.org>; Wed, 25 May 2016 17:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1aXshTwiM2/EXwHE314oiWbpOcls5IOlD65g2O2nUi8=;
        b=YIlpDvHHxkjTwO/af/C3+tuzB1bKOQ8Kr9be8/mGkLgfM/tiMUV+XLNjQQ/1QQFy//
         yYX033KvkPEhR/zrXitrLgr7Q6ue8kj4TjowM0/xPdXuSlvPyUGFJ5tGCdV/x5g9njOP
         RGWY30mjEBL+WMZ1hXfFv8L409lMC7/uK01YPbp271hrl5RsAQTK75JkUd44DQUJ6Y3k
         9Xrg6ZPG5uIFNJJlm8X6v+VKoN0YwKYTywR7YXnCmNw8+Mf696dNF0sbbETESglhuk/A
         SP5NkH1K/LY12IrE2lzdu73DolYIQqW/N/dh4kZs6lRr3PVP+hglvHUVYSxPtk7Dw+BK
         VQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1aXshTwiM2/EXwHE314oiWbpOcls5IOlD65g2O2nUi8=;
        b=JG+o5YPQNpkX51PSY0eZH7ntK2t4B/IcNYgvj8G99lMeDNac9TnEmgxCeYKfh9PmQR
         csKqy+Wzk0srw+uqZeZExj4FhPkhi0YhM2cpoBfQUQuMhXarrRirDq8PbV2FWAyzYzPw
         FRpBagSHBc3+rIcN+Czm1Z+L4nAArYQ04HYHg4A6dKLGNlFFTo3iuFN76dZUgFEZptKN
         is4Ear+wmsPyZ2+/VdvOpW51Zj3C3LMo/vlDBbkPkr04NH35RUG3EpN/PpVelOg5lQ6d
         3YnoLMJDP/9JqgW1MB7nLCE2gjP0b+FMS6W0XJcvPeHabZJ8wseEG7PNw0sEYEdjTmn0
         8S1A==
X-Gm-Message-State: ALyK8tL0Dz1wXwLPIOXW67U+zw1BLjcHwajwe8VXzCh3GkpBpPHrElYJ31dOee744RbJisQM
X-Received: by 10.98.149.20 with SMTP id p20mr9768213pfd.95.1464221203160;
        Wed, 25 May 2016 17:06:43 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:9ded:7fc0:154a:2e3b])
        by smtp.gmail.com with ESMTPSA id z12sm1049325pfj.1.2016.05.25.17.06.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 25 May 2016 17:06:42 -0700 (PDT)
X-Mailer: git-send-email 2.9.0.rc0.2.g145fc64
In-Reply-To: <20160526000633.27223-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295621>

Sometimes the history of a submodule is not considered important by
the projects upstream. To make it easier for downstream users, allow
a boolean field 'submodule.<name>.shallow' in .gitmodules, which can
be used to recommend whether upstream considers the history important.

This field is honored in the initial clone by default, it can be
ignored by giving the `--no-recommend-shallow` option.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-submodule.txt | 10 ++++++--
 builtin/submodule--helper.c     |  7 +++++-
 git-submodule.sh                |  9 ++++++-
 t/t5614-clone-submodules.sh     | 52 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 74 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 9226c43..c928c0d 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -15,8 +15,9 @@ SYNOPSIS
 'git submodule' [--quiet] init [--] [<path>...]
 'git submodule' [--quiet] deinit [-f|--force] (--all|[--] <path>...)
 'git submodule' [--quiet] update [--init] [--remote] [-N|--no-fetch]
-	      [-f|--force] [--rebase|--merge] [--reference <repository>]
-	      [--depth <depth>] [--recursive] [--jobs <n>] [--] [<path>...]
+	      [--[no-]recommended-depth] [-f|--force] [--rebase|--merge]
+	      [--reference <repository>] [--depth <depth>] [--recursive]
+	      [--jobs <n>] [--] [<path>...]
 'git submodule' [--quiet] summary [--cached|--files] [(-n|--summary-limit) <n>]
 	      [commit] [--] [<path>...]
 'git submodule' [--quiet] foreach [--recursive] <command>
@@ -384,6 +385,11 @@ for linkgit:git-clone[1]'s `--reference` and `--shared` options carefully.
 	clone with a history truncated to the specified number of revisions.
 	See linkgit:git-clone[1]
 
+--[no-]recommended-depth::
+	This option is only valid for the update command.
+	The initial clone of a submodule will use the recommended
+	`submodule.<name>.depth` as provided by the .gitmodules file.
+
 -j <n>::
 --jobs <n>::
 	This option is only valid for the update command.
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 8da263f..ca33408 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -581,6 +581,7 @@ struct submodule_update_clone {
 
 	/* configuration parameters which are passed on to the children */
 	int quiet;
+	int recommend_shallow;
 	const char *reference;
 	const char *depth;
 	const char *recursive_prefix;
@@ -593,7 +594,7 @@ struct submodule_update_clone {
 	unsigned quickstop : 1;
 };
 #define SUBMODULE_UPDATE_CLONE_INIT {0, MODULE_LIST_INIT, 0, \
-	SUBMODULE_UPDATE_STRATEGY_INIT, 0, NULL, NULL, NULL, NULL, \
+	SUBMODULE_UPDATE_STRATEGY_INIT, 0, -1, NULL, NULL, NULL, NULL, \
 	STRING_LIST_INIT_DUP, 0}
 
 
@@ -698,6 +699,8 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 		argv_array_push(&child->args, "--quiet");
 	if (suc->prefix)
 		argv_array_pushl(&child->args, "--prefix", suc->prefix, NULL);
+	if (suc->recommend_shallow && sub->recommend_shallow == 1)
+		argv_array_push(&child->args, "--depth=1");
 	argv_array_pushl(&child->args, "--path", sub->path, NULL);
 	argv_array_pushl(&child->args, "--name", sub->name, NULL);
 	argv_array_pushl(&child->args, "--url", url, NULL);
@@ -780,6 +783,8 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 			      "specified number of revisions")),
 		OPT_INTEGER('j', "jobs", &max_jobs,
 			    N_("parallel jobs")),
+		OPT_BOOL(0, "recommend-shallow", &suc.recommend_shallow,
+			    N_("whether the initial clone should follow the shallow recommendation")),
 		OPT__QUIET(&suc.quiet, N_("don't print cloning progress")),
 		OPT_END()
 	};
diff --git a/git-submodule.sh b/git-submodule.sh
index 5a4dec0..42e0e9f 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -9,7 +9,7 @@ USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <re
    or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] init [--] [<path>...]
    or: $dashless [--quiet] deinit [-f|--force] (--all| [--] <path>...)
-   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--reference <repository>] [--recursive] [--] [<path>...]
+   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--[no-]recommend-shallow] [--reference <repository>] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
    or: $dashless [--quiet] foreach [--recursive] <command>
    or: $dashless [--quiet] sync [--recursive] [--] [<path>...]"
@@ -559,6 +559,12 @@ cmd_update()
 		--checkout)
 			update="checkout"
 			;;
+		--recommend-shallow)
+			recommend_shallow="--recommend-shallow"
+			;;
+		--no-recommend-shallow)
+			recommend_shallow="--no-recommend-shallow"
+			;;
 		--depth)
 			case "$2" in '') usage ;; esac
 			depth="--depth=$2"
@@ -601,6 +607,7 @@ cmd_update()
 		${update:+--update "$update"} \
 		${reference:+--reference "$reference"} \
 		${depth:+--depth "$depth"} \
+		${recommend_shallow:+"$recommend_shallow"} \
 		${jobs:+$jobs} \
 		"$@" || echo "#unmatched"
 	} | {
diff --git a/t/t5614-clone-submodules.sh b/t/t5614-clone-submodules.sh
index 62044c5..32d83e2 100755
--- a/t/t5614-clone-submodules.sh
+++ b/t/t5614-clone-submodules.sh
@@ -82,4 +82,56 @@ test_expect_success 'non shallow clone with shallow submodule' '
 	)
 '
 
+test_expect_success 'clone follows shallow recommendation' '
+	test_when_finished "rm -rf super_clone" &&
+	git config -f .gitmodules submodule.sub.shallow true &&
+	git add .gitmodules &&
+	git commit -m "recommed shallow for sub" &&
+	git clone --recurse-submodules --no-local "file://$pwd/." super_clone &&
+	(
+		cd super_clone &&
+		git log --oneline >lines &&
+		test_line_count = 4 lines
+	) &&
+	(
+		cd super_clone/sub &&
+		git log --oneline >lines &&
+		test_line_count = 1 lines
+	)
+'
+
+test_expect_success 'get unshallow recommended shallow submodule' '
+	test_when_finished "rm -rf super_clone" &&
+	git clone --no-local "file://$pwd/." super_clone &&
+	(
+		cd super_clone &&
+		git submodule update --init --no-recommend-shallow &&
+		git log --oneline >lines &&
+		test_line_count = 4 lines
+	) &&
+	(
+		cd super_clone/sub &&
+		git log --oneline >lines &&
+		test_line_count = 3 lines
+	)
+'
+
+test_expect_success 'clone follows non shallow recommendation' '
+	test_when_finished "rm -rf super_clone" &&
+	git config -f .gitmodules submodule.sub.shallow false &&
+	git add .gitmodules &&
+	git commit -m "recommed non shallow for sub" &&
+	git clone --recurse-submodules --no-local "file://$pwd/." super_clone &&
+	(
+		cd super_clone &&
+		git log --oneline >lines &&
+		test_line_count = 5 lines
+	) &&
+	(
+		cd super_clone/sub &&
+		git log --oneline >lines &&
+		test_line_count = 3 lines
+	)
+'
+
 test_done
-- 
2.9.0.rc0.2.g145fc64
