From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 02/11] ref-filter: use strbuf_split_str_omit_term()
Date: Wed, 16 Dec 2015 20:59:53 +0530
Message-ID: <1450279802-29414-3-git-send-email-Karthik.188@gmail.com>
References: <1450279802-29414-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 16 16:29:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9E1a-0001Nn-MZ
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 16:29:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934065AbbLPP3q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 10:29:46 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36036 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933118AbbLPP3p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 10:29:45 -0500
Received: by mail-pa0-f54.google.com with SMTP id q3so5235198pav.3
        for <git@vger.kernel.org>; Wed, 16 Dec 2015 07:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E+mmMK56IWsGDNJdSViydhKCZCqEkG7HrAriXtXhwdI=;
        b=K9Fh2Ep+3/VrPaSV7Ilun6HijiazwbplOcxbL9NFJ0t5OxbWE9fyfdtZDv6iAPPh24
         /qXyXTrWz/HrUDHecN/h1c5PO/vNwZSG90TQ76mjugR2oPEMAiuF9DTJI1HMc8zFteew
         D4ZCOHmCxo6mJ9WQei5dCI5GoErv6jVUZ7IscpB2stlONvADnK7Ih6h6op8FW+uIPSu0
         CtQCU60g/dfKRmAd2RxRvQKsUfo/o3AGReI6J4SZqCC6kP3N64Q2FP0bcGHPZ16xESh/
         rdnOwtc4sq5lY8VKenqhlg1KZkwZxXefjPop1NLaLVtliGKRhThGgm6WN2I3WH7Pior/
         +qlQ==
X-Received: by 10.66.161.133 with SMTP id xs5mr3681507pab.70.1450279785099;
        Wed, 16 Dec 2015 07:29:45 -0800 (PST)
Received: from ashley.localdomain ([106.51.233.145])
        by smtp.gmail.com with ESMTPSA id x12sm5620612pfi.95.2015.12.16.07.29.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Dec 2015 07:29:44 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1450279802-29414-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282566>

Use the newly introduced strbuf_split_str_omit_term() rather than
using strbuf_split_str() and manually removing the ',' terminator.

Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index e205dd2..6263710 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -869,18 +869,11 @@ static void populate_value(struct ref_array_item *ref)
 			if (!valp)
 				die(_("expected format: %%(align:<width>,<position>)"));
 
-			/*
-			 * TODO: Implement a function similar to strbuf_split_str()
-			 * which would omit the separator from the end of each value.
-			 */
-			s = to_free = strbuf_split_str(valp, ',', 0);
+			s = to_free = strbuf_split_str_omit_term(valp, ',', 0);
 
 			align->position = ALIGN_LEFT;
 
 			while (*s) {
-				/*  Strip trailing comma */
-				if (s[1])
-					strbuf_setlen(s[0], s[0]->len - 1);
 				if (!strtoul_ui(s[0]->buf, 10, (unsigned int *)&width))
 					;
 				else if (!strcmp(s[0]->buf, "left"))
-- 
2.6.4
