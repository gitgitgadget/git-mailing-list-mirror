From: "Pat Notz" <patnotz@gmail.com>
Subject: [PATCHv7 4/6] add tests of commit --fixup
Date: Tue, 2 Nov 2010 13:59:10 -0600
Message-ID: <1288727952-57498-5-git-send-email-patnotz@gmail.com>
References: <1288727952-57498-1-git-send-email-patnotz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 02 21:00:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDN1d-0007yP-Bl
	for gcvg-git-2@lo.gmane.org; Tue, 02 Nov 2010 21:00:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752046Ab0KBT7j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Nov 2010 15:59:39 -0400
Received: from sentry-three.sandia.gov ([132.175.109.17]:39658 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612Ab0KBT7e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Nov 2010 15:59:34 -0400
X-WSS-ID: 0LB9WV5-0C-06E-02
X-M-MSG: 
Received: from sentry.sandia.gov (sentry.sandia.gov [132.175.109.21])
	by sentry-three.sandia.gov (Postfix) with ESMTP id 13B8A47FDBA
	for <git@vger.kernel.org>; Tue,  2 Nov 2010 13:59:27 -0600 (MDT)
Received: from [132.175.109.1] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.2)); Tue, 02 Nov 2010 13:59:19 -0600
X-Server-Uuid: 6BFC7783-7E22-49B4-B610-66D6BE496C0E
Received: from mail.sandia.gov (cas2.sandia.gov [134.253.165.160]) by
 mailgate.sandia.gov (8.14.4/8.14.4) with ESMTP id oA2Jx5mp000560 for
 <git@vger.kernel.org>; Tue, 2 Nov 2010 13:59:09 -0600
Received: from localhost.localdomain (134.253.98.198) by
 cas2.srn.sandia.gov (134.253.165.189) with Microsoft SMTP Server id
 8.2.254.0; Tue, 2 Nov 2010 13:59:14 -0600
X-Mailer: git-send-email 1.7.3.2
In-Reply-To: <1288727952-57498-1-git-send-email-patnotz@gmail.com>
X-PMX-Version: 5.6.0.2009776, Antispam-Engine: 2.7.2.376379,
 Antispam-Data: 2010.11.2.195116
X-PMX-Spam: Gauge=IIIIIIII, Probability=8%, Report=' FORGED_FROM_GMAIL
 0.1, BODY_SIZE_4000_4999 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_7000_LESS
 0, DATE_TZ_NA 0, __CT 0, __CT_TEXT_PLAIN 0, __FRAUD_BODY_WEBMAIL 0,
 __FRAUD_WEBMAIL 0, __FRAUD_WEBMAIL_FROM 0, __FROM_GMAIL 0, __HAS_MSGID
 0, __HAS_X_MAILER 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0,
 __PHISH_SPEAR_STRUCTURE_1 0, __SANE_MSGID 0, __STOCK_PHRASE_7 0,
 __TO_MALFORMED_2 0, __TO_NO_NAME 0, __URI_NO_PATH 0, __URI_NO_WWW 0,
 __URI_NS '
X-TMWD-Spam-Summary: TS=20101102195922; ID=1; SEV=2.3.1;
 DFV=B2010110219; IFV=NA; AIF=B2010110219; RPD=5.03.0010; ENG=NA;
 RPDID=7374723D303030312E30413031303230352E34434430364439422E303036383A534346535441543838363133332C73733D312C6667733D30;
 CAT=NONE; CON=NONE; SIG=AAABAJsKIgAAAAAAAAAAAAAAAAAAAH0=
X-MMS-Spam-Filter-ID: B2010110219_5.03.0010
X-WSS-ID: 60CEB21D3KK1977239-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160549>

t7500: test expected behavior of commit --fixup
t3415: test interaction of commit --fixup with rebase --autosquash
t3900: test commit --fixup with i18n encodings

Signed-off-by: Pat Notz <patnotz@gmail.com>
---
 t/t3415-rebase-autosquash.sh |   25 +++++++++++++++++++++++--
 t/t3900-i18n-commit.sh       |   27 +++++++++++++++++++++++++++
 t/t7500-commit.sh            |   33 +++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index fd2184c..b77a413 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -14,6 +14,7 @@ test_expect_success setup '
 	git add . &&
 	test_tick &&
 	git commit -m "first commit" &&
+	git tag first-commit &&
 	echo 3 >file3 &&
 	git add . &&
 	test_tick &&
@@ -21,7 +22,7 @@ test_expect_success setup '
 	git tag base
 '
 
-test_auto_fixup() {
+test_auto_fixup () {
 	git reset --hard base &&
 	echo 1 >file1 &&
 	git add -u &&
@@ -50,7 +51,7 @@ test_expect_success 'auto fixup (config)' '
 	test_must_fail test_auto_fixup final-fixup-config-false
 '
 
-test_auto_squash() {
+test_auto_squash () {
 	git reset --hard base &&
 	echo 1 >file1 &&
 	git add -u &&
@@ -94,4 +95,24 @@ test_expect_success 'misspelled auto squash' '
 	test 0 = $(git rev-list final-missquash...HEAD | wc -l)
 '
 
+test_auto_commit_flags () {
+	git reset --hard base &&
+	echo 1 >file1 &&
+	git add -u &&
+	test_tick &&
+	git commit --$1 first-commit &&
+	git tag final-commit-$1 &&
+	test_tick &&
+	git rebase --autosquash -i HEAD^^^ &&
+	git log --oneline >actual &&
+	test 3 = $(wc -l <actual) &&
+	git diff --exit-code final-commit-$1 &&
+	test 1 = "$(git cat-file blob HEAD^:file1)" &&
+	test $2 = $(git cat-file commit HEAD^ | grep first | wc -l)
+}
+
+test_expect_success 'use commit --fixup' '
+	test_auto_commit_flags fixup 1
+'
+
 test_done
diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
index 256c4c9..f4775ee 100755
--- a/t/t3900-i18n-commit.sh
+++ b/t/t3900-i18n-commit.sh
@@ -133,4 +133,31 @@ do
 	'
 done
 
+test_commit_autosquash_flags () {
+	H=$1
+	flag=$2
+	test_expect_success "commit --$flag with $H encoding" '
+		git config i18n.commitencoding $H &&
+		git checkout -b $H-$flag C0 &&
+		echo $H >>F &&
+		git commit -a -F "$TEST_DIRECTORY"/t3900/$H.txt &&
+		test_tick &&
+		echo intermediate stuff >>G &&
+		git add G &&
+		git commit -a -m "intermediate commit" &&
+		test_tick &&
+		echo $H $flag >>F &&
+		git commit -a --$flag HEAD~1 $3 &&
+		E=$(git cat-file commit '$H-$flag' |
+			sed -ne "s/^encoding //p") &&
+		test "z$E" = "z$H" &&
+		git config --unset-all i18n.commitencoding &&
+		git rebase --autosquash -i HEAD^^^ &&
+		git log --oneline >actual &&
+		test 3 = $(wc -l <actual)
+	'
+}
+
+test_commit_autosquash_flags eucJP fixup
+
 test_done
diff --git a/t/t7500-commit.sh b/t/t7500-commit.sh
index aa9c577..a41b819 100755
--- a/t/t7500-commit.sh
+++ b/t/t7500-commit.sh
@@ -215,4 +215,37 @@ test_expect_success 'Commit a message with --allow-empty-message' '
 	commit_msg_is "hello there"
 '
 
+commit_for_rebase_autosquash_setup () {
+	echo "first content line" >>foo &&
+	git add foo &&
+	cat >log <<EOF &&
+target message subject line
+
+target message body line 1
+target message body line 2
+EOF
+	git commit -F log &&
+	echo "second content line" >>foo &&
+	git add foo &&
+	git commit -m "intermediate commit" &&
+	echo "third content line" >>foo &&
+	git add foo
+}
+
+test_expect_success 'commit --fixup provides correct one-line commit message' '
+	commit_for_rebase_autosquash_setup &&
+	git commit --fixup HEAD~1 &&
+	commit_msg_is "fixup! target message subject line"
+'
+
+test_expect_success 'invalid message options when using --fixup' '
+	echo changes >>foo &&
+	echo "message" >log &&
+	git add foo &&
+	test_must_fail git commit --fixup HEAD~1 -C HEAD~2 &&
+	test_must_fail git commit --fixup HEAD~1 -c HEAD~2 &&
+	test_must_fail git commit --fixup HEAD~1 -m "cmdline message" &&
+	test_must_fail git commit --fixup HEAD~1 -F log
+'
+
 test_done
-- 
1.7.3.2
