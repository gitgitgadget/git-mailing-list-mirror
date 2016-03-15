From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 00/16] port branch.c to use ref-filter's printing options
Date: Tue, 15 Mar 2016 22:17:00 +0530
Message-ID: <1458060436-1215-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, jacob.keller@gmail.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 15 17:47:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afs81-0000aO-PW
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 17:47:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934196AbcCOQrZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 12:47:25 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36773 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753886AbcCOQrX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 12:47:23 -0400
Received: by mail-pf0-f181.google.com with SMTP id u190so35734235pfb.3
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 09:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=joSFQU31ssjqYp7c3F21oNx4YABoj0xFLzyPTDNLbwo=;
        b=Zp+qUZpLhE/pNo+5zXJxljHAg2nXdFrMB3Zk8edBI0yfNRgxbSwJ5fdX5+1zFPwyEO
         l/CzQgOS62OX3Z4hDdMPvhlWgECMggKb45/bz1hYEZrfL656ZGG94GwW389nb8WcG6Nl
         p9JRqwJijR3gGdGXlzv+i0nhkjyKmSQ1nTFZUHby/22uZ96xvTDuiOaydUatvGvpUHv0
         1tDxrclvAM2/v+rA2xlg2Mds1lbXxMCvEpmb6qaCkakcalmF632xTPFVvTbRH4GoSZ3O
         TdtWEHBgW+Pw7BZyPsPh3yuqH8i0uL0db8RHWF3cQa7lM2ZRLdDDnUZ5YGhAS+H82SEG
         ylfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=joSFQU31ssjqYp7c3F21oNx4YABoj0xFLzyPTDNLbwo=;
        b=WKdZQYoMuqSNm4M5KRMbZJTQqA8Wq2gdQkUjeAoBKNa86F6va1v58BtetRajSY3V8I
         lwUhWMuxnnSDdHANH1F1TRVl4W1k1R0acaRgoAXtdclpsyUtdD2h/j6vDn+P2WnQSBvk
         fdFrPeTSDrHiwT+ouddzfGpI7GZ6SEZTKRbbN7uvBiijb/Jqgjtt03sdd/NKLt66OOZJ
         CgTz2u4N20EcCq3FfisiUxR48uS2WPgpyGG/RBnZE90+8ubZN4EfvhOdrCvl7FsAiZOt
         KgxWaHOua6SLKEydhDhQxrfPsWa4LcM/qI6iNxREvcDRGaD5j0ggYLFDqX/zmR468170
         zQCA==
X-Gm-Message-State: AD7BkJLcLMaoWSkJFo4fxc4PAp0h0OvMs7PeaR1RvUS/KMXOsKyvaHHSjzubL8cXL2Yhjw==
X-Received: by 10.66.254.168 with SMTP id aj8mr48157533pad.18.1458060442470;
        Tue, 15 Mar 2016 09:47:22 -0700 (PDT)
Received: from localhost.localdomain ([106.51.243.87])
        by smtp.gmail.com with ESMTPSA id i1sm40874361pfj.17.2016.03.15.09.47.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Mar 2016 09:47:21 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288863>

This is part of unification of the commands 'git tag -l, git branch -l
and git for-each-ref'. This ports over branch.c to use ref-filter's
printing options.

Initially posted here: $(gmane/279226). It was decided that this series
would follow up after refactoring ref-filter parsing mechanism, which
is now merged into master (9606218b32344c5c756f7c29349d3845ef60b80c).

v1 can be found here: $(gmane/288342)

Changes in this version:

1. Implement parser atoms for %(if:equals=...) and %(if:notequals=...)
2. Include a pointer to the corresponding used_atom within atom_value.
3. add missing documentation for %(upstream:track).
4. Fix commit message.

Thanks to Jacob and Junio for their suggestions on the first iteration.

Karthik Nayak (16):
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
  ref-filter: introduce symref_atom_parser()
  ref-filter: introduce refname_atom_parser()
  ref-filter: add support for %(refname:dir) and %(refname:base)
  ref-filter: allow porcelain to translate messages in the output
  branch, tag: use porcelain output
  branch: use ref-filter printing APIs
  branch: implement '--format' option

 Documentation/git-branch.txt       |   7 +-
 Documentation/git-for-each-ref.txt |  58 ++++-
 builtin/branch.c                   | 267 ++++++----------------
 builtin/tag.c                      |   2 +
 ref-filter.c                       | 447 +++++++++++++++++++++++++++++++------
 ref-filter.h                       |   7 +
 t/t3203-branch-output.sh           |  12 +
 t/t6040-tracking-info.sh           |   2 +-
 t/t6300-for-each-ref.sh            |  40 +++-
 t/t6302-for-each-ref-filter.sh     |  88 ++++++++
 10 files changed, 653 insertions(+), 277 deletions(-)

Interdiff:

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 193e99e..578bbd1 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -116,10 +116,12 @@ upstream::
 	`refname` above.  Additionally respects `:track` to show
 	"[ahead N, behind M]" and `:trackshort` to show the terse
 	version: ">" (ahead), "<" (behind), "<>" (ahead and behind),
-	or "=" (in sync).  Append `:track,nobracket` to show tracking
-	information without brackets (i.e "ahead N, behind M").  Has
-	no effect if the ref does not have tracking information
-	associated with it.
+	or "=" (in sync).  Has no effect if the ref does not have
+	tracking information associated with it. `:track` also prints
+	"[gone]" whenever unknown upstream ref is encountered. Append
+	`:track,nobracket` to show tracking information without
+	brackets (i.e "ahead N, behind M").  Has no effect if the ref
+	does not have tracking information associated with it.
 
 push::
 	The name of a local ref which represents the `@{push}` location
diff --git a/ref-filter.c b/ref-filter.c
index 76ea7c3..3435df1 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -75,6 +75,10 @@ static struct used_atom {
 			unsigned int nlines;
 		} contents;
 		struct {
+			const char *if_equals,
+				*not_equals;
+		} if_then_else;
+		struct {
 			enum { O_FULL, O_LENGTH, O_SHORT } option;
 			unsigned int length;
 		} objectname;
@@ -226,6 +230,18 @@ static void align_atom_parser(struct used_atom *atom, const char *arg)
 	string_list_clear(&params, 0);
 }
 
+static void if_atom_parser(struct used_atom *atom, const char *arg)
+{
+	if (!arg)
+		return;
+	else if (skip_prefix(arg, "equals=", &atom->u.if_then_else.if_equals))
+		 ;
+	else if (skip_prefix(arg, "notequals=", &atom->u.if_then_else.not_equals))
+		;
+	else
+		die(_("unrecognized %%(if) argument: %s"), arg);
+}
+
 static void symref_atom_parser(struct used_atom *atom, const char *arg)
 {
 	if (!arg)
@@ -295,7 +311,7 @@ static struct {
 	{ "color", FIELD_STR, color_atom_parser },
 	{ "align", FIELD_STR, align_atom_parser },
 	{ "end" },
-	{ "if" },
+	{ "if", FIELD_STR, if_atom_parser },
 	{ "then" },
 	{ "else" },
 };
@@ -316,11 +332,9 @@ struct ref_formatting_state {
 
 struct atom_value {
 	const char *s;
-	union {
-		struct align align;
-	} u;
 	void (*handler)(struct atom_value *atomv, struct ref_formatting_state *state);
 	unsigned long ul; /* used for sorting when not FIELD_STR */
+	struct used_atom *atom;
 };
 
 /*
@@ -377,7 +391,7 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
 		valid_atom[i].parser(&used_atom[at], arg);
 	if (*atom == '*')
 		need_tagged = 1;
-	if (starts_with(used_atom[at].name, "symref"))
+	if (!strcmp(valid_atom[i].name, "symref"))
 		need_symref = 1;
 	return at;
 }
@@ -456,7 +470,7 @@ static void align_atom_handler(struct atom_value *atomv, struct ref_formatting_s
 	push_stack_element(&state->stack);
 	new = state->stack;
 	new->at_end = end_align_handler;
-	new->at_end_data = &atomv->u.align;
+	new->at_end_data = &atomv->atom->u.align;
 }
 
 static void if_then_else_handler(struct ref_formatting_stack **stack)
@@ -497,14 +511,9 @@ static void if_atom_handler(struct atom_value *atomv, struct ref_formatting_stat
 {
 	struct ref_formatting_stack *new;
 	struct if_then_else *if_then_else = xcalloc(sizeof(struct if_then_else), 1);
-	const char *valp;
 
-	if (skip_prefix(atomv->s, "equals=", &valp))
-		if_then_else->if_equals = valp;
-	else if (skip_prefix(atomv->s, "notequals=", &valp))
-		if_then_else->not_equals = valp;
-	else if (atomv->s[0])
-		die(_("format: unknown format if:%s"), atomv->s);
+	if_then_else->if_equals = atomv->atom->u.if_then_else.if_equals;
+	if_then_else->not_equals = atomv->atom->u.if_then_else.not_equals;
 
 	push_stack_element(&state->stack);
 	new = state->stack;
@@ -1243,6 +1252,7 @@ static void populate_value(struct ref_array_item *ref)
 		struct branch *branch = NULL;
 
 		v->handler = append_atom;
+		v->atom = atom;
 
 		if (*name == '*') {
 			deref = 1;
@@ -1307,7 +1317,6 @@ static void populate_value(struct ref_array_item *ref)
 				v->s = " ";
 			continue;
 		} else if (starts_with(name, "align")) {
-			v->u.align = atom->u.align;
 			v->handler = align_atom_handler;
 			continue;
 		} else if (!strcmp(name, "end")) {


-- 
2.7.3
