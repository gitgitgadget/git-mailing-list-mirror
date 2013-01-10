From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCHv3] commit: make default of "cleanup" option configurable
Date: Thu, 10 Jan 2013 18:45:59 +0100
Message-ID: <1357839959-18193-1-git-send-email-ralf.thielow@gmail.com>
References: <1357760209-3407-1-git-send-email-ralf.thielow@gmail.com>
Cc: git@vger.kernel.org, Ralf Thielow <ralf.thielow@gmail.com>
To: gitster@pobox.com, jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Thu Jan 10 18:46:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtMD2-0002gS-MQ
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jan 2013 18:46:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755238Ab3AJRqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2013 12:46:11 -0500
Received: from mail-bk0-f41.google.com ([209.85.214.41]:35437 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690Ab3AJRqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2013 12:46:09 -0500
Received: by mail-bk0-f41.google.com with SMTP id jg9so479062bkc.28
        for <git@vger.kernel.org>; Thu, 10 Jan 2013 09:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=W6LuSq/51DdNBNzHddde83zttpsrG+BykIp46YeobjU=;
        b=TMcAgotuTq8kGiGVXpG1atZYKUxqw08zTFccz1FEw20uetXfWXJ4cXrUxcZlzkjD4J
         ADG+Zwvpv4yBWlawR825CVPYjgd8CMj83X0agCVb6+wI4yLgOYEGPtFv33A42TA70Dtn
         wo8at5wt6y6UHBaRvzqnEehYvROLeTBzYLeN08x40glDEFsGEvjJeKuS0nyG1fhRiXmY
         K9f+whJi8GDlCQu9ldKngJHI5QFz4AHPeKR55X9VAulUjsfmlUDefMp6O4es2QQqX5RD
         xrSU7vNV/9c5ktDdk02Wwv9KbQ6xlMTsZF9vxmgbyLH6tl1X+w8GBR0nn9jaKunKH+Uj
         Gblw==
X-Received: by 10.204.7.92 with SMTP id c28mr34803582bkc.86.1357839967951;
        Thu, 10 Jan 2013 09:46:07 -0800 (PST)
Received: from localhost.localdomain (dslb-094-222-138-000.pools.arcor-ip.net. [94.222.138.0])
        by mx.google.com with ESMTPS id z5sm2150665bkv.11.2013.01.10.09.46.06
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 10 Jan 2013 09:46:07 -0800 (PST)
X-Mailer: git-send-email 1.8.1.227.g44fe835
In-Reply-To: <1357760209-3407-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213144>

The default of the "cleanup" option in "git commit"
is not configurable. Users who don't want to use the
default have to pass this option on every commit since
there's no way to configure it. This commit introduces
a new config option "commit.cleanup" which can be used
to change the default of the "cleanup" option in
"git commit".

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
changes in v3:
- remove extra blank line in builtin/commit.c
- add newline at end of t/t7500/add-content-and-comment
- improve documentation of commit.cleanup configuration variable
as Junio suggested (makes a lot of sense)

Thanks

 Documentation/config.txt        |  9 +++++
 Documentation/git-commit.txt    |  4 +-
 builtin/commit.c                |  4 +-
 t/t7500/add-content-and-comment |  5 +++
 t/t7502-commit.sh               | 84 +++++++++++++++++++++++++++++++++++++----
 5 files changed, 97 insertions(+), 9 deletions(-)
 create mode 100755 t/t7500/add-content-and-comment

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 53c4ca1..c92a308 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -917,6 +917,15 @@ column.tag::
 	Specify whether to output tag listing in `git tag` in columns.
 	See `column.ui` for details.
 
+commit.cleanup::
+	This setting overrides the default of the `--cleanup` option in
+	`git commit`. See linkgit:git-commit[1] for details. Changing the
+	default can be useful when you always want to keep lines that begin
+	with comment character `#` in your log message, in which case you
+	would do `git config commit.cleanup whitespace` (note that you will
+	have to remove the help lines that begin with `#` in the commit log
+	template yourself, if you do this).
+
 commit.status::
 	A boolean to enable/disable inclusion of status information in the
 	commit message template when using an editor to prepare the commit
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 7bdb039..41b27da 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -179,7 +179,9 @@ OPTIONS
 	only if the message is to be edited. Otherwise only whitespace
 	removed. The 'verbatim' mode does not change message at all,
 	'whitespace' removes just leading/trailing whitespace lines
-	and 'strip' removes both whitespace and commentary.
+	and 'strip' removes both whitespace and commentary. The default
+	can be changed by the 'commit.cleanup' configuration variable
+	(see linkgit:git-config[1]).
 
 -e::
 --edit::
diff --git a/builtin/commit.c b/builtin/commit.c
index d6dd3df..7c2a3d4 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -103,7 +103,7 @@ static enum {
 	CLEANUP_NONE,
 	CLEANUP_ALL
 } cleanup_mode;
-static char *cleanup_arg;
+static const char *cleanup_arg;
 
 static enum commit_whence whence;
 static int use_editor = 1, include_status = 1;
@@ -1320,6 +1320,8 @@ static int git_commit_config(const char *k, const char *v, void *cb)
 		include_status = git_config_bool(k, v);
 		return 0;
 	}
+	if (!strcmp(k, "commit.cleanup"))
+		return git_config_string(&cleanup_arg, k, v);
 
 	status = git_gpg_config(k, v, NULL);
 	if (status)
diff --git a/t/t7500/add-content-and-comment b/t/t7500/add-content-and-comment
new file mode 100755
index 0000000..c4dccff
--- /dev/null
+++ b/t/t7500/add-content-and-comment
@@ -0,0 +1,5 @@
+#!/bin/sh
+echo "commit message" >> "$1"
+echo "# comment" >> "$1"
+exit 0
+
diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index 1a5cb69..b1c7648 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -4,6 +4,15 @@ test_description='git commit porcelain-ish'
 
 . ./test-lib.sh
 
+commit_msg_is () {
+	expect=commit_msg_is.expect
+	actual=commit_msg_is.actual
+
+	printf "%s" "$(git log --pretty=format:%s%b -1)" >$actual &&
+	printf "%s" "$1" >$expect &&
+	test_i18ncmp $expect $actual
+}
+
 # Arguments: [<prefix] [<commit message>] [<commit options>]
 check_summary_oneline() {
 	test_tick &&
@@ -168,7 +177,7 @@ test_expect_success 'verbose respects diff config' '
 	git config --unset color.diff
 '
 
-test_expect_success 'cleanup commit messages (verbatim,-t)' '
+test_expect_success 'cleanup commit messages (verbatim option,-t)' '
 
 	echo >>negative &&
 	{ echo;echo "# text";echo; } >expect &&
@@ -178,7 +187,7 @@ test_expect_success 'cleanup commit messages (verbatim,-t)' '
 
 '
 
-test_expect_success 'cleanup commit messages (verbatim,-F)' '
+test_expect_success 'cleanup commit messages (verbatim option,-F)' '
 
 	echo >>negative &&
 	git commit --cleanup=verbatim -F expect -a &&
@@ -187,7 +196,7 @@ test_expect_success 'cleanup commit messages (verbatim,-F)' '
 
 '
 
-test_expect_success 'cleanup commit messages (verbatim,-m)' '
+test_expect_success 'cleanup commit messages (verbatim option,-m)' '
 
 	echo >>negative &&
 	git commit --cleanup=verbatim -m "$(cat expect)" -a &&
@@ -196,7 +205,7 @@ test_expect_success 'cleanup commit messages (verbatim,-m)' '
 
 '
 
-test_expect_success 'cleanup commit messages (whitespace,-F)' '
+test_expect_success 'cleanup commit messages (whitespace option,-F)' '
 
 	echo >>negative &&
 	{ echo;echo "# text";echo; } >text &&
@@ -207,7 +216,7 @@ test_expect_success 'cleanup commit messages (whitespace,-F)' '
 
 '
 
-test_expect_success 'cleanup commit messages (strip,-F)' '
+test_expect_success 'cleanup commit messages (strip option,-F)' '
 
 	echo >>negative &&
 	{ echo;echo "# text";echo sample;echo; } >text &&
@@ -218,7 +227,7 @@ test_expect_success 'cleanup commit messages (strip,-F)' '
 
 '
 
-test_expect_success 'cleanup commit messages (strip,-F,-e)' '
+test_expect_success 'cleanup commit messages (strip option,-F,-e)' '
 
 	echo >>negative &&
 	{ echo;echo sample;echo; } >text &&
@@ -231,10 +240,71 @@ echo "sample
 # Please enter the commit message for your changes. Lines starting
 # with '#' will be ignored, and an empty message aborts the commit." >expect
 
-test_expect_success 'cleanup commit messages (strip,-F,-e): output' '
+test_expect_success 'cleanup commit messages (strip option,-F,-e): output' '
 	test_i18ncmp expect actual
 '
 
+test_expect_success 'cleanup commit message (fail on invalid cleanup mode option)' '
+	test_must_fail git commit --cleanup=non-existent
+'
+
+test_expect_success 'cleanup commit message (fail on invalid cleanup mode configuration)' '
+	test_must_fail git -c commit.cleanup=non-existent commit
+'
+
+test_expect_success 'cleanup commit message (no config and no option uses default)' '
+	echo content >>file &&
+	git add file &&
+	test_set_editor "$TEST_DIRECTORY"/t7500/add-content-and-comment &&
+	git commit --no-status &&
+	commit_msg_is "commit message"
+'
+
+test_expect_success 'cleanup commit message (option overrides default)' '
+	echo content >>file &&
+	git add file &&
+	test_set_editor "$TEST_DIRECTORY"/t7500/add-content-and-comment &&
+	git commit --cleanup=whitespace --no-status &&
+	commit_msg_is "commit message # comment"
+'
+
+test_expect_success 'cleanup commit message (config overrides default)' '
+	echo content >>file &&
+	git add file &&
+	test_set_editor "$TEST_DIRECTORY"/t7500/add-content-and-comment &&
+	git -c commit.cleanup=whitespace commit --no-status &&
+	commit_msg_is "commit message # comment"
+'
+
+test_expect_success 'cleanup commit message (option overrides config)' '
+	echo content >>file &&
+	git add file &&
+	test_set_editor "$TEST_DIRECTORY"/t7500/add-content-and-comment &&
+	git -c commit.cleanup=whitespace commit --cleanup=default &&
+	commit_msg_is "commit message"
+'
+
+test_expect_success 'cleanup commit message (default, -m)' '
+	echo content >>file &&
+	git add file &&
+	git commit -m "message #comment " &&
+	commit_msg_is "message #comment"
+'
+
+test_expect_success 'cleanup commit message (whitespace option, -m)' '
+	echo content >>file &&
+	git add file &&
+	git commit --cleanup=whitespace --no-status -m "message #comment " &&
+	commit_msg_is "message #comment"
+'
+
+test_expect_success 'cleanup commit message (whitespace config, -m)' '
+	echo content >>file &&
+	git add file &&
+	git -c commit.cleanup=whitespace commit --no-status -m "message #comment " &&
+	commit_msg_is "message #comment"
+'
+
 test_expect_success 'message shows author when it is not equal to committer' '
 	echo >>negative &&
 	git commit -e -m "sample" -a &&
-- 
1.8.1.227.g44fe835
