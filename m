From: Jeff King <peff@peff.net>
Subject: [PATCH v3 06/19] upload-archive: do not copy repo name
Date: Wed, 20 Feb 2013 15:00:59 -0500
Message-ID: <20130220200059.GF25647@sigill.intra.peff.net>
References: <20130220195147.GA25332@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 20 21:01:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8Fr5-0003uc-Ca
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 21:01:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934779Ab3BTUBB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 15:01:01 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54577 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934553Ab3BTUBB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 15:01:01 -0500
Received: (qmail 17677 invoked by uid 107); 20 Feb 2013 20:02:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Feb 2013 15:02:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Feb 2013 15:00:59 -0500
Content-Disposition: inline
In-Reply-To: <20130220195147.GA25332@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216720>

According to the comment, enter_repo will modify its input.
However, this has not been the case since 1c64b48
(enter_repo: do not modify input, 2011-10-04). Drop the
now-useless copy.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/upload-archive.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index b928beb..c3d134e 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -27,13 +27,8 @@ int cmd_upload_archive_writer(int argc, const char **argv, const char *prefix)
 	if (argc != 2)
 		usage(upload_archive_usage);
 
-	if (strlen(argv[1]) + 1 > sizeof(buf))
-		die("insanely long repository name");
-
-	strcpy(buf, argv[1]); /* enter-repo smudges its argument */
-
-	if (!enter_repo(buf, 0))
-		die("'%s' does not appear to be a git repository", buf);
+	if (!enter_repo(argv[1], 0))
+		die("'%s' does not appear to be a git repository", argv[1]);
 
 	/* put received options in sent_argv[] */
 	sent_argc = 1;
-- 
1.8.2.rc0.9.g352092c
