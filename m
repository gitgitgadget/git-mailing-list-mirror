From: "Pat Notz" <patnotz@gmail.com>
Subject: [PATCHv3 4/4] t7500: add tests of commit --squash
Date: Thu, 23 Sep 2010 10:23:17 -0600
Message-ID: <1285258997-12497-5-git-send-email-patnotz@gmail.com>
References: <1285258997-12497-1-git-send-email-patnotz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 23 18:23:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyoaE-0002KF-Ig
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 18:23:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755611Ab0IWQXi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Sep 2010 12:23:38 -0400
Received: from sentry-three.sandia.gov ([132.175.109.17]:51515 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755179Ab0IWQXe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Sep 2010 12:23:34 -0400
X-WSS-ID: 0L97K76-0C-7KH-02
X-M-MSG: 
Received: from sentry.sandia.gov (mm04snlnto.sandia.gov [132.175.109.21])
	by sentry-three.sandia.gov (Postfix) with ESMTP id 1C3A14F65E0
	for <git@vger.kernel.org>; Thu, 23 Sep 2010 10:23:30 -0600 (MDT)
Received: from [132.175.109.1] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.2)); Thu, 23 Sep 2010 10:23:21 -0600
X-Server-Uuid: AF72F651-81B1-4134-BA8C-A8E1A4E620FF
Received: from mail.sandia.gov (cas2.sandia.gov [134.253.165.160]) by
 mailgate.sandia.gov (8.14.4/8.14.4) with ESMTP id o8NGN7qO014459 for
 <git@vger.kernel.org>; Thu, 23 Sep 2010 10:23:11 -0600
Received: from s919422.srn.sandia.gov (134.253.71.44) by
 cas2.srn.sandia.gov (134.253.165.189) with Microsoft SMTP Server id
 8.2.254.0; Thu, 23 Sep 2010 10:23:16 -0600
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1285258997-12497-1-git-send-email-patnotz@gmail.com>
X-PMX-Version: 5.6.0.2009776, Antispam-Engine: 2.7.2.376379,
 Antispam-Data: 2010.9.23.161514
X-PMX-Spam: Gauge=IIIIIIII, Probability=8%, Report=' FORGED_FROM_GMAIL
 0.1, BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_2000_2999 0,
 BODY_SIZE_5000_LESS 0, BODY_SIZE_7000_LESS 0, DATE_TZ_NA 0, __CT 0,
 __CT_TEXT_PLAIN 0, __FRAUD_BODY_WEBMAIL 0, __FRAUD_WEBMAIL 0,
 __FRAUD_WEBMAIL_FROM 0, __FROM_GMAIL 0, __HAS_MSGID 0, __HAS_X_MAILER
 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __PHISH_SPEAR_STRUCTURE_1 0,
 __SANE_MSGID 0, __STOCK_PHRASE_7 0, __TO_MALFORMED_2 0, __TO_NO_NAME 0,
 __URI_NO_PATH 0, __URI_NO_WWW 0, __URI_NS '
X-TMWD-Spam-Summary: TS=20100923162324; ID=1; SEV=2.3.1;
 DFV=B2010090808; IFV=NA; AIF=B2010090808; RPD=5.03.0010; ENG=NA;
 RPDID=7374723D303030312E30413031303230332E34433942374546422E303134453A534346535441543838363133332C73733D312C6667733D30;
 CAT=NONE; CON=NONE; SIG=AAABAJsKIgAAAAAAAAAAAAAAAAAAAH0=
X-MMS-Spam-Filter-ID: B2010090808_5.03.0010
X-WSS-ID: 6085A17329K4559426-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156875>

Signed-off-by: Pat Notz <patnotz@gmail.com>
---
 t/t7500-commit.sh    |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 t/t7500/edit-content |    4 ++++
 2 files changed, 51 insertions(+), 0 deletions(-)
 create mode 100755 t/t7500/edit-content

diff --git a/t/t7500-commit.sh b/t/t7500-commit.sh
index 7656ed4..0f746d5 100755
--- a/t/t7500-commit.sh
+++ b/t/t7500-commit.sh
@@ -238,10 +238,57 @@ test_expect_success 'commit --fixup provides correct one-line commit message' '
 	commit_msg_is "fixup! target message subject line"
 '
 
+test_expect_success 'commit --squash works with -F' '
+	commit_for_rebase_autosquash_setup &&
+	echo "log message from file" >msgfile
+	git commit --squash HEAD~1 -F msgfile  &&
+	commit_msg_is "squash! target message subject linelog message from file"
+'
+
+test_expect_success 'commit --squash works with -m' '
+	commit_for_rebase_autosquash_setup &&
+	git commit --squash HEAD~1 -m "foo bar\nbaz" &&
+	commit_msg_is "squash! target message subject linefoo bar\nbaz"
+'
+
+test_expect_success 'commit --squash works with -C' '
+	commit_for_rebase_autosquash_setup &&
+	git commit --squash HEAD~1 -C HEAD &&
+	commit_msg_is "squash! target message subject lineintermediate commit"
+'
+
+test_expect_success 'commit --squash works with -c' '
+	commit_for_rebase_autosquash_setup &&
+	test_set_editor "$TEST_DIRECTORY"/t7500/edit-content &&
+	git commit --squash HEAD~1 -c HEAD &&
+	commit_msg_is "squash! target message subject lineedited commit"
+'
+
+test_expect_success 'commit --squash works with -C for same commit' '
+	commit_for_rebase_autosquash_setup &&
+	git commit --squash HEAD -C HEAD &&
+	commit_msg_is "squash! intermediate commit"
+'
+
+test_expect_success 'commit --squash works with -c for same commit' '
+	commit_for_rebase_autosquash_setup &&
+	test_set_editor "$TEST_DIRECTORY"/t7500/edit-content &&
+	git commit --squash HEAD -c HEAD &&
+	commit_msg_is "squash! edited commit"
+'
+
+test_expect_success 'commit --squash works with editor' '
+	commit_for_rebase_autosquash_setup &&
+	test_set_editor "$TEST_DIRECTORY"/t7500/add-content &&
+	git commit --squash HEAD~1 &&
+	commit_msg_is "squash! target message subject linecommit message"
+'
+
 test_expect_success 'invalid message options when using --fixup' '
 	echo changes >>foo &&
 	echo "message" >log &&
 	git add foo &&
+	test_must_fail git commit --fixup HEAD~1 --squash HEAD~2 &&
 	test_must_fail git commit --fixup HEAD~1 --C HEAD~2 &&
 	test_must_fail git commit --fixup HEAD~1 --c HEAD~2 &&
 	test_must_fail git commit --fixup HEAD~1 -m "cmdline message" &&
diff --git a/t/t7500/edit-content b/t/t7500/edit-content
new file mode 100755
index 0000000..08db9fd
--- /dev/null
+++ b/t/t7500/edit-content
@@ -0,0 +1,4 @@
+#!/bin/sh
+sed -e "s/intermediate/edited/g" <"$1" >"$1-"
+mv "$1-" "$1"
+exit 0
-- 
1.7.3
