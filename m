From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] parseopt: do not translate empty help string
Date: Mon, 20 Aug 2012 20:24:56 +0200
Message-ID: <bcb1f4437760452f967737fddf26dff019d0f0b2.1345487066.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 20 20:25:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3WfI-0004u5-N0
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 20:25:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937Ab2HTSZX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 14:25:23 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:52109 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750775Ab2HTSZV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 14:25:21 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 20 Aug
 2012 20:25:17 +0200
Received: from thomas.inf.ethz.net (46.126.8.85) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 20 Aug
 2012 20:25:18 +0200
X-Mailer: git-send-email 1.7.12.rc1.203.gc3c8071
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203865>

The gettext .po files have a header, but it looks like the translation
specification for an empty string.  This results in _("") actually
returning that header.

Prevent parseopt from passing empty strings to gettext when it
displays help about commands.  In some instances it already did this,
but git-grep's --or etc. caught another case.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 parse-options.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/parse-options.c b/parse-options.c
index c1c66bd..f95bbb2 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -562,7 +562,8 @@ static int usage_with_options_internal(struct parse_opt_ctx_t *ctx,
 			fputc('\n', outfile);
 			pad = USAGE_OPTS_WIDTH;
 		}
-		fprintf(outfile, "%*s%s\n", pad + USAGE_GAP, "", _(opts->help));
+		fprintf(outfile, "%*s%s\n", pad + USAGE_GAP, "",
+			*opts->help ? _(opts->help) : "");
 	}
 	fputc('\n', outfile);
 
-- 
1.7.12.rc1.203.gc3c8071
