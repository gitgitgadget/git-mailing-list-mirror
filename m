From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5b 02/17] ref-filter: include reference to 'used_atom' within 'atom_value'
Date: Mon, 25 Apr 2016 20:47:43 +0530
Message-ID: <1461597478-31855-2-git-send-email-Karthik.188@gmail.com>
References: <1461581558-32348-1-git-send-email-Karthik.188@gmail.com>
Cc: jacob.keller@gmail.com, gitster@pobox.com, peff@peff.net,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 25 17:19:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auiIU-0006Nw-Bz
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 17:19:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932753AbcDYPTE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 11:19:04 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34440 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754766AbcDYPSH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 11:18:07 -0400
Received: by mail-pf0-f177.google.com with SMTP id y69so47995807pfb.1
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 08:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+P0Qd8U7gnT4OhaITcOf9ICcIg1I3eOVT9Gybg1LZMw=;
        b=mrWodT8CfI/pTN/4bxkqkBa57JDcVoLfhkEPlO997kySp7QJav0T3f8IuAS2I590Ck
         b6MuB7qkeTL31q1a+IZio/yDqUpvfUWbAIKSiUpUptWQz4Y0HZbhNTc1mz22rbMjRW0b
         dZTwBz5KUK7zFP/M2D7XGkao7kcckY/wzlT2lvhQ7LMrYGBawUv7/wyLERvIO4PqQpV6
         b/pGDw3DkoUjvhsHRu1k9gNL0bcgu3ElgL4U+y4zEUy5bHuunTJr9iR+jp91zFpYefGL
         CXgGpvEvhpIIIdHthGtNkWN6fe6GuZ6AX025kP9F8tH5xC5uovnPq4/VXbRlzZi59Oy+
         X97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+P0Qd8U7gnT4OhaITcOf9ICcIg1I3eOVT9Gybg1LZMw=;
        b=YU0g/OkUAlIcclHyAgQCViKxKLthNlFYsDWtUBLJwbIvyXAAeDc//yRmVA6YU5ijm6
         K31nRDp+SOVTx3crftY0wKKmIKwxV0odj8yc7zWpkTaq6WizRsxmoTJF0koy9/JeE/Ph
         JORvTwEAWqfdT4GbZC2ZEP7asxl32WY1eRe2OZfTu5KtY7Dgx1LIusYX8DIRcAGOtoLe
         06I6inPxxPwMGwT9SpW8JlbFmQ6BLeJOllCX03ZlcD/e0TduSlNb4LZGczi5xgCsgr+0
         OxBKJTz+Dr0uO9kCEZdlYA05VlBHLP2+xWN/emv1BxDufvQAnVWq9AxrytNyTDzBNwwu
         PcfA==
X-Gm-Message-State: AOPr4FXlyp67RxiYpcXfRSqZarOeZ9mua46ZuyucCfa2y4i9+vUfxanfGFI9JcvT0h2bdw==
X-Received: by 10.98.7.24 with SMTP id b24mr48611676pfd.125.1461597487092;
        Mon, 25 Apr 2016 08:18:07 -0700 (PDT)
Received: from ashley.localdomain ([106.51.234.108])
        by smtp.gmail.com with ESMTPSA id ut1sm30812527pac.46.2016.04.25.08.18.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Apr 2016 08:18:06 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1461581558-32348-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292506>

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
