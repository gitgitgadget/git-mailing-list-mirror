From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: [PATCH] Bugfix: stop if directory already exists
Date: Sun, 13 Nov 2005 15:03:31 +0100
Message-ID: <200511131503.32078.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 13 15:04:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbISX-0005fd-52
	for gcvg-git@gmane.org; Sun, 13 Nov 2005 15:03:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbVKMODh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Nov 2005 09:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932500AbVKMODh
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Nov 2005 09:03:37 -0500
Received: from mail.gmx.de ([213.165.64.20]:23221 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932495AbVKMODg (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Nov 2005 09:03:36 -0500
Received: (qmail invoked by alias); 13 Nov 2005 14:03:34 -0000
Received: from p549699FE.dip0.t-ipconnect.de (EHLO [192.168.178.21]) [84.150.153.254]
  by mail.gmx.net (mp019) with SMTP; 13 Nov 2005 15:03:34 +0100
X-Authenticated: #352111
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.8.2
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11740>

Fix a typo: We do not want to run the directory as command,
and want to terminate if the directory exists
Additionally, update the usage message

Signed-off-by: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>

---

Regarding the usage: I do not think that on an error condition
the usage string should be outputted. This helps nothing:
either the user knows the usage, and can see what is wrong by
the error message, or he should look up the man page.
Should we use "git clone" or "git-clone" in the usage message?
Or perhaps
 usage: git clone ...
 For more details, see 'man git-clone'
?

 git-clone.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

applies-to: 62fad3f1275b9bbf07fba50c328a3bd730c3454c
3de065bff303bd4caa433dfa685fdc1164be2b81
diff --git a/git-clone.sh b/git-clone.sh
index f99e0ad..c09979a 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -9,7 +9,7 @@
 unset CDPATH
 
 usage() {
-	echo >&2 "* git clone [-l [-s]] [-q] [-u <upload-pack>] [-n] <repo> <dir>"
+	echo >&2 "* git clone [-l [-s]] [-q] [-u <upload-pack>] [-n] <repo> [<dir>]"
 	exit 1
 }
 
@@ -98,7 +98,7 @@ fi
 dir="$2"
 # Try using "humanish" part of source repo if user didn't specify one
 [ -z "$dir" ] && dir=$(echo "$repo" | sed -e 's|/$||' -e 's|:*/*\.git$||' -e 's|.*/||g')
-[ -e "$dir" ] && $(echo "$dir already exists."; usage)
+[ -e "$dir" ] && echo "$dir already exists." && usage
 mkdir -p "$dir" &&
 D=$(
 	(cd "$dir" && git-init-db && pwd)
---
0.99.9.GIT
