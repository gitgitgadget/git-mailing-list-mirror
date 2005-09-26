From: Dan Aloni <da-x@monatomic.org>
Subject: [PATCH] wrap scp in cogito
Date: Tue, 27 Sep 2005 00:15:02 +0300
Message-ID: <20050926211502.GA27488@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 26 23:14:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EK0G9-0000dA-D1
	for gcvg-git@gmane.org; Mon, 26 Sep 2005 23:11:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbVIZVLa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 17:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbVIZVLa
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 17:11:30 -0400
Received: from noname.neutralserver.com ([70.84.186.210]:18412 "EHLO
	noname.neutralserver.com") by vger.kernel.org with ESMTP
	id S932088AbVIZVL3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2005 17:11:29 -0400
Received: from bzq-72-111.red.bezeqint.net
	([62.219.72.111]:48490 helo=callisto.yi.org ident=karrde)
	by noname.neutralserver.com with esmtpa (Exim 4.52)
	id 1EK0Fz-0007D5-UB; Mon, 26 Sep 2005 16:11:28 -0500
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - noname.neutralserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - monatomic.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9334>

Hello,

Since git allows to wrap ssh by the means of the GIT_SSH environment 
variable I think it would be appropriate to complete the picture and wrap 
the usage of scp in cogito by using the same measures. The patch follows.


diff --git a/cg-Xlib b/cg-Xlib
--- a/cg-Xlib
+++ b/cg-Xlib
@@ -471,6 +471,12 @@ if [ "$_git_requires_root" ] && [ "$_git
 	exit 1
 fi
 
+if [ "$GIT_SCP" != "" ] ; then
+    _cogito_scp=$GIT_SCP
+else
+    _cogito_scp=scp	
+fi
+
 
 # Backward compatibility hacks:
 # Fortunately none as of now.
diff --git a/cg-fetch b/cg-fetch
--- a/cg-fetch
+++ b/cg-fetch
@@ -206,7 +206,7 @@ get_ssh()
 		echo "Warning: Cannot protect against overwriting $dest when fetching over ssh" 2>/dev/null
 
 	[ "$directory" ] && dest=$(dirname "$dest")
-	scp $scp_flags "$src" "$dest"
+	${_cogito_scp} $scp_flags "$src" "$dest"
 }
 
 fetch_ssh()


-- 
Dan Aloni
da-x@monatomic.org, da-x@colinux.org, da-x@gmx.net
