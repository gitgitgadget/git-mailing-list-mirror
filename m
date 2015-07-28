From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v6 02/10] ref-filter: add option to pad atoms to the right
Date: Tue, 28 Jul 2015 12:03:23 +0530
Message-ID: <1438065211-3777-2-git-send-email-Karthik.188@gmail.com>
References: <CAOLa=ZR6_2NBB4v0Ynq391=8Jk2RZON6R0YG=HKUNwKx249b7Q@mail.gmail.com>
 <1438065211-3777-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 28 08:33:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJySJ-0005cC-8z
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 08:33:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754143AbbG1Gde (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 02:33:34 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:35830 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751909AbbG1Gdd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 02:33:33 -0400
Received: by pdrg1 with SMTP id g1so65305372pdr.2
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 23:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XfhK4kVoTQlrvl7lIYE3NZFTbPTFO7/WcxYGs6JtjDI=;
        b=rN6dqtgLpGkLLZmPKkN48XK8tiVp5ofH5xoDtgQgiBP4KkllDqEscc25iZEAM/GwDA
         kL3qVy93SsvA43nltDnt0ZiYqfGARTCH/qsGD1mr9juD+hk37V0NNdTTvpBemF/z1kZu
         N6z7+J0dcInCxm+ReXsvDmwD2tnathNMniBaiGaUW118yvCExp3VIMlf5OZfZkF5ZpfR
         VKs8BSEw5KocAPTQq5Hq9U1I2a4FkQzJ5Yn4LddGsStAwhDguY2IKiaqxjeyDA6cTsEy
         qAg+Wf9EOxgnUxKzf8UmQyEYS4Pb5CGIrj9ANqqUllkP5c9b9WZ3+VBowpitAiQMfPwZ
         lHZQ==
X-Received: by 10.70.128.34 with SMTP id nl2mr78443519pdb.43.1438065212874;
        Mon, 27 Jul 2015 23:33:32 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id p9sm32976792pds.92.2015.07.27.23.33.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jul 2015 23:33:32 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <1438065211-3777-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274730>

Add a new atom "padright" and support %(padright:X) where X is a
number.  This will align the succeeding atom value to the left
followed by spaces for a total length of X characters. If X is less
than the item size, the entire atom value is printed.

Add tests and documentation for the same.

Helped-by: Duy Nguyen <pclouds@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt |  6 ++++++
 ref-filter.c                       | 27 +++++++++++++++++++++++++--
 ref-filter.h                       |  4 +++-
 t/t6302-for-each-ref-filter.sh     | 16 ++++++++++++++++
 4 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index e49d578..45dd7f8 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -127,6 +127,12 @@ color::
 	Change output color.  Followed by `:<colorname>`, where names
 	are described in `color.branch.*`.
 
+padright::
+	Pad succeeding atom to the right. Followed by `:<value>`,
+	where `value` states the total length of atom including the
+	padding. If the `value` is greater than the atom length, then
+	no padding is performed.
+
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
 be used to specify the value in the header field.
diff --git a/ref-filter.c b/ref-filter.c
index a919a14..e5cd97b 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -55,6 +55,7 @@ static struct {
 	{ "flag" },
 	{ "HEAD" },
 	{ "color" },
+	{ "padright" },
 };
 
 /*
@@ -689,6 +690,18 @@ static void populate_value(struct ref_array_item *ref)
 			else
 				v->s = " ";
 			continue;
+		} else if (starts_with(name, "padright:")) {
+			const char *valp = NULL;
+
+			skip_prefix(name, "padright:", &valp);
+			if (!valp[0])
+				die(_("no value given with 'padright:'"));
+			if (strtoul_ui(valp, 10, (unsigned int *)&v->ul))
+				die(_("positive integer expected after ':' in padright:%u\n"),
+				    (unsigned int)v->ul);
+			v->modifier_atom = 1;
+			v->pad_to_right = 1;
+			continue;
 		} else
 			continue;
 
@@ -1195,7 +1208,16 @@ void ref_array_sort(struct ref_sorting *sorting, struct ref_array *array)
 static void apply_formatting_state(struct ref_formatting_state *state,
 				   struct atom_value *v, struct strbuf *value)
 {
-	/*  Eventually we'll formatt based on the ref_formatting_state */
+	if (state->pad_to_right) {
+		if (!is_utf8(v->s))
+			strbuf_addf(value, "%-*s", state->pad_to_right, v->s);
+		else {
+			int utf8_compensation = strlen(v->s) - utf8_strwidth(v->s);
+			strbuf_addf(value, "%-*s", state->pad_to_right + utf8_compensation, v->s);
+		}
+		return;
+	}
+
 	strbuf_addstr(value, v->s);
 }
 
@@ -1276,7 +1298,8 @@ static void emit(const char *cp, const char *ep)
 static void store_formatting_state(struct ref_formatting_state *state,
 				   struct atom_value *atomv)
 {
-	/*  Here the 'ref_formatting_state' variable will be filled */
+	if (atomv->pad_to_right)
+		state->pad_to_right = atomv->ul;
 }
 
 static void reset_formatting_state(struct ref_formatting_state *state)
diff --git a/ref-filter.h b/ref-filter.h
index 12e6a6b..23d8574 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -19,11 +19,13 @@
 struct atom_value {
 	const char *s;
 	unsigned long ul; /* used for sorting when not FIELD_STR */
-	unsigned int modifier_atom : 1; /*  atoms which act as modifiers for the next atom */
+	unsigned int modifier_atom : 1, /*  atoms which act as modifiers for the next atom */
+		pad_to_right : 1;
 };
 
 struct ref_formatting_state {
 	int quote_style;
+	unsigned int pad_to_right;
 };
 
 struct ref_sorting {
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 505a360..19ac480 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -81,4 +81,20 @@ test_expect_success 'filtering with --contains' '
 	test_cmp expect actual
 '
 
+test_expect_success 'padding to the right using `padright`' '
+	cat >expect <<-\EOF &&
+	refs/heads/master|refs/heads/master        |refs/heads/master|
+	refs/heads/side|refs/heads/side          |refs/heads/side|
+	refs/odd/spot|refs/odd/spot            |refs/odd/spot|
+	refs/tags/double-tag|refs/tags/double-tag     |refs/tags/double-tag|
+	refs/tags/four|refs/tags/four           |refs/tags/four|
+	refs/tags/one|refs/tags/one            |refs/tags/one|
+	refs/tags/signed-tag|refs/tags/signed-tag     |refs/tags/signed-tag|
+	refs/tags/three|refs/tags/three          |refs/tags/three|
+	refs/tags/two|refs/tags/two            |refs/tags/two|
+	EOF
+	git for-each-ref --format="%(refname)%(padright:25)|%(refname)|%(refname)|" >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.4.6
