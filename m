From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 20/86] http: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:06:13 +0100
Message-ID: <20131109070720.18178.55408.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:09:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2fY-00036C-MH
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:09:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933304Ab3KIHJC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:09:02 -0500
Received: from mail-3y.bbox.fr ([194.158.98.45]:54160 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933263Ab3KIHId (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:33 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 075F668;
	Sat,  9 Nov 2013 08:08:28 +0100 (CET)
X-git-sha1: 71c0c2a90aaa51644d3938bdf08ff97614ed9e88 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237493>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 http.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/http.c b/http.c
index f3e1439..f2621cd 100644
--- a/http.c
+++ b/http.c
@@ -422,7 +422,7 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 		credential_from_url(&http_auth, url);
 		if (!ssl_cert_password_required &&
 		    getenv("GIT_SSL_CERT_PASSWORD_PROTECTED") &&
-		    !prefixcmp(url, "https://"))
+		    has_prefix(url, "https://"))
 			ssl_cert_password_required = 1;
 	}
 
@@ -985,7 +985,7 @@ int http_fetch_ref(const char *base, struct ref *ref)
 		strbuf_rtrim(&buffer);
 		if (buffer.len == 40)
 			ret = get_sha1_hex(buffer.buf, ref->old_sha1);
-		else if (!prefixcmp(buffer.buf, "ref: ")) {
+		else if (has_prefix(buffer.buf, "ref: ")) {
 			ref->symref = xstrdup(buffer.buf + 5);
 			ret = 0;
 		}
@@ -1084,8 +1084,8 @@ int http_get_info_packs(const char *base_url, struct packed_git **packs_head)
 		case 'P':
 			i++;
 			if (i + 52 <= buf.len &&
-			    !prefixcmp(data + i, " pack-") &&
-			    !prefixcmp(data + i + 46, ".pack\n")) {
+			    has_prefix(data + i, " pack-") &&
+			    has_prefix(data + i + 46, ".pack\n")) {
 				get_sha1_hex(data + i + 6, sha1);
 				fetch_and_setup_pack_index(packs_head, sha1,
 						      base_url);
-- 
1.8.4.1.566.geca833c
