From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] git-clone: better error message if curl program is missing
Date: Fri, 7 Sep 2007 17:13:59 +0000
Message-ID: <20070907171400.28590.qmail@d780fac1e27de6.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 19:13:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IThOt-0004jS-Hn
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 19:13:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757611AbXIGRNl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 13:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757631AbXIGRNl
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 13:13:41 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:38461 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757611AbXIGRNk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 13:13:40 -0400
Received: (qmail 28592 invoked by uid 1000); 7 Sep 2007 17:14:00 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58053>

If the curl program is not available, and git clone is started to clone a
repository through http, this is the output

 Initialized empty Git repository in /tmp/puppet/.git/
 /usr/bin/git-clone: line 37: curl: command not found
 Cannot get remote repository information.
 Perhaps git-update-server-info needs to be run there?

This patch improves the error message by testing for availability of the
curl program before running it, the error output now is

 Initialized empty Git repository in /tmp/puppet/.git/
 The curl program is not available

Adrian Bridgett noticed this and reported through
 http://bugs.debian.org/440976

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 git-clone.sh |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index 18003ab..834371d 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -34,6 +34,8 @@ fi
 
 http_fetch () {
 	# $1 = Remote, $2 = Local
+	type curl >/dev/null 2>&1 ||
+	    die "The curl program is not available"
 	curl -nsfL $curl_extra_args "$1" >"$2"
 }
 
-- 
1.5.3.1
