From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 04/83] builtin/apply: avoid local variable shadowing 'len' parameter
Date: Sun, 24 Apr 2016 15:33:04 +0200
Message-ID: <1461504863-15946-5-git-send-email-chriscool@tuxfamily.org>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 15:39:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKFk-0001Ni-Iy
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:39:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752723AbcDXNe7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:34:59 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38147 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752695AbcDXNev (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:34:51 -0400
Received: by mail-wm0-f41.google.com with SMTP id u206so89918924wme.1
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gClf/7XAGFheEdcykU+CYLWL17GkuvXxxTA9sorpapc=;
        b=Kx3cOWzHAgn0uMTZDSgswevvSHdlBq9ekaLTQQC8+XCsbaXkqFWvIGnJas9cf/8KSz
         qMRAxxiyy3GU3P0/tHqkvtPus7IjRFNvhrLXeeEDied3JivZzDNzE/wHpmtAdkAZ+WvQ
         QnB2aEg3Oh6a9jEoiJxZnLofZc/VUBalND0rRb8Hu3ffZsjWLDUyTLnzXzC2y2kJouU7
         CL1kOK28BzcpXY4tBCffyoRFEVU9zmR9/LkHb/R3RagNHU/5+uzOgERkO0U4dsaB5Lhi
         HSHsz09ILZ/JUVYz87zP6bN6IgU/5oJGM2Q6Gh07R4clRnlsubd6eSq3bHCajePrICHK
         pIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gClf/7XAGFheEdcykU+CYLWL17GkuvXxxTA9sorpapc=;
        b=Bkq39fq30Z5QwE/c9ZeLIwqkgyuv6Jq+qpQDtkRmRYiArnvjHE5ikxTQnx3xkbY4II
         uAkUyvdklem+ttrgppY/eGJVY0xxK/AF3Fp6SaJOVY57QdTEJLwl18roREKrchRSeZpq
         qsduQBQWmt8KHOMQTAF4F3IjIT59+xbAhG8rHrsMzws+5rbJRm6ERgN7UlOSaCUeGTnu
         4939rSpk3UjJERRQtt4jw9Zuv1i3Xu0K4Y8El4S2MhgNqcNZUPmzpfrmFqk95Bk3EjAd
         zIymduLraJVbMZXH1xfmgEMNat8n5d2K5CJvnTTQox4CY53TsCE+0DYP+b9/AYl0qFMB
         Jmnw==
X-Gm-Message-State: AOPr4FWg6kWAN2QGrxR0ADEkVygDJzNLWbgBUZKqtad/ODOvSv4gNnhfUc3bKAW0QefTPQ==
X-Received: by 10.194.125.201 with SMTP id ms9mr29383439wjb.71.1461504889661;
        Sun, 24 Apr 2016 06:34:49 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.34.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:34:48 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292398>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 7115dc2..78849e4 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -2194,17 +2194,17 @@ static void update_pre_post_images(struct image *preimage,
 	fixed = preimage->buf;
 
 	for (i = reduced = ctx = 0; i < postimage->nr; i++) {
-		size_t len = postimage->line[i].len;
+		size_t l_len = postimage->line[i].len;
 		if (!(postimage->line[i].flag & LINE_COMMON)) {
 			/* an added line -- no counterparts in preimage */
-			memmove(new, old, len);
-			old += len;
-			new += len;
+			memmove(new, old, l_len);
+			old += l_len;
+			new += l_len;
 			continue;
 		}
 
 		/* a common context -- skip it in the original postimage */
-		old += len;
+		old += l_len;
 
 		/* and find the corresponding one in the fixed preimage */
 		while (ctx < preimage->nr &&
@@ -2223,11 +2223,11 @@ static void update_pre_post_images(struct image *preimage,
 		}
 
 		/* and copy it in, while fixing the line length */
-		len = preimage->line[ctx].len;
-		memcpy(new, fixed, len);
-		new += len;
-		fixed += len;
-		postimage->line[i].len = len;
+		l_len = preimage->line[ctx].len;
+		memcpy(new, fixed, l_len);
+		new += l_len;
+		fixed += l_len;
+		postimage->line[i].len = l_len;
 		ctx++;
 	}
 
-- 
2.8.1.300.g5fed0c0
