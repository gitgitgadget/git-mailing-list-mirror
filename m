From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 1/5] trailer: ignore comment lines inside the trailers
Date: Sun, 09 Nov 2014 10:23:39 +0100
Message-ID: <20141109092344.4864.68904.chriscool@tuxfamily.org>
References: <20141109092313.4864.54933.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 09 10:29:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnOoR-0007zW-45
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 10:29:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904AbaKIJ33 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2014 04:29:29 -0500
Received: from [194.158.98.15] ([194.158.98.15]:60649 "EHLO mail-2y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751541AbaKIJ1h (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2014 04:27:37 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id B61E958;
	Sun,  9 Nov 2014 10:27:14 +0100 (CET)
X-git-sha1: bbd20666c99e29f0484bca021d32ab3f448a05b4 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20141109092313.4864.54933.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Otherwise trailers that are commented out might be
processed. We would also error out if the comment line
char is also a separator.

This means that comments inside a trailer block will
disappear, but that was already the case anyway.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 trailer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/trailer.c b/trailer.c
index 8514566..761b763 100644
--- a/trailer.c
+++ b/trailer.c
@@ -804,8 +804,10 @@ static int process_input_file(struct strbuf **lines,
 
 	/* Parse trailer lines */
 	for (i = trailer_start; i < patch_start; i++) {
-		struct trailer_item *new = create_trailer_item(lines[i]->buf);
-		add_trailer_item(in_tok_first, in_tok_last, new);
+		if (lines[i]->buf[0] != comment_line_char) {
+			struct trailer_item *new = create_trailer_item(lines[i]->buf);
+			add_trailer_item(in_tok_first, in_tok_last, new);
+		}
 	}
 
 	return patch_start;
-- 
2.1.2.555.gfbecd99
