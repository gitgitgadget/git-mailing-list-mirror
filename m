From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] t1304: fall back to $USER if $LOGNAME is not defined
Date: Fri, 14 Oct 2011 19:44:45 +0200
Message-ID: <4E98750D.1020106@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 14 19:44:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REloV-0003G5-PK
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 19:44:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755887Ab1JNRov (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 13:44:51 -0400
Received: from india601.server4you.de ([85.25.151.105]:57146 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918Ab1JNRou (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 13:44:50 -0400
Received: from [192.168.2.104] (p4FFD9258.dip.t-dialin.net [79.253.146.88])
	by india601.server4you.de (Postfix) with ESMTPSA id C91B92F8057;
	Fri, 14 Oct 2011 19:44:48 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183586>

For some reason $LOGNAME is not set anymore for me after an upgrade from
Ubuntu 11.04 to 11.10.  Use $USER in such a case.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
The only other use of $LOGNAME is in git-cvsimport, which does the same.

 t/t1304-default-acl.sh |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/t/t1304-default-acl.sh b/t/t1304-default-acl.sh
index b5d89a2..2b962cf 100755
--- a/t/t1304-default-acl.sh
+++ b/t/t1304-default-acl.sh
@@ -25,6 +25,11 @@ else
 	test_set_prereq SETFACL
 fi
 
+if test -z "$LOGNAME"
+then
+	LOGNAME=$USER
+fi
+
 check_perms_and_acl () {
 	test -r "$1" &&
 	getfacl "$1" > actual &&
-- 
1.7.7
