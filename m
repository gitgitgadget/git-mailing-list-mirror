From: "Lars R. Damerow" <lars@pixar.com>
Subject: [PATCH 2/3] truncate cwd string before printing error message
Date: Wed, 17 Mar 2010 12:55:52 -0700
Message-ID: <1268855753-25840-3-git-send-email-lars@pixar.com>
References: <1268855753-25840-1-git-send-email-lars@pixar.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 17 21:06:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrzVU-0006Kx-0U
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 21:06:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756018Ab0CQUGF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Mar 2010 16:06:05 -0400
Received: from cmx.pixar.com ([199.108.77.24]:33473 "EHLO cmx.pixar.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756016Ab0CQUGE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 16:06:04 -0400
X-PixarMID: 1954521
X-PixarRecvListener: OutboundMail
X-PixarRemoteIP: 138.72.131.152
X-IronPort-AV: E=Sophos;i="4.51,261,1267430400"; 
   d="scan'208";a="1954521"
Received: from helper.dynamic.pixar.com ([138.72.131.152])
  by cirrus.pixar.com with ESMTP; 17 Mar 2010 12:56:04 -0700
Received: from helper.dynamic.pixar.com (localhost [127.0.0.1])
	by helper.dynamic.pixar.com (8.14.3/8.14.3) with ESMTP id o2HJu3ZC025895
	for <git@vger.kernel.org>; Wed, 17 Mar 2010 12:56:03 -0700
Received: (from lars@localhost)
	by helper.dynamic.pixar.com (8.14.3/8.14.3/Submit) id o2HJu3DL025894
	for git@vger.kernel.org; Wed, 17 Mar 2010 12:56:03 -0700
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <1268855753-25840-1-git-send-email-lars@pixar.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142433>

Without this truncation the error message printed only shows the cwd
from the start of the search, not where it failed.

Signed-off-by: Lars R. Damerow <lars@pixar.com>
---
 setup.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/setup.c b/setup.c
index 5716d90..f0b56b9 100644
--- a/setup.c
+++ b/setup.c
@@ -422,8 +422,10 @@ const char *setup_git_directory_gently(int *nongit_ok)
 			}
 			die("Not a git repository (or any of the parent directories): %s", DEFAULT_GIT_DIR_ENVIRONMENT);
 		}
-		if (chdir(".."))
+		if (chdir("..")) {
+			cwd[offset] = '\0';
 			die_errno("Cannot change to '%s/..'", cwd);
+		}
 	}
 
 	inside_git_dir = 0;
-- 
1.6.5.2
