From: Siddharth Goel <siddharth98391@gmail.com>
Subject: [PATCH v2] skip_prefix:rewrite so that prefix is scanned once
Date: Sun,  2 Mar 2014 23:03:04 +0800
Message-ID: <1393772584-3716-1-git-send-email-siddharth98391@gmail.com>
Cc: sunshine@sunshineco.com, Siddharth Goel <siddharth98391@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 02 16:03:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WK7vX-0005uH-23
	for gcvg-git-2@plane.gmane.org; Sun, 02 Mar 2014 16:03:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbaCBPDN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2014 10:03:13 -0500
Received: from mail-pb0-f43.google.com ([209.85.160.43]:51520 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826AbaCBPDN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2014 10:03:13 -0500
Received: by mail-pb0-f43.google.com with SMTP id um1so2729612pbc.2
        for <git@vger.kernel.org>; Sun, 02 Mar 2014 07:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=O1Kwa/R1At0YezIYOFFkkuZqhtfVj3khasAEo6CC2AA=;
        b=scfy3J/DWhFbno9PN/IODpnY3Mg8QianhUwGEzPyz5NybiHeNegvqoI3byC3+tnRld
         A9OnsZIxJQpw5uLDs3eKsT2+5mo8oC4I+iqfQAU5iI+DEashHw0gX+6DxTJnzsbXaVGf
         YRwH4YrGU6u8CpkhCOWr3H4aT//Xye+gTE5Jd4kJCG1MJXIzrw/SulR7gVvH8Cy0tfUg
         w6yNQo19ZwPJW00tEmXG3+d4SNh2evWA57lE/q4ONtbgeC2ua4HPICug5jIocNaIKBrg
         J84NEnqOKfOvnJRu6DskUk4wWEPJG41+zyfpHeD00RkBWYXYuGJmB6jNlgE8OXBCdkhz
         DDfw==
X-Received: by 10.66.246.229 with SMTP id xz5mr1557899pac.119.1393772592570;
        Sun, 02 Mar 2014 07:03:12 -0800 (PST)
Received: from vbox.singnet.com.sg ([202.166.71.42])
        by mx.google.com with ESMTPSA id vn10sm26231701pbc.21.2014.03.02.07.03.10
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 02 Mar 2014 07:03:11 -0800 (PST)
X-Mailer: git-send-email 1.9.0.138.g2de3478.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243150>

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Siddharth Goel <siddharth98391@gmail.com>
---
Thanks a lot Eric for your valuable comments. Please let me know if there is 
anything else which needs to be modified in this patch.

 git-compat-util.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 614a5e9..550dce3 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -357,8 +357,11 @@ extern int suffixcmp(const char *str, const char *suffix);
 
 static inline const char *skip_prefix(const char *str, const char *prefix)
 {
-	size_t len = strlen(prefix);
-	return strncmp(str, prefix, len) ? NULL : str + len;
+	while (*prefix != '\0' && *str == *prefix) {
+		str++;
+		prefix++;
+	}
+	return (*prefix == '\0' ? str : NULL);
 }
 
 #if defined(NO_MMAP) || defined(USE_WIN32_MMAP)
-- 
1.9.0.138.g2de3478.dirty
