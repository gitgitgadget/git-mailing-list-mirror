From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] submodule.c: Squelch a "use before assignment" warning
Date: Thu, 19 Nov 2009 17:33:05 -0800
Message-ID: <1258680785-42235-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Nov 20 02:33:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBIND-0002AD-Gt
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 02:33:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754962AbZKTBdH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 20:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754418AbZKTBdH
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 20:33:07 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:40897 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754394AbZKTBdF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 20:33:05 -0500
Received: by yxe17 with SMTP id 17so2566063yxe.33
        for <git@vger.kernel.org>; Thu, 19 Nov 2009 17:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=AthU57izvvDkpkuzEuh/6GKl9Fc77pTQa1azLATjujY=;
        b=hoMKfT3dQafC1kQSaIPbW47nCw3VWE9MA3Y278iW4NvoJJwBOF/DICWaD6QrIJBFOR
         F5gdclyHaCQObi6PxoVAUrjldkisQ1dxdSXh/NB0F/6ltu3iJe2ANaHhALLzwuxPNl8p
         H+gFEBJHfA4DWPqNUlBaL+VTFW9KdyROiJxb0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Mrg/3GumDPs9e11BBGAhyCd1dWmabqGLi/h0DAiu1PErEz/B354p3huitxtaSyfch/
         d7KptQPbGJ2Zu240ZUs0sCUkEETRGlk8vIOFOJ+YCYynxVaMNnJPc7KeaoMHuPpx9gWz
         0PVLW4RSq+k4xQ3/JTUxYN6Tcb1wGLNYECac0=
Received: by 10.101.17.17 with SMTP id u17mr1321328ani.167.1258680791147;
        Thu, 19 Nov 2009 17:33:11 -0800 (PST)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 7sm519476yxd.44.2009.11.19.17.33.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Nov 2009 17:33:10 -0800 (PST)
X-Mailer: git-send-email 1.6.5.3.171.ge36e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133278>

i686-apple-darwin9-gcc-4.0.1 (GCC) 4.0.1 (Apple Inc. build 5493) compiler
(and probably others) mistakenly thinks variable 'right' is used
before assigned.  Work it around by giving it a fake initialization.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 submodule.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/submodule.c b/submodule.c
index 461faf0..0145a62 100644
--- a/submodule.c
+++ b/submodule.c
@@ -38,7 +38,7 @@ void show_submodule_summary(FILE *f, const char *path,
 		const char *del, const char *add, const char *reset)
 {
 	struct rev_info rev;
-	struct commit *commit, *left = left, *right;
+	struct commit *commit, *left = left, *right = NULL;
 	struct commit_list *merge_bases, *list;
 	const char *message = NULL;
 	struct strbuf sb = STRBUF_INIT;
-- 
1.6.5.3.171.ge36e
