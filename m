From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 02/15] ref-filter: implement %(if:equals=<string>) and %(if:notequals=<string>)
Date: Sun,  6 Mar 2016 17:34:49 +0530
Message-ID: <1457265902-7949-3-git-send-email-Karthik.188@gmail.com>
References: <1457265902-7949-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 06 13:05:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acXR5-0001sw-Rv
	for gcvg-git-2@plane.gmane.org; Sun, 06 Mar 2016 13:05:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbcCFMFS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2016 07:05:18 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35754 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298AbcCFMFN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2016 07:05:13 -0500
Received: by mail-pf0-f171.google.com with SMTP id x188so39148828pfb.2
        for <git@vger.kernel.org>; Sun, 06 Mar 2016 04:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rL6SCsuZzEpMeW9NiAyyCt+uktSjXUMDnrl/afJ+nTY=;
        b=kz3jz/M1xbTOsAkff7Vwf7/Z7QPSYU0SrjIbOQ3nu7m1t6y4DtkYNJc0Jez+kyylc1
         nsGCTY4W+/IZuubGsTEjr3XSLLVVHNZb2X7EstAtAlygv8OXtPnb8d3nXSJWG0sH3PFN
         /5v1lkcq7JKKdSVWKVhfiis32/RySMm46il8omvMtHtCpziVdLhT7p5OkQEskDKOz/x1
         buOKNHD3Kn0TSM7MMmv2hWB+1VwjuuZuConm2EY/dDHs9DBtBJ2gqDdqm5k5SULrOxGw
         mFYCxmKFna1QSeMxQT0TMN/JnXe+7/qqFGGP9cV9tbk2p4ohAkSmRJqG+zwgMfEZZ+Q5
         xQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rL6SCsuZzEpMeW9NiAyyCt+uktSjXUMDnrl/afJ+nTY=;
        b=M2QFhcJs2iYEhDxMZy+KPAnHBLMj/EZDsm6957VRKv6lHefhKjygP26rK0YtjiJJiv
         HUrhNYt7rA8XLFONNu0swvSY1ogHSWP9uKArioC6CNIAT+3X8AtRMAAr4d5B/y25L+TL
         S9zzYl+XHY2/cGvXXhbw45WvTP2Z2d8oEK+B2jxLjBbSraljcZp08gb8hmbXxqQdbLL3
         O3YoKOF3QGTc+xS8aEMyNjMhdBcy3nyMktG58A20+QEHlypMF7OEFocW/q6LzSlNkxee
         o2xuSd47MTqN/KahcdhqAfQQiBE4N3miUrQBPiW949ZH+Pv+wi1uvmETtwZjDnj3nlj+
         ItAw==
X-Gm-Message-State: AD7BkJKk990PImRqdcdepgijBo14AimIgRIXTmJylSu9HmpHJWefhdCZDHNXrSsK4avHlw==
X-Received: by 10.98.80.22 with SMTP id e22mr25441210pfb.15.1457265912730;
        Sun, 06 Mar 2016 04:05:12 -0800 (PST)
Received: from localhost.localdomain ([106.51.240.143])
        by smtp.gmail.com with ESMTPSA id n66sm17536850pfj.39.2016.03.06.04.05.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 06 Mar 2016 04:05:12 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.2
In-Reply-To: <1457265902-7949-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288344>

Implement %(if:equals=<string>) wherein the if condition is only
satisfied if the value obtained between the %(if:...) and %(then) atom
is the same as the given '<string>'.

Similarly, implement (if:notequals=<string>) wherein the if condition
is only satisfied if the value obtained between the %(if:...) and
%(then) atom is differnt from the given '<string>'.

Add tests and Documentation for the same.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt |  3 +++
 ref-filter.c                       | 29 +++++++++++++++++++++++++----
 t/t6302-for-each-ref-filter.sh     | 18 ++++++++++++++++++
 3 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index d048561..e1b1a66 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -152,6 +152,9 @@ if::
 	evaluating the string before %(then), this is useful when we
 	use the %(HEAD) atom which prints either "*" or " " and we
 	want to apply the 'if' condition only on the 'HEAD' ref.
+	Append ":equals=<string>" or ":notequals=<string>" to compare
+	the value between the %(if:...) and %(then) atoms with the
+	given string.
 
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
diff --git a/ref-filter.c b/ref-filter.c
index 41e73f0..440e270 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -22,6 +22,8 @@ struct align {
 };
 
 struct if_then_else {
+	const char *if_equals,
+		*not_equals;
 	unsigned int then_atom_seen : 1,
 		else_atom_seen : 1,
 		condition_satisfied : 1;
@@ -411,6 +413,14 @@ static void if_atom_handler(struct atom_value *atomv, struct ref_formatting_stat
 {
 	struct ref_formatting_stack *new;
 	struct if_then_else *if_then_else = xcalloc(sizeof(struct if_then_else), 1);
+	const char *valp;
+
+	if (skip_prefix(atomv->s, "equals=", &valp))
+		if_then_else->if_equals = valp;
+	else if (skip_prefix(atomv->s, "notequals=", &valp))
+		if_then_else->not_equals = valp;
+	else if (atomv->s[0])
+		die(_("format: unknown format if:%s"), atomv->s);
 
 	push_stack_element(&state->stack);
 	new = state->stack;
@@ -443,10 +453,17 @@ static void then_atom_handler(struct atom_value *atomv, struct ref_formatting_st
 		die(_("format: %%(then) atom used after %%(else)"));
 	if_then_else->then_atom_seen = 1;
 	/*
-	 * If there exists non-empty string between the 'if' and
-	 * 'then' atom then the 'if' condition is satisfied.
+	 * If the 'equals' or 'notequals' attribute is used then
+	 * perform the required comparison. If not, only non-empty
+	 * strings satisfy the 'if' condition.
 	 */
-	if (cur->output.len && !is_empty(cur->output.buf))
+	if (if_then_else->if_equals) {
+		if (!strcmp(if_then_else->if_equals, cur->output.buf))
+			if_then_else->condition_satisfied = 1;
+	} else 	if (if_then_else->not_equals) {
+		if (strcmp(if_then_else->not_equals, cur->output.buf))
+			if_then_else->condition_satisfied = 1;
+	} else if (cur->output.len && !is_empty(cur->output.buf))
 		if_then_else->condition_satisfied = 1;
 	strbuf_reset(&cur->output);
 }
@@ -1139,7 +1156,11 @@ static void populate_value(struct ref_array_item *ref)
 		} else if (!strcmp(name, "end")) {
 			v->handler = end_atom_handler;
 			continue;
-		} else if (!strcmp(name, "if")) {
+		} else if (starts_with(name, "if")) {
+			const char *s;
+
+			if (skip_prefix(name, "if:", &s))
+				v->s = xstrdup(s);
 			v->handler = if_atom_handler;
 			continue;
 		} else if (!strcmp(name, "then")) {
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 954b12a..83716e4 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -367,4 +367,22 @@ test_expect_success 'ignore spaces in %(if) atom usage' '
 	test_cmp expect actual
 '
 
+test_expect_success 'check %(if:equals=<string>)' '
+	git for-each-ref --format="%(if:equals=master)%(refname:short)%(then)Found master%(else)Not master%(end)" refs/heads/ >actual &&
+	cat >expect <<-\EOF &&
+	Found master
+	Not master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'check %(if:notequals=<string>)' '
+	git for-each-ref --format="%(if:notequals=master)%(refname:short)%(then)Not master%(else)Found master%(end)" refs/heads/ >actual &&
+	cat >expect <<-\EOF &&
+	Found master
+	Not master
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
2.7.2
