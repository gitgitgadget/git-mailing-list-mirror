From: Siddharth Goel <siddharth98391@gmail.com>
Subject: [PATCH v3] skip_prefix: rewrite so that prefix is scanned once
Date: Mon,  3 Mar 2014 11:13:04 +0800
Message-ID: <1393816384-3300-1-git-send-email-siddharth98391@gmail.com>
Cc: sunshine@sunshineco.com, Siddharth Goel <siddharth98391@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 03 04:13:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKJJf-0006sv-Fz
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 04:13:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752988AbaCCDNP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2014 22:13:15 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36655 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752589AbaCCDNO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2014 22:13:14 -0500
Received: by mail-pa0-f54.google.com with SMTP id lf10so493947pab.27
        for <git@vger.kernel.org>; Sun, 02 Mar 2014 19:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=8+cEUfxkFwblMbgDX9UtyI3uLfC5Dr/VyOjDJyh5Keo=;
        b=fUc6WhFOmCg7+2HQNL2kgLacE+cy0mFn2Fb2Elhpk8FNsJ36pjnYk+prkZq1K+2DPu
         A9s1pe7uPEYxWDv9WX0i27VXdH4BcesNeWqh/MXURHfIN21ucvCSsDXFZDurXo5HoaOt
         R3JQJ+JpW6Zf2jqT2HrzfRPCtTSKfyZuQZNeEU5cH43eLeJ4vt0b+SWvkrrZ5RaM/QAU
         dcl3EKwaFKKcVyCZccWHVM0C/k+sd5mde1l91R0IrnmjV5T7BHk2zlIl8br2oz2ojCiJ
         8XYZJYohuH0UQQTnA7LH8WV/UXGVVUU+FrZRmFljWgcfBHrmjiMd8s/4q1CX3s68jc4Y
         dBIA==
X-Received: by 10.68.19.164 with SMTP id g4mr17032585pbe.36.1393816394343;
        Sun, 02 Mar 2014 19:13:14 -0800 (PST)
Received: from vbox.nus.edu.sg (nusnet-17-89.dynip.nus.edu.sg. [137.132.17.89])
        by mx.google.com with ESMTPSA id sy2sm30345727pbc.28.2014.03.02.19.13.12
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 02 Mar 2014 19:13:13 -0800 (PST)
X-Mailer: git-send-email 1.9.0.138.g2de3478.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243174>

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Siddharth Goel <siddharth98391@gmail.com>
---
Added a space after colon in the subject as compared to previous 
patch [PATCH v2].

[PATCH v2]: http://thread.gmane.org/gmane.comp.version-control.git/243150

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
