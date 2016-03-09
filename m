From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 03/48] builtin/apply: avoid local variable shadowing 'len' parameter
Date: Wed,  9 Mar 2016 18:48:31 +0100
Message-ID: <1457545756-20616-4-git-send-email-chriscool@tuxfamily.org>
References: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 09 18:52:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiHO-0007SG-0u
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 18:52:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933632AbcCIRwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 12:52:10 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36931 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933576AbcCIRwG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 12:52:06 -0500
Received: by mail-wm0-f54.google.com with SMTP id p65so81779235wmp.0
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 09:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4D1pNndNbj5euH76sB2mnWxYj1D3XSafQ+8MdRgNRmA=;
        b=LIwyVTmZp99oznDYs1t0yDySG85pjasyBTHDAb3/pe5cQ3e97Jr8cL/WCeUPpZ/KGH
         AhIUtJQoS9n/rhaSYcz01YMFv0G8A8wJrwaoflH2VfYEwnYH4yYoPfedIRQPcrEnpMkt
         uIy9WqqxP+So5QyXa33AjhVK4CfhADmB9dxMvLfwKEiMjKH4F5VqCdvWX8lEkL9FLw8j
         /1R/f13PJLGdIQD3N2AWUCuhq74Lo+sfU9eDpefbgqY7Uoo6PQBN5oBlka/Sh0DhEjgv
         f1Cisr1SdO1oRu7iYVTzg/UVggfznD0yj1yhanKyxa+vQcT1GQ2l9HmCezgWciX1tESb
         38Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4D1pNndNbj5euH76sB2mnWxYj1D3XSafQ+8MdRgNRmA=;
        b=gZWmEb5RaGE4Fy1NjUvFtgWgats85aBRxr+OgLGH/TliawnkRxFAzf63Rg/MeKePFJ
         rmaIx3nYMQCRyVXKtOSnmmmwBlEFMMuHPRcP6YZzenTH7tX3hdKCltvmsAX4JcMOsbXb
         ItZGxQh2Rn2OdeTfUg1Id76+jQHQ06jzy+Kg8jVIOO9EGH9cr8J9hDiSOcORDwUlQewC
         S6wABzt4lo9KYM2Qxn+OlF6WAcFx4rSNNGdJtbpFWlpMckRlNJQryJwN5hVYViVzBOqv
         ERpw04toAx3zE79u3pluYaEBgUBe4T02UO/031r41791fmVl9CDNOO0MKQfH/hUH6+e5
         +S0A==
X-Gm-Message-State: AD7BkJKMidDyP1+8br5rsVJ00ZF2fCuNV+VWoXFpTPp93PuMZa6dFmBENB5hpLTdYDMrzQ==
X-Received: by 10.194.248.163 with SMTP id yn3mr35996454wjc.179.1457545925556;
        Wed, 09 Mar 2016 09:52:05 -0800 (PST)
Received: from localhost.localdomain ([80.215.161.239])
        by smtp.gmail.com with ESMTPSA id e127sm24975419wma.20.2016.03.09.09.52.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Mar 2016 09:52:04 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc1.49.gca61272
In-Reply-To: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288491>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 3f740c7..c99c859 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -2196,17 +2196,17 @@ static void update_pre_post_images(struct image *preimage,
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
@@ -2225,11 +2225,11 @@ static void update_pre_post_images(struct image *preimage,
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
2.8.0.rc1.49.gca61272
