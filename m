From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 4/4] xdiff/xhistogram: drop need for additional variable
Date: Mon,  1 Aug 2011 12:20:10 +0800
Message-ID: <1312172410-4380-5-git-send-email-rctay89@gmail.com>
References: <1312168608-10828-1-git-send-email-rctay89@gmail.com>
 <1312172410-4380-1-git-send-email-rctay89@gmail.com>
 <1312172410-4380-2-git-send-email-rctay89@gmail.com>
 <1312172410-4380-3-git-send-email-rctay89@gmail.com>
 <1312172410-4380-4-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 01 06:20:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qnjzj-0002mU-Sx
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 06:20:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752086Ab1HAEUl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 00:20:41 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37546 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025Ab1HAEUk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 00:20:40 -0400
Received: by mail-iy0-f174.google.com with SMTP id 12so6447661iyb.19
        for <git@vger.kernel.org>; Sun, 31 Jul 2011 21:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=RnDKjAjyGksbWNjGuWQQWyQlAszwMcuoFOIm+1q6FNg=;
        b=UHy0/7+OP7e1pPn8G4mTlZz04dRohl4/gkDIf7SCN0AAn8KG3U6EeBSnnYnNf1ZUm9
         cuoNkLFV2Vrws8b8iUq2plKE1KRv4uyhM/jNn4qzFTEW5F14tvrZNEFrvYdTLLPVLlg2
         KiEF7L0FujDKgALn1n1lEOyrQOFyzqkGpV7r4=
Received: by 10.231.82.17 with SMTP id z17mr2680543ibk.45.1312172439714;
        Sun, 31 Jul 2011 21:20:39 -0700 (PDT)
Received: from localhost (cm119.beta238.maxonline.com.sg [116.86.238.119])
        by mx.google.com with ESMTPS id q13sm3109401ibi.9.2011.07.31.21.20.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 31 Jul 2011 21:20:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.msysgit.0
In-Reply-To: <1312172410-4380-4-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178313>

Having an additional variable (ptr) instead of changing line(1|2) and
count(1|2) was for debugging purposes.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 xdiff/xhistogram.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
index 804e19b..3201fc5 100644
--- a/xdiff/xhistogram.c
+++ b/xdiff/xhistogram.c
@@ -323,11 +323,10 @@ static int histogram_diff(xpparam_t const *xpp, xdfenv_t *env,
 		result = fall_back_to_classic_diff(&index, line1, count1, line2, count2);
 	else {
 		if (lcs.begin1 == 0 && lcs.begin2 == 0) {
-			int ptr;
-			for (ptr = 0; ptr < count1; ptr++)
-				env->xdf1.rchg[line1 + ptr - 1] = 1;
-			for (ptr = 0; ptr < count2; ptr++)
-				env->xdf2.rchg[line2 + ptr - 1] = 1;
+			while (count1--)
+				env->xdf1.rchg[line1++ - 1] = 1;
+			while (count2--)
+				env->xdf2.rchg[line2++ - 1] = 1;
 			result = 0;
 		} else {
 			if (result = histogram_diff(xpp, env,
-- 
1.7.3.4.730.g67af1.dirty
