From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: [PATCH] zlib: fix compilation failures with Sun C Compilaer
Date: Mon, 22 Apr 2013 18:18:40 +0200
Message-ID: <97eabaedd6cd7d876812474a35fa2d3d63dfec4a.1366647415.git.stefano.lattarini@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 22 18:18:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUJSE-0005ig-2l
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 18:18:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753360Ab3DVQSx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 12:18:53 -0400
Received: from mail-wg0-f52.google.com ([74.125.82.52]:41716 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753301Ab3DVQSx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 12:18:53 -0400
Received: by mail-wg0-f52.google.com with SMTP id k13so1042358wgh.31
        for <git@vger.kernel.org>; Mon, 22 Apr 2013 09:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=Ao+cBzC/sR4Rdd1XALB5qiYLD9QMYMRQSCUqEbEb38c=;
        b=nujRrPz9y7pKkgLwuaipQlxOF13jXRJbdjFgk00r58fFqPFJhHy0H0/1q0GTSvOAu+
         g+x7lnjnsYoJltxIUhVs3f+RBRiXZ7k1S2biy0wIRVyuackqW/R3Cwwk87MJ6SVv6LDl
         iWio0yql8napdG5GMSSdpBjfYwFDwdLfkVyODlHkqAOXlRTfenBB0navLF7noAqUfpHG
         BzkbNamHZ2xrJcqrVV0eEFVaSVkjuWubz9A6y0y1nPpYRpoCpgRFCrUby/Il5ZbzdLyy
         uq3/nFJom/Hq9W9CTxfQEhcMIDjptiyMPxl9lUNjWtrgKh9ZQpaYJUDWJiq4XWSwfDFl
         F/mQ==
X-Received: by 10.180.21.193 with SMTP id x1mr30172876wie.31.1366647528851;
        Mon, 22 Apr 2013 09:18:48 -0700 (PDT)
Received: from localhost.localdomain (host93-95-dynamic.6-79-r.retail.telecomitalia.it. [79.6.95.93])
        by mx.google.com with ESMTPS id d8sm23036171wiv.10.2013.04.22.09.18.46
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 22 Apr 2013 09:18:47 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.389.gcaa7d79
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222036>

Do this by removing a couple of useless return statements.  Without this
change, compilation with Sun C Compiler 5.9 (SunOS_i386 Patch 124868-15
2010/08/11) fails with the following message:

  "zlib.c", line 192: void function cannot return value
  "zlib.c", line 201: void function cannot return value
  cc: acomp failed for zlib.c

Signed-off-by: Stefano Lattarini <stefano.lattarini@gmail.com>
---
 zlib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/zlib.c b/zlib.c
index bbaa081..61e6df0 100644
--- a/zlib.c
+++ b/zlib.c
@@ -189,7 +189,7 @@ void git_deflate_init_gzip(git_zstream *strm, int level)
 	 * Use default 15 bits, +16 is to generate gzip header/trailer
 	 * instead of the zlib wrapper.
 	 */
-	return do_git_deflate_init(strm, level, 15 + 16);
+	do_git_deflate_init(strm, level, 15 + 16);
 }
 
 void git_deflate_init_raw(git_zstream *strm, int level)
@@ -198,7 +198,7 @@ void git_deflate_init_raw(git_zstream *strm, int level)
 	 * Use default 15 bits, negate the value to get raw compressed
 	 * data without zlib header and trailer.
 	 */
-	return do_git_deflate_init(strm, level, -15);
+	do_git_deflate_init(strm, level, -15);
 }
 
 int git_deflate_abort(git_zstream *strm)
-- 
1.8.1.rc3.897.gb3600c3
