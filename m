From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 02/16] ref-filter: include reference to 'used_atom' within 'atom_value'
Date: Wed, 30 Mar 2016 15:09:46 +0530
Message-ID: <1459330800-12525-3-git-send-email-Karthik.188@gmail.com>
References: <1459330800-12525-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, jacob.keller@gmail.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 30 11:40:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alCc5-0001fQ-8m
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 11:40:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752028AbcC3JkS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 05:40:18 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35809 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751960AbcC3JkO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 05:40:14 -0400
Received: by mail-pa0-f46.google.com with SMTP id td3so36012618pab.2
        for <git@vger.kernel.org>; Wed, 30 Mar 2016 02:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b5P0I1m4W0AMNm1dvp1A0u7veebAR/QI5xqCRwWi26A=;
        b=pS3zG7yWAtRNUzsTp7V0sNZdaVP8DQVGl116C6duOk1b4X54H+9ZWdV9Z/fxST/10H
         1ErvM8DYhvj9rbl6jRu11IJ2V+VU34ZK9EGLhjM7EkiC23S7bH+bQINdqBVpHWEsnnh7
         JtYz2CLUDIszGUIVAARqQ0d6a9IR54Z9tCnW1ZAaxeWVrX1EevazhrkkTIN//hpVagpc
         +4SWx8a1TiDF57ozppcIcNXQby3g5M91knOlxdkfbTucFysEGeRi9lZZK5mPPHIvdD6a
         fLTD+ohUe2tIO7vZhmTSiJBeBNko3tsvIm6znLHXHxkC4cpHBAerWrUZ9NmjyJm+SXAz
         fE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b5P0I1m4W0AMNm1dvp1A0u7veebAR/QI5xqCRwWi26A=;
        b=lDoKlghsyvaNr9AqNHoiRQvkVDWfSLHHO6G4OnsLY+Q4czfWMNzSpB6wHETIDC4i53
         4/JeMPfQdw59VX4YDudHF/IvLWtaBODKkXC9AJCRNiXWbJe8+u3eH348OWAY7dIOD8si
         tsB7n+At4rQbNwdjmCkri/fBs9uALbKJqtOAy0/ylGmmx4QdsptrxvxbkJixjDCPvTyM
         RwH7a8Si7PnnXDa1iptP9C7B85By8bNbEiRqWDiewY9TxBdT2icb0oq9R+zZVwfja+cs
         zy/f/zUlGzh3A8V08ukuD7vpUn+kq98TWiu1S64gy+4xSba7rRQv/s90jqDlDqBZn2pH
         pbNA==
X-Gm-Message-State: AD7BkJJHyBhIqP7p17qv6KIwlV0HdzokwmtAc9kiTKKlwUT+dyN+cSvpal5+g7EMjUt3MQ==
X-Received: by 10.66.254.168 with SMTP id aj8mr11522117pad.18.1459330813799;
        Wed, 30 Mar 2016 02:40:13 -0700 (PDT)
Received: from localhost.localdomain ([106.51.243.45])
        by smtp.gmail.com with ESMTPSA id r65sm4402606pfa.27.2016.03.30.02.40.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Mar 2016 02:40:13 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1459330800-12525-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290283>

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
2.7.4
