From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 1/7] t/t1304-default-acl: change from skip_all=* to prereq skip
Date: Wed, 11 Aug 2010 19:04:04 +0000
Message-ID: <1281553450-26467-2-git-send-email-avarab@gmail.com>
References: <7vd3tpxao1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 11 21:04:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjGbS-00034v-Sx
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 21:04:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758441Ab0HKTEb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 15:04:31 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:47186 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755354Ab0HKTE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 15:04:29 -0400
Received: by wyb32 with SMTP id 32so462345wyb.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 12:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=8B+1j1VEqYql+uWCGw9PptMjGbXwAKnPyy2QWobTuKE=;
        b=K9brG9riZXNmwFXev2RTjcU3paBBJR7WDNc37RlabIiOg1mfKTzwR8q+qLsA5vGUG3
         AofAS9QFveZv664/7SzRCclEdv4DzWOsgW3fTNQefpkqs1WMwuWGuWAtL99h/+81V1vB
         5DiR/cbBD17QaEo1RR14CGz5sFPwH/Slb62ts=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=s6F9d0hl71/mnOEjWsnHIsutP8D9pFzt+sDaItQ/LndsgY9ytnKnDQBWDZvWHSSqIm
         /8aYKd2TUc1hq69o7gvm+FkoCzZMR5eFCWIVtN6NvS7QBtKSaZ0kARI36x/4vlVzTrVa
         DZ3xl+Xal3FfqUMQd/WNG98HIKg7PN43o50i8=
Received: by 10.227.147.79 with SMTP id k15mr16646048wbv.128.1281553467802;
        Wed, 11 Aug 2010 12:04:27 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id b18sm369379wbb.19.2010.08.11.12.04.26
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 11 Aug 2010 12:04:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.295.gdf931
In-Reply-To: <7vd3tpxao1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153283>

Change this test to skip test with test prerequisites, and to do setup
work in tests. This improves the skipped statistics on platforms where
the test isn't run.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t1304-default-acl.sh |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/t/t1304-default-acl.sh b/t/t1304-default-acl.sh
index 97ab02a..b5d89a2 100755
--- a/t/t1304-default-acl.sh
+++ b/t/t1304-default-acl.sh
@@ -18,9 +18,11 @@ umask 077
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
 check_perms_and_acl () {
@@ -34,7 +36,7 @@ check_perms_and_acl () {
=20
 dirs_to_set=3D"./ .git/ .git/objects/ .git/objects/pack/"
=20
-test_expect_success 'Setup test repo' '
+test_expect_success SETFACL 'Setup test repo' '
 	setfacl -m d:u::rwx,d:g::---,d:o:---,d:m:rwx $dirs_to_set &&
 	setfacl -m m:rwx               $dirs_to_set &&
 	setfacl -m u:root:rwx          $dirs_to_set &&
@@ -46,12 +48,12 @@ test_expect_success 'Setup test repo' '
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
1.7.2.1.295.gdf931
