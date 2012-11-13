From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v4 3/4] diff: rename "set" variable
Date: Tue, 13 Nov 2012 21:12:46 +0530
Message-ID: <1352821367-3611-4-git-send-email-artagnon@gmail.com>
References: <http://mid.gmane.org/1352653146-3932-1-git-send-email-artagnon@gmail.com>
 <1352821367-3611-1-git-send-email-artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 13 16:43:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYIe1-0000rr-DX
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 16:43:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752317Ab2KMPnE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 10:43:04 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:37022 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753389Ab2KMPnB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 10:43:01 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so5097397pad.19
        for <git@vger.kernel.org>; Tue, 13 Nov 2012 07:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=p61Py1Ca9R4NW0DvbENMRGpVD/pb9yKolN04MsiFJaU=;
        b=rs47XI8a1qErsVxbJjwEnrcS9uanYlCU3hdFgS+nZOw/Ioo5YOaMuTxdQKqkJ+kwge
         efTftO3jgU+eKcdxlCGWw2n/CDv+uXMaMbmXXaMgrL7gnyYDi5i6/kNjhkeCcHYWTcHw
         EDfcVhFhAyCx8ssOOKNwFGWXyblhrvSVx2QOcQ0QnidOGPopQSTFTOVg6+nceGW68+dY
         AEyxduKhN2/gZ3/wF129hT4OgnbNZiBAyyYb9UPynTZx8AWgjgcSOLFoo2qkopX8JOjb
         7IWMkDASZxYWrJ49sx9M6UzewMReOmf6sOTJK9txgtJuLRK1PE1lyenBbBekaF7/7+2W
         5sNg==
Received: by 10.68.189.5 with SMTP id ge5mr68371900pbc.1.1352821381198;
        Tue, 13 Nov 2012 07:43:01 -0800 (PST)
Received: from localhost.localdomain ([49.206.137.123])
        by mx.google.com with ESMTPS id hs2sm3546550pbc.22.2012.11.13.07.42.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Nov 2012 07:43:00 -0800 (PST)
X-Mailer: git-send-email 1.7.8.1.362.g5d6df.dirty
In-Reply-To: <1352821367-3611-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209621>

From: Jeff King <peff@peff.net>

Once upon a time the builtin_diff function used one color, and the color
variables were called "set" and "reset". Nowadays it is a much longer
function and we use several colors (e.g., "add", "del"). Rename "set" to
"meta" to show that it is the color for showing diff meta-info (it still
does not indicate that it is a "color", but at least it matches the
scheme of the other color variables).

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 diff.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index 7f2a255..ffaed72 100644
--- a/diff.c
+++ b/diff.c
@@ -2240,7 +2240,7 @@ static void builtin_diff(const char *name_a,
 	mmfile_t mf1, mf2;
 	const char *lbl[2];
 	char *a_one, *b_two;
-	const char *set = diff_get_color_opt(o, DIFF_METAINFO);
+	const char *meta = diff_get_color_opt(o, DIFF_METAINFO);
 	const char *reset = diff_get_color_opt(o, DIFF_RESET);
 	const char *a_prefix, *b_prefix;
 	struct userdiff_driver *textconv_one = NULL;
@@ -2287,24 +2287,24 @@ static void builtin_diff(const char *name_a,
 	b_two = quote_two(b_prefix, name_b + (*name_b == '/'));
 	lbl[0] = DIFF_FILE_VALID(one) ? a_one : "/dev/null";
 	lbl[1] = DIFF_FILE_VALID(two) ? b_two : "/dev/null";
-	strbuf_addf(&header, "%s%sdiff --git %s %s%s\n", line_prefix, set, a_one, b_two, reset);
+	strbuf_addf(&header, "%s%sdiff --git %s %s%s\n", line_prefix, meta, a_one, b_two, reset);
 	if (lbl[0][0] == '/') {
 		/* /dev/null */
-		strbuf_addf(&header, "%s%snew file mode %06o%s\n", line_prefix, set, two->mode, reset);
+		strbuf_addf(&header, "%s%snew file mode %06o%s\n", line_prefix, meta, two->mode, reset);
 		if (xfrm_msg)
 			strbuf_addstr(&header, xfrm_msg);
 		must_show_header = 1;
 	}
 	else if (lbl[1][0] == '/') {
-		strbuf_addf(&header, "%s%sdeleted file mode %06o%s\n", line_prefix, set, one->mode, reset);
+		strbuf_addf(&header, "%s%sdeleted file mode %06o%s\n", line_prefix, meta, one->mode, reset);
 		if (xfrm_msg)
 			strbuf_addstr(&header, xfrm_msg);
 		must_show_header = 1;
 	}
 	else {
 		if (one->mode != two->mode) {
-			strbuf_addf(&header, "%s%sold mode %06o%s\n", line_prefix, set, one->mode, reset);
-			strbuf_addf(&header, "%s%snew mode %06o%s\n", line_prefix, set, two->mode, reset);
+			strbuf_addf(&header, "%s%sold mode %06o%s\n", line_prefix, meta, one->mode, reset);
+			strbuf_addf(&header, "%s%snew mode %06o%s\n", line_prefix, meta, two->mode, reset);
 			must_show_header = 1;
 		}
 		if (xfrm_msg)
-- 
1.7.8.1.362.g5d6df.dirty
