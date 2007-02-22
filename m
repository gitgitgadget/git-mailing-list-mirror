From: Fredrik Kuivinen <frekui@gmail.com>
Subject: [PATCH] Fix 'git commit -a' in a newly initialized repository
Date: Thu, 22 Feb 2007 21:28:12 +0100
Message-ID: <20070222202812.8882.44375.stgit@c165>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 22 21:28:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKKY7-000224-1L
	for gcvg-git@gmane.org; Thu, 22 Feb 2007 21:28:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847AbXBVU2P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 15:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751833AbXBVU2P
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 15:28:15 -0500
Received: from mxfep01.bredband.com ([195.54.107.70]:49904 "EHLO
	mxfep01.bredband.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847AbXBVU2O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 15:28:14 -0500
Received: from ironport2.bredband.com ([195.54.107.84] [195.54.107.84])
          by mxfep01.bredband.com with ESMTP
          id <20070222202812.SMTZ3634.mxfep01.bredband.com@ironport2.bredband.com>
          for <git@vger.kernel.org>; Thu, 22 Feb 2007 21:28:12 +0100
Received: from c-f766e455.09-360-6c6b701.cust.bredbandsbolaget.se (HELO c165) ([85.228.102.247])
  by ironport2.bredband.com with ESMTP; 22 Feb 2007 21:28:12 +0100
Received: from c165 ([127.0.0.1])
	by c165 with esmtp (Exim 3.36 #1 (Debian))
	id 1HKKY0-0002JN-00
	for <git@vger.kernel.org>; Thu, 22 Feb 2007 21:28:12 +0100
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40381>


With current git:

$ git init
$ git commit -a
cp: cannot stat `.git/index': No such file or directory

Output a nice error message instead.

Signed-off-by: Fredrik Kuivinen <frekui@gmail.com>

---

 git-commit.sh |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/git-commit.sh b/git-commit.sh
index ec506d9..476f4f1 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -318,6 +318,10 @@ esac
 
 case "$all,$also" in
 t,)
+	if test ! -f "$THIS_INDEX"
+	then
+		die 'nothing to commit (use "git add file1 file2" to include for commit)'
+	fi
 	save_index &&
 	(
 		cd_to_toplevel &&
