From: Faiz Kothari <faiz.off93@gmail.com>
Subject: [PATCH] GSoC 2014 Microproject 1 rewrite skip_prefix() as loop
Date: Wed, 26 Feb 2014 22:16:35 +0530
Message-ID: <1393433195.4629.4.camel@dj-pc>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Faiz Kothari <faiz.off93@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 26 17:46:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIhd8-00024W-Ki
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 17:46:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753228AbaBZQqo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 11:46:44 -0500
Received: from mail-pb0-f49.google.com ([209.85.160.49]:58406 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751879AbaBZQqm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 11:46:42 -0500
Received: by mail-pb0-f49.google.com with SMTP id jt11so1212770pbb.8
        for <git@vger.kernel.org>; Wed, 26 Feb 2014 08:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:subject:from:to:cc:date:content-type:mime-version
         :content-transfer-encoding;
        bh=+z6u5TLGjh8GnY+AP0rsnJRfM96jiR83k21/T4bn2Xc=;
        b=hClBvmojRpQwATXVCxdEVPtdOzFZ+0iuJSRTwInOeMpB28eKr75vucq95HIGNncWxO
         onAPdi4X8QHqpKl83LcDg9jVOm6Uxqgc77HlBMVdTCHsknP+BXVy3D7PQSKvVHHtCayB
         evla64I0x97n7C+KT8vB3S1tXe1Pzq9Bbs3mbmOZDwV+q0G/Hq/3MVpz8eEM0ru0OdNl
         jOU7+Aw48YqCzpj5NUkWWkwNTWgUihRt5gbdTt5w+SCWcpwimsHNxvq3uPsRNgzuPpWC
         Cne7yoKCISLICIquxusJ0G9bi2aP1wRAwdFaeHJ2pq05o1arWG5Vdjpq7VcTjL2s42w9
         hY6w==
X-Received: by 10.68.36.41 with SMTP id n9mr7675639pbj.99.1393433202402;
        Wed, 26 Feb 2014 08:46:42 -0800 (PST)
Received: from [10.3.1.100] ([115.248.130.148])
        by mx.google.com with ESMTPSA id kc9sm4926112pbc.25.2014.02.26.08.46.39
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Wed, 26 Feb 2014 08:46:41 -0800 (PST)
X-Mailer: Evolution 3.10.4 (3.10.4-1.fc20) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242736>

Hi,
I am Faiz Kothari, I am a GSoC aspirant and want to contribute to git.
I am submitting the patch in reponse to Microproject 1,
rewrite git-compat-util.h:skip_prefix() as a loop.

Signed-off-by: Faiz Kothari <faiz.off93@gmail.com>
---
 git-compat-util.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index cbd86c3..bb2582a 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -357,8 +357,11 @@ extern int suffixcmp(const char *str, const char
*suffix);
 
 static inline const char *skip_prefix(const char *str, const char
*prefix)
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
1.9.0.1.ge8df331
