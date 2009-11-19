From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] t9700-perl-git.sh: Fix a test failure on Cygwin
Date: Thu, 19 Nov 2009 18:41:20 +0000
Message-ID: <4B059150.5050303@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 19 20:02:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBCGY-0001K7-OZ
	for gcvg-git-2@lo.gmane.org; Thu, 19 Nov 2009 20:02:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754326AbZKSTBv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 14:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754240AbZKSTBu
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 14:01:50 -0500
Received: from anchor-post-3.mail.demon.net ([195.173.77.134]:55344 "EHLO
	anchor-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753035AbZKSTBu (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Nov 2009 14:01:50 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1NBCGR-0001nH-nh; Thu, 19 Nov 2009 19:01:55 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133244>


The t/t9700/test.pl script uses method invocation syntax when
using the Cwd module to determine the current working directory.
This fails on cygwin, since cygwin perl specifically checks for
any arguments to the cwd() function and croak()'s with the message
"Usage: Cwd::cwd()". (In perl v5.8.8 distribution, see the file
perl-5.8.8/cygwin/cygwin.c lines 139-157)

In order to avoid the problem, we replace the method invocation
syntax with a simple function call.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 t/t9700/test.pl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t9700/test.pl b/t/t9700/test.pl
index 6c70aec..666722d 100755
--- a/t/t9700/test.pl
+++ b/t/t9700/test.pl
@@ -13,7 +13,7 @@ use File::Basename;
 BEGIN { use_ok('Git') }
 
 # set up
-our $abs_repo_dir = Cwd->cwd;
+our $abs_repo_dir = cwd();
 ok(our $r = Git->repository(Directory => "."), "open repository");
 
 # config
-- 
1.6.5
