From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] Use git-update-ref to update a ref during commit in git-cvsserver
Date: Tue, 20 Feb 2007 20:10:01 +0000
Message-ID: <200702202010.02128.andyparkins@gmail.com>
References: <200702200857.02779.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 20 21:13:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJbMq-0001Lw-3p
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 21:13:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030417AbXBTUM4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 15:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030413AbXBTUM4
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 15:12:56 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:16149 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030417AbXBTUMz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 15:12:55 -0500
Received: by ug-out-1314.google.com with SMTP id 44so887707uga
        for <git@vger.kernel.org>; Tue, 20 Feb 2007 12:12:54 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:in-reply-to:references:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=rf/71g4gJt9to1Qqj5Ce/OD8/ntVvWROx45SFTITkEG5oBL+jShEuSLGcIfeuUFV2XyKUoEv5y+D9KopplFXU1tH0XxNiFhlwCx2RsJIlvCbJn6PrnRs3UHrVz1jY0ApOxihbvY8Djq6+u+2WIY2goS7aSB170oRAhq6f/GHPY0=
Received: by 10.66.239.18 with SMTP id m18mr2143644ugh.1172002374310;
        Tue, 20 Feb 2007 12:12:54 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id g30sm11346461ugd.2007.02.20.12.12.52;
        Tue, 20 Feb 2007 12:12:52 -0800 (PST)
In-Reply-To: <200702200857.02779.andyparkins@gmail.com>
X-TUID: 235a41573f2f2145
X-UID: 248
X-Length: 1205
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40257>

Nicholas Pitre mentioned that updating a reference should be done with
git-update-ref.

This patch does that and includes the -m option to have the reflog
updated as a bonus.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
As promised...

 git-cvsserver.perl |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index b4ef6bc..54d943a 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -1216,9 +1216,9 @@ sub req_ci
     }
 
     close LOCKFILE;
-    my $reffile = "$ENV{GIT_DIR}refs/heads/$state->{module}";
-    unlink($reffile);
-    rename($lockfile, $reffile);
+    my $reffile = "refs/heads/$state->{module}";
+	`git-update-ref -m "git-cvsserver commit" $reffile $commithash $parenthash`;
+	unlink($lockfile);
     chdir "/";
 
     print "ok\n";
-- 
1.5.0.rc4.gb4d2
