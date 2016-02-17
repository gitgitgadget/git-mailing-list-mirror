From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v6 06/11] ref-filter: introduce parse_align_position()
Date: Wed, 17 Feb 2016 23:36:14 +0530
Message-ID: <1455732379-22479-7-git-send-email-Karthik.188@gmail.com>
References: <1455732379-22479-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 19:06:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aW6V4-0007ah-WA
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 19:06:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423633AbcBQSGN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 13:06:13 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33963 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423488AbcBQSFv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 13:05:51 -0500
Received: by mail-pf0-f171.google.com with SMTP id x65so15370206pfb.1
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 10:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+hPOhtgVcVmYbTWa/YlMmSKcItQmaSmcomx28VyzVfA=;
        b=rs+BcvPLTl250NLNkc9folvvj6dW4DQ6egNc1uGrQ/CWuHrJTyjuPTVuzPPlHl3wgT
         rxWHEdqfRYLRiKSUiPrF8BCGnMhM9xDwJf70hojvhHvdns/HpEQWT2F552CE5jEYRdox
         UtiUkmd9S2GllR+EZ9qLV27zvsmgL5HA7+KxBsAxHhJvqhYPpqvaOtEItWhCp8eDp1eM
         +yiQB3NwQ1vW5iSFV6+o/djy5xjJwKDeJedT9sF32j7uMx4FlY9fePqay0O+R2elgxWJ
         LngBHlPXZ+lEIpta94qvsByiWZJXJK0Y0LEd9LTR85xtR/gxtQgnZHMtQrHP54wgLNpt
         qjZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+hPOhtgVcVmYbTWa/YlMmSKcItQmaSmcomx28VyzVfA=;
        b=Xfm/GpBQjmIfhYCjFCAhkBmdArS7Pp+Y5OchXyaAiumBIzURowm+kGiac5ffML391n
         /gQEavN+oEuQ0G11Yw/XdIYcWt6GauEltYohmDj29z6HATzjcDEQh39QcChLkbVEOTy0
         rPLeRwm0ISIkURDXyW7p1W/llQlHRdgSbjMgk1mtDoKRs4s4OPt/zrWqlNlM0orFoUNA
         qfWXvsh7Nrg5VU7U0xcGLWabq9WOFIO7ceMhJW2B3qHU9Yo9mEelSrb3KjM1uBNZRtCb
         rle8NGCTSOSbet4XDn1j79VOKwv3mXMoImaOdk1jPMr7Oir4b7g6xq+Fh+OSezuOZ2M4
         HqmA==
X-Gm-Message-State: AG10YOTGeXIN1lOUa1Jri/DKtblYoPEWqLseTDDJtfLwOaSFJ5MkFVY+7WgY1wi6NSzRyQ==
X-Received: by 10.98.31.221 with SMTP id l90mr4036525pfj.92.1455732351518;
        Wed, 17 Feb 2016 10:05:51 -0800 (PST)
Received: from ashley.localdomain ([106.51.133.38])
        by smtp.gmail.com with ESMTPSA id cf6sm4105793pad.41.2016.02.17.10.05.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Feb 2016 10:05:50 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.1
In-Reply-To: <1455732379-22479-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286527>

>From populate_value() extract parse_align_position() which given a
string would give us the alignment position. This is a preparatory
patch as to introduce prefixes for the %(align) atom and avoid
redundancy in the code.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index c90d2f4..e8b076d 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -44,6 +44,17 @@ static void color_atom_parser(struct used_atom *atom, const char *color_value)
 		die(_("unrecognized color: %%(color:%s)"), color_value);
 }
 
+static align_type parse_align_position(const char *s)
+{
+	if (!strcmp(s, "right"))
+		return ALIGN_RIGHT;
+	else if (!strcmp(s, "middle"))
+		return ALIGN_MIDDLE;
+	else if (!strcmp(s, "left"))
+		return ALIGN_LEFT;
+	return -1;
+}
+
 static struct {
 	const char *name;
 	cmp_type cmp_type;
@@ -912,14 +923,12 @@ static void populate_value(struct ref_array_item *ref)
 			string_list_split(&params, valp, ',', -1);
 			for (i = 0; i < params.nr; i++) {
 				const char *s = params.items[i].string;
+				int position;
+
 				if (!strtoul_ui(s, 10, (unsigned int *)&width))
 					;
-				else if (!strcmp(s, "left"))
-					align->position = ALIGN_LEFT;
-				else if (!strcmp(s, "right"))
-					align->position = ALIGN_RIGHT;
-				else if (!strcmp(s, "middle"))
-					align->position = ALIGN_MIDDLE;
+				else if ((position = parse_align_position(s)) >= 0)
+					align->position = position;
 				else
 					die(_("improper format entered align:%s"), s);
 			}
-- 
2.7.1
