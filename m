Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55A2F205C9
	for <e@80x24.org>; Tue, 10 Jan 2017 08:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760494AbdAJItM (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 03:49:12 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35435 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760375AbdAJItJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 03:49:09 -0500
Received: by mail-pf0-f193.google.com with SMTP id f144so9037866pfa.2
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 00:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cGYxFpT1DKl1N4GrDzNEYzOywCFPmd+C+4rXyKaaa98=;
        b=p+j24WD6Qq64g4qJMhEJxQk2ZrZcU4yEUYNKXKbhJsJYRRSbYA2bQIQXM/9EM8Nvw+
         VL7pCgBLugyLytXlXwRurK8xNZZlDQH5oL7HRVqne/F9vETqZsabeyBBZRh+fr1op+F8
         hge0T2L0WnstWeFPXuIc0SVzKML86+BtRRIUks2zHpbIacQpsKf1DwRd2JkU8MPiQXE4
         XGmYmWto/lZ5Hi6JoSx1SK04uu9ZS5eI8Q3ESpLSnDrDVJRJbKdAKATr+l0l1NHMbvdP
         gHXyFgNxGypReNR63otzF7kwqNXoo+OBRjkvRdrJ++LlJ/H8fJwGrJAuo1V0yel7Dcc+
         6Wpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cGYxFpT1DKl1N4GrDzNEYzOywCFPmd+C+4rXyKaaa98=;
        b=rB1BcqfwBn2MoznCk+WhoiW/5iuuZTQ43gYWIqEHTPajpmzLmuA34hU4jOpBQW3gWG
         LMR0762kw7eugVl2O3hQGNSu47cXhFOqRj4O2QtNuopQC5qDrxNoTWfCE42ATPwdohll
         nklCRgtrKVduNnzY5T0WP1XtdinxXdcvrrhLhpNWi0MZH5gDOjwDaFX9NZOnc4ZfArfD
         bowLPRBlWtljp+ELKxN0ENxz864AK6v+2TWCPYWsCvt66s5TLzwuKpYl1iErFxOknZOR
         hkAGkxLfkN2KLRP3kRvpX9CtFndvgE118UV7/iI4W5Ww6vBY+fAjLyHU4JEbQWIhstFX
         jofQ==
X-Gm-Message-State: AIkVDXJhWTYYt8HMroO4NNN9yHOLAJXl9EBV7UjgDzC7giY5ODP2j/6Yix07EtlGTBKl1A==
X-Received: by 10.99.149.1 with SMTP id p1mr2732965pgd.21.1484038149199;
        Tue, 10 Jan 2017 00:49:09 -0800 (PST)
Received: from AamlaJuice.corp.endurance.com ([115.110.127.198])
        by smtp.gmail.com with ESMTPSA id m12sm3411983pfg.92.2017.01.10.00.49.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jan 2017 00:49:08 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, gitster@pobox.com,
        Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v10 08/20] ref-filter: add support for %(upstream:track,nobracket)
Date:   Tue, 10 Jan 2017 14:19:41 +0530
Message-Id: <20170110084953.15890-9-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170110084953.15890-1-Karthik.188@gmail.com>
References: <20170110084953.15890-1-Karthik.188@gmail.com>
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
index 94c6b88fa..14240b407 100644
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
index 998991873..6de0927d1 100644
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
index a2e3f5525..af76dc530 100755
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
2.11.0

