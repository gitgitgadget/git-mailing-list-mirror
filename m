From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 2/5] utf8: fix iconv error detection
Date: Sun, 16 Feb 2014 16:06:03 +0000
Message-ID: <53061a27144d1cbafd509c3b5a13e642a9ea400a.1392565571.git.john@keeping.me.uk>
References: <cover.1392565571.git.john@keeping.me.uk>
Cc: John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 16 17:06:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WF4F2-0007zt-WC
	for gcvg-git-2@plane.gmane.org; Sun, 16 Feb 2014 17:06:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752786AbaBPQGs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Feb 2014 11:06:48 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:35771 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752620AbaBPQG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Feb 2014 11:06:28 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 2BD10CDA2D4;
	Sun, 16 Feb 2014 16:06:28 +0000 (GMT)
X-Quarantine-ID: <okYJoARgDedB>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id okYJoARgDedB; Sun, 16 Feb 2014 16:06:27 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id ED887CDA590;
	Sun, 16 Feb 2014 16:06:27 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id E68DE161E521;
	Sun, 16 Feb 2014 16:06:27 +0000 (GMT)
X-Quarantine-ID: <sICW0NJ1Ibci>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sICW0NJ1Ibci; Sun, 16 Feb 2014 16:06:27 +0000 (GMT)
Received: from river.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id D5E46161E52F;
	Sun, 16 Feb 2014 16:06:23 +0000 (GMT)
X-Mailer: git-send-email 1.9.rc0.187.g6292fff
In-Reply-To: <cover.1392565571.git.john@keeping.me.uk>
In-Reply-To: <cover.1392565571.git.john@keeping.me.uk>
References: <cover.1392565571.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242228>

iconv(3) returns "(size_t) -1" on error.  Make sure that we cast the
"-1" properly when checking for this.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 utf8.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/utf8.c b/utf8.c
index 0d20e0a..24c3c5c 100644
--- a/utf8.c
+++ b/utf8.c
@@ -529,7 +529,7 @@ char *reencode_string_iconv(const char *in, size_t insz, iconv_t conv, int *outs
 	while (1) {
 		size_t cnt = iconv(conv, &cp, &insz, &outpos, &outsz);
 
-		if (cnt == -1) {
+		if (cnt == (size_t) -1) {
 			size_t sofar;
 			if (errno != E2BIG) {
 				free(out);
-- 
1.9.rc0.187.g6292fff
