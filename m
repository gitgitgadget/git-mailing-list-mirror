From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 10/23] Introduce --ref-exists
Date: Sat, 23 Apr 2011 17:22:39 +1000
Message-ID: <1303543372-77843-11-git-send-email-jon.seymour@gmail.com>
References: <1303543372-77843-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 09:24:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QDXCf-0004tb-4Y
	for gcvg-git-2@lo.gmane.org; Sat, 23 Apr 2011 09:24:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752374Ab1DWHYU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Apr 2011 03:24:20 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:39715 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752190Ab1DWHYR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2011 03:24:17 -0400
Received: by mail-pz0-f46.google.com with SMTP id 9so584380pzk.19
        for <git@vger.kernel.org>; Sat, 23 Apr 2011 00:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=93Trzd2ycIdemZYqEETLPZB9nTwee5d/zQ42/Oem0OI=;
        b=oS4wOMn9doQxNlVJ772TUN6od3iP50FiKXSRqcrNo325K/jGLG4y2FcosvRay9Nf0N
         DCJGNDOL4IvOfrlQd8rEYHEy5CQzcdkWripqwvrDtNHvw26DJ0iZ2DOfeqnPgE7oSbuL
         N1EuVrhs1MpTrhiYfQybT97wO55/QEQ2zIL7E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=A7KRRbQ3KsSl56mcHCTXBNGuA0+LHpx12bxTHaMaydNtP0gx5zFHjpEv0TfwH9cCDb
         BGEMmacXKONWUsstBgmCrOfHPClOBUxVRzXXjsU60sUxj5Zg+3BAjmEgEplP61gLR1Gg
         vcvr9upzYPMbgqNu/jy3Bf9lOU+Z+6Fzt/EY8=
Received: by 10.68.9.196 with SMTP id c4mr2903063pbb.461.1303543456859;
        Sat, 23 Apr 2011 00:24:16 -0700 (PDT)
Received: from localhost.localdomain (124-169-133-110.dyn.iinet.net.au [124.169.133.110])
        by mx.google.com with ESMTPS id v8sm2498310pbk.95.2011.04.23.00.24.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 23 Apr 2011 00:24:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.rc1.23.g7f622
In-Reply-To: <1303543372-77843-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171962>

tweak ref
---
 Documentation/git-test.txt |    2 ++
 git-conditions-lib.sh      |   12 ++++++++++++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-test.txt b/Documentation/git-test.txt
index 69c8710..259a04c 100644
--- a/Documentation/git-test.txt
+++ b/Documentation/git-test.txt
@@ -80,6 +80,8 @@ CONDITIONS
         Tests if the specified branch does (not) exist.				    
 '--tag-exists'|'--not-tag-exists tag'::
         Tests if the specified tag does (not) exist.
+'--ref-exists'|'--not-ref-exists tag'::
+        Tests if the specified reference does (not) exist.
 
 EXTENDING THE CONDITION LIBRARY
 -------------------------------
diff --git a/git-conditions-lib.sh b/git-conditions-lib.sh
index 93a916a..c21d669 100644
--- a/git-conditions-lib.sh
+++ b/git-conditions-lib.sh
@@ -99,5 +99,17 @@ check_tag_exists_1()
 	fi
 }
 
+check_ref_exists_1()
+{
+	symbolic=$(git rev-parse --quiet --symbolic-full-name --verify "$1")
+ 	if test "${symbolic#refs/}" != "${symbolic}"
+	then
+		echo "Reference '$1' exists."
+	else
+		echo "Reference '$1' does not exist."
+		false
+	fi
+}
+
 
 fi
-- 
1.7.5.rc1.23.g7f622
