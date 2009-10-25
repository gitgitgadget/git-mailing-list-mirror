From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCH 4/5] http-backend: add example for gitweb on same URL
Date: Sun, 25 Oct 2009 14:05:34 -0400
Message-ID: <1256493935-8680-5-git-send-email-lodatom@gmail.com>
References: <1256493935-8680-1-git-send-email-lodatom@gmail.com>
 <1256493935-8680-2-git-send-email-lodatom@gmail.com>
 <1256493935-8680-3-git-send-email-lodatom@gmail.com>
 <1256493935-8680-4-git-send-email-lodatom@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 25 19:05:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N27Sr-00075h-Jr
	for gcvg-git-2@lo.gmane.org; Sun, 25 Oct 2009 19:05:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753911AbZJYSE4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2009 14:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753878AbZJYSEz
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Oct 2009 14:04:55 -0400
Received: from mail-qy0-f174.google.com ([209.85.221.174]:65052 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753880AbZJYSEv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2009 14:04:51 -0400
Received: by mail-qy0-f174.google.com with SMTP id 4so7380254qyk.33
        for <git@vger.kernel.org>; Sun, 25 Oct 2009 11:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=5UfXITZG1bkSCRq27GhrS2F0Q9ugHDuu/h6ZpTdXRVA=;
        b=l1tH0eB7Gd5cfC9dy5MLxXD2fgfluDOfnU66a/+r9w9XKgCSXsS98FWWzxx+BR4TWL
         thkDtZQLqU+At/E20/VxkCXAJl9U2Fq+L4vzeAQzEgSrSV+5ANwaaYu2GXtS/gfZqtY/
         0msjEUW0PeI3Vp9SVZAsh2LyJMvwYE75WQXOA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=dCvvetP88G2ilxlW3jZXdttcykj6NrRdssQh+Q8QZhGbJxEHHtnO0ue3JGbadGnyXu
         P7gCWKxLkt58UYjSRFgJjQVSp82zTe6i9brHScmamrl1Iidbwf81V3NIpE9Gv7VKcppL
         1STnV35xatO5nNY5Juz8jK3fKGnTWXPWGwlsM=
Received: by 10.224.122.3 with SMTP id j3mr6754910qar.335.1256493896324;
        Sun, 25 Oct 2009 11:04:56 -0700 (PDT)
Received: from localhost.localdomain (c-68-33-182-150.hsd1.dc.comcast.net [68.33.182.150])
        by mx.google.com with ESMTPS id 7sm13930120qwf.46.2009.10.25.11.04.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Oct 2009 11:04:55 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.1
In-Reply-To: <1256493935-8680-4-git-send-email-lodatom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131230>

In the git-http-backend documentation, add an example of how to set up
gitweb and git-http-backend on the same URL by using a series of
mod_alias commands.

Signed-off-by: Mark Lodato <lodatom@gmail.com>
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
1.6.5.1
