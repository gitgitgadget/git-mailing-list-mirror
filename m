From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 08/16] ref-filter: add support for %(upstream:track,nobracket)
Date: Tue, 15 Mar 2016 22:17:08 +0530
Message-ID: <1458060436-1215-9-git-send-email-Karthik.188@gmail.com>
References: <1458060436-1215-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, jacob.keller@gmail.com,
	Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 15 17:48:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afs8Z-000108-8t
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 17:48:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965248AbcCOQru (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 12:47:50 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36170 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965232AbcCOQrs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 12:47:48 -0400
Received: by mail-pf0-f176.google.com with SMTP id u190so35744934pfb.3
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 09:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KfUvX63EdVYh++jfCcHCckhx4wgjEVNh8cB0jomBOhI=;
        b=gL7VKDBnJT28F8mmD/jTMzbnhGoUkPgJmzR74aZOyAFH892LFdlio0NP9ncqGwnXb4
         jLW9voeckYBl+rTEmQE8wcAcSK4eu0/S+VgMFxE5lihOR2W39+hXWAJS0qOBxkX7dVAk
         92ipHFUANomtWi15Q7lU6jTlm0w1f1gYflpAmgOxFTRWQk0XtmejR8FDGJWHeDlLJ76W
         /NPMGaWSOrTheCwdwVBfeaoIXRuabD1RgHDTe7/3bTVElkXQou4GMiIks4dD6KsRMJ8D
         xbJGFlacw3rtDldZcwbUaqSTNpbrh1beTZo4FgUQPQgNdMiibAm6gBk6WabqGaBIEqag
         q3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KfUvX63EdVYh++jfCcHCckhx4wgjEVNh8cB0jomBOhI=;
        b=g5r+3DYMy8Py2k+CKJPSpjdpMX9J7RZfK5s7NS/mLm4+hEO6G6uuV1gUgSLF9JU4Ay
         5kxHkfQyjluWqSZ8Cx1NGX3KBsMrxQOlx4my+S7KKr1N4+qv5AfcuytCkg/Sq7l9V3Xp
         lJtsJdxYhLNTvWWdGHeUDUJhYoYn5ZHZJXMnpSU7JQpO5RLmek+ZTbrIxFQxX8Zt5xTc
         kyAbBsAwNbrKCvYq81SrWMCw8w9XfKXZql93Ac9sG+NpQ1I1w4pZ80btOUsNHKWEYtBY
         Y6/lcMzYyUkn4rXnu52zmsnwq8UVEpdc8MRQaAI5NY0hOgZvAf1Zc0oRkjbjCVtqYBwt
         smzQ==
X-Gm-Message-State: AD7BkJJFK981EOViSOmygXFRwZq6csNhrJliRALqdtRc98nloCQtre0OFwp32hClxUDRGg==
X-Received: by 10.66.248.168 with SMTP id yn8mr47650725pac.24.1458060462319;
        Tue, 15 Mar 2016 09:47:42 -0700 (PDT)
Received: from localhost.localdomain ([106.51.243.87])
        by smtp.gmail.com with ESMTPSA id i1sm40874361pfj.17.2016.03.15.09.47.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Mar 2016 09:47:41 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1458060436-1215-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288871>

Add support for %(upstream:track,nobracket) which will print the
tracking information without the brackets (i.e. "ahead N, behind M").
This is needed when we port branch.c to use ref-filter's printing APIs.

Add test and documentation for the same.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt |  5 ++-
 ref-filter.c                       | 67 +++++++++++++++++++++++++-------------
 t/t6300-for-each-ref.sh            |  2 ++
 3 files changed, 50 insertions(+), 24 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 6dbd7bd..4e41cee 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -116,7 +116,10 @@ upstream::
 	version: ">" (ahead), "<" (behind), "<>" (ahead and behind),
 	or "=" (in sync).  Has no effect if the ref does not have
 	tracking information associated with it. `:track` also prints
-	"[gone]" whenever unknown upstream ref is encountered.
+	"[gone]" whenever unknown upstream ref is encountered. Append
+	`:track,nobracket` to show tracking information without
+	brackets (i.e "ahead N, behind M").  Has no effect if the ref
+	does not have tracking information associated with it.
 
 push::
 	The name of a local ref which represents the `@{push}` location
diff --git a/ref-filter.c b/ref-filter.c
index 4d7e0c0..8c97cdb 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -46,8 +46,10 @@ static struct used_atom {
 	union {
 		char color[COLOR_MAXLEN];
 		struct align align;
-		enum { RR_NORMAL, RR_SHORTEN, RR_TRACK, RR_TRACKSHORT }
-			remote_ref;
+		struct {
+			enum { RR_NORMAL, RR_SHORTEN, RR_TRACK, RR_TRACKSHORT } option;
+			unsigned int nobracket: 1;
+		} remote_ref;
 		struct {
 			enum { C_BARE, C_BODY, C_BODY_DEP, C_LINES, C_SIG, C_SUB } option;
 			unsigned int nlines;
@@ -75,16 +77,33 @@ static void color_atom_parser(struct used_atom *atom, const char *color_value)
 
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
@@ -1045,25 +1064,27 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
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
index a92b36f..2c5f177 100755
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
2.7.3
