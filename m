Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9ED7420259
	for <e@80x24.org>; Wed,  7 Dec 2016 15:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753453AbcLGPhC (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 10:37:02 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36489 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753319AbcLGPgw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 10:36:52 -0500
Received: by mail-pf0-f195.google.com with SMTP id c4so20788055pfb.3
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 07:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9zE9Pg8YEJBltw9dI5BE9nSOQuiyIdUBL2CK9D3gAsQ=;
        b=zSKRAm/pqcV++DmviEPjExmoIYTfGuvU6H4Z6BmQNsXmoT1+T2P5hc3+amPwOO0K3+
         1MQH1OiyH+8pezkZFGEq65U8lYcG7qchtrZ/dHMzrD7xV8HjRcycOElkcd63jtsa5HjR
         bpaMIslOQojGnLstENKZLjVuobikBDFk8D2N+1oBt2D8P3ZWJSLcdeE8hvf2ihHiIPmn
         Bftnn5oEOD4SFlA354qlAgFPRTi2CDJfYrOyhD4nNw2tV8f1N28pxG1E3JQL77RHRrgM
         aByD0RrIhYM9O/r5CjwhQaeycT3mQ4RZWJDE4siOGL6WCds3OMG4rJK95J0CYiVT4lGn
         YVsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9zE9Pg8YEJBltw9dI5BE9nSOQuiyIdUBL2CK9D3gAsQ=;
        b=gIH2+GwxdPnobiY5CTxybtF+BJmqiDOwWBs11Y8F9icaLFDavJmu2QIVNmJB4+M3XM
         MrpOl45r6rIk9dL0/tqRK737qBEziHHjju/64ss4le6W/ejd/YnwBThEsoxl3Qtgg5Kb
         G+EaB27OQdj4QlQUqAcnLyJN/VyqXFMeyRgOy5YJE000Nyy2iZOi2uYDJ+ls7VGY+Jjp
         wZIBWDt4ozVugCTDv/2umHYmwptIcfhU3J6HtbBkWTKYtOjffaG9OOctwvKF+drB6UmG
         CZnzHNKz8/MJDbzI2vwFW++7dJee6Rb1Cql+5bpP30Wle3OAHVEwsD49Lk2KK0OJzEY8
         yI0Q==
X-Gm-Message-State: AKaTC00t1/J2J7buV2udvCN9GFYApBYzpBV5LVUZR+Gv4l/Y83cx0amG9u35yteK5FLprw==
X-Received: by 10.84.216.10 with SMTP id m10mr148287070pli.131.1481125011791;
        Wed, 07 Dec 2016 07:36:51 -0800 (PST)
Received: from AamlaJuice.corp.endurance.com ([122.15.255.69])
        by smtp.gmail.com with ESMTPSA id l7sm43584459pfg.35.2016.12.07.07.36.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Dec 2016 07:36:51 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, gitster@pobox.com, jnareb@gmail.com,
        Karthik Nayak <Karthik.188@gmail.com>
Subject: [PATCH v8 15/19] ref-filter: add an 'rstrip=<N>' option to atoms which deal with refnames
Date:   Wed,  7 Dec 2016 21:06:23 +0530
Message-Id: <20161207153627.1468-16-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161207153627.1468-1-Karthik.188@gmail.com>
References: <20161207153627.1468-1-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Complimenting the existing 'lstrip=<N>' option, add an 'rstrip=<N>'
option which strips `<N>` slash-separated path components from the end
of the refname (e.g., `%(refname:rstrip=2)` turns `refs/tags/foo` into
`refs`).

Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt | 40 ++++++++++++++++++++-----------------
 ref-filter.c                       | 41 ++++++++++++++++++++++++++++++++++++--
 t/t6300-for-each-ref.sh            | 24 ++++++++++++++++++++++
 3 files changed, 85 insertions(+), 20 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index ad9b243..c72baeb 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -92,10 +92,12 @@ refname::
 	The name of the ref (the part after $GIT_DIR/).
 	For a non-ambiguous short name of the ref append `:short`.
 	The option core.warnAmbiguousRefs is used to select the strict
-	abbreviation mode. If `lstrip=<N>` is appended, strips `<N>`
-	slash-separated path components from the front of the refname
-	(e.g., `%(refname:lstrip=2)` turns `refs/tags/foo` into `foo`.
-	if `<N>` is a negative number, then only `<N>` path components
+	abbreviation mode. If `lstrip=<N>` or `rstrip=<N>` option can
+	be appended to strip `<N>` slash-separated path components
+	from or end of the refname respectively (e.g.,
+	`%(refname:lstrip=2)` turns `refs/tags/foo` into `foo` and
+	`%(refname:rstrip=2)` turns `refs/tags/foo` into `refs`).  if
+	`<N>` is a negative number, then only `<N>` path components
 	are left behind.  If a displayed ref has fewer components than
 	`<N>`, the command aborts with an error.
 
@@ -114,22 +116,23 @@ objectname::
 
 upstream::
 	The name of a local ref which can be considered ``upstream''
-	from the displayed ref. Respects `:short` and `:lstrip` in the
-	same way as `refname` above.  Additionally respects `:track`
-	to show "[ahead N, behind M]" and `:trackshort` to show the
-	terse version: ">" (ahead), "<" (behind), "<>" (ahead and
-	behind), or "=" (in sync). `:track` also prints "[gone]"
-	whenever unknown upstream ref is encountered. Append
-	`:track,nobracket` to show tracking information without
-	brackets (i.e "ahead N, behind M").  Has no effect if the ref
-	does not have tracking information associated with it.  All
-	the options apart from `nobracket` are mutually exclusive, but
-	if used together the last option is selected.
+	from the displayed ref. Respects `:short`, `:lstrip` and
+	`:rstrip` in the same way as `refname` above.  Additionally
+	respects `:track` to show "[ahead N, behind M]" and
+	`:trackshort` to show the terse version: ">" (ahead), "<"
+	(behind), "<>" (ahead and behind), or "=" (in sync). `:track`
+	also prints "[gone]" whenever unknown upstream ref is
+	encountered. Append `:track,nobracket` to show tracking
+	information without brackets (i.e "ahead N, behind M").  Has
+	no effect if the ref does not have tracking information
+	associated with it.  All the options apart from `nobracket`
+	are mutually exclusive, but if used together the last option
+	is selected.
 
 push::
 	The name of a local ref which represents the `@{push}`
 	location for the displayed ref. Respects `:short`, `:lstrip`,
-	`:track`, and `:trackshort` options as `upstream`
+	`:rstrip`, `:track`, and `:trackshort` options as `upstream`
 	does. Produces an empty string if no `@{push}` ref is
 	configured.
 
@@ -171,8 +174,9 @@ if::
 
 symref::
 	The ref which the given symbolic ref refers to. If not a
-	symbolic ref, nothing is printed. Respects the `:short` and
-	`:lstrip` options in the same way as `refname` above.
+	symbolic ref, nothing is printed. Respects the `:short`,
+	`:lstrip` and `:rstrip` options in the same way as `refname`
+	above.
 
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
diff --git a/ref-filter.c b/ref-filter.c
index deb2b29..9fce5bb 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -32,8 +32,8 @@ struct if_then_else {
 };
 
 struct refname_atom {
-	enum { R_NORMAL, R_SHORT, R_LSTRIP } option;
-	int lstrip;
+	enum { R_NORMAL, R_SHORT, R_LSTRIP, R_RSTRIP } option;
+	int lstrip, rstrip;
 };
 
 /*
@@ -94,6 +94,10 @@ static void refname_atom_parser_internal(struct refname_atom *atom,
 		atom->option = R_LSTRIP;
 		if (strtol_i(arg, 10, &atom->lstrip))
 			die(_("Integer value expected refname:lstrip=%s"), arg);
+	} else if (skip_prefix(arg, "rstrip=", &arg)) {
+		atom->option = R_RSTRIP;
+		if (strtol_i(arg, 10, &atom->rstrip))
+			die(_("Integer value expected refname:rstrip=%s"), arg);
 	} else
 		die(_("unrecognized %%(%s) argument: %s"), name, arg);
 }
@@ -1105,12 +1109,45 @@ static const char *lstrip_ref_components(const char *refname, int len)
 	return start;
 }
 
+static const char *rstrip_ref_components(const char *refname, int len)
+{
+	long remaining = len;
+	char *start = xstrdup(refname);
+
+	if (len < 0) {
+		int i;
+		const char *p = refname;
+
+		/* Find total no of '/' separated path-components */
+		for (i = 0; p[i]; p[i] == '/' ? i++ : *p++);
+		/*
+		 * The number of components we need to strip is now
+		 * the total minus the components to be left (Plus one
+		 * because we count the number of '/', but the number
+		 * of components is one more than the no of '/').
+		 */
+		remaining = i + len + 1;
+	}
+
+	while (remaining--) {
+		char *p = strrchr(start, '/');
+		if (p == NULL)
+			die(_("ref '%s' does not have %d components to :rstrip"),
+			  refname, len);
+		else
+			p[0] = '\0';
+	}
+	return start;
+}
+
 static const char *show_ref(struct refname_atom *atom, const char *refname)
 {
 	if (atom->option == R_SHORT)
 		return shorten_unambiguous_ref(refname, warn_ambiguous_refs);
 	else if (atom->option == R_LSTRIP)
 		return lstrip_ref_components(refname, atom->lstrip);
+	else if (atom->option == R_RSTRIP)
+		return rstrip_ref_components(refname, atom->rstrip);
 	else
 		return refname;
 }
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 26adca8..8d75cef 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -55,14 +55,22 @@ test_atom head refname:lstrip=1 heads/master
 test_atom head refname:lstrip=2 master
 test_atom head refname:lstrip=-1 master
 test_atom head refname:lstrip=-2 heads/master
+test_atom head refname:rstrip=1 refs/heads
+test_atom head refname:rstrip=2 refs
+test_atom head refname:rstrip=-1 refs
+test_atom head refname:rstrip=-2 refs/heads
 test_atom head upstream refs/remotes/origin/master
 test_atom head upstream:short origin/master
 test_atom head upstream:lstrip=2 origin/master
 test_atom head upstream:lstrip=-2 origin/master
+test_atom head upstream:rstrip=2 refs/remotes
+test_atom head upstream:rstrip=-2 refs/remotes
 test_atom head push refs/remotes/myfork/master
 test_atom head push:short myfork/master
 test_atom head push:lstrip=1 remotes/myfork/master
 test_atom head push:lstrip=-1 master
+test_atom head push:rstrip=1 refs/remotes/myfork
+test_atom head push:rstrip=-1 refs
 test_atom head objecttype commit
 test_atom head objectsize 171
 test_atom head objectname $(git rev-parse refs/heads/master)
@@ -150,6 +158,11 @@ test_expect_success 'stripping refnames too far gives an error' '
 	test_must_fail git for-each-ref --format="%(refname:lstrip=-4)"
 '
 
+test_expect_success 'stripping refnames too far gives an error' '
+	test_must_fail git for-each-ref --format="%(refname:rstrip=3)" &&
+	test_must_fail git for-each-ref --format="%(refname:rstrip=-4)"
+'
+
 test_expect_success 'Check format specifiers are ignored in naming date atoms' '
 	git for-each-ref --format="%(authordate)" refs/heads &&
 	git for-each-ref --format="%(authordate:default) %(authordate)" refs/heads &&
@@ -611,4 +624,15 @@ test_expect_success 'Verify usage of %(symref:lstrip) atom' '
 	test_cmp expected actual
 '
 
+cat >expected <<EOF
+refs
+refs/heads
+EOF
+
+test_expect_success 'Verify usage of %(symref:rstrip) atom' '
+	git for-each-ref --format="%(symref:rstrip=2)" refs/heads/sym > actual &&
+	git for-each-ref --format="%(symref:rstrip=-2)" refs/heads/sym >> actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.10.2

