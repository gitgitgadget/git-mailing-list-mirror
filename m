From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 1/5] t/t1304: avoid -d option to setfacl
Date: Mon, 15 Mar 2010 12:14:33 -0500
Message-ID: <YowxgPZqaOkg2MZzY1CxL7osRwRHVqDoA4pDFlm_036BvsYP4hI0frMTwyMvLVDr6FREt89Ntxk@cipher.nrlssc.navy.mil>
References: <YowxgPZqaOkg2MZzY1CxL1fbmUZ7CMUf5DgqI3S0X83DgqLNI9AGfI83JRNT8LWYHqXBB-PGS1Q@cipher.nrlssc.navy.mil>
Cc: Matthieu.Moy@imag.fr, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 15 18:15:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrDtU-0004dk-PI
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 18:15:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965524Ab0CORPV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 13:15:21 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:43471 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965505Ab0CORPU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 13:15:20 -0400
Received: by mail.nrlssc.navy.mil id o2FHF5qW002221; Mon, 15 Mar 2010 12:15:05 -0500
In-Reply-To: <YowxgPZqaOkg2MZzY1CxL1fbmUZ7CMUf5DgqI3S0X83DgqLNI9AGfI83JRNT8LWYHqXBB-PGS1Q@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 15 Mar 2010 17:15:03.0529 (UTC) FILETIME=[0D2C3D90:01CAC463]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142229>

From: Brandon Casey <drafnel@gmail.com>

Some platforms (Solaris) have a setfacl whose -d switch works differently
than the one on Linux.  On Linux, it causes all operations to be applied
to the Default ACL.  There is a notation for operating on the Default ACL:

   [d[efault]:] [u[ser]:]uid [:perms]

so use it instead of the -d switch.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/t1304-default-acl.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1304-default-acl.sh b/t/t1304-default-acl.sh
index cc30be4..415a2dd 100755
--- a/t/t1304-default-acl.sh
+++ b/t/t1304-default-acl.sh
@@ -46,8 +46,8 @@ dirs_to_set="./ .git/ .git/objects/ .git/objects/pack/"
 
 test_expect_success 'Setup test repo' '
 	setfacl -m u:root:rwx          $dirs_to_set &&
-	setfacl -d -m u:"$LOGNAME":rwx $dirs_to_set &&
-	setfacl -d -m u:root:rwx       $dirs_to_set &&
+	setfacl -m d:u:"$LOGNAME":rwx  $dirs_to_set &&
+	setfacl -m d:u:root:rwx        $dirs_to_set &&
 
 	touch file.txt &&
 	git add file.txt &&
-- 
1.6.6.2
