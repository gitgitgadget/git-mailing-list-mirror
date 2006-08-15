From: Dennis Stosberg <dennis@stosberg.net>
Subject: [PATCH 3/6] Look for sockaddr_storage in sys/socket.h
Date: Tue, 15 Aug 2006 11:01:25 +0200
Message-ID: <20060815090125.5223.70700.stgit@leonov.stosberg.net>
References: <20060815090031.5223.27458.stgit@leonov.stosberg.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Tue Aug 15 11:01:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCunp-0001xX-DV
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 11:01:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932772AbWHOJBc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Aug 2006 05:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932766AbWHOJBc
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Aug 2006 05:01:32 -0400
Received: from ncs.stosberg.net ([89.110.145.104]:62911 "EHLO ncs.stosberg.net")
	by vger.kernel.org with ESMTP id S965304AbWHOJB3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Aug 2006 05:01:29 -0400
Received: from leonov.stosberg.net (p213.54.74.221.tisdip.tiscali.de [213.54.74.221])
	by ncs.stosberg.net (Postfix) with ESMTP id 919EA589000B
	for <git@vger.kernel.org>; Tue, 15 Aug 2006 11:01:23 +0200 (CEST)
Received: from leonov.stosberg.net (leonov.stosberg.net [127.0.0.1])
	by leonov.stosberg.net (Postfix) with ESMTP id 59FF1121739
	for <git@vger.kernel.org>; Tue, 15 Aug 2006 11:01:25 +0200 (CEST)
To: git@vger.kernel.org
In-Reply-To: <20060815090031.5223.27458.stgit@leonov.stosberg.net>
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25449>

On Solaris and the BSDs the definition of "struct sockaddr_storage"
is not available from "netinet/in.h".  On Solaris "sys/socket.h" is 
enough, at least OpenBSD needs "sys/types.h", too.

Using "sys/types.h" and "sys/socket.h" seems to be a more portable
way.

Signed-off-by: Dennis Stosberg <dennis@stosberg.net>
---

 configure.ac |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index e890131..0321d43 100644
--- a/configure.ac
+++ b/configure.ac
@@ -181,8 +181,10 @@ # Define NO_SOCKADDR_STORAGE if your pla
 # sockaddr_storage.
 AC_CHECK_TYPE(struct sockaddr_storage,
 [NO_SOCKADDR_STORAGE=],
-[NO_SOCKADDR_STORAGE=YesPlease],
-[#include <netinet/in.h>])
+[NO_SOCKADDR_STORAGE=YesPlease],[
+#include <sys/types.h>
+#include <sys/socket.h>
+])
 AC_SUBST(NO_SOCKADDR_STORAGE)
 #
 # Define NO_IPV6 if you lack IPv6 support and getaddrinfo().
