From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [RFC/PATCH] fast-import: Fix compile warnings
Date: Wed, 7 Feb 2007 12:38:21 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702071237360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 07 12:38:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEl86-0004Ea-Mx
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 12:38:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161219AbXBGLiX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 06:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161220AbXBGLiX
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 06:38:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:52928 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161219AbXBGLiX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 06:38:23 -0500
Received: (qmail invoked by alias); 07 Feb 2007 11:38:22 -0000
X-Provags-ID: V01U2FsdGVkX1/U1yozZZLUC2aLPSbrK+qV+OlRYHJ0M5Af58GdOs
	Vb7Q==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38914>


Not on all platforms are size_t and unsigned long equivalent.
Since I do not know how portable %z is, I play safe, and just
cast the respective variables to unsigned long.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	I have no idea how portable %z is, but there are so many
	experts on this list. Care to enlighten me?

 fast-import.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index bc95a0d..2813ceb 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -882,7 +882,8 @@ static int store_object(
 	SHA_CTX c;
 	z_stream s;
 
-	hdrlen = sprintf((char*)hdr,"%s %lu",type_names[type],datlen) + 1;
+	hdrlen = sprintf((char*)hdr,"%s %lu", type_names[type],
+		(unsigned long)datlen) + 1;
 	SHA1_Init(&c);
 	SHA1_Update(&c, hdr, hdrlen);
 	SHA1_Update(&c, dat, datlen);
@@ -1427,7 +1428,8 @@ static void *cmd_data (size_t *size)
 		while (n < length) {
 			size_t s = fread(buffer + n, 1, length - n, stdin);
 			if (!s && feof(stdin))
-				die("EOF in data (%lu bytes remaining)", length - n);
+				die("EOF in data (%lu bytes remaining)",
+					(unsigned long)(length - n));
 			n += s;
 		}
 	}
@@ -2028,7 +2030,8 @@ int main(int argc, const char **argv)
 	fprintf(stderr, "      marks:     %10ju (%10ju unique    )\n", (((uintmax_t)1) << marks->shift) * 1024, marks_set_count);
 	fprintf(stderr, "      atoms:     %10u\n", atom_cnt);
 	fprintf(stderr, "Memory total:    %10ju KiB\n", (total_allocd + alloc_count*sizeof(struct object_entry))/1024);
-	fprintf(stderr, "       pools:    %10lu KiB\n", total_allocd/1024);
+	fprintf(stderr, "       pools:    %10lu KiB\n",
+		(unsigned long)(total_allocd / 1024));
 	fprintf(stderr, "     objects:    %10ju KiB\n", (alloc_count*sizeof(struct object_entry))/1024);
 	fprintf(stderr, "---------------------------------------------------------------------\n");
 	pack_report();
-- 
1.5.0.rc3.2124.g3861-dirty
