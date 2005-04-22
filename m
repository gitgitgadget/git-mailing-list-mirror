From: Andreas Gal <gal@uci.edu>
Subject: compiling git with ZLIB < 1.2
Date: Fri, 22 Apr 2005 15:12:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504221508530.22285@sam.ics.uci.edu>
References: <S262157AbVDVVWs/20050422212248Z+375@vger.kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sat Apr 23 00:08:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP6Jn-0006nK-L6
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 00:08:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbVDVWMW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 18:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbVDVWMW
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 18:12:22 -0400
Received: from sam.ics.uci.edu ([128.195.38.141]:28137 "EHLO sam.ics.uci.edu")
	by vger.kernel.org with ESMTP id S261191AbVDVWMI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2005 18:12:08 -0400
Received: from sam.ics.uci.edu (localhost.localdomain [127.0.0.1])
	by sam.ics.uci.edu (8.12.11/8.12.11) with ESMTP id j3MMC6fl022292
	for <git@vger.kernel.org>; Fri, 22 Apr 2005 15:12:06 -0700
Received: from localhost (gal@localhost)
	by sam.ics.uci.edu (8.12.11/8.12.8/Submit) with ESMTP id j3MMC60X022288
	for <git@vger.kernel.org>; Fri, 22 Apr 2005 15:12:06 -0700
X-Authentication-Warning: sam.ics.uci.edu: gal owned process doing -bs
X-X-Sender: gal@sam.ics.uci.edu
To: git@vger.kernel.org
In-Reply-To: <S262157AbVDVVWs/20050422212248Z+375@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


deflateBound() was added in ZLIB 1.2, but there is unfortunately no easy 
way to check against the ZLIB version. I would suggest to use the fix 
below until everyone has a recent ZLIB installed (neither my RHEL3 nor my 
Darwin box does by default).

Andreas

--- a/sha1_file.c
+++ b/sha1_file.c
@@ -240,7 +240,11 @@ int write_sha1_file(char *buf, unsigned 
 	/* Set it up */
 	memset(&stream, 0, sizeof(stream));
 	deflateInit(&stream, Z_BEST_COMPRESSION);
+#ifdef ONCE_EVERYONE_UPDATED_TO_ZLIB_12
 	size = deflateBound(&stream, len);
+#else	
+	size = len + ((len + 7) >> 3) + ((len + 63) >> 6) + 11;
+#endif	
 	compressed = malloc(size);
 
 	/* Compress it */
