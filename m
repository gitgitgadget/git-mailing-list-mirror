From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 4/4] t6000lib: workaround a possible dash bug
Date: Thu, 25 May 2006 19:06:18 -0700
Message-ID: <11486091792604-git-send-email-normalperson@yhbt.net>
References: <11486091793385-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: git@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
	Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri May 26 04:06:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjRif-00077O-Fu
	for gcvg-git@gmane.org; Fri, 26 May 2006 04:06:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030221AbWEZCGX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 22:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030218AbWEZCGW
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 22:06:22 -0400
Received: from hand.yhbt.net ([66.150.188.102]:7318 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1030216AbWEZCGU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 May 2006 22:06:20 -0400
Received: by hand.yhbt.net (Postfix, from userid 500)
	id 93F077DC023; Thu, 25 May 2006 19:06:19 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.3.2.g7d11
In-Reply-To: <11486091793385-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20778>

pdksh doesn't need this patch, of course bash works fine since
that what most users use.

Normally, 'var=val command' seems to work fine with dash, but
perhaps there's something weird going on with "$@".  dash is
pretty widespread, so it'll be good to support this even though
it does seem like a bug in dash.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 t/t6000lib.sh |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

cba907ce0b1c0927fb15cbb5dd91a4129ff9a950
diff --git a/t/t6000lib.sh b/t/t6000lib.sh
index c6752af..d402621 100755
--- a/t/t6000lib.sh
+++ b/t/t6000lib.sh
@@ -69,7 +69,9 @@ on_committer_date()
 {
     _date=$1
     shift 1
-    GIT_COMMITTER_DATE=$_date "$@"
+    export GIT_COMMITTER_DATE="$_date"
+    "$@"
+    unset GIT_COMMITTER_DATE
 }
 
 # Execute a command and suppress any error output.
-- 
1.3.2.g7d11
