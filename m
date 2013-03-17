From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] fast-export: rename handle_object function
Date: Sun, 17 Mar 2013 04:33:12 -0400
Message-ID: <20130317083312.GA30183@sigill.intra.peff.net>
References: <20130317083235.GA29907@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 17 09:33:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UH92N-00016k-Iw
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 09:33:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756083Ab3CQIdY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Mar 2013 04:33:24 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54193 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756062Ab3CQIdX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Mar 2013 04:33:23 -0400
Received: (qmail 7892 invoked by uid 107); 17 Mar 2013 08:34:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 17 Mar 2013 04:34:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Mar 2013 04:33:12 -0400
Content-Disposition: inline
In-Reply-To: <20130317083235.GA29907@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218351>

The handle_object function is rather vaguely named; it only
operates on blobs, and its purpose is to export the blob to
the output stream. Let's call it "export_blob" to make it
more clear what it does.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fast-export.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 77dffd1..3eba852 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -113,7 +113,7 @@ static void show_progress(void)
 		printf("progress %d objects\n", counter);
 }
 
-static void handle_object(const unsigned char *sha1)
+static void export_blob(const unsigned char *sha1)
 {
 	unsigned long size;
 	enum object_type type;
@@ -312,7 +312,7 @@ static void handle_commit(struct commit *commit, struct rev_info *rev)
 	/* Export the referenced blobs, and remember the marks. */
 	for (i = 0; i < diff_queued_diff.nr; i++)
 		if (!S_ISGITLINK(diff_queued_diff.queue[i]->two->mode))
-			handle_object(diff_queued_diff.queue[i]->two->sha1);
+			export_blob(diff_queued_diff.queue[i]->two->sha1);
 
 	mark_next_object(&commit->object);
 	if (!is_encoding_utf8(encoding))
@@ -512,7 +512,7 @@ static void get_tags_and_duplicates(struct rev_cmdline_info *info,
 				commit = (struct commit *)tag;
 				break;
 			case OBJ_BLOB:
-				handle_object(tag->object.sha1);
+				export_blob(tag->object.sha1);
 				continue;
 			default: /* OBJ_TAG (nested tags) is already handled */
 				warning("Tag points to object of unexpected type %s, skipping.",
-- 
1.8.2.rc2.7.gef06216
