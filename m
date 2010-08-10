From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 1/7] t/t1304-default-acl: change from skip_all=* to prereq skip
Date: Tue, 10 Aug 2010 19:52:42 +0000
Message-ID: <1281469968-25670-2-git-send-email-avarab@gmail.com>
References: <1281469968-25670-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 10 21:53:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oiusz-0008HM-F7
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 21:53:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754808Ab0HJTxF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Aug 2010 15:53:05 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:58890 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754530Ab0HJTxD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Aug 2010 15:53:03 -0400
Received: by wwj40 with SMTP id 40so13310538wwj.1
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 12:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=FmNQDbddoyA6Twm/uIsyKe2vkBftWdl9PzgalLE2U04=;
        b=PvHfq9MVab4ff5NKtBf3lcWYM/eVs1K7aWsnKANJxjrZvshkkW4al/P9c4SqnAKwBF
         OQEVO1LRdEeiulAmaJffg04ywh9zn7bIOkGmHShzOSvrNZEiYtxChF9lKeatAIF/iAHB
         0njeteXiHcXiLdv4TBmNOJqGxtkW6kSwMnCs4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=kgDAA1FLPSu5aR+ib1Hc45gMNWy73pLuILHaGxiSSiitrFnqFgZAxPFiimvMHph23E
         RGivBWbpp/Xz0G+e2Bqf6fYMBHdkht9PHgKK3+hAoPFCH9q+YxnxWqWXPhifDOoI3Olr
         K++xkLWWZ1gimNd+LGInjceGTVVXrKCEZIhpw=
Received: by 10.216.21.206 with SMTP id r56mr4330526wer.31.1281469981927;
        Tue, 10 Aug 2010 12:53:01 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id p45sm3602981weq.21.2010.08.10.12.52.57
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 10 Aug 2010 12:52:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.295.gd03d
In-Reply-To: <1281469968-25670-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153144>

Change this test to skip test with test prerequisites, and to do setup
work in tests. This improves the skipped statistics on platforms where
the test isn't run.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t1304-default-acl.sh |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/t/t1304-default-acl.sh b/t/t1304-default-acl.sh
index 97ab02a..0e6cb4f 100755
--- a/t/t1304-default-acl.sh
+++ b/t/t1304-default-acl.sh
@@ -18,11 +18,14 @@ umask 077
 setfacl_out=3D"$(setfacl -m u:root:rwx . 2>&1)"
 setfacl_ret=3D$?
=20
-if [ $setfacl_ret !=3D 0 ]; then
-	skip_all=3D"Skipping ACL tests: unable to use setfacl (output: '$setf=
acl_out'; return code: '$setfacl_ret')"
-	test_done
+if test $setfacl_ret !=3D 0
+then
+	say "Unable to use setfacl (output: '$setfacl_out'; return code: '$se=
tfacl_ret')"
+else
+	test_set_prereq SETFACL
 fi
=20
+
 check_perms_and_acl () {
 	test -r "$1" &&
 	getfacl "$1" > actual &&
@@ -34,7 +37,7 @@ check_perms_and_acl () {
=20
 dirs_to_set=3D"./ .git/ .git/objects/ .git/objects/pack/"
=20
-test_expect_success 'Setup test repo' '
+test_expect_success SETFACL 'Setup test repo' '
 	setfacl -m d:u::rwx,d:g::---,d:o:---,d:m:rwx $dirs_to_set &&
 	setfacl -m m:rwx               $dirs_to_set &&
 	setfacl -m u:root:rwx          $dirs_to_set &&
@@ -46,12 +49,12 @@ test_expect_success 'Setup test repo' '
 	git commit -m "init"
 '
=20
-test_expect_success 'Objects creation does not break ACLs with restric=
tive umask' '
+test_expect_success SETFACL 'Objects creation does not break ACLs with=
 restrictive umask' '
 	# SHA1 for empty blob
 	check_perms_and_acl .git/objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48=
c5391
 '
=20
-test_expect_success 'git gc does not break ACLs with restrictive umask=
' '
+test_expect_success SETFACL 'git gc does not break ACLs with restricti=
ve umask' '
 	git gc &&
 	check_perms_and_acl .git/objects/pack/*.pack
 '
--=20
1.7.2.1.295.gd03d
