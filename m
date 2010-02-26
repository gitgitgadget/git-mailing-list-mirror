From: Larry D'Anna <larry@elder-gods.org>
Subject: [PATCH 2/4] git-push: squelch advice message if in --porcelain mode
Date: Fri, 26 Feb 2010 14:50:08 -0500
Message-ID: <75b6d65f8028407cc1e8244a57823b3d87c520f1.1267211537.git.larry@elder-gods.org>
References: <cover.1267211537.git.larry@elder-gods.org>
Cc: Larry D'Anna <larry@elder-gods.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 26 20:50:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nl6D0-000758-2d
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 20:50:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965917Ab0BZTuR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2010 14:50:17 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:37690 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965860Ab0BZTuO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2010 14:50:14 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id 765FC822014; Fri, 26 Feb 2010 14:50:11 -0500 (EST)
X-Mailer: git-send-email 1.7.0.rc2.40.g7d8aa
In-Reply-To: <cover.1267211537.git.larry@elder-gods.org>
In-Reply-To: <cover.1267211537.git.larry@elder-gods.org>
References: <cover.1267211537.git.larry@elder-gods.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141139>

By default, git-push may give the user a verbose advice message if a ref is
rejected for not being a fast-forward.  This patch squelches that message for
--porcelain mode.

Signed-off-by: Larry D'Anna <larry@elder-gods.org>
---
 builtin-push.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/builtin-push.c b/builtin-push.c
index 0a27072..aacba45 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -226,6 +226,11 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, options, push_usage, 0);
 
+	if (flags & TRANSPORT_PUSH_PORCELAIN) {
+		/* Do not give advice messages to Porcelain scripts */
+		advice_push_nonfastforward = 0;
+	}
+
 	if (deleterefs && (tags || (flags & (TRANSPORT_PUSH_ALL | TRANSPORT_PUSH_MIRROR))))
 		die("--delete is incompatible with --all, --mirror and --tags");
 	if (deleterefs && argc < 2)
-- 
1.7.0.rc2.40.g7d8aa
