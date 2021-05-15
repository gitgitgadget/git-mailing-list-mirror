Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABACCC433ED
	for <git@archiver.kernel.org>; Sat, 15 May 2021 09:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 845CF60BBB
	for <git@archiver.kernel.org>; Sat, 15 May 2021 09:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234543AbhEOJF1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 May 2021 05:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbhEOJF0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 May 2021 05:05:26 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA004C06174A
        for <git@vger.kernel.org>; Sat, 15 May 2021 02:04:10 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id z17so1423781wrq.7
        for <git@vger.kernel.org>; Sat, 15 May 2021 02:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=iluZiIEU3o7xAtbScp+lDM3wtlMNho1WSX7Ln2NIXCg=;
        b=b1B4C9WliVdFOOSc+RLh7nGNqw1Fl2pmZEcDB8mZES1eYu0YqfIyVEV4jGQdsuXutz
         l1LS2pgacKDvJdOtJC/mnT+qiYhyF7lNHdhrvIO+rSiQu28MLP8wmlCqpFXoVsk9xsKU
         H+V/lgzIdNhmFQSf+/uBDQvXWhvxElOmNe3LwDUErGhw/o53dzWHBzyixvSt8ddyEIUM
         L5Ewn+W1Oq44F8R9DM48nZBZxApe2gyUjQr0ih51/1Z5qw5VnON2uwpJKU2TzLtgONog
         HtUSkeyJ19iIMUPhXmD3izovpJQFBpJSHzwe9fgN5FeLXlhDKj0GAV+nY3kGw99lGMOw
         /d8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iluZiIEU3o7xAtbScp+lDM3wtlMNho1WSX7Ln2NIXCg=;
        b=TYAqrbKiLcR9rfnDJmawA/275jZ7NTAcTaQ+aLHIQsyQZ1fz6iJ/kcgcS4MOsLQo/B
         KzJx9FGb93cmdH8o4sVGCnMIZfn1GYTOc4hNfbbkaHHrSnp1OBC1+yCeT7nUYHA1C/+r
         YYtPA9Zt90m+KyXCDm/zvXzzIMDZDNuBrVzk/NwZonyjWzbKfJwC8KYG7ibNlAFgcnCe
         VRvjAIO5Ezf3YcUA3kg2Uim9/ivd78dmTUxzSXbRi8npHAwNeT4rCCpozdBHIfFB7eML
         5rR1+OipgqoPynXwWazWe/QtW6pUKPmFIONdNimjUFSipe/7ghkqePmuDK73HxjZTqtl
         mK9g==
X-Gm-Message-State: AOAM5311ZyBU2CRWdPIFEhbT/JxvFMUu7BN4QfcSnuEmCkv+xD5gLSF4
        iy4BiZcSAKBTI77qBy6zDH7RggtyLCU=
X-Google-Smtp-Source: ABdhPJw18m7CL2V6zN9g+o/OQlGWH+vyr8Ff7q4WbGIAhFQwzRYIEbcxLPgrAZyj6LBVUKnLU8jFNQ==
X-Received: by 2002:a05:6000:192:: with SMTP id p18mr20590794wrx.252.1621069449601;
        Sat, 15 May 2021 02:04:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x10sm9064581wro.66.2021.05.15.02.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 02:04:08 -0700 (PDT)
Message-Id: <pull.952.git.1621069448064.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 15 May 2021 09:04:07 +0000
Subject: [PATCH] [GSOC][RFC] ref-filter: add %(notes) atom and --notes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Hariom Verma <hariom18599@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Note that `--pretty="%N"` can view notes related
to the commit. So add `%(notes)` to ref-filter
seem is a good choice. New atom `%(notes)` can show
the notes associated with the object pointed at by
the ref. At the same time we can use `%(*notes)`
to show the notes of the object which dereferenced
by the ref.

Add `--notes=<ref>` option and `--no-notes` option
to `git for-each-ref`. Multiple `--notes=<ref>`
options can be combined to control which notes are
being displayed. `--no-notes` will reset the list of
notes refs from which notes are shown.

By default, `git for-each-ref --format="%(notes)"`
will output notes of "refs/notes/commits", and
in the case of using `--notes=foo`, will suppress
the output notes of `refs/notes/commits`, unless
use `--notes=refs/notes/commits` at the same time,
"refs/notes/commit"'s notes will output. Therefore,
the semantics of `--notes=<ref>` here are different
from that of `git log --notes=<ref>`.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    [GSOC][RFC] ref-filter: add %(notes) atom and --notes
    
    In https://lore.kernel.org/git/xmqqsg34a5j8.fsf@gitster.g/
    
    Junio think that %(notes) atom can be used with --notes. René Scharfe
    think %(notes) can make use of load_display_notes() and
    format_display_notes() to reduce overhead.
    
    So in this new version of this patch, I may have implemented this
    feature in some troublesome ways.
    
    First, I parsed --notes and --no-notes in for-each-ref.c. use new struct
    notes_info as a carrier for parsing --notes, The parsed notes_info is
    passed to ref-filter.c through a global variable "struct notes_info
    notes_info".
    
    Then in ref-filter.c I use notes_atom_parser() to parse %(notes), the
    parsing of all notes atoms only calls load_display_notes() once.
    
    Finally, use grab_notes() to get the notes corresponding to the object.
    
    However, the current implementation is still not elegant enough,
    
    First, can we directly learn the processing of --notes and --no-notes in
    revision.c? It is very cumbersome to make new --notes and --no-notes in
    for-each-ref.c. Since we need to output "refs/notes/commits" notes by
    default when using --format="%(notes)", should we reject the default
    notes output of "refs/notes/commits" when using --notes=<ref> as it has
    been done now? And here --notes=<ref> does not support --notes (no ref),
    is there any good way to implement it?
    
    Second, I can not easily make struct notes_info notes_info a member of
    struct ref_format format, because as a parameter of *_atom_parser in
    ref-flter.c, const struct ref_format *format is used to prevent us from
    modifying it. However, struct notes_info notes_info is a variable that
    needs to be modified. So here I have to use a global variable to pass it
    (very urgly).
    
    Third, I am not sure whether the "raw" parameter of
    format_display_notes() should be passed 0 or 1.
    
    So, I feel very confused, any good suggestions?

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-952%2Fadlternative%2Fref-filter-notes-atom-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-952/adlternative/ref-filter-notes-atom-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/952

 Documentation/git-for-each-ref.txt | 14 +++++++
 builtin/for-each-ref.c             | 26 ++++++++++++
 ref-filter.c                       | 35 +++++++++++++++-
 ref-filter.h                       |  7 ++++
 t/t6300-for-each-ref.sh            | 64 ++++++++++++++++++++++++++++++
 5 files changed, 144 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 2ae2478de706..1157e8dda63d 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -13,6 +13,7 @@ SYNOPSIS
 		   [--points-at=<object>]
 		   [--merged[=<object>]] [--no-merged[=<object>]]
 		   [--contains[=<object>]] [--no-contains[=<object>]]
+		   [--no-notes | --notes=<ref>]
 
 DESCRIPTION
 -----------
@@ -57,6 +58,15 @@ OPTIONS
 	`xx`; for example `%00` interpolates to `\0` (NUL),
 	`%09` to `\t` (TAB) and `%0a` to `\n` (LF).
 
+--notes=<ref>::
+	Show the notes that annotate the object. With an optional '<ref>' argument,
+	use the ref to find the notes to display.
+	(see linkgit:git-notes[1] and linkgit:pretty-options.txt[])
+--no-notes::
+	Do not show notes. This negates the above `--notes` option, by
+	resetting the list of notes refs from which notes are shown.
+	(see linkgit:git-notes[1] and linkgit:pretty-options.txt[])
+
 --color[=<when>]::
 	Respect any colors specified in the `--format` option. The
 	`<when>` field must be one of `always`, `never`, or `auto` (if
@@ -139,6 +149,9 @@ deltabase::
 	given object, if it is stored as a delta.  Otherwise it
 	expands to the null object name (all zeroes).
 
+notes::
+	The notes associated with the object pointed at by the ref.
+
 upstream::
 	The name of a local ref which can be considered ``upstream''
 	from the displayed ref. Respects `:short`, `:lstrip` and
@@ -302,6 +315,7 @@ git for-each-ref --count=3 --sort='-*authordate' \
 Subject: %(*subject)
 Date: %(*authordate)
 Ref: %(*refname)
+Notes: %(*notes)
 
 %(*body)
 ' 'refs/tags'
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 89cb6307d46f..12e6e673d48e 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -14,6 +14,26 @@ static char const * const for_each_ref_usage[] = {
 	NULL
 };
 
+extern struct notes_info notes_info;
+
+int parse_opt_notes(const struct option *opt, const char *arg, int unset)
+{
+	struct notes_info *ni = opt->value;
+
+	if (unset) {
+		disable_display_notes(&ni->notes_option, &ni->show_notes);
+		return 0;
+	}
+
+	if (!arg)
+		return -1;
+
+	enable_ref_display_notes(&ni->notes_option, &ni->show_notes, arg);
+	ni->notes_option.use_default_notes = 0;
+
+	return 0;
+}
+
 int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 {
 	int i;
@@ -38,6 +58,8 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		OPT_GROUP(""),
 		OPT_INTEGER( 0 , "count", &maxcount, N_("show only <n> matched refs")),
 		OPT_STRING(  0 , "format", &format.format, N_("format"), N_("format to use for the output")),
+		OPT_CALLBACK(0, "notes", &notes_info, N_("notes"), N_("the notes associated"
+			     "with the object pointed at by the ref"), parse_opt_notes),
 		OPT__COLOR(&format.use_color, N_("respect format colors")),
 		OPT_REF_SORT(sorting_tail),
 		OPT_CALLBACK(0, "points-at", &filter.points_at,
@@ -51,6 +73,9 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 
+	init_display_notes(&notes_info.notes_option);
+	enable_default_display_notes(&notes_info.notes_option, &notes_info.show_notes);
+
 	memset(&array, 0, sizeof(array));
 	memset(&filter, 0, sizeof(filter));
 
@@ -97,5 +122,6 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	free_commit_list(filter.with_commit);
 	free_commit_list(filter.no_commit);
 	UNLEAK(sorting);
+	string_list_clear(&notes_info.notes_option.extra_notes_refs, 0);
 	return 0;
 }
diff --git a/ref-filter.c b/ref-filter.c
index e2eac50d9508..ffcc1e500ed3 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -84,6 +84,8 @@ static struct expand_data {
 	struct object_info info;
 } oi, oi_deref;
 
+struct notes_info notes_info;
+
 struct ref_to_worktree_entry {
 	struct hashmap_entry ent;
 	struct worktree *wt; /* key is wt->head_ref */
@@ -295,6 +297,16 @@ static int deltabase_atom_parser(const struct ref_format *format, struct used_at
 	return 0;
 }
 
+static int notes_atom_parser(const struct ref_format *format, struct used_atom *atom,
+				 const char *arg, struct strbuf *err)
+{
+	if(!notes_info.show_notes_given && notes_info.show_notes) {
+			load_display_notes(&notes_info.notes_option);
+			notes_info.show_notes_given = 1;
+	}
+	return 0;
+}
+
 static int body_atom_parser(const struct ref_format *format, struct used_atom *atom,
 			    const char *arg, struct strbuf *err)
 {
@@ -506,6 +518,7 @@ static struct {
 	{ "objectsize", SOURCE_OTHER, FIELD_ULONG, objectsize_atom_parser },
 	{ "objectname", SOURCE_OTHER, FIELD_STR, oid_atom_parser },
 	{ "deltabase", SOURCE_OTHER, FIELD_STR, deltabase_atom_parser },
+	{ "notes", SOURCE_OTHER, FIELD_STR, notes_atom_parser },
 	{ "tree", SOURCE_OBJ, FIELD_STR, oid_atom_parser },
 	{ "parent", SOURCE_OBJ, FIELD_STR, oid_atom_parser },
 	{ "numparent", SOURCE_OBJ, FIELD_ULONG },
@@ -953,6 +966,17 @@ static int grab_oid(const char *name, const char *field, const struct object_id
 	return 0;
 }
 
+static void grab_notes(const struct object_id *oid, struct atom_value *v)
+{
+	struct strbuf notebuf = STRBUF_INIT;
+
+	if (notes_info.show_notes)
+			format_display_notes(oid, &notebuf,
+			     get_log_output_encoding(), 1);
+	strbuf_trim_trailing_newline(&notebuf);
+	v->s = strbuf_detach(&notebuf, NULL);
+}
+
 /* See grab_values */
 static void grab_common_values(struct atom_value *val, int deref, struct expand_data *oi)
 {
@@ -975,8 +999,12 @@ static void grab_common_values(struct atom_value *val, int deref, struct expand_
 			v->s = xstrfmt("%"PRIuMAX , (uintmax_t)oi->size);
 		} else if (!strcmp(name, "deltabase"))
 			v->s = xstrdup(oid_to_hex(&oi->delta_base_oid));
-		else if (deref)
-			grab_oid(name, "objectname", &oi->oid, v, &used_atom[i]);
+		else if (deref) {
+			if (!strcmp(name, "notes"))
+				grab_notes(&oi->oid, v);
+			else
+				grab_oid(name, "objectname", &oi->oid, v, &used_atom[i]);
+		}
 	}
 }
 
@@ -1767,6 +1795,9 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 			continue;
 		} else if (!deref && grab_oid(name, "objectname", &ref->objectname, v, atom)) {
 			continue;
+		} else if (!deref && !strcmp(name, "notes")) {
+			grab_notes(&ref->objectname, v);
+			continue;
 		} else if (!strcmp(name, "HEAD")) {
 			if (atom->u.head && !strcmp(ref->refname, atom->u.head))
 				v->s = xstrdup("*");
diff --git a/ref-filter.h b/ref-filter.h
index baf72a718965..b2f97bbd164e 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -5,6 +5,7 @@
 #include "refs.h"
 #include "commit.h"
 #include "parse-options.h"
+#include "notes.h"
 
 /* Quoting styles */
 #define QUOTE_NONE 0
@@ -85,6 +86,12 @@ struct ref_format {
 
 #define REF_FORMAT_INIT { NULL, 0, -1 }
 
+struct notes_info {
+	int show_notes;
+	int show_notes_given;
+	struct display_notes_opt notes_option;
+};
+
 /*  Macros for checking --merged and --no-merged options */
 #define _OPT_MERGED_NO_MERGED(option, filter, h) \
 	{ OPTION_CALLBACK, 0, option, (filter), N_("commit"), (h), \
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 9e0214076b4d..a92636236dfb 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -32,8 +32,12 @@ test_expect_success setup '
 	git add one &&
 	git commit -m "Initial" &&
 	git branch -M main &&
+	git notes add -m "commit-notes" HEAD &&
+	git notes --ref=refs/notes/sky-walker add \
+	    -m "sky-notes" HEAD &&
 	setdate_and_increment &&
 	git tag -a -m "Tagging at $datestamp" testtag &&
+	git notes add -m "tag-notes" testtag &&
 	git update-ref refs/remotes/origin/main main &&
 	git remote add origin nowhere &&
 	git config branch.main.remote origin &&
@@ -162,6 +166,7 @@ test_atom head contents:signature ''
 test_atom head contents 'Initial
 '
 test_atom head HEAD '*'
+test_atom head notes $(git notes show refs/heads/main)
 
 test_atom tag refname refs/tags/testtag
 test_atom tag refname:short testtag
@@ -220,6 +225,8 @@ test_atom tag contents:signature ''
 test_atom tag contents 'Tagging at 1151968727
 '
 test_atom tag HEAD ' '
+test_atom tag notes $(git notes show refs/tags/testtag)
+test_atom tag "*notes" $(git notes show refs/heads/main)
 
 test_expect_success 'Check invalid atoms names are errors' '
 	test_must_fail git for-each-ref --format="%(INVALID)" refs/heads
@@ -380,6 +387,8 @@ test_expect_success 'exercise strftime with odd fields' '
 
 cat >expected <<\EOF
 refs/heads/main
+refs/notes/commits
+refs/notes/sky-walker
 refs/remotes/origin/main
 refs/tags/testtag
 EOF
@@ -393,6 +402,8 @@ test_expect_success 'Verify ascending sort' '
 cat >expected <<\EOF
 refs/tags/testtag
 refs/remotes/origin/main
+refs/notes/sky-walker
+refs/notes/commits
 refs/heads/main
 EOF
 
@@ -429,6 +440,8 @@ test_expect_success 'exercise glob patterns with prefixes' '
 
 cat >expected <<\EOF
 'refs/heads/main'
+'refs/notes/commits'
+'refs/notes/sky-walker'
 'refs/remotes/origin/main'
 'refs/tags/testtag'
 EOF
@@ -450,6 +463,8 @@ test_expect_success 'Quoting style: python' '
 
 cat >expected <<\EOF
 "refs/heads/main"
+"refs/notes/commits"
+"refs/notes/sky-walker"
 "refs/remotes/origin/main"
 "refs/tags/testtag"
 EOF
@@ -509,6 +524,8 @@ test_expect_success 'Check for invalid refname format' '
 test_expect_success 'set up color tests' '
 	cat >expected.color <<-EOF &&
 	$(git rev-parse --short refs/heads/main) <GREEN>main<RESET>
+	$(git rev-parse --short refs/notes/commits) <GREEN>notes/commits<RESET>
+	$(git rev-parse --short refs/notes/sky-walker) <GREEN>notes/sky-walker<RESET>
 	$(git rev-parse --short refs/remotes/myfork/main) <GREEN>myfork/main<RESET>
 	$(git rev-parse --short refs/remotes/origin/main) <GREEN>origin/main<RESET>
 	$(git rev-parse --short refs/tags/testtag) <GREEN>testtag<RESET>
@@ -1007,6 +1024,53 @@ test_expect_success 'Add symbolic ref for the following tests' '
 	git symbolic-ref refs/heads/sym refs/heads/main
 '
 
+test_expect_success 'for-each-ref --notes and --no-notes' '
+	cat >expected <<-\EOF &&
+	sky-notes
+	EOF
+	git for-each-ref --format="%(notes)" --notes=refs/notes/sky-walker \
+	    refs/heads/ambiguous >actual &&
+	test_cmp expected actual &&
+	git for-each-ref --format="%(notes)" --notes=sky-walker refs/heads/ambiguous >actual &&
+	test_cmp expected actual &&
+	git for-each-ref --format="%(notes)" --notes=sky-walker --notes=commits \
+	    --no-notes --notes=sky-walker refs/heads/ambiguous >actual &&
+	test_cmp expected actual &&
+	cat >expected <<-\EOF &&
+	commit-notes
+	EOF
+	git for-each-ref --format="%(notes)" --notes=commits refs/heads/ambiguous >actual &&
+	cat >expected <<-\EOF &&
+	sky-notes
+	commit-notes
+	EOF
+	git for-each-ref --format="%(notes)" --notes=sky-walker --notes=commits \
+	    refs/heads/ambiguous >actual &&
+	test_cmp expected actual &&
+	cat >expected <<-\EOF &&
+	commit-notes
+	sky-notes
+	EOF
+	git for-each-ref --format="%(notes)" --notes=commits --notes=sky-walker \
+	    refs/heads/ambiguous >actual &&
+	test_cmp expected actual &&
+	cat >expected <<-\EOF &&
+
+	EOF
+	git for-each-ref --format="%(notes)" --notes=sky-walker --notes=commits --no-notes \
+	    refs/heads/ambiguous >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'for-each-ref --notes with remote ref' '
+	cat >expected <<-\EOF &&
+	refs/remotes/origin/main sky-notes
+	EOF
+	git for-each-ref --format="%(refname) %(notes)" --notes=refs/notes/sky-walker \
+	    refs/remotes/origin/main >actual &&
+	test_cmp expected actual
+'
+
 cat >expected <<EOF
 refs/heads/main
 EOF

base-commit: 97eea85a0a1ec66d356567808a1e4ca2367e0ce7
-- 
gitgitgadget
