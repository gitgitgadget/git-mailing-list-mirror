From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v6 01/11] ref-filter: use string_list_split over strbuf_split
Date: Wed, 17 Feb 2016 23:36:09 +0530
Message-ID: <1455732379-22479-2-git-send-email-Karthik.188@gmail.com>
References: <1455732379-22479-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Jeff King <peff@peff.net>,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 19:05:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aW6Ty-0006i0-PP
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 19:05:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423449AbcBQSFm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 13:05:42 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33850 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423145AbcBQSFk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 13:05:40 -0500
Received: by mail-pf0-f176.google.com with SMTP id x65so15367120pfb.1
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 10:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WYlB4/OD7lqBM81LigQDuxGYuubi7Xabn6rRiKX1I6A=;
        b=q8JW6/HT126KR2AdGDcwt8Mb/dAf5IUfxNqgI5xWNn7MqUKKtZbZGKwkjdVFluaIEN
         wcNfUzK9rhsXsaAzFOpacG7sb3ol6KHXH1L+9wFV8mfmh99Esx0uccSTnYaYraeRTQ4y
         +6uOJz4LB9Z9j/g58GlBoYxbezQVaET0w2EDZ2fXxQO0Yl+xmimaIit2WISalyBrboka
         mB7TZVbmUnJiKJmouODiTkcclC3FCgVZBVo73dlQcNRtuVs4f/yW/ll/vPLzTA0oUM+8
         bm19fO2T6aQr+sXrFupg/kGB4jL0q8qI8yqHjIeLGdOlhdCyyNnECb27js+GT5PKXZZ6
         aU5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WYlB4/OD7lqBM81LigQDuxGYuubi7Xabn6rRiKX1I6A=;
        b=SCw8r6lyIjiueOIgq0t+34ijSc8BAdyeB3NY3o7By8gxr7C+dSNZfx8nXZvkQ2HMOB
         gGIWB2PbEaCigiGbykMb4eOC2WjlLE8Y8uJ22o+qFessohB73FT/sm2ILJ4sqMiACzHw
         0psngtO9I/QqweHcBd4ZUwvStcHTS2Z5+qVW3zvWvl8v8+0VKbofluFBYo5QeGnyDiCY
         p0qySfCHBFdxryAmRkDomapspjjX/Fm6DdGzjZZkFDRec4Ss5k1XZTECBldLJL76U8kg
         hL1eGIiH4xODKNuDAdHYUOQOkaLD52WJIx24vqar9CDycHq71HPG2A1HLKU7EhijXLaK
         1QYw==
X-Gm-Message-State: AG10YOTOKmWTibSh+3kwynYZJLY8yCwUZSClu3kT3Or1aKOLy70LDyjpqAOGKdJ8FM51zQ==
X-Received: by 10.98.80.80 with SMTP id e77mr4002748pfb.126.1455732339630;
        Wed, 17 Feb 2016 10:05:39 -0800 (PST)
Received: from ashley.localdomain ([106.51.133.38])
        by smtp.gmail.com with ESMTPSA id cf6sm4105793pad.41.2016.02.17.10.05.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Feb 2016 10:05:38 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.1
In-Reply-To: <1455732379-22479-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286517>

From: Jeff King <peff@peff.net>

We don't do any post-processing on the resulting strbufs, so it is
simpler to just use string_list_split, which takes care of removing
the delimiter for us.

Written-by: Jeff King <peff@peff.net>
Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index f097176..19367ce 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -886,41 +886,34 @@ static void populate_value(struct ref_array_item *ref)
 			continue;
 		} else if (match_atom_name(name, "align", &valp)) {
 			struct align *align = &v->u.align;
-			struct strbuf **s, **to_free;
+			struct string_list params = STRING_LIST_INIT_DUP;
+			int i;
 			int width = -1;
 
 			if (!valp)
 				die(_("expected format: %%(align:<width>,<position>)"));
 
-			/*
-			 * TODO: Implement a function similar to strbuf_split_str()
-			 * which would omit the separator from the end of each value.
-			 */
-			s = to_free = strbuf_split_str(valp, ',', 0);
-
 			align->position = ALIGN_LEFT;
 
-			while (*s) {
-				/*  Strip trailing comma */
-				if (s[1])
-					strbuf_setlen(s[0], s[0]->len - 1);
-				if (!strtoul_ui(s[0]->buf, 10, (unsigned int *)&width))
+			string_list_split(&params, valp, ',', -1);
+			for (i = 0; i < params.nr; i++) {
+				const char *s = params.items[i].string;
+				if (!strtoul_ui(s, 10, (unsigned int *)&width))
 					;
-				else if (!strcmp(s[0]->buf, "left"))
+				else if (!strcmp(s, "left"))
 					align->position = ALIGN_LEFT;
-				else if (!strcmp(s[0]->buf, "right"))
+				else if (!strcmp(s, "right"))
 					align->position = ALIGN_RIGHT;
-				else if (!strcmp(s[0]->buf, "middle"))
+				else if (!strcmp(s, "middle"))
 					align->position = ALIGN_MIDDLE;
 				else
-					die(_("improper format entered align:%s"), s[0]->buf);
-				s++;
+					die(_("improper format entered align:%s"), s);
 			}
 
 			if (width < 0)
 				die(_("positive width expected with the %%(align) atom"));
 			align->width = width;
-			strbuf_list_free(to_free);
+			string_list_clear(&params, 0);
 			v->handler = align_atom_handler;
 			continue;
 		} else if (!strcmp(name, "end")) {
-- 
2.7.1
