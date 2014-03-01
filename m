From: Siddharth Goel <siddharth98391@gmail.com>
Subject: [PATCH] git-compat-util.h:rewrite skip_prefix() as loop
Date: Sat,  1 Mar 2014 21:32:04 +0800
Message-ID: <1393680724-19983-1-git-send-email-siddharth98391@gmail.com>
Cc: gitster@pobox.com, Siddharth Goel <siddharth98391@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 01 14:32:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJk1X-0000zq-RG
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 14:32:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752654AbaCANcM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2014 08:32:12 -0500
Received: from mail-pb0-f52.google.com ([209.85.160.52]:52268 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752370AbaCANcL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 08:32:11 -0500
Received: by mail-pb0-f52.google.com with SMTP id rr13so1929436pbb.25
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 05:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ktSyEtETThUpqRNyXXj1UyBwfcmk7ghvTbfT3Y2dP5o=;
        b=GdrTE3OTptlFNxMmWlau4ohIHs0xJ5CYnwC+FRILm6y4i1vxoervt9JqHdegOgAegU
         UATBc0mpWYRYJJzaiItLTSYLmpje3m4VTW8IVLofcgiag/nBgUbP9VkadViNsY/DXVXf
         UdwqBOma0+NDllK4wfsQ5eF/2Z46Hd3+zlISF5cFzJu3fXGcnwX7DSxuVKOFcsi2W1RW
         /sxGVMfMejbXWnqMoTlAP61Lwx0swOZwaIGfQeJj85u4EptMBjlWc9SwnuyrswrdAiMr
         XlAqHRf5s/7IGCawbBfZmcW54944e7/NpekRuxw3Nmib4FA58EfdyBLzFkP0vGFYsb6e
         oW4Q==
X-Received: by 10.66.216.129 with SMTP id oq1mr9374219pac.75.1393680731105;
        Sat, 01 Mar 2014 05:32:11 -0800 (PST)
Received: from vbox.nus.edu.sg (s150119.pc.nus.edu.sg. [137.132.72.246])
        by mx.google.com with ESMTPSA id vb7sm337768pbc.13.2014.03.01.05.32.08
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 01 Mar 2014 05:32:10 -0800 (PST)
X-Mailer: git-send-email 1.9.0.138.g2de3478.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243097>

Rewrote skip_prefix() function so that prefix is scanned once.

Signed-off-by: Siddharth Goel <siddharth98391@gmail.com>
---
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
