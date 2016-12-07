Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A08D20259
	for <e@80x24.org>; Wed,  7 Dec 2016 15:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753276AbcLGPgw (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 10:36:52 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34250 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751427AbcLGPgv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 10:36:51 -0500
Received: by mail-pg0-f66.google.com with SMTP id e9so23774578pgc.1
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 07:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=wWRpwnMkabEiZh/j31hNlEgYybFUhfgS3mtmA/vVY/w=;
        b=NBN/D0xIsvi6x3NrCQgNPuZ8lV0W1YTBPPWiD1twZ1gd5Zn6SB4dl9q9ArbRfqfmP3
         OK5LU++TLMHn4Oz4bc3ABYVuq9a+krOejVN7K1yQEXgShqgm0sSwuhvsQ5Uem/YsCCcf
         6dKcYKFE5rRT3QPaacR6TL9W1wZhCDLTmBF/RIdX7AssDPPE8ApWsAPXjp9iLX7ZlLyg
         vv9A0ghZLaZ0jfhGeIL4F0narp4Cq0rGLAXrOJaaS6Rqz8D16e038QJm5SJn5W9q7vGQ
         xsQ1mbpM8rKFpild+fXddediK+BNWDE6BP3PiIv5QjGuNSc/+xWJLgVNktExjBGYgAZI
         u4ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wWRpwnMkabEiZh/j31hNlEgYybFUhfgS3mtmA/vVY/w=;
        b=JT+m8oAy3FfZRMbY+n9apavEuyP5/c0cFdSNUhrnYNhb/G3l0rcirpwE0JkhLY5kPp
         JnaJxImVEEHXZKeQVccoMIXGZui/zaLlngstwAY7Yb0n2pmWmW4JziGIFE4vihu1G9np
         GDqSMXUWsm+sM2dYozqH2aBGu2vmOgaFCDgzoe5SmztbD4cBJk6+WaSqiyGC1I288XIE
         gFB+1nqfKMDmYro99cAWPG6eUMTYwBWaHcz78c/+De6Ho/p24J/e6Tm1qsAHB82hT/Je
         e8umiTpqnrXS3V6gv24xz7ozIR+iwvnky97pgnk/SzXNL67cK7NTO7Zo+ip30zxZnSyG
         nSwg==
X-Gm-Message-State: AKaTC01vr8MpGd5ONvJyiApmz/jv3g2CoEdZqU4Pij60NNxL2pAknYQLpMC0SL2w3TXf1g==
X-Received: by 10.99.56.82 with SMTP id h18mr120216101pgn.55.1481124961069;
        Wed, 07 Dec 2016 07:36:01 -0800 (PST)
Received: from AamlaJuice.corp.endurance.com ([122.15.255.69])
        by smtp.gmail.com with ESMTPSA id l7sm43584459pfg.35.2016.12.07.07.35.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Dec 2016 07:36:00 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, gitster@pobox.com, jnareb@gmail.com,
        Karthik Nayak <Karthik.188@gmail.com>
Subject: [PATCH v8 00/19] port branch.c to use ref-filter's printing options
Date:   Wed,  7 Dec 2016 21:06:08 +0530
Message-Id: <20161207153627.1468-1-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is part of unification of the commands 'git tag -l, git branch -l
and git for-each-ref'. This ports over branch.c to use ref-filter's
printing options.

Initially posted here: $(gmane/279226). It was decided that this series
would follow up after refactoring ref-filter parsing mechanism, which
is now merged into master (9606218b32344c5c756f7c29349d3845ef60b80c).

v1 can be found here: $(gmane/288342)
v2 can be found here: $(gmane/288863)
v3 can be found here: $(gmane/290299)
v4 can be found here: $(gmane/291106)
v5b can be found here: $(gmane/292467)
v6 can be found here: http://marc.info/?l=git&m=146330914118766&w=2
v7 can be found here: http://marc.info/?l=git&m=147863593317362&w=2

Changes in this version:

1. use an enum for holding the comparision type in
%(if:[equals/notequals=...]) options.
2. rename the 'strip' option to 'lstrip' and introduce an 'rstrip'
option. Also modify them to take negative values. This drops the
':dri' and ':base' options.
3. Drop unecessary code.
4. Cleanup code and fix spacing.
5. Add more comments wherever required.
6. Add quote_literal_for_format(const char *s) for safer string
insertions in branch.c:build_format().

Thanks to Jacob, Jackub, Junio and Matthieu for their inputs on the
previous version.

Interdiff below.

Karthik Nayak (19):
  ref-filter: implement %(if), %(then), and %(else) atoms
  ref-filter: include reference to 'used_atom' within 'atom_value'
  ref-filter: implement %(if:equals=<string>) and
    %(if:notequals=<string>)
  ref-filter: modify "%(objectname:short)" to take length
  ref-filter: move get_head_description() from branch.c
  ref-filter: introduce format_ref_array_item()
  ref-filter: make %(upstream:track) prints "[gone]" for invalid
    upstreams
  ref-filter: add support for %(upstream:track,nobracket)
  ref-filter: make "%(symref)" atom work with the ':short' modifier
  ref-filter: introduce refname_atom_parser_internal()
  ref-filter: introduce refname_atom_parser()
  ref-filter: make remote_ref_atom_parser() use
    refname_atom_parser_internal()
  ref-filter: rename the 'strip' option to 'lstrip'
  ref-filter: modify the 'lstrip=<N>' option to work with negative '<N>'
  ref-filter: add an 'rstrip=<N>' option to atoms which deal with
    refnames
  ref-filter: allow porcelain to translate messages in the output
  branch, tag: use porcelain output
  branch: use ref-filter printing APIs
  branch: implement '--format' option

 Documentation/git-branch.txt       |   7 +-
 Documentation/git-for-each-ref.txt |  86 +++++--
 builtin/branch.c                   | 290 +++++++---------------
 builtin/tag.c                      |   6 +-
 ref-filter.c                       | 488 +++++++++++++++++++++++++++++++------
 ref-filter.h                       |   7 +
 t/t3203-branch-output.sh           |  16 +-
 t/t6040-tracking-info.sh           |   2 +-
 t/t6300-for-each-ref.sh            |  88 ++++++-
 t/t6302-for-each-ref-filter.sh     |  94 +++++++
 10 files changed, 784 insertions(+), 300 deletions(-)

Interdiff:

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index f4ad297..c72baeb 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -92,13 +92,14 @@ refname::
 	The name of the ref (the part after $GIT_DIR/).
 	For a non-ambiguous short name of the ref append `:short`.
 	The option core.warnAmbiguousRefs is used to select the strict
-	abbreviation mode. If `strip=<N>` is appended, strips `<N>`
-	slash-separated path components from the front of the refname
-	(e.g., `%(refname:strip=2)` turns `refs/tags/foo` into `foo`.
-	`<N>` must be a positive integer.  If a displayed ref has fewer
-	components than `<N>`, the command aborts with an error. For the base
-	directory of the ref (i.e. foo in refs/foo/bar/boz) append
-	`:base`. For the entire directory path append `:dir`.
+	abbreviation mode. If `lstrip=<N>` or `rstrip=<N>` option can
+	be appended to strip `<N>` slash-separated path components
+	from or end of the refname respectively (e.g.,
+	`%(refname:lstrip=2)` turns `refs/tags/foo` into `foo` and
+	`%(refname:rstrip=2)` turns `refs/tags/foo` into `refs`).  if
+	`<N>` is a negative number, then only `<N>` path components
+	are left behind.  If a displayed ref has fewer components than
+	`<N>`, the command aborts with an error.
 
 objecttype::
 	The type of the object (`blob`, `tree`, `commit`, `tag`).
@@ -113,11 +114,10 @@ objectname::
 	`:short=<length>`, where the minimum length is MINIMUM_ABBREV. The
 	length may be exceeded to ensure unique object names.
 
-
 upstream::
 	The name of a local ref which can be considered ``upstream''
-	from the displayed ref. Respects `:short`, `:strip`, `:base`
-	and `:dir` in the same way as `refname` above.  Additionally
+	from the displayed ref. Respects `:short`, `:lstrip` and
+	`:rstrip` in the same way as `refname` above.  Additionally
 	respects `:track` to show "[ahead N, behind M]" and
 	`:trackshort` to show the terse version: ">" (ahead), "<"
 	(behind), "<>" (ahead and behind), or "=" (in sync). `:track`
@@ -125,14 +125,16 @@ upstream::
 	encountered. Append `:track,nobracket` to show tracking
 	information without brackets (i.e "ahead N, behind M").  Has
 	no effect if the ref does not have tracking information
-	associated with it.
+	associated with it.  All the options apart from `nobracket`
+	are mutually exclusive, but if used together the last option
+	is selected.
 
 push::
 	The name of a local ref which represents the `@{push}`
-	location for the displayed ref. Respects `:short`, `:strip`,
-	`:track`, `:trackshort`, `:base` and `:dir` options as
-	`upstream` does. Produces an empty string if no `@{push}` ref
-	is configured.
+	location for the displayed ref. Respects `:short`, `:lstrip`,
+	`:rstrip`, `:track`, and `:trackshort` options as `upstream`
+	does. Produces an empty string if no `@{push}` ref is
+	configured.
 
 HEAD::
 	'*' if HEAD matches current ref (the checked out branch), ' '
@@ -158,7 +160,7 @@ align::
 	quoting.
 
 if::
-	Used as %(if)...%(then)...(%end) or
+	Used as %(if)...%(then)...%(end) or
 	%(if)...%(then)...%(else)...%(end).  If there is an atom with
 	value or string literal after the %(if) then everything after
 	the %(then) is printed, else if the %(else) atom is used, then
@@ -173,8 +175,8 @@ if::
 symref::
 	The ref which the given symbolic ref refers to. If not a
 	symbolic ref, nothing is printed. Respects the `:short`,
-	`:strip`, `:base` and `:dir` options in the same way as
-	`refname` above.
+	`:lstrip` and `:rstrip` options in the same way as `refname`
+	above.
 
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
@@ -214,12 +216,6 @@ values the `--date` option to linkgit:git-rev-list[1] takes).
 Some atoms like %(align) and %(if) always require a matching %(end).
 We call them "opening atoms" and sometimes denote them as %($open).
 
-When a scripting language specific quoting is in effect (i.e. one of
-`--shell`, `--perl`, `--python`, `--tcl` is used), except for opening
-atoms, replacement from every %(atom) is quoted when and only when it
-appears at the top-level (that is, when it appears outside
-%($open)...%(end)).
-
 When a scripting language specific quoting is in effect, everything
 between a top-level opening atom and its matching %(end) is evaluated
 according to the semantics of the opening atom and its result is
diff --git a/builtin/branch.c b/builtin/branch.c
index acadb99..6393c3c 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -306,16 +306,36 @@ static int calc_maxwidth(struct ref_array *refs, int remote_bonus)
 	return max;
 }
 
+const char *quote_literal_for_format(const char *s)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	strbuf_reset(&buf);
+	while (*s) {
+		const char *ep = strchrnul(s, '%');
+		if (s < ep)
+			strbuf_add(&buf, s, ep - s);
+		if (*ep == '%') {
+			strbuf_addstr(&buf, "%%");
+			s = ep + 1;
+		} else {
+			s = ep;
+		}
+	}
+	return buf.buf;
+}
+
 static char *build_format(struct ref_filter *filter, int maxwidth, const char *remote_prefix)
 {
 	struct strbuf fmt = STRBUF_INIT;
 	struct strbuf local = STRBUF_INIT;
 	struct strbuf remote = STRBUF_INIT;
 
-	strbuf_addf(&fmt, "%%(if)%%(HEAD)%%(then)* %s%%(else)  %%(end)", branch_get_color(BRANCH_COLOR_CURRENT));
+	strbuf_addf(&fmt, "%%(if)%%(HEAD)%%(then)* %s%%(else)  %%(end)",
+		    branch_get_color(BRANCH_COLOR_CURRENT));
 
 	if (filter->verbose) {
-		strbuf_addf(&local, "%%(align:%d,left)%%(refname:strip=2)%%(end)", maxwidth);
+		strbuf_addf(&local, "%%(align:%d,left)%%(refname:lstrip=2)%%(end)", maxwidth);
 		strbuf_addf(&local, "%s", branch_get_color(BRANCH_COLOR_RESET));
 		strbuf_addf(&local, " %%(objectname:short=7) ");
 
@@ -326,18 +346,19 @@ static char *build_format(struct ref_filter *filter, int maxwidth, const char *r
 		else
 			strbuf_addf(&local, "%%(if)%%(upstream:track)%%(then)%%(upstream:track) %%(end)%%(contents:subject)");
 
-		strbuf_addf(&remote, "%s%%(align:%d,left)%s%%(refname:strip=2)%%(end)%s%%(if)%%(symref)%%(then) -> %%(symref:short)"
+		strbuf_addf(&remote, "%s%%(align:%d,left)%s%%(refname:lstrip=2)%%(end)%s%%(if)%%(symref)%%(then) -> %%(symref:short)"
 			    "%%(else) %%(objectname:short=7) %%(contents:subject)%%(end)",
-			    branch_get_color(BRANCH_COLOR_REMOTE), maxwidth,
-			    remote_prefix, branch_get_color(BRANCH_COLOR_RESET));
+			    branch_get_color(BRANCH_COLOR_REMOTE), maxwidth, quote_literal_for_format(remote_prefix),
+			    branch_get_color(BRANCH_COLOR_RESET));
 	} else {
-		strbuf_addf(&local, "%%(refname:strip=2)%s%%(if)%%(symref)%%(then) -> %%(symref:short)%%(end)",
+		strbuf_addf(&local, "%%(refname:lstrip=2)%s%%(if)%%(symref)%%(then) -> %%(symref:short)%%(end)",
+			    branch_get_color(BRANCH_COLOR_RESET));
+		strbuf_addf(&remote, "%s%s%%(refname:lstrip=2)%s%%(if)%%(symref)%%(then) -> %%(symref:short)%%(end)",
+			    branch_get_color(BRANCH_COLOR_REMOTE), quote_literal_for_format(remote_prefix),
 			    branch_get_color(BRANCH_COLOR_RESET));
-		strbuf_addf(&remote, "%s%s%%(refname:strip=2)%s%%(if)%%(symref)%%(then) -> %%(symref:short)%%(end)",
-			    branch_get_color(BRANCH_COLOR_REMOTE), remote_prefix, branch_get_color(BRANCH_COLOR_RESET));
 	}
 
-	strbuf_addf(&fmt, "%%(if:notequals=remotes)%%(refname:base)%%(then)%s%%(else)%s%%(end)", local.buf, remote.buf);
+	strbuf_addf(&fmt, "%%(if:notequals=refs/remotes)%%(refname:rstrip=-2)%%(then)%s%%(else)%s%%(end)", local.buf, remote.buf);
 
 	strbuf_release(&local);
 	strbuf_release(&remote);
@@ -682,7 +703,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		 * create_branch takes care of setting up the tracking
 		 * info and making sure new_upstream is correct
 		 */
-		create_branch(head, branch->name, new_upstream, 0, 0, 0, quiet, BRANCH_TRACK_OVERRIDE);
+		create_branch(branch->name, new_upstream, 0, 0, 0, quiet, BRANCH_TRACK_OVERRIDE);
 	} else if (unset_upstream) {
 		struct branch *branch = branch_get(argv[0]);
 		struct strbuf buf = STRBUF_INIT;
@@ -728,7 +749,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		strbuf_release(&buf);
 
 		branch_existed = ref_exists(branch->refname);
-		create_branch(head, argv[0], (argc == 2) ? argv[1] : head,
+		create_branch(argv[0], (argc == 2) ? argv[1] : head,
 			      force, reflog, 0, quiet, track);
 
 		/*
diff --git a/ref-filter.c b/ref-filter.c
index 944671a..a68ed7b 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -21,6 +21,7 @@ static struct ref_msg {
 	const char *behind;
 	const char *ahead_behind;
 } msgs = {
+	 /* Untranslated plumbing messages: */
 	"gone",
 	"ahead %d",
 	"behind %d",
@@ -36,6 +37,7 @@ void setup_ref_filter_porcelain_msg(void)
 }
 
 typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
+typedef enum { COMPARE_EQUAL, COMPARE_UNEQUAL, COMPARE_NONE } cmp_status;
 
 struct align {
 	align_type position;
@@ -43,16 +45,16 @@ struct align {
 };
 
 struct if_then_else {
-	const char *if_equals,
-		*not_equals;
+	cmp_status cmp_status;
+	const char *str;
 	unsigned int then_atom_seen : 1,
 		else_atom_seen : 1,
 		condition_satisfied : 1;
 };
 
 struct refname_atom {
-	enum { R_BASE, R_DIR, R_NORMAL, R_SHORT, R_STRIP } option;
-	unsigned int strip;
+	enum { R_NORMAL, R_SHORT, R_LSTRIP, R_RSTRIP } option;
+	int lstrip, rstrip;
 };
 
 /*
@@ -81,8 +83,8 @@ static struct used_atom {
 			unsigned int nlines;
 		} contents;
 		struct {
-			const char *if_equals,
-				*not_equals;
+			cmp_status cmp_status;
+			const char *str;
 		} if_then_else;
 		struct {
 			enum { O_FULL, O_LENGTH, O_SHORT } option;
@@ -109,15 +111,15 @@ static void refname_atom_parser_internal(struct refname_atom *atom,
 		atom->option = R_NORMAL;
 	else if (!strcmp(arg, "short"))
 		atom->option = R_SHORT;
-	else if (skip_prefix(arg, "strip=", &arg)) {
-		atom->option = R_STRIP;
-		if (strtoul_ui(arg, 10, &atom->strip) || atom->strip <= 0)
-			die(_("positive value expected refname:strip=%s"), arg);
-	} else if (!strcmp(arg, "dir"))
-		atom->option = R_DIR;
-	else if (!strcmp(arg, "base"))
-		atom->option = R_BASE;
-	else
+	else if (skip_prefix(arg, "lstrip=", &arg)) {
+		atom->option = R_LSTRIP;
+		if (strtol_i(arg, 10, &atom->lstrip))
+			die(_("Integer value expected refname:lstrip=%s"), arg);
+	} else if (skip_prefix(arg, "rstrip=", &arg)) {
+		atom->option = R_RSTRIP;
+		if (strtol_i(arg, 10, &atom->rstrip))
+			die(_("Integer value expected refname:rstrip=%s"), arg);
+	} else
 		die(_("unrecognized %%(%s) argument: %s"), name, arg);
 }
 
@@ -204,11 +206,6 @@ static void objectname_atom_parser(struct used_atom *atom, const char *arg)
 		die(_("unrecognized %%(objectname) argument: %s"), arg);
 }
 
-static void symref_atom_parser(struct used_atom *atom, const char *arg)
-{
-	return refname_atom_parser_internal(&atom->u.refname, arg, atom->name);
-}
-
 static void refname_atom_parser(struct used_atom *atom, const char *arg)
 {
 	return refname_atom_parser_internal(&atom->u.refname, arg, atom->name);
@@ -266,16 +263,19 @@ static void align_atom_parser(struct used_atom *atom, const char *arg)
 
 static void if_atom_parser(struct used_atom *atom, const char *arg)
 {
-	if (!arg)
+	if (!arg) {
+		atom->u.if_then_else.cmp_status = COMPARE_NONE;
 		return;
-	else if (skip_prefix(arg, "equals=", &atom->u.if_then_else.if_equals))
-		 ;
-	else if (skip_prefix(arg, "notequals=", &atom->u.if_then_else.not_equals))
-		;
-	else
+	} else if (skip_prefix(arg, "equals=", &atom->u.if_then_else.str)) {
+		atom->u.if_then_else.cmp_status = COMPARE_EQUAL;
+	} else if (skip_prefix(arg, "notequals=", &atom->u.if_then_else.str)) {
+		atom->u.if_then_else.cmp_status = COMPARE_UNEQUAL;
+	} else {
 		die(_("unrecognized %%(if) argument: %s"), arg);
+	}
 }
 
+
 static struct {
 	const char *name;
 	cmp_type cmp_type;
@@ -310,7 +310,7 @@ static struct {
 	{ "contents", FIELD_STR, contents_atom_parser },
 	{ "upstream", FIELD_STR, remote_ref_atom_parser },
 	{ "push", FIELD_STR, remote_ref_atom_parser },
-	{ "symref", FIELD_STR, symref_atom_parser },
+	{ "symref", FIELD_STR, refname_atom_parser },
 	{ "flag" },
 	{ "HEAD" },
 	{ "color", FIELD_STR, color_atom_parser },
@@ -501,12 +501,13 @@ static void if_then_else_handler(struct ref_formatting_stack **stack)
 			strbuf_reset(&cur->output);
 			pop_stack_element(&cur);
 		}
-	} else if (!if_then_else->condition_satisfied)
+	} else if (!if_then_else->condition_satisfied) {
 		/*
 		 * No %(else) atom: just drop the %(then) branch if the
 		 * condition is not satisfied.
 		 */
 		strbuf_reset(&cur->output);
+	}
 
 	*stack = cur;
 	free(if_then_else);
@@ -517,8 +518,8 @@ static void if_atom_handler(struct atom_value *atomv, struct ref_formatting_stat
 	struct ref_formatting_stack *new;
 	struct if_then_else *if_then_else = xcalloc(sizeof(struct if_then_else), 1);
 
-	if_then_else->if_equals = atomv->atom->u.if_then_else.if_equals;
-	if_then_else->not_equals = atomv->atom->u.if_then_else.not_equals;
+	if_then_else->str = atomv->atom->u.if_then_else.str;
+	if_then_else->cmp_status = atomv->atom->u.if_then_else.cmp_status;
 
 	push_stack_element(&state->stack);
 	new = state->stack;
@@ -555,11 +556,11 @@ static void then_atom_handler(struct atom_value *atomv, struct ref_formatting_st
 	 * perform the required comparison. If not, only non-empty
 	 * strings satisfy the 'if' condition.
 	 */
-	if (if_then_else->if_equals) {
-		if (!strcmp(if_then_else->if_equals, cur->output.buf))
+	if (if_then_else->cmp_status == COMPARE_EQUAL) {
+		if (!strcmp(if_then_else->str, cur->output.buf))
 			if_then_else->condition_satisfied = 1;
-	} else 	if (if_then_else->not_equals) {
-		if (strcmp(if_then_else->not_equals, cur->output.buf))
+	} else 	if (if_then_else->cmp_status == COMPARE_UNEQUAL) {
+		if (strcmp(if_then_else->str, cur->output.buf))
 			if_then_else->condition_satisfied = 1;
 	} else if (cur->output.len && !is_empty(cur->output.buf))
 		if_then_else->condition_satisfied = 1;
@@ -1095,21 +1096,68 @@ static inline char *copy_advance(char *dst, const char *src)
 	return dst;
 }
 
-static const char *strip_ref_components(const char *refname, unsigned int len)
+static const char *lstrip_ref_components(const char *refname, int len)
 {
 	long remaining = len;
 	const char *start = refname;
 
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
 	while (remaining) {
 		switch (*start++) {
 		case '\0':
-			die(_("ref '%s' does not have %ud components to :strip"),
+			die(_("ref '%s' does not have %d components to :lstrip"),
 			    refname, len);
 		case '/':
 			remaining--;
 			break;
 		}
 	}
+
+	return start;
+}
+
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
 	return start;
 }
 
@@ -1117,27 +1165,11 @@ static const char *show_ref(struct refname_atom *atom, const char *refname)
 {
 	if (atom->option == R_SHORT)
 		return shorten_unambiguous_ref(refname, warn_ambiguous_refs);
-	else if (atom->option == R_STRIP)
-		return strip_ref_components(refname, atom->strip);
-	else if (atom->option == R_BASE) {
-		const char *sp, *ep;
-
-		if (skip_prefix(refname, "refs/", &sp)) {
-			ep = strchr(sp, '/');
-			if (!ep)
-				return "";
-			return xstrndup(sp, ep - sp);
-		}
-		return "";
-	} else if (atom->option == R_DIR) {
-		const char *sp, *ep;
-
-		sp = refname;
-		ep = strrchr(sp, '/');
-		if (!ep)
-			return "";
-		return xstrndup(sp, ep - sp);
-	} else
+	else if (atom->option == R_LSTRIP)
+		return lstrip_ref_components(refname, atom->lstrip);
+	else if (atom->option == R_RSTRIP)
+		return rstrip_ref_components(refname, atom->rstrip);
+	else
 		return refname;
 }
 
@@ -1318,7 +1350,7 @@ static void populate_value(struct ref_array_item *ref)
 
 			head = resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
 						  sha1, NULL);
-			if (!strcmp(ref->refname, head))
+			if (head && !strcmp(ref->refname, head))
 				v->s = "*";
 			else
 				v->s = " ";
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 8ff6568..8d75cef 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -51,20 +51,26 @@ test_atom() {
 
 test_atom head refname refs/heads/master
 test_atom head refname:short master
-test_atom head refname:strip=1 heads/master
-test_atom head refname:strip=2 master
-test_atom head refname:dir refs/heads
-test_atom head refname:base heads
+test_atom head refname:lstrip=1 heads/master
+test_atom head refname:lstrip=2 master
+test_atom head refname:lstrip=-1 master
+test_atom head refname:lstrip=-2 heads/master
+test_atom head refname:rstrip=1 refs/heads
+test_atom head refname:rstrip=2 refs
+test_atom head refname:rstrip=-1 refs
+test_atom head refname:rstrip=-2 refs/heads
 test_atom head upstream refs/remotes/origin/master
 test_atom head upstream:short origin/master
-test_atom head upstream:strip=2 origin/master
-test_atom head upstream:dir refs/remotes/origin
-test_atom head upstream:base remotes
+test_atom head upstream:lstrip=2 origin/master
+test_atom head upstream:lstrip=-2 origin/master
+test_atom head upstream:rstrip=2 refs/remotes
+test_atom head upstream:rstrip=-2 refs/remotes
 test_atom head push refs/remotes/myfork/master
 test_atom head push:short myfork/master
-test_atom head push:strip=1 remotes/myfork/master
-test_atom head push:dir refs/remotes/myfork
-test_atom head push:base remotes
+test_atom head push:lstrip=1 remotes/myfork/master
+test_atom head push:lstrip=-1 master
+test_atom head push:rstrip=1 refs/remotes/myfork
+test_atom head push:rstrip=-1 refs
 test_atom head objecttype commit
 test_atom head objectsize 171
 test_atom head objectname $(git rev-parse refs/heads/master)
@@ -147,14 +153,14 @@ test_expect_success 'Check invalid atoms names are errors' '
 	test_must_fail git for-each-ref --format="%(INVALID)" refs/heads
 '
 
-test_expect_success 'arguments to :strip must be positive integers' '
-	test_must_fail git for-each-ref --format="%(refname:strip=0)" &&
-	test_must_fail git for-each-ref --format="%(refname:strip=-1)" &&
-	test_must_fail git for-each-ref --format="%(refname:strip=foo)"
+test_expect_success 'stripping refnames too far gives an error' '
+	test_must_fail git for-each-ref --format="%(refname:lstrip=3)" &&
+	test_must_fail git for-each-ref --format="%(refname:lstrip=-4)"
 '
 
 test_expect_success 'stripping refnames too far gives an error' '
-	test_must_fail git for-each-ref --format="%(refname:strip=3)"
+	test_must_fail git for-each-ref --format="%(refname:rstrip=3)" &&
+	test_must_fail git for-each-ref --format="%(refname:rstrip=-4)"
 '
 
 test_expect_success 'Check format specifiers are ignored in naming date atoms' '
@@ -575,6 +581,16 @@ test_expect_success 'Verify sort with multiple keys' '
 	test_cmp expected actual
 '
 
+
+test_expect_success 'do not dereference NULL upon %(HEAD) on unborn branch' '
+	test_when_finished "git checkout master" &&
+	git for-each-ref --format="%(HEAD) %(refname:short)" refs/heads/ >actual &&
+	sed -e "s/^\* /  /" actual >expect &&
+	git checkout --orphan HEAD &&
+	git for-each-ref --format="%(HEAD) %(refname:short)" refs/heads/ >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'Add symbolic ref for the following tests' '
 	git symbolic-ref refs/heads/sym refs/heads/master
 '
@@ -584,7 +600,7 @@ refs/heads/master
 EOF
 
 test_expect_success 'Verify usage of %(symref) atom' '
-	git for-each-ref --format="%(symref)" refs/heads/sym > actual &&
+	git for-each-ref --format="%(symref)" refs/heads/sym >actual &&
 	test_cmp expected actual
 '
 
@@ -593,34 +609,29 @@ heads/master
 EOF
 
 test_expect_success 'Verify usage of %(symref:short) atom' '
-	git for-each-ref --format="%(symref:short)" refs/heads/sym > actual &&
+	git for-each-ref --format="%(symref:short)" refs/heads/sym >actual &&
 	test_cmp expected actual
 '
 
 cat >expected <<EOF
 master
+heads/master
 EOF
 
-test_expect_success 'Verify usage of %(symref:strip) atom' '
-	git for-each-ref --format="%(symref:strip=2)" refs/heads/sym > actual &&
+test_expect_success 'Verify usage of %(symref:lstrip) atom' '
+	git for-each-ref --format="%(symref:lstrip=2)" refs/heads/sym > actual &&
+	git for-each-ref --format="%(symref:lstrip=-2)" refs/heads/sym >> actual &&
 	test_cmp expected actual
 '
 
 cat >expected <<EOF
+refs
 refs/heads
 EOF
 
-test_expect_success 'Verify usage of %(symref:dir) atom' '
-	git for-each-ref --format="%(symref:dir)" refs/heads/sym > actual &&
-	test_cmp expected actual
-'
-
-cat >expected <<EOF
-heads
-EOF
-
-test_expect_success 'Verify usage of %(symref:base) atom' '
-	git for-each-ref --format="%(symref:base)" refs/heads/sym > actual &&
+test_expect_success 'Verify usage of %(symref:rstrip) atom' '
+	git for-each-ref --format="%(symref:rstrip=2)" refs/heads/sym > actual &&
+	git for-each-ref --format="%(symref:rstrip=-2)" refs/heads/sym >> actual &&
 	test_cmp expected actual
 '


-- 
2.10.2

