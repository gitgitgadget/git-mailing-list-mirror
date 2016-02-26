From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: [PATCH] Add --no-autostash flag to git pull --rebase
Date: Fri, 26 Feb 2016 16:53:45 +0530
Message-ID: <1456485825-21309-2-git-send-email-mehul.jain2029@gmail.com>
References: <1456485825-21309-1-git-send-email-mehul.jain2029@gmail.com>
Cc: me@ikke.info, pyokagan@gmail.com,
	Mehul Jain <mehul.jain2029@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 26 12:25:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZGWa-0005PO-7o
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 12:25:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752121AbcBZLZ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 06:25:27 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34837 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310AbcBZLZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 06:25:26 -0500
Received: by mail-pf0-f196.google.com with SMTP id w128so4544106pfb.2
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 03:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uzgkxbuvyq6pWr35XXr6qY/JhYufDdC1ocnQjOpYoOg=;
        b=eO81aJ0X1npW/PPVcv5VKh6PSKSyUitgSSQ+/oC9xGjzIzk3mh2TvJgMhyUTyuIs+y
         PqR3t53o46ngku0bqxxe3rVGP8McCda7xbDERVwvsJ2jwfCb61JKra/64NP1z5kMyIlp
         sadWJSFhw9sakhLKeqAFlTTvo8yJFbpnx+Re7LRVrbhY/9pHsU8V8BdzHcjyKc3iQ5TD
         n82oWwwQ5z/3X2kTcft90jyJWcdcVTu72nt24lYskdsin5tI5/krEN/oXlaxZ9yABX1f
         QMCpO4LjIQ/IiN72EfLFvjhisKkPduzsbubkV/MWJIDJoDD6XAk8MVXvtLpAd8ir362E
         v8ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uzgkxbuvyq6pWr35XXr6qY/JhYufDdC1ocnQjOpYoOg=;
        b=J8BmlghVY1PuubTwwBMEtFUuKiVD7DaziEgIR3M9tYa48VehgjqF0GzD5ULZjgJUF2
         i3WUVIXu0/ko+1H6humr/cPUU7NAr31yfwNlEMIfsWAZPO21EaPiyFseC0O8wEOnEW1t
         GZOctmhwhZEBfkyIGtHpD6BLagkpdf9I8g9XJtlkIosYC6n2U2/OLyafB8FpO2e7BuQe
         2H1lsMwc8xlVVa6jQUJh4o1Uc8V3EQJSWC4ar5oBPNAtlb8hT2m5Dwlmg+tuPRMVM//1
         Sj3wpY6NH0B41A1onIXBTSrpi9YrtBlcxnN3pYmdq0JbfbSpbBKpTmy8iT/g0x/3VK3p
         UCBQ==
X-Gm-Message-State: AD7BkJImUWpW4XiTgHxnBRmPqUhsFRdIgics8znI02CtsnsUEK4lmOCSs8yuxNYobx+71w==
X-Received: by 10.98.34.5 with SMTP id i5mr1274617pfi.160.1456485925443;
        Fri, 26 Feb 2016 03:25:25 -0800 (PST)
Received: from localhost.localdomain ([1.39.137.118])
        by smtp.gmail.com with ESMTPSA id 3sm18733071pfn.59.2016.02.26.03.25.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Feb 2016 03:25:24 -0800 (PST)
X-Mailer: git-send-email 2.7.1.340.g69eb491.dirty
In-Reply-To: <1456485825-21309-1-git-send-email-mehul.jain2029@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287569>

git pull --rebase now understand --no-autostash flag. If directory is found
to be dirty then command will die. This flag override "rebase.autostash" 
configuration(if set). If this flag is not passed in command line then
default behaviour is choosen, given by "rebase.autostash"(if "rebase.autostash"
is not set then git pull --rebase will die if directory is dirty).

Signed-off-by: Mehul Jain <mehul.jain2029@gmail.com>
---
 builtin/pull.c          | 12 ++++++++----
 t/t5520-pull.sh         |  8 ++++++++
 t/t5521-pull-options.sh | 24 ++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 10eff03..9d1a3d0 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -85,6 +85,7 @@ static char *opt_squash;
 static char *opt_commit;
 static char *opt_edit;
 static char *opt_ff;
+static int opt_autostash = -1;
 static char *opt_verify_signatures;
 static struct argv_array opt_strategies = ARGV_ARRAY_INIT;
 static struct argv_array opt_strategy_opts = ARGV_ARRAY_INIT;
@@ -146,6 +147,8 @@ static struct option pull_options[] = {
 	OPT_PASSTHRU(0, "ff-only", &opt_ff, NULL,
 		N_("abort if fast-forward is not possible"),
 		PARSE_OPT_NOARG | PARSE_OPT_NONEG),
+	OPT_COLOR_FLAG(0,"autostash",&opt_autostash,
+		N_("abort if tree is dirty")),
 	OPT_PASSTHRU(0, "verify-signatures", &opt_verify_signatures, NULL,
 		N_("verify that the named commit has a valid GPG signature"),
 		PARSE_OPT_NOARG),
@@ -835,13 +838,14 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		hashclr(orig_head);
 
 	if (opt_rebase) {
-		int autostash = 0;
-
 		if (is_null_sha1(orig_head) && !is_cache_unborn())
 			die(_("Updating an unborn branch with changes added to the index."));
 
-		git_config_get_bool("rebase.autostash", &autostash);
-		if (!autostash)
+		if(opt_autostash < 0)
+			if(git_config_get_bool("rebase.autostash",&opt_autostash))
+				opt_autostash = 0;
+
+		if (!opt_autostash)
 			die_on_unclean_work_tree(prefix);
 
 		if (get_rebase_fork_point(rebase_fork_point, repo, *refspecs))
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index c952d5e..512d3bf 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -245,6 +245,14 @@ test_expect_success '--rebase fails with multiple branches' '
 	test modified = "$(git show HEAD:file)"
 '
 
+test_expect_success '--rebase --no-autostash fails with dirty working directory' '
+	test_config rebase.autostash true &&
+	git reset --hard before-rebase &&
+	echo dirty >new_file &&
+	git add new_file &&
+	test_must_fail git pull --rebase --no-autostash . copy
+'
+
 test_expect_success 'pull --rebase succeeds with dirty working directory and rebase.autostash set' '
 	test_config rebase.autostash true &&
 	git reset --hard before-rebase &&
diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index 18372ca..22ff5d7 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -62,6 +62,30 @@ test_expect_success 'git pull -v --rebase' '
 	test_must_be_empty out)
 '
 
+test_expect_success 'git pull --rebase --no-autostash' '
+	mkdir clonedrbnas &&
+	(cd clonedrbnas  && git init &&
+	git pull --rebase --no-autostash "../parent" >out 2>err &&
+	test -s err &&
+	test_must_be_empty out)
+'
+
+test_expect_success 'git pull -q --rebase --no-autostash' '
+	mkdir clonedqrbnas &&
+	(cd clonedqrbnas  && git init &&
+	git pull -q --rebase --no-autostash "../parent" >out 2>err &&
+	test_must_be_empty err &&
+	test_must_be_empty out)
+'
+
+test_expect_success 'git pull -v --rebase --no-autostash' '
+	mkdir clonedvrbnas &&
+	(cd clonedvrbnas && git init &&
+	git pull -v --rebase --no-autostash "../parent" >out 2>err &&
+	test -s err &&
+	test_must_be_empty out)
+'
+
 test_expect_success 'git pull -v -q' '
 	mkdir clonedvq &&
 	(cd clonedvq && git init &&
-- 
2.7.1.340.g69eb491.dirty
