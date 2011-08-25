From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2] log: Do not decorate replacements with --no-replace-objects
Date: Thu, 25 Aug 2011 17:09:30 +0200
Message-ID: <739ff64bdbd0c099b3baf0755c0350de82c1ec0a.1314284204.git.git@drmicha.warpmail.net>
References: <4E566586.5010901@drmicha.warpmail.net>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 25 17:26:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qwboj-0006LD-7U
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 17:26:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754548Ab1HYPZi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 11:25:38 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:58298 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753714Ab1HYPJe (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Aug 2011 11:09:34 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.messagingengine.com (Postfix) with ESMTP id BFC7420C0B;
	Thu, 25 Aug 2011 11:09:32 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute4.internal (MEProxy); Thu, 25 Aug 2011 11:09:32 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references; s=smtpout; bh=8awRoc/mjRe2sHfjbAyd7OFq7
	uc=; b=TF5A0QrPWFATDBd1fAcl2YZn+jCRxskj4HJNfDthjcWBaOdGp18xyQkf7
	Ba3U4ueXL5LirERXRbLlSIi1AscL88nroJ2B1nCl1r59gVWFvJzZZHZ5rCvot/QW
	JWdUuY/oGq+oVymHmreDCNXGnbnzR5K9xaU8ci3FMDQei0pCII=
X-Sasl-enc: I5uob8T/rew80vWt270SNbDy/qOljNBPVN47RWqvcrOq 1314284972
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 40AD1A202EA;
	Thu, 25 Aug 2011 11:09:32 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.845.gc3c05
In-Reply-To: <4E566586.5010901@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180082>

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
 log-tree.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 74fc20d..f65f6b6 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -96,6 +96,8 @@ static int add_ref_decoration(const char *refname, const unsigned char *sha1, in
 	enum decoration_type type = DECORATION_NONE;
 
 	if (!prefixcmp(refname, "refs/replace/")) {
+		if (!read_replace_refs)
+			return 0;
 		unsigned char original_sha1[20];
 		if (get_sha1_hex(refname + 13, original_sha1)) {
 			warning("invalid replace ref %s", refname);
-- 
1.7.6.845.gc3c05
