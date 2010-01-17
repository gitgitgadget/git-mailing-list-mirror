From: Tarmigan Casebolt <tarmigan+git@gmail.com>
Subject: [PATCH] ident.c: suppress fprintf compiler warning
Date: Sat, 16 Jan 2010 22:16:14 -0800
Message-ID: <1263708974-99619-1-git-send-email-tarmigan+git@gmail.com>
Cc: git@vger.kernel.org, Tarmigan Casebolt <tarmigan+git@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 17 07:18:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWOSg-0006tf-QH
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 07:18:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413Ab0AQGQ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 01:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750851Ab0AQGQ2
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 01:16:28 -0500
Received: from mail-yw0-f182.google.com ([209.85.211.182]:40752 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145Ab0AQGQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 01:16:27 -0500
Received: by ywh12 with SMTP id 12so607457ywh.21
        for <git@vger.kernel.org>; Sat, 16 Jan 2010 22:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=SuOj/CJYv12RuEZRv0sA+Kr0IbCssW3/iERkalyOwpw=;
        b=Zb2cRdOIZdTrQguGK1N8CxHA7wmxeWRZa8fC+u8OcWLgSHvCwUQuHMzgMXfgGHt0Ef
         Y1JFHfVvPG+pyMxGMFtAU1PLSa4L9lRayTEpHBg9he3nQ7tnydNVMxLjVQAByK2d8BeZ
         DxJ2Rr4xGOZgrCtVF/0OzzMVb17gG2oOqXBl8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        b=Z4FxKMq++PUvAXN79me8HoLHvo1nDspkXU1bvnn1sOWthJUTAIgV2wjFgBmVjTC/9Q
         agfVW6tMtSje6jAZlJX3apGU9W7W7RCazsefYGZhCbnaWIQRDyeC/qLm9irZ+pcZ5QIx
         ySGcO/7TeF4hsKypCJoGlHgsgfqTk8tw810pM=
Received: by 10.150.183.15 with SMTP id g15mr3459819ybf.231.1263708986899;
        Sat, 16 Jan 2010 22:16:26 -0800 (PST)
Received: from localhost.localdomain (c-69-181-44-199.hsd1.ca.comcast.net [69.181.44.199])
        by mx.google.com with ESMTPS id 20sm1154555yxe.20.2010.01.16.22.16.25
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 16 Jan 2010 22:16:26 -0800 (PST)
X-Mailer: git-send-email 1.6.6.425.g6b174
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137275>

Compiling today's pu gave
    ...
    CC ident.o
    CC levenshtein.o
ident.c: In function 'fmt_ident':
ident.c:206: warning: format not a string literal and no format arguments
    CC list-objects.o
    ...

This warning seems to have appeared first in 18e95f279ec6 (ident.c:
remove unused variables) which removed additional fprintf arguments.

Suppress this warning by using a literal "%s" to print the string
instead of passing the string directly to fprintf.

Signed-off-by: Tarmigan Casebolt <tarmigan+git@gmail.com>
---
 ident.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/ident.c b/ident.c
index d4f6145..239112c 100644
--- a/ident.c
+++ b/ident.c
@@ -203,7 +203,7 @@ const char *fmt_ident(const char *name, const char *email,
 
 		if ((warn_on_no_name || error_on_no_name) &&
 		    name == git_default_name && env_hint) {
-			fprintf(stderr, env_hint);
+			fprintf(stderr, "%s", env_hint);
 			env_hint = NULL; /* warn only once */
 		}
 		if (error_on_no_name)
-- 
1.6.6.425.g6b174
