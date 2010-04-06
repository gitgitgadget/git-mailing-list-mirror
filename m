From: Chris Webb <chris@arachsys.com>
Subject: [PATCH] git-instaweb: pass through invoking user's path to gitweb
 CGI script
Date: Tue, 6 Apr 2010 17:57:21 +0100
Message-ID: <20100406165721.GH28707@arachsys.com>
References: <186fa4afcc08ad6ba10906a231c437536fbdb8e9.1270412075.git.chris@arachsys.com>
 <7vk4sm7vao.fsf@alter.siamese.dyndns.org>
 <20100404222801.GB31315@arachsys.com>
 <20100406163525.GF15306@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 06 18:57:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzC5w-0006cV-Ae
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 18:57:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757368Ab0DFQ50 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Apr 2010 12:57:26 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:46118 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757333Ab0DFQ5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 12:57:24 -0400
Received: from [83.104.159.199] (helo=miranda.arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.52)
	id 1NzC5a-0001zL-DT; Tue, 06 Apr 2010 17:57:23 +0100
Content-Disposition: inline
In-Reply-To: <20100406163525.GF15306@arachsys.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144158>

When used with lighttpd or mongoose, git-instaweb previously passed a
hard-coded, default value of PATH to the gitweb CGI script. Use the invoking
user's value for PATH for this instead. (This is already the behaviour for
other web servers supported by git-instaweb.)

Signed-off-by: Chris Webb <chris@arachsys.com>
---
 git-instaweb.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index 6a65f25..0e1cb07 100755
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
