From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: [PATCH] Allow passing of --directory to git-am.
Date: Thu, 04 Dec 2008 18:04:04 +0100
Message-ID: <49380D84.5050403@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 04 18:39:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8IAZ-0004gE-Ls
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 18:39:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759206AbYLDRh4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2008 12:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759183AbYLDRhz
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 12:37:55 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:53995 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759067AbYLDRhy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2008 12:37:54 -0500
X-Greylist: delayed 2026 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Dec 2008 12:37:54 EST
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id B33591C25E
	for <git@vger.kernel.org>; Thu,  4 Dec 2008 18:04:05 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id AMtkAeK46KZo for <git@vger.kernel.org>;
	Thu,  4 Dec 2008 18:04:05 +0100 (CET)
Received: from [192.168.10.11] (dyn.144-85-212-018.dsl.vtx.ch [144.85.212.18])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 82D331C0A9
	for <git@vger.kernel.org>; Thu,  4 Dec 2008 18:04:05 +0100 (CET)
User-Agent: Thunderbird 2.0.0.17 (X11/20081021)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102351>

We need to play some shell tricks to be able to pass directory names
which contain spaces and/or quotes.

Signed-off-by: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
---
  git-am.sh |    8 +++++---
  1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index aa60261..4052d7d 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -16,6 +16,7 @@ s,signoff       add a Signed-off-by line to the commit 
message
  u,utf8          recode into utf8 (default)
  k,keep          pass -k flag to git-mailinfo
  whitespace=     pass it through git-apply
+directory=      pass it through git-apply
  C=              pass it through git-apply
  p=              pass it through git-apply
  resolvemsg=     override error message when patch failure occurs
@@ -155,8 +156,9 @@ do
  		;;
  	--resolvemsg)
  		shift; resolvemsg=$1 ;;
-	--whitespace)
-		git_apply_opt="$git_apply_opt $1=$2"; shift ;;
+	--whitespace|--directory)
+		quot=$(echo "$2" | sed -e "s/'/\\'/g")
+		git_apply_opt="$git_apply_opt $1='$quot'"; shift ;;
  	-C|-p)
  		git_apply_opt="$git_apply_opt $1$2"; shift ;;
  	--)
@@ -454,7 +456,7 @@ do

  	case "$resolved" in
  	'')
-		git apply $git_apply_opt --index "$dotest/patch"
+		eval git apply $git_apply_opt --index '"$dotest/patch"'
  		apply_status=$?
  		;;
  	t)
-- 
1.6.1.rc1.45.g123ed.dirty
