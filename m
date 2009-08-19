From: Frank Li <lznuaa@gmail.com>
Subject: [PATCH 02/12] Define SNPRINTF_SIZE_CORR=1 for Microsoft Visual C++
Date: Wed, 19 Aug 2009 23:52:37 +0800
Message-ID: <1250697167-5536-2-git-send-email-lznuaa@gmail.com>
References: <1250697167-5536-1-git-send-email-lznuaa@gmail.com>
Cc: Frank Li <lznuaa@gmail.com>
To: git@vger.kernel.org, msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Wed Aug 19 17:53:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdnTd-0001c6-OI
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 17:53:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752304AbZHSPxQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 11:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752151AbZHSPxP
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 11:53:15 -0400
Received: from rv-out-0506.google.com ([209.85.198.239]:41043 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752146AbZHSPxP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 11:53:15 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1038011rvb.5
        for <git@vger.kernel.org>; Wed, 19 Aug 2009 08:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=GqRDj+LWdHa1KX9CDE5xQ3qnoc7qf+UefM+/tkA5B7s=;
        b=V+fWge7xzDRKvgqAE+6TfevjK+zi2wVJMk1Otb8ZL55pa1lWobMBbcgDKGpecuBJwe
         0PHK8W+0bRSVEYSWge/tV0Shod29siqtoPLqxoF/HnOI0s4uWY0QO8VxN86deSk4Qtz5
         0uLvSTNr8s7KWAZJZqgwW+hcddqiXJRxh2m7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=S6RrGQe/y8zmdl6k1bof2V0LNPPlphXOYgWnFUshg5STmHPjwohwtszcFvMKqNxk5T
         uasNeKoCU18SXDalXSzgGcJNfzieMRQtvQxODTLD3d+65ZGlOpNCs1qmkfv689Kfw6xV
         AQWTjddJpId3WD1DgPtd1P+xjmYdmWi1DQtsc=
Received: by 10.140.135.20 with SMTP id i20mr2605514rvd.145.1250697196470;
        Wed, 19 Aug 2009 08:53:16 -0700 (PDT)
Received: from localhost ([58.38.115.215])
        by mx.google.com with ESMTPS id l31sm3521178rvb.54.2009.08.19.08.53.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 19 Aug 2009 08:53:15 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.msysgit.0
In-Reply-To: <1250697167-5536-1-git-send-email-lznuaa@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126552>

The Microsoft C runtime's vsnprintf function does not add NUL at
the end of the buffer.

Further, Microsoft deprecated vsnprintf in favor of _vsnprintf, so
add a #define to that end.

Signed-off-by: Frank Li <lznuaa@gmail.com>
---
 compat/snprintf.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/compat/snprintf.c b/compat/snprintf.c
index 6c0fb05..47b2b8a 100644
--- a/compat/snprintf.c
+++ b/compat/snprintf.c
@@ -6,7 +6,7 @@
  * number of characters to write without the trailing NUL.
  */
 #ifndef SNPRINTF_SIZE_CORR
-#if defined(__MINGW32__) && defined(__GNUC__) && __GNUC__ < 4
+#if defined(__MINGW32__) && defined(__GNUC__) && __GNUC__ < 4 || defined(_MSC_VER)
 #define SNPRINTF_SIZE_CORR 1
 #else
 #define SNPRINTF_SIZE_CORR 0
@@ -14,6 +14,11 @@
 #endif
 
 #undef vsnprintf
+
+#if defined(_MSC_VER)
+#define vsnprintf _vsnprintf
+#endif
+
 int git_vsnprintf(char *str, size_t maxsize, const char *format, va_list ap)
 {
 	char *s;
-- 
1.6.4.msysgit.0
