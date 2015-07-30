From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v7 03/11] ref-filter: add option to pad atoms to the right
Date: Thu, 30 Jul 2015 21:18:44 +0530
Message-ID: <1438271332-10615-3-git-send-email-Karthik.188@gmail.com>
References: <CAOLa=ZQG4Oz4aSGLNQxcRB4vNo3DQn_V96H-aCD=krSSoA9JGQ@mail.gmail.com>
 <1438271332-10615-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 30 17:49:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKq4u-0003I3-8U
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jul 2015 17:49:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751703AbbG3Ps7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2015 11:48:59 -0400
Received: from mail-pd0-f194.google.com ([209.85.192.194]:33925 "EHLO
	mail-pd0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977AbbG3Ps5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2015 11:48:57 -0400
Received: by pdav4 with SMTP id v4so2288772pda.1
        for <git@vger.kernel.org>; Thu, 30 Jul 2015 08:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KhzXjq32z4NMbWt9QB/EJTrKGTf9UaL0eY3+WRDUW4g=;
        b=BwrIVNIQmDan3mLqDqgk6XeJ92Sn4fl972r2X1kdbApVA6P2/i3srU2D3WZu3KPA0w
         m8yzUMslt9FKXusS0BLSa4WOfXBPOXO4YgGpv8EoXJNWSUI8MOgaxiM2CYUqzuhB8QpP
         +buhWNy5sKCZtsRXd9OHDYcay81CHt0LAEeGx1zW5UKdP60n5hhjhKUushch3p78siln
         Y9VaA09016PWM6Ms2FgWlXTjYAa6k2q+WzKLBBP/iPlGAKclVwX93hTvljtwkj3Sq6HG
         x+KESte67fJG3/jI87I7sNXsPGo75F5Nx0vIyK6MFgQE8M/MOm6ZNHTiMXLR5NSbJQC9
         xpYw==
X-Received: by 10.70.65.38 with SMTP id u6mr105230834pds.99.1438271336778;
        Thu, 30 Jul 2015 08:48:56 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id cz1sm2875338pdb.44.2015.07.30.08.48.54
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 Jul 2015 08:48:56 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <1438271332-10615-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275005>

Add a new atom "padright" and support %(padright:X) where X is a
number.  This will align the succeeding atom or string to the left
followed by spaces for a total length of X characters. If X is less
than the atom or string length then no padding is done.

Add tests and documentation for the same.

Helped-by: Duy Nguyen <pclouds@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt |  6 ++++++
 ref-filter.c                       | 26 ++++++++++++++++++++++++++
 ref-filter.h                       |  4 +++-
 t/t6302-for-each-ref-filter.sh     | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index e49d578..9961921 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -127,6 +127,12 @@ color::
 	Change output color.  Followed by `:<colorname>`, where names
 	are described in `color.branch.*`.
 
+padright::
+	Pad succeeding atom or string to the right. Followed by
+	`:<value>`, where `value` states the total length of atom or
+	string including the padding. If the `value` is lesser than
+	the atom or string length, then no padding is performed.
+
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
 be used to specify the value in the header field.
diff --git a/ref-filter.c b/ref-filter.c
index 9a63d25..e2890e3 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -55,6 +55,7 @@ static struct {
 	{ "flag" },
 	{ "HEAD" },
 	{ "color" },
+	{ "padright" },
 };
 
 /*
@@ -691,6 +692,18 @@ static void populate_value(struct ref_array_item *ref)
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
 
@@ -1201,6 +1214,17 @@ static void apply_formatting_state(struct ref_formatting_state *state,
 		strbuf_addstr(value, state->color);
 		state->color = NULL;
 	}
+	if (state->pad_to_right) {
+		if (!is_utf8(buf))
+			strbuf_addf(value, "%-*s", state->pad_to_right, buf);
+		else {
+			int utf8_compensation = strlen(buf) - utf8_strwidth(buf);
+			strbuf_addf(value, "%-*s", state->pad_to_right + utf8_compensation, buf);
+		}
+		state->pad_to_right = 0;
+		return;
+	}
+
 	strbuf_addstr(value, buf);
 }
 
@@ -1285,6 +1309,8 @@ static void store_formatting_state(struct ref_formatting_state *state,
 {
 	if (atomv->color)
 		state->color = atomv->s;
+	if (atomv->pad_to_right)
+		state->pad_to_right = atomv->ul;
 }
 
 void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style)
diff --git a/ref-filter.h b/ref-filter.h
index 5d33360..e548c93 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -20,11 +20,13 @@ struct atom_value {
 	const char *s;
 	unsigned long ul; /* used for sorting when not FIELD_STR */
 	unsigned int modifier_atom : 1, /*  atoms which act as modifiers for the next atom */
-		color : 1;
+		color : 1,
+		pad_to_right : 1;
 };
 
 struct ref_formatting_state {
 	int quote_style;
+	unsigned int pad_to_right;
 	const char *color;
 };
 
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 505a360..48caac9 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -81,4 +81,36 @@ test_expect_success 'filtering with --contains' '
 	test_cmp expect actual
 '
 
+test_expect_success 'padding to the right using `padright`' '
+	cat >expect <<-\EOF &&
+	master|    master    |
+	side|    side      |
+	odd/spot|    odd/spot  |
+	double-tag|    double-tag|
+	four|    four      |
+	one|    one       |
+	signed-tag|    signed-tag|
+	three|    three     |
+	two|    two       |
+	EOF
+	git for-each-ref --format="%(refname:short)%(padright:5)|%(padright:10)%(refname:short)|" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'no padding when `padright` length is smaller than atom length' '
+	cat >expect <<-\EOF &&
+	refs/heads/master|
+	refs/heads/side|
+	refs/odd/spot|
+	refs/tags/double-tag|
+	refs/tags/four|
+	refs/tags/one|
+	refs/tags/signed-tag|
+	refs/tags/three|
+	refs/tags/two|
+	EOF
+	git for-each-ref --format="%(padright:5)%(refname)|" >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.4.6
