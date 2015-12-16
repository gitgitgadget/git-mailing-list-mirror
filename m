From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 2/2] push: add '-d' as shorthand for '--delete'
Date: Wed, 16 Dec 2015 09:16:52 +0100
Message-ID: <1450253812-17230-2-git-send-email-ps@pks.im>
References: <1450253812-17230-1-git-send-email-ps@pks.im>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 16 09:17:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a97Gu-0005BI-QC
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 09:17:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754462AbbLPIRL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 03:17:11 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59090 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754444AbbLPIRJ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Dec 2015 03:17:09 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 1932F20D19
	for <git@vger.kernel.org>; Wed, 16 Dec 2015 03:17:09 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Wed, 16 Dec 2015 03:17:09 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=oBKU
	SsTp5Wm+ESRbTMk5zi7T4mM=; b=BunrSmEscgLRQj9pYfdMHMk7C/djGUTB4rWp
	9kEGKRyoTp6iLNugBsvmpYflu4/7InOEH/0GqH9Y6hlYiADVWjiGt5tx7XP8vzdL
	+JyDKWfBDMBidTmEJMmxTbF8ZC3qiOiQXdr/JVX6MHJ7fu6D6VTqEZKlC0oYrjN2
	F8XL5s0=
X-Sasl-enc: meyf2fHBcuYXF+z2dZ2lCJ1Y6qmfR96A32xq85gOKe/g 1450253828
Received: from localhost (x5ce0fb64.dyn.telefonica.de [92.224.251.100])
	by mail.messagingengine.com (Postfix) with ESMTPA id 89B6768014A;
	Wed, 16 Dec 2015 03:17:08 -0500 (EST)
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1450253812-17230-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282544>

It is possible to delete branches on remotes by specifying the
'--delete' flag. The `git-branch` command, which can be used to
delete local branches with the same '--delete' flag, also accepts
the shorthand '-d'. This may cause confusion for users which are
frequently using the shorthand form of deleting local branches
and subsequently try to use the same shorthand for `git-push`,
which will fail.

Fix this usability issue by adding the '-d' shorthand to
`git-push` and document it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-push.txt | 2 +-
 builtin/push.c             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index e830c08..6f5d98c 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git push' [--all | --mirror | --tags] [--follow-tags] [--atomic] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
-	   [--repo=<repository>] [-f | --force] [--delete] [--prune] [-v | --verbose]
+	   [--repo=<repository>] [-f | --force] [-d | --delete] [--prune] [-v | --verbose]
 	   [-u | --set-upstream]
 	   [--[no-]signed|--sign=(true|false|if-asked)]
 	   [--force-with-lease[=<refname>[:<expect>]]]
diff --git a/builtin/push.c b/builtin/push.c
index 3bda430..093011d 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -540,7 +540,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_BIT( 0 , "all", &flags, N_("push all refs"), TRANSPORT_PUSH_ALL),
 		OPT_BIT( 0 , "mirror", &flags, N_("mirror all refs"),
 			    (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE)),
-		OPT_BOOL( 0, "delete", &deleterefs, N_("delete refs")),
+		OPT_BOOL('d', "delete", &deleterefs, N_("delete refs")),
 		OPT_BOOL( 0 , "tags", &tags, N_("push tags (can't be used with --all or --mirror)")),
 		OPT_BIT('n' , "dry-run", &flags, N_("dry run"), TRANSPORT_PUSH_DRY_RUN),
 		OPT_BIT( 0,  "porcelain", &flags, N_("machine-readable output"), TRANSPORT_PUSH_PORCELAIN),
-- 
2.6.4
