From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Fix gcc-4 warning in accept() call
Date: Thu, 29 Sep 2005 17:05:01 -0400
Message-ID: <1128027901.24397.57.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Sep 29 23:05:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EL5aY-0003ny-37
	for gcvg-git@gmane.org; Thu, 29 Sep 2005 23:05:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbVI2VFF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 17:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbVI2VFE
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 17:05:04 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:49284 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751331AbVI2VFD
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2005 17:05:03 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EL5aQ-0001OV-LI
	for git@vger.kernel.org; Thu, 29 Sep 2005 17:05:02 -0400
Received: from proski by dv.roinet.com with local (Exim 4.52)
	id 1EL5aP-0001kG-LZ
	for git@vger.kernel.org; Thu, 29 Sep 2005 17:05:01 -0400
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9507>

Fix gcc-4 warning in accept() call

gcc-4 warns about sign mismatch in pointers.  Third argument in accept()
is socklen_t, which is unsigned.  Since Linus doesn't like socklen_t
(see commit 7fa090844f7d1624c7d1ffc621aae6aec84a1110), let's use
unsigned int.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/daemon.c b/daemon.c
--- a/daemon.c
+++ b/daemon.c
@@ -459,7 +459,7 @@ static int serve(int port)
 
 			if (FD_ISSET(sockfd, &fds)) {
 				struct sockaddr_storage ss;
-				int sslen = sizeof(ss);
+				unsigned int sslen = sizeof(ss);
 				int incoming = accept(sockfd, (struct sockaddr *)&ss, &sslen);
 				if (incoming < 0) {
 					switch (errno) {


-- 
Regards,
Pavel Roskin
