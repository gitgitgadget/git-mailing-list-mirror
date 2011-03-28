From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] Improve test for pthreads flag
Date: Mon, 28 Mar 2011 09:39:59 +0200
Message-ID: <1301297999-30130-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 28 09:40:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q473o-0005Rz-8L
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 09:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119Ab1C1HkS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 03:40:18 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:43264 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314Ab1C1HkR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 03:40:17 -0400
Received: by ewy4 with SMTP id 4so1085856ewy.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 00:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=vVW9EYk5/vOudGArm+oXmXv2+SME8+4NFUbt0nRVdr0=;
        b=ZJC8wtVmEBSl53EmVjoeybWQikC/LntJOp8wu+8TvKjlqDZAdO07nuwKwqqj7k2fS+
         IXFVjaawgK/2kKx3goYo5AQR9g7QIv+vBBtbRB4pYlmSQOZhsHy6Ue+pSbjtDbvDjJqX
         LQZEw8JKcyl3gAuiaYUjeqjiEPgaeZPOiHtBE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=SPIyHzJK7/qsN23gULzUCF/wE07FCDG0VVHdzEMiBl5HshHVvXxDGosVQYcpDpD4jU
         cMhT1TBPNLckBlmDgfToC1rOgkr6TNpb+FwHdvM7CckVYskB5yP3mc0x/E93CQtG5+XU
         UNl237zDvtpoYaeec5rc8diKFEJgnO8QONtcE=
Received: by 10.213.98.135 with SMTP id q7mr1026584ebn.72.1301298016136;
        Mon, 28 Mar 2011 00:40:16 -0700 (PDT)
Received: from localhost ([151.97.19.54])
        by mx.google.com with ESMTPS id v60sm2529118eeh.16.2011.03.28.00.40.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Mar 2011 00:40:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.2.644.gb47dd1.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170105>

When compiling with CC=clang using Clang 1.1 as shipped by Debian
unstable (package version 2.7-3), the -mt flag is sufficient to compile
during the `configure` test. However, building git would then fail at
link time complaining about missing symbols such as `pthread_key_create'
and `pthread_create'.

Work around this issue by adding pthread key creation to the pthreads
configure test source.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 configure.ac |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/configure.ac b/configure.ac
index dd07907..fafd815 100644
--- a/configure.ac
+++ b/configure.ac
@@ -895,7 +895,9 @@ AC_LANG_PROGRAM([[
 #include <pthread.h>
 ]], [[
 	pthread_mutex_t test_mutex;
+	pthread_key_t test_key;
 	int retcode = 0;
+	retcode |= pthread_key_create(&test_key, (void *)0);
 	retcode |= pthread_mutex_init(&test_mutex,(void *)0);
 	retcode |= pthread_mutex_lock(&test_mutex);
 	retcode |= pthread_mutex_unlock(&test_mutex);
-- 
1.7.4.2.644.gb47dd1.dirty
