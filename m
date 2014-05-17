From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 05/10] replace: make sure --edit results in a different
 object
Date: Sat, 17 May 2014 14:16:34 +0200
Message-ID: <20140517121640.27582.3418.chriscool@tuxfamily.org>
References: <20140517120649.27582.58609.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 17 17:58:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wlh0S-0003Xp-8j
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 17:58:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932496AbaEQP6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2014 11:58:18 -0400
Received: from mail-2y.bbox.fr ([194.158.98.15]:44486 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757414AbaEQP5j (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2014 11:57:39 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 7CB2642;
	Sat, 17 May 2014 17:57:38 +0200 (CEST)
X-git-sha1: 54c4ea1a8bd294171a1600138fe35ba9c1ab426f 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140517120649.27582.58609.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249483>

It's a bad idea to create a replace ref for an object
that points to the original object itself.

That's why we have to check if the result from editing
the original object is a different object and error out
if it isn't.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/replace.c b/builtin/replace.c
index 3da1bae..0751804 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -275,6 +275,9 @@ static int edit_and_replace(const char *object_ref, int force)
 
 	free(tmpfile);
 
+	if (!hashcmp(old, new))
+		return error("new object is the same as the old one: '%s'", sha1_to_hex(old));
+
 	return replace_object_sha1(object_ref, old, "replacement", new, force);
 }
 
-- 
1.9.rc0.17.g651113e
