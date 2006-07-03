From: Joachim B Haga <cjhaga@fys.uio.no>
Subject: [PATCH] Use configurable zlib compression level everywhere.
Date: 03 Jul 2006 21:02:29 +0200
Message-ID: <8564ie8qbe.fsf_-_@lupus.ig3.net>
References: <loom.20060703T124601-969@post.gmane.org> <81b0412b0607030503p63b4ee31v7776bd155d3dab29@mail.gmail.com> <44A91C7A.6090902@fys.uio.no> <Pine.LNX.4.64.0607031030150.1213@localhost.localdomain> <Pine.LNX.4.64.0607030929490.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Linus Torvalds <torvalds@osdl.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Jul 03 21:05:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxTjL-0006qz-CL
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 21:05:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbWGCTFG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 15:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbWGCTFG
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 15:05:06 -0400
Received: from main.gmane.org ([80.91.229.2]:3712 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751033AbWGCTFF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Jul 2006 15:05:05 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1FxTjC-0006ov-Ek
	for git@vger.kernel.org; Mon, 03 Jul 2006 21:05:02 +0200
Received: from 67.80-203-45.nextgentel.com ([80.203.45.67])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Jul 2006 21:05:02 +0200
Received: from cjhaga by 67.80-203-45.nextgentel.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Jul 2006 21:05:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 67.80-203-45.nextgentel.com
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23192>

This one I'm not so sure about, it's for completeness. But I don't actually use
git and haven't tested beyond the git add / git commit stage. Still...

Signed-off-by: Joachim B Haga (cjhaga@fys.uio.no)
---
 csum-file.c |    2 +-
 diff.c      |    2 +-
 http-push.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/csum-file.c b/csum-file.c
index ebaad03..6a7b40f 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -122,7 +122,7 @@ int sha1write_compressed(struct sha1file
        void *out;
 
        memset(&stream, 0, sizeof(stream));
-       deflateInit(&stream, Z_DEFAULT_COMPRESSION);
+       deflateInit(&stream, zlib_compression_level);
        maxsize = deflateBound(&stream, size);
        out = xmalloc(maxsize);
 
diff --git a/diff.c b/diff.c
index 5a71489..428ff78 100644
--- a/diff.c
+++ b/diff.c
@@ -583,7 +583,7 @@ static unsigned char *deflate_it(char *d
        z_stream stream;
 
        memset(&stream, 0, sizeof(stream));
-       deflateInit(&stream, Z_BEST_COMPRESSION);
+       deflateInit(&stream, zlib_compression_level);
        bound = deflateBound(&stream, size);
        deflated = xmalloc(bound);
        stream.next_out = deflated;
diff --git a/http-push.c b/http-push.c
index e281f70..f761584 100644
--- a/http-push.c
+++ b/http-push.c
@@ -492,7 +492,7 @@ static void start_put(struct transfer_re
 
        /* Set it up */
        memset(&stream, 0, sizeof(stream));
-       deflateInit(&stream, Z_BEST_COMPRESSION);
+       deflateInit(&stream, zlib_compression_level);
        size = deflateBound(&stream, len + hdrlen);
        request->buffer.buffer = xmalloc(size);
 
-- 
1.4.1.g8fced-dirty
