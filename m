From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] log: Do not decorate replacements with --no-replace-objects
Date: Thu, 25 Aug 2011 15:44:06 +0200
Message-ID: <ad41e81daa6f9fc4654ae4c312f293202519a5d0.1314279822.git.git@drmicha.warpmail.net>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 25 15:44:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwaED-0007Wn-BT
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 15:44:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939Ab1HYNoL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 09:44:11 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:35575 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750747Ab1HYNoK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Aug 2011 09:44:10 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 83EE920A84;
	Thu, 25 Aug 2011 09:44:09 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Thu, 25 Aug 2011 09:44:09 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id; s=
	smtpout; bh=iIU8kVNXgyP3kkYbd7X9zAjcTaE=; b=KrJybRY0DpQ3OwIWk/ME
	BHozaIx0liYxs2xbpVBIP4e7uiEUC5ww3RGBRK+b6fvN/SSZI+/v+lOPByZ73u40
	jnK4gD94xdfWh26FGRIIStEvsDkIkjAXwPPH+9Sm0cIYDVtS7DSlqYTt/TV0TdCd
	a78x7ZhYZ8YbuI46TeVk0Zo=
X-Sasl-enc: hZteFMnude6W6yb4Vezo0Oz8y5fZNbfsC7oAjq5gY2+O 1314279849
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 07A499E0818;
	Thu, 25 Aug 2011 09:44:08 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.845.gc3c05
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180078>

5267d29 (log: decorate "replaced" on to replaced commits, 2011-08-19)
introduced textual decorations for replaced commits, based on the
detection of refs/replace.

Make it so that additionally the use of --no-replace-objects is
detected: I.e. replaced commits are only decorated as replaced when they
are actually replaced.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Sorry for being late to the party. Trying to keep up.
---
 log-tree.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 74fc20d..2066bb7 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -95,7 +95,7 @@ static int add_ref_decoration(const char *refname, const unsigned char *sha1, in
 	struct object *obj;
 	enum decoration_type type = DECORATION_NONE;
 
-	if (!prefixcmp(refname, "refs/replace/")) {
+	if (read_replace_refs && !prefixcmp(refname, "refs/replace/")) {
 		unsigned char original_sha1[20];
 		if (get_sha1_hex(refname + 13, original_sha1)) {
 			warning("invalid replace ref %s", refname);
-- 
1.7.6.845.gc3c05
