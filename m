From: David Michael <fedora.dm0@gmail.com>
Subject: [PATCH 3/3] compat/bswap.h: Detect endianness from XL C compiler macros
Date: Sun, 26 Oct 2014 13:34:26 -0400
Message-ID: <87k33mag65.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 26 18:34:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XiRhz-000723-ED
	for gcvg-git-2@plane.gmane.org; Sun, 26 Oct 2014 18:34:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751757AbaJZReY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2014 13:34:24 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:51591 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751745AbaJZReX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2014 13:34:23 -0400
Received: by mail-qa0-f46.google.com with SMTP id s7so2885560qap.5
        for <git@vger.kernel.org>; Sun, 26 Oct 2014 10:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:mime-version:content-type;
        bh=V4zNRs4zi3JEdZxG08TlK6Jjgxg7UEBiWESuxagCl4c=;
        b=zgb/iPcHIKkR88CRill2Fzku0ms6c0i2SbfRHgyFwk61dza+62PYImmSJK8aQDrIPv
         QnQg9wBUIbwnSblyCqkh/oj0/lnrY+aLuq9mnDWqVXvF+lBXqv92XBXOlNpL4UKsHoRJ
         vbO1KqjIYfAYh8zb6CHl3gu5zALRUqDu0h2ojyZkhjGycW+kEr4V3bobpcIK2Xj3R17u
         JsyI8P0YlIm/lMbUuSVe/9N3rDwhPURga4GTM+5ft4f6bG1tky7QTdoQyfujhk4yy2ST
         iQxFqGtwB3Z5rlB+9R2ScAGsV8Zs7Snjg7mTQP71+vYbHMvXZS0mXsbkNtQRMQX+QNBe
         R8Gg==
X-Received: by 10.229.79.132 with SMTP id p4mr6492369qck.14.1414344862816;
        Sun, 26 Oct 2014 10:34:22 -0700 (PDT)
Received: from callisto (c-68-81-204-146.hsd1.pa.comcast.net. [68.81.204.146])
        by mx.google.com with ESMTPSA id c63sm1636828qgf.14.2014.10.26.10.34.21
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Oct 2014 10:34:22 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is no /usr/include/endian.h equivalent on z/OS, but the
compiler will define macros to indicate endianness on host and
target hardware.  This adds a test for these macros as a last
resort for determining byte order.

Signed-off-by: David Michael <fedora.dm0@gmail.com>
---
 compat/bswap.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/compat/bswap.h b/compat/bswap.h
index f6fd9a6..7fed637 100644
--- a/compat/bswap.h
+++ b/compat/bswap.h
@@ -122,6 +122,10 @@ static inline uint64_t git_bswap64(uint64_t x)
 #  define GIT_BYTE_ORDER GIT_BIG_ENDIAN
 # elif defined(_LITTLE_ENDIAN) && !defined(_BIG_ENDIAN)
 #  define GIT_BYTE_ORDER GIT_LITTLE_ENDIAN
+# elif defined(__THW_BIG_ENDIAN__) && !defined(__THW_LITTLE_ENDIAN__)
+#  define GIT_BYTE_ORDER GIT_BIG_ENDIAN
+# elif defined(__THW_LITTLE_ENDIAN__) && !defined(__THW_BIG_ENDIAN__)
+#  define GIT_BYTE_ORDER GIT_LITTLE_ENDIAN
 # else
 #  error "Cannot determine endianness"
 # endif
-- 
1.9.3
