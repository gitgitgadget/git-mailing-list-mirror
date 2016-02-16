From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 00/12]  ref-filter: use parsing functions
Date: Wed, 17 Feb 2016 00:30:03 +0530
Message-ID: <1455649215-23260-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 19:59:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVkqc-0007xN-EP
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 19:59:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755498AbcBPS7i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 13:59:38 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33908 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753079AbcBPS7h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 13:59:37 -0500
Received: by mail-pf0-f174.google.com with SMTP id x65so109751138pfb.1
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 10:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=TMc0621B3v6DqV9dp3YA01zyZCoaKGZYn9xcDBXRS+g=;
        b=0walrHBOViackFN3hDIlIzqTpuKOrHkDKgABaDeBXMEaCb0G94CaH8jQJHpdtOUAOp
         P+13PPyX3LjNZwyrqIJf/G4yKgjSLMvfkoa29M1UvPHcWzWTNe+qi8jpLqdECX4YsPBf
         0CMMZVYuZ3McvSqBWs0NzzigCGzfR4wXgrbe3XR5ESHXzX+eacHX7t/cmWDhtm5RBM9J
         3NtoBGI0FvETxLsrXM/ATG2wckoHh019D2rpEw72lwiHL17Dbqndmilg9M7v4DtmmdAt
         c4UO8V8yh8pb09gTEAV7c4zbwWhRVk/oZHiNOtJtsFbOOhkWr6mnPNgO+R0tQ8tHVJcs
         b2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TMc0621B3v6DqV9dp3YA01zyZCoaKGZYn9xcDBXRS+g=;
        b=hsOtNGY7kqvwVZGgcxWA37yecbRetbKXQfrps58QF7wSCYoVwoCXk9lqC7kUeecvsc
         ObaK98PekN812RNx41jEera9LTTL04+K/Sx8PcrU6bohpn05D6Jz+oZKl8+nuQW5dhKR
         BVme+ETyAK57FA9EaDYzh/i9EFOiTZWzNB5ORCMcN1NDKPvjj7VguYb4ZWf4twd3vyDA
         vT7LZCOGSU1BvbR0ubq1m6U1ISHD6E6HLBZZAmx1M2wP9YNjoV8zwHOOIkwehTv+4GIU
         JLRKJm9Z8jnEjLAnx69RKirrqp9BOp3VO7jD8taO9qQQezle95h54zSEnu8g72l959XY
         WVWA==
X-Gm-Message-State: AG10YOS+Ou5D1L3vDnUTWtLOBzpplJVLy7Y12z98jnXZUsyyafQ1pqvTE4b5Ww5LDFInhQ==
X-Received: by 10.98.68.73 with SMTP id r70mr33615762pfa.136.1455649176877;
        Tue, 16 Feb 2016 10:59:36 -0800 (PST)
Received: from ashley.localdomain ([106.51.133.38])
        by smtp.gmail.com with ESMTPSA id 27sm47469677pfh.48.2016.02.16.10.59.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Feb 2016 10:59:36 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286414>

This series cleans up populate_value() in ref-filter, by moving out
the parsing part of atoms to separate parsing functions. This ensures
that parsing is only done once and also improves the modularity of the
code.

v1: http://thread.gmane.org/gmane.comp.version-control.git/281180
v2: http://thread.gmane.org/gmane.comp.version-control.git/282563
v3: http://thread.gmane.org/gmane.comp.version-control.git/283350
v4: http://thread.gmane.org/gmane.comp.version-control.git/285158

Changes:
* Fixed small errors in multiple 'die(..)' messages.
* Removed unecessary braces.
* In parse_align_position() use 'v', 's' to denote the vector of arguments
and individual argument respectively rather than re-using 'arg'.
* Fix error in parse_ref_filter_atom() where length of current atom wasn't
accurately calculated.
* Small code and indentation fixes

Thanks to Eric, Junio, Ramsay and Andreas for their comments on the previous
version. And everyone else who helped review the previous patch series.

Karthik Nayak (12):
  strbuf: introduce strbuf_split_str_omit_term()
  ref-filter: use strbuf_split_str_omit_term()
  ref-filter: bump 'used_atom' and related code to the top
  ref-filter: introduce struct used_atom
  ref-filter: introduce parsing functions for each valid atom
  ref-filter: introduce color_atom_parser()
  ref-filter: introduce parse_align_position()
  ref-filter: introduce align_atom_parser()
  ref-filter: align: introduce long-form syntax
  ref-filter: introduce remote_ref_atom_parser()
  ref-filter: introduce contents_atom_parser()
  ref-filter: introduce objectname_atom_parser()

 Documentation/git-for-each-ref.txt |  20 +-
 ref-filter.c                       | 434 +++++++++++++++++++++----------------
 strbuf.c                           |  14 +-
 strbuf.h                           |  25 ++-
 t/t6302-for-each-ref-filter.sh     |  42 ++++
 5 files changed, 329 insertions(+), 206 deletions(-)

Interdiff:

diff --git a/ref-filter.c b/ref-filter.c
index d48e2a3..21f4937 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -54,14 +54,14 @@ static void color_atom_parser(struct used_atom *atom, const char *color_value)
 	if (!color_value)
 		die(_("expected format: %%(color:<color>)"));
 	if (color_parse(color_value, atom->u.color) < 0)
-		die(_("invalid color value: %s"), atom->u.color);
+		die(_("unrecognized color: %%(color:%s)"), color_value);
 }
 
 static void remote_ref_atom_parser(struct used_atom *atom, const char *arg)
 {
-	if (!arg) {
+	if (!arg)
 		atom->u.remote_ref = RR_NORMAL;
-	} else if (!strcmp(arg, "short"))
+	else if (!strcmp(arg, "short"))
 		atom->u.remote_ref = RR_SHORTEN;
 	else if (!strcmp(arg, "track"))
 		atom->u.remote_ref = RR_TRACK;
@@ -74,14 +74,14 @@ static void remote_ref_atom_parser(struct used_atom *atom, const char *arg)
 static void body_atom_parser(struct used_atom *atom, const char *arg)
 {
 	if (arg)
-		die("%%(body) atom does not take arguments");
+		die("%%(body) does not take arguments");
 	atom->u.contents.option = C_BODY_DEP;
 }
 
 static void subject_atom_parser(struct used_atom *atom, const char *arg)
 {
 	if (arg)
-		die("%%(subject) atom does not take arguments");
+		die("%%(subject) does not take arguments");
 	atom->u.contents.option = C_SUB;
 }
 
@@ -127,34 +127,34 @@ static align_type parse_align_position(const char *s)
 static void align_atom_parser(struct used_atom *atom, const char *arg)
 {
 	struct align *align = &atom->u.align;
-	struct strbuf **s, **to_free;
+	struct strbuf **v, **to_free;
 	unsigned int width = ~0U;
 
 	if (!arg)
 		die(_("expected format: %%(align:<width>,<position>)"));
-	s = to_free = strbuf_split_str_omit_term(arg, ',', 0);
+	v = to_free = strbuf_split_str_omit_term(arg, ',', 0);
 
 	align->position = ALIGN_LEFT;
 
-	while (*s) {
+	while (*v) {
 		int position;
-		arg = s[0]->buf;
+		const char *s = v[0]->buf;
 
-		if (skip_prefix(arg, "position=", &arg)) {
-			position = parse_align_position(arg);
+		if (skip_prefix(s, "position=", &s)) {
+			position = parse_align_position(s);
 			if (position < 0)
-				die(_("unrecognized position:%s"), arg);
+				die(_("unrecognized position:%s"), s);
 			align->position = position;
-		} else if (skip_prefix(arg, "width=", &arg)) {
-			if (strtoul_ui(arg, 10, &width))
-				die(_("unrecognized width:%s"), arg);
-		} else if (!strtoul_ui(arg, 10, &width))
+		} else if (skip_prefix(s, "width=", &s)) {
+			if (strtoul_ui(s, 10, &width))
+				die(_("unrecognized width:%s"), s);
+		} else if (!strtoul_ui(s, 10, &width))
 			;
-		else if ((position = parse_align_position(arg)) >= 0)
+		else if ((position = parse_align_position(s)) >= 0)
 			align->position = position;
 		else
-			die(_("unrecognized %%(align) argument: %s"), arg);
-		s++;
+			die(_("unrecognized %%(align) argument: %s"), s);
+		v++;
 	}
 
 	if (width == ~0U)
@@ -253,6 +253,7 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
 	/* Is the atom a valid one? */
 	for (i = 0; i < ARRAY_SIZE(valid_atom); i++) {
 		int len = strlen(valid_atom[i].name);
+
 		/*
 		 * If the atom name has a colon, strip it and everything after
 		 * it off - it specifies the format for this entry, and
@@ -260,7 +261,7 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
 		 * table.
 		 */
 		arg = memchr(sp, ':', ep - sp);
-		if ((!arg || len == arg - sp) &&
+		if (len == (arg ? arg : ep) - sp &&
 		    !memcmp(valid_atom[i].name, sp, len))
 			break;
 	}
@@ -775,8 +776,8 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
 	unsigned long sublen = 0, bodylen = 0, nonsiglen = 0, siglen = 0;
 
 	for (i = 0; i < used_atom_cnt; i++) {
-		const char *name = used_atom[i].name;
 		struct used_atom *atom = &used_atom[i];
+		const char *name = atom->name;
 		struct atom_value *v = &val[i];
 		if (!!deref != (*name == '*'))
 			continue;
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index f79355d..bcf472b 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -149,8 +149,8 @@ test_align_permutations() {
 	while read -r option
 	do
 		test_expect_success "align:$option" '
-		git for-each-ref --format="|%(align:$option)refname is %(refname)%(end)|%(refname)" >actual &&
-		test_cmp expect actual
+			git for-each-ref --format="|%(align:$option)refname is %(refname)%(end)|%(refname)" >actual &&
+			test_cmp expect actual
 		'
 	done
 }

-- 
2.7.1
