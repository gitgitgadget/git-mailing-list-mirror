From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 04/49] builtin/apply: avoid local variable shadowing 'len' parameter
Date: Tue, 24 May 2016 10:10:41 +0200
Message-ID: <20160524081126.16973-5-chriscool@tuxfamily.org>
References: <20160524081126.16973-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 10:16:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b57Vp-0002IQ-JO
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 10:16:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754757AbcEXIQT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 04:16:19 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36855 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754652AbcEXILw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 04:11:52 -0400
Received: by mail-wm0-f66.google.com with SMTP id q62so3634793wmg.3
        for <git@vger.kernel.org>; Tue, 24 May 2016 01:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BrDOUb7mYbmRNOB498djK2MnZhQG5m879XFT0q+wuGA=;
        b=y0X+ZPJkGNl0OlBOvE5bfwg3hX+LOKUSTevjp54QRRozpN2lauq8ler1Nmx5LvEd9l
         A1e/dEQpup8g4L0p9P9El77iU45YQWwXBIF3JKaUU6rimsarAe4NH6bchNA2ElPagkpG
         9DNjCw0Fh/Li3eG43PdvY65YTd/JsCST/Kid3JAq9/I01dGOPmu5MxatJLKasHGL/AON
         8ZcM/sqK4wmw64ixPmgCCqWSNJzSRbDEAbHHmuAY7etxImgf4Mgs5DUpyQQkYf2FkbbT
         1qHB5fiCGgqvtlQLKioLSYHP4y9hH/8nc07HePAZaL3VHPWq4cpG8Ygor9nqpRLdTpS5
         NDPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BrDOUb7mYbmRNOB498djK2MnZhQG5m879XFT0q+wuGA=;
        b=RnJUx928J3pIAyz8P4mjk2llxxPhSHmv7fBvOnmZQluQbdOiliAjwbLqDsyrhyO+s+
         stH1QhI0+afqt2KuqJA7ROWC1xUrC7sHomPopVvUoBjFNJxpZViV+s9+/6l6nGNFf8br
         Kdyu/yYE3mnxIOeaJtMxwa9upAtc9z/NQcyvUnonSGjtL/ZRO2JkTIT+yhuIV/XwN0x4
         vBjaqgupY1aBumuRtAoGilAoatK5pDeI1vWyuDpBB2n1jWXGUgiHRZVv4JNk/7bB12W+
         piafsXdnVxwOsFx8SV6ycJRbx41qPnWaNgDxX9ln7sSPvWabxilEimUPI0SJNUWiokS5
         BzfQ==
X-Gm-Message-State: ALyK8tI9Gxwbyj6CKuVBbkfiHap/xfbMpYU8e/3A6QJjqjP6WcH7G6RBWK+G4wmqVZsBqQ==
X-Received: by 10.194.186.179 with SMTP id fl19mr3146141wjc.2.1464077511580;
        Tue, 24 May 2016 01:11:51 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 131sm2258044wmu.17.2016.05.24.01.11.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 01:11:50 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.3.443.gaeee61e
In-Reply-To: <20160524081126.16973-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295474>

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
2.8.3.443.gaeee61e
