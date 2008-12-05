From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH 2/3] Make chdir failures visible
Date: Fri, 5 Dec 2008 01:36:46 +0100
Message-ID: <20081205003646.GB7294@blimp.localdomain>
References: <20081205003546.GA7294@blimp.localdomain>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 05 01:38:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8Ohq-0000hf-JD
	for gcvg-git-2@gmane.org; Fri, 05 Dec 2008 01:38:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936AbYLEAgu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2008 19:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751919AbYLEAgt
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 19:36:49 -0500
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:19026 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751873AbYLEAgt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2008 19:36:49 -0500
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :Pm0FVUW6aauhRGJJc5OfA4AU8DM8ZlijdmJYxKn/UQvEQQx8Ak82pR9a
Received: from tigra.home (Fadd1.f.strato-dslnet.de [195.4.173.209])
	by post.strato.de (klopstock mo60) (RZmta 17.20)
	with ESMTP id x054dckB4M3XDR ; Fri, 5 Dec 2008 01:36:47 +0100 (MET)
Received: from blimp.localdomain (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id EE77B277C8;
	Fri,  5 Dec 2008 01:36:46 +0100 (CET)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 00A6936D27; Fri,  5 Dec 2008 01:36:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081205003546.GA7294@blimp.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102382>

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 git.c   |    4 ++--
 setup.c |    3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/git.c b/git.c
index 9e5813c..940a498 100644
--- a/git.c
+++ b/git.c
@@ -195,8 +195,8 @@ static int handle_alias(int *argcp, const char ***argv)
 		ret = 1;
 	}
 
-	if (subdir)
-		chdir(subdir);
+	if (subdir && chdir(subdir))
+		die("Cannot change to %s: %s", subdir, strerror(errno));
 
 	errno = saved_errno;
 
diff --git a/setup.c b/setup.c
index 78a8041..833ced2 100644
--- a/setup.c
+++ b/setup.c
@@ -470,7 +470,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
 			}
 			die("Not a git repository");
 		}
-		chdir("..");
+		if (chdir(".."))
+			die("Cannot change to %s/..: %s", cwd, strerror(errno));
 	}
 
 	inside_git_dir = 0;
-- 
1.6.1.rc1.29.gb140
