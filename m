From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 01/16] ref-filter: include reference to 'used_atom' within 'atom_value'
Date: Sat, 23 Apr 2016 00:33:52 +0530
Message-ID: <1461351847-22903-2-git-send-email-Karthik.188@gmail.com>
References: <1461351847-22903-1-git-send-email-Karthik.188@gmail.com>
Cc: jacob.keller@gmail.com, gitster@pobox.com, peff@peff.net,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 21:04:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atgNf-0007zU-1T
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 21:04:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752379AbcDVTEZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 15:04:25 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34448 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309AbcDVTEW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 15:04:22 -0400
Received: by mail-pf0-f195.google.com with SMTP id 145so3073568pfz.1
        for <git@vger.kernel.org>; Fri, 22 Apr 2016 12:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+P0Qd8U7gnT4OhaITcOf9ICcIg1I3eOVT9Gybg1LZMw=;
        b=HonJ/x/zkdslODMenc85J4ZF9LfBpegbbC0de1+Hs/DYwXSXH5Yf6GiLU/Lunpbqj5
         5jH8oVPEHCICFA8TeZnFfvspImOyrmKkxJmZiUjqpZA8BC3gc27A25tH9y83EhlJRAyu
         oC/xjcofK00ptdE38mWtHyySniCodrGtkJQlDbKh8kh2Me4t3F/9WRnzzR5fzSuANWet
         ZTPJYpI7J1q73df5xJr9iEBH+0hKih8kN5g7NskgAzUT8CwOzrntNrNB0Hj2hEE5MH8y
         Ue8tzx3bzQ/CxDjMDike9N9Dgz+n5YEoc4ftxR2qU0C4fiTLpClgVA9AmBypIDvKcact
         W+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+P0Qd8U7gnT4OhaITcOf9ICcIg1I3eOVT9Gybg1LZMw=;
        b=HO+gK+88rpfz9evcHvr8NjUsGRRn6IzDDQYOTe2NMnJIUGpuNnbkfQmCjRktYBX25b
         aiMjRc7WuG7HoHQMJYIE0xFaz5zZWl6To31Ybizps6UEbemSDgcJGC4tMUyKnw6aIB1v
         3rkfLLxAyU8llqBps52XaYnIVOYa4pypMMpZetr9oq0+CzLxwzCaaTOrIrE4+dglpJkY
         2+NteC022VyRKzyNQU8ht3E+JNWo072cEvsVaatZwTcFuh2L9ZNNgehP0DimYYw3F1op
         +ZWIVSY5/Teb9Ta8USOw1o9dJRdIRj6J5t1injOr18/GDr4FbAI0s3851E3YR3qqhKlb
         g+qQ==
X-Gm-Message-State: AOPr4FV4WdEJ8R1aWBiXqP7jjJvq/iInjmSzCsRU+Acwi+u0+tiG0CTyh3yPCuIHoNcpcQ==
X-Received: by 10.98.69.132 with SMTP id n4mr16539545pfi.53.1461351862005;
        Fri, 22 Apr 2016 12:04:22 -0700 (PDT)
Received: from ashley.localdomain ([106.216.186.206])
        by smtp.gmail.com with ESMTPSA id t1sm11266470paa.17.2016.04.22.12.04.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Apr 2016 12:04:21 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1461351847-22903-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292246>

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
