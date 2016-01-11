From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 2/2] builtin/grep: add grep.fallbackToNoIndex config
Date: Mon, 11 Jan 2016 22:26:20 +0100
Message-ID: <1452547580-30687-3-git-send-email-t.gummerer@gmail.com>
References: <1452435597-12099-1-git-send-email-t.gummerer@gmail.com>
 <1452547580-30687-1-git-send-email-t.gummerer@gmail.com>
Cc: pclouds@gmail.com, sunshine@sunshineco.com, gitster@pobox.com,
	peff@peff.net, Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 11 22:26:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIjyv-0004GP-SF
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 22:26:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933393AbcAKV00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 16:26:26 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32901 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933357AbcAKV0Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 16:26:24 -0500
Received: by mail-wm0-f68.google.com with SMTP id u188so28082237wmu.0
        for <git@vger.kernel.org>; Mon, 11 Jan 2016 13:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DFxlWayUrN+vqoDwz0t1n9H4tcqp5vAycBmRUYhFdJw=;
        b=tBwLjrEB+U5xYCEpRecKTYrzAIfnFTqzK0Vxj0UxIy4TAfw5BNHjjkvLHmIMePXA5M
         edyX5lAKG5ctFO+x3nLdlaJLnK3ZsHGOnDgM0HAStDLjdWP6xqTLFgmxWhfeZisejXZ6
         ANlN1cCsi1zImN1ScQcFohppaz+elGMpZCYuCQ+7bpJjyq5fZoNUrhhJctZr/cbstwAZ
         5ReM5SwysFm7tid2nye1cN5Di9Nyj6kg3gdS7/nvzknGH2qEMkns15UqofV21oW2hFwI
         BjB5EEFBGyY3ajlOLIP2k7cbFu5aWk+ipArZY4yIPWi76H4YL3YP8Puc6Fbc4+zvy0bq
         e/+w==
X-Received: by 10.28.214.76 with SMTP id n73mr17172477wmg.52.1452547583602;
        Mon, 11 Jan 2016 13:26:23 -0800 (PST)
Received: from localhost (host143-106-dynamic.248-95-r.retail.telecomitalia.it. [95.248.106.143])
        by smtp.gmail.com with ESMTPSA id e77sm14559156wma.18.2016.01.11.13.26.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jan 2016 13:26:22 -0800 (PST)
X-Mailer: git-send-email 2.7.0.2.gafd9bce.dirty
In-Reply-To: <1452547580-30687-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283724>

Currently when git grep is used outside of a git repository without the
--no-index option git simply dies.  For convenience, add a
grep.fallbackToNoIndex configuration variable.  If set to true, git grep
behaves like git grep --no-index if it is run outside of a git
repository.  It defaults to false, preserving the current behavior.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/config.txt   |  4 ++++
 Documentation/git-grep.txt |  4 ++++
 builtin/grep.c             | 23 ++++++++++++++++++-----
 t/t7810-grep.sh            | 41 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 67 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f617886..8d51f80 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1450,6 +1450,10 @@ grep.extendedRegexp::
 	option is ignored when the 'grep.patternType' option is set to a value
 	other than 'default'.
 
+grep.fallbackToNoIndex::
+	If set to true, fall back to git grep --no-index if git grep
+	is executed outside of a git repository.  Defaults to false.
+
 gpg.program::
 	Use this custom program instead of "gpg" found on $PATH when
 	making or verifying a PGP signature. The program must support the
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 4a44d6d..15b9033 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -56,6 +56,10 @@ grep.extendedRegexp::
 grep.fullName::
 	If set to true, enable '--full-name' option by default.
 
+grep.fallbackToNoIndex::
+	If set to true, fall back to git grep --no-index if git grep
+	is executed outside of a git repository.  Defaults to false.
+
 
 OPTIONS
 -------
diff --git a/builtin/grep.c b/builtin/grep.c
index 4229cae..5efe9bb 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -755,9 +755,20 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 	grep_commit_pattern_type(pattern_type_arg, &opt);
 
-	if (use_index && !startup_info->have_repository)
-		/* die the same way as if we did it at the beginning */
-		setup_git_directory();
+	if (use_index && !startup_info->have_repository) {
+		int fallback = 0;
+		git_config_get_bool("grep.fallbacktonoindex", &fallback);
+		if (fallback) {
+			int nongit = 0;
+
+			setup_git_directory_gently(&nongit);
+			if (nongit)
+				use_index = 0;
+		} else {
+			/* die the same way as if we did it at the beginning */
+			setup_git_directory();
+		}
+	}
 
 	/*
 	 * skip a -- separator; we know it cannot be
@@ -874,12 +885,14 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		setup_pager();
 
 	if (!use_index && (untracked || cached))
-		die(_("--cached or --untracked cannot be used with --no-index."));
+		die(_("--cached or --untracked cannot be used with --no-index "
+		      "or outside of a git repository"));
 
 	if (!use_index || untracked) {
 		int use_exclude = (opt_exclude < 0) ? use_index : !!opt_exclude;
 		if (list.nr)
-			die(_("--no-index or --untracked cannot be used with revs."));
+			die(_("git grep outside of a repository, --no-index or "
+			      "--untracked cannot be used with revs."));
 		hit = grep_directory(&opt, &pathspec, use_exclude);
 	} else if (0 <= opt_exclude) {
 		die(_("--[no-]exclude-standard cannot be used for tracked contents."));
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index cc4b97d..b540944 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -821,6 +821,47 @@ test_expect_success 'outside of git repository' '
 	)
 '
 
+test_expect_success 'outside of git repository with fallbackToNoIndex' '
+	rm -fr non &&
+	mkdir -p non/git/sub &&
+	echo hello >non/git/file1 &&
+	echo world >non/git/sub/file2 &&
+	cat <<-\EOF >non/expect.full &&
+	file1:hello
+	sub/file2:world
+	EOF
+	echo file2:world >non/expect.sub &&
+	(
+		GIT_CEILING_DIRECTORIES="$(pwd)/non" &&
+		export GIT_CEILING_DIRECTORIES &&
+		cd non/git &&
+		test_must_fail git -c grep.fallbackToNoIndex=false grep o &&
+		git -c grep.fallbackToNoIndex=true grep o >../actual.full &&
+		test_cmp ../expect.full ../actual.full &&
+		cd sub &&
+		test_must_fail git -c grep.fallbackToNoIndex=false grep o &&
+		git -c grep.fallbackToNoIndex=true grep o >../../actual.sub &&
+		test_cmp ../../expect.sub ../../actual.sub
+	) &&
+
+	echo ".*o*" >non/git/.gitignore &&
+	(
+		GIT_CEILING_DIRECTORIES="$(pwd)/non" &&
+		export GIT_CEILING_DIRECTORIES &&
+		cd non/git &&
+		test_must_fail git -c grep.fallbackToNoIndex=false grep o &&
+		git -c grep.fallbackToNoIndex=true grep --exclude-standard o >../actual.full &&
+		test_cmp ../expect.full ../actual.full &&
+
+		{
+			echo ".gitignore:.*o*" &&
+			cat ../expect.full
+		} >../expect.with.ignored &&
+		git -c grep.fallbackToNoIndex grep --no-exclude o >../actual.full &&
+		test_cmp ../expect.with.ignored ../actual.full
+	)
+'
+
 test_expect_success 'inside git repository but with --no-index' '
 	rm -fr is &&
 	mkdir -p is/git/sub &&
-- 
2.7.0.2.gafd9bce.dirty
