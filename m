From: Spencer Baugh <sbaugh@catern.com>
Subject: [PATCH] checkout: don't check worktrees when not necessary
Date: Sun, 31 May 2015 19:16:29 -0400
Message-ID: <1433114189-9779-1-git-send-email-sbaugh@catern.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Spencer Baugh <sbaugh@catern.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 01 01:25:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzCbf-0000ik-MN
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 01:25:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758544AbbEaXZT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2015 19:25:19 -0400
Received: from catern.com ([104.131.201.120]:38070 "EHLO mail.catern.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758542AbbEaXZS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2015 19:25:18 -0400
X-Greylist: delayed 524 seconds by postgrey-1.27 at vger.kernel.org; Sun, 31 May 2015 19:25:18 EDT
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.catern.com (Postfix) with ESMTPSA id 90AEE434E4;
	Sun, 31 May 2015 23:16:33 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270367>

When --patch or pathspecs are passed to git checkout, the working tree
will not be switching branch, so there's no need to check if the branch
that we are running checkout on is already checked out.

Signed-off-by: Spencer Baugh <sbaugh@catern.com>
---
 builtin/checkout.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2f92328..7039c5c 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1237,6 +1237,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 		char *head_ref = resolve_refdup("HEAD", 0, sha1, &flag);
 		if (head_ref &&
 		    (!(flag & REF_ISSYMREF) || strcmp(head_ref, new->path)) &&
+		    !(opts->patch_mode || opts->pathspec.nr) &&
 		    !opts->ignore_other_worktrees)
 			check_linked_checkouts(new);
 		free(head_ref);
-- 
2.4.2.339.g77bd3ea
