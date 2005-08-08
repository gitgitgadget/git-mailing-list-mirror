From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH] Make curl fail on server error
Date: Mon, 08 Aug 2005 10:53:23 +0100
Message-ID: <20050808095323.31602.76855.stgit@localhost.localdomain>
X-From: git-owner@vger.kernel.org Mon Aug 08 11:56:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E24MI-0007YK-2P
	for gcvg-git@gmane.org; Mon, 08 Aug 2005 11:55:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbVHHJyb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Aug 2005 05:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbVHHJyb
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Aug 2005 05:54:31 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:11482 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S1750792AbVHHJya (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2005 05:54:30 -0400
Received: from cam-mail2.cambridge.arm.com (cam-mail2.cambridge.arm.com [10.1.127.39])
	by cam-admin0.cambridge.arm.com (8.12.10/8.12.10) with ESMTP id j789reOU010603
	for <git@vger.kernel.org>; Mon, 8 Aug 2005 10:53:41 +0100 (BST)
Received: from ZIPPY.Emea.Arm.com (cam-exch2.emea.arm.com [10.1.255.58])
	by cam-mail2.cambridge.arm.com (8.9.3/8.9.3) with ESMTP id KAA20195
	for <git@vger.kernel.org>; Mon, 8 Aug 2005 10:54:29 +0100 (BST)
Received: from localhost.localdomain ([10.1.69.144]) by ZIPPY.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.211);
	 Mon, 8 Aug 2005 10:53:54 +0100
To: git@vger.kernel.org
X-OriginalArrivalTime: 08 Aug 2005 09:53:54.0330 (UTC) FILETIME=[1650FFA0:01C59BFF]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Some http servers return an HTML error page and git reads it as normal
data. Adding -f option makes curl fail silently.

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---

 git-clone-dumb-http  |    2 +-
 git-fetch-script     |    2 +-
 git-ls-remote-script |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-clone-dumb-http b/git-clone-dumb-http
--- a/git-clone-dumb-http
+++ b/git-clone-dumb-http
@@ -14,7 +14,7 @@ if [ -n "$GIT_SSL_NO_VERIFY" ]; then
 fi
 http_fetch () {
 	# $1 = Remote, $2 = Local
-	curl -ns $curl_extra_args "$1" >"$2"
+	curl -nsf $curl_extra_args "$1" >"$2"
 }
 
 cd "$D" && 
diff --git a/git-fetch-script b/git-fetch-script
--- a/git-fetch-script
+++ b/git-fetch-script
@@ -15,7 +15,7 @@ http://* | https://*)
         fi
 	_x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]' &&
 	_x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40" &&
-	head=$(curl -ns $curl_extra_args "$merge_repo/$merge_head") &&
+	head=$(curl -nsf $curl_extra_args "$merge_repo/$merge_head") &&
 	expr "$head" : "$_x40\$" >/dev/null || {
 		echo >&2 "Failed to fetch $merge_head from $merge_repo"
 	        exit 1
diff --git a/git-ls-remote-script b/git-ls-remote-script
--- a/git-ls-remote-script
+++ b/git-ls-remote-script
@@ -46,7 +46,7 @@ http://* | https://* )
         if [ -n "$GIT_SSL_NO_VERIFY" ]; then
             curl_extra_args="-k"
         fi
-	curl -ns $curl_extra_args "$peek_repo/info/refs" || exit 1
+	curl -nsf $curl_extra_args "$peek_repo/info/refs" || exit 1
 	;;
 
 rsync://* )
