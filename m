From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH 2/2 v2] Change the description of '-M' and '-C' option.
Date: Sat, 10 Apr 2010 18:15:30 +0800
Message-ID: <1270894530-6486-3-git-send-email-struggleyb.nku@gmail.com>
References: <1270894530-6486-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 10 12:16:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0XjZ-0001ZA-Nl
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 12:16:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765Ab0DJKQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 06:16:00 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:48933 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751584Ab0DJKPs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 06:15:48 -0400
Received: by mail-vw0-f46.google.com with SMTP id 18so416067vws.19
        for <git@vger.kernel.org>; Sat, 10 Apr 2010 03:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Ckl/ANXBcg7y0MkM7DnQGcBrhJW7SJpA99a8WYORPZo=;
        b=FoTgGlbSXRyXGyW/w9siBhBjxlgKlbOY+A6dO0zVAkITYSIzLzfP+oWf6EeLhLNvho
         PlSEVqUy2hv1rBCseqgwBvh/PlpsclRkCY199Tdjp/q05WJ05Xi4AntmYtbOQTh+D+Ut
         y+GPPLukpuI40HjxUEymwx8VNJpHO0pOfJrDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=oFM+5yteUrzJAr5I0Ponr8vPPYUQowUNr0Mv5xKIzXNz9y/VRLWejB/80qMXsf5EvR
         avaXZWh3qCSdOHtFf3uJvDKrxwyD3j9EbrvFkTDoWAQQ9YlJmyT9ru6A3TG+Mzh0EyRY
         fFZcnZSL4UARAqi4gd0dYtjBZprkctdrSqFCI=
Received: by 10.220.107.167 with SMTP id b39mr680724vcp.136.1270894547634;
        Sat, 10 Apr 2010 03:15:47 -0700 (PDT)
Received: from localhost.localdomain ([117.15.72.219])
        by mx.google.com with ESMTPS id 25sm46893343vws.1.2010.04.10.03.15.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 Apr 2010 03:15:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.2.273.gc2413.dirty
In-Reply-To: <1270894530-6486-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144539>

Both '-M' and '-C' option detect code moving and copying.
The difference between the two options is whether they
search across file boundary.

Thanks-to: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 Documentation/blame-options.txt |   46 +++++++++++++++++++++++---------------
 1 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index 4833cac..d113f2e 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -79,34 +79,44 @@ of lines before or after the line given by <start>.
 	of the --date option at linkgit:git-log[1].
 
 -M|<num>|::
-	Detect moving lines in the file as well.  When a commit
-	moves a block of lines in a file (e.g. the original file
-	has A and then B, and the commit changes it to B and
-	then A), the traditional 'blame' algorithm typically blames
-	the lines that were moved up (i.e. B) to the parent and
-	assigns blame to the lines that were moved down (i.e. A)
-	to the child commit.  With this option, both groups of lines
-	are blamed on the parent.
+	Detect moving/copying lines in the file as well.  Instead of
+	taking blame for all '+' lines, attempt to find the same
+	lines 'in the same file' in the parent commit.  If such a
+	match was found, shift the blame to these lines in the
+	parent. (This expends extra effort on the order of the size
+	of the file for every change.)
++
+The net effect is that if code is moved or copied within the file, the
+lines are attributed to the original instead of the move/copy.
 +
 <num> is optional but it is the lower bound on the number of
 alphanumeric characters that git must detect as moving
 within a file for it to associate those lines with the parent
-commit.
+commit. And the default value is 20.
 
 -C|<num>|::
-	In addition to `-M`, detect lines copied from other
-	files that were modified in the same commit.  This is
-	useful when you reorganize your program and move code
-	around across files.  When this option is given twice,
-	the command additionally looks for copies from other
-	files in the commit that creates the file. When this
-	option is given three times, the command additionally
-	looks for copies from other files in any commit.
+	Like `-M`, detect moving/copying lines between files as well.
+	Instead of taking blame for all '+' lines, attempt to find the same
+	lines across file boundary according to the number of given `-C`.
+	This is useful when you reorganize your program and move/copy
+	code around across files. When this option is given once, detect
+	lines moved/copied from other files that were modified in the
+	same commit. (This expends extra effort on the order of
+	<number of modified files>*<file size> for every change.) When this
+	option is given twice, the command additionally looks for moves/copies
+	from other files in the commit that creates this file. (This expends
+	extra effort on the order of <number of files in the commit>*<file size>
+	for every change.) When this option is given three times, the
+	command additionally looks for moves/copies from other files
+	in any commit. (This expends extra effort on the order of
+	<commit number>*<number of files in one commit>*<file size>
+	for every change.)
 +
 <num> is optional but it is the lower bound on the number of
 alphanumeric characters that git must detect as moving
 between files for it to associate those lines with the parent
-commit.
+commit. And the default value is 40. If there are different values
+provided by different `-C` option, the last value will take effect finally.
 
 -h::
 --help::
-- 
1.7.0.2.273.gc2413.dirty
