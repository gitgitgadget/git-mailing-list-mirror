From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v5 19/28] http-backend: add example for gitweb on same URL
Date: Fri, 30 Oct 2009 17:47:38 -0700
Message-ID: <1256950067-27938-21-git-send-email-spearce@spearce.org>
References: <1256950067-27938-1-git-send-email-spearce@spearce.org>
Cc: Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 31 01:49:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N429q-0001yQ-Q8
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 01:49:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933169AbZJaAse (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 20:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933148AbZJaAsb
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 20:48:31 -0400
Received: from george.spearce.org ([209.20.77.23]:36950 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757596AbZJaAr4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 20:47:56 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id D718838215; Sat, 31 Oct 2009 00:48:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 0831038200;
	Sat, 31 Oct 2009 00:47:54 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.2.181.gd6f41
In-Reply-To: <1256950067-27938-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131801>

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
