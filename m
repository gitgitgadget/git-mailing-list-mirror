From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] setup_git_directory_gently: fix off-by-one error
Date: Sun, 11 Mar 2007 02:35:00 +0100
Message-ID: <20070311013459.GA30057@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 11 02:35:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQCxq-0006T9-Sh
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 02:35:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbXCKBfF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 20:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbXCKBfF
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 20:35:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:56093 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932281AbXCKBfC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 20:35:02 -0500
Received: (qmail invoked by alias); 11 Mar 2007 01:35:01 -0000
Received: from pD9EBB157.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.177.87]
  by mail.gmx.net (mp044) with SMTP; 11 Mar 2007 02:35:01 +0100
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX19mlAREKGtmoMh7JZTzzJpphVsnJjS8JQp/y5TDxI
	sj6c6t33DwkS9G
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41890>

don't tell getcwd that the buffer has one spare byte for an extra /

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
gdb session with PATH_MAX set to 2048:
Breakpoint 5, setup_git_directory_gently (nongit_ok=0x0) at
setup.c:253
253             cwd[len] = 0;
$ print sizeof(cwd)
$14 = 2049
$ print len
$15 = 2049
$ print PATH_MAX
$16 = 2048
---
 setup.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/setup.c b/setup.c
index dda67d2..a45ea83 100644
--- a/setup.c
+++ b/setup.c
@@ -216,7 +216,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		die("Not a git repository: '%s'", gitdirenv);
 	}
 
-	if (!getcwd(cwd, sizeof(cwd)) || cwd[0] != '/')
+	if (!getcwd(cwd, sizeof(cwd)-1) || cwd[0] != '/')
 		die("Unable to read current working directory");
 
 	offset = len = strlen(cwd);
-- 
1.5.0.3
