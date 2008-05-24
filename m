From: Junio C Hamano <junio@pobox.com>
Subject: [PATCH 1/3] tests: do not use implicit "git diff --no-index"
Date: Sat, 24 May 2008 00:25:45 -0700
Message-ID: <7vmymgmadi.fsf@gitster.siamese.dyndns.org>
References: <b0943d9e0805230720h61cbabbbw180908e1b28a34cc@mail.gmail.com>
 <alpine.LFD.1.10.0805230906110.3081@woody.linux-foundation.org>
 <alpine.LFD.1.10.0805230942480.3081@woody.linux-foundation.org>
 <7vbq2wsxnk.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0805232309350.30431@racer>
 <alpine.DEB.1.00.0805232349410.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	git <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat May 24 09:27:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jzo9z-0007LI-BV
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 09:27:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753252AbYEXH00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 May 2008 03:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752471AbYEXH00
	(ORCPT <rfc822;git-outgoing>); Sat, 24 May 2008 03:26:26 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34137 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753567AbYEXH0V (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2008 03:26:21 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 79A273E2C;
	Sat, 24 May 2008 03:26:17 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 696163CFC; Sat, 24 May 2008 03:25:54 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B2D59F86-2962-11DD-AAD1-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82800>

As a general principle, we should not use "git diff" to validate the
results of what git command that is being tested has done.  We would not
know if we are testing the command in question, or locating a bug in the
cute hack of "git diff --no-index".

Rather use test_cmp for that purpose.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/diff-lib.sh                      |    6 +-
 t/t0030-stripspace.sh              |  156 +++++++++++++-------------
 t/t0040-parse-options.sh           |   18 ++--
 t/t1000-read-tree-m-3way.sh        |    2 +-
 t/t1001-read-tree-m-2way.sh        |   26 +++---
 t/t1002-read-tree-m-u-2way.sh      |    2 +-
 t/t1300-repo-config.sh             |    8 +-
 t/t1303-wacky-config.sh            |    2 +-
 t/t1502-rev-parse-parseopt.sh      |    2 +-
 t/t3001-ls-files-others-exclude.sh |    4 +-
 t/t3002-ls-files-dashpath.sh       |   10 +-
 t/t3030-merge-recursive.sh         |   42 ++++----
 t/t3040-subprojects-basic.sh       |    4 +-
 t/t3100-ls-tree-restrict.sh        |    2 +-
 t/t3101-ls-tree-dirname.sh         |    2 +-
 t/t3300-funny-names.sh             |   30 +++---
 t/t3900-i18n-commit.sh             |    2 +-
 t/t4006-diff-mode.sh               |    2 +-
 t/t4013-diff-various.sh            |    2 +-
 t/t4014-format-patch.sh            |    2 +-
 t/t4015-diff-whitespace.sh         |   12 +-
 t/t4016-diff-quote.sh              |    4 +-
 t/t4018-diff-funcname.sh           |    8 +-
 t/t4100-apply-stat.sh              |   14 ++--
 t/t4104-apply-boundary.sh          |    4 +-
 t/t4115-apply-symlink.sh           |    4 +-
 t/t4116-apply-reverse.sh           |    2 +-
 t/t4117-apply-reject.sh            |   12 +-
 t/t4118-apply-empty-context.sh     |    6 +-
 t/t4200-rerere.sh                  |    6 +-
 t/t5305-include-tag.sh             |    4 +-
 t/t5400-send-pack.sh               |    2 +-
 t/t5401-update-hooks.sh            |   10 +-
 t/t5503-tagfollow.sh               |    8 +-
 t/t5505-remote.sh                  |   10 +-
 t/t5515-fetch-merge-logic.sh       |    4 +-
 t/t6006-rev-list-format.sh         |    2 +-
 t/t6023-merge-file.sh              |    8 +-
 t/t6024-recursive-merge.sh         |    4 +-
 t/t6029-merge-subtree.sh           |    4 +-
 t/t6120-describe.sh                |    2 +-
 t/t6200-fmt-merge-msg.sh           |   16 ++--
 t/t6300-for-each-ref.sh            |   24 ++--
 t/t7003-filter-branch.sh           |    4 +-
 t/t7004-tag.sh                     |  210 ++++++++++++++++++------------------
 t/t7102-reset.sh                   |   12 +-
 t/t7502-status.sh                  |    6 +-
 t/t9100-git-svn-basic.sh           |    6 +-
 t/t9300-fast-import.sh             |   34 +++---
 t/t9600-cvsimport.sh               |    8 +-
 50 files changed, 387 insertions(+), 387 deletions(-)

diff --git a/t/diff-lib.sh b/t/diff-lib.sh
index 28b941c..4bddeb5 100644
--- a/t/diff-lib.sh
+++ b/t/diff-lib.sh
@@ -11,7 +11,7 @@ compare_diff_raw () {
 
     sed -e "$sanitize_diff_raw" <"$1" >.tmp-1
     sed -e "$sanitize_diff_raw" <"$2" >.tmp-2
-    git diff .tmp-1 .tmp-2 && rm -f .tmp-1 .tmp-2
+    test_cmp .tmp-1 .tmp-2 && rm -f .tmp-1 .tmp-2
 }
 
 sanitize_diff_raw_z='/^:/s/ '"$_x40"' '"$_x40"' \([A-Z]\)[0-9]*$/ X X \1#/'
@@ -23,7 +23,7 @@ compare_diff_raw_z () {
 
     perl -pe 'y/\000/\012/' <"$1" | sed -e "$sanitize_diff_raw_z" >.tmp-1
     perl -pe 'y/\000/\012/' <"$2" | sed -e "$sanitize_diff_raw_z" >.tmp-2
-    git diff .tmp-1 .tmp-2 && rm -f .tmp-1 .tmp-2
+    test_cmp .tmp-1 .tmp-2 && rm -f .tmp-1 .tmp-2
 }
 
 compare_diff_patch () {
@@ -37,5 +37,5 @@ compare_diff_patch () {
 	/^[dis]*imilarity index [0-9]*%$/d
 	/^index [0-9a-f]*\.\.[0-9a-f]/d
     ' <"$2" >.tmp-2
-    git diff .tmp-1 .tmp-2 && rm -f .tmp-1 .tmp-2
+    test_cmp .tmp-1 .tmp-2 && rm -f .tmp-1 .tmp-2
 }
diff --git a/t/t0030-stripspace.sh b/t/t0030-stripspace.sh
index 3ecdd66..ccb0a3c 100755
--- a/t/t0030-stripspace.sh
+++ b/t/t0030-stripspace.sh
@@ -16,96 +16,96 @@ test_expect_success \
     'long lines without spaces should be unchanged' '
     echo "$ttt" >expect &&
     git stripspace <expect >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     echo "$ttt$ttt" >expect &&
     git stripspace <expect >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     echo "$ttt$ttt$ttt" >expect &&
     git stripspace <expect >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     echo "$ttt$ttt$ttt$ttt" >expect &&
     git stripspace <expect >actual &&
-    git diff expect actual
+    test_cmp expect actual
 '
 
 test_expect_success \
     'lines with spaces at the beginning should be unchanged' '
     echo "$sss$ttt" >expect &&
     git stripspace <expect >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     echo "$sss$sss$ttt" >expect &&
     git stripspace <expect >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     echo "$sss$sss$sss$ttt" >expect &&
     git stripspace <expect >actual &&
-    git diff expect actual
+    test_cmp expect actual
 '
 
 test_expect_success \
     'lines with intermediate spaces should be unchanged' '
     echo "$ttt$sss$ttt" >expect &&
     git stripspace <expect >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     echo "$ttt$sss$sss$ttt" >expect &&
     git stripspace <expect >actual &&
-    git diff expect actual
+    test_cmp expect actual
 '
 
 test_expect_success \
     'consecutive blank lines should be unified' '
     printf "$ttt\n\n$ttt\n" > expect &&
     printf "$ttt\n\n\n\n\n$ttt\n" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     printf "$ttt$ttt\n\n$ttt\n" > expect &&
     printf "$ttt$ttt\n\n\n\n\n$ttt\n" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     printf "$ttt$ttt$ttt\n\n$ttt\n" > expect &&
     printf "$ttt$ttt$ttt\n\n\n\n\n$ttt\n" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     printf "$ttt\n\n$ttt\n" > expect &&
     printf "$ttt\n\n\n\n\n$ttt\n" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     printf "$ttt\n\n$ttt$ttt\n" > expect &&
     printf "$ttt\n\n\n\n\n$ttt$ttt\n" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     printf "$ttt\n\n$ttt$ttt$ttt\n" > expect &&
     printf "$ttt\n\n\n\n\n$ttt$ttt$ttt\n" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     printf "$ttt\n\n$ttt\n" > expect &&
     printf "$ttt\n\t\n \n\n  \t\t\n$ttt\n" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     printf "$ttt$ttt\n\n$ttt\n" > expect &&
     printf "$ttt$ttt\n\t\n \n\n  \t\t\n$ttt\n" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     printf "$ttt$ttt$ttt\n\n$ttt\n" > expect &&
     printf "$ttt$ttt$ttt\n\t\n \n\n  \t\t\n$ttt\n" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     printf "$ttt\n\n$ttt\n" > expect &&
     printf "$ttt\n\t\n \n\n  \t\t\n$ttt\n" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     printf "$ttt\n\n$ttt$ttt\n" > expect &&
     printf "$ttt\n\t\n \n\n  \t\t\n$ttt$ttt\n" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     printf "$ttt\n\n$ttt$ttt$ttt\n" > expect &&
     printf "$ttt\n\t\n \n\n  \t\t\n$ttt$ttt$ttt\n" | git stripspace >actual &&
-    git diff expect actual
+    test_cmp expect actual
 '
 
 test_expect_success \
@@ -113,114 +113,114 @@ test_expect_success \
     > expect &&
 
     printf "\n" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     printf "\n\n\n" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     printf "$sss\n$sss\n$sss\n" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     printf "$sss$sss\n$sss\n\n" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     printf "\n$sss\n$sss$sss\n" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     printf "$sss$sss$sss$sss\n\n\n" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     printf "\n$sss$sss$sss$sss\n\n" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     printf "\n\n$sss$sss$sss$sss\n" | git stripspace >actual &&
-    git diff expect actual
+    test_cmp expect actual
 '
 
 test_expect_success \
     'consecutive blank lines at the beginning should be removed' '
     printf "$ttt\n" > expect &&
     printf "\n$ttt\n" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     printf "$ttt\n" > expect &&
     printf "\n\n\n$ttt\n" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     printf "$ttt$ttt\n" > expect &&
     printf "\n\n\n$ttt$ttt\n" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     printf "$ttt$ttt$ttt\n" > expect &&
     printf "\n\n\n$ttt$ttt$ttt\n" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     printf "$ttt$ttt$ttt$ttt\n" > expect &&
     printf "\n\n\n$ttt$ttt$ttt$ttt\n" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     printf "$ttt\n" > expect &&
 
     printf "$sss\n$sss\n$sss\n$ttt\n" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     printf "\n$sss\n$sss$sss\n$ttt\n" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     printf "$sss$sss\n$sss\n\n$ttt\n" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     printf "$sss$sss$sss\n\n\n$ttt\n" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     printf "\n$sss$sss$sss\n\n$ttt\n" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     printf "\n\n$sss$sss$sss\n$ttt\n" | git stripspace >actual &&
-    git diff expect actual
+    test_cmp expect actual
 '
 
 test_expect_success \
     'consecutive blank lines at the end should be removed' '
     printf "$ttt\n" > expect &&
     printf "$ttt\n\n" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     printf "$ttt\n" > expect &&
     printf "$ttt\n\n\n\n" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     printf "$ttt$ttt\n" > expect &&
     printf "$ttt$ttt\n\n\n\n" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     printf "$ttt$ttt$ttt\n" > expect &&
     printf "$ttt$ttt$ttt\n\n\n\n" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     printf "$ttt$ttt$ttt$ttt\n" > expect &&
     printf "$ttt$ttt$ttt$ttt\n\n\n\n" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     printf "$ttt\n" > expect &&
 
     printf "$ttt\n$sss\n$sss\n$sss\n" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     printf "$ttt\n\n$sss\n$sss$sss\n" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     printf "$ttt\n$sss$sss\n$sss\n\n" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     printf "$ttt\n$sss$sss$sss\n\n\n" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     printf "$ttt\n\n$sss$sss$sss\n\n" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     printf "$ttt\n\n\n$sss$sss$sss\n" | git stripspace >actual &&
-    git diff expect actual
+    test_cmp expect actual
 '
 
 test_expect_success \
@@ -257,27 +257,27 @@ test_expect_success \
     'text plus spaces without newline should show the correct lines' '
     printf "$ttt\n" >expect &&
     printf "$ttt$sss" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     printf "$ttt\n" >expect &&
     printf "$ttt$sss$sss" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     printf "$ttt\n" >expect &&
     printf "$ttt$sss$sss$sss" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     printf "$ttt$ttt\n" >expect &&
     printf "$ttt$ttt$sss" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     printf "$ttt$ttt\n" >expect &&
     printf "$ttt$ttt$sss$sss" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     printf "$ttt$ttt$ttt\n" >expect &&
     printf "$ttt$ttt$ttt$sss" | git stripspace >actual &&
-    git diff expect actual
+    test_cmp expect actual
 '
 
 test_expect_success \
@@ -294,27 +294,27 @@ test_expect_success \
     'text plus spaces at end should be cleaned and newline must remain' '
     echo "$ttt" >expect &&
     echo "$ttt$sss" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     echo "$ttt" >expect &&
     echo "$ttt$sss$sss" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     echo "$ttt" >expect &&
     echo "$ttt$sss$sss$sss" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     echo "$ttt$ttt" >expect &&
     echo "$ttt$ttt$sss" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     echo "$ttt$ttt" >expect &&
     echo "$ttt$ttt$sss$sss" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     echo "$ttt$ttt$ttt" >expect &&
     echo "$ttt$ttt$ttt$sss" | git stripspace >actual &&
-    git diff expect actual
+    test_cmp expect actual
 '
 
 # spaces only:
@@ -324,19 +324,19 @@ test_expect_success \
     printf "" >expect &&
 
     echo | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     echo "$sss" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     echo "$sss$sss" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     echo "$sss$sss$sss" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     echo "$sss$sss$sss$sss" | git stripspace >actual &&
-    git diff expect actual
+    test_cmp expect actual
 '
 
 test_expect_success \
@@ -353,43 +353,43 @@ test_expect_success \
     printf "" >expect &&
 
     printf "" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     printf "$sss$sss" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     printf "$sss$sss$sss" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     printf "$sss$sss$sss$sss" | git stripspace >actual &&
-    git diff expect actual
+    test_cmp expect actual
 '
 
 test_expect_success \
     'consecutive text lines should be unchanged' '
     printf "$ttt$ttt\n$ttt\n" >expect &&
     printf "$ttt$ttt\n$ttt\n" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     printf "$ttt\n$ttt$ttt\n$ttt\n" >expect &&
     printf "$ttt\n$ttt$ttt\n$ttt\n" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     printf "$ttt\n$ttt\n$ttt\n$ttt$ttt\n" >expect &&
     printf "$ttt\n$ttt\n$ttt\n$ttt$ttt\n" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     printf "$ttt\n$ttt\n\n$ttt$ttt\n$ttt\n" >expect &&
     printf "$ttt\n$ttt\n\n$ttt$ttt\n$ttt\n" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     printf "$ttt$ttt\n\n$ttt\n$ttt$ttt\n" >expect &&
     printf "$ttt$ttt\n\n$ttt\n$ttt$ttt\n" | git stripspace >actual &&
-    git diff expect actual &&
+    test_cmp expect actual &&
 
     printf "$ttt\n$ttt$ttt\n\n$ttt\n" >expect &&
     printf "$ttt\n$ttt$ttt\n\n$ttt\n" | git stripspace >actual &&
-    git diff expect actual
+    test_cmp expect actual
 '
 
 test_expect_success 'strip comments, too' '
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index c23f0ac..9965cfa 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -29,7 +29,7 @@ EOF
 test_expect_success 'test help' '
 	! test-parse-options -h > output 2> output.err &&
 	test ! -s output &&
-	git diff expect.err output.err
+	test_cmp expect.err output.err
 '
 
 cat > expect << EOF
@@ -40,7 +40,7 @@ EOF
 
 test_expect_success 'short options' '
 	test-parse-options -s123 -b -i 1729 -b > output 2> output.err &&
-	git diff expect output &&
+	test_cmp expect output &&
 	test ! -s output.err
 '
 cat > expect << EOF
@@ -53,7 +53,7 @@ test_expect_success 'long options' '
 	test-parse-options --boolean --integer 1729 --boolean --string2=321 \
 		> output 2> output.err &&
 	test ! -s output.err &&
-	git diff expect output
+	test_cmp expect output
 '
 
 cat > expect << EOF
@@ -69,7 +69,7 @@ test_expect_success 'intermingled arguments' '
 	test-parse-options a1 --string 123 b1 --boolean -j 13 -- --boolean \
 		> output 2> output.err &&
 	test ! -s output.err &&
-	git diff expect output
+	test_cmp expect output
 '
 
 cat > expect << EOF
@@ -81,13 +81,13 @@ EOF
 test_expect_success 'unambiguously abbreviated option' '
 	test-parse-options --int 2 --boolean --no-bo > output 2> output.err &&
 	test ! -s output.err &&
-	git diff expect output
+	test_cmp expect output
 '
 
 test_expect_success 'unambiguously abbreviated option with "="' '
 	test-parse-options --int=2 > output 2> output.err &&
 	test ! -s output.err &&
-	git diff expect output
+	test_cmp expect output
 '
 
 test_expect_success 'ambiguously abbreviated option' '
@@ -104,7 +104,7 @@ EOF
 test_expect_success 'non ambiguous option (after two options it abbreviates)' '
 	test-parse-options --st 123 > output 2> output.err &&
 	test ! -s output.err &&
-	git diff expect output
+	test_cmp expect output
 '
 
 cat > expect.err << EOF
@@ -114,7 +114,7 @@ EOF
 test_expect_success 'detect possible typos' '
 	! test-parse-options -boolean > output 2> output.err &&
 	test ! -s output &&
-	git diff expect.err output.err
+	test_cmp expect.err output.err
 '
 
 cat > expect <<EOF
@@ -127,7 +127,7 @@ EOF
 test_expect_success 'keep some options as arguments' '
 	test-parse-options --quux > output 2> output.err &&
         test ! -s output.err &&
-        git diff expect output
+        test_cmp expect output
 '
 
 test_done
diff --git a/t/t1000-read-tree-m-3way.sh b/t/t1000-read-tree-m-3way.sh
index 17f519f..807fb83 100755
--- a/t/t1000-read-tree-m-3way.sh
+++ b/t/t1000-read-tree-m-3way.sh
@@ -131,7 +131,7 @@ _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
 
 check_result () {
     git ls-files --stage | sed -e 's/ '"$_x40"' / X /' >current &&
-    git diff expected current
+    test_cmp expected current
 }
 
 # This is done on an empty work directory, which is the normal
diff --git a/t/t1001-read-tree-m-2way.sh b/t/t1001-read-tree-m-2way.sh
index b01b003..4b44e13 100755
--- a/t/t1001-read-tree-m-2way.sh
+++ b/t/t1001-read-tree-m-2way.sh
@@ -33,7 +33,7 @@ compare_change () {
 	    -e '/^--- /d; /^+++ /d; /^@@ /d;' \
 	    -e 's/^\([-+][0-7][0-7][0-7][0-7][0-7][0-7]\) '"$_x40"' /\1 X /p' \
 	    "$1"
-	git diff expected current
+	test_cmp expected current
 }
 
 check_cache_at () {
@@ -86,7 +86,7 @@ test_expect_success \
     'rm -f .git/index &&
      read_tree_twoway $treeH $treeM &&
      git ls-files --stage >1-3.out &&
-     git diff M.out 1-3.out &&
+     test_cmp M.out 1-3.out &&
      check_cache_at bozbar dirty &&
      check_cache_at frotz dirty &&
      check_cache_at nitfol dirty'
@@ -101,7 +101,7 @@ test_expect_success \
      git update-index --add yomin &&
      read_tree_twoway $treeH $treeM &&
      git ls-files --stage >4.out || return 1
-     git diff M.out 4.out >4diff.out
+     git diff --no-index M.out 4.out >4diff.out
      compare_change 4diff.out expected &&
      check_cache_at yomin clean'
 
@@ -115,7 +115,7 @@ test_expect_success \
      echo yomin yomin >yomin &&
      read_tree_twoway $treeH $treeM &&
      git ls-files --stage >5.out || return 1
-     git diff M.out 5.out >5diff.out
+     git diff --no-index M.out 5.out >5diff.out
      compare_change 5diff.out expected &&
      check_cache_at yomin dirty'
 
@@ -127,7 +127,7 @@ test_expect_success \
      git update-index --add frotz &&
      read_tree_twoway $treeH $treeM &&
      git ls-files --stage >6.out &&
-     git diff M.out 6.out &&
+     test_cmp M.out 6.out &&
      check_cache_at frotz clean'
 
 test_expect_success \
@@ -140,7 +140,7 @@ test_expect_success \
      echo frotz frotz >frotz &&
      read_tree_twoway $treeH $treeM &&
      git ls-files --stage >7.out &&
-     git diff M.out 7.out &&
+     test_cmp M.out 7.out &&
      check_cache_at frotz dirty'
 
 test_expect_success \
@@ -171,7 +171,7 @@ test_expect_success \
      git update-index --add rezrov &&
      read_tree_twoway $treeH $treeM &&
      git ls-files --stage >10.out &&
-     git diff M.out 10.out'
+     test_cmp M.out 10.out'
 
 test_expect_success \
     '11 - dirty path removed.' \
@@ -216,7 +216,7 @@ test_expect_success \
      git update-index --add nitfol &&
      read_tree_twoway $treeH $treeM &&
      git ls-files --stage >14.out || return 1
-     git diff M.out 14.out >14diff.out
+     git diff --no-index M.out 14.out >14diff.out
      compare_change 14diff.out expected &&
      check_cache_at nitfol clean'
 
@@ -230,7 +230,7 @@ test_expect_success \
      echo nitfol nitfol nitfol >nitfol &&
      read_tree_twoway $treeH $treeM &&
      git ls-files --stage >15.out || return 1
-     git diff M.out 15.out >15diff.out
+     git diff --no-index M.out 15.out >15diff.out
      compare_change 15diff.out expected &&
      check_cache_at nitfol dirty'
 
@@ -262,7 +262,7 @@ test_expect_success \
      git update-index --add bozbar &&
      read_tree_twoway $treeH $treeM &&
      git ls-files --stage >18.out &&
-     git diff M.out 18.out &&
+     test_cmp M.out 18.out &&
      check_cache_at bozbar clean'
 
 test_expect_success \
@@ -275,7 +275,7 @@ test_expect_success \
      echo gnusto gnusto >bozbar &&
      read_tree_twoway $treeH $treeM &&
      git ls-files --stage >19.out &&
-     git diff M.out 19.out &&
+     test_cmp M.out 19.out &&
      check_cache_at bozbar dirty'
 
 test_expect_success \
@@ -287,7 +287,7 @@ test_expect_success \
      git update-index --add bozbar &&
      read_tree_twoway $treeH $treeM &&
      git ls-files --stage >20.out &&
-     git diff M.out 20.out &&
+     test_cmp M.out 20.out &&
      check_cache_at bozbar dirty'
 
 test_expect_success \
@@ -337,7 +337,7 @@ test_expect_success \
      git update-index --add DF &&
      read_tree_twoway $treeDF $treeDFDF &&
      git ls-files --stage >DFDFcheck.out &&
-     git diff DFDF.out DFDFcheck.out &&
+     test_cmp DFDF.out DFDFcheck.out &&
      check_cache_at DF/DF dirty &&
      :'
 
diff --git a/t/t1002-read-tree-m-u-2way.sh b/t/t1002-read-tree-m-u-2way.sh
index 42e5cf8..e04990e 100755
--- a/t/t1002-read-tree-m-u-2way.sh
+++ b/t/t1002-read-tree-m-u-2way.sh
@@ -16,7 +16,7 @@ compare_change () {
 	sed >current \
 	    -e '/^--- /d; /^+++ /d; /^@@ /d;' \
 	    -e 's/^\(.[0-7][0-7][0-7][0-7][0-7][0-7]\) '"$_x40"' /\1 X /' "$1"
-	git diff expected current
+	test_cmp expected current
 }
 
 check_cache_at () {
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index a675cbb..afe7e66 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -427,13 +427,13 @@ cat > expect << EOF
 weird
 EOF
 
-test_expect_success "rename succeeded" "git diff expect .git/config"
+test_expect_success "rename succeeded" "test_cmp expect .git/config"
 
 test_expect_success "rename non-existing section" '
 	! git config --rename-section branch."world domination" branch.drei
 '
 
-test_expect_success "rename succeeded" "git diff expect .git/config"
+test_expect_success "rename succeeded" "test_cmp expect .git/config"
 
 test_expect_success "rename another section" \
 	'git config --rename-section branch."1 234 blabl/a" branch.drei'
@@ -449,7 +449,7 @@ cat > expect << EOF
 weird
 EOF
 
-test_expect_success "rename succeeded" "git diff expect .git/config"
+test_expect_success "rename succeeded" "test_cmp expect .git/config"
 
 cat >> .git/config << EOF
   [branch "zwei"] a = 1 [branch "vier"]
@@ -465,7 +465,7 @@ weird
 EOF
 
 test_expect_success "section was removed properly" \
-	"git diff -u expect .git/config"
+	"test_cmp expect .git/config"
 
 rm .git/config
 
diff --git a/t/t1303-wacky-config.sh b/t/t1303-wacky-config.sh
index f366b53..f98f4c5 100755
--- a/t/t1303-wacky-config.sh
+++ b/t/t1303-wacky-config.sh
@@ -11,7 +11,7 @@ setup() {
 check() {
 	echo "$2" >expected
 	git config --get "$1" >actual
-	git diff actual expected
+	test_cmp actual expected
 }
 
 test_expect_success 'modify same key' '
diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt.sh
index 762af5f..d24a47d 100755
--- a/t/t1502-rev-parse-parseopt.sh
+++ b/t/t1502-rev-parse-parseopt.sh
@@ -37,7 +37,7 @@ C?        option C with an optional argument
 Extras
 extra1    line above used to cause a segfault but no longer does
 EOF
-	git diff expect.err output.err
+	test_cmp expect.err output.err
 '
 
 test_done
diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-others-exclude.sh
index 55f057c..1caeaca 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -65,7 +65,7 @@ test_expect_success \
        --exclude-per-directory=.gitignore \
        --exclude-from=.git/ignore \
        >output &&
-     git diff expect output'
+     test_cmp expect output'
 
 # Test \r\n (MSDOS-like systems)
 printf '*.1\r\n/*.3\r\n!*.6\r\n' >.gitignore
@@ -77,7 +77,7 @@ test_expect_success \
        --exclude-per-directory=.gitignore \
        --exclude-from=.git/ignore \
        >output &&
-     git diff expect output'
+     test_cmp expect output'
 
 cat > excludes-file << EOF
 *.[1-8]
diff --git a/t/t3002-ls-files-dashpath.sh b/t/t3002-ls-files-dashpath.sh
index 8687a01..8704b04 100755
--- a/t/t3002-ls-files-dashpath.sh
+++ b/t/t3002-ls-files-dashpath.sh
@@ -23,7 +23,7 @@ test_expect_success \
 test_expect_success \
     'git ls-files without path restriction.' \
     'git ls-files --others >output &&
-     git diff output - <<EOF
+     test_cmp output - <<EOF
 --
 -foo
 output
@@ -34,7 +34,7 @@ EOF
 test_expect_success \
     'git ls-files with path restriction.' \
     'git ls-files --others path0 >output &&
-	git diff output - <<EOF
+	test_cmp output - <<EOF
 path0
 EOF
 '
@@ -42,7 +42,7 @@ EOF
 test_expect_success \
     'git ls-files with path restriction with --.' \
     'git ls-files --others -- path0 >output &&
-	git diff output - <<EOF
+	test_cmp output - <<EOF
 path0
 EOF
 '
@@ -50,7 +50,7 @@ EOF
 test_expect_success \
     'git ls-files with path restriction with -- --.' \
     'git ls-files --others -- -- >output &&
-	git diff output - <<EOF
+	test_cmp output - <<EOF
 --
 EOF
 '
@@ -58,7 +58,7 @@ EOF
 test_expect_success \
     'git ls-files with no path restriction.' \
     'git ls-files --others -- >output &&
-	git diff output - <<EOF
+	test_cmp output - <<EOF
 --
 -foo
 output
diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
index 607f57f..aff3603 100755
--- a/t/t3030-merge-recursive.sh
+++ b/t/t3030-merge-recursive.sh
@@ -43,7 +43,7 @@ test_expect_success 'setup 1' '
 		echo "100644 $o0 0	c"
 		echo "100644 $o1 0	d/e"
 	) >expected &&
-	git diff -u expected actual
+	test_cmp expected actual
 '
 
 test_expect_success 'setup 2' '
@@ -61,7 +61,7 @@ test_expect_success 'setup 2' '
 		echo "100644 $o0 0	c"
 		echo "100644 $o0 0	d/e"
 	) >expected &&
-	git diff -u expected actual &&
+	test_cmp expected actual &&
 
 	echo goodbye >>a &&
 	o2=$(git hash-object a) &&
@@ -82,7 +82,7 @@ test_expect_success 'setup 2' '
 		echo "100644 $o0 0	c"
 		echo "100644 $o0 0	d/e"
 	) >expected &&
-	git diff -u expected actual
+	test_cmp expected actual
 '
 
 test_expect_success 'setup 3' '
@@ -100,7 +100,7 @@ test_expect_success 'setup 3' '
 		echo "100644 $o0 0	c"
 		echo "100644 $o0 0	d/e"
 	) >expected &&
-	git diff -u expected actual &&
+	test_cmp expected actual &&
 
 	rm -f b && mkdir b && echo df-1 >b/c && git add b/c &&
 	o3=$(git hash-object b/c) &&
@@ -119,7 +119,7 @@ test_expect_success 'setup 3' '
 		echo "100644 $o0 0	c"
 		echo "100644 $o0 0	d/e"
 	) >expected &&
-	git diff -u expected actual
+	test_cmp expected actual
 '
 
 test_expect_success 'setup 4' '
@@ -137,7 +137,7 @@ test_expect_success 'setup 4' '
 		echo "100644 $o0 0	c"
 		echo "100644 $o0 0	d/e"
 	) >expected &&
-	git diff -u expected actual &&
+	test_cmp expected actual &&
 
 	rm -f a && mkdir a && echo df-2 >a/c && git add a/c &&
 	o4=$(git hash-object a/c) &&
@@ -156,7 +156,7 @@ test_expect_success 'setup 4' '
 		echo "100644 $o0 0	c"
 		echo "100644 $o0 0	d/e"
 	) >expected &&
-	git diff -u expected actual
+	test_cmp expected actual
 '
 
 test_expect_success 'setup 5' '
@@ -174,7 +174,7 @@ test_expect_success 'setup 5' '
 		echo "100644 $o0 0	c"
 		echo "100644 $o0 0	d/e"
 	) >expected &&
-	git diff -u expected actual &&
+	test_cmp expected actual &&
 
 	rm -f b &&
 	echo remove-conflict >a &&
@@ -195,7 +195,7 @@ test_expect_success 'setup 5' '
 		echo "100644 $o0 0	c"
 		echo "100644 $o0 0	d/e"
 	) >expected &&
-	git diff -u expected actual
+	test_cmp expected actual
 
 '
 
@@ -214,7 +214,7 @@ test_expect_success 'setup 6' '
 		echo "100644 $o0 0	c"
 		echo "100644 $o0 0	d/e"
 	) >expected &&
-	git diff -u expected actual &&
+	test_cmp expected actual &&
 
 	rm -fr d && echo df-3 >d && git add d &&
 	o6=$(git hash-object d) &&
@@ -233,7 +233,7 @@ test_expect_success 'setup 6' '
 		echo "100644 $o0 0	c"
 		echo "100644 $o6 0	d"
 	) >expected &&
-	git diff -u expected actual
+	test_cmp expected actual
 '
 
 test_expect_success 'merge-recursive simple' '
@@ -265,7 +265,7 @@ test_expect_success 'merge-recursive result' '
 		echo "100644 $o0 0	c"
 		echo "100644 $o1 0	d/e"
 	) >expected &&
-	git diff -u expected actual
+	test_cmp expected actual
 
 '
 
@@ -297,7 +297,7 @@ test_expect_success 'merge-recursive remove conflict' '
 		echo "100644 $o0 0	c"
 		echo "100644 $o1 0	d/e"
 	) >expected &&
-	git diff -u expected actual
+	test_cmp expected actual
 
 '
 
@@ -318,7 +318,7 @@ test_expect_success 'merge-recursive result' '
 		echo "100644 $o0 0	c"
 		echo "100644 $o1 0	d/e"
 	) >expected &&
-	git diff -u expected actual
+	test_cmp expected actual
 
 '
 
@@ -352,7 +352,7 @@ test_expect_success 'merge-recursive d/f conflict result' '
 		echo "100644 $o0 0	c"
 		echo "100644 $o1 0	d/e"
 	) >expected &&
-	git diff -u expected actual
+	test_cmp expected actual
 
 '
 
@@ -386,7 +386,7 @@ test_expect_success 'merge-recursive d/f conflict result the other way' '
 		echo "100644 $o0 0	c"
 		echo "100644 $o1 0	d/e"
 	) >expected &&
-	git diff -u expected actual
+	test_cmp expected actual
 
 '
 
@@ -420,7 +420,7 @@ test_expect_success 'merge-recursive d/f conflict result' '
 		echo "100644 $o0 1	d/e"
 		echo "100644 $o1 2	d/e"
 	) >expected &&
-	git diff -u expected actual
+	test_cmp expected actual
 
 '
 
@@ -454,7 +454,7 @@ test_expect_success 'merge-recursive d/f conflict result' '
 		echo "100644 $o0 1	d/e"
 		echo "100644 $o1 3	d/e"
 	) >expected &&
-	git diff -u expected actual
+	test_cmp expected actual
 
 '
 
@@ -480,7 +480,7 @@ test_expect_success 'reset and bind merge' '
 		echo "100644 $o0 0	c"
 		echo "100644 $o1 0	d/e"
 	) >expected &&
-	git diff -u expected actual &&
+	test_cmp expected actual &&
 
 	git read-tree --prefix=a1/ master &&
 	git ls-files -s >actual &&
@@ -498,7 +498,7 @@ test_expect_success 'reset and bind merge' '
 		echo "100644 $o0 0	c"
 		echo "100644 $o1 0	d/e"
 	) >expected &&
-	git diff -u expected actual
+	test_cmp expected actual
 
 	git read-tree --prefix=z/ master &&
 	git ls-files -s >actual &&
@@ -520,7 +520,7 @@ test_expect_success 'reset and bind merge' '
 		echo "100644 $o0 0	z/c"
 		echo "100644 $o1 0	z/d/e"
 	) >expected &&
-	git diff -u expected actual
+	test_cmp expected actual
 
 '
 
diff --git a/t/t3040-subprojects-basic.sh b/t/t3040-subprojects-basic.sh
index 79b9f23..f6973e9 100755
--- a/t/t3040-subprojects-basic.sh
+++ b/t/t3040-subprojects-basic.sh
@@ -24,7 +24,7 @@ test_expect_success 'create subprojects' \
     git add sub2 &&
     git commit -q -m "subprojects added" &&
     git diff-tree --abbrev=5 HEAD^ HEAD |cut -d" " -f-3,5- >current &&
-    git diff expected current'
+    test_cmp expected current'
 
 git branch save HEAD
 
@@ -62,7 +62,7 @@ test_expect_success 'check if clone works' \
     'git ls-files -s >expected &&
     git clone -l -s . cloned &&
     ( cd cloned && git ls-files -s ) >current &&
-    git diff expected current'
+    test_cmp expected current'
 
 test_expect_success 'removing and adding subproject' \
     'git update-index --force-remove -- sub2 &&
diff --git a/t/t3100-ls-tree-restrict.sh b/t/t3100-ls-tree-restrict.sh
index 46427e3..6e6a254 100755
--- a/t/t3100-ls-tree-restrict.sh
+++ b/t/t3100-ls-tree-restrict.sh
@@ -35,7 +35,7 @@ _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
 _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
 test_output () {
     sed -e "s/ $_x40	/ X	/" <current >check
-    git diff expected check
+    test_cmp expected check
 }
 
 test_expect_success \
diff --git a/t/t3101-ls-tree-dirname.sh b/t/t3101-ls-tree-dirname.sh
index 70f9ce9..4dd7d12 100755
--- a/t/t3101-ls-tree-dirname.sh
+++ b/t/t3101-ls-tree-dirname.sh
@@ -43,7 +43,7 @@ _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
 _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
 test_output () {
     sed -e "s/ $_x40	/ X	/" <current >check
-    git diff expected check
+    test_cmp expected check
 }
 
 test_expect_success \
diff --git a/t/t3300-funny-names.sh b/t/t3300-funny-names.sh
index 24a00a9..0574ef1 100755
--- a/t/t3300-funny-names.sh
+++ b/t/t3300-funny-names.sh
@@ -35,7 +35,7 @@ no-funny' >expected
 test_expect_success 'git ls-files no-funny' \
 	'git update-index --add "$p0" "$p2" &&
 	git ls-files >current &&
-	git diff expected current'
+	test_cmp expected current'
 
 t0=`git write-tree`
 echo "$t0" >t0
@@ -48,14 +48,14 @@ EOF
 test_expect_success 'git ls-files with-funny' \
 	'git update-index --add "$p1" &&
 	git ls-files >current &&
-	git diff expected current'
+	test_cmp expected current'
 
 echo 'just space
 no-funny
 tabs	," (dq) and spaces' >expected
 test_expect_success 'git ls-files -z with-funny' \
 	'git ls-files -z | perl -pe y/\\000/\\012/ >current &&
-	git diff expected current'
+	test_cmp expected current'
 
 t1=`git write-tree`
 echo "$t1" >t1
@@ -67,28 +67,28 @@ no-funny
 EOF
 test_expect_success 'git ls-tree with funny' \
 	'git ls-tree -r $t1 | sed -e "s/^[^	]*	//" >current &&
-	 git diff expected current'
+	 test_cmp expected current'
 
 cat > expected <<\EOF
 A	"tabs\t,\" (dq) and spaces"
 EOF
 test_expect_success 'git diff-index with-funny' \
 	'git diff-index --name-status $t0 >current &&
-	git diff expected current'
+	test_cmp expected current'
 
 test_expect_success 'git diff-tree with-funny' \
 	'git diff-tree --name-status $t0 $t1 >current &&
-	git diff expected current'
+	test_cmp expected current'
 
 echo 'A
 tabs	," (dq) and spaces' >expected
 test_expect_success 'git diff-index -z with-funny' \
 	'git diff-index -z --name-status $t0 | perl -pe y/\\000/\\012/ >current &&
-	git diff expected current'
+	test_cmp expected current'
 
 test_expect_success 'git diff-tree -z with-funny' \
 	'git diff-tree -z --name-status $t0 $t1 | perl -pe y/\\000/\\012/ >current &&
-	git diff expected current'
+	test_cmp expected current'
 
 cat > expected <<\EOF
 CNUM	no-funny	"tabs\t,\" (dq) and spaces"
@@ -96,7 +96,7 @@ EOF
 test_expect_success 'git diff-tree -C with-funny' \
 	'git diff-tree -C --find-copies-harder --name-status \
 		$t0 $t1 | sed -e 's/^C[0-9]*/CNUM/' >current &&
-	git diff expected current'
+	test_cmp expected current'
 
 cat > expected <<\EOF
 RNUM	no-funny	"tabs\t,\" (dq) and spaces"
@@ -105,7 +105,7 @@ test_expect_success 'git diff-tree delete with-funny' \
 	'git update-index --force-remove "$p0" &&
 	git diff-index -M --name-status \
 		$t0 | sed -e 's/^R[0-9]*/RNUM/' >current &&
-	git diff expected current'
+	test_cmp expected current'
 
 cat > expected <<\EOF
 diff --git a/no-funny "b/tabs\t,\" (dq) and spaces"
@@ -116,7 +116,7 @@ EOF
 test_expect_success 'git diff-tree delete with-funny' \
 	'git diff-index -M -p $t0 |
 	 sed -e "s/index [0-9]*%/index NUM%/" >current &&
-	 git diff expected current'
+	 test_cmp expected current'
 
 chmod +x "$p1"
 cat > expected <<\EOF
@@ -130,7 +130,7 @@ EOF
 test_expect_success 'git diff-tree delete with-funny' \
 	'git diff-index -M -p $t0 |
 	 sed -e "s/index [0-9]*%/index NUM%/" >current &&
-	 git diff expected current'
+	 test_cmp expected current'
 
 cat >expected <<\EOF
  "tabs\t,\" (dq) and spaces"
@@ -139,7 +139,7 @@ EOF
 test_expect_success 'git diff-tree rename with-funny applied' \
 	'git diff-index -M -p $t0 |
 	 git apply --stat | sed -e "s/|.*//" -e "s/ *\$//" >current &&
-	 git diff expected current'
+	 test_cmp expected current'
 
 cat > expected <<\EOF
  no-funny
@@ -149,12 +149,12 @@ EOF
 test_expect_success 'git diff-tree delete with-funny applied' \
 	'git diff-index -p $t0 |
 	 git apply --stat | sed -e "s/|.*//" -e "s/ *\$//" >current &&
-	 git diff expected current'
+	 test_cmp expected current'
 
 test_expect_success 'git apply non-git diff' \
 	'git diff-index -p $t0 |
 	 sed -ne "/^[-+@]/p" |
 	 git apply --stat | sed -e "s/|.*//" -e "s/ *\$//" >current &&
-	 git diff expected current'
+	 test_cmp expected current'
 
 test_done
diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
index 94b1c24..883281d 100755
--- a/t/t3900-i18n-commit.sh
+++ b/t/t3900-i18n-commit.sh
@@ -9,7 +9,7 @@ test_description='commit and log output encodings'
 
 compare_with () {
 	git show -s $1 | sed -e '1,/^$/d' -e 's/^    //' >current &&
-	git diff current "$2"
+	test_cmp current "$2"
 }
 
 test_expect_success setup '
diff --git a/t/t4006-diff-mode.sh b/t/t4006-diff-mode.sh
index ab5406d..4e92fce 100755
--- a/t/t4006-diff-mode.sh
+++ b/t/t4006-diff-mode.sh
@@ -38,6 +38,6 @@ echo ":100644 100755 X X M	rezrov" >expected
 
 test_expect_success \
     'verify' \
-    'git diff expected check'
+    'test_cmp expected check'
 
 test_done
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 6b4d1c5..4c038cc 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -112,7 +112,7 @@ do
 		} >"$actual" &&
 		if test -f "$expect"
 		then
-			git diff "$expect" "$actual" &&
+			test_cmp "$expect" "$actual" &&
 			rm -f "$actual"
 		else
 			# this is to help developing new tests.
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index b2b7a8d..3583e68 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -226,7 +226,7 @@ test_expect_success 'shortlog of cover-letter wraps overly-long onelines' '
 
 	git format-patch --cover-letter -2 &&
 	sed -e "1,/A U Thor/d" -e "/^$/q" < 0000-cover-letter.patch > output &&
-	git diff expect output
+	test_cmp expect output
 
 '
 
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 83c54b7..ca0302f 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -43,13 +43,13 @@ index adf3937..6edc172 100644
 EOF
 
 git diff > out
-test_expect_success "Ray's example without options" 'git diff expect out'
+test_expect_success "Ray's example without options" 'test_cmp expect out'
 
 git diff -w > out
-test_expect_success "Ray's example with -w" 'git diff expect out'
+test_expect_success "Ray's example with -w" 'test_cmp expect out'
 
 git diff -b > out
-test_expect_success "Ray's example with -b" 'git diff expect out'
+test_expect_success "Ray's example with -b" 'test_cmp expect out'
 
 tr 'Q' '\015' << EOF > x
 whitespace at beginning
@@ -90,14 +90,14 @@ index d99af23..8b32fb5 100644
 +CR at end
 EOF
 git diff > out
-test_expect_success 'another test, without options' 'git diff expect out'
+test_expect_success 'another test, without options' 'test_cmp expect out'
 
 cat << EOF > expect
 diff --git a/x b/x
 index d99af23..8b32fb5 100644
 EOF
 git diff -w > out
-test_expect_success 'another test, with -w' 'git diff expect out'
+test_expect_success 'another test, with -w' 'test_cmp expect out'
 
 tr 'Q' '\015' << EOF > expect
 diff --git a/x b/x
@@ -115,7 +115,7 @@ index d99af23..8b32fb5 100644
  CR at endQ
 EOF
 git diff -b > out
-test_expect_success 'another test, with -b' 'git diff expect out'
+test_expect_success 'another test, with -b' 'test_cmp expect out'
 
 test_expect_success 'check mixed spaces and tabs in indent' '
 
diff --git a/t/t4016-diff-quote.sh b/t/t4016-diff-quote.sh
index 5dbdc0c..0950250 100755
--- a/t/t4016-diff-quote.sh
+++ b/t/t4016-diff-quote.sh
@@ -49,7 +49,7 @@ cat >expect <<\EOF
 EOF
 test_expect_success 'git diff --summary -M HEAD' '
 	git diff --summary -M HEAD >actual &&
-	git diff expect actual
+	test_cmp expect actual
 '
 
 cat >expect <<\EOF
@@ -64,7 +64,7 @@ cat >expect <<\EOF
 EOF
 test_expect_success 'git diff --stat -M HEAD' '
 	git diff --stat -M HEAD >actual &&
-	git diff expect actual
+	test_cmp expect actual
 '
 
 test_done
diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index f9db81d..6d3ef6c 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -33,13 +33,13 @@ EOF
 sed 's/beer\\/beer,\\/' < Beer.java > Beer-correct.java
 
 test_expect_success 'default behaviour' '
-	git diff Beer.java Beer-correct.java |
+	git diff --no-index Beer.java Beer-correct.java |
 	grep "^@@.*@@ public class Beer"
 '
 
 test_expect_success 'preset java pattern' '
 	echo "*.java diff=java" >.gitattributes &&
-	git diff Beer.java Beer-correct.java |
+	git diff --no-index Beer.java Beer-correct.java |
 	grep "^@@.*@@ public static void main("
 '
 
@@ -48,13 +48,13 @@ git config diff.java.funcname '!static
 [^ 	].*s.*'
 
 test_expect_success 'custom pattern' '
-	git diff Beer.java Beer-correct.java |
+	git diff --no-index Beer.java Beer-correct.java |
 	grep "^@@.*@@ int special;$"
 '
 
 test_expect_success 'last regexp must not be negated' '
 	git config diff.java.funcname "!static" &&
-	! git diff Beer.java Beer-correct.java
+	! git diff --no-index Beer.java Beer-correct.java
 '
 
 test_done
diff --git a/t/t4100-apply-stat.sh b/t/t4100-apply-stat.sh
index 435f65b..8073a5a 100755
--- a/t/t4100-apply-stat.sh
+++ b/t/t4100-apply-stat.sh
@@ -11,36 +11,36 @@ test_description='git apply --stat --summary test.
 test_expect_success \
     'rename' \
     'git apply --stat --summary <../t4100/t-apply-1.patch >current &&
-    git diff ../t4100/t-apply-1.expect current'
+    test_cmp ../t4100/t-apply-1.expect current'
 
 test_expect_success \
     'copy' \
     'git apply --stat --summary <../t4100/t-apply-2.patch >current &&
-    git diff ../t4100/t-apply-2.expect current'
+    test_cmp ../t4100/t-apply-2.expect current'
 
 test_expect_success \
     'rewrite' \
     'git apply --stat --summary <../t4100/t-apply-3.patch >current &&
-    git diff ../t4100/t-apply-3.expect current'
+    test_cmp ../t4100/t-apply-3.expect current'
 
 test_expect_success \
     'mode' \
     'git apply --stat --summary <../t4100/t-apply-4.patch >current &&
-    git diff ../t4100/t-apply-4.expect current'
+    test_cmp ../t4100/t-apply-4.expect current'
 
 test_expect_success \
     'non git' \
     'git apply --stat --summary <../t4100/t-apply-5.patch >current &&
-    git diff ../t4100/t-apply-5.expect current'
+    test_cmp ../t4100/t-apply-5.expect current'
 
 test_expect_success \
     'non git' \
     'git apply --stat --summary <../t4100/t-apply-6.patch >current &&
-    git diff ../t4100/t-apply-6.expect current'
+    test_cmp ../t4100/t-apply-6.expect current'
 
 test_expect_success \
     'non git' \
     'git apply --stat --summary <../t4100/t-apply-7.patch >current &&
-    git diff ../t4100/t-apply-7.expect current'
+    test_cmp ../t4100/t-apply-7.expect current'
 
 test_done
diff --git a/t/t4104-apply-boundary.sh b/t/t4104-apply-boundary.sh
index 43943ab..e7e2913 100755
--- a/t/t4104-apply-boundary.sh
+++ b/t/t4104-apply-boundary.sh
@@ -90,7 +90,7 @@ do
 				cat '"$kind-patch.$with"'
 				(exit 1)
 			} &&
-			git diff '"$kind"'-expect victim
+			test_cmp '"$kind"'-expect victim
 		'
 	done
 done
@@ -108,7 +108,7 @@ do
 			cat '"$kind-ng.without"'
 			(exit 1)
 		} &&
-		git diff '"$kind"'-expect victim
+		test_cmp '"$kind"'-expect victim
 	'
 done
 
diff --git a/t/t4115-apply-symlink.sh b/t/t4115-apply-symlink.sh
index a07ff42..9ace578 100755
--- a/t/t4115-apply-symlink.sh
+++ b/t/t4115-apply-symlink.sh
@@ -33,7 +33,7 @@ test_expect_success 'apply symlink patch' '
 	git checkout side &&
 	git apply patch &&
 	git diff-files -p >patched &&
-	git diff patch patched
+	test_cmp patch patched
 
 '
 
@@ -42,7 +42,7 @@ test_expect_success 'apply --index symlink patch' '
 	git checkout -f side &&
 	git apply --index patch &&
 	git diff-index --cached -p HEAD >patched &&
-	git diff patch patched
+	test_cmp patch patched
 
 '
 
diff --git a/t/t4116-apply-reverse.sh b/t/t4116-apply-reverse.sh
index c3f4579..1459a90 100755
--- a/t/t4116-apply-reverse.sh
+++ b/t/t4116-apply-reverse.sh
@@ -42,7 +42,7 @@ test_expect_success 'apply in reverse' '
 	git reset --hard second &&
 	git apply --reverse --binary --index patch &&
 	git diff >diff &&
-	git diff /dev/null diff
+	test_cmp /dev/null diff
 
 '
 
diff --git a/t/t4117-apply-reject.sh b/t/t4117-apply-reject.sh
index 659e17c..e9ccd16 100755
--- a/t/t4117-apply-reject.sh
+++ b/t/t4117-apply-reject.sh
@@ -54,7 +54,7 @@ test_expect_success 'apply without --reject should fail' '
 		exit 1
 	fi
 
-	git diff file1 saved.file1
+	test_cmp file1 saved.file1
 '
 
 test_expect_success 'apply without --reject should fail' '
@@ -65,7 +65,7 @@ test_expect_success 'apply without --reject should fail' '
 		exit 1
 	fi
 
-	git diff file1 saved.file1
+	test_cmp file1 saved.file1
 '
 
 test_expect_success 'apply with --reject should fail but update the file' '
@@ -79,7 +79,7 @@ test_expect_success 'apply with --reject should fail but update the file' '
 		exit 1
 	fi
 
-	git diff file1 expected &&
+	test_cmp file1 expected &&
 
 	cat file1.rej &&
 
@@ -105,7 +105,7 @@ test_expect_success 'apply with --reject should fail but update the file' '
 		echo "file1 still exists?"
 		exit 1
 	}
-	git diff file2 expected &&
+	test_cmp file2 expected &&
 
 	cat file2.rej &&
 
@@ -132,7 +132,7 @@ test_expect_success 'the same test with --verbose' '
 		echo "file1 still exists?"
 		exit 1
 	}
-	git diff file2 expected &&
+	test_cmp file2 expected &&
 
 	cat file2.rej &&
 
@@ -151,7 +151,7 @@ test_expect_success 'apply cleanly with --verbose' '
 
 	git apply --verbose patch.1 &&
 
-	git diff file1 clean
+	test_cmp file1 clean
 '
 
 test_done
diff --git a/t/t4118-apply-empty-context.sh b/t/t4118-apply-empty-context.sh
index 1d531ca..f92e259 100755
--- a/t/t4118-apply-empty-context.sh
+++ b/t/t4118-apply-empty-context.sh
@@ -38,7 +38,7 @@ test_expect_success 'apply --numstat' '
 		echo "0	1	file1" &&
 		echo "0	1	file2"
 	} >expect &&
-	git diff expect actual
+	test_cmp expect actual
 
 '
 
@@ -48,8 +48,8 @@ test_expect_success 'apply --apply' '
 	cat file2.orig >file2 &&
 	git update-index file1 file2 &&
 	git apply --index diff.output &&
-	git diff file1.mods file1 &&
-	git diff file2.mods file2
+	test_cmp file1.mods file1 &&
+	test_cmp file2.mods file2
 '
 
 test_done
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 3cbfee7..85d7e3e 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -101,7 +101,7 @@ cat > expect << EOF
 EOF
 git rerere diff > out
 
-test_expect_success 'rerere diff' 'git diff expect out'
+test_expect_success 'rerere diff' 'test_cmp expect out'
 
 cat > expect << EOF
 a1
@@ -109,7 +109,7 @@ EOF
 
 git rerere status > out
 
-test_expect_success 'rerere status' 'git diff expect out'
+test_expect_success 'rerere status' 'test_cmp expect out'
 
 test_expect_success 'commit succeeds' \
 	"git commit -q -a -m 'prefer first over second'"
@@ -126,7 +126,7 @@ test_expect_success 'another conflicting merge' '
 git show first:a1 | sed 's/To die: t/To die! T/' > expect
 test_expect_success 'rerere kicked in' "! grep ======= a1"
 
-test_expect_success 'rerere prefers first change' 'git diff a1 expect'
+test_expect_success 'rerere prefers first change' 'test_cmp a1 expect'
 
 rm $rr/postimage
 echo "$sha1	a1" | perl -pe 'y/\012/\000/' > .git/rr-cache/MERGE_RR
diff --git a/t/t5305-include-tag.sh b/t/t5305-include-tag.sh
index 0db2754..fb471a0 100755
--- a/t/t5305-include-tag.sh
+++ b/t/t5305-include-tag.sh
@@ -50,7 +50,7 @@ test_expect_success 'check unpacked result (have commit, no tag)' '
 		test_must_fail git cat-file -e $tag &&
 		git rev-list --objects $commit
 	) >list.actual &&
-	git diff list.expect list.actual
+	test_cmp list.expect list.actual
 '
 
 rm -rf clone.git
@@ -78,7 +78,7 @@ test_expect_success 'check unpacked result (have commit, have tag)' '
 		export GIT_DIR &&
 		git rev-list --objects $tag
 	) >list.actual &&
-	git diff list.expect list.actual
+	test_cmp list.expect list.actual
 '
 
 test_done
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 2b6b6e3..68c2ae6 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -110,7 +110,7 @@ test_expect_success \
 	cd .. &&
 	git update-ref refs/heads/master master^ || return 1
 	git-send-pack --force ./victim/.git/ master && return 1
-	! git diff .git/refs/heads/master victim/.git/refs/heads/master
+	! test_cmp .git/refs/heads/master victim/.git/refs/heads/master
 '
 
 test_expect_success \
diff --git a/t/t5401-update-hooks.sh b/t/t5401-update-hooks.sh
index 9a12024..2fff300 100755
--- a/t/t5401-update-hooks.sh
+++ b/t/t5401-update-hooks.sh
@@ -83,23 +83,23 @@ test_expect_success 'hooks ran' '
 test_expect_success 'pre-receive hook input' '
 	(echo $commit0 $commit1 refs/heads/master;
 	 echo $commit1 $commit0 refs/heads/tofail
-	) | git diff - victim/.git/pre-receive.stdin
+	) | test_cmp - victim/.git/pre-receive.stdin
 '
 
 test_expect_success 'update hook arguments' '
 	(echo refs/heads/master $commit0 $commit1;
 	 echo refs/heads/tofail $commit1 $commit0
-	) | git diff - victim/.git/update.args
+	) | test_cmp - victim/.git/update.args
 '
 
 test_expect_success 'post-receive hook input' '
 	echo $commit0 $commit1 refs/heads/master |
-	git diff - victim/.git/post-receive.stdin
+	test_cmp - victim/.git/post-receive.stdin
 '
 
 test_expect_success 'post-update hook arguments' '
 	echo refs/heads/master |
-	git diff - victim/.git/post-update.args
+	test_cmp - victim/.git/post-update.args
 '
 
 test_expect_success 'all hook stdin is /dev/null' '
@@ -130,7 +130,7 @@ STDERR post-update
 EOF
 test_expect_success 'send-pack stderr contains hook messages' '
 	grep ^STD send.err >actual &&
-	git diff - actual <expect
+	test_cmp - actual <expect
 '
 
 test_done
diff --git a/t/t5503-tagfollow.sh b/t/t5503-tagfollow.sh
index 86e5b9b..4074e23 100755
--- a/t/t5503-tagfollow.sh
+++ b/t/t5503-tagfollow.sh
@@ -50,7 +50,7 @@ test_expect_success 'fetch A (new commit : 1 connection)' '
 	) &&
 	test -s $U &&
 	cut -d" " -f1,2 $U >actual &&
-	git diff expect actual
+	test_cmp expect actual
 '
 
 test_expect_success "create tag T on A, create C on branch cat" '
@@ -82,7 +82,7 @@ test_expect_success 'fetch C, T (new branch, tag : 1 connection)' '
 	) &&
 	test -s $U &&
 	cut -d" " -f1,2 $U >actual &&
-	git diff expect actual
+	test_cmp expect actual
 '
 
 test_expect_success "create commits O, B, tag S on B" '
@@ -118,7 +118,7 @@ test_expect_success 'fetch B, S (commit and tag : 1 connection)' '
 	) &&
 	test -s $U &&
 	cut -d" " -f1,2 $U >actual &&
-	git diff expect actual
+	test_cmp expect actual
 '
 
 cat - <<EOF >expect
@@ -144,7 +144,7 @@ test_expect_success 'new clone fetch master and tags' '
 	) &&
 	test -s $U &&
 	cut -d" " -f1,2 $U >actual &&
-	git diff expect actual
+	test_cmp expect actual
 '
 
 test_done
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 48ff2d4..a37b6f5 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -135,7 +135,7 @@ test_expect_success 'show' '
 	 git config --add remote.origin.push \
 		+refs/tags/lastbackup &&
 	 git remote show origin > output &&
-	 git diff expect output)
+	 test_cmp expect output)
 '
 
 test_expect_success 'prune' '
@@ -179,7 +179,7 @@ test_expect_success 'update' '
 	 git remote add apis ../mirror &&
 	 git remote update &&
 	 git branch -r > output &&
-	 git diff expect output)
+	 test_cmp expect output)
 
 '
 
@@ -206,7 +206,7 @@ test_expect_success 'update with arguments' '
 	 git config remotes.titanus manduca &&
 	 git remote update phobaeticus titanus &&
 	 git branch -r > output &&
-	 git diff expect output)
+	 test_cmp expect output)
 
 '
 
@@ -229,7 +229,7 @@ test_expect_success 'update default' '
 	 git config remote.drosophila.skipDefaultUpdate true &&
 	 git remote update default &&
 	 git branch -r > output &&
-	 git diff expect output)
+	 test_cmp expect output)
 
 '
 
@@ -249,7 +249,7 @@ test_expect_success 'update default (overridden, with funny whitespace)' '
 	 git config remotes.default "$(printf "\t drosophila  \n")" &&
 	 git remote update default &&
 	 git branch -r > output &&
-	 git diff expect output)
+	 test_cmp expect output)
 
 '
 
diff --git a/t/t5515-fetch-merge-logic.sh b/t/t5515-fetch-merge-logic.sh
index 65c3774..3def75e 100755
--- a/t/t5515-fetch-merge-logic.sh
+++ b/t/t5515-fetch-merge-logic.sh
@@ -151,7 +151,7 @@ do
 		git show-ref >"$actual_r" &&
 		if test -f "$expect_f"
 		then
-			git diff -u "$expect_f" "$actual_f" &&
+			test_cmp "$expect_f" "$actual_f" &&
 			rm -f "$actual_f"
 		else
 			# this is to help developing new tests.
@@ -160,7 +160,7 @@ do
 		fi &&
 		if test -f "$expect_r"
 		then
-			git diff -u "$expect_r" "$actual_r" &&
+			test_cmp "$expect_r" "$actual_r" &&
 			rm -f "$actual_r"
 		else
 			# this is to help developing new tests.
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index 0dc915e..9176484 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -15,7 +15,7 @@ test_format() {
 	cat >expect.$1
 	test_expect_success "format $1" "
 git rev-list --pretty=format:$2 master >output.$1 &&
-git diff expect.$1 output.$1
+test_cmp expect.$1 output.$1
 "
 }
 
diff --git a/t/t6023-merge-file.sh b/t/t6023-merge-file.sh
index 79dc58b..74e9e66 100755
--- a/t/t6023-merge-file.sh
+++ b/t/t6023-merge-file.sh
@@ -63,7 +63,7 @@ test_expect_success "merge without conflict (missing LF at EOF)" \
 	"git merge-file test2.txt orig.txt new2.txt"
 
 test_expect_success "merge result added missing LF" \
-	"git diff test.txt test2.txt"
+	"test_cmp test.txt test2.txt"
 
 cp test.txt backup.txt
 test_expect_success "merge with conflicts" \
@@ -86,7 +86,7 @@ non timebo mala, quoniam tu mecum es:
 virga tua et baculus tuus ipsa me consolata sunt.
 EOF
 
-test_expect_success "expected conflict markers" "git diff test.txt expect.txt"
+test_expect_success "expected conflict markers" "test_cmp test.txt expect.txt"
 
 cp backup.txt test.txt
 test_expect_success "merge with conflicts, using -L" \
@@ -110,7 +110,7 @@ virga tua et baculus tuus ipsa me consolata sunt.
 EOF
 
 test_expect_success "expected conflict markers, with -L" \
-	"git diff test.txt expect.txt"
+	"test_cmp test.txt expect.txt"
 
 sed "s/ tu / TU /" < new1.txt > new5.txt
 test_expect_success "conflict in removed tail" \
@@ -132,7 +132,7 @@ virga tua et baculus tuus ipsa me consolata sunt.
 >>>>>>> new5.txt
 EOF
 
-test_expect_success "expected conflict markers" "git diff expect out"
+test_expect_success "expected conflict markers" "test_cmp expect out"
 
 test_expect_success 'binary files cannot be merged' '
 	! git merge-file -p orig.txt ../test4012.png new1.txt 2> merge.err &&
diff --git a/t/t6024-recursive-merge.sh b/t/t6024-recursive-merge.sh
index 23d24d3..6a6a130 100755
--- a/t/t6024-recursive-merge.sh
+++ b/t/t6024-recursive-merge.sh
@@ -70,7 +70,7 @@ G
 >>>>>>> G:a1
 EOF
 
-test_expect_success "result contains a conflict" "git diff expect a1"
+test_expect_success "result contains a conflict" "test_cmp expect a1"
 
 git ls-files --stage > out
 cat > expect << EOF
@@ -79,7 +79,7 @@ cat > expect << EOF
 100644 fd7923529855d0b274795ae3349c5e0438333979 3	a1
 EOF
 
-test_expect_success "virtual trees were processed" "git diff expect out"
+test_expect_success "virtual trees were processed" "test_cmp expect out"
 
 test_expect_success 'refuse to merge binary files' '
 	git reset --hard &&
diff --git a/t/t6029-merge-subtree.sh b/t/t6029-merge-subtree.sh
index 43f5459..5bbfa44 100755
--- a/t/t6029-merge-subtree.sh
+++ b/t/t6029-merge-subtree.sh
@@ -57,7 +57,7 @@ test_expect_success 'initial merge' '
 		echo "100644 $o1 0	git-gui/git-gui.sh"
 		echo "100644 $o2 0	git.c"
 	) >expected &&
-	git diff -u expected actual
+	test_cmp expected actual
 '
 
 test_expect_success 'merge update' '
@@ -73,7 +73,7 @@ test_expect_success 'merge update' '
 		echo "100644 $o3 0	git-gui/git-gui.sh"
 		echo "100644 $o2 0	git.c"
 	) >expected &&
-	git diff -u expected actual
+	test_cmp expected actual
 '
 
 test_done
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 56bbd85..ea476a2 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -108,7 +108,7 @@ warning: tag 'A' is really 'Q' here
 EOF
 check_describe A-* HEAD
 test_expect_success 'warning was displayed for Q' '
-	git diff err.expect err.actual
+	test_cmp err.expect err.actual
 '
 test_expect_success 'rename tag Q back to A' '
 	mv .git/refs/tags/Q .git/refs/tags/A
diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index c9bf6fd..bc74349 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -79,7 +79,7 @@ test_expect_success 'merge-msg test #1' '
 	git fetch . left &&
 
 	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
-	git diff actual expected
+	test_cmp expected actual
 '
 
 cat >expected <<EOF
@@ -92,7 +92,7 @@ test_expect_success 'merge-msg test #2' '
 	git fetch ../"$test" left &&
 
 	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
-	git diff actual expected
+	test_cmp expected actual
 '
 
 cat >expected <<\EOF
@@ -117,7 +117,7 @@ test_expect_success 'merge-msg test #3-1' '
 	git fetch . left &&
 
 	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
-	git diff actual expected
+	test_cmp expected actual
 '
 
 test_expect_success 'merge-msg test #3-2' '
@@ -131,7 +131,7 @@ test_expect_success 'merge-msg test #3-2' '
 	git fetch . left &&
 
 	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
-	git diff actual expected
+	test_cmp expected actual
 '
 
 cat >expected <<\EOF
@@ -163,7 +163,7 @@ test_expect_success 'merge-msg test #4-1' '
 	git fetch . left right &&
 
 	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
-	git diff actual expected
+	test_cmp expected actual
 '
 
 test_expect_success 'merge-msg test #4-2' '
@@ -177,7 +177,7 @@ test_expect_success 'merge-msg test #4-2' '
 	git fetch . left right &&
 
 	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
-	git diff actual expected
+	test_cmp expected actual
 '
 
 test_expect_success 'merge-msg test #5-1' '
@@ -191,7 +191,7 @@ test_expect_success 'merge-msg test #5-1' '
 	git fetch . left right &&
 
 	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
-	git diff actual expected
+	test_cmp expected actual
 '
 
 test_expect_success 'merge-msg test #5-2' '
@@ -205,7 +205,7 @@ test_expect_success 'merge-msg test #5-2' '
 	git fetch . left right &&
 
 	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
-	git diff actual expected
+	test_cmp expected actual
 '
 
 test_done
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index f46ec93..91ea85d 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -75,14 +75,14 @@ EOF
 test_expect_success 'Check unformatted date fields output' '
 	(git for-each-ref --shell --format="%(refname) %(committerdate) %(authordate)" refs/heads &&
 	git for-each-ref --shell --format="%(refname) %(taggerdate)" refs/tags) >actual &&
-	git diff expected actual
+	test_cmp expected actual
 '
 
 test_expect_success 'Check format "default" formatted date fields output' '
 	f=default &&
 	(git for-each-ref --shell --format="%(refname) %(committerdate:$f) %(authordate:$f)" refs/heads &&
 	git for-each-ref --shell --format="%(refname) %(taggerdate:$f)" refs/tags) >actual &&
-	git diff expected actual
+	test_cmp expected actual
 '
 
 # Don't know how to do relative check because I can't know when this script
@@ -109,7 +109,7 @@ test_expect_success 'Check format "short" date fields output' '
 	f=short &&
 	(git for-each-ref --shell --format="%(refname) %(committerdate:$f) %(authordate:$f)" refs/heads &&
 	git for-each-ref --shell --format="%(refname) %(taggerdate:$f)" refs/tags) >actual &&
-	git diff expected actual
+	test_cmp expected actual
 '
 
 cat >expected <<\EOF
@@ -121,7 +121,7 @@ test_expect_success 'Check format "local" date fields output' '
 	f=local &&
 	(git for-each-ref --shell --format="%(refname) %(committerdate:$f) %(authordate:$f)" refs/heads &&
 	git for-each-ref --shell --format="%(refname) %(taggerdate:$f)" refs/tags) >actual &&
-	git diff expected actual
+	test_cmp expected actual
 '
 
 cat >expected <<\EOF
@@ -133,7 +133,7 @@ test_expect_success 'Check format "iso8601" date fields output' '
 	f=iso8601 &&
 	(git for-each-ref --shell --format="%(refname) %(committerdate:$f) %(authordate:$f)" refs/heads &&
 	git for-each-ref --shell --format="%(refname) %(taggerdate:$f)" refs/tags) >actual &&
-	git diff expected actual
+	test_cmp expected actual
 '
 
 cat >expected <<\EOF
@@ -145,7 +145,7 @@ test_expect_success 'Check format "rfc2822" date fields output' '
 	f=rfc2822 &&
 	(git for-each-ref --shell --format="%(refname) %(committerdate:$f) %(authordate:$f)" refs/heads &&
 	git for-each-ref --shell --format="%(refname) %(taggerdate:$f)" refs/tags) >actual &&
-	git diff expected actual
+	test_cmp expected actual
 '
 
 cat >expected <<\EOF
@@ -155,7 +155,7 @@ EOF
 
 test_expect_success 'Verify ascending sort' '
 	git-for-each-ref --format="%(refname)" --sort=refname >actual &&
-	git diff expected actual
+	test_cmp expected actual
 '
 
 
@@ -166,7 +166,7 @@ EOF
 
 test_expect_success 'Verify descending sort' '
 	git-for-each-ref --format="%(refname)" --sort=-refname >actual &&
-	git diff expected actual
+	test_cmp expected actual
 '
 
 cat >expected <<\EOF
@@ -176,17 +176,17 @@ EOF
 
 test_expect_success 'Quoting style: shell' '
 	git for-each-ref --shell --format="%(refname)" >actual &&
-	git diff expected actual
+	test_cmp expected actual
 '
 
 test_expect_success 'Quoting style: perl' '
 	git for-each-ref --perl --format="%(refname)" >actual &&
-	git diff expected actual
+	test_cmp expected actual
 '
 
 test_expect_success 'Quoting style: python' '
 	git for-each-ref --python --format="%(refname)" >actual &&
-	git diff expected actual
+	test_cmp expected actual
 '
 
 cat >expected <<\EOF
@@ -196,7 +196,7 @@ EOF
 
 test_expect_success 'Quoting style: tcl' '
 	git for-each-ref --tcl --format="%(refname)" >actual &&
-	git diff expected actual
+	test_cmp expected actual
 '
 
 for i in "--perl --shell" "-s --python" "--python --tcl" "--tcl --perl"; do
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 1639c7a..1e8a205 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -224,7 +224,7 @@ test_expect_success 'Tag name filtering retains tag message' '
 	git cat-file tag T > expect &&
 	git filter-branch -f --tag-name-filter cat &&
 	git cat-file tag T > actual &&
-	git diff expect actual
+	test_cmp expect actual
 '
 
 faux_gpg_tag='object XXXXXX
@@ -248,7 +248,7 @@ test_expect_success 'Tag name filtering strips gpg signature' '
 	echo "$faux_gpg_tag" | sed -e s/XXXXXX/$sha1/ | head -n 6 > expect &&
 	git filter-branch -f --tag-name-filter cat &&
 	git cat-file tag S > actual &&
-	git diff expect actual
+	test_cmp expect actual
 '
 
 test_done
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 2dcee7c..241c70d 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -116,9 +116,9 @@ mytag
 EOF
 test_expect_success \
 	'trying to delete tags without params should succeed and do nothing' '
-	git tag -l > actual && git diff expect actual &&
+	git tag -l > actual && test_cmp expect actual &&
 	git-tag -d &&
-	git tag -l > actual && git diff expect actual
+	git tag -l > actual && test_cmp expect actual
 '
 
 test_expect_success \
@@ -173,9 +173,9 @@ test_expect_success 'listing all tags should print them ordered' '
 	git tag v1.0 &&
 	git tag t210 &&
 	git tag -l > actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 	git tag > actual &&
-	git diff expect actual
+	test_cmp expect actual
 '
 
 cat >expect <<EOF
@@ -186,7 +186,7 @@ EOF
 test_expect_success \
 	'listing tags with substring as pattern must print those matching' '
 	git-tag -l "*a*" > actual &&
-	git diff expect actual
+	test_cmp expect actual
 '
 
 cat >expect <<EOF
@@ -196,7 +196,7 @@ EOF
 test_expect_success \
 	'listing tags with a suffix as pattern must print those matching' '
 	git-tag -l "*.1" > actual &&
-	git diff expect actual
+	test_cmp expect actual
 '
 
 cat >expect <<EOF
@@ -206,7 +206,7 @@ EOF
 test_expect_success \
 	'listing tags with a prefix as pattern must print those matching' '
 	git-tag -l "t21*" > actual &&
-	git diff expect actual
+	test_cmp expect actual
 '
 
 cat >expect <<EOF
@@ -215,7 +215,7 @@ EOF
 test_expect_success \
 	'listing tags using a name as pattern must print that one matching' '
 	git-tag -l a1 > actual &&
-	git diff expect actual
+	test_cmp expect actual
 '
 
 cat >expect <<EOF
@@ -224,7 +224,7 @@ EOF
 test_expect_success \
 	'listing tags using a name as pattern must print that one matching' '
 	git-tag -l v1.0 > actual &&
-	git diff expect actual
+	test_cmp expect actual
 '
 
 cat >expect <<EOF
@@ -234,14 +234,14 @@ EOF
 test_expect_success \
 	'listing tags with ? in the pattern should print those matching' '
 	git-tag -l "v1.?.?" > actual &&
-	git diff expect actual
+	test_cmp expect actual
 '
 
 >expect
 test_expect_success \
 	'listing tags using v.* should print nothing because none have v.' '
 	git-tag -l "v.*" > actual &&
-	git diff expect actual
+	test_cmp expect actual
 '
 
 cat >expect <<EOF
@@ -253,7 +253,7 @@ EOF
 test_expect_success \
 	'listing tags using v* should print only those having v' '
 	git-tag -l "v*" > actual &&
-	git diff expect actual
+	test_cmp expect actual
 '
 
 # creating and verifying lightweight tags:
@@ -302,7 +302,7 @@ test_expect_success \
 	'creating an annotated tag with -m message should succeed' '
 	git-tag -m "A message" annotated-tag &&
 	get_tag_msg annotated-tag >actual &&
-	git diff expect actual
+	test_cmp expect actual
 '
 
 cat >msgfile <<EOF
@@ -315,7 +315,7 @@ test_expect_success \
 	'creating an annotated tag with -F messagefile should succeed' '
 	git-tag -F msgfile file-annotated-tag &&
 	get_tag_msg file-annotated-tag >actual &&
-	git diff expect actual
+	test_cmp expect actual
 '
 
 cat >inputmsg <<EOF
@@ -327,7 +327,7 @@ cat inputmsg >>expect
 test_expect_success 'creating an annotated tag with -F - should succeed' '
 	git-tag -F - stdin-annotated-tag <inputmsg &&
 	get_tag_msg stdin-annotated-tag >actual &&
-	git diff expect actual
+	test_cmp expect actual
 '
 
 test_expect_success \
@@ -358,7 +358,7 @@ test_expect_success \
 	'creating a tag with an empty -m message should succeed' '
 	git-tag -m "" empty-annotated-tag &&
 	get_tag_msg empty-annotated-tag >actual &&
-	git diff expect actual
+	test_cmp expect actual
 '
 
 >emptyfile
@@ -367,7 +367,7 @@ test_expect_success \
 	'creating a tag with an empty -F messagefile should succeed' '
 	git-tag -F emptyfile emptyfile-annotated-tag &&
 	get_tag_msg emptyfile-annotated-tag >actual &&
-	git diff expect actual
+	test_cmp expect actual
 '
 
 printf '\n\n  \n\t\nLeading blank lines\n' >blanksfile
@@ -388,7 +388,7 @@ test_expect_success \
 	'extra blanks in the message for an annotated tag should be removed' '
 	git-tag -F blanksfile blanks-annotated-tag &&
 	get_tag_msg blanks-annotated-tag >actual &&
-	git diff expect actual
+	test_cmp expect actual
 '
 
 get_tag_header blank-annotated-tag $commit commit $time >expect
@@ -396,7 +396,7 @@ test_expect_success \
 	'creating a tag with blank -m message with spaces should succeed' '
 	git-tag -m "     " blank-annotated-tag &&
 	get_tag_msg blank-annotated-tag >actual &&
-	git diff expect actual
+	test_cmp expect actual
 '
 
 echo '     ' >blankfile
@@ -407,7 +407,7 @@ test_expect_success \
 	'creating a tag with blank -F messagefile with spaces should succeed' '
 	git-tag -F blankfile blankfile-annotated-tag &&
 	get_tag_msg blankfile-annotated-tag >actual &&
-	git diff expect actual
+	test_cmp expect actual
 '
 
 printf '      ' >blanknonlfile
@@ -416,7 +416,7 @@ test_expect_success \
 	'creating a tag with -F file of spaces and no newline should succeed' '
 	git-tag -F blanknonlfile blanknonlfile-annotated-tag &&
 	get_tag_msg blanknonlfile-annotated-tag >actual &&
-	git diff expect actual
+	test_cmp expect actual
 '
 
 # messages with commented lines:
@@ -451,7 +451,7 @@ test_expect_success \
 	'creating a tag using a -F messagefile with #comments should succeed' '
 	git-tag -F commentsfile comments-annotated-tag &&
 	get_tag_msg comments-annotated-tag >actual &&
-	git diff expect actual
+	test_cmp expect actual
 '
 
 get_tag_header comment-annotated-tag $commit commit $time >expect
@@ -459,7 +459,7 @@ test_expect_success \
 	'creating a tag with a #comment in the -m message should succeed' '
 	git-tag -m "#comment" comment-annotated-tag &&
 	get_tag_msg comment-annotated-tag >actual &&
-	git diff expect actual
+	test_cmp expect actual
 '
 
 echo '#comment' >commentfile
@@ -470,7 +470,7 @@ test_expect_success \
 	'creating a tag with #comments in the -F messagefile should succeed' '
 	git-tag -F commentfile commentfile-annotated-tag &&
 	get_tag_msg commentfile-annotated-tag >actual &&
-	git diff expect actual
+	test_cmp expect actual
 '
 
 printf '#comment' >commentnonlfile
@@ -479,7 +479,7 @@ test_expect_success \
 	'creating a tag with a file of #comment and no newline should succeed' '
 	git-tag -F commentnonlfile commentnonlfile-annotated-tag &&
 	get_tag_msg commentnonlfile-annotated-tag >actual &&
-	git diff expect actual
+	test_cmp expect actual
 '
 
 # listing messages for annotated non-signed tags:
@@ -490,23 +490,23 @@ test_expect_success \
 
 	echo "tag-one-line" >expect &&
 	git-tag -l | grep "^tag-one-line" >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 	git-tag -n0 -l | grep "^tag-one-line" >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 	git-tag -n0 -l tag-one-line >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 
 	echo "tag-one-line    A msg" >expect &&
 	git-tag -n1 -l | grep "^tag-one-line" >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 	git-tag -n -l | grep "^tag-one-line" >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 	git-tag -n1 -l tag-one-line >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 	git-tag -n2 -l tag-one-line >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 	git-tag -n999 -l tag-one-line >actual &&
-	git diff expect actual
+	test_cmp expect actual
 '
 
 test_expect_success \
@@ -515,23 +515,23 @@ test_expect_success \
 
 	echo "tag-zero-lines" >expect &&
 	git-tag -l | grep "^tag-zero-lines" >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 	git-tag -n0 -l | grep "^tag-zero-lines" >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 	git-tag -n0 -l tag-zero-lines >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 
 	echo "tag-zero-lines  " >expect &&
 	git-tag -n1 -l | grep "^tag-zero-lines" >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 	git-tag -n -l | grep "^tag-zero-lines" >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 	git-tag -n1 -l tag-zero-lines >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 	git-tag -n2 -l tag-zero-lines >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 	git-tag -n999 -l tag-zero-lines >actual &&
-	git diff expect actual
+	test_cmp expect actual
 '
 
 echo 'tag line one' >annotagmsg
@@ -543,39 +543,39 @@ test_expect_success \
 
 	echo "tag-lines" >expect &&
 	git-tag -l | grep "^tag-lines" >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 	git-tag -n0 -l | grep "^tag-lines" >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 	git-tag -n0 -l tag-lines >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 
 	echo "tag-lines       tag line one" >expect &&
 	git-tag -n1 -l | grep "^tag-lines" >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 	git-tag -n -l | grep "^tag-lines" >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 	git-tag -n1 -l tag-lines >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 
 	echo "    tag line two" >>expect &&
 	git-tag -n2 -l | grep "^ *tag.line" >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 	git-tag -n2 -l tag-lines >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 
 	echo "    tag line three" >>expect &&
 	git-tag -n3 -l | grep "^ *tag.line" >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 	git-tag -n3 -l tag-lines >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 	git-tag -n4 -l | grep "^ *tag.line" >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 	git-tag -n4 -l tag-lines >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 	git-tag -n99 -l | grep "^ *tag.line" >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 	git-tag -n99 -l tag-lines >actual &&
-	git diff expect actual
+	test_cmp expect actual
 '
 
 # subsequent tests require gpg; check if it is available
@@ -635,7 +635,7 @@ echo '-----BEGIN PGP SIGNATURE-----' >>expect
 test_expect_success 'creating a signed tag with -m message should succeed' '
 	git-tag -s -m "A signed tag message" signed-tag &&
 	get_tag_msg signed-tag >actual &&
-	git diff expect actual
+	test_cmp expect actual
 '
 
 get_tag_header u-signed-tag $commit commit $time >expect
@@ -645,7 +645,7 @@ test_expect_success 'sign with a given key id' '
 
 	git tag -u committer@example.com -m "Another message" u-signed-tag &&
 	get_tag_msg u-signed-tag >actual &&
-	git diff expect actual
+	test_cmp expect actual
 
 '
 
@@ -675,7 +675,7 @@ echo '-----BEGIN PGP SIGNATURE-----' >>expect
 test_expect_success '-u implies signed tag' '
 	GIT_EDITOR=./fakeeditor git-tag -u CDDE430D implied-sign &&
 	get_tag_msg implied-sign >actual &&
-	git diff expect actual
+	test_cmp expect actual
 '
 
 cat >sigmsgfile <<EOF
@@ -689,7 +689,7 @@ test_expect_success \
 	'creating a signed tag with -F messagefile should succeed' '
 	git-tag -s -F sigmsgfile file-signed-tag &&
 	get_tag_msg file-signed-tag >actual &&
-	git diff expect actual
+	test_cmp expect actual
 '
 
 cat >siginputmsg <<EOF
@@ -702,7 +702,7 @@ echo '-----BEGIN PGP SIGNATURE-----' >>expect
 test_expect_success 'creating a signed tag with -F - should succeed' '
 	git-tag -s -F - stdin-signed-tag <siginputmsg &&
 	get_tag_msg stdin-signed-tag >actual &&
-	git diff expect actual
+	test_cmp expect actual
 '
 
 get_tag_header implied-annotate $commit commit $time >expect
@@ -711,7 +711,7 @@ echo '-----BEGIN PGP SIGNATURE-----' >>expect
 test_expect_success '-s implies annotated tag' '
 	GIT_EDITOR=./fakeeditor git-tag -s implied-annotate &&
 	get_tag_msg implied-annotate >actual &&
-	git diff expect actual
+	test_cmp expect actual
 '
 
 test_expect_success \
@@ -752,7 +752,7 @@ test_expect_success \
 	'creating a signed tag with an empty -m message should succeed' '
 	git-tag -s -m "" empty-signed-tag &&
 	get_tag_msg empty-signed-tag >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 	git-tag -v empty-signed-tag
 '
 
@@ -763,7 +763,7 @@ test_expect_success \
 	'creating a signed tag with an empty -F messagefile should succeed' '
 	git-tag -s -F sigemptyfile emptyfile-signed-tag &&
 	get_tag_msg emptyfile-signed-tag >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 	git-tag -v emptyfile-signed-tag
 '
 
@@ -786,7 +786,7 @@ test_expect_success \
 	'extra blanks in the message for a signed tag should be removed' '
 	git-tag -s -F sigblanksfile blanks-signed-tag &&
 	get_tag_msg blanks-signed-tag >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 	git-tag -v blanks-signed-tag
 '
 
@@ -796,7 +796,7 @@ test_expect_success \
 	'creating a signed tag with a blank -m message should succeed' '
 	git-tag -s -m "     " blank-signed-tag &&
 	get_tag_msg blank-signed-tag >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 	git-tag -v blank-signed-tag
 '
 
@@ -809,7 +809,7 @@ test_expect_success \
 	'creating a signed tag with blank -F file with spaces should succeed' '
 	git-tag -s -F sigblankfile blankfile-signed-tag &&
 	get_tag_msg blankfile-signed-tag >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 	git-tag -v blankfile-signed-tag
 '
 
@@ -820,7 +820,7 @@ test_expect_success \
 	'creating a signed tag with spaces and no newline should succeed' '
 	git-tag -s -F sigblanknonlfile blanknonlfile-signed-tag &&
 	get_tag_msg blanknonlfile-signed-tag >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 	git-tag -v signed-tag
 '
 
@@ -857,7 +857,7 @@ test_expect_success \
 	'creating a signed tag with a -F file with #comments should succeed' '
 	git-tag -s -F sigcommentsfile comments-signed-tag &&
 	get_tag_msg comments-signed-tag >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 	git-tag -v comments-signed-tag
 '
 
@@ -867,7 +867,7 @@ test_expect_success \
 	'creating a signed tag with #commented -m message should succeed' '
 	git-tag -s -m "#comment" comment-signed-tag &&
 	get_tag_msg comment-signed-tag >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 	git-tag -v comment-signed-tag
 '
 
@@ -880,7 +880,7 @@ test_expect_success \
 	'creating a signed tag with #commented -F messagefile should succeed' '
 	git-tag -s -F sigcommentfile commentfile-signed-tag &&
 	get_tag_msg commentfile-signed-tag >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 	git-tag -v commentfile-signed-tag
 '
 
@@ -891,7 +891,7 @@ test_expect_success \
 	'creating a signed tag with a #comment and no newline should succeed' '
 	git-tag -s -F sigcommentnonlfile commentnonlfile-signed-tag &&
 	get_tag_msg commentnonlfile-signed-tag >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 	git-tag -v commentnonlfile-signed-tag
 '
 
@@ -903,23 +903,23 @@ test_expect_success \
 
 	echo "stag-one-line" >expect &&
 	git-tag -l | grep "^stag-one-line" >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 	git-tag -n0 -l | grep "^stag-one-line" >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 	git-tag -n0 -l stag-one-line >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 
 	echo "stag-one-line   A message line signed" >expect &&
 	git-tag -n1 -l | grep "^stag-one-line" >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 	git-tag -n -l | grep "^stag-one-line" >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 	git-tag -n1 -l stag-one-line >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 	git-tag -n2 -l stag-one-line >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 	git-tag -n999 -l stag-one-line >actual &&
-	git diff expect actual
+	test_cmp expect actual
 '
 
 test_expect_success \
@@ -928,23 +928,23 @@ test_expect_success \
 
 	echo "stag-zero-lines" >expect &&
 	git-tag -l | grep "^stag-zero-lines" >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 	git-tag -n0 -l | grep "^stag-zero-lines" >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 	git-tag -n0 -l stag-zero-lines >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 
 	echo "stag-zero-lines " >expect &&
 	git-tag -n1 -l | grep "^stag-zero-lines" >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 	git-tag -n -l | grep "^stag-zero-lines" >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 	git-tag -n1 -l stag-zero-lines >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 	git-tag -n2 -l stag-zero-lines >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 	git-tag -n999 -l stag-zero-lines >actual &&
-	git diff expect actual
+	test_cmp expect actual
 '
 
 echo 'stag line one' >sigtagmsg
@@ -956,39 +956,39 @@ test_expect_success \
 
 	echo "stag-lines" >expect &&
 	git-tag -l | grep "^stag-lines" >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 	git-tag -n0 -l | grep "^stag-lines" >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 	git-tag -n0 -l stag-lines >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 
 	echo "stag-lines      stag line one" >expect &&
 	git-tag -n1 -l | grep "^stag-lines" >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 	git-tag -n -l | grep "^stag-lines" >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 	git-tag -n1 -l stag-lines >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 
 	echo "    stag line two" >>expect &&
 	git-tag -n2 -l | grep "^ *stag.line" >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 	git-tag -n2 -l stag-lines >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 
 	echo "    stag line three" >>expect &&
 	git-tag -n3 -l | grep "^ *stag.line" >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 	git-tag -n3 -l stag-lines >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 	git-tag -n4 -l | grep "^ *stag.line" >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 	git-tag -n4 -l stag-lines >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 	git-tag -n99 -l | grep "^ *stag.line" >actual &&
-	git diff expect actual &&
+	test_cmp expect actual &&
 	git-tag -n99 -l stag-lines >actual &&
-	git diff expect actual
+	test_cmp expect actual
 '
 
 # tags pointing to objects different from commits:
@@ -1004,7 +1004,7 @@ test_expect_success \
 	'creating a signed tag pointing to a tree should succeed' '
 	git-tag -s -m "A message for a tree" tree-signed-tag HEAD^{tree} &&
 	get_tag_msg tree-signed-tag >actual &&
-	git diff expect actual
+	test_cmp expect actual
 '
 
 get_tag_header blob-signed-tag $blob blob $time >expect
@@ -1014,7 +1014,7 @@ test_expect_success \
 	'creating a signed tag pointing to a blob should succeed' '
 	git-tag -s -m "A message for a blob" blob-signed-tag HEAD:foo &&
 	get_tag_msg blob-signed-tag >actual &&
-	git diff expect actual
+	test_cmp expect actual
 '
 
 get_tag_header tag-signed-tag $tag tag $time >expect
@@ -1024,7 +1024,7 @@ test_expect_success \
 	'creating a signed tag pointing to another tag should succeed' '
 	git-tag -s -m "A message for another tag" tag-signed-tag signed-tag &&
 	get_tag_msg tag-signed-tag >actual &&
-	git diff expect actual
+	test_cmp expect actual
 '
 
 # try to sign with bad user.signingkey
@@ -1064,7 +1064,7 @@ test_expect_success \
 	git tag -a -m "An annotation to be reused" reuse &&
 	GIT_EDITOR=true git tag -f -a reuse &&
 	get_tag_msg reuse >actual &&
-	git diff expect actual
+	test_cmp expect actual
 '
 
 test_done
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index e5c9f30..39ba141 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -34,13 +34,13 @@ test_expect_success 'creating initial files and commits' '
 
 check_changes () {
 	test "$(git rev-parse HEAD)" = "$1" &&
-	git diff | git diff .diff_expect - &&
-	git diff --cached | git diff .cached_expect - &&
+	git diff | test_cmp .diff_expect - &&
+	git diff --cached | test_cmp .cached_expect - &&
 	for FILE in *
 	do
 		echo $FILE':'
 		cat $FILE || return
-	done | git diff .cat_expect -
+	done | test_cmp .cat_expect -
 }
 
 >.diff_expect
@@ -390,9 +390,9 @@ test_expect_success 'test --mixed <paths>' '
 	git add file1 file3 file4 &&
 	! git reset HEAD -- file1 file2 file3 &&
 	git diff > output &&
-	git diff output expect &&
+	test_cmp output expect &&
 	git diff --cached > output &&
-	git diff output cached_expect
+	test_cmp output cached_expect
 '
 
 test_expect_success 'test resetting the index at give paths' '
@@ -425,7 +425,7 @@ EOF
 test_expect_success '--mixed refreshes the index' '
 	echo 123 >> file2 &&
 	git reset --mixed HEAD > output &&
-	git diff --exit-code expect output
+	test_cmp expect output
 '
 
 test_done
diff --git a/t/t7502-status.sh b/t/t7502-status.sh
index e4bfcae..80a438d 100755
--- a/t/t7502-status.sh
+++ b/t/t7502-status.sh
@@ -63,7 +63,7 @@ EOF
 test_expect_success 'status (2)' '
 
 	git status > output &&
-	git diff expect output
+	test_cmp expect output
 
 '
 
@@ -93,7 +93,7 @@ EOF
 test_expect_success 'status with relative paths' '
 
 	(cd dir1 && git status) > output &&
-	git diff expect output
+	test_cmp expect output
 
 '
 
@@ -124,7 +124,7 @@ test_expect_success 'status without relative paths' '
 
 	git config status.relativePaths false
 	(cd dir1 && git status) > output &&
-	git diff expect output
+	test_cmp expect output
 
 '
 
diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index bdf29c1..242cdf0 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -169,7 +169,7 @@ test_expect_success "$name" '
 	svn up "$SVN_TREE" &&
 	test -f "$SVN_TREE"/exec-2.sh &&
 	test ! -L "$SVN_TREE"/exec-2.sh &&
-	git diff help "$SVN_TREE"/exec-2.sh'
+	test_cmp help "$SVN_TREE"/exec-2.sh'
 
 if test "$have_utf8" = t
 then
@@ -193,7 +193,7 @@ test_expect_success "$name" \
     'git-svn init "$svnrepo" && git-svn fetch &&
      git rev-list --pretty=raw remotes/git-svn | grep ^tree | uniq > a &&
      git rev-list --pretty=raw remotes/alt | grep ^tree | uniq > b &&
-     git diff a b'
+     test_cmp a b'
 
 name='check imported tree checksums expected tree checksums'
 rm -f expected
@@ -211,7 +211,7 @@ tree d667270a1f7b109f5eb3aaea21ede14b56bfdd6e
 tree 8f51f74cf0163afc9ad68a4b1537288c4558b5a4
 EOF
 
-test_expect_success "$name" "git diff a expected"
+test_expect_success "$name" "test_cmp a expected"
 
 test_expect_success 'exit if remote refs are ambigious' "
         git config --add svn-remote.svn.fetch \
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index c4f4465..5edf56f 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -74,7 +74,7 @@ EOF
 test_expect_success \
 	'A: verify commit' \
 	'git cat-file commit master | sed 1d >actual &&
-	git diff expect actual'
+	test_cmp expect actual'
 
 cat >expect <<EOF
 100644 blob file2
@@ -84,22 +84,22 @@ EOF
 test_expect_success \
 	'A: verify tree' \
 	'git cat-file -p master^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
-	 git diff expect actual'
+	 test_cmp expect actual'
 
 echo "$file2_data" >expect
 test_expect_success \
 	'A: verify file2' \
-	'git cat-file blob master:file2 >actual && git diff expect actual'
+	'git cat-file blob master:file2 >actual && test_cmp expect actual'
 
 echo "$file3_data" >expect
 test_expect_success \
 	'A: verify file3' \
-	'git cat-file blob master:file3 >actual && git diff expect actual'
+	'git cat-file blob master:file3 >actual && test_cmp expect actual'
 
 printf "$file4_data" >expect
 test_expect_success \
 	'A: verify file4' \
-	'git cat-file blob master:file4 >actual && git diff expect actual'
+	'git cat-file blob master:file4 >actual && test_cmp expect actual'
 
 cat >expect <<EOF
 :2 `git rev-parse --verify master:file2`
@@ -109,7 +109,7 @@ cat >expect <<EOF
 EOF
 test_expect_success \
 	'A: verify marks output' \
-	'git diff expect marks.out'
+	'test_cmp expect marks.out'
 
 test_expect_success \
 	'A: verify marks import' \
@@ -117,7 +117,7 @@ test_expect_success \
 		--import-marks=marks.out \
 		--export-marks=marks.new \
 		</dev/null &&
-	git diff -u expect marks.new'
+	test_cmp expect marks.new'
 
 test_tick
 cat >input <<INPUT_END
@@ -259,7 +259,7 @@ EOF
 test_expect_success \
 	'C: verify commit' \
 	'git cat-file commit branch | sed 1d >actual &&
-	 git diff expect actual'
+	 test_cmp expect actual'
 
 cat >expect <<EOF
 :000000 100755 0000000000000000000000000000000000000000 f1fb5da718392694d0076d677d6d0e364c79b0bc A	file2/newf
@@ -316,13 +316,13 @@ echo "$file5_data" >expect
 test_expect_success \
 	'D: verify file5' \
 	'git cat-file blob branch:newdir/interesting >actual &&
-	 git diff expect actual'
+	 test_cmp expect actual'
 
 echo "$file6_data" >expect
 test_expect_success \
 	'D: verify file6' \
 	'git cat-file blob branch:newdir/exec.sh >actual &&
-	 git diff expect actual'
+	 test_cmp expect actual'
 
 ###
 ### series E
@@ -358,7 +358,7 @@ EOF
 test_expect_success \
 	'E: verify commit' \
 	'git cat-file commit branch | sed 1,2d >actual &&
-	git diff expect actual'
+	test_cmp expect actual'
 
 ###
 ### series F
@@ -411,7 +411,7 @@ EOF
 test_expect_success \
 	'F: verify other commit' \
 	'git cat-file commit other >actual &&
-	git diff expect actual'
+	test_cmp expect actual'
 
 ###
 ### series G
@@ -489,7 +489,7 @@ echo "$file5_data" >expect
 test_expect_success \
 	'H: verify file' \
 	'git cat-file blob H:h/e/l/lo >actual &&
-	 git diff expect actual'
+	 test_cmp expect actual'
 
 ###
 ### series I
@@ -515,7 +515,7 @@ EOF
 test_expect_success \
 	'I: verify edge list' \
 	'sed -e s/pack-.*pack/pack-.pack/ edges.list >actual &&
-	 git diff expect actual'
+	 test_cmp expect actual'
 
 ###
 ### series J
@@ -625,7 +625,7 @@ test_expect_success \
     'L: verify internal tree sorting' \
 	'git-fast-import <input &&
 	 git diff-tree --abbrev --raw L^ L >output &&
-	 git diff expect output'
+	 test_cmp expect output'
 
 ###
 ### series M
@@ -885,7 +885,7 @@ test_expect_success \
 	 test 8 = `find .git/objects/pack -type f | wc -l` &&
 	 test `git rev-parse refs/tags/O3-2nd` = `git rev-parse O3^` &&
 	 git log --reverse --pretty=oneline O3 | sed s/^.*z// >actual &&
-	 git diff expect actual'
+	 test_cmp expect actual'
 
 cat >input <<INPUT_END
 commit refs/heads/O4
@@ -916,6 +916,6 @@ test_expect_success \
 	'O: progress outputs as requested by input' \
 	'git-fast-import <input >actual &&
 	 grep "progress " <input >expect &&
-	 git diff expect actual'
+	 test_cmp expect actual'
 
 test_done
diff --git a/t/t9600-cvsimport.sh b/t/t9600-cvsimport.sh
index 0b115a1..655f882 100755
--- a/t/t9600-cvsimport.sh
+++ b/t/t9600-cvsimport.sh
@@ -69,7 +69,7 @@ EOF
 test_expect_success 'import a trivial module' '
 
 	git cvsimport -a -z 0 -C module-git module &&
-	git diff module-cvs/o_fortuna module-git/o_fortuna
+	test_cmp module-cvs/o_fortuna module-git/o_fortuna
 
 '
 
@@ -110,7 +110,7 @@ test_expect_success 'update git module' '
 	git cvsimport -a -z 0 module &&
 	git merge origin &&
 	cd .. &&
-	git diff module-cvs/o_fortuna module-git/o_fortuna
+	test_cmp module-cvs/o_fortuna module-git/o_fortuna
 
 '
 
@@ -131,7 +131,7 @@ test_expect_success 'cvsimport.module config works' '
 		git cvsimport -a -z0 &&
 		git merge origin &&
 	cd .. &&
-	git diff module-cvs/tick module-git/tick
+	test_cmp module-cvs/tick module-git/tick
 
 '
 
@@ -142,7 +142,7 @@ test_expect_success 'import from a CVS working tree' '
 		git cvsimport -a -z0 &&
 		echo 1 >expect &&
 		git log -1 --pretty=format:%s%n >actual &&
-		git diff actual expect &&
+		test_cmp actual expect &&
 	cd ..
 
 '
