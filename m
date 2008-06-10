From: "Philippe Bruhat (BooK)" <book@cpan.org>
Subject: [PATCH] git-cvsimport: do not fail when CVSROOT is /
Date: Tue, 10 Jun 2008 14:32:06 +0200
Message-ID: <1213101126-4974-1-git-send-email-book@cpan.org>
Cc: gitster@pobox.com, "Philippe Bruhat (BooK)" <book@cpan.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 10 15:11:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K63dN-0004MK-SJ
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 15:11:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753513AbYFJNKk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 09:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753458AbYFJNKk
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 09:10:40 -0400
Received: from zlonk.bruhat.net ([91.121.102.217]:52619 "EHLO
	ks354402.kimsufi.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753450AbYFJNKj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 09:10:39 -0400
X-Greylist: delayed 2279 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Jun 2008 09:10:39 EDT
Received: from localhost ([127.0.0.1] helo=plop)
	by ks354402.kimsufi.com with esmtp (Exim 4.63)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1K62zf-00045X-0I; Tue, 10 Jun 2008 14:30:31 +0200
Received: from book by plop with local (Exim 4.69)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1K631C-0001J9-Vm; Tue, 10 Jun 2008 14:32:07 +0200
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <>
References: <>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84499>

For CVS repositories with unusual CVSROOT, git-cvsimport would fail:

    $ git-cvsimport -v -C foo -d :pserver:anon:@cvs.example.com:/ foo
    AuthReply: error 0 : no such repository

This patch ensures that the path is never empty, but at least '/'.

Signed-off-by: Philippe Bruhat (BooK) <book@cpan.org>
---
 git-cvsimport.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 5a02550..cacbfc0 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -227,6 +227,7 @@ sub conn {
 				$proxyport = $1;
 			}
 		}
+		$repo ||= '/';
 
 		# if username is not explicit in CVSROOT, then use current user, as cvs would
 		$user=(getlogin() || $ENV{'LOGNAME'} || $ENV{'USER'} || "anonymous") unless $user;
-- 
1.5.4.3
