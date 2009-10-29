From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [RFC PATCH v4 19/26] http-backend: add example for gitweb on same URL
Date: Wed, 28 Oct 2009 17:00:41 -0700
Message-ID: <1256774448-7625-20-git-send-email-spearce@spearce.org>
References: <1256774448-7625-1-git-send-email-spearce@spearce.org>
Cc: Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 29 01:02:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3ISm-0000kN-LN
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 01:02:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755946AbZJ2ABG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 20:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755705AbZJ2ABE
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 20:01:04 -0400
Received: from george.spearce.org ([209.20.77.23]:36258 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755609AbZJ2AA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 20:00:57 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 4D981381D3; Thu, 29 Oct 2009 00:01:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 873AA38239;
	Thu, 29 Oct 2009 00:00:54 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.2.181.gd6f41
In-Reply-To: <1256774448-7625-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131521>

From: Mark Lodato <lodatom@gmail.com>

In the git-http-backend documentation, add an example of how to set up
gitweb and git-http-backend on the same URL by using a series of
mod_alias commands.

Signed-off-by: Mark Lodato <lodatom@gmail.com>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/git-http-backend.txt |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-http-backend.txt b/Documentation/git-http-backend.txt
index e67519d..2989c9f 100644
--- a/Documentation/git-http-backend.txt
+++ b/Documentation/git-http-backend.txt
@@ -88,6 +88,23 @@ directive around the repository, or one of its parent directories:
 	...
 </Location>
 ----------------------------------------------------------------
++
+To serve gitweb at the same url, use a ScriptAliasMatch to only
+those URLs that 'git-http-backend' can handle, and forward the
+rest to gitweb:
++
+----------------------------------------------------------------
+ScriptAliasMatch \
+	"(?x)^/git/(.*/(HEAD | \
+			info/refs | \
+			objects/(info/[^/]+ | \
+				 [0-9a-f]{2}/[0-9a-f]{38} | \
+				 pack/pack-[0-9a-f]{40}\.(pack|idx)) | \
+			git-(upload|receive)-pack))$" \
+	/usr/libexec/git-core/git-http-backend/$1
+
+ScriptAlias /git/ /var/www/cgi-bin/gitweb.cgi/
+----------------------------------------------------------------
 
 Accelerated static Apache 2.x::
 	Similar to the above, but Apache can be used to return static
@@ -102,6 +119,22 @@ AliasMatch ^/git/(.*/objects/[0-9a-f]{2}/[0-9a-f]{38})$          /var/www/git/$1
 AliasMatch ^/git/(.*/objects/pack/pack-[0-9a-f]{40}.(pack|idx))$ /var/www/git/$1
 ScriptAlias /git/ /usr/libexec/git-core/git-http-backend/
 ----------------------------------------------------------------
++
+This can be combined with the gitweb configuration:
++
+----------------------------------------------------------------
+SetEnv GIT_PROJECT_ROOT /var/www/git
+
+AliasMatch ^/git/(.*/objects/[0-9a-f]{2}/[0-9a-f]{38})$          /var/www/git/$1
+AliasMatch ^/git/(.*/objects/pack/pack-[0-9a-f]{40}.(pack|idx))$ /var/www/git/$1
+ScriptAliasMatch \
+	"(?x)^/git/(.*/(HEAD | \
+			info/refs | \
+			objects/info/[^/]+ | \
+			git-(upload|receive)-pack))$" \
+	/usr/libexec/git-core/git-http-backend/$1
+ScriptAlias /git/ /var/www/cgi-bin/gitweb.cgi/
+----------------------------------------------------------------
 
 
 ENVIRONMENT
-- 
1.6.5.2.181.gd6f41
