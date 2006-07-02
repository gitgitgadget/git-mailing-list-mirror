From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] instaweb: fix unportable ';' usage in sed
Date: Sun, 2 Jul 2006 04:56:16 -0700
Message-ID: <20060702115616.GA28291@soma>
References: <7vr7145u17.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0607021109540.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 02 13:56:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fx0Yp-0005DK-A2
	for gcvg-git@gmane.org; Sun, 02 Jul 2006 13:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbWGBL4T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Jul 2006 07:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbWGBL4T
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Jul 2006 07:56:19 -0400
Received: from hand.yhbt.net ([66.150.188.102]:53390 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932323AbWGBL4S (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Jul 2006 07:56:18 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id C06757DC021;
	Sun,  2 Jul 2006 04:56:16 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun,  2 Jul 2006 04:56:16 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0607021109540.29667@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23104>

Hint taken from Johannes.  I've tested this with sed --posix on
my system with GNU sed and it works fine with and also without
it.  Further portability testing/review would be good.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---

 Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
 > 
 > Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
 > ---
 > 	Re: What's in git.git
 > 
 > 	On Sun, 2 Jul 2006, Junio C Hamano wrote:
 > 
 > 	>  - instaweb by Eric Wong.
 > 
 > 	This breaks make on _all_ platforms I have.
 > 
 > 	First of all, it is _ugly_ (three invocations of sed, where one 
 > 	really is sufficient). Then, it uses the non-portable ';' 
 > 	operator, and then, the non-at-all-portable 'T'.
 > 
 > 	And worst: it is unnecessary.

 *Blushes*  Sorry about that, I've been meaning to brush up on my
 sed skills (coming from a Perl-heavy environment).

 git-instaweb.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index 51067d9..69aef3c 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -194,9 +194,9 @@ EOF
 }
 
 script='
-s#^\(my\|our\) $projectroot =.*#\1 $projectroot = "'`dirname $fqgitdir`'";#;
-s#\(my\|our\) $gitbin =.*#\1 $gitbin = "'$GIT_EXEC_PATH'";#;
-s#\(my\|our\) $projects_list =.*#\1 $projects_list = $projectroot;#;
+s#^\(my\|our\) $projectroot =.*#\1 $projectroot = "'`dirname $fqgitdir`'";#
+s#\(my\|our\) $gitbin =.*#\1 $gitbin = "'$GIT_EXEC_PATH'";#
+s#\(my\|our\) $projects_list =.*#\1 $projects_list = $projectroot;#
 s#\(my\|our\) $git_temp =.*#\1 $git_temp = "'$fqgitdir/gitweb/tmp'";#'
 
 gitweb_cgi () {
-- 
1.4.1.rc2.gbc4f
