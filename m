From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v2 2/4] compat/setenv.c: error if name contains '='
Date: Wed, 14 Dec 2011 15:07:09 +0100
Message-ID: <1323871631-2872-3-git-send-email-kusmabite@gmail.com>
References: <1323871631-2872-1-git-send-email-kusmabite@gmail.com>
Cc: peff@peff.net, gitster@pobox.com, schwab@linux-m68k.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 14 15:07:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RapUX-0001cC-FF
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 15:07:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757320Ab1LNOH1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 09:07:27 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:65260 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757264Ab1LNOHZ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Dec 2011 09:07:25 -0500
Received: by mail-lpp01m010-f46.google.com with SMTP id p5so326737lag.19
        for <git@vger.kernel.org>; Wed, 14 Dec 2011 06:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=XZAhSRpsRK8HwBsE7Hql9+p9r524nISpdpXsZ1DLTPg=;
        b=C076Gw+TbeQz71wFjQOGrdBXh9blZq52jp0DDnkXK/KBkB8j8L8vypp0yRyc3xWmDV
         FRvDCRx2oG8XDjU+BbcxehqVmJj3dCblR2CuEvvPmq9PzpQvOkMaqZz+uCCQZ2liX2E+
         7O197M9pR3HWLerA7R6pEGbeN6ZueX98j1jaY=
Received: by 10.152.144.2 with SMTP id si2mr2467190lab.8.1323871644492;
        Wed, 14 Dec 2011 06:07:24 -0800 (PST)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id nw10sm2339707lab.4.2011.12.14.06.07.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Dec 2011 06:07:22 -0800 (PST)
X-Mailer: git-send-email 1.7.7.1.msysgit.0.272.g9e47e
In-Reply-To: <1323871631-2872-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187113>

According to POSIX, setenv should error out with EINVAL if it's
asked to set an environment variable whose name contains an equals
sign. Implement this detail in our compatibility-fallback.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 compat/setenv.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/compat/setenv.c b/compat/setenv.c
index 89947b7..fc1439a 100644
--- a/compat/setenv.c
+++ b/compat/setenv.c
@@ -6,7 +6,7 @@ int gitsetenv(const char *name, const char *value, int replace)
 	size_t namelen, valuelen;
 	char *envstr;
 
-	if (!name || !value) {
+	if (!name || strchr(name, '=') || !value) {
 		errno = EINVAL;
 		return -1;
 	}
-- 
1.7.7.1.msysgit.0.272.g9e47e
