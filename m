From: Dennis Stosberg <dennis@stosberg.net>
Subject: [PATCH] git-write-tree writes garbage on sparc64
Date: Sun, 28 May 2006 21:08:08 +0200
Message-ID: <20060528190808.G7cae5a8a@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun May 28 21:08:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkQcf-0000C9-9F
	for gcvg-git@gmane.org; Sun, 28 May 2006 21:08:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbWE1TIP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 May 2006 15:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750871AbWE1TIP
	(ORCPT <rfc822;git-outgoing>); Sun, 28 May 2006 15:08:15 -0400
Received: from v345.ncsrv.de ([89.110.145.104]:43393 "EHLO ncs.stosberg.net")
	by vger.kernel.org with ESMTP id S1750869AbWE1TIP (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 May 2006 15:08:15 -0400
Received: from leonov.stosberg.net (p213.54.89.85.tisdip.tiscali.de [213.54.89.85])
	by ncs.stosberg.net (Postfix) with ESMTP id D57B2589000C
	for <git@vger.kernel.org>; Sun, 28 May 2006 21:08:00 +0200 (CEST)
Received: by leonov.stosberg.net (Postfix, from userid 500)
	id A523B104434; Sun, 28 May 2006 21:08:08 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
Received: from leonov ([unix socket]) by leonov (Cyrus v2.1.18-IPv6-Debian-2.1.18-1+sarge2) with LMTP; Sun, 28 May 2006 20:38:41 +0200
X-Sieve: CMU Sieve 2.2
User-Agent: mutt-ng/devel-r802 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20889>

In the "next" branch, write_index_ext_header() writes garbage on a
64-bit big-endian machine; the written index file will be unreadable.
I noticed this on NetBSD/sparc64. Reproducible with:

$ git init-db
$ :>file
$ git-update-index --add file
$ git-write-tree
$ git-update-index
error: index uses  extension, which we do not understand
fatal: index file corrupt

Signed-off-by: Dennis Stosberg <dennis@stosberg.net>
---
 read-cache.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 36bd4ea..c499c51 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -826,7 +826,7 @@ static int ce_write(SHA_CTX *context, in
 }
 
 static int write_index_ext_header(SHA_CTX *context, int fd,
-				  unsigned long ext, unsigned long sz)
+				  unsigned int ext, unsigned int sz)
 {
 	ext = htonl(ext);
 	sz = htonl(sz);
-- 
1.3.3.g3c38f
