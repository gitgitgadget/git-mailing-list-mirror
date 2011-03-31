From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH 4/4] Unify pack header checking between index-pack and unpack-objects
Date: Wed, 30 Mar 2011 20:24:34 -0500
Message-ID: <1301534674-31981-4-git-send-email-dpmcgee@gmail.com>
References: <1301534674-31981-1-git-send-email-dpmcgee@gmail.com>
Cc: Dan McGee <dpmcgee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 31 03:25:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q56dF-0007mz-2Y
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 03:25:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933737Ab1CaBYs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 21:24:48 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:42099 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933637Ab1CaBYq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 21:24:46 -0400
Received: by yia27 with SMTP id 27so784265yia.19
        for <git@vger.kernel.org>; Wed, 30 Mar 2011 18:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=vPjuV/euXU3DI5O/7bOQGWDJKEnL0NYASawdh5++h0M=;
        b=wgZPoh4gHXXQ3xCXL1hIsQO9+S9cv4rR1TkOCP4L7MeXYTRSU0pYa/Jnn2Di27hqNI
         8ALhxqkCytO2E4NDymg41tKzevVFc3PN/0mnbSzxSBLjFRkCI/Ow08CfeO/DOCyPCWa2
         PhF+rDiPV0zkjuPEsJynu8ana0nKqh29IarVs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=VMkksWXOogptsKgo2PR/5+VjRKovaipG3VkIUSMtHXIulyL2rB245H1TOAWml3dpiU
         fSKqx4qTVBt6RiUAcFkDl/oHUqdR4WGf/8E+mEil74vuKRRQ1U8+HoxMmi9HCxJ1DNsM
         4a1r0UE7kiURcoyZkDZybZO7B7YYVbYbSIrlA=
Received: by 10.236.180.165 with SMTP id j25mr2845343yhm.351.1301534685995;
        Wed, 30 Mar 2011 18:24:45 -0700 (PDT)
Received: from localhost (c-71-239-242-45.hsd1.il.comcast.net [71.239.242.45])
        by mx.google.com with ESMTPS id 8sm351235yhx.8.2011.03.30.18.24.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 Mar 2011 18:24:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.2
In-Reply-To: <1301534674-31981-1-git-send-email-dpmcgee@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170439>

Both of these builtins share a lot of common code; taking steps to bring
them closer together before a likely future commit to unify some of the
shared code.

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---
 builtin/unpack-objects.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index a9e681e..a0dde7f 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -471,10 +471,10 @@ static uint32_t unpack_all(void)
 
 	nr_objects = ntohl(hdr->hdr_entries);
 
-	if (ntohl(hdr->hdr_signature) != PACK_SIGNATURE)
-		die("bad pack file");
+	if (hdr->hdr_signature != htonl(PACK_SIGNATURE))
+		die("pack signature mismatch");
 	if (!pack_version_ok(hdr->hdr_version))
-		die("unknown pack file version %"PRIu32,
+		die("pack version %"PRIu32" unsupported",
 			ntohl(hdr->hdr_version));
 	use(sizeof(struct pack_header));
 
-- 
1.7.4.2
