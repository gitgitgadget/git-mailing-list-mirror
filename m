From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 04/94] builtin/apply: avoid local variable shadowing 'len' parameter
Date: Wed, 11 May 2016 15:16:15 +0200
Message-ID: <20160511131745.2914-5-chriscool@tuxfamily.org>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 15:18:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U2G-0001gv-RK
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:18:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbcEKNSl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:18:41 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33223 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338AbcEKNSg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:18:36 -0400
Received: by mail-wm0-f66.google.com with SMTP id r12so9403723wme.0
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oACS5vS6VpZ2N8DxCtgM5v3ZPizRJZLhex9wSrikpM4=;
        b=AiDv5sHviGk0uzb7tpXidjQoTveqllQcWXMj1TagyfO8BiVjTPzBNFZmq64JX80Li5
         PTrx09SBfFJmVYonfxj2EXyUBqlhP5rW5SwKWoZruVClnpxMyYI/LOcznYhMMcXdeUbW
         Goea1l1p/sK9OaKvNM2wjHmNGg/3kOkUsz5PzmEQK2dmUiK+j80yuUWxvz57cztk/baZ
         Z5hRLgl7mBYcatHAFAXNmXXtGdCRMd1Lz69dU3oaNNQL2JmV1QZ209+AUmERvLJx48F0
         QbSZrs5J810dCI/YjAPMHkGtV76gKCeGYPXeS39aNTbNN9UaFORGBPU/5BIoyw3WFNP1
         3D9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oACS5vS6VpZ2N8DxCtgM5v3ZPizRJZLhex9wSrikpM4=;
        b=Ns+kLkxGiQPjM8Q9tBqNNnWy3F6A2/ZZADlv0AlbbTfnEvHWLC7mlJifzupGmo/TYh
         7P2zscZs04JmfRqvAj1MnBap7quvJSQ74HQctX5Gw1uOwjQNRUoWkmRcTIvtxsCJ2NI7
         ka9m1R2kPIAjYcVBsSi0tEO8yAnc+LWjCDP8pG8CD6u7YknPDiVabR5N0R8/NLgbPX8G
         0CtxslNAsrFz0IVnouznIf7XgPqXwm3hFJ8o0q77nLlFbxFceRchAoMh9aB/divSr52s
         0ljJcCjOjE6PHcbJyudfAMmMTT+8okrE7SiKuq4HJr2I12i33FWCQUUXlI207dmE9JQu
         fcHA==
X-Gm-Message-State: AOPr4FU256Rc0GonK+mypatIvRnYXLLcr3InpradQcwG40tStiPBalDcBy2doiS4i4MZaA==
X-Received: by 10.28.11.82 with SMTP id 79mr4307278wml.33.1462972714565;
        Wed, 11 May 2016 06:18:34 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.18.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:18:33 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294251>

This is just a cleanup to avoid errors when compiling with -Wshadow and
to make it safer to later move global variables into a "state" struct.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 705a9c8..bb8bf7f 100644
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
2.8.2.490.g3dabe57
