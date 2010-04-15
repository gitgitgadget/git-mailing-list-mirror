From: Chris Webb <chris@arachsys.com>
Subject: [PATCH] git-instaweb: pass through invoking user's path to gitweb
 CGI scripts
Date: Thu, 15 Apr 2010 14:29:45 +0100
Message-ID: <59ee8c7a3052ed747b5dbaa0a1d0e51aded9c413.1271337968.git.chris@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 15 15:30:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2P8v-0005sw-Ej
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 15:30:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753912Ab0DON3u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 09:29:50 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:42699 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403Ab0DON3t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 09:29:49 -0400
Received: from [83.104.159.199] (helo=miranda.arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.52)
	id 1O2P8c-0005YQ-G0; Thu, 15 Apr 2010 14:29:46 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144985>

When used with lighttpd or mongoose, git-instaweb previously passed a
hard-coded, default value of PATH to the gitweb CGI script. Use the invoking
user's value for PATH for this instead. (This is already implicitly the
behaviour for other web servers supported by git-instaweb.)

Signed-off-by: Chris Webb <chris@arachsys.com>
---
 git-instaweb.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index d4941a9..f608014 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -212,7 +212,7 @@ server.errorlog = "$fqgitdir/gitweb/error.log"
 # variable above and uncomment this
 #accesslog.filename = "$fqgitdir/gitweb/access.log"
 
-setenv.add-environment = ( "PATH" => "/usr/local/bin:/usr/bin:/bin" )
+setenv.add-environment = ( "PATH" => env.PATH )
 
 cgi.assign = ( ".cgi" => "" )
 
@@ -361,7 +361,7 @@ error_log	$fqgitdir/gitweb/error.log
 access_log	$fqgitdir/gitweb/access.log
 
 #cgi setup
-cgi_env		PATH=/usr/local/bin:/usr/bin:/bin,GIT_DIR=$GIT_DIR,GIT_EXEC_PATH=$GIT_EXEC_PATH
+cgi_env		PATH=$PATH,GIT_DIR=$GIT_DIR,GIT_EXEC_PATH=$GIT_EXEC_PATH
 cgi_interp	$PERL
 cgi_ext		cgi,pl
 
-- 
1.7.0.3
