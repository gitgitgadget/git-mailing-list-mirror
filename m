From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 03/11] ref-filter: add option to pad atoms to the right
Date: Mon, 27 Jul 2015 12:57:07 +0530
Message-ID: <1437982035-6658-3-git-send-email-Karthik.188@gmail.com>
References: <CAOLa=ZTtAepdO5U8zo62VBn_z4-LcKoguPxVGaAnNZULEwzrQQ@mail.gmail.com>
 <1437982035-6658-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 27 09:27:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJcom-0000ai-Mg
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 09:27:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbbG0H1U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 03:27:20 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:36544 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751135AbbG0H1T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 03:27:19 -0400
Received: by pdjr16 with SMTP id r16so48138049pdj.3
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 00:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cmAcCXWGJQhvw4ClpVXuoWko79SUoBVPeouTo87Aa9U=;
        b=t9Qso+XLmoT2iKVJMOkxqjHPsZ4WLD+TacNNjF/JDr59OV0ZDXJnK1h+5317AZC8ta
         ZW1pziGeGMURXYpHSXdBqteko6F1riXF0p8RRWNm25PF6NndDmfqZb5VqgmNAM/RfCCL
         O57hbuU+j9Cy70mEnUPgb4tGh/SDjQwy/mkF2URR4pZXlDrOwiZF9AwdADF4aZ7V5EjX
         YOoANx+HYijaTJKshmrSbxANIB3smB3YYkkJPFunY8wO4zmM9abHLdglkU1DJVj5z6vX
         BPzrP7byCrWIPs1QYpbxVLOdZpBHfRTVdM1G4ou5rMvjiAolqMs8GNGiGMv4BIFGPz4v
         8lMg==
X-Received: by 10.70.128.14 with SMTP id nk14mr62911373pdb.79.1437982038938;
        Mon, 27 Jul 2015 00:27:18 -0700 (PDT)
Received: from ashley.localdomain ([106.51.241.234])
        by smtp.gmail.com with ESMTPSA id wv4sm27732769pac.2.2015.07.27.00.27.16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jul 2015 00:27:18 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <1437982035-6658-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274653>

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
 ref-filter.c                       | 24 ++++++++++++++++++++++++
 ref-filter.h                       |  4 +++-
 t/t6302-for-each-ref-filter.sh     | 16 ++++++++++++++++
 4 files changed, 49 insertions(+), 1 deletion(-)

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
index cc25c85..7ab34be 100644
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
+			v->pseudo_atom = 1;
+			v->pad_to_right = 1;
+			continue;
 		} else
 			continue;
 
@@ -1202,6 +1215,15 @@ static void ref_formatting(struct ref_formatting_state *state,
 		free(state->color);
 		state->color = NULL;
 	}
+	if (state->pad_to_right) {
+		if (!is_utf8(v->s))
+			strbuf_addf(value, "%-*s", state->pad_to_right, v->s);
+		else {
+			int utf8_compensation = strlen(v->s) - utf8_strwidth(v->s);
+			strbuf_addf(value, "%-*s", state->pad_to_right + utf8_compensation, v->s);
+		}
+		return;
+	}
 	strbuf_addf(value, "%s", v->s);
 }
 
@@ -1278,6 +1300,8 @@ static void apply_pseudo_state(struct ref_formatting_state *state,
 {
 	if (v->color)
 		state->color = (char *)v->s;
+	if (v->pad_to_right)
+		state->pad_to_right = v->ul;
 }
 
 void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style)
diff --git a/ref-filter.h b/ref-filter.h
index 7687879..63b8175 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -20,12 +20,14 @@ struct atom_value {
 	const char *s;
 	unsigned long ul; /* used for sorting when not FIELD_STR */
 	unsigned int pseudo_atom : 1, /*  atoms which aren't placeholders for ref attributes */
-		color : 1;
+		color : 1,
+		pad_to_right : 1;
 };
 
 struct ref_formatting_state {
 	int quote_style;
 	char *color;
+	unsigned int pad_to_right;
 };
 
 struct ref_sorting {
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 505a360..daaa27a 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -81,4 +81,20 @@ test_expect_success 'filtering with --contains' '
 	test_cmp expect actual
 '
 
+test_expect_success 'padding to the right using `padright`' '
+	cat >expect <<-\EOF &&
+	refs/heads/master        |
+	refs/heads/side          |
+	refs/odd/spot            |
+	refs/tags/double-tag     |
+	refs/tags/four           |
+	refs/tags/one            |
+	refs/tags/signed-tag     |
+	refs/tags/three          |
+	refs/tags/two            |
+	EOF
+	git for-each-ref --format="%(padright:25)%(refname)|" >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.4.6
