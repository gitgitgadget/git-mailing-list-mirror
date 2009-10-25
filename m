From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCH 3/5] http-backend: use mod_alias instead of mod_rewrite
Date: Sun, 25 Oct 2009 14:05:33 -0400
Message-ID: <1256493935-8680-4-git-send-email-lodatom@gmail.com>
References: <1256493935-8680-1-git-send-email-lodatom@gmail.com>
 <1256493935-8680-2-git-send-email-lodatom@gmail.com>
 <1256493935-8680-3-git-send-email-lodatom@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 25 19:05:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N27Sr-00075h-25
	for gcvg-git-2@lo.gmane.org; Sun, 25 Oct 2009 19:05:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753884AbZJYSEv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2009 14:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753878AbZJYSEu
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Oct 2009 14:04:50 -0400
Received: from mail-qy0-f174.google.com ([209.85.221.174]:65052 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753864AbZJYSEt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2009 14:04:49 -0400
Received: by mail-qy0-f174.google.com with SMTP id 4so7380254qyk.33
        for <git@vger.kernel.org>; Sun, 25 Oct 2009 11:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=6FpTKbi+t4tiMnuFI4F70Xc1WvzlxiIUfgrjGdL8D9I=;
        b=uybsd7LSNBqYDPJB9d+tSwUYaXlAYoU1Ltap6F72aRkQ9pMO8+U7Lx/FlBWiO2VNM4
         0ymoLxfv8xm9gMVAZIysJ3D1buEBAv8xMxOb3Av0IWHVyBshmBcgNhjepphRaNRPZahz
         a8lasH6mGPuHXxT96pPI1yx1r4aWCVXzxG8AM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=QQ5WTOi9nZvJL2RCCbJWeCDOkvTqeZRIyka+JRpXxlgCW18cVlVsfINXficp9K+0/E
         KfnkTv3tXvlwa370KoVNYFZRSckeVa4C8lF0ZUUaEbXnzQbCbXfaHtVoKxKOLfC2pWtj
         9qS6+zMYKGMr3phjQEo6hgWOyz0G69pCMBF7E=
Received: by 10.224.61.141 with SMTP id t13mr6722259qah.313.1256493894241;
        Sun, 25 Oct 2009 11:04:54 -0700 (PDT)
Received: from localhost.localdomain (c-68-33-182-150.hsd1.dc.comcast.net [68.33.182.150])
        by mx.google.com with ESMTPS id 7sm13930120qwf.46.2009.10.25.11.04.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Oct 2009 11:04:53 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.1
In-Reply-To: <1256493935-8680-3-git-send-email-lodatom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131232>

In the git-http-backend documentation, use mod_alias exlusively, instead
of using a combination of mod_alias and mod_rewrite.  This makes the
example slightly shorted and a bit more clear.

Signed-off-by: Mark Lodato <lodatom@gmail.com>
---
 Documentation/git-http-backend.txt |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-http-backend.txt b/Documentation/git-http-backend.txt
index 0b5e951..e67519d 100644
--- a/Documentation/git-http-backend.txt
+++ b/Documentation/git-http-backend.txt
@@ -98,13 +98,9 @@ Accelerated static Apache 2.x::
 ----------------------------------------------------------------
 SetEnv GIT_PROJECT_ROOT /var/www/git
 
-ScriptAlias /git/        /usr/libexec/git-core/git-http-backend/
-Alias       /git_static/ /var/www/git/
-
-RewriteEngine on
-RewriteRule ^/git/(.*/objects/[0-9a-f]{2}/[0-9a-f]{38})$    /git_static/$1 [PT]
-RewriteRule ^/git/(.*/objects/pack/pack-[0-9a-f]{40}.pack)$ /git_static/$1 [PT]
-RewriteRule ^/git/(.*/objects/pack/pack-[0-9a-f]{40}.idx)$  /git_static/$1 [PT]
+AliasMatch ^/git/(.*/objects/[0-9a-f]{2}/[0-9a-f]{38})$          /var/www/git/$1
+AliasMatch ^/git/(.*/objects/pack/pack-[0-9a-f]{40}.(pack|idx))$ /var/www/git/$1
+ScriptAlias /git/ /usr/libexec/git-core/git-http-backend/
 ----------------------------------------------------------------
 
 
-- 
1.6.5.1
