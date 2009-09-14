From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH 1/2] increase portability of NORETURN declarations
Date: Mon, 14 Sep 2009 13:49:33 +0200
Message-ID: <1252928973-6280-1-git-send-email-kusmabite@gmail.com>
Cc: Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 14 13:50:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnA4v-00033D-90
	for gcvg-git-2@lo.gmane.org; Mon, 14 Sep 2009 13:50:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755390AbZINLuN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2009 07:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751632AbZINLuN
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Sep 2009 07:50:13 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:40890 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895AbZINLuM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2009 07:50:12 -0400
Received: by ewy2 with SMTP id 2so578316ewy.17
        for <git@vger.kernel.org>; Mon, 14 Sep 2009 04:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=VmVrrtm2+LPKIyu8cdeptpxnV2JtecLWe25DcXKt22o=;
        b=nyt15NQIoaGrca6VSSEJjca53RiGGJxz5ZH+mEUQ5PqmIF1aAsB0uNaosW2D2vFxSo
         Yrsq7ckQZW4ngT+lr6dWIafVoCJv3C/xoIjhGJByMS3fE/Q0/ulgrLR7V6M+5FhfVCzV
         5I8Eh0pSyg77gD1L2T7eHLkZvHTGbMWPUGh5A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=ZbvYkkiMJmxJO5mM1FEaUCvT+MzauCPb7fvB7KITbf4v7JDqYbRJioK16FilPF1Aco
         iPCcyAYf6w9lmm59F1GXoYRP6K/B3GNLHCtR2sbkxD/xiYIfZRuJH0VSHfeQe6JEB1Yh
         vGHqywh2luasI7dzNLEQV3+RjJuhVvzlQn9L4=
Received: by 10.211.138.11 with SMTP id q11mr6793930ebn.1.1252929010383;
        Mon, 14 Sep 2009 04:50:10 -0700 (PDT)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id 28sm689587eye.40.2009.09.14.04.50.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 14 Sep 2009 04:50:09 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.msysgit.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128448>

Some compilers (including at least MSVC) supports NORETURN
on function declarations, but only before the function-name.

This patch makes it possible to define NORETURN for those compilers.

Signed-off-by: Erik Faye-Lund <kusmab...@gmail.com>
---

This patch requires specifying "-C 2" to "git am" to apply to the
current maint(7fb6bcf), but I suspect that it's not really needed
there. Supporting new compilers is going to require additional
patching anyway.

 git-compat-util.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index e5e9f39..5876d91 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -177,9 +177,9 @@ extern char *gitbasename(char *);
 #include "compat/bswap.h"
 
 /* General helper functions */
-extern void usage(const char *err) NORETURN;
-extern void die(const char *err, ...) NORETURN __attribute__((format (printf, 1, 2)));
-extern void die_errno(const char *err, ...) NORETURN __attribute__((format (printf, 1, 2)));
+extern NORETURN void usage(const char *err);
+extern NORETURN void die(const char *err, ...) __attribute__((format (printf, 1, 2)));
+extern NORETURN void die_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
 extern int error(const char *err, ...) __attribute__((format (printf, 1, 2)));
 extern void warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
 
-- 
1.6.4.msysgit.0.16.gd92d4.dirty
