From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 02/16] ref-filter: include reference to 'used_atom' within 'atom_value'
Date: Tue, 15 Mar 2016 22:17:02 +0530
Message-ID: <1458060436-1215-3-git-send-email-Karthik.188@gmail.com>
References: <1458060436-1215-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, jacob.keller@gmail.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 15 17:47:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afs89-0000hn-Ng
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 17:47:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965037AbcCOQrb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 12:47:31 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34342 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934545AbcCOQr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 12:47:28 -0400
Received: by mail-pf0-f172.google.com with SMTP id x3so35788867pfb.1
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 09:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2CIwQdpGqEk8iH9yKhWUgYxT/cxzyVzn+6Cv7gsWr7M=;
        b=w4fwHEt+EyO3AnXYx1VQkbfDwt9jUCpr25wAJn+t0oqD4VZq9EtNCCQZKOVpkZ2THG
         sqFcssU7x05uYP13tGL1jHoEyeMeIRRtthe95gnRRrTsfq+xCBfmxj4TOH8oDlShKwFL
         xoNwA4K6u2/nX9FnfG5/LRBsYoPkBWxijPLUHMSomYsd07JtPo+yVRWJCyj1k3RYQCqe
         0KRuENCHOyahcZEU862Lm1HU4rLCmD9uvnyq1VjvnnOnP5ye0+O5jIb/npCBb+kPcdMx
         73axlM+gNtcSDSNASTwCtaVCxEOS88XQEBncymuGkaUjS0fMvWyWc9pakF9/C2NgLH6/
         DATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2CIwQdpGqEk8iH9yKhWUgYxT/cxzyVzn+6Cv7gsWr7M=;
        b=eokXVa3dh6KAJCq4KPNU8gJNHKmoc0ZGKe9tOjI384M2mybKnA6Te1zz6Dv0F310o6
         4ljPYfo4fs75vPerJskOE8YCTu1X1C3mvBFBWdJZZ2eeI1vvCbc/YghfjXy0Vvf2jQao
         2Ma7mfaODOXKDgV6/vSjFR4mxn+6V9R7VL4k5U3HY42JKNYi4ud6jKiusiobn9rzKaVN
         CkUtH7hGGTkKLK+L0x0NRjYwxcW8iiXsvICkp4/cTzX7e+kaTNNpZpx6RORJbP7LtKy3
         bkNx7JXm+73E3qPDz8eSnwduzGsirW5XAObVT2wamgrPIigLPG9JrtD/OXggJbagsUi7
         Mp3Q==
X-Gm-Message-State: AD7BkJIee34ylanlWmB9bxTQ7y7V6clBqP4DKfanlWRT4jNptpnicgxBBWlBf2BYPqIJbg==
X-Received: by 10.66.250.199 with SMTP id ze7mr48033701pac.103.1458060447271;
        Tue, 15 Mar 2016 09:47:27 -0700 (PDT)
Received: from localhost.localdomain ([106.51.243.87])
        by smtp.gmail.com with ESMTPSA id i1sm40874361pfj.17.2016.03.15.09.47.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Mar 2016 09:47:26 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1458060436-1215-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288864>

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
2.7.3
