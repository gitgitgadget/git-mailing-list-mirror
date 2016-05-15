From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v6 02/17] ref-filter: include reference to 'used_atom' within 'atom_value'
Date: Sun, 15 May 2016 16:15:18 +0530
Message-ID: <1463309133-14503-3-git-send-email-Karthik.188@gmail.com>
References: <1463309133-14503-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, peff@peff.net,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 12:45:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1tYS-0003Ln-Uv
	for gcvg-git-2@plane.gmane.org; Sun, 15 May 2016 12:45:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754139AbcEOKpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2016 06:45:43 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:33555 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751953AbcEOKpl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 06:45:41 -0400
Received: by mail-pa0-f68.google.com with SMTP id gh9so12080659pac.0
        for <git@vger.kernel.org>; Sun, 15 May 2016 03:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2t/YJLE9sGP56wG58cl2aU4NlhkXKt6N7CHFJAGNQDM=;
        b=JnhPy+XKUWk57Y3PW/sSvab5Rbd57QgjDjEmfi73IO/JQqrg2C+B69OT44B6pEbD/y
         uXPnD1fO8HqxIbie/FSrlF6OOB9x9MaZxfjnHQlIYfw5DMQbeWCmuJuT8+0vRgAO8Xld
         Pl4+Yhxn8WM8tdbPy8TtkZuSlgrQwg329rbPMbU1uMTuyL+S43cy2ARStvGt9cRVe/0V
         Q8iTLlursY3CHKrlkns+78JBOFmFGhYRpTHyDfGM+g6//kYPBSbBhGjK7DJgCrgD3xfT
         uzUFgDI8gci/AcfT19omEBU5TKQpef7H+5xf7IjLyFgCTA/NNOgltHPJkHQwJ8EQjfY3
         HifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2t/YJLE9sGP56wG58cl2aU4NlhkXKt6N7CHFJAGNQDM=;
        b=hdbnS78WQAN4BINFDHPQERxdACCo1FodzUbuQpMDL7xsP0WkY9TO/1rXIhEdULdoL/
         rBb05Lcu592DVNJzAF+Eg4kYxhtgMdXMH5GBgQwxcdGYDH/Onb69zS1T6GDvLVYb4LDY
         j27mboRMquHKfsF4xJAS2zuVqwOZXyKtA5glMXoyCc+pO3iJRzpAOmXHSbABHt34Eoev
         qvhEas4shtXnaoyZgqm3B37s0hSPHFmMlyK3RddAZWPSCfFgFQ9/6on28N1nwnUB45P5
         MvVSs22Vs/lofv+m/mVxr1pwDJ/4ggg1Ymx/WKvIzx761T21AhG3+uq0scM/hyklWlMY
         Fatg==
X-Gm-Message-State: AOPr4FXchHWgOfxDMXSQ8oaula1GfeHyz7h2yW5gDBkMTPNQAkTAFS/1EqvC923s5INg6Q==
X-Received: by 10.66.246.165 with SMTP id xx5mr36770461pac.87.1463309140577;
        Sun, 15 May 2016 03:45:40 -0700 (PDT)
Received: from ashley.localdomain ([106.51.133.65])
        by smtp.gmail.com with ESMTPSA id 71sm39866747pfy.32.2016.05.15.03.45.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 15 May 2016 03:45:39 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.8.2
In-Reply-To: <1463309133-14503-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294649>

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
2.8.2
