Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B080402454
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 22:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773959928; cv=none; b=Dpq35grtpGfM3ivF2AxFAmfjdceabu0GJC3QuYrqTrFBAbgVdgQToWo1oZxJCN8Tpz/EoP8PFdmNhOK5H1cwSJ+4bd7OY09WM8yoUIuP9MwgG+daw8yFOpop6es+t4TwKP3iM+hdl5D2pS/F7n2cVjnLLiL7Il+qhf3ZuhVRtRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773959928; c=relaxed/simple;
	bh=H51oudAIbhki4379hL/cY1JYdsdIFGOZJwR7jRnsMys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IrItRh7UJDcHJYaj3hAD6kk8VLizSZ1YBpCWZKtSGrDQg/3WbPruzkvwVWMTByeNHAaMQGpLd5H05W7YtWDzpjt6Ezh70uwZttc7nV/b4MEHqnogk7R1p0me15ZOvR/GfH45sJAWigWzz4xwEEa45C1KKTJPlnQvLCR+6INQCko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=FtzjBRB9; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="FtzjBRB9"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1773959919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sYvc6yzpXJ26Cq8mM6Z6eXZBzwqmB5nqXhrtg0O6Z5w=;
	b=FtzjBRB9o8TNPydfmj6Eg/BW4it6E2aiM/aANUsGc5kHdTFMMMbGZ7yYsy9yupmSuRrrsH
	oof6Ny/s3Zy2dAo4+zHfaMwn4iz1QZSv4QZdqWSAFyFh1aKmCfosnVQEHSfbjwXeul7POh
	qW7cpUrN+P+6ttNZpGZgeMOvuFs/kzvVgyY611UzoXIifn0a+KbopaTKcbM1T88MFALJyI
	KfyD1sBtYpPyOKIU4gAU6UEfWJMKHxxcnF3OYXr65LQdiXcMvBuzf7a78aF6Am3ax1sFAd
	7kNzoFEGl60Adi2ujjsJy5yr7fOpOx5XPY9MDYJMxW6lhkG8MFnO79jUb1qeQA==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v2 3/8] format-patch: rename --cover-letter-format option
Date: Thu, 19 Mar 2026 23:38:13 +0100
Message-ID: <5d061d6398bae368a7cc95700b5df44854d1d8e8.1773959395.git.mroik@delayed.space>
In-Reply-To: <cover.1773959395.git.mroik@delayed.space>
References: <cover.1773530191.git.mroik@delayed.space> <cover.1773959395.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -----

To align the name of the configuration variable and the name of the
command line option, either one should change name. By changing the name
of the option we get the added benefit of having --cover-<TAB> expand to
--cover-letter without ambiguity.

If the user gives the --cover-letter-format option it would be
reasonable to expect that the user wants to generate the cover letter
despite not giving --cover-letter.

Rename --cover-letter-format to --commit-list-format and make it imply
--cover-letter unless --no-cover-letter is given.

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
 Documentation/git-format-patch.adoc | 17 ++++++------
 builtin/log.c                       |  4 ++-
 t/t4014-format-patch.sh             | 41 +++++++++++++++--------------
 t/t9902-completion.sh               |  1 -
 4 files changed, 32 insertions(+), 31 deletions(-)

diff --git a/Documentation/git-format-patch.adoc b/Documentation/git-format-patch.adoc
index 31fa492335..45ca72e670 100644
--- a/Documentation/git-format-patch.adoc
+++ b/Documentation/git-format-patch.adoc
@@ -24,7 +24,7 @@ SYNOPSIS
 		   [(--reroll-count|-v) <n>]
 		   [--to=<email>] [--cc=<email>]
 		   [--[no-]cover-letter] [--quiet]
-		   [--cover-letter-format=<format-spec>]
+		   [--commit-list-format=<format-spec>]
 		   [--[no-]encode-email-headers]
 		   [--no-notes | --notes[=<ref>]]
 		   [--interdiff=<previous>]
@@ -323,16 +323,15 @@ feeding the result to `git send-email`.
 	containing the branch description, shortlog and the overall diffstat.  You can
 	fill in a description in the file before sending it out.
 
---cover-letter-format=<format-spec>::
-	Specify the format in which to generate the commit list of the
-	patch series. This option is available if the user wants to use
-	an alternative to the default `shortlog` format. The accepted
-	values for format-spec are "shortlog" or a format string
-	prefixed with `log:`.
+--commit-list-format=<format-spec>::
+	Specify the format in which to generate the commit list of the patch
+	series. The accepted values for format-spec are "shortlog" or a format
+	string prefixed with `log:`.
 	e.g. `log: %s (%an)`
-	If defined, defaults to the `format.commitListFormat` configuration
+	If not given, defaults to the `format.commitListFormat` configuration
 	variable.
-	This option is relevant only if a cover letter is generated.
+	This option implies the use of `--cover-letter` unless
+	`--no-cover-letter` is given.
 
 --encode-email-headers::
 --no-encode-email-headers::
diff --git a/builtin/log.c b/builtin/log.c
index 997bdd608e..a7f129d583 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -2014,7 +2014,7 @@ int cmd_format_patch(int argc,
 			    N_("print patches to standard out")),
 		OPT_BOOL(0, "cover-letter", &cover_letter,
 			    N_("generate a cover letter")),
-		OPT_STRING(0, "cover-letter-format", &cover_letter_fmt, N_("format-spec"),
+		OPT_STRING(0, "commit-list-format", &cover_letter_fmt, N_("format-spec"),
 			    N_("format spec used for the commit list in the cover letter")),
 		OPT_BOOL(0, "numbered-files", &just_numbers,
 			    N_("use simple number sequence for output file names")),
@@ -2358,6 +2358,8 @@ int cmd_format_patch(int argc,
 		cover_letter_fmt = cfg.fmt_cover_letter_commit_list;
 		if (!cover_letter_fmt)
 			cover_letter_fmt = "shortlog";
+	} else if (cover_letter == -1) {
+		cover_letter = 1;
 	}
 
 	if (cover_letter == -1) {
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 7c67bdf922..d2a775f78d 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -383,49 +383,50 @@ test_expect_success 'filename limit applies only to basename' '
 test_expect_success 'cover letter with subject, author and count' '
 	rm -rf patches &&
 	test_when_finished "git reset --hard HEAD~1" &&
-	test_when_finished "rm -rf patches result test_file" &&
+	test_when_finished "rm -rf patches test_file" &&
 	touch test_file &&
 	git add test_file &&
 	git commit -m "This is a subject" &&
-	git format-patch --cover-letter \
-	--cover-letter-format="log:[%(count)/%(total)] %s (%an)" -o patches HEAD~1 &&
-	grep "^\[1/1\] This is a subject (A U Thor)$" patches/0000-cover-letter.patch >result &&
-	test_line_count = 1 result
+	git format-patch --commit-list-format="log:[%(count)/%(total)] %s (%an)" \
+	-o patches HEAD~1 &&
+	test_grep "^\[1/1\] This is a subject (A U Thor)$" patches/0000-cover-letter.patch
 '
 
-test_expected_success 'cover letter with author and count' '
+test_expect_success 'cover letter with author and count' '
 	test_when_finished "git reset --hard HEAD~1" &&
-	test_when_finished "rm -rf patches result test_file" &&
+	test_when_finished "rm -rf patches test_file" &&
 	touch test_file &&
 	git add test_file &&
 	git commit -m "This is a subject" &&
-	git format-patch --cover-letter \
-	--cover-letter-format="log:[%(count)/%(total)] %an" -o patches HEAD~1 &&
-	grep "^\[1/1\] A U Thor$" patches/0000-cover-letter.patch >result &&
-	test_line_count = 1 result
+	git format-patch --commit-list-format="log:[%(count)/%(total)] %an" \
+	-o patches HEAD~1 &&
+	test_grep "^\[1/1\] A U Thor$" patches/0000-cover-letter.patch
 '
 
 test_expect_success 'cover letter shortlog' '
 	test_when_finished "git reset --hard HEAD~1" &&
-	test_when_finished "rm -rf patches result test_file" &&
+	test_when_finished "rm -rf expect patches result test_file" &&
+	cat >expect <<-"EOF" &&
+	A U Thor (1):
+	  This is a subject
+	EOF
 	touch test_file &&
 	git add test_file &&
 	git commit -m "This is a subject" &&
-	git format-patch --cover-letter --cover-letter-format=shortlog \
-	-o patches HEAD~1 &&
-	sed -n -e "/^A U Thor/p;" patches/0000-cover-letter.patch >result &&
-	test_line_count = 1 result
+	git format-patch --commit-list-format=shortlog -o patches HEAD~1 &&
+	grep -E -A 1 "^A U Thor \([[:digit:]]+\):$" patches/0000-cover-letter.patch >result &&
+	cat result &&
+	test_cmp expect result
 '
 
-test_expect_success 'cover letter no format' '
+test_expect_success 'no cover letter but with format specified' '
 	test_when_finished "git reset --hard HEAD~1" &&
 	test_when_finished "rm -rf patches result test_file" &&
 	touch test_file &&
 	git add test_file &&
 	git commit -m "This is a subject" &&
-	git format-patch --cover-letter -o patches HEAD~1 &&
-	sed -n -e "/^A U Thor/p;" patches/0000-cover-letter.patch >result &&
-	test_line_count = 1 result
+	git format-patch --no-cover-letter --commit-list-format="[%(count)] %s" -o patches HEAD~1 &&
+	test_path_is_missing patches/0000-cover-letter.patch
 '
 
 test_expect_success 'cover letter config with count, subject and author' '
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 35e20b5351..2f9a597ec7 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2775,7 +2775,6 @@ test_expect_success PERL 'send-email' '
 	test_completion "git send-email --cov" <<-\EOF &&
 	--cover-from-description=Z
 	--cover-letter Z
-	--cover-letter-format=Z
 	EOF
 	test_completion "git send-email --val" <<-\EOF &&
 	--validate Z
-- 
2.53.0.1018.g2bb0e51243

