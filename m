From: Jeff King <peff@peff.net>
Subject: [PATCH] git-commit: allow -e option anywhere on command line
Date: Fri, 23 Jun 2006 09:43:38 -0400
Message-ID: <20060623134338.GA12630@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 23 15:58:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtmAY-0008FD-04
	for gcvg-git@gmane.org; Fri, 23 Jun 2006 15:57:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbWFWN5n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 09:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbWFWN5l
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 09:57:41 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:36748 "HELO
	peff.net") by vger.kernel.org with SMTP id S1750718AbWFWNnk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Jun 2006 09:43:40 -0400
Received: (qmail 7873 invoked from network); 23 Jun 2006 09:43:19 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 23 Jun 2006 09:43:19 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Jun 2006 09:43:38 -0400
To: junkio@cox.net
Mail-Followup-To: junkio@cox.net, git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22421>

Previously, the command 'git-commit -e -m foo' would ignore the '-e' option
because the '-m' option overwrites the no_edit flag during sequential
option parsing. Now we cause -e to reset the no_edit flag after all
options are parsed.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-commit.sh |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/git-commit.sh b/git-commit.sh
index 6dd04fd..4bb16db 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -199,6 +199,7 @@ only=
 logfile=
 use_commit=
 amend=
+edit_flag=
 no_edit=
 log_given=
 log_message=
@@ -246,7 +247,7 @@ do
       shift
       ;;
   -e|--e|--ed|--edi|--edit)
-      no_edit=
+      edit_flag=t
       shift
       ;;
   -i|--i|--in|--inc|--incl|--inclu|--includ|--include)
@@ -384,6 +385,7 @@ do
       ;;
   esac
 done
+case "$edit_flag" in t) no_edit= ;; esac 
 
 ################################################################
 # Sanity check options
-- 
1.4.1.rc1.gf603-dirty
