From: Frank Li <lznuaa@gmail.com>
Subject: [PATCH 03/11] Define SNPRINTF_SIZE_CORR 1 when use MSVC build git
Date: Tue, 18 Aug 2009 00:01:04 +0800
Message-ID: <1250524872-5148-3-git-send-email-lznuaa@gmail.com>
References: <1250524872-5148-1-git-send-email-lznuaa@gmail.com>
 <1250524872-5148-2-git-send-email-lznuaa@gmail.com>
Cc: Johannes.Schindelin@gmx.de, Frank Li <lznuaa@gmail.com>
To: git@vger.kernel.org, msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Mon Aug 17 18:02:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md4fE-0003nt-Ea
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 18:02:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756505AbZHQQCU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 12:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756503AbZHQQCT
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 12:02:19 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:24715 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756395AbZHQQCT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 12:02:19 -0400
Received: by rv-out-0506.google.com with SMTP id f6so802590rvb.1
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 09:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=QPbqRfYYgiENk5u4z86u7c/BF3gT/1XzDIRIkao6ml4=;
        b=WZEanfxYiCTWo73VxTCFUPMfDC53t6+fJnmqTG6ZnAfzNAVut3tUlTH5TFOKRuPHX4
         n4Qyq1olTK1HQzh6NMoC6Qm51tOECT2ZlpLBm0H12XLHaW202tADRhG2WRt60ZnOX/49
         +q8vXX1/HSVk49V++Xi3jRr1+WPkbXtGW//K4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=BGEPwgLsA/HedX1jrPqs3O/IS4q9py8zzsSvI5FTvGFv6sovFIunEyNXwVZRz2H+42
         AvQSG248Vik0G6uaC5bbxBAEtCwe/ZApm+f8PKLmCzf4C0/OCoXWE60K027HWOLnwxjV
         EH00EBafhJg4lJ5hAig9JO3C/l9BdiS5cuhhQ=
Received: by 10.140.163.10 with SMTP id l10mr861479rve.162.1250524940879;
        Mon, 17 Aug 2009 09:02:20 -0700 (PDT)
Received: from localhost ([58.38.115.215])
        by mx.google.com with ESMTPS id l31sm18012329rvb.24.2009.08.17.09.02.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 Aug 2009 09:02:20 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.msysgit.0
In-Reply-To: <1250524872-5148-2-git-send-email-lznuaa@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126203>

There are not NUL at vsnprintf verstion of MSVC when rearch max len.
Define vsnprintf to _vsnprintf. vsnprintf have deprecated.

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
