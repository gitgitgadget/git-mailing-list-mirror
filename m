From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH 10/12] MINGW: compat/poll/poll.c: undef NOGDI
Date: Tue, 29 Apr 2014 13:12:04 +0400
Message-ID: <1398762726-22825-11-git-send-email-marat@slonopotamus.org>
References: <1398762726-22825-1-git-send-email-marat@slonopotamus.org>
Cc: marat@slonopotamus.org,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 29 11:13:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf46b-0006O2-A2
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 11:13:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933190AbaD2JNa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 05:13:30 -0400
Received: from seldon.slonopotamus.org ([94.242.204.247]:46223 "EHLO
	slonopotamus.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S932967AbaD2JN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 05:13:28 -0400
Received: from [185.6.245.138] (helo=radchenko-d-lnx.mail.msk)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1Wf45M-0006BN-Pz; Tue, 29 Apr 2014 13:12:21 +0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1398762726-22825-1-git-send-email-marat@slonopotamus.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247540>

On MinGW-W64, MsgWaitForMultipleObjects is guarded with #ifndef NOGDI.

Removal -DNOGDI=1 from config.mak.uname has an undesirable effect of
bringing in wingdi.h with weird #define ERROR 0 that conflicts with
internal Git enums. So, just #undef NOGDI in compat/poll/poll.c.

Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
---
 compat/poll/poll.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/compat/poll/poll.c b/compat/poll/poll.c
index 31163f2..e38cba8 100644
--- a/compat/poll/poll.c
+++ b/compat/poll/poll.c
@@ -38,6 +38,7 @@
 #include <assert.h>
 
 #if (defined _WIN32 || defined __WIN32__) && ! defined __CYGWIN__
+# undef NOGDI
 # define WIN32_NATIVE
 # if defined (_MSC_VER) && !defined(_WIN32_WINNT)
 #  define _WIN32_WINNT 0x0502
-- 
1.9.1
