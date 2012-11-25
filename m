From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 2/8] xml_entities(): use function strbuf_addstr_xml_quoted()
Date: Sun, 25 Nov 2012 12:08:35 +0100
Message-ID: <1353841721-16269-3-git-send-email-mhagger@alum.mit.edu>
References: <1353841721-16269-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeremy White <jwhite@codeweavers.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 25 12:09:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tca5k-0004G0-SL
	for gcvg-git-2@plane.gmane.org; Sun, 25 Nov 2012 12:09:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753144Ab2KYLJR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 06:09:17 -0500
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:44172 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753125Ab2KYLJO (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Nov 2012 06:09:14 -0500
X-AuditID: 12074412-b7f216d0000008e3-41-50b1fc59769b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 33.C1.02275.95CF1B05; Sun, 25 Nov 2012 06:09:13 -0500 (EST)
Received: from michael.fritz.box (p57A25314.dip.t-dialin.net [87.162.83.20])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id qAPB90UE002898
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 25 Nov 2012 06:09:12 -0500
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353841721-16269-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsUixO6iqBv5Z2OAQf8RC4uuK91MFg29V5gt
	+pd3sVlcPjmX0eL2ivnMDqwef99/YPL4crWRyePDxziPi5eUPT5vkgtgjeK2SUosKQvOTM/T
	t0vgzlh//zBzwXT2igWtG5gaGE+ydjFyckgImEg8bl3PBmGLSVy4B2JzcQgJXGaUeLD5CSOE
	c4ZJ4vD8e8wgVWwCuhKLepqZQGwRATWJiW2HWECKmAVWM0pM3nKeHSQhLOAjsfniaqBuDg4W
	AVWJUx8SQMK8Ai4Sk29ug9omJ/FhzyOwck4BV4kf+x6AxYWAajZf2M84gZF3ASPDKka5xJzS
	XN3cxMyc4tRk3eLkxLy81CJdM73czBK91JTSTYyQkBLawbj+pNwhRgEORiUe3puJGwOEWBPL
	iitzDzFKcjApifLO/QoU4kvKT6nMSCzOiC8qzUktPsQowcGsJMIb+gwox5uSWFmVWpQPk5Lm
	YFES5/25WN1PSCA9sSQ1OzW1ILUIJivDwaEkwdv+G6hRsCg1PbUiLTOnBCHNxMEJIrhANvAA
	bZgPUshbXJCYW5yZDlF0ilFRSpy3HiQhAJLIKM2DGwCL/leM4kD/CPOuBaniASYOuO5XQIOZ
	gAYnXwcbXJKIkJJqYOxh6r8e+Co0ZZvCv/sNx2ZqWQutWT1n95XJrOzbngpNDYhjXFc7e7Jw
	w87AB/F/PVKZm8NPvb57b/b0/u6IHh6p7q29CueqTlpk3bCvm6H7f4pSWet+c9M73amh3nGK
	+kvFFz2T8EkoMuR+nHTQRCaGk+vVLp3jBbOX/7gWlvxCxWFF/hxrbyWW4oxEQy3m 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210360>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 http-push.c | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/http-push.c b/http-push.c
index 8701c12..9923441 100644
--- a/http-push.c
+++ b/http-push.c
@@ -172,28 +172,7 @@ enum dav_header_flag {
 static char *xml_entities(const char *s)
 {
 	struct strbuf buf = STRBUF_INIT;
-	while (*s) {
-		size_t len = strcspn(s, "\"<>&");
-		strbuf_add(&buf, s, len);
-		s += len;
-		switch (*s) {
-		case '"':
-			strbuf_addstr(&buf, "&quot;");
-			break;
-		case '<':
-			strbuf_addstr(&buf, "&lt;");
-			break;
-		case '>':
-			strbuf_addstr(&buf, "&gt;");
-			break;
-		case '&':
-			strbuf_addstr(&buf, "&amp;");
-			break;
-		case 0:
-			return strbuf_detach(&buf, NULL);
-		}
-		s++;
-	}
+	strbuf_addstr_xml_quoted(&buf, s);
 	return strbuf_detach(&buf, NULL);
 }
 
-- 
1.8.0
