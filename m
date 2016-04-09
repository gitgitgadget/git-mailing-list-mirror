From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 02/16] ref-filter: include reference to 'used_atom' within 'atom_value'
Date: Sun, 10 Apr 2016 00:15:01 +0530
Message-ID: <1460227515-28437-3-git-send-email-Karthik.188@gmail.com>
References: <1460227515-28437-1-git-send-email-Karthik.188@gmail.com>
Cc: jacob.keller@gmail.com, gitster@pobox.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 09 20:45:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoxsu-0003PV-8F
	for gcvg-git-2@plane.gmane.org; Sat, 09 Apr 2016 20:45:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758852AbcDISpZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2016 14:45:25 -0400
Received: from mail-ig0-f194.google.com ([209.85.213.194]:34382 "EHLO
	mail-ig0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758040AbcDISpY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2016 14:45:24 -0400
Received: by mail-ig0-f194.google.com with SMTP id qu10so6552626igc.1
        for <git@vger.kernel.org>; Sat, 09 Apr 2016 11:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+P0Qd8U7gnT4OhaITcOf9ICcIg1I3eOVT9Gybg1LZMw=;
        b=uTxSz782Ey8dD8kf5leGAlCnEQVOTKpezjGNufpdR0vKoaCPIXW+4qlS3h9B3wCJ+R
         oXFmNrvfdLltjyO4299Jk25qIoRA+DESqwOci0ziXq9UF80DxZhYYlR6kxyV2hawBTtf
         NQQY49LBjGx8Pk40kXdZL5vQOYbZKFEJdUt/UgGehDSTLgwHTo3VxVKK6DfyL2FnKTCN
         mCb1o2KPlkh7DKoPakpaJ5tldZOdPKdwYWuV1RFDJ3V0Tk2/vR3Bx27ARmSHLj40TPia
         pHdoOCipiQoihH7zMVdh0n9isOHdxMp/9YwtLZw2UrdodPT6l4drRDzPufJqZGS/Zr16
         vp+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+P0Qd8U7gnT4OhaITcOf9ICcIg1I3eOVT9Gybg1LZMw=;
        b=DTO7c+enW0SkwqyITsbCxg3PqUacJDTSOb+2hvTLiEqMKgt6CFgJfFNkW1EzSC0svc
         /zvi4G6YRxVIpdT9yQQQVdo9CWZixh5ZKQYaaaQpfxa9fYFLL2usRzJRaKhzasbSZXGN
         XZ0qGiE8dtBgkdGBqJTR+HH8Krx8R9e+cPkfYCrwQBL1Izrtbc1hUzC9DAH9DQniOR0f
         Vz7jp1Y77/KSqWXIfOrRm9i/FS2ouME8DIho+HoA5REe9suYNwDtSPHXg7oKOXdcth8d
         Dz7vXa8/SzYOaxTiP//wrRRYUwSUOn+wD9nSa+1gwIV8wSTDSQbCvXrC3NjoWk7VLk0O
         RbVQ==
X-Gm-Message-State: AD7BkJIiKOjdSzCO2tWnxpU3fp7uGJ95zuGtPpbjnPcJUk6Vgu8p1RNnSGQthuQpbTbVIw==
X-Received: by 10.50.126.101 with SMTP id mx5mr10389163igb.49.1460227523593;
        Sat, 09 Apr 2016 11:45:23 -0700 (PDT)
Received: from localhost.localdomain ([106.51.241.12])
        by smtp.gmail.com with ESMTPSA id be7sm7132351igb.1.2016.04.09.11.45.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 09 Apr 2016 11:45:23 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1460227515-28437-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291108>

Ensure that each 'atom_value' has a reference to its corresponding
'used_atom'. This let's us use values within 'used_atom' in the
'handler' function.

Hence we can get the %(align) atom's parameters directly from the
'used_atom' therefore removing the necessity of passing %(align) atom's
parameters to 'atom_value'.

This also acts as a preparatory patch for the upcoming patch where we
introduce %(if:equals=) and %(if:notequals=).

Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 41e73f0..12e646c 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -230,11 +230,9 @@ struct ref_formatting_state {
 
 struct atom_value {
 	const char *s;
-	union {
-		struct align align;
-	} u;
 	void (*handler)(struct atom_value *atomv, struct ref_formatting_state *state);
 	unsigned long ul; /* used for sorting when not FIELD_STR */
+	struct used_atom *atom;
 };
 
 /*
@@ -370,7 +368,7 @@ static void align_atom_handler(struct atom_value *atomv, struct ref_formatting_s
 	push_stack_element(&state->stack);
 	new = state->stack;
 	new->at_end = end_align_handler;
-	new->at_end_data = &atomv->u.align;
+	new->at_end_data = &atomv->atom->u.align;
 }
 
 static void if_then_else_handler(struct ref_formatting_stack **stack)
@@ -1069,6 +1067,7 @@ static void populate_value(struct ref_array_item *ref)
 		struct branch *branch = NULL;
 
 		v->handler = append_atom;
+		v->atom = atom;
 
 		if (*name == '*') {
 			deref = 1;
@@ -1133,7 +1132,6 @@ static void populate_value(struct ref_array_item *ref)
 				v->s = " ";
 			continue;
 		} else if (starts_with(name, "align")) {
-			v->u.align = atom->u.align;
 			v->handler = align_atom_handler;
 			continue;
 		} else if (!strcmp(name, "end")) {
-- 
2.8.0
