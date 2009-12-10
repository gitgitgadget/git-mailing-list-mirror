From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] tag -d: print sha1 of deleted tag
Date: Thu, 10 Dec 2009 13:23:43 +0100
Message-ID: <3b0a7bfa75126e4c13ec15a4357645b2bfd14b5b.1260447713.git.git@drmicha.warpmail.net>
References: <87ljhb87nj.fsf@jondo.cante.net>
Cc: Jari Aalto <jari.aalto@cante.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 10 13:25:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIi59-0000iT-Qk
	for gcvg-git-2@lo.gmane.org; Thu, 10 Dec 2009 13:25:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933023AbZLJMY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2009 07:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932929AbZLJMY7
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Dec 2009 07:24:59 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:52071 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932871AbZLJMY6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Dec 2009 07:24:58 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 6AE30C60CF;
	Thu, 10 Dec 2009 07:25:05 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 10 Dec 2009 07:25:05 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=GtSn9sXfU9eSy95+MrsfHz679EU=; b=PvodAA8pHMpb7tNAKGuEuSKTLVjqecS/Udo7CCya1pNDQMqCjb53aagzKJX3CJA7Hg3Ub/94TbDuZIk92oRClgCn2WJTOwVvgb+ku+e5dnbOVE3uenmOCNwvWlRM5stCqNizR6DY9LlQvuL+kzD8+tpzhLWsEAjrvA9q0fe7TM0=
X-Sasl-enc: hD3M4GAouccRBli09DwMyHkVO+zWiCbGDeP9gTyTHlXW 1260447904
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id BDD9D208C0;
	Thu, 10 Dec 2009 07:25:04 -0500 (EST)
X-Mailer: git-send-email 1.6.6.rc1.292.gd8fe
In-Reply-To: <87ljhb87nj.fsf@jondo.cante.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135019>

Print the sha1 of the deleted tag (in addition to the tag name) so that
one can easily recreate a mistakenly deleted tag:

git tag -d tagname
Deleted tag 'tagname' DEADBEEF
git tag 'tagname' DEADBEEF # for lightweight tags
git update-ref refs/tags/'tagname' DEADBEEF # for annotated tags

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
Suggested-by: Jari Aalto <jari.aalto@cante.net>
---
 builtin-tag.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-tag.c b/builtin-tag.c
index c479018..39d0ce2 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -140,7 +140,7 @@ static int delete_tag(const char *name, const char *ref,
 {
 	if (delete_ref(ref, sha1, 0))
 		return 1;
-	printf("Deleted tag '%s'\n", name);
+	printf("Deleted tag '%s' %s\n", name, sha1_to_hex(sha1));
 	return 0;
 }
 
-- 
1.6.6.rc1.292.gd8fe
