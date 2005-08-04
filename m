From: Holger Eitzenberger <holger@my-eitzenberger.de>
Subject: [PATCH 1/1] git: use git_mkstemp() instead of mkstemp()
Date: Thu, 04 Aug 2005 22:49:49 +0200
Message-ID: <42F27F6D.5070903@my-eitzenberger.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070803060705060901010501"
X-From: git-owner@vger.kernel.org Fri Aug 05 01:11:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0oqK-00027c-AW
	for gcvg-git@gmane.org; Fri, 05 Aug 2005 01:09:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262696AbVHDUyK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Aug 2005 16:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262673AbVHDUwK
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Aug 2005 16:52:10 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:63738 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262670AbVHDUtx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2005 16:49:53 -0400
Received: from p54A3A6FD.dip0.t-ipconnect.de [84.163.166.253] (helo=[192.168.11.11])
	by mrelayeu.kundenserver.de with ESMTP (Nemesis),
	id 0ML21M-1E0mey3hzA-00052l; Thu, 04 Aug 2005 22:49:48 +0200
User-Agent: Debian Thunderbird 1.0.2 (X11/20050715)
X-Accept-Language: en-us, en
To: git <git@vger.kernel.org>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:8548cd0e00552bb75411ff34ad15700a
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------070803060705060901010501
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

prep_temp_blob: use git_mkstemp() instead of mkstemp()

/holger

--------------070803060705060901010501
Content-Type: text/x-patch;
 name="git_use_git_mkstemp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="git_use_git_mkstemp.patch"

prep_temp_blob: use git_mkstemp() instead of mkstemp()

---
commit 43bac92063c8dd8d88b33cb838530d4bb3dcad25
tree aeb8bdc2aa285df1fc4888e66fe88b4a8a5e2b3b
parent 1a1f2cb5c27ed26e6ef8dd34209e561bdf256c22
author Holger Eitzenberger <holger@my-eitzenberger.de> Thu, 04 Aug 2005 22:30:43 +0200
committer Holger Eitzenberger <holger@elmo.intranet.astaro.de> Thu, 04 Aug 2005 22:30:43 +0200

 diff.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -41,11 +41,13 @@ static const char *external_diff(void)
 	return external_diff_cmd;
 }
 
+#define TEMPFILE_PATH_LEN		50
+
 static struct diff_tempfile {
 	const char *name; /* filename external diff should read from */
 	char hex[41];
 	char mode[10];
-	char tmp_path[50];
+	char tmp_path[TEMPFILE_PATH_LEN];
 } diff_temp[2];
 
 static int count_lines(const char *filename)
@@ -421,8 +423,7 @@ static void prep_temp_blob(struct diff_t
 {
 	int fd;
 
-	strcpy(temp->tmp_path, ".diff_XXXXXX");
-	fd = mkstemp(temp->tmp_path);
+	fd = git_mkstemp(temp->tmp_path, TEMPFILE_PATH_LEN, ".diff_XXXXXX");
 	if (fd < 0)
 		die("unable to create temp-file");
 	if (write(fd, blob, size) != size)

--------------070803060705060901010501--
