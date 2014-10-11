From: Etienne Buira <etienne.buira@gmail.com>
Subject: [PATCH 2/2] Remove spurious 'no threads support' warnings
Date: Sat, 11 Oct 2014 16:46:27 +0200
Message-ID: <8d057560e40fb5edaa3a32f204718c5e561a207a.1413038338.git.etienne.buira@gmail.com>
References: <d2df2f619967ea7ba9625868b9c77d79a1190665.1413038338.git.etienne.buira@gmail.com>
Cc: Etienne Buira <etienne.buira@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 11 16:46:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xcxwb-0007zZ-53
	for gcvg-git-2@plane.gmane.org; Sat, 11 Oct 2014 16:46:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752402AbaJKOqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Oct 2014 10:46:49 -0400
Received: from mail-wg0-f43.google.com ([74.125.82.43]:35766 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752365AbaJKOqt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Oct 2014 10:46:49 -0400
Received: by mail-wg0-f43.google.com with SMTP id m15so5794910wgh.26
        for <git@vger.kernel.org>; Sat, 11 Oct 2014 07:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+LHKKDPQSGMZJ/taWZ9IteHNrGCV9QfUGnTY4Swe4do=;
        b=gVlbURbDCO9yzAV1+VNYBHPZkuEmJtRiGgI+FLYEqfYyofEdDt4nJ94Asm2B82ueI4
         k76tS/zbPm8Ci1MgoO0GxQvib9T2dY6ygVZOCuWBr0QK/pLY43jNraCLW2RGjO8EOW01
         UN7GMnBI4xR2iHTO8c2Anv1qgstFJpGgrL6adl2h6evefgXva9fAHIq7jHS6b2vMz9zs
         a5wxAOhhNErDSxJIfad8/IMnRQMYzd5IJ7kLZo+WxWcXlUp74y7qaAiZUubrr6lS8r+L
         4Z+PPQJ3KWUhADcJmvAz6pP5H+0VCqBEik9dG+0XT6EbrpjMQN39RTfIFMsPD/Mhkrxe
         cEXg==
X-Received: by 10.180.78.35 with SMTP id y3mr10602381wiw.39.1413038807921;
        Sat, 11 Oct 2014 07:46:47 -0700 (PDT)
Received: from localhost.localdomain (sbr22-2-88-185-151-243.fbx.proxad.net. [88.185.151.243])
        by mx.google.com with ESMTPSA id t9sm10295819wjf.41.2014.10.11.07.46.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Oct 2014 07:46:47 -0700 (PDT)
X-Mailer: git-send-email 1.8.5.5
In-Reply-To: <d2df2f619967ea7ba9625868b9c77d79a1190665.1413038338.git.etienne.buira@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Threads count being defaulted to 0 (autodetect), and --disable-pthreads
build checking that thread count==1, there were spurious warnings about
threads being ignored, despite not specified on command line/conf.

Fixes tests 5521 and 5526 that were broken in --disable-pthreads builds
because of those warnings.

Signed-off-by: Etienne Buira <etienne.buira@gmail.com>
---
 builtin/pack-objects.c | 2 +-
 thread-utils.h         | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index b59f5d8..7b51453 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -51,7 +51,7 @@ static int progress = 1;
 static int window = 10;
 static unsigned long pack_size_limit;
 static int depth = 50;
-static int delta_search_threads;
+static int delta_search_threads = THREAD_COMPAT_DEFAULT_THREAD_NBR;
 static int pack_to_stdout;
 static int num_preferred_base;
 static struct progress *progress_state;
diff --git a/thread-utils.h b/thread-utils.h
index 6fb98c3..4f5e802 100644
--- a/thread-utils.h
+++ b/thread-utils.h
@@ -7,5 +7,8 @@
 extern int online_cpus(void);
 extern int init_recursive_mutex(pthread_mutex_t*);
 
+#define THREAD_COMPAT_DEFAULT_THREAD_NBR 0
+#else
+#define THREAD_COMPAT_DEFAULT_THREAD_NBR 1
 #endif
 #endif /* THREAD_COMPAT_H */
-- 
1.8.5.5
