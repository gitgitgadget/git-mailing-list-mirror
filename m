From: Ferry Huberts <mailings@hupie.com>
Subject: [CGit] [PATCH 4/6] source_filter: also communicate the repo name to the filter
Date: Thu, 17 Feb 2011 22:11:07 +0100
Message-ID: <1297977069-21884-5-git-send-email-mailings@hupie.com>
References: <1297977069-21884-1-git-send-email-mailings@hupie.com>
Cc: hjemli@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 17 22:11:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqB8Q-0007Wi-F4
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 22:11:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758038Ab1BQVLR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 16:11:17 -0500
Received: from 82-197-206-98.dsl.cambrium.nl ([82.197.206.98]:57504 "EHLO
	mail.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757349Ab1BQVLL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 16:11:11 -0500
Received: from paul.internal.hupie.com (paul.internal.Hupie.com [192.168.180.1])
	by mail.internal.Hupie.com (Postfix) with ESMTP id B377C58C99B;
	Thu, 17 Feb 2011 22:11:09 +0100 (CET)
X-Mailer: git-send-email 1.7.4
In-Reply-To: <1297977069-21884-1-git-send-email-mailings@hupie.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167119>

From: Ferry Huberts <ferry.huberts@pelagic.nl>

Signed-off-by: Ferry Huberts <ferry.huberts@pelagic.nl>
---
 cgit.c                         |    2 +-
 filters/syntax-highlighting.sh |    1 +
 ui-tree.c                      |    2 ++
 3 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/cgit.c b/cgit.c
index 6fa8f60..65c892c 100644
--- a/cgit.c
+++ b/cgit.c
@@ -46,7 +46,7 @@ struct cgit_filter *new_filter(const char *cmd, filter_type filtertype)
 			break;
 
 		case source:
-			extra_args = 1;
+			extra_args = 2;
 			break;
 
 		default:
diff --git a/filters/syntax-highlighting.sh b/filters/syntax-highlighting.sh
index 6b1c576..80d670f 100755
--- a/filters/syntax-highlighting.sh
+++ b/filters/syntax-highlighting.sh
@@ -26,6 +26,7 @@
 
 # store filename and extension in local vars
 BASENAME="$1"
+REPONAME="$2"
 EXTENSION="${BASENAME##*.}"
 
 # map Makefile and Makefile.* to .mk
diff --git a/ui-tree.c b/ui-tree.c
index 442b6be..2c7298c 100644
--- a/ui-tree.c
+++ b/ui-tree.c
@@ -45,6 +45,8 @@ static void print_text_buffer(const char *name, char *buf, unsigned long size)
 	if (ctx.repo->source_filter) {
 		html("<td class='lines'><pre><code>");
 		ctx.repo->source_filter->argv[1] = xstrdup(name);
+		if (!ctx.repo->source_filter->argv[2])
+			ctx.repo->source_filter->argv[2] = xstrdup(ctx.repo->name);
 		cgit_open_filter(ctx.repo->source_filter);
 		html_raw(buf, size);
 		cgit_close_filter(ctx.repo->source_filter);
-- 
1.7.4
