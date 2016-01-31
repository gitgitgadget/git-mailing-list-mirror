From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 02/12] ref-filter: use strbuf_split_str_omit_term()
Date: Sun, 31 Jan 2016 23:12:46 +0530
Message-ID: <1454262176-6594-3-git-send-email-Karthik.188@gmail.com>
References: <1454262176-6594-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 31 18:43:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPw24-0000aW-Mt
	for gcvg-git-2@plane.gmane.org; Sun, 31 Jan 2016 18:43:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932646AbcAaRm5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2016 12:42:57 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36338 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932131AbcAaRmY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2016 12:42:24 -0500
Received: by mail-pf0-f193.google.com with SMTP id n128so6395237pfn.3
        for <git@vger.kernel.org>; Sun, 31 Jan 2016 09:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k1zifAhRfSB6YAmA2Dos1WTje4qXSt/bHfPitiND8Ws=;
        b=WjnyGWUCzeBa8bncgVAbyzqBkiAGzIULkUcV0z2k9ArWakl7yOGqDqEUwfHZgLajRI
         6XX26pzwt8YaD16uv4E8jOjuEFl/6MCQlCo9AqjEPJmgIuYwHIIt4XRrnJreNy1DcHmW
         KGBOxlt82hklWTBPtZyH84KcWjzU6kDHd8IZ3byNMSgVasB2Q5qCJK4ofBZ44/o2E9Av
         wyvjRgYuJuIqCGBB2ilT8RBdpV53gb89npfdEjgXE9luT7e8xnfZNeHeKtkVv2LTLQbB
         7+03yg+taFf0a4JXDvFPM7N++oYV1UflIhiFaP048uE+3qLPSoto/zhwzl2b+unjcMyA
         BX0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k1zifAhRfSB6YAmA2Dos1WTje4qXSt/bHfPitiND8Ws=;
        b=MkJ+VhYln8Hz3ZPbo6NC03btdI1ozjeh5CXUav8I1vQsjYrPU8XJd8gOKW9Euue0Y2
         8EqkrCTZXWwgzo2u4n9n1Hyg5KMjPyyeGTTeca7FPR7xyPal4J3u5S9HN1bGMZ8mJ9/D
         vTd9HUwR8frUzprjJwGQOXIapwOZQM2/Fm4j3gfB7B2YsmT/aH9RqqZagMUdDVNmWFoz
         J2dzmAebPLVLe3FXmin6bWJY+OIvh57TdrrmFP1cIGiCz3+QYqevOuO0Z3NQQtsOHmSr
         9cYvCc9Q6N1qt/eBycwWzI45EgLBnfW3nOQCpJI6Oho0tCJG7kISMT+7+Krug88tOF7x
         ScHQ==
X-Gm-Message-State: AG10YOT5kgOWjJFXd5r+eW9Zn566cgKndcc6qFY3fYVDY1kjAGLpz/7krNTN9tCB7nvx9A==
X-Received: by 10.98.13.68 with SMTP id v65mr31305115pfi.54.1454262143869;
        Sun, 31 Jan 2016 09:42:23 -0800 (PST)
Received: from ashley.localdomain ([106.51.132.212])
        by smtp.gmail.com with ESMTPSA id v26sm37274012pfi.56.2016.01.31.09.42.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 31 Jan 2016 09:42:23 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1454262176-6594-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285166>

Use the newly introduced strbuf_split_str_omit_term() rather than
using strbuf_split_str() and manually removing the ',' terminator.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index f097176..38f38d4 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -892,18 +892,11 @@ static void populate_value(struct ref_array_item *ref)
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
2.7.0
