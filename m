From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 6/6] revisions: list all worktree HEADs with --all
Date: Fri, 26 Feb 2016 17:39:46 +0100
Message-ID: <99338f7eca7172a2e168c1ac2cfdb0ffc84f8a28.1456504190.git.git@drmicha.warpmail.net>
References: <cover.1456504190.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 26 17:40:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZLRC-0001D4-W2
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 17:40:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932791AbcBZQkE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 11:40:04 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:37995 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932751AbcBZQkB (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Feb 2016 11:40:01 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 1ED4220C91
	for <git@vger.kernel.org>; Fri, 26 Feb 2016 11:39:56 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute6.internal (MEProxy); Fri, 26 Feb 2016 11:39:56 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	date:from:in-reply-to:message-id:references:subject:to
	:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=mKwfMJUJpjJLtcgiWMga+hevJPY
	=; b=PVW4501KgILZcOyZjvn+SgSKbPjs+bHZeYWEu9dhNB47pm0glYhJTFPNEsW
	8YHaFl3kmUij5j8L/uJa9v1ygAVgiU8m4rhLK1TGalhaUg/KvnytkEAhhoB/9KSR
	VxdZJRem1jrhKfks3ePtO0nNo4BoYRWWRPl5OI2wBTDIdQIc=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=mKwf
	MJUJpjJLtcgiWMga+hevJPY=; b=rl8wHsF7A9+zElvty0PxnCYrkxHEc7zGfA4J
	58IQ4xpmT2gTO319Qa+mvqGbJpP19ePr/4FTMOnLl0X95Tgtz7DHjexqdaiaRxi6
	auOZ0PJGDiGJ5W3M/9afaaCCsSNOZLvLxsrhl1oXvnJcfkYKBcdgO4uLkK3oO8w1
	miYL0as=
X-Sasl-enc: cUYNTUA3hvFsyCXdIEaXOPnuBBSPdf8ySLWhdhU5yRI5 1456504795
Received: from localhost (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id 5DA3EC0001E;
	Fri, 26 Feb 2016 11:39:55 -0500 (EST)
X-Mailer: git-send-email 2.7.2.618.g7a61b68
In-Reply-To: <cover.1456504190.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287586>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---

Notes:
    Note that ever since
    f0298cf (revision walker: include a detached HEAD in --all, 2009-01-16)
    the documentation failed to mention the inclusion of HEAD with "--all".

 Documentation/rev-list-options.txt | 2 +-
 refs/files-backend.c               | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 4f009d4..fe37956 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -134,7 +134,7 @@ parents) and `--max-parents=-1` (negative numbers denote no upper limit).
 
 --all::
 	Pretend as if all the refs in `refs/` are listed on the
-	command line as '<commit>'.
+	command line as '<commit>', as well as the HEADs of all worktrees.
 
 --branches[=<pattern>]::
 	Pretend as if all the refs in `refs/heads` are listed
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 1614854..e717db0 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1802,7 +1802,7 @@ int head_ref_worktrees(each_ref_fn fn, void *cb_data)
 
 int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 {
-	return do_head_ref(submodule, fn, cb_data);
+	return do_head_ref_worktrees(submodule, fn, cb_data);
 }
 
 int for_each_ref(each_ref_fn fn, void *cb_data)
-- 
2.7.2.618.g7a61b68
