From: Faiz Kothari <faiz.off93@gmail.com>
Subject: [PATCH] rewrite skip_prefix() as loop
Date: Thu, 27 Feb 2014 17:32:42 +0530
Message-ID: <1393502562-28025-1-git-send-email-faizkothari@gmail.com>
Cc: Faiz Kothari <faiz.off93@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 27 13:03:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIzgD-0006kJ-Ti
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 13:03:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbaB0MDE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 07:03:04 -0500
Received: from mail-pd0-f175.google.com ([209.85.192.175]:39732 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223AbaB0MDD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 07:03:03 -0500
Received: by mail-pd0-f175.google.com with SMTP id x10so2354742pdj.20
        for <git@vger.kernel.org>; Thu, 27 Feb 2014 04:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ot56iNj5b/k60S7ighy5Lz0N3kAiN260NvAJkPKpC0s=;
        b=FqPDxmxj48XmxPBwjDj//THjyCCnvOym3s/Mi1PdEsw75ZyQJmY28lxj3k82r4vteO
         oBuqXcQuRjfux2oNWjFoC7VqW76o0bTl+RHgpsEvw8DUMPA4mekjgtfhH4jsDzNGqiXZ
         J9H+yo330qOo/gGaDjJMR5CAxDh2QJobOl6Gtj/+t8q3XfvQA0ZsHYmPgU2p5278xpBz
         PKSLTDKCHSBpAOFLJdW3a73aK78mlP+ITpdGClv/ctCB9qJv8trSPcuArxxg+QtLXSi0
         UKY3q/DgKf3sKCmzaD4MyZyGbw0y/76C9elTlPajg7rPBfi8GBhwjHorzR6JGgRB3TLq
         8SkA==
X-Received: by 10.68.176.65 with SMTP id cg1mr12940325pbc.145.1393502582708;
        Thu, 27 Feb 2014 04:03:02 -0800 (PST)
Received: from dj-pc.bits-goa.ac.in ([115.248.130.148])
        by mx.google.com with ESMTPSA id ce15sm29852428pac.0.2014.02.27.04.02.59
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 27 Feb 2014 04:03:01 -0800 (PST)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242811>

From: Faiz Kothari <faiz.off93@gmail.com>


Signed-off-by: Faiz Kothari <django@dj-pc.(none)>
---
 git-compat-util.h |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index cbd86c3..bb2582a 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -357,8 +357,11 @@ extern int suffixcmp(const char *str, const char *suffix);
 
 static inline const char *skip_prefix(const char *str, const char *prefix)
 {
-	size_t len = strlen(prefix);
-	return strncmp(str, prefix, len) ? NULL : str + len;
+	for (; ; str++, prefix++)
+		if (!*prefix)
+			return str;//code same as strbuf.c:starts_with()
+		else if (*str != *prefix)
+			return NULL;
 }
 
 #if defined(NO_MMAP) || defined(USE_WIN32_MMAP)
-- 
1.7.9.5
