From: Justin Lebar <jlebar@google.com>
Subject: [PATCH v5 4/4] Fix misuses of "nor" outside comments and in tests
Date: Mon, 31 Mar 2014 15:11:47 -0700
Message-ID: <1396303907-23291-4-git-send-email-jlebar@google.com>
References: <1396303907-23291-1-git-send-email-jlebar@google.com>
Cc: Justin Lebar <jlebar@google.com>, Richard Hansen <rhansen@bbn.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 01 00:14:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUkRJ-0007P6-TZ
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 00:12:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547AbaCaWMF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 18:12:05 -0400
Received: from mail-vc0-f201.google.com ([209.85.220.201]:57682 "EHLO
	mail-vc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447AbaCaWL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 18:11:59 -0400
Received: by mail-vc0-f201.google.com with SMTP id ik5so1231603vcb.2
        for <git@vger.kernel.org>; Mon, 31 Mar 2014 15:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vglzd+xK03fRZeVU5DEc7VAgpvKMp7FY34SRMp+i+Fs=;
        b=V+q9r07vc75zOVeGYrY7KWcwUi36/ijnzceRhicOvkfblPebmyZBJVPN8uaG5x5khl
         IJe8C1Pvpaz7Y0KsXrAjm/9nt0JXamUbyW6+ig6Lb3LubFhd1GD7IRfb6AhmLl4VKhtY
         1OMB40r+JayXIVs7oeeWOXtudqZzYIL2/6G2Qq+jPhXEZjl1awyJjJ9ANbxFgjsPAELT
         w7KC11K9rHpNLUma7LThuzC8929TQ5rBVxAmRFqb7KAZdxh1/NShb+X0UufBARiV7gm5
         56RXjsAZq1HYz8a7OGFxH22+xkMVLlKzDbpWvG6dSjVnVV/pKIelJc1ALbLY0zf+rXUV
         kpxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vglzd+xK03fRZeVU5DEc7VAgpvKMp7FY34SRMp+i+Fs=;
        b=NDCRHzG2JjyvYybFtazDfDweIeCros+MHbJ0KoI/8d/uo7H61axkvIL2VIq2iRnsvH
         A/EmbCUFiOFnE7D9sFILQ2jBkR0lZI3Q6Ylz6EuDNSvJpnBB+SK0i4RrlHEISk+joKYu
         8yF0/pZcO2nLS4v3rIwQkwZ//2vRulL5Pgh402PP/15At1eva0/zx+2aMvGFWvffjdQ4
         ENkQ9ZoXclXAAxEfHK/B8ZX77b1sz4v6D19E/sNU+X/KZleAUIj+Iw8fC+CNP/Q5Vbto
         eUm1l+6ih/ecsPFazRr1LYvdUR8ohgFFAc2xOmng0/WmZVNy48pHpHXO2YDV4NqlvdDi
         MlZQ==
X-Gm-Message-State: ALoCoQlkaKGRh9Fec936RgIFuk7jnNuDfjLdvH3H5UgHL++bAj5oBXMtlYU1pZxrtVRfecEbg2TdI+dkmV7dBMqhtXa0xEh7ZKHcnyAGVVXAbeKWGn8zNyDxPOAnxoNZsgoMkU0+ERPVs0zMmWJbvRDM2Kf/ceO+jijYBz7mxmM8zmlNdHWuTluSJjpiLYWopoAJVohPs6I7
X-Received: by 10.58.195.202 with SMTP id ig10mr10418421vec.38.1396303918552;
        Mon, 31 Mar 2014 15:11:58 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id i30si2918926yhc.0.2014.03.31.15.11.58
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 31 Mar 2014 15:11:58 -0700 (PDT)
Received: from jlebar0.mtv.corp.google.com (jlebar0.mtv.corp.google.com [172.17.132.58])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 47AC95A4226;
	Mon, 31 Mar 2014 15:11:58 -0700 (PDT)
Received: by jlebar0.mtv.corp.google.com (Postfix, from userid 214119)
	id 09FA91A08FA; Mon, 31 Mar 2014 15:11:57 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.423.g4596e3a
In-Reply-To: <1396303907-23291-1-git-send-email-jlebar@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245554>

Signed-off-by: Justin Lebar <jlebar@google.com>
---
 builtin/clean.c                   | 6 +++---
 builtin/commit.c                  | 2 +-
 git-add--interactive.perl         | 4 ++--
 perl/Git/SVN.pm                   | 4 ++--
 sha1_file.c                       | 2 +-
 t/t1001-read-tree-m-2way.sh       | 2 +-
 t/t4005-diff-rename-2.sh          | 2 +-
 t/t4009-diff-rename-4.sh          | 2 +-
 t/t5304-prune.sh                  | 2 +-
 t/t6036-recursive-corner-cases.sh | 2 +-
 t/t7104-reset.sh                  | 2 +-
 t/t9400-git-cvsserver-server.sh   | 2 +-
 12 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 5502957..977a068 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -903,11 +903,11 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 
 	if (!interactive && !dry_run && !force) {
 		if (config_set)
-			die(_("clean.requireForce set to true and neither -i, -n nor -f given; "
+			die(_("clean.requireForce set to true and neither -i, -n, nor -f given; "
 				  "refusing to clean"));
 		else
-			die(_("clean.requireForce defaults to true and neither -i, -n nor -f given; "
-				  "refusing to clean"));
+			die(_("clean.requireForce defaults to true and neither -i, -n, nor -f given;"
+				  " refusing to clean"));
 	}
 
 	if (force > 1)
diff --git a/builtin/commit.c b/builtin/commit.c
index 26b2986..5d594a4 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1123,7 +1123,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	if (argc == 0 && only && amend)
 		only_include_assumed = _("Clever... amending the last one with dirty index.");
 	if (argc > 0 && !also && !only)
-		only_include_assumed = _("Explicit paths specified without -i nor -o; assuming --only paths...");
+		only_include_assumed = _("Explicit paths specified without -i or -o; assuming --only paths...");
 	if (!cleanup_arg || !strcmp(cleanup_arg, "default"))
 		cleanup_mode = use_editor ? CLEANUP_ALL : CLEANUP_SPACE;
 	else if (!strcmp(cleanup_arg, "verbatim"))
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 24bb1ab..32c2f9c 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1156,9 +1156,9 @@ sub help_patch_cmd {
 	print colored $help_color, <<EOF ;
 y - $verb this hunk$target
 n - do not $verb this hunk$target
-q - quit; do not $verb this hunk nor any of the remaining ones
+q - quit; do not $verb this hunk or any of the remaining ones
 a - $verb this hunk and all later hunks in the file
-d - do not $verb this hunk nor any of the later hunks in the file
+d - do not $verb this hunk or any of the later hunks in the file
 g - select a hunk to go to
 / - search for a hunk matching the given regex
 j - leave this hunk undecided, see next undecided hunk
diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 62f3293..a59564f 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -480,8 +480,8 @@ sub refname {
 	# It cannot end with a slash /, we'll throw up on this because
 	# SVN can't have directories with a slash in their name, either:
 	if ($refname =~ m{/$}) {
-		die "ref: '$refname' ends with a trailing slash, this is ",
-		    "not permitted by git nor Subversion\n";
+		die "ref: '$refname' ends with a trailing slash; this is ",
+		    "not permitted by git or Subversion\n";
 	}
 
 	# It cannot have ASCII control character space, tilde ~, caret ^,
diff --git a/sha1_file.c b/sha1_file.c
index b79efe4..77dbb56 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1123,7 +1123,7 @@ static void report_helper(const struct string_list *list,
 	const char *msg;
 	switch (seen_bits) {
 	case 0:
-		msg = "no corresponding .idx nor .pack";
+		msg = "no corresponding .idx or .pack";
 		break;
 	case 1:
 		msg = "no corresponding .idx";
diff --git a/t/t1001-read-tree-m-2way.sh b/t/t1001-read-tree-m-2way.sh
index acaab07..1731383 100755
--- a/t/t1001-read-tree-m-2way.sh
+++ b/t/t1001-read-tree-m-2way.sh
@@ -18,7 +18,7 @@ In the test, these paths are used:
         frotz   - not in H added in M
         nitfol  - in H, stays in M unmodified
         rezrov  - in H, deleted in M
-        yomin   - not in H nor M
+        yomin   - not in H or M
 '
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-read-tree.sh
diff --git a/t/t4005-diff-rename-2.sh b/t/t4005-diff-rename-2.sh
index 77d7f49..7d2c6e1 100755
--- a/t/t4005-diff-rename-2.sh
+++ b/t/t4005-diff-rename-2.sh
@@ -66,7 +66,7 @@ test_expect_success \
 
 # tree has COPYING and rezrov.  work tree has the same COPYING and
 # copy-edited COPYING.1, and unchanged rezrov.  We should not say
-# anything about rezrov nor COPYING, since the revised again diff-raw
+# anything about rezrov or COPYING, since the revised again diff-raw
 # nows how to say Copy.
 
 test_expect_success \
diff --git a/t/t4009-diff-rename-4.sh b/t/t4009-diff-rename-4.sh
index f22c8e3..57c094f 100755
--- a/t/t4009-diff-rename-4.sh
+++ b/t/t4009-diff-rename-4.sh
@@ -73,7 +73,7 @@ test_expect_success \
 
 # tree has COPYING and rezrov.  work tree has the same COPYING and
 # copy-edited COPYING.1, and unchanged rezrov.  We should not say
-# anything about rezrov nor COPYING, since the revised again diff-raw
+# anything about rezrov or COPYING, since the revised again diff-raw
 # nows how to say Copy.
 
 test_expect_success \
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index 66c9a41..377d3d3 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -213,7 +213,7 @@ test_expect_success 'garbage report in count-objects -v' '
 warning: garbage found: .git/objects/pack/fake.bar
 warning: garbage found: .git/objects/pack/foo
 warning: garbage found: .git/objects/pack/foo.bar
-warning: no corresponding .idx nor .pack: .git/objects/pack/fake2.keep
+warning: no corresponding .idx or .pack: .git/objects/pack/fake2.keep
 warning: no corresponding .idx: .git/objects/pack/foo.keep
 warning: no corresponding .idx: .git/objects/pack/foo.pack
 warning: no corresponding .pack: .git/objects/pack/fake3.idx
diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index dfee7d1..a86087b 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -388,7 +388,7 @@ test_expect_failure 'git detects conflict w/ criss-cross+contrived resolution' '
 
 #
 # criss-cross + d/f conflict via add/add:
-#   Commit A: Neither file 'a' nor directory 'a/' exist.
+#   Commit A: Neither file 'a' nor directory 'a/' exists.
 #   Commit B: Introduce 'a'
 #   Commit C: Introduce 'a/file'
 #   Commit D: Merge B & C, keeping 'a' and deleting 'a/'
diff --git a/t/t7104-reset.sh b/t/t7104-reset.sh
index f136ee7..16faa07 100755
--- a/t/t7104-reset.sh
+++ b/t/t7104-reset.sh
@@ -33,7 +33,7 @@ test_expect_success 'reset --hard should restore unmerged ones' '
 
 '
 
-test_expect_success 'reset --hard did not corrupt index nor cached-tree' '
+test_expect_success 'reset --hard did not corrupt index or cached-tree' '
 
 	T=$(git write-tree) &&
 	rm -f .git/index &&
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 3edc408..1f06e25 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -512,7 +512,7 @@ test_expect_success 'cvs co -c (shows module database)' '
 # Known issues with git-cvsserver current log output:
 #  - Hard coded "lines: +2 -3" placeholder, instead of real numbers.
 #  - CVS normally does not internally add a blank first line
-#    nor a last line with nothing but a space to log messages.
+#    or a last line with nothing but a space to log messages.
 #  - The latest cvs 1.12.x server sends +0000 timezone (with some hidden "MT"
 #    tagging in the protocol), and if cvs 1.12.x client sees the MT tags,
 #    it converts to local time zone.  git-cvsserver doesn't do the +0000
-- 
1.9.1.423.g4596e3a
