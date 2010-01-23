From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH] If deriving SVN_SSH from GIT_SSH on msys, also add quotes
Date: Sat, 23 Jan 2010 11:22:13 +0100
Message-ID: <4B5ACDD5.8080007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, jugg@hotmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 23 11:23:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYd97-0006RJ-AF
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 11:23:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752705Ab0AWKXF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 05:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752506Ab0AWKXE
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 05:23:04 -0500
Received: from lo.gmane.org ([80.91.229.12]:47542 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751590Ab0AWKXA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 05:23:00 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NYd8s-0006N1-Ck
	for git@vger.kernel.org; Sat, 23 Jan 2010 11:22:58 +0100
Received: from 91-67-62-42-dynip.superkabel.de ([91.67.62.42])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 23 Jan 2010 11:22:58 +0100
Received: from sschuberth by 91-67-62-42-dynip.superkabel.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 23 Jan 2010 11:22:58 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 91-67-62-42-dynip.superkabel.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137833>

In contrast to GIT_SSH, SVN_SSH requires quotes for paths that contain
spaces. As GIT_SSH will not work if it contains quotes, it is save to
assume it never contains quotes. Also, adding quotes to SVN_SSH for paths
that do not contain spaces does no harm. So we always add quotes when
deriving SVN_SSH from GIT_SSH on msys.

This fixes msysGit issue 385, see
http://code.google.com/p/msysgit/issues/detail?id=385

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 git-svn.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 650c9e5..ef39a9f 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -26,6 +26,7 @@ if (! exists $ENV{SVN_SSH}) {
 		$ENV{SVN_SSH} = $ENV{GIT_SSH};
 		if ($^O eq 'msys') {
 			$ENV{SVN_SSH} =~ s/\\/\\\\/g;
+			$ENV{SVN_SSH} =~ s/(.*)/"$1"/;
 		}
 	}
 }
-- 
1.6.6.265.ga0f40
