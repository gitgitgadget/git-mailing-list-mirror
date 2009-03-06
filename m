From: John Tapsell <johnflux@gmail.com>
Subject: [PATCH] Documentation: More examples for git bisect
Date: Fri,  6 Mar 2009 09:37:35 +0000
Message-ID: <1236332255-15712-1-git-send-email-johnflux@gmail.com>
Cc: John Tapsell <johnflux@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 06 10:39:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfWWa-0000W9-Lm
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 10:39:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751522AbZCFJhy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 04:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750950AbZCFJhy
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 04:37:54 -0500
Received: from rv-out-0506.google.com ([209.85.198.229]:48563 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876AbZCFJhx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 04:37:53 -0500
Received: by rv-out-0506.google.com with SMTP id g37so420303rvb.1
        for <git@vger.kernel.org>; Fri, 06 Mar 2009 01:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=9XpSQsVj206jQ3FP3yuO0gX/qMcrMcow99w48Xu9zM4=;
        b=F251G5NwtwDAnqH/Zj3kVvHEdG+lwvxhfoyRFTC+UyIcr58PCYke3vHWLnN5nZOwee
         5LGtx9ls/LTjvWMpk9xX4NnMotONQa4JZ8kMicPirqSmTxFEmE70JIQylcoYkLwoiXHp
         0hANwfZd2UW0fzDP5rzWEtCx3H6cJUdQ3f7I0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Vun1Jx0DmZeDBdC631+UQwoagl/aVeKNe4p7exfmrrsFULEKnsanrU1zYaBIbSLmKh
         atldND38e79ALyOfE5+8X2E3qchyxb/xXRKOLrD3Uzz4JtvFGMJWf3Kj7T3Ll++ztlA2
         +QX0GclAQHmF+Nt99TQQYfhiooPmsoCDFZJvM=
Received: by 10.140.162.21 with SMTP id k21mr1173424rve.191.1236332271049;
        Fri, 06 Mar 2009 01:37:51 -0800 (PST)
Received: from localhost.localdomain (58-190-81-184.eonet.ne.jp [58.190.81.184])
        by mx.google.com with ESMTPS id f42sm1531092rvb.3.2009.03.06.01.37.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Mar 2009 01:37:50 -0800 (PST)
X-Mailer: git-send-email 1.6.2.97.g034f.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112409>

Including passing parameters to the programs, and running more
complicated checks without requiring a seperate shell script.

Signed-off-by: John Tapsell <johnflux@gmail.com>
---
 Documentation/git-bisect.txt |   27 ++++++++++++++++++++++++++-
 1 files changed, 26 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 147ea38..7b8cfdd 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -212,7 +212,7 @@ If you have a script that can tell if the current source code is good
 or bad, you can automatically bisect using:
 
 ------------
-$ git bisect run my_script
+$ git bisect run my_script arguments
 ------------
 
 Note that the "run" script (`my_script` in the above example) should
@@ -251,6 +251,22 @@ EXAMPLES
 $ git bisect start HEAD v1.2 --      # HEAD is bad, v1.2 is good
 $ git bisect run make                # "make" builds the app
 ------------
++
+This looks for the first revision that fails to build between HEAD and
+the tag 'v1.2'.  
+
+* Automatically bisect a test failure between origin and HEAD:
++
+------------
+$ git bisect start HEAD origin --    # HEAD is bad, origin is good
+$ git bisect run make test           # "make test" builds and tests
+------------
++
+This looks for the first revision that 'make test' fails for, assuming that
+you have such a Makefile rule, and that 'make test' also builds the source code.
+Note however that if the source fails to build, this will be treated as a bad
+commit.  This may not be what you intend, so the following examples instead
+treat build failures as commits to skip.
 
 * Automatically bisect a broken test suite:
 +
@@ -291,6 +307,15 @@ It's safer if both "test.sh" and "check_test_case.sh" scripts are
 outside the repo to prevent interactions between the bisect, make and
 test processes and the scripts.
 
+* Automatically bisect a broken test suite, simplified version:
++
+------------
+$ git bisect start HEAD HEAD~10 --   # culprit is among the last 10
+$ git bisect run sh -c "make || exit 125; ~/check_test_case.sh"
+------------
++
+Does the same as the previous example, but on a single line.
+
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org>
-- 
1.6.2.97.g034f.dirty
