From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 07/16] ref-filter: add support for %(upstream:track,nobracket)
Date: Sat, 23 Apr 2016 00:33:58 +0530
Message-ID: <1461351847-22903-8-git-send-email-Karthik.188@gmail.com>
References: <1461351847-22903-1-git-send-email-Karthik.188@gmail.com>
Cc: jacob.keller@gmail.com, gitster@pobox.com, peff@peff.net,
	Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 21:05:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atgNy-0008Fb-1q
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 21:05:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752505AbcDVTEy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 15:04:54 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34543 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752265AbcDVTEv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 15:04:51 -0400
Received: by mail-pf0-f196.google.com with SMTP id 145so3074227pfz.1
        for <git@vger.kernel.org>; Fri, 22 Apr 2016 12:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PM49cJgbFdBsVu9IxDt7TRJWX+vSRyYC3XDckMZxXgI=;
        b=W9EZGybYuo5x+Cefi+6PFWxDqXKVTCzMnaSVEtUQXKE/T2EQoPYxX2uIHIMx+ZXl8+
         soCyXCwcWAKmg4gtqfXRHhBHbpYgCBGhqdpsvpaiNdT7RHq+1pOlLeia4n4UIZwuPaCf
         h9JGOKcn9omWcx8ENbWmL535yPiCfWmmUPQxWTBZ92yUrkjXOALD/AimEy9YImfMbm8N
         bSXX7pH/mXzyLu2r0TbYPnwR5MFttMYHA6LmZRUF47MAwsawLqi4KMo4QpU9iKBjCWFl
         UERTxdeZ7eT9yaQkeiw5GegJvURX2w8+i1jky+/UAaq972lo1x8aHOFf3evhvISUyVe7
         WtCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PM49cJgbFdBsVu9IxDt7TRJWX+vSRyYC3XDckMZxXgI=;
        b=kcq3TlffoFTJIZsG4hZcMFjSVCAdTRDCinJUlD8xxockg1HFn9AdMWsrqHk7qWmXdX
         Q0h3hUcE9dytVbmlqPL1yGkFi8eYYrOAojSNq5mRvLt11T6UkguyjeshgSNWEyYor02G
         LHs5KiLdFGl31qStF/NHiUs4MT12nkXK8fTI2YU8uClZH//b8f8XlBTaEHMVKLtmq9HK
         SAZlCmM+J0PlGlOd6JxJ5YTedjw2Fnhpq/l1AzDup0BTqYggJ4IX7AT93v0/emvsZuo+
         0tGe6LhatMdPBAnUSdyqeqiAwp0lXSUyIgd6Ws0PJUxaWALXlxbqBjKmhxexy3Gnsh9M
         MElw==
X-Gm-Message-State: AOPr4FXnaza9KEu1J9nYmKN2lqty3QCvq1+iJbjWDPdWiXit5sAFgFMhFDH1hVIjn94LEQ==
X-Received: by 10.98.72.199 with SMTP id q68mr21809667pfi.164.1461351890607;
        Fri, 22 Apr 2016 12:04:50 -0700 (PDT)
Received: from ashley.localdomain ([106.216.186.206])
        by smtp.gmail.com with ESMTPSA id t1sm11266470paa.17.2016.04.22.12.04.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Apr 2016 12:04:49 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1461351847-22903-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292255>

Add support for %(upstream:track,nobracket) which will print the
tracking information without the brackets (i.e. "ahead N, behind M").
This is needed when we port branch.c to use ref-filter's printing APIs.

Add test and documentation for the same.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt |  8 +++--
 ref-filter.c                       | 67 +++++++++++++++++++++++++-------------
 t/t6300-for-each-ref.sh            |  2 ++
 3 files changed, 51 insertions(+), 26 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index f1e46a7..5c85f27 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -118,9 +118,11 @@ upstream::
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
+	information associated with it.
 
 push::
 	The name of a local ref which represents the `@{push}` location
diff --git a/ref-filter.c b/ref-filter.c
index 3bb6923..b898bcd 100644
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
2.8.0
