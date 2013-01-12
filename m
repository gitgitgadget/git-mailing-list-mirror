From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH v2 2/3] t9600: fixup for new cvsimport
Date: Sat, 12 Jan 2013 00:21:42 -0600
Message-ID: <1357971703-28513-3-git-send-email-chris@rorvick.com>
References: <1357971703-28513-1-git-send-email-chris@rorvick.com>
Cc: "Eric S. Raymond" <esr@thyrsus.com>,
	Junio C Hamano <gitster@pobox.com>,
	Chris Rorvick <chris@rorvick.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 12 07:24:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtuVn-0004UI-2q
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jan 2013 07:24:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752237Ab3ALGXp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2013 01:23:45 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:34061 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752103Ab3ALGXo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2013 01:23:44 -0500
Received: by mail-ie0-f174.google.com with SMTP id c11so3238473ieb.33
        for <git@vger.kernel.org>; Fri, 11 Jan 2013 22:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=vG492iu/FyUt8GizCv88l4l1XiDPNkIs5ICLR/K8ei0=;
        b=wY9OGYN2cMw7fOC3gvCxNhgJtGZGbNhywB2giyaFg3QcIpDY5rJMc6mkV+D23ASNK8
         e6BcEUa3oi+bttbo/pSR6rD6YgAXgbREko4CybYiUeSx5LuHS5Nz73p2NKRtKhTuxDBE
         P3TroRjyaapd9dRR8m7Ove5JIY7tAPOsCYrsF6vpZeg7u7fQ4roTedi/ZxGLxMUpDjd8
         sHrtbF2sOsFLky1OayJA8Wkap6WO9/l2hlWQ+B5zDdkY040YHWAZzY6m4AF9zF35pxHQ
         eDEFus0xVVnJRNEM1O3DAb1kRN2PEPSQl+59lqxst8cC0qfzTjeVxRWJ8N7RH/kAxBIJ
         n0XA==
X-Received: by 10.50.15.138 with SMTP id x10mr1392677igc.16.1357971823651;
        Fri, 11 Jan 2013 22:23:43 -0800 (PST)
Received: from marlin.localdomain (adsl-70-131-98-170.dsl.emhril.sbcglobal.net. [70.131.98.170])
        by mx.google.com with ESMTPS id ww6sm1426280igb.2.2013.01.11.22.23.42
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 11 Jan 2013 22:23:42 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc3.335.g88a67d6
In-Reply-To: <1357971703-28513-1-git-send-email-chris@rorvick.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213269>

cvsimport no longer supports -a (import all commits including recent ones)
and no longer uses the 'origin' branch by default for imports.

Signed-off-by: Chris Rorvick <chris@rorvick.com>
---
 t/t9600-cvsimport.sh | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/t/t9600-cvsimport.sh b/t/t9600-cvsimport.sh
index 4c384ff..14f54d5 100755
--- a/t/t9600-cvsimport.sh
+++ b/t/t9600-cvsimport.sh
@@ -44,7 +44,7 @@ EOF
 
 test_expect_success PERL 'import a trivial module' '
 
-	git cvsimport -a -R -z 0 -C module-git module &&
+	git cvsimport -R -z 0 -C module-git module &&
 	test_cmp module-cvs/o_fortuna module-git/o_fortuna
 
 '
@@ -90,8 +90,7 @@ test_expect_success PERL 'update git module' '
 
 	(cd module-git &&
 	git config cvsimport.trackRevisions true &&
-	git cvsimport -a -z 0 module &&
-	git merge origin
+	git cvsimport -z 0 module
 	) &&
 	test_cmp module-cvs/o_fortuna module-git/o_fortuna
 
@@ -119,8 +118,7 @@ test_expect_success PERL 'cvsimport.module config works' '
 	(cd module-git &&
 		git config cvsimport.module module &&
 		git config cvsimport.trackRevisions true &&
-		git cvsimport -a -z0 &&
-		git merge origin
+		git cvsimport -z0
 	) &&
 	test_cmp module-cvs/tick module-git/tick
 
@@ -140,7 +138,7 @@ test_expect_success PERL 'import from a CVS working tree' '
 	$CVS co -d import-from-wt module &&
 	(cd import-from-wt &&
 		git config cvsimport.trackRevisions false &&
-		git cvsimport -a -z0 &&
+		git cvsimport -z0 &&
 		echo 1 >expect &&
 		git log -1 --pretty=format:%s%n >actual &&
 		test_cmp actual expect
-- 
1.8.1.rc3.335.g88a67d6
