From: Larry D'Anna <larry@elder-gods.org>
Subject: [PATCH 2/4] git-push: squelch advice message if in --porcelain mode
Date: Tue,  9 Feb 2010 00:54:00 -0500
Message-ID: <82ed08a77b08dd046be932ad4c08f65136c22c29.1265694627.git.larry@elder-gods.org>
References: <1d1ce7e0ad28fd0cad8d9d7bfeda04ba58be36d4.1265694627.git.larry@elder-gods.org>
Cc: Larry D'Anna <larry@elder-gods.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 09 06:54:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nej36-0006Lo-Dt
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 06:54:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752613Ab0BIFyI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 00:54:08 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:36725 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751780Ab0BIFyG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 00:54:06 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id E2617822012; Tue,  9 Feb 2010 00:54:02 -0500 (EST)
X-Mailer: git-send-email 1.7.0.rc1.33.g07cf0f.dirty
In-Reply-To: <1d1ce7e0ad28fd0cad8d9d7bfeda04ba58be36d4.1265694627.git.larry@elder-gods.org>
In-Reply-To: <20100209054820.GA30907@cthulhu>
References: <20100209054820.GA30907@cthulhu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139365>

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
1.7.0.rc1.33.g07cf0f.dirty
