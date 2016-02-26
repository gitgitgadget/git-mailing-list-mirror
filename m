From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 5/6] WIP: fix unborn branch case
Date: Fri, 26 Feb 2016 17:39:45 +0100
Message-ID: <9d4ba4d9aa4deaf88c4e7e1d9d92fb18717e7b2c.1456504190.git.git@drmicha.warpmail.net>
References: <cover.1456504190.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 26 17:40:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZLR2-00014b-BD
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 17:40:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932660AbcBZQj5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 11:39:57 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:38199 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754483AbcBZQjz (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Feb 2016 11:39:55 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 729EC20B5C
	for <git@vger.kernel.org>; Fri, 26 Feb 2016 11:39:54 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute5.internal (MEProxy); Fri, 26 Feb 2016 11:39:54 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	date:from:in-reply-to:message-id:references:subject:to
	:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=BOl3cFvYbbOMXYfnUxV3yF5QPyM
	=; b=QSICJAlpxniG9XxPaEgQ1rRUdMIKH9Ju4/zzZo+WZflYR+fsbJCgRiBuIuV
	Dnbelny7bIBvaOUH9gIZSoJvxPJEYASudulOMDeftD3u3RATHVY7YArmRfkwWYtz
	HSyJxDcU4r822EExMF3pRVSaTqJ3sst1W8Oe6cG92t3h49V0=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=BOl3
	cFvYbbOMXYfnUxV3yF5QPyM=; b=rCyu/tzy7Q2KIa71szotKMoDdtN5k9PqxRWw
	xV3PTXL72pnzoSldPQ93R0XksiwFoIaHboTbhrC0BWzJNiURiRsmJHVOrNmBXzRQ
	hZ2GJhZAHO8giDsUx1JJ+NMWQNKtGBp5Q93e6qBHIaQQYjIkjKYHbr+5aPBx3Vg/
	K7w7h1w=
X-Sasl-enc: 33yFUCVmaCaDPF+ICaT5z6J6cI7Ad1o+Kbp7OCSAonRa 1456504794
Received: from localhost (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id DD2296801B3;
	Fri, 26 Feb 2016 11:39:53 -0500 (EST)
X-Mailer: git-send-email 2.7.2.618.g7a61b68
In-Reply-To: <cover.1456504190.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287582>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 refs/files-backend.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index f020c52..1614854 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1780,6 +1780,8 @@ static int do_head_ref_worktrees(const char *submodule, each_ref_fn fn, void *cb
 	worktrees = get_worktrees();
 	retval = 0;
 	for (i=0; worktrees[i]; i++) {
+		if (is_null_sha1(worktrees[i]->head_sha1))
+			continue;
 		hashcpy(oid.hash, worktrees[i]->head_sha1);
 		retval = retval || fn("HEAD", &oid, worktrees[i]->is_detached ? 0 : REF_ISSYMREF, cb_data);
 	}
-- 
2.7.2.618.g7a61b68
