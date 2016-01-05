From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 02/15] ref-filter: use strbuf_split_str_omit_term()
Date: Tue,  5 Jan 2016 13:33:01 +0530
Message-ID: <1451980994-26865-3-git-send-email-Karthik.188@gmail.com>
References: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 05 09:02:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGMZx-0007lQ-SH
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jan 2016 09:02:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840AbcAEICu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2016 03:02:50 -0500
Received: from mail-pf0-f173.google.com ([209.85.192.173]:35149 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751579AbcAEICs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2016 03:02:48 -0500
Received: by mail-pf0-f173.google.com with SMTP id 78so218685278pfw.2
        for <git@vger.kernel.org>; Tue, 05 Jan 2016 00:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vHmkCWFCQg7M+KpHcm4sWZZ+1xiN68B3UK+G5EDxh9g=;
        b=CTJ/clg4IylqfaGXOTLYs/6VRHsE76k+FwFp6cvs8KxqKUKiG2haFqh8mDtO0SpHF+
         NJIm5OgNkmMkuknxEL+N7GCfdsX/YApSpykg8eDZB3tKTsBUS78E5WydIyQY0rdwX8Lb
         d8uKB9UpQMk0ni9bKJ8u2ypYDEzL1GJCPfK+dYvMyri8RK8goFkcRPpzZ4riU5xwyca2
         cTnP7rTjVbkfAqqgiHDrmPp0Gs76qqr6a1weWuLk2Em0Hblq/mbH9x96k/gPMRFLoEVK
         vnMSar0t8eq9/YGg5CZYAOUQ1pfY2+3c5xYB1+9lbnKHWjwrA29OzdQharFt+sg0cYCS
         0AnA==
X-Received: by 10.98.13.86 with SMTP id v83mr114423554pfi.127.1451980968206;
        Tue, 05 Jan 2016 00:02:48 -0800 (PST)
Received: from ashley.localdomain ([106.51.242.38])
        by smtp.gmail.com with ESMTPSA id q190sm125814275pfq.59.2016.01.05.00.02.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Jan 2016 00:02:47 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283351>

Use the newly introduced strbuf_split_str_omit_term() rather than
using strbuf_split_str() and manually removing the ',' terminator.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
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
