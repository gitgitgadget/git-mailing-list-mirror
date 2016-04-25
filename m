From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5b 08/17] ref-filter: add support for %(upstream:track,nobracket)
Date: Mon, 25 Apr 2016 20:47:49 +0530
Message-ID: <1461597478-31855-8-git-send-email-Karthik.188@gmail.com>
References: <1461581558-32348-1-git-send-email-Karthik.188@gmail.com>
Cc: jacob.keller@gmail.com, gitster@pobox.com, peff@peff.net,
	Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 25 17:18:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auiHT-0005mc-6s
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 17:18:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932642AbcDYPS3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 11:18:29 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34504 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932511AbcDYPS0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 11:18:26 -0400
Received: by mail-pf0-f173.google.com with SMTP id y69so47998883pfb.1
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 08:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PM49cJgbFdBsVu9IxDt7TRJWX+vSRyYC3XDckMZxXgI=;
        b=wNqR4mnvQnXBsjUXDSz+730KW3o1EM8u6QW5Z7rTolLl0KaecslPt5ax3aMoqnxips
         +UdK7B8jODup+yIxtyj+1qKfymEc7xoj+QTt3Y2Wct6Y1EIpm2nv3EyEVWvgA5n0RGxR
         YChVheUPlDuiN6ynNL6DUzcwNnWz4dygsRujduH7Y4Xs2wpMmY8Lp92n8eglf+XFwnGC
         yqkZdXV3ZPCeYBPwTSb0Xl2gLwRBNrf+IIRX4QxhL980q3aNkE096CLWKMG6TyvV0gNy
         GO1fGPxn4OZJzcy8C3SGtEFKphPv9rCqMCkviU0ASZUASWGYLfbBk/cFx6S4ZrYW3IT+
         j1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PM49cJgbFdBsVu9IxDt7TRJWX+vSRyYC3XDckMZxXgI=;
        b=gHKu5LRrtIQX9M0x9nCPNYx8vLN7rYYtKD6O/0/dx3RG3DXjBs8+ZNuK7jbQwP7a4f
         lUhSzFEvw528z2B92CW2ps2WjYzbXjeHulqa4ZORSZXGWmPrskjESyjqBd97xNST24Vw
         AnetMcDYq9N5jZpPr1IiNA7O3O/YW3CMkd5vIRIkzE0KxYRPl3Df0RUMwVTF6q+FuL9k
         z9xWanEKwWzJDkZCxpvTXmjncqgEDBrOSCj20qSp6WCWVnoUv+VQ9gRwqDQ88qBW9KZl
         9IYUrbsKvxb8uikmIpG9Z7jD6fiFYbvt2kx90TFzXugExcvrw26YUspIr53mul/e+ArT
         XpRQ==
X-Gm-Message-State: AOPr4FV7NZMjwFLstF2J3i6Jw5IFg6A9MSDVq56lG+XDupgYIomuFdjH3DBcFWs+uQVNPQ==
X-Received: by 10.98.51.132 with SMTP id z126mr15103979pfz.23.1461597505819;
        Mon, 25 Apr 2016 08:18:25 -0700 (PDT)
Received: from ashley.localdomain ([106.51.234.108])
        by smtp.gmail.com with ESMTPSA id ut1sm30812527pac.46.2016.04.25.08.18.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Apr 2016 08:18:24 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1461581558-32348-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292495>

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
