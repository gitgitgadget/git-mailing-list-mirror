From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] Add a flag core.symlinks analogous to core.filemode.
Date: Tue, 27 Feb 2007 22:41:37 +0100
Message-ID: <11726125033437-git-send-email-johannes.sixt@telecom.at>
References: <11726125012895-git-send-email-johannes.sixt@telecom.at>
Cc: Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 27 22:42:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMA56-0000yR-Vv
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 22:41:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbXB0Vlq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 16:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbXB0Vlq
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 16:41:46 -0500
Received: from smtp4.noc.eunet-ag.at ([193.154.160.226]:46973 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1750835AbXB0Vlp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 16:41:45 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 8A628976B8;
	Tue, 27 Feb 2007 22:41:43 +0100 (CET)
X-Mailer: git-send-email 1.5.0.19.gddff
In-Reply-To: <11726125012895-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40813>

The new flag core.symlinks (which is true by default) can be set to false
to indicate that the filesystem does not support symbolic links. In this
case, symbolic links that exist in the trees are checked out as small plain
files and checking in modifications of these files preserve the symlink
property in the database (as long as an entry exists in the index).

This commit as the first of a series starts by adding and initializing
the global flag variable.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 cache.h       |    1 +
 config.c      |    5 +++++
 environment.c |    1 +
 3 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index 04f8e63..6cbb9d8 100644
--- a/cache.h
+++ b/cache.h
@@ -202,6 +202,7 @@ extern int delete_ref(const char *, unsigned char *sha1);
 /* Environment bits from configuration mechanism */
 extern int use_legacy_headers;
 extern int trust_executable_bit;
+extern int trust_symlink_fmt;
 extern int assume_unchanged;
 extern int prefer_symlink_refs;
 extern int log_all_ref_updates;
diff --git a/config.c b/config.c
index c938aa0..749bec3 100644
--- a/config.c
+++ b/config.c
@@ -269,6 +269,11 @@ int git_default_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.symlinks")) {
+		trust_symlink_fmt = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.bare")) {
 		is_bare_repository_cfg = git_config_bool(var, value);
 		return 0;
diff --git a/environment.c b/environment.c
index 54c22f8..1e8292a 100644
--- a/environment.c
+++ b/environment.c
@@ -13,6 +13,7 @@ char git_default_email[MAX_GITNAME];
 char git_default_name[MAX_GITNAME];
 int use_legacy_headers = 1;
 int trust_executable_bit = 1;
+int trust_symlink_fmt = 1;
 int assume_unchanged;
 int prefer_symlink_refs;
 int is_bare_repository_cfg = -1; /* unspecified */
-- 
1.5.0.19.gddff
