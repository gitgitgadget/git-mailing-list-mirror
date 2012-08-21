From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 6/7] Fix tests under GETTEXT_POISON on git-remote
Date: Tue, 21 Aug 2012 11:31:03 +0700
Message-ID: <1345523464-14586-7-git-send-email-pclouds@gmail.com>
References: <1345523464-14586-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 21 06:38:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3gEa-0001H7-MP
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 06:38:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751716Ab2HUEiX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Aug 2012 00:38:23 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:48556 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585Ab2HUEiH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 00:38:07 -0400
Received: by pbbrr13 with SMTP id rr13so7921045pbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 21:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=1MaBY+w8zV/8+fVEgljKQ9wx8m949V4CnqhNwhDlWDk=;
        b=Pan7Cz5I7nNVJIbkJlTGZ+Qa560+DjG6H6OVDsz51Z3QLnQjGu8xo/2ZN0UHf88g/D
         BA3gsXuGu2UJc8eP35vUXBKT/RWuMvtfi/Mt7ZeGq+Qj6ETzCBBSfp3Cd85ff5qBV5XB
         dgX+H9yIDfTUg46o023hYqfcJlaYK2Nd62xxGfwjMr0fVKTfcBMhD9XvX4/XW0XQelSs
         yDKVjDoF5wVrKiwod3WCS7owpmRj7eLiVuMA+SWXPvqs+q1YzfcyQQ1tZSDsJzwqB0bq
         qtf6HBhnksgv2dhTfeKeyIHSjMRbDrDzd2tMkcq5UC6FjATJUkL/IK5ZxXH45hDruTnx
         LXdA==
Received: by 10.66.76.227 with SMTP id n3mr34783348paw.53.1345523546598;
        Mon, 20 Aug 2012 21:32:26 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id wh7sm587604pbc.33.2012.08.20.21.32.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 21:32:25 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 21 Aug 2012 11:32:12 +0700
X-Mailer: git-send-email 1.7.12.rc2
In-Reply-To: <1345523464-14586-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203933>

=46rom: Jiang Xin <worldhello.net@gmail.com>

Use i18n-specific test functions in test scripts for git-remote.
This issue was was introduced in v1.7.10-233-gbb16d5:

    bb16d5 i18n: remote: mark strings for translation

and been broken under GETTEXT_POISON=3DYesPlease since.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t5505-remote.sh | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index e8af615..07045e3 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -27,10 +27,16 @@ tokens_match () {
 	test_cmp expect actual
 }
=20
+tokens_i18nmatch () {
+	echo "$1" | tr ' ' '\012' | sort | sed -e '/^$/d' >expect &&
+	echo "$2" | tr ' ' '\012' | sort | sed -e '/^$/d' >actual &&
+	test_i18ncmp expect actual
+}
+
 check_remote_track () {
 	actual=3D$(git remote show "$1" | sed -ne 's|^    \(.*\) tracked$|\1|=
p')
 	shift &&
-	tokens_match "$*" "$actual"
+	tokens_i18nmatch "$*" "$actual"
 }
=20
 check_tracking_branch () {
@@ -131,8 +137,8 @@ EOF
 	git remote rm oops 2>actual2 &&
 	git branch -d foobranch &&
 	git tag -d footag &&
-	test_cmp expect1 actual1 &&
-	test_cmp expect2 actual2
+	test_i18ncmp expect1 actual1 &&
+	test_i18ncmp expect2 actual2
 )
 '
=20
@@ -192,7 +198,7 @@ test_expect_success 'show' '
 	 git config --add remote.two.push refs/heads/master:refs/heads/anothe=
r &&
 	 git remote show origin two > output &&
 	 git branch -d rebase octopus &&
-	 test_cmp expect output)
+	 test_i18ncmp expect output)
 '
=20
 cat > test/expect << EOF
@@ -217,7 +223,7 @@ test_expect_success 'show -n' '
 	 cd test &&
 	 git remote show -n origin > output &&
 	 mv ../one.unreachable ../one &&
-	 test_cmp expect output)
+	 test_i18ncmp expect output)
 '
=20
 test_expect_success 'prune' '
@@ -255,7 +261,7 @@ EOF
 test_expect_success 'set-head --auto fails w/multiple HEADs' '
 	(cd test &&
 	 test_must_fail git remote set-head --auto two >output 2>&1 &&
-	test_cmp expect output)
+	test_i18ncmp expect output)
 '
=20
 cat >test/expect <<EOF
@@ -285,7 +291,7 @@ test_expect_success 'prune --dry-run' '
 	 test_must_fail git rev-parse refs/remotes/origin/side &&
 	(cd ../one &&
 	 git branch -m side side2) &&
-	 test_cmp expect output)
+	 test_i18ncmp expect output)
 '
=20
 test_expect_success 'add --mirror && prune' '
@@ -705,7 +711,7 @@ test_expect_success 'remote prune to cause a dangli=
ng symref' '
 		cd seven &&
 		git remote prune origin
 	) >err 2>&1 &&
-	grep "has become dangling" err &&
+	test_i18ngrep "has become dangling" err &&
=20
 	: And the dangling symref will not cause other annoying errors &&
 	(
--=20
1.7.12.rc2
