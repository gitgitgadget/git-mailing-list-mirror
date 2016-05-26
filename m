From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/2] submodule update: learn `--[no-]recommend-shallow` option
Date: Thu, 26 May 2016 14:59:43 -0700
Message-ID: <20160526215943.29526-3-sbeller@google.com>
References: <20160526215943.29526-1-sbeller@google.com>
Cc: gitster@pobox.com, jrnieder@gmail.com, Jens.Lehmann@web.de,
	remi.galan-alfonso@ensimag.grenoble-inp.fr,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 27 00:00:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b63KG-0007pT-P9
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 00:00:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755526AbcEZWAB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 18:00:01 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33434 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755518AbcEZV74 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 17:59:56 -0400
Received: by mail-pa0-f44.google.com with SMTP id xk12so33273160pac.0
        for <git@vger.kernel.org>; Thu, 26 May 2016 14:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g/je8B6gcnIwFpTdX3QzDj1OEBocNkQQrvQb/fLbv88=;
        b=ch32oQtztEccuo5E+A6sK2sT2Il2/A7sSCdgw97BYXjaYDBE95V4QpDB16eLDCnDCW
         CvaasbaZdKffmfdtEvhwSbbXbGnZSNnpX1z1JjrbOk+qI+rQoJKKFJgzZSd+mgyXlbf5
         8pilgNJD6hoBXj6xv1LwBPqJitV8E+lvSN5JAGFILnAaB+AtJWKSWm4ulLnJYGvJ1mqK
         6wsw4+fa7Dfg7UxULkyy2+nJheyZlxBwmdEFJX11oeFXNaB7iTF5TiRDfWcKgpwIvTdt
         b9SLdYBfCs/qMnTj7Y2TBADmVo++fYNJHrCX+ORNUeYkiD6rPhN6Wdm0kjQ4rz0JeaB3
         YvaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g/je8B6gcnIwFpTdX3QzDj1OEBocNkQQrvQb/fLbv88=;
        b=QNUkcUzEbDpPPSDnGz1yrvE8y3q9c17/gt4oio+MU7N9YsiAOg6IZa79glMDtMR8Rz
         tSuC519s44bgYETqjvYykxCq+xaiSTkZXcizBxarQGdClsveaXUt7S5PBWIDoMb8Q7c/
         n9QEO0wvaJuwhxsKnwHzdJbmSiLWPdJB/DLpHo3w2ZrLashYPQhSsVp3iBsRJF7fE0KQ
         JOXqHlpwWXIEynmgb8sBHXuFqa1t4UhESfPi41u5Z3H7+V8QDb8NLelA3PdvNH3qshdw
         1QeN6WdQpW5Lm9Iy9WnOh5bYe+WqZ7sg2tMwXeEusVIbZJyqTrTVgAaqRWRcF6Hw1zCV
         AGUA==
X-Gm-Message-State: ALyK8tJiz9GEO+o+kZWGqyYXW7/sbHxfHcpWfvqbYLVTMzdRm2IVES5GGf0/h3I8AVIaCiSy
X-Received: by 10.66.199.66 with SMTP id ji2mr17554160pac.34.1464299995079;
        Thu, 26 May 2016 14:59:55 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:f5f9:aea3:ef22:58b3])
        by smtp.gmail.com with ESMTPSA id h16sm8368822pfj.0.2016.05.26.14.59.54
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 26 May 2016 14:59:54 -0700 (PDT)
X-Mailer: git-send-email 2.9.0.rc0.2.g145fc64
In-Reply-To: <20160526215943.29526-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295697>

Sometimes the history of a submodule is not considered important by
the projects upstream. To make it easier for downstream users, allow
a boolean field 'submodule.<name>.shallow' in .gitmodules, which can
be used to recommend whether upstream considers the history important.

This field is honored in the initial clone by default, it can be
ignored by giving the `--no-recommend-shallow` option.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-submodule.txt | 11 +++++++--
 builtin/submodule--helper.c     |  7 +++++-
 git-submodule.sh                |  9 ++++++-
 t/t5614-clone-submodules.sh     | 52 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 75 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 9226c43..bf3bb37 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -15,8 +15,9 @@ SYNOPSIS
 'git submodule' [--quiet] init [--] [<path>...]
 'git submodule' [--quiet] deinit [-f|--force] (--all|[--] <path>...)
 'git submodule' [--quiet] update [--init] [--remote] [-N|--no-fetch]
-	      [-f|--force] [--rebase|--merge] [--reference <repository>]
-	      [--depth <depth>] [--recursive] [--jobs <n>] [--] [<path>...]
+	      [--[no-]recommend-shallow] [-f|--force] [--rebase|--merge]
+	      [--reference <repository>] [--depth <depth>] [--recursive]
+	      [--jobs <n>] [--] [<path>...]
 'git submodule' [--quiet] summary [--cached|--files] [(-n|--summary-limit) <n>]
 	      [commit] [--] [<path>...]
 'git submodule' [--quiet] foreach [--recursive] <command>
@@ -384,6 +385,12 @@ for linkgit:git-clone[1]'s `--reference` and `--shared` options carefully.
 	clone with a history truncated to the specified number of revisions.
 	See linkgit:git-clone[1]
 
+--[no-]recommend-shallow::
+	This option is only valid for the update command.
+	The initial clone of a submodule will use the recommended
+	`submodule.<name>.shallow` as provided by the .gitmodules file
+	by default. To ignore the suggestions use `--no-recommend-shallow`.
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
