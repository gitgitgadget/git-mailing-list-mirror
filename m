From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH] git: make "git -C '' <cmd>" not to barf
Date: Tue,  3 Mar 2015 21:11:31 +0530
Message-ID: <1425397291-25435-1-git-send-email-karthik.188@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 03 16:41:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSoxI-0005Ug-4T
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 16:41:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756728AbbCCPlv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 10:41:51 -0500
Received: from mail-pd0-f174.google.com ([209.85.192.174]:46163 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755968AbbCCPlu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2015 10:41:50 -0500
Received: by pdjy10 with SMTP id y10so49212132pdj.13
        for <git@vger.kernel.org>; Tue, 03 Mar 2015 07:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=rCtv1BAlAV5gl154Ic+KRx4rgLVWrPf5W8Rp9KHxakE=;
        b=f3Yvl11p+aq5xhh47rqdaBk1LvOts1XlLrqNlqsE8e3W0G2P4GixaM265SlJtx3q2C
         7ShGeZgQKRE/xoUwUZrzTv0IId14jJFqDMlAbN0JGhT1FogNZ7aFmZY4WncBbkG0j5FZ
         m8zKv6X8r3j4Nfh3zKUg+3FAryOLBhdGCpEQBIhO+sADAniz9sdYKEybBGIh/dHb6th0
         kDmALjc3B1r3IOjo+6mP8TF9Idf/fW+9oCoFeRhufEKUiDctCa8PuqAr+AW71FstLpJg
         Nsr2VsVpGSZRalgQSypTHwMZpH/jL0GEFD3vO2ofNdFjkv7e7m9I7wKJV9cE7m0MIm59
         bN8g==
X-Received: by 10.68.232.200 with SMTP id tq8mr56434365pbc.133.1425397310522;
        Tue, 03 Mar 2015 07:41:50 -0800 (PST)
Received: from ashley.localdomain ([103.227.98.178])
        by mx.google.com with ESMTPSA id br15sm1302194pdb.76.2015.03.03.07.41.48
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Mar 2015 07:41:49 -0800 (PST)
X-Mailer: git-send-email 2.3.1.167.g7f4ba4b.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264664>

now it works like cd "" which silently succeeds

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 git.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/git.c b/git.c
index 8c7ee9c..f4c2285 100644
--- a/git.c
+++ b/git.c
@@ -204,7 +204,9 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				fprintf(stderr, "No directory given for -C.\n" );
 				usage(git_usage_string);
 			}
-			if (chdir((*argv)[1]))
+			if (*(*argv)[1] == 0)
+				; /* Ignore "" as a directory */
+			else if (chdir((*argv)[1]))
 				die_errno("Cannot change to '%s'", (*argv)[1]);
 			if (envchanged)
 				*envchanged = 1;
-- 
2.3.1.167.g7f4ba4b.dirty
