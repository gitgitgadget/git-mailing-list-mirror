Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 963E5201A0
	for <e@80x24.org>; Thu, 11 May 2017 19:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756319AbdEKTiA (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 15:38:00 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:33857 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755224AbdEKTh7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 15:37:59 -0400
Received: by mail-pg0-f54.google.com with SMTP id u28so19314680pgn.1
        for <git@vger.kernel.org>; Thu, 11 May 2017 12:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Toti5rXEebOo12vCNQOanUcB5004b/GXjVmvghecm6Q=;
        b=k6Cl46Pio2lAIy3YWBf0hdkk9nchhrp3PLDF2Bdv5eObrdddQGoQbLHsXP69xdtfO/
         mThVjiecFEU9XOnQBQ7ur19QvRyOR4V3j4+76n+8ZwyYlqh4RtG80My+GlMPFihv3cye
         JUIYCqbyUJXfIdd4FUHiK9qdZsxUMzG4DCXeBrC+geH9uSm5CRM4mWwsizhGBsS+faPh
         wlH32O1wmVTqsdp24adFSY9hdrOZnMhjgChiULtl/cC/zrOck7NLsklWbvOH0fImYGJp
         fdUbuHJGNJqqXMr7p5YTUcPNKNPHlgBknfUEOQDzEGGdg/aWH83ECj1Ecj5QUxpZfoav
         XOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Toti5rXEebOo12vCNQOanUcB5004b/GXjVmvghecm6Q=;
        b=SxR4/7d8aYfCqyvtKjixuDxO52lFlMnXmDBo285m0L1zKv0uAYuWobmOI88icQCCvT
         yT2bxbetHTpSoXc8HOyxKr7A/ONaNcnRQj9/7VrKXu3c4L3GAPDd/3OEtAyZUsHDzSd8
         lGvLdtgMJqijS/VM18yNWrMWd34PuI1qCsEm+sqV6GzMCtxHKsqoo1imX5P4Kn3YT9Et
         neeVhpRw7VIsyHuiKzlsJhiUoCJkO7AVlpo4p4z7NKoQp0CneClZY4QcE0l3Q41UqHc2
         J3xZf0gnMAb24xkXmtn4zXOJVCpJuX1COtYp+4XEeEnah8lzg6nwbG2B65bj3sq6YFa2
         HH3Q==
X-Gm-Message-State: AODbwcATjniN0O6I5+e3XZZyEfxyjMz0mfL2tHS8Eyffwbu6qW9K7YVy
        KqjICDRjiF2jGiRT
X-Received: by 10.98.14.137 with SMTP id 9mr171720pfo.169.1494531478422;
        Thu, 11 May 2017 12:37:58 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id t5sm1789794pgt.19.2017.05.11.12.37.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 May 2017 12:37:57 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [RFC] send-email: support validate hook
Date:   Thu, 11 May 2017 12:37:53 -0700
Message-Id: <20170511193753.19594-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.0.rc2.291.g57267f2277-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, send-email has support for rudimentary e-mail validation.
Allow the user to add support for more validation by providing a
sendemail-validate hook.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---

This is motivated by situations in which we discuss a work in progress
using Gerrit (which requires Change-Id trailers in patches), and then,
forgetting to remove the Change-Id trailers, send them to the Git
mailing list (which does not want such trailers). I can envision such
functionality being useful in other situations, hence this patch
submission.

I'm not very familiar with Perl, and "There Is More Than One Way To Do
It", so advice on Perl style is appreciated.
---
 Documentation/git-send-email.txt |  1 +
 Documentation/githooks.txt       |  8 ++++++++
 git-send-email.perl              | 18 +++++++++++++++++-
 t/t9001-send-email.sh            | 40 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 9d66166f6..bb23b02ca 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -377,6 +377,7 @@ have been specified, in which case default to 'compose'.
 	Currently, validation means the following:
 +
 --
+		*	Invoke the sendemail-validate hook if present (see linkgit:githooks[5]).
 		*	Warn of patches that contain lines longer than 998 characters; this
 			is due to SMTP limits as described by http://www.ietf.org/rfc/rfc2821.txt.
 --
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 706091a56..b2514f4d4 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -447,6 +447,14 @@ rebase::
 The commits are guaranteed to be listed in the order that they were
 processed by rebase.
 
+sendemail-validate
+~~~~~~~~~~~~~~~~~~
+
+This hook is invoked by 'git send-email'.  It takes a single parameter,
+the name of the file that holds the e-mail to be sent.  Exiting with a
+non-zero status causes 'git send-email' to abort before sending any
+e-mails.
+
 
 GIT
 ---
diff --git a/git-send-email.perl b/git-send-email.perl
index eea0a517f..7de91ca7c 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -27,6 +27,7 @@ use Term::ANSIColor;
 use File::Temp qw/ tempdir tempfile /;
 use File::Spec::Functions qw(catfile);
 use Error qw(:try);
+use Cwd qw(abs_path cwd);
 use Git;
 use Git::I18N;
 
@@ -628,9 +629,24 @@ if (@rev_list_opts) {
 @files = handle_backup_files(@files);
 
 if ($validate) {
+	my @hook = ($repo->repo_path().'/hooks/sendemail-validate', '');
+	my $use_hook = -x $hook[0];
+	if ($use_hook) {
+		# The hook needs a correct GIT_DIR.
+		$ENV{"GIT_DIR"} = $repo->repo_path();
+	}
 	foreach my $f (@files) {
 		unless (-p $f) {
-			my $error = validate_patch($f);
+			my $error;
+			if ($use_hook) {
+				$hook[1] = abs_path($f);
+				my $cwd_save = cwd();
+				chdir($repo->wc_path() or $repo->repo_path());
+				$error = "rejected by sendemail-validate hook"
+					unless system(@hook) == 0;
+				chdir($cwd_save);
+			}
+			$error = validate_patch($f) unless $error;
 			$error and die sprintf(__("fatal: %s: %s\nwarning: no patches were sent\n"),
 						  $f, $error);
 		}
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 60a80f60b..f3f238d40 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1913,4 +1913,44 @@ test_expect_success $PREREQ 'leading and trailing whitespaces are removed' '
 	test_cmp expected-list actual-list
 '
 
+test_expect_success $PREREQ 'invoke hook' '
+	mkdir -p .git/hooks &&
+
+	write_script .git/hooks/sendemail-validate <<-\EOF &&
+		# test that we have the correct environment variable, pwd, and
+		# argument
+		case "$GIT_DIR" in
+			*.git)
+				true
+				;;
+			*)
+				false
+				;;
+		esac &&
+		test -e 0001-add-master.patch &&
+		grep "add master" "$1"
+	EOF
+
+	mkdir subdir &&
+	(
+		# Test that it works even if we are not at the root of the
+		# working tree
+		cd subdir &&
+		git send-email \
+			--from="Example <nobody@example.com>" \
+			--to=nobody@example.com \
+			--smtp-server="$(pwd)/../fake.sendmail" \
+			../0001-add-master.patch &&
+
+		# Verify error message when a patch is rejected by the hook
+		sed -e "s/add master/x/" ../0001-add-master.patch >../another.patch &&
+		git send-email \
+			--from="Example <nobody@example.com>" \
+			--to=nobody@example.com \
+			--smtp-server="$(pwd)/../fake.sendmail" \
+			../another.patch 2>err
+		test_i18ngrep "rejected by sendemail-validate hook" err
+	)
+'
+
 test_done
-- 
2.13.0.rc2.291.g57267f2277-goog

