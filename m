From: Guanglin Xu <mzguanglin@gmail.com>
Subject: [PATCH v2] branch.c: change install_branch_config() to use skip_prefix()
Date: Sun,  2 Mar 2014 23:55:55 +0800
Message-ID: <1393775755-15359-1-git-send-email-mzguanglin@gmail.com>
Content-Type: text/plain; charset="utf-8"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 02 16:56:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WK8kZ-0003Aa-F0
	for gcvg-git-2@plane.gmane.org; Sun, 02 Mar 2014 16:56:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753449AbaCBP4S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2014 10:56:18 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:61802 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753070AbaCBP4R (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2014 10:56:17 -0500
Received: by mail-pa0-f49.google.com with SMTP id hz1so2763012pad.36
        for <git@vger.kernel.org>; Sun, 02 Mar 2014 07:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:content-type;
        bh=H/OmdSbUowpyfKZoYicWK0KQoQhQQdeePCtzt207f3c=;
        b=e5tQ4GKmAcQCi7iFxVj3WtD8ZyzFFHE7uWxqaePy/mk0cvDyOiCH1fkOt5pVjU4sr8
         Ooer5yXBdR+WBu80LJgRIvgd6Xh7d16/Mao+dll95VSaRHa7qsVGGtbsEMso+X2NftYr
         fHXpyTL2L1NBEQJ+O4ZJBpwAamiqtA2qA5FcYEaB2P6CfOKmWPZBa/R68jJ+YdzeEmfz
         rLwf2xwvi5BXbFi+mgHD7FopGJ4hpdogcPkPCHgv0joGCld2gRG52nPbmKJ1wCW9tB2Z
         bBIEzaRs4GbVaM3pWIvIcYGEc3ywbLY0vhZF4nEsMcJHSG3SCVfqBYq98YrgK2O3KVgd
         I4Rg==
X-Received: by 10.68.171.193 with SMTP id aw1mr3243502pbc.117.1393775777388;
        Sun, 02 Mar 2014 07:56:17 -0800 (PST)
Received: from localhost.localdomain ([113.107.25.71])
        by mx.google.com with ESMTPSA id f5sm64233278pat.11.2014.03.02.07.56.14
        for <git@vger.kernel.org>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 02 Mar 2014 07:56:16 -0800 (PST)
X-Mailer: git-send-email 1.9.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243152>

Change install_branch_config() to use skip_prefix() and make it conform to the usage of previous starts_with(). This is because the proper usage of skip_prefix() overrides the functionality of starts_with(). Thorough replacements may finally remove the starts_with() function and reduce  code redundency.

Signed-off-by: Guanglin Xu <mzguanglin@gmail.com>
---
 branch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/branch.c b/branch.c
index 723a36b..ca4e824 100644
--- a/branch.c
+++ b/branch.c
@@ -50,7 +50,7 @@ static int should_setup_rebase(const char *origin)
 void install_branch_config(int flag, const char *local, const char *origin, const char *remote)
 {
 	const char *shortname = remote + 11;
-	int remote_is_branch = starts_with(remote, "refs/heads/");
+	int remote_is_branch = (NULL != skip_prefix(remote ,"refs/heads/"));
 	struct strbuf key = STRBUF_INIT;
 	int rebasing = should_setup_rebase(origin);
 
-- 
1.9.0


Hi,
I am Guanglin Xu. I plan to apply for GSoC 2014.

This patch is in accordance with the idea#2 of GSoC2014 Microproject. Any comments are welcomed.
