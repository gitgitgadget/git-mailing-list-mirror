From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: [PATCH 2/2] git-gui: Don't prepend the prefix if value looks like a full path
Date: Tue,  2 Oct 2012 12:25:15 -0400
Message-ID: <1349195115-15494-3-git-send-email-andrew.kw.w@gmail.com>
References: <1349195115-15494-1-git-send-email-andrew.kw.w@gmail.com>
Cc: Andrew Wong <andrew.kw.w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 02 18:25:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJ5I1-0007C8-7i
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 18:25:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755015Ab2JBQZb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 12:25:31 -0400
Received: from mail-ia0-f174.google.com ([209.85.210.174]:36993 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754985Ab2JBQZa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 12:25:30 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so753414iag.19
        for <git@vger.kernel.org>; Tue, 02 Oct 2012 09:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=kzynbs0Nl+RN5bElWqMnepWDfwEqrBIrui12aeZn5jk=;
        b=r1gvJOd0N2KL+DGCNcpV/tpfd3TpwJFYTI3KaA0lqjeHviDc7tKdnFm/C4f48dmHNP
         jH056QLYaFJOZxuFhGoUkJUQjPyfkieULaG6YGsnyvpc+WoMSm0JeeMQUPcQk2/eaBm2
         vs260EwopB76xvmuhssiJC3d8eTT0NqGR4HuIYdO5An2tM7Q4Gg/5h1gvfsKG0n4f+MV
         4WuOEMhG9Vsg7YluH8uUTJfGVgqgYB0RHaIFEo3FO+d10j2W0tRYk4PKGDrLASeeuST6
         0HTKnrJcm0dwSyXqSZW+KmHuzohd0MT1nz2LvMwL7NhgQcN4E7lj0jHt0GgpPo17lL5r
         9EGg==
Received: by 10.42.33.69 with SMTP id h5mr13489045icd.54.1349195130419;
        Tue, 02 Oct 2012 09:25:30 -0700 (PDT)
Received: from nigel.sohovfx.com ([66.207.196.114])
        by mx.google.com with ESMTPS id d19sm9109210igp.6.2012.10.02.09.25.27
        (version=SSLv3 cipher=OTHER);
        Tue, 02 Oct 2012 09:25:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.1.382.gb0576a6
In-Reply-To: <1349195115-15494-1-git-send-email-andrew.kw.w@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206810>

When argument parsing fails to detect a file name, "git-gui" will try to
use the previously detected "head" as the file name. We should avoid
prepending the prefix if "head" looks like a full path.

Signed-off-by: Andrew Wong <andrew.kw.w@gmail.com>
---
 git-gui.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 5d7894b..89f636f 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -3037,8 +3037,13 @@ blame {
 	unset is_path
 
 	if {$head ne {} && $path eq {}} {
-		set path [normalize_relpath $_prefix$head]
-		set head {}
+		if {[string index $head 0] eq {/}} {
+			set path [normalize_relpath $head]
+			set head {}
+		} else {
+			set path [normalize_relpath $_prefix$head]
+			set head {}
+		}
 	}
 
 	if {$head eq {}} {
-- 
1.7.12.1.382.gb0576a6
