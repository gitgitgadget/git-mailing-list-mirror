From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 4/6] diff: add diff_line_prefix function
Date: Thu,  7 Feb 2013 20:15:26 +0000
Message-ID: <dfb0c8fc336ae6e125e5307311e8b49425d06aa5.1360267849.git.john@keeping.me.uk>
References: <cover.1360267849.git.john@keeping.me.uk>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 07 21:23:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3Y0W-0001X8-5J
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 21:23:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171Ab3BGUXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 15:23:09 -0500
Received: from pichi.aluminati.org ([72.9.246.58]:37245 "EHLO
	pichi.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759355Ab3BGUXF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 15:23:05 -0500
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 3F47D161E4FB;
	Thu,  7 Feb 2013 20:15:53 +0000 (GMT)
X-Quarantine-ID: <SeRDW1qTKMxP>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SeRDW1qTKMxP; Thu,  7 Feb 2013 20:15:53 +0000 (GMT)
Received: from river.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 9DAFC161E4D6;
	Thu,  7 Feb 2013 20:15:47 +0000 (GMT)
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <cover.1360267849.git.john@keeping.me.uk>
In-Reply-To: <cover.1360267849.git.john@keeping.me.uk>
References: <cover.1360267849.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215727>

This is a helper function to call the diff output_prefix function and
return its value as a C string, allowing us to greatly simplify
everywhere that needs to get the output prefix.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 diff.c | 10 ++++++++++
 diff.h |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/diff.c b/diff.c
index 73ae02d..ed14d5d 100644
--- a/diff.c
+++ b/diff.c
@@ -1105,6 +1105,16 @@ const char *diff_get_color(int diff_use_color, enum color_diff ix)
 	return "";
 }
 
+const char *diff_line_prefix(struct diff_options *opt)
+{
+	struct strbuf *msgbuf;
+	if (!opt->output_prefix)
+		return "";
+
+	msgbuf = opt->output_prefix(opt, opt->output_prefix_data);
+	return msgbuf->buf;
+}
+
 static unsigned long sane_truncate_line(struct emit_callback *ecb, char *line, unsigned long len)
 {
 	const char *cp;
diff --git a/diff.h b/diff.h
index a47bae4..76830e2 100644
--- a/diff.h
+++ b/diff.h
@@ -174,6 +174,9 @@ const char *diff_get_color(int diff_use_color, enum color_diff ix);
 	diff_get_color((o)->use_color, ix)
 
 
+const char *diff_line_prefix(struct diff_options *);
+
+
 extern const char mime_boundary_leader[];
 
 extern void diff_tree_setup_paths(const char **paths, struct diff_options *);
-- 
1.8.1.2
