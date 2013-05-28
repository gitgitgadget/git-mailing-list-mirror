From: Xidorn Quan <quanxunzhen@gmail.com>
Subject: [PATCH v3] credential-osxkeychain: support more protocols
Date: Tue, 28 May 2013 10:36:21 +0800
Message-ID: <1369708581-4104-1-git-send-email-quanxunzhen@gmail.com>
References: <1369665359-48242-1-git-send-email-quanxunzhen@gmail.com>
Cc: Xidorn Quan <quanxunzhen@gmail.com>, Jeff King <peff@peff.net>,
	John Szakmeister <john@szakmeister.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 28 04:36:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uh9mP-00027v-4g
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 04:36:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758634Ab3E1Cgs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 May 2013 22:36:48 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:41023 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758627Ab3E1Cgs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 May 2013 22:36:48 -0400
Received: by mail-pd0-f180.google.com with SMTP id 14so4653827pdc.25
        for <git@vger.kernel.org>; Mon, 27 May 2013 19:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=GzGvx6Z1l1ndU+f/c79O87SqoHCVB5TlVRoJeT9LCcw=;
        b=JXX8Zkj1AGtN4W0YHfVN/SIG77m0gHAf8PXQSdVKP+A/o5TYx5O9BDCwGfsIr4C+4I
         Nd0IPghp+Totuz1VCCN6quFUGvCdTi+pg7oV53m97WO07NUDs0h04FkfKzuKnLuL1ySy
         Bh/4/74KkTZjCOkVgeHQthOPy4TLZU2FASn7PiYKDu3oFRZhtm4RkCnpZVXI3e2Y7iq9
         QY1B2//zdZHZYAOlRFOjFjl3SUZQCE0iKu+kR+a1DwNvc87G1KJOOu1LnIZ+FMJkibMj
         lpn+am9Qe0YQk+MFXCvlJEN8WvDvFMXLD0GWxnFkVdf5LkftlKyZFjnXXjLoM9wEsBhT
         CWBw==
X-Received: by 10.66.246.131 with SMTP id xw3mr31747088pac.114.1369708607618;
        Mon, 27 May 2013 19:36:47 -0700 (PDT)
Received: from localhost.localdomain ([221.239.198.136])
        by mx.google.com with ESMTPSA id bs2sm32955470pad.17.2013.05.27.19.36.44
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 27 May 2013 19:36:46 -0700 (PDT)
X-Mailer: git-send-email 1.8.3
In-Reply-To: <1369665359-48242-1-git-send-email-quanxunzhen@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225618>

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
