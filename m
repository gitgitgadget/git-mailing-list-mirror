From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 00/12] ref-filter: use parsing functions
Date: Sun, 31 Jan 2016 23:12:44 +0530
Message-ID: <1454262176-6594-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 31 18:43:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPw1b-0008By-5a
	for gcvg-git-2@plane.gmane.org; Sun, 31 Jan 2016 18:42:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbcAaRmV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2016 12:42:21 -0500
Received: from mail-pa0-f67.google.com ([209.85.220.67]:33083 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932066AbcAaRmU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2016 12:42:20 -0500
Received: by mail-pa0-f67.google.com with SMTP id pv5so6144565pac.0
        for <git@vger.kernel.org>; Sun, 31 Jan 2016 09:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=GiXrcJu2Xy2sEHSD+tpXw2boQxc2PZQIRXr1koA1uyg=;
        b=pox3T3us2bR3sjz0Nf8fvPDXRdMnt3VqDclLc1rTADn3Ic7P3rVrsfzF3Vn9KBfLkZ
         OyfUVdGv2lLFjFxYnHmNUnE185Kh1tVkhq47CNI1byEUcsOgJp9bwmEMXqByqEQoImCG
         UxlXejeTny1D9E7kmLhOwu0qDPBg8nHCESNxDmo4gGMWPCZB3ex8qFD+HqhzTF6RcQSt
         fasqUIXrT6ZDR/HCkMrj4rhJr42dB4kXEZPkA8IoLLFSmiH1r/DeWivQHpZqhBoa/3DF
         gO9Y3zHTUCOfOe7NAPcXQ9TudwT5v/aHq1ecn8tiDvE271ajio5Us1S4UlXd3cMe4FFm
         QqyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GiXrcJu2Xy2sEHSD+tpXw2boQxc2PZQIRXr1koA1uyg=;
        b=TQqA+xRPXcCRUmM7Fp62YOz3EDyWNdZUgqE6LBNQRTnW+BBvoxjCT5FPbJczpsRdZr
         W/P6lEpSMY6Osd+z+7uysMjCHpgMd8Ha00Sk4paDt8W267/q/bYIf+8FIzuVfKKmznl6
         vIUwUN3oD/DYO/yx3V5CqFT3+SxBt8dn9a+h4l7ea3HLQkkoZkMOpAIl6NsqnKSyHqJw
         EXKWeDPZX2P4Kfs03Hd2O1LvF3Asb7Cg5sg47jTl/+ixclw4KrVvCVTWS/lIuRIxbMdj
         bMuNoe2281LmveD8rypDv1ilVbXHaXUd2AAZA1MmxWX4Rn2WSvZpG8TQjbvQex4C/JBH
         KFrA==
X-Gm-Message-State: AG10YOR/PVFMXa1dmAvMOSqM+lrbdtekg0zolGxrTlm1WDtwOMxQP9FCzOtAdlysPtf6yA==
X-Received: by 10.66.255.70 with SMTP id ao6mr31352757pad.64.1454262139522;
        Sun, 31 Jan 2016 09:42:19 -0800 (PST)
Received: from ashley.localdomain ([106.51.132.212])
        by smtp.gmail.com with ESMTPSA id v26sm37274012pfi.56.2016.01.31.09.42.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 31 Jan 2016 09:42:18 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285158>

This series cleans up populate_value() in ref-filter, by moving out
the parsing part of atoms to separate parsing functions. This ensures
that parsing is only done once and also improves the modularity of the
code.

v1: http://thread.gmane.org/gmane.comp.version-control.git/281180
v2: http://thread.gmane.org/gmane.comp.version-control.git/282563
v3: http://thread.gmane.org/gmane.comp.version-control.git/283350

Changes:
* The parsing functions now take the arguments of the atom as
function parameteres, instead of parsing it inside the fucntion.
* Rebased on top of pu:jk/list-tag-2.7-regression
* In strbuf use a copylen variable rather than using multiplication
to perform a logical operation.
* Code movement for easier review and general improvement.
* Use COLOR_MAXLEN as the maximum size for the color variable.
* Small code changes.
* Documentation changes.
* Fixed incorrect style of test (t6302).

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

Interdiff:

diff --git a/ref-filter.c b/ref-filter.c
index 7a634e6..d48e2a3 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -35,7 +35,7 @@ static struct used_atom {
 	const char *name;
 	cmp_type type;
 	union {
-		char *color;
+		char color[COLOR_MAXLEN];
 		struct align align;
 		enum { RR_NORMAL, RR_SHORTEN, RR_TRACK, RR_TRACKSHORT }
 			remote_ref;
@@ -49,99 +49,68 @@ static struct used_atom {
 static int used_atom_cnt, need_tagged, need_symref;
 static int need_color_reset_at_eol;
 
-static int match_atom_name(const char *name, const char *atom_name, const char **val)
+static void color_atom_parser(struct used_atom *atom, const char *color_value)
 {
-	const char *body;
-
-	/* skip the deref specifier */
-	if (name[0] == '*')
-		name++;
-
-	if (!skip_prefix(name, atom_name, &body))
-		return 0; /* doesn't even begin with "atom_name" */
-	if (!body[0]) {
-		*val = NULL; /* %(atom_name) and no customization */
-		return 1;
-	}
-	if (body[0] != ':')
-		return 0; /* "atom_namefoo" is not "atom_name" or "atom_name:..." */
-	*val = body + 1; /* "atom_name:val" */
-	return 1;
-}
-
-static void color_atom_parser(struct used_atom *atom)
-{
-	if (!match_atom_name(atom->name, "color", (const char **)&atom->u.color))
-		die("BUG: parsing non-'color'");
-	if (!atom->u.color)
+	if (!color_value)
 		die(_("expected format: %%(color:<color>)"));
-	/* atom->u.color points to part of atom->name */
-	atom->u.color = xstrdup(atom->u.color);
-	if (color_parse(atom->u.color, atom->u.color) < 0)
+	if (color_parse(color_value, atom->u.color) < 0)
 		die(_("invalid color value: %s"), atom->u.color);
 }
 
-static void remote_ref_atom_parser(struct used_atom *atom)
+static void remote_ref_atom_parser(struct used_atom *atom, const char *arg)
 {
-	const char *buf;
-
-	buf = strchr(atom->name, ':');
-	if (!buf) {
+	if (!arg) {
 		atom->u.remote_ref = RR_NORMAL;
-		return;
-	}
-	buf++;
-	if (!strcmp(buf, "short"))
+	} else if (!strcmp(arg, "short"))
 		atom->u.remote_ref = RR_SHORTEN;
-	else if (!strcmp(buf, "track"))
+	else if (!strcmp(arg, "track"))
 		atom->u.remote_ref = RR_TRACK;
-	else if (!strcmp(buf, "trackshort"))
+	else if (!strcmp(arg, "trackshort"))
 		atom->u.remote_ref = RR_TRACKSHORT;
 	else
 		die(_("unrecognized format: %%(%s)"), atom->name);
 }
 
-static void contents_atom_parser(struct used_atom *atom)
+static void body_atom_parser(struct used_atom *atom, const char *arg)
 {
-	const char * buf;
+	if (arg)
+		die("%%(body) atom does not take arguments");
+	atom->u.contents.option = C_BODY_DEP;
+}
 
-	if (match_atom_name(atom->name, "subject", &buf)) {
-		atom->u.contents.option = C_SUB;
-		return;
-	} else if (match_atom_name(atom->name, "body", &buf)) {
-		atom->u.contents.option = C_BODY_DEP;
-		return;
-	} if (!match_atom_name(atom->name, "contents", &buf))
-		  die("BUG: parsing non-'contents'");
+static void subject_atom_parser(struct used_atom *atom, const char *arg)
+{
+	if (arg)
+		die("%%(subject) atom does not take arguments");
+	atom->u.contents.option = C_SUB;
+}
 
-	if (!buf)
+static void contents_atom_parser(struct used_atom *atom, const char *arg)
+{
+	if (!arg)
 		atom->u.contents.option = C_BARE;
-	else if (!strcmp(buf, "body"))
+	else if (!strcmp(arg, "body"))
 		atom->u.contents.option = C_BODY;
-	else if (!strcmp(buf, "signature"))
+	else if (!strcmp(arg, "signature"))
 		atom->u.contents.option = C_SIG;
-	else if (!strcmp(buf, "subject"))
+	else if (!strcmp(arg, "subject"))
 		atom->u.contents.option = C_SUB;
-	else if (skip_prefix(buf, "lines=", &buf)) {
+	else if (skip_prefix(arg, "lines=", &arg)) {
 		atom->u.contents.option = C_LINES;
-		if (strtoul_ui(buf, 10, &atom->u.contents.nlines))
-			die(_("positive value expected contents:lines=%s"), buf);
+		if (strtoul_ui(arg, 10, &atom->u.contents.nlines))
+			die(_("positive value expected contents:lines=%s"), arg);
 	} else
-		die(_("unrecognized %%(contents) argument: %s"), buf);
+		die(_("unrecognized %%(contents) argument: %s"), arg);
 }
 
-static void objectname_atom_parser(struct used_atom *atom)
+static void objectname_atom_parser(struct used_atom *atom, const char *arg)
 {
-	const char * buf;
-
-	if (!match_atom_name(atom->name, "objectname", &buf))
-		die("BUG: parsing non-'objectname'");
-	if (!buf)
+	if (!arg)
 		atom->u.objectname = O_FULL;
-	else if (!strcmp(buf, "short"))
+	else if (!strcmp(arg, "short"))
 		atom->u.objectname = O_SHORT;
 	else
-		die(_("unrecognized %%(objectname) argument: %s"), buf);
+		die(_("unrecognized %%(objectname) argument: %s"), arg);
 }
 
 static align_type parse_align_position(const char *s)
@@ -155,39 +124,36 @@ static align_type parse_align_position(const char *s)
 	return -1;
 }
 
-static void align_atom_parser(struct used_atom *atom)
+static void align_atom_parser(struct used_atom *atom, const char *arg)
 {
 	struct align *align = &atom->u.align;
-	const char *buf = NULL;
 	struct strbuf **s, **to_free;
 	unsigned int width = ~0U;
 
-	if (!match_atom_name(atom->name, "align", &buf))
-		die("BUG: parsing non-'align'");
-	if (!buf)
+	if (!arg)
 		die(_("expected format: %%(align:<width>,<position>)"));
-	s = to_free = strbuf_split_str_omit_term(buf, ',', 0);
+	s = to_free = strbuf_split_str_omit_term(arg, ',', 0);
 
 	align->position = ALIGN_LEFT;
 
 	while (*s) {
 		int position;
-		buf = s[0]->buf;
+		arg = s[0]->buf;
 
-		if (skip_prefix(buf, "position=", &buf)) {
-			position = parse_align_position(buf);
+		if (skip_prefix(arg, "position=", &arg)) {
+			position = parse_align_position(arg);
 			if (position < 0)
-				die(_("unrecognized position:%s"), buf);
+				die(_("unrecognized position:%s"), arg);
 			align->position = position;
-		} else if (skip_prefix(buf, "width=", &buf)) {
-			if (strtoul_ui(buf, 10, &width))
-				die(_("unrecognized width:%s"), buf);
-		} else if (!strtoul_ui(buf, 10, &width))
+		} else if (skip_prefix(arg, "width=", &arg)) {
+			if (strtoul_ui(arg, 10, &width))
+				die(_("unrecognized width:%s"), arg);
+		} else if (!strtoul_ui(arg, 10, &width))
 			;
-		else if ((position = parse_align_position(buf)) >= 0)
+		else if ((position = parse_align_position(arg)) >= 0)
 			align->position = position;
 		else
-			die(_("unrecognized %%(align) argument: %s"), buf);
+			die(_("unrecognized %%(align) argument: %s"), arg);
 		s++;
 	}
 
@@ -200,7 +166,7 @@ static void align_atom_parser(struct used_atom *atom)
 static struct {
 	const char *name;
 	cmp_type cmp_type;
-	void (*parser)(struct used_atom *atom);
+	void (*parser)(struct used_atom *atom, const char *arg);
 } valid_atom[] = {
 	{ "refname" },
 	{ "objecttype" },
@@ -226,8 +192,8 @@ static struct {
 	{ "taggerdate", FIELD_TIME },
 	{ "creator" },
 	{ "creatordate", FIELD_TIME },
-	{ "subject", FIELD_STR, contents_atom_parser },
-	{ "body", FIELD_STR, contents_atom_parser },
+	{ "subject", FIELD_STR, subject_atom_parser },
+	{ "body", FIELD_STR, body_atom_parser },
 	{ "contents", FIELD_STR, contents_atom_parser },
 	{ "upstream", FIELD_STR, remote_ref_atom_parser },
 	{ "push", FIELD_STR, remote_ref_atom_parser },
@@ -268,6 +234,7 @@ struct atom_value {
 int parse_ref_filter_atom(const char *atom, const char *ep)
 {
 	const char *sp;
+	const char *arg;
 	int i, at;
 
 	sp = atom;
@@ -292,10 +259,9 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
 		 * shouldn't be used for checking against the valid_atom
 		 * table.
 		 */
-		const char *formatp = strchr(sp, ':');
-		if (!formatp || ep < formatp)
-			formatp = ep;
-		if (len == formatp - sp && !memcmp(valid_atom[i].name, sp, len))
+		arg = memchr(sp, ':', ep - sp);
+		if ((!arg || len == arg - sp) &&
+		    !memcmp(valid_atom[i].name, sp, len))
 			break;
 	}
 
@@ -308,9 +274,11 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
 	REALLOC_ARRAY(used_atom, used_atom_cnt);
 	used_atom[at].name = xmemdupz(atom, ep - atom);
 	used_atom[at].type = valid_atom[i].cmp_type;
+	if (arg)
+		arg = used_atom[at].name + (arg - atom) + 1;
 	memset(&used_atom[at].u, 0, sizeof(used_atom[at].u));
 	if (valid_atom[i].parser)
-		valid_atom[i].parser(&used_atom[at]);
+		valid_atom[i].parser(&used_atom[at], arg);
 	if (*atom == '*')
 		need_tagged = 1;
 	if (!strcmp(used_atom[at].name, "symref"))
@@ -516,7 +484,7 @@ static void grab_common_values(struct atom_value *val, int deref, struct object
 			v->s = xstrfmt("%lu", sz);
 		}
 		else if (deref)
-			grab_objectname(name, obj->sha1, v, &used_atom[i]);
+			grab_objectname(name, obj->oid.hash, v, &used_atom[i]);
 	}
 }
 
@@ -538,7 +506,7 @@ static void grab_tag_values(struct atom_value *val, int deref, struct object *ob
 		else if (!strcmp(name, "type") && tag->tagged)
 			v->s = typename(tag->tagged->type);
 		else if (!strcmp(name, "object") && tag->tagged)
-			v->s = xstrdup(sha1_to_hex(tag->tagged->sha1));
+			v->s = xstrdup(oid_to_hex(&tag->tagged->oid));
 	}
 }
 
@@ -556,7 +524,7 @@ static void grab_commit_values(struct atom_value *val, int deref, struct object
 		if (deref)
 			name++;
 		if (!strcmp(name, "tree")) {
-			v->s = xstrdup(sha1_to_hex(commit->tree->object.sha1));
+			v->s = xstrdup(oid_to_hex(&commit->tree->object.oid));
 		}
 		else if (!strcmp(name, "numparent")) {
 			v->ul = commit_list_count(commit->parents);
@@ -569,7 +537,7 @@ static void grab_commit_values(struct atom_value *val, int deref, struct object
 				struct commit *parent = parents->item;
 				if (parents != commit->parents)
 					strbuf_addch(&s, ' ');
-				strbuf_addstr(&s, sha1_to_hex(parent->object.sha1));
+				strbuf_addstr(&s, oid_to_hex(&parent->object.oid));
 			}
 			v->s = strbuf_detach(&s, NULL);
 		}
@@ -931,7 +922,7 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 			*s = ">";
 		else
 			*s = "<>";
-	} else if (atom->u.remote_ref == RR_NORMAL)
+	} else /* RR_NORMAL */
 		*s = refname;
 }
 
@@ -986,9 +977,8 @@ static void populate_value(struct ref_array_item *ref)
 			branch = branch_get(branch_name);
 
 			refname = branch_get_upstream(branch, NULL);
-			if (!refname)
-				continue;
-			fill_remote_ref_details(atom, refname, branch, &v->s);
+			if (refname)
+				fill_remote_ref_details(atom, refname, branch, &v->s);
 			continue;
 		} else if (starts_with(name, "push")) {
 			const char *branch_name;
--- a/strbuf.c
+++ b/strbuf.c
@@ -123,15 +123,18 @@ struct strbuf **strbuf_split_buf(const char *str, size_t slen,
 
 	while (slen) {
 		int len = slen;
+		int copylen = len;
 		const char *end = NULL;
 		if (max <= 0 || nr + 1 < max) {
 			end = memchr(str, terminator, slen);
-			if (end)
+			if (end) {
 				len = end - str + 1;
+				copylen = len - !!omit_term;
+			}
 		}
 		t = xmalloc(sizeof(struct strbuf));
-		strbuf_init(t, len);
-		strbuf_add(t, str, len - !!end * !!omit_term);
+		strbuf_init(t, copylen);
+		strbuf_add(t, str, copylen);
 		ALLOC_GROW(ret, nr + 2, alloc);
 		ret[nr++] = t;
 		str += len;

-- 
2.7.0
