Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BD5920441
	for <e@80x24.org>; Tue, 27 Dec 2016 16:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755524AbcL0QXi (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 11:23:38 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33660 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755440AbcL0QXc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 11:23:32 -0500
Received: by mail-pf0-f193.google.com with SMTP id 127so8393506pfg.0
        for <git@vger.kernel.org>; Tue, 27 Dec 2016 08:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ldTPRO6k+VTQTEFZ3aBqac6vx0TYxcW9xwcr7ky4DJI=;
        b=ndi46DDi26KgFJWbGCVWUE0YRtS4q5jYs+SHcmleQ0rn8nR8TQr2jmBIgb0EEWCiUh
         x6qFhfAAe4B5hHTzEP8dBLj6zVDbCblHLN66kvdj3yI23VJXDDGYjaKuXzyk6GFDy7uz
         mDgMK7+MX+ss4Z7dUVPbhOmHXBVeGk3P+Yu+WGc64Iz8eY1eu+sZiGtqghYE9qVOnSkr
         LHgyS6Pi2tLHeqnE8pQO5bfV5NTbgIrSLBaCCVLtTULYbWpVymw992WsmsJ5uJD8t6v4
         RNbNSoVU2y3UHibcQoMEddAd6D2jO86Ne/MJgpYkuTgIOelo1K6gNbpl5dMScji0Nvq8
         0ifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ldTPRO6k+VTQTEFZ3aBqac6vx0TYxcW9xwcr7ky4DJI=;
        b=rrmlq4lNJye0+CYRpzW0Ag9AnHGuC1egMwIsr9olRFOLBoq+quS+HNB2Fv2qxj7yA3
         oF0L9/F68tnGgG7MWUkrSBXJ1fnJf8Yh1vwnZcqTb+Pnw7Q0zwR0EwGB4egt0BTIo90a
         KMqS8YHNL8aRO2c5Qpo8soq2HaQ2Nu9rt9UBXefsHHSX4Pvp5Og28wgOrbd9ImJvvEPk
         W1Cx7OmeIKI+fw5jby6D9QQv9AdOTuwd5EJq/cfTSHS/+v4dq/iJU6F7vV7Zs9Y68INj
         Kgskq0VhWpj8Dr+rCIaF0MWj9/p7G7+2ATgd/0xqNT6o532Ph0BN7rJbTDOU5O4jlYsX
         5WpQ==
X-Gm-Message-State: AIkVDXLBjVS6vGc9eijx68s7fRNlsSGlqjFV/QPmoKX6/SYcwZPl9kV8X8I8LhT7mc6SgA==
X-Received: by 10.84.167.168 with SMTP id d37mr67967626plb.71.1482855811790;
        Tue, 27 Dec 2016 08:23:31 -0800 (PST)
Received: from AamlaJuice.corp.endurance.com ([115.110.127.198])
        by smtp.gmail.com with ESMTPSA id c64sm46517096pfa.91.2016.12.27.08.23.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Dec 2016 08:23:31 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v9 08/20] ref-filter: add support for %(upstream:track,nobracket)
Date:   Tue, 27 Dec 2016 21:53:45 +0530
Message-Id: <20161227162357.28212-9-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161227162357.28212-1-Karthik.188@gmail.com>
References: <20161227162357.28212-1-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Karthik Nayak <karthik.188@gmail.com>

Add support for %(upstream:track,nobracket) which will print the
tracking information without the brackets (i.e. "ahead N, behind M").
This is needed when we port branch.c to use ref-filter's printing APIs.

Add test and documentation for the same.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt | 10 ++++--
 ref-filter.c                       | 67 +++++++++++++++++++++++++-------------
 t/t6300-for-each-ref.sh            |  2 ++
 3 files changed, 53 insertions(+), 26 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 24a1679..b17273e 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -120,9 +120,13 @@ upstream::
 	`refname` above.  Additionally respects `:track` to show
 	"[ahead N, behind M]" and `:trackshort` to show the terse
 	version: ">" (ahead), "<" (behind), "<>" (ahead and behind),
-	or "=" (in sync).  Has no effect if the ref does not have
-	tracking information associated with it. `:track` also prints
-	"[gone]" whenever unknown upstream ref is encountered.
+	or "=" (in sync). `:track` also prints "[gone]" whenever
+	unknown upstream ref is encountered. Append `:track,nobracket`
+	to show tracking information without brackets (i.e "ahead N,
+	behind M").  Has no effect if the ref does not have tracking
+	information associated with it.  All the options apart from
+	`nobracket` are mutually exclusive, but if used together the
+	last option is selected.
 
 push::
 	The name of a local ref which represents the `@{push}` location
diff --git a/ref-filter.c b/ref-filter.c
index 9989918..6de0927 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -48,8 +48,10 @@ static struct used_atom {
 	union {
 		char color[COLOR_MAXLEN];
 		struct align align;
-		enum { RR_NORMAL, RR_SHORTEN, RR_TRACK, RR_TRACKSHORT }
-			remote_ref;
+		struct {
+			enum { RR_NORMAL, RR_SHORTEN, RR_TRACK, RR_TRACKSHORT } option;
+			unsigned int nobracket : 1;
+		} remote_ref;
 		struct {
 			enum { C_BARE, C_BODY, C_BODY_DEP, C_LINES, C_SIG, C_SUB, C_TRAILERS } option;
 			unsigned int nlines;
@@ -77,16 +79,33 @@ static void color_atom_parser(struct used_atom *atom, const char *color_value)
 
 static void remote_ref_atom_parser(struct used_atom *atom, const char *arg)
 {
-	if (!arg)
-		atom->u.remote_ref = RR_NORMAL;
-	else if (!strcmp(arg, "short"))
-		atom->u.remote_ref = RR_SHORTEN;
-	else if (!strcmp(arg, "track"))
-		atom->u.remote_ref = RR_TRACK;
-	else if (!strcmp(arg, "trackshort"))
-		atom->u.remote_ref = RR_TRACKSHORT;
-	else
-		die(_("unrecognized format: %%(%s)"), atom->name);
+	struct string_list params = STRING_LIST_INIT_DUP;
+	int i;
+
+	if (!arg) {
+		atom->u.remote_ref.option = RR_NORMAL;
+		return;
+	}
+
+	atom->u.remote_ref.nobracket = 0;
+	string_list_split(&params, arg, ',', -1);
+
+	for (i = 0; i < params.nr; i++) {
+		const char *s = params.items[i].string;
+
+		if (!strcmp(s, "short"))
+			atom->u.remote_ref.option = RR_SHORTEN;
+		else if (!strcmp(s, "track"))
+			atom->u.remote_ref.option = RR_TRACK;
+		else if (!strcmp(s, "trackshort"))
+			atom->u.remote_ref.option = RR_TRACKSHORT;
+		else if (!strcmp(s, "nobracket"))
+			atom->u.remote_ref.nobracket = 1;
+		else
+			die(_("unrecognized format: %%(%s)"), atom->name);
+	}
+
+	string_list_clear(&params, 0);
 }
 
 static void body_atom_parser(struct used_atom *atom, const char *arg)
@@ -1069,25 +1088,27 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 				    struct branch *branch, const char **s)
 {
 	int num_ours, num_theirs;
-	if (atom->u.remote_ref == RR_SHORTEN)
+	if (atom->u.remote_ref.option == RR_SHORTEN)
 		*s = shorten_unambiguous_ref(refname, warn_ambiguous_refs);
-	else if (atom->u.remote_ref == RR_TRACK) {
+	else if (atom->u.remote_ref.option == RR_TRACK) {
 		if (stat_tracking_info(branch, &num_ours,
 				       &num_theirs, NULL)) {
-			*s = "[gone]";
-			return;
-		}
-
-		if (!num_ours && !num_theirs)
+			*s = xstrdup("gone");
+		} else if (!num_ours && !num_theirs)
 			*s = "";
 		else if (!num_ours)
-			*s = xstrfmt("[behind %d]", num_theirs);
+			*s = xstrfmt("behind %d", num_theirs);
 		else if (!num_theirs)
-			*s = xstrfmt("[ahead %d]", num_ours);
+			*s = xstrfmt("ahead %d", num_ours);
 		else
-			*s = xstrfmt("[ahead %d, behind %d]",
+			*s = xstrfmt("ahead %d, behind %d",
 				     num_ours, num_theirs);
-	} else if (atom->u.remote_ref == RR_TRACKSHORT) {
+		if (!atom->u.remote_ref.nobracket && *s[0]) {
+			const char *to_free = *s;
+			*s = xstrfmt("[%s]", *s);
+			free((void *)to_free);
+		}
+	} else if (atom->u.remote_ref.option == RR_TRACKSHORT) {
 		if (stat_tracking_info(branch, &num_ours,
 				       &num_theirs, NULL))
 			return;
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index a2e3f55..af76dc5 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -372,6 +372,8 @@ test_expect_success 'setup for upstream:track[short]' '
 
 test_atom head upstream:track '[ahead 1]'
 test_atom head upstream:trackshort '>'
+test_atom head upstream:track,nobracket 'ahead 1'
+test_atom head upstream:nobracket,track 'ahead 1'
 test_atom head push:track '[ahead 1]'
 test_atom head push:trackshort '>'
 
-- 
2.10.2

