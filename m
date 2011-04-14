From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] i18n: use test_i18n{grep,cmp} in t7508
Date: Thu, 14 Apr 2011 13:56:14 -0700
Message-ID: <7v1v14h7rl.fsf_-_@alter.siamese.dyndns.org>
References: <1302464048-21806-1-git-send-email-avarab@gmail.com>
 <1302464048-21806-2-git-send-email-avarab@gmail.com>
 <7v39lorli9.fsf@alter.siamese.dyndns.org>
 <7vy63gq6s2.fsf@alter.siamese.dyndns.org>
 <BANLkTincUmH7SjypXfDMXDfg8BxW4MW+Jg@mail.gmail.com>
 <7vsjtnpc0k.fsf@alter.siamese.dyndns.org>
 <7v62qjnkpe.fsf@alter.siamese.dyndns.org>
 <7v1v17nk9z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 22:56:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QATaa-0000qz-DD
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 22:56:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752651Ab1DNU40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2011 16:56:26 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35473 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543Ab1DNU4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2011 16:56:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 479E952C8;
	Thu, 14 Apr 2011 16:58:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zrM1njyrv42Fb5ndIBf/0nOR780=; b=eZr22C
	ENH3R8GPX8HINSALhdKYxXYLs3QWE2XI45yfBGA4pLJ8mMi8/Cn7vmZJPaxlvQLQ
	Pxd9YrdRFsI53lFzxKrnP4B0noZOCMKDFYoqIo0G6YiaBpdWYVd4ftxdiffdc1lh
	0DsD+OklJmVAoK2bK/gUqtWYKGlUWsi+zOOmQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LWnnHQtj0RUJjn8IVRQxz8GrKWf1EkPj
	3cpAJZTNBur+U5ma4iKy6OQidEX/Ti1JT1WPt+ydpf501D8cCz3BC3CEgqmT015V
	/CfoThsq3VbUzM5E8aqVrFm33UdMmJNzfr6AJ2iO+W1w5fGJf5b+yjegUZbDBPuv
	brQUhXKS5bY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1F43652C5;
	Thu, 14 Apr 2011 16:58:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7315B52C3; Thu, 14 Apr 2011
 16:58:15 -0400 (EDT)
In-Reply-To: <7v1v17nk9z.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 12 Apr 2011 16:04:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ECF077CE-66D9-11E0-91C6-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171550>

Two tests looked for "[Uu]sage" in the output, but we cannot expect the
l10n to use that phrase.  Mark them with test_i18ngrep so that in later
versions we can test truly localized versions with the same tests, not
just GETTEXT_POISON that happens to keep the original string in the
output.

Merge a few tests that were artificially split into "do" and "test output
under C_LOCALE_OUTPUT" in the original i18n patches back.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I've queued many others in 'pu' without sending them on the list, but
   this one is a bit different and can use extra sets of eyeballs, so...

 t/t7508-status.sh |  222 ++++++++++++++++++++++++-----------------------------
 1 files changed, 102 insertions(+), 120 deletions(-)

diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index a93e70f..cd6e2c5 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -16,7 +16,7 @@ test_expect_success 'status -h in broken repository' '
 		echo "[status] showuntrackedfiles = CORRUPT" >>.git/config &&
 		test_expect_code 129 git status -h >usage 2>&1
 	) &&
-	grep "[Uu]sage" broken/usage
+	test_i18ngrep "[Uu]sage" broken/usage
 '
 
 test_expect_success 'commit -h in broken repository' '
@@ -28,7 +28,7 @@ test_expect_success 'commit -h in broken repository' '
 		echo "[status] showuntrackedfiles = CORRUPT" >>.git/config &&
 		test_expect_code 129 git commit -h >usage 2>&1
 	) &&
-	grep "[Uu]sage" broken/usage
+	test_i18ngrep "[Uu]sage" broken/usage
 '
 
 test_expect_success 'setup' '
@@ -55,10 +55,8 @@ test_expect_success 'setup' '
 	git add dir2/added
 '
 
-test_expect_success C_LOCALE_OUTPUT 'status (1)' '
-
-	grep "use \"git rm --cached <file>\.\.\.\" to unstage" output
-
+test_expect_success 'status (1)' '
+	test_i18ngrep "use \"git rm --cached <file>\.\.\.\" to unstage" output
 '
 
 cat >expect <<\EOF
@@ -85,11 +83,9 @@ cat >expect <<\EOF
 #	untracked
 EOF
 
-test_expect_success C_LOCALE_OUTPUT 'status (2)' '
-
+test_expect_success 'status (2)' '
 	git status >output &&
-	test_cmp expect output
-
+	test_i18ncmp expect output
 '
 
 cat >expect <<\EOF
@@ -109,17 +105,14 @@ cat >expect <<\EOF
 #	untracked
 EOF
 
-git config advice.statusHints false
-
-test_expect_success C_LOCALE_OUTPUT 'status (advice.statusHints false)' '
-
+test_expect_success 'status (advice.statusHints false)' '
+	test_when_finished "git config --unset advice.statusHints" &&
+	git config advice.statusHints false &&
 	git status >output &&
-	test_cmp expect output
+	test_i18ncmp expect output
 
 '
 
-git config --unset advice.statusHints
-
 cat >expect <<\EOF
  M dir1/modified
 A  dir2/added
@@ -178,16 +171,16 @@ cat >expect <<EOF
 #
 # Untracked files not listed (use -u option to show untracked files)
 EOF
-test_expect_success C_LOCALE_OUTPUT 'status -uno' '
+test_expect_success 'status -uno' '
 	git status -uno >output &&
-	test_cmp expect output
+	test_i18ncmp expect output
 '
 
-test_expect_success C_LOCALE_OUTPUT 'status (status.showUntrackedFiles no)' '
+test_expect_success 'status (status.showUntrackedFiles no)' '
 	git config status.showuntrackedfiles no
 	test_when_finished "git config --unset status.showuntrackedfiles" &&
 	git status >output &&
-	test_cmp expect output
+	test_i18ncmp expect output
 '
 
 cat >expect <<EOF
@@ -201,9 +194,9 @@ cat >expect <<EOF
 # Untracked files not listed
 EOF
 git config advice.statusHints false
-test_expect_success C_LOCALE_OUTPUT 'status -uno (advice.statusHints false)' '
+test_expect_success 'status -uno (advice.statusHints false)' '
 	git status -uno >output &&
-	test_cmp expect output
+	test_i18ncmp expect output
 '
 git config --unset advice.statusHints
 
@@ -246,16 +239,16 @@ cat >expect <<EOF
 #	output
 #	untracked
 EOF
-test_expect_success C_LOCALE_OUTPUT 'status -unormal' '
+test_expect_success 'status -unormal' '
 	git status -unormal >output &&
-	test_cmp expect output
+	test_i18ncmp expect output
 '
 
-test_expect_success C_LOCALE_OUTPUT 'status (status.showUntrackedFiles normal)' '
+test_expect_success 'status (status.showUntrackedFiles normal)' '
 	git config status.showuntrackedfiles normal
 	test_when_finished "git config --unset status.showuntrackedfiles" &&
 	git status >output &&
-	test_cmp expect output
+	test_i18ncmp expect output
 '
 
 cat >expect <<EOF
@@ -305,15 +298,16 @@ cat >expect <<EOF
 #	output
 #	untracked
 EOF
-test_expect_success C_LOCALE_OUTPUT 'status -uall' '
+test_expect_success 'status -uall' '
 	git status -uall >output &&
-	test_cmp expect output
+	test_i18ncmp expect output
 '
-test_expect_success C_LOCALE_OUTPUT 'status (status.showUntrackedFiles all)' '
+
+test_expect_success 'status (status.showUntrackedFiles all)' '
 	git config status.showuntrackedfiles all
 	test_when_finished "git config --unset status.showuntrackedfiles" &&
 	git status >output &&
-	test_cmp expect output
+	test_i18ncmp expect output
 '
 
 test_expect_success 'teardown dir3' '
@@ -367,11 +361,9 @@ cat >expect <<\EOF
 #	../untracked
 EOF
 
-test_expect_success C_LOCALE_OUTPUT 'status with relative paths' '
-
+test_expect_success 'status with relative paths' '
 	(cd dir1 && git status) >output &&
-	test_cmp expect output
-
+	test_i18ncmp expect output
 '
 
 cat >expect <<\EOF
@@ -440,22 +432,18 @@ cat >expect <<\EOF
 #	<BLUE>untracked<RESET>
 EOF
 
-test_expect_success C_LOCALE_OUTPUT 'status with color.ui' '
-
+test_expect_success 'status with color.ui' '
 	git config color.ui always &&
 	test_when_finished "git config --unset color.ui" &&
 	git status | test_decode_color >output &&
-	test_cmp expect output
-
+	test_i18ncmp expect output
 '
 
-test_expect_success C_LOCALE_OUTPUT 'status with color.status' '
-
+test_expect_success 'status with color.status' '
 	git config color.status always &&
 	test_when_finished "git config --unset color.status" &&
 	git status | test_decode_color >output &&
-	test_cmp expect output
-
+	test_i18ncmp expect output
 '
 
 cat >expect <<\EOF
@@ -570,12 +558,12 @@ cat >expect <<\EOF
 EOF
 
 
-test_expect_success C_LOCALE_OUTPUT 'status without relative paths' '
+test_expect_success 'status without relative paths' '
 
 	git config status.relativePaths false &&
 	test_when_finished "git config --unset status.relativePaths" &&
 	(cd dir1 && git status) >output &&
-	test_cmp expect output
+	test_i18ncmp expect output
 
 '
 
@@ -616,11 +604,8 @@ cat <<EOF >expect
 #	untracked
 EOF
 test_expect_success 'dry-run of partial commit excluding new file in index' '
-	git commit --dry-run dir1/modified >output
-'
-
-test_expect_success C_LOCALE_OUTPUT 'dry-run of partial commit excluding new file in index: output' '
-	test_cmp expect output
+	git commit --dry-run dir1/modified >output &&
+	test_i18ncmp expect output
 '
 
 cat >expect <<EOF
@@ -667,15 +652,15 @@ cat >expect <<EOF
 #	output
 #	untracked
 EOF
-test_expect_success C_LOCALE_OUTPUT 'status submodule summary is disabled by default' '
+test_expect_success 'status submodule summary is disabled by default' '
 	git status >output &&
-	test_cmp expect output
+	test_i18ncmp expect output
 '
 
 # we expect the same as the previous test
-test_expect_success C_LOCALE_OUTPUT 'status --untracked-files=all does not show submodule' '
+test_expect_success 'status --untracked-files=all does not show submodule' '
 	git status --untracked-files=all >output &&
-	test_cmp expect output
+	test_i18ncmp expect output
 '
 
 cat >expect <<EOF
@@ -731,10 +716,10 @@ cat >expect <<EOF
 #	output
 #	untracked
 EOF
-test_expect_success C_LOCALE_OUTPUT 'status submodule summary' '
+test_expect_success 'status submodule summary' '
 	git config status.submodulesummary 10 &&
 	git status >output &&
-	test_cmp expect output
+	test_i18ncmp expect output
 '
 
 cat >expect <<EOF
@@ -773,15 +758,12 @@ cat >expect <<EOF
 no changes added to commit (use "git add" and/or "git commit -a")
 EOF
 test_expect_success 'status submodule summary (clean submodule): commit' '
-	git commit -m "commit submodule"
-'
-
-test_expect_success C_LOCALE_OUTPUT 'status submodule summary (clean submodule): output' '
+	git commit -m "commit submodule" &&
 	git config status.submodulesummary 10 &&
 	test_must_fail git commit --dry-run >output &&
-	test_cmp expect output &&
+	test_i18ncmp expect output &&
 	git status >output &&
-	test_cmp expect output
+	test_i18ncmp expect output
 '
 
 cat >expect <<EOF
@@ -827,10 +809,10 @@ cat >expect <<EOF
 #	output
 #	untracked
 EOF
-test_expect_success C_LOCALE_OUTPUT 'commit --dry-run submodule summary (--amend)' '
+test_expect_success 'commit --dry-run submodule summary (--amend)' '
 	git config status.submodulesummary 10 &&
 	git commit --dry-run --amend >output &&
-	test_cmp expect output
+	test_i18ncmp expect output
 '
 
 test_expect_success POSIXPERM,SANITY 'status succeeds in a read-only repository' '
@@ -882,84 +864,84 @@ cat > expect << EOF
 #	untracked
 EOF
 
-test_expect_success C_LOCALE_OUTPUT '--ignore-submodules=untracked suppresses submodules with untracked content' '
-	echo modified > sm/untracked &&
-	git status --ignore-submodules=untracked > output &&
-	test_cmp expect output
+test_expect_success '--ignore-submodules=untracked suppresses submodules with untracked content' '
+	echo modified  sm/untracked &&
+	git status --ignore-submodules=untracked >output &&
+	test_i18ncmp expect output
 '
 
-test_expect_success C_LOCALE_OUTPUT '.gitmodules ignore=untracked suppresses submodules with untracked content' '
+test_expect_success '.gitmodules ignore=untracked suppresses submodules with untracked content' '
 	git config diff.ignoreSubmodules dirty &&
 	git status >output &&
-	test_cmp expect output &&
+	test_i18ncmp expect output &&
 	git config --add -f .gitmodules submodule.subname.ignore untracked &&
 	git config --add -f .gitmodules submodule.subname.path sm &&
-	git status > output &&
-	test_cmp expect output &&
+	git status >output &&
+	test_i18ncmp expect output &&
 	git config -f .gitmodules  --remove-section submodule.subname &&
 	git config --unset diff.ignoreSubmodules
 '
 
-test_expect_success C_LOCALE_OUTPUT '.git/config ignore=untracked suppresses submodules with untracked content' '
+test_expect_success '.git/config ignore=untracked suppresses submodules with untracked content' '
 	git config --add -f .gitmodules submodule.subname.ignore none &&
 	git config --add -f .gitmodules submodule.subname.path sm &&
 	git config --add submodule.subname.ignore untracked &&
 	git config --add submodule.subname.path sm &&
-	git status > output &&
-	test_cmp expect output &&
+	git status >output &&
+	test_i18ncmp expect output &&
 	git config --remove-section submodule.subname &&
 	git config --remove-section -f .gitmodules submodule.subname
 '
 
-test_expect_success C_LOCALE_OUTPUT '--ignore-submodules=dirty suppresses submodules with untracked content' '
-	git status --ignore-submodules=dirty > output &&
-	test_cmp expect output
+test_expect_success '--ignore-submodules=dirty suppresses submodules with untracked content' '
+	git status --ignore-submodules=dirty >output &&
+	test_i18ncmp expect output
 '
 
-test_expect_success C_LOCALE_OUTPUT '.gitmodules ignore=dirty suppresses submodules with untracked content' '
+test_expect_success '.gitmodules ignore=dirty suppresses submodules with untracked content' '
 	git config diff.ignoreSubmodules dirty &&
 	git status >output &&
 	! test -s actual &&
 	git config --add -f .gitmodules submodule.subname.ignore dirty &&
 	git config --add -f .gitmodules submodule.subname.path sm &&
-	git status > output &&
-	test_cmp expect output &&
+	git status >output &&
+	test_i18ncmp expect output &&
 	git config -f .gitmodules  --remove-section submodule.subname &&
 	git config --unset diff.ignoreSubmodules
 '
 
-test_expect_success C_LOCALE_OUTPUT '.git/config ignore=dirty suppresses submodules with untracked content' '
+test_expect_success '.git/config ignore=dirty suppresses submodules with untracked content' '
 	git config --add -f .gitmodules submodule.subname.ignore none &&
 	git config --add -f .gitmodules submodule.subname.path sm &&
 	git config --add submodule.subname.ignore dirty &&
 	git config --add submodule.subname.path sm &&
-	git status > output &&
-	test_cmp expect output &&
+	git status >output &&
+	test_i18ncmp expect output &&
 	git config --remove-section submodule.subname &&
 	git config -f .gitmodules  --remove-section submodule.subname
 '
 
-test_expect_success C_LOCALE_OUTPUT '--ignore-submodules=dirty suppresses submodules with modified content' '
-	echo modified > sm/foo &&
-	git status --ignore-submodules=dirty > output &&
-	test_cmp expect output
+test_expect_success '--ignore-submodules=dirty suppresses submodules with modified content' '
+	echo modified >sm/foo &&
+	git status --ignore-submodules=dirty >output &&
+	test_i18ncmp expect output
 '
 
-test_expect_success C_LOCALE_OUTPUT '.gitmodules ignore=dirty suppresses submodules with modified content' '
+test_expect_success '.gitmodules ignore=dirty suppresses submodules with modified content' '
 	git config --add -f .gitmodules submodule.subname.ignore dirty &&
 	git config --add -f .gitmodules submodule.subname.path sm &&
-	git status > output &&
-	test_cmp expect output &&
+	git status >output &&
+	test_i18ncmp expect output &&
 	git config -f .gitmodules  --remove-section submodule.subname
 '
 
-test_expect_success C_LOCALE_OUTPUT '.git/config ignore=dirty suppresses submodules with modified content' '
+test_expect_success '.git/config ignore=dirty suppresses submodules with modified content' '
 	git config --add -f .gitmodules submodule.subname.ignore none &&
 	git config --add -f .gitmodules submodule.subname.path sm &&
 	git config --add submodule.subname.ignore dirty &&
 	git config --add submodule.subname.path sm &&
-	git status > output &&
-	test_cmp expect output &&
+	git status >output &&
+	test_i18ncmp expect output &&
 	git config --remove-section submodule.subname &&
 	git config -f .gitmodules  --remove-section submodule.subname
 '
@@ -996,26 +978,26 @@ cat > expect << EOF
 #	untracked
 EOF
 
-test_expect_success C_LOCALE_OUTPUT "--ignore-submodules=untracked doesn't suppress submodules with modified content" '
+test_expect_success "--ignore-submodules=untracked doesn't suppress submodules with modified content" '
 	git status --ignore-submodules=untracked > output &&
-	test_cmp expect output
+	test_i18ncmp expect output
 '
 
-test_expect_success C_LOCALE_OUTPUT ".gitmodules ignore=untracked doesn't suppress submodules with modified content" '
+test_expect_success ".gitmodules ignore=untracked doesn't suppress submodules with modified content" '
 	git config --add -f .gitmodules submodule.subname.ignore untracked &&
 	git config --add -f .gitmodules submodule.subname.path sm &&
-	git status > output &&
-	test_cmp expect output &&
+	git status >output &&
+	test_i18ncmp expect output &&
 	git config -f .gitmodules  --remove-section submodule.subname
 '
 
-test_expect_success C_LOCALE_OUTPUT ".git/config ignore=untracked doesn't suppress submodules with modified content" '
+test_expect_success ".git/config ignore=untracked doesn't suppress submodules with modified content" '
 	git config --add -f .gitmodules submodule.subname.ignore none &&
 	git config --add -f .gitmodules submodule.subname.path sm &&
 	git config --add submodule.subname.ignore untracked &&
 	git config --add submodule.subname.path sm &&
-	git status > output &&
-	test_cmp expect output &&
+	git status >output &&
+	test_i18ncmp expect output &&
 	git config --remove-section submodule.subname &&
 	git config -f .gitmodules  --remove-section submodule.subname
 '
@@ -1058,49 +1040,49 @@ cat > expect << EOF
 #	untracked
 EOF
 
-test_expect_success C_LOCALE_OUTPUT "--ignore-submodules=untracked doesn't suppress submodule summary" '
+test_expect_success "--ignore-submodules=untracked doesn't suppress submodule summary" '
 	git status --ignore-submodules=untracked > output &&
-	test_cmp expect output
+	test_i18ncmp expect output
 '
 
-test_expect_success C_LOCALE_OUTPUT ".gitmodules ignore=untracked doesn't suppress submodule summary" '
+test_expect_success ".gitmodules ignore=untracked doesn't suppress submodule summary" '
 	git config --add -f .gitmodules submodule.subname.ignore untracked &&
 	git config --add -f .gitmodules submodule.subname.path sm &&
-	git status > output &&
-	test_cmp expect output &&
+	git status >output &&
+	test_i18ncmp expect output &&
 	git config -f .gitmodules  --remove-section submodule.subname
 '
 
-test_expect_success C_LOCALE_OUTPUT ".git/config ignore=untracked doesn't suppress submodule summary" '
+test_expect_success ".git/config ignore=untracked doesn't suppress submodule summary" '
 	git config --add -f .gitmodules submodule.subname.ignore none &&
 	git config --add -f .gitmodules submodule.subname.path sm &&
 	git config --add submodule.subname.ignore untracked &&
 	git config --add submodule.subname.path sm &&
-	git status > output &&
-	test_cmp expect output &&
+	git status >output &&
+	test_i18ncmp expect output &&
 	git config --remove-section submodule.subname &&
 	git config -f .gitmodules  --remove-section submodule.subname
 '
 
-test_expect_success C_LOCALE_OUTPUT "--ignore-submodules=dirty doesn't suppress submodule summary" '
+test_expect_success "--ignore-submodules=dirty doesn't suppress submodule summary" '
 	git status --ignore-submodules=dirty > output &&
-	test_cmp expect output
+	test_i18ncmp expect output
 '
-test_expect_success C_LOCALE_OUTPUT ".gitmodules ignore=dirty doesn't suppress submodule summary" '
+test_expect_success ".gitmodules ignore=dirty doesn't suppress submodule summary" '
 	git config --add -f .gitmodules submodule.subname.ignore dirty &&
 	git config --add -f .gitmodules submodule.subname.path sm &&
-	git status > output &&
-	test_cmp expect output &&
+	git status >output &&
+	test_i18ncmp expect output &&
 	git config -f .gitmodules  --remove-section submodule.subname
 '
 
-test_expect_success C_LOCALE_OUTPUT ".git/config ignore=dirty doesn't suppress submodule summary" '
+test_expect_success ".git/config ignore=dirty doesn't suppress submodule summary" '
 	git config --add -f .gitmodules submodule.subname.ignore none &&
 	git config --add -f .gitmodules submodule.subname.path sm &&
 	git config --add submodule.subname.ignore dirty &&
 	git config --add submodule.subname.path sm &&
-	git status > output &&
-	test_cmp expect output &&
+	git status >output &&
+	test_i18ncmp expect output &&
 	git config --remove-section submodule.subname &&
 	git config -f .gitmodules  --remove-section submodule.subname
 '
@@ -1126,9 +1108,9 @@ cat > expect << EOF
 no changes added to commit (use "git add" and/or "git commit -a")
 EOF
 
-test_expect_success C_LOCALE_OUTPUT "--ignore-submodules=all suppresses submodule summary" '
+test_expect_success "--ignore-submodules=all suppresses submodule summary" '
 	git status --ignore-submodules=all > output &&
-	test_cmp expect output
+	test_i18ncmp expect output
 '
 
 test_expect_failure '.gitmodules ignore=all suppresses submodule summary' '
