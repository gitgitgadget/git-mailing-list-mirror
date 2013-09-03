From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 06/11] replace: bypass the type check if -f option is used
Date: Tue, 03 Sep 2013 09:10:20 +0200
Message-ID: <20130903071026.29838.76437.chriscool@tuxfamily.org>
References: <20130903070551.29838.43576.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
	Thomas Rast <trast@inf.ethz.ch>, Johannes Sixt <j6t@kdbg.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 09:17:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGks6-0008IL-1I
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 09:17:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932561Ab3ICHRr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 03:17:47 -0400
Received: from mail-1y.bbox.fr ([194.158.98.14]:53243 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932533Ab3ICHRU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 03:17:20 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id D9A6C61;
	Tue,  3 Sep 2013 09:17:18 +0200 (CEST)
X-git-sha1: a687c5f54eede130ee5a413565cf68dfb1f0626a 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20130903070551.29838.43576.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233698>

If -f option, which means '--force', is used, we can allow an object
to be replaced with one of a different type, as the user should know
what (s)he is doing.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index 9a94769..95736d9 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -103,7 +103,7 @@ static int replace_object(const char *object_ref, const char *replace_ref,
 
 	obj_type = sha1_object_info(object, NULL);
 	repl_type = sha1_object_info(repl, NULL);
-	if (obj_type != repl_type)
+	if (!force && obj_type != repl_type)
 		die("Objects must be of the same type.\n"
 		    "'%s' points to a replaced object of type '%s'\n"
 		    "while '%s' points to a replacement object of type '%s'.",
-- 
1.8.4.rc1.31.g530f5ce.dirty
