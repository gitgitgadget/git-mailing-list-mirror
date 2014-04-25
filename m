From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 try2 04/14] grep: add --staged option
Date: Fri, 25 Apr 2014 13:12:37 -0500
Message-ID: <1398449567-16314-5-git-send-email-felipe.contreras@gmail.com>
References: <1398449567-16314-1-git-send-email-felipe.contreras@gmail.com>
Cc: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	William Swanson <swansontec@gmail.com>,
	Ping Yin <pkufranky@gmail.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 25 20:23:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wdkmn-0006WE-FK
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 20:23:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753216AbaDYSXg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 14:23:36 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:44970 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753166AbaDYSXd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 14:23:33 -0400
Received: by mail-ob0-f173.google.com with SMTP id wn1so4696754obc.32
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 11:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OyCbtAuw7tXEHFyejfD1USE8s8ZJQ5kvcqCrcWWhFpE=;
        b=hoDHrxLWGPE+1MFLyQCzJU5zr7rZWxZNljyuVwfcRN4SotjvhckK2jh7M9/iaNf3kK
         m37Xp3jkC/WuQlHj4JtH4cMs2Q4y/m0M+kkbyJQ6VjYZkBmdIkTCPxwiRZOWo3Z/JbkI
         +T5sONSWYEdlifdLJB6wELp0iAkdXhkkCuMsmLwp24QH6opcuGR2i0XPtj9vWJrUgba8
         d2Hf5fHmPNoRxR8gdOJPV6yYSCzXTox5wJWISAWOkXQIlWVPXe5OPCWEjmcqAqRpo3GM
         ZpIXDUpnyYHt2Ru0Fza9fkEAei9tNwJvJ/muPodqMOlJkOeZnm+bU8T7D6ILYzIVpe4D
         clfA==
X-Received: by 10.182.241.9 with SMTP id we9mr1799005obc.81.1398450213563;
        Fri, 25 Apr 2014 11:23:33 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id d9sm34727691oex.6.2014.04.25.11.23.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Apr 2014 11:23:32 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.2.gfbaae8c
In-Reply-To: <1398449567-16314-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247076>

Synonym for --cached.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-grep.txt | 5 ++++-
 builtin/grep.c             | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index f837334..6ed84d7 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -25,7 +25,7 @@ SYNOPSIS
 	   [-W | --function-context]
 	   [-f <file>] [-e] <pattern>
 	   [--and|--or|--not|(|)|-e <pattern>...]
-	   [ [--[no-]exclude-standard] [--cached | --no-index | --untracked] | <tree>...]
+	   [ [--[no-]exclude-standard] [--cached | --staged | --no-index | --untracked] | <tree>...]
 	   [--] [<pathspec>...]
 
 DESCRIPTION
@@ -60,6 +60,9 @@ OPTIONS
 	Instead of searching tracked files in the working tree, search
 	blobs registered in the index file.
 
+--staged::
+	Synonym for `--cached`.
+
 --no-index::
 	Search files in the current directory that is not managed by Git.
 
diff --git a/builtin/grep.c b/builtin/grep.c
index 69ac2d8..dc2edaf 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -638,6 +638,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_BOOL(0, "cached", &cached,
 			N_("search in index instead of in the work tree")),
+		OPT_BOOL(0, "staged", &cached,
+			N_("search in index instead of in the work tree")),
 		OPT_NEGBIT(0, "no-index", &use_index,
 			 N_("find in contents not managed by git"), 1),
 		OPT_BOOL(0, "untracked", &untracked,
-- 
1.9.2+fc1.2.gfbaae8c
