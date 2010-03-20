From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH v2 3/3] find_unique_abbrev: early out without a memcpy
Date: Sat, 20 Mar 2010 19:55:29 +0100
Message-ID: <1269111329-5896-4-git-send-email-kusmabite@gmail.com>
References: <1269111329-5896-1-git-send-email-kusmabite@gmail.com>
Cc: rene.scharfe@lsrfire.ath.cx, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 20 19:57:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt3rC-0007TB-RF
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 19:57:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410Ab0CTS4r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 14:56:47 -0400
Received: from mail-ew0-f216.google.com ([209.85.219.216]:45107 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386Ab0CTS4p (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 14:56:45 -0400
Received: by mail-ew0-f216.google.com with SMTP id 8so297132ewy.28
        for <git@vger.kernel.org>; Sat, 20 Mar 2010 11:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=TZl2yt6mVzsuPfIF4iWLDvxB+zDLOd/0hCNxJzEh7ME=;
        b=LQBn4nku4J8MlHbVylNcCNOlWQixeQoNgsZ3nGgiZ1G/7u0AJLVYMZ3RkR1638rL8U
         1gtHO5/lDt43M1Q9EwvsPRtVX5mtOR7wdZ39CjbtE956OQT4wWEhOpomTQLtt+K8/9WO
         Hon9zQBo1SNggdwWq7YABMXgqLeIpWmLilwa4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=KFpDEvV7I9zbk6cPPtM7ddzmgEOs68EcHONYeh4bpPPNRa9OF/dlLjZQQraTJcF0H7
         9okqwS0uxuZNJdBf4hAxVMjVhVN9OJAy1pUcYoTuDJB8RNRhhacsgpQx3eBDLZqgC7Ae
         rcRyUS37/MF5FXC+G2P9+vrvWvpeyifooDXaM=
Received: by 10.213.54.147 with SMTP id q19mr1571558ebg.12.1269111404200;
        Sat, 20 Mar 2010 11:56:44 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id 13sm1241688ewy.13.2010.03.20.11.56.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Mar 2010 11:56:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.2.456.g64f24
In-Reply-To: <1269111329-5896-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142739>

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 sha1_name.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index bf92417..2b1be58 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -196,10 +196,10 @@ const char *find_unique_abbrev(const unsigned char *sha1, int len)
 	int status, exists;
 	static char hex[41];
 
+	if (len == 40 || !len)
+		return sha1_to_hex(sha1);
 	exists = has_sha1_file(sha1);
 	memcpy(hex, sha1_to_hex(sha1), 40);
-	if (len == 40 || !len)
-		return hex;
 	while (len < 40) {
 		unsigned char sha1_ret[20];
 		status = get_short_sha1(hex, len, sha1_ret, 1);
-- 
1.7.0.2.456.g64f24
