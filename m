From: Xidorn Quan <quanxunzhen@gmail.com>
Subject: [PATCH v3] credential-osxkeychain: support more protocols
Date: Fri, 31 May 2013 12:07:55 +0800
Message-ID: <1369973275-13353-1-git-send-email-quanxunzhen@gmail.com>
Cc: Xidorn Quan <quanxunzhen@gmail.com>, git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri May 31 06:08:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiGe4-0004tv-Be
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 06:08:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779Ab3EaEIg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 May 2013 00:08:36 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:49327 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756Ab3EaEIf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 May 2013 00:08:35 -0400
Received: by mail-pb0-f48.google.com with SMTP id md4so1512272pbc.7
        for <git@vger.kernel.org>; Thu, 30 May 2013 21:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=GzGvx6Z1l1ndU+f/c79O87SqoHCVB5TlVRoJeT9LCcw=;
        b=VoyeD9e2YSA+Vc2VEorVtmXa7WluBp+sTakM7qbY40IFL3SGe+7ERhF0njphVgAVno
         AMA1CMWP3iEZgKUO48i1u2/wHZkZbE86mVP0c4kcoxWsQ9HvJd+BVNI4ABWTBfPbRjNx
         B8CHdHJwn0yPVgNO6r7CRTJNn1bV7dzhUOKFxjY+SnpW3Z8YeaIXd9kK7RDgAM2/0+V3
         L2UDlDm0IyaQwNUmPNsl8cLCuK1GvlnqeR/xkzacMJeNUWqxlAG/h5LYrDH9meeWXsYx
         AanW6yr75uZPlfpD7a8b3ZwGqlcMW2MZa6jt/BoKN8Jc18JLpuSAg1U9sqh/sXcQJerQ
         f8OA==
X-Received: by 10.66.122.97 with SMTP id lr1mr11501068pab.147.1369973314706;
        Thu, 30 May 2013 21:08:34 -0700 (PDT)
Received: from localhost.localdomain ([221.239.198.50])
        by mx.google.com with ESMTPSA id fp2sm44726136pbb.36.2013.05.30.21.08.31
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 30 May 2013 21:08:33 -0700 (PDT)
X-Mailer: git-send-email 1.8.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226046>

Add protocol imap, imaps, ftp and smtp for credential-osxkeychain.

Signed-off-by: Xidorn Quan <quanxunzhen@gmail.com>
Acked-by: John Szakmeister <john@szakmeister.net>
Acked-by: Jeff King <peff@peff.net>
---
 contrib/credential/osxkeychain/git-credential-osxkeychain.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/contrib/credential/osxkeychain/git-credential-osxkeychain.c b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
index 3940202..bcd3f57 100644
--- a/contrib/credential/osxkeychain/git-credential-osxkeychain.c
+++ b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
@@ -127,10 +127,20 @@ static void read_credential(void)
 		*v++ = '\0';
 
 		if (!strcmp(buf, "protocol")) {
-			if (!strcmp(v, "https"))
+			if (!strcmp(v, "imap"))
+				protocol = kSecProtocolTypeIMAP;
+			else if (!strcmp(v, "imaps"))
+				protocol = kSecProtocolTypeIMAPS;
+			else if (!strcmp(v, "ftp"))
+				protocol = kSecProtocolTypeFTP;
+			else if (!strcmp(v, "ftps"))
+				protocol = kSecProtocolTypeFTPS;
+			else if (!strcmp(v, "https"))
 				protocol = kSecProtocolTypeHTTPS;
 			else if (!strcmp(v, "http"))
 				protocol = kSecProtocolTypeHTTP;
+			else if (!strcmp(v, "smtp"))
+				protocol = kSecProtocolTypeSMTP;
 			else /* we don't yet handle other protocols */
 				exit(0);
 		}
-- 
1.8.3
