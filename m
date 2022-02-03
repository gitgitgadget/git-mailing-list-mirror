Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADD6C433F5
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 17:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352920AbiBCRjA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 12:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235430AbiBCRi7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 12:38:59 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D78DC061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 09:38:59 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id s5so11058906ejx.2
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 09:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=W8lpQVG8ePYMnh4pGcFX3jfa1hPiIZ3pcQe2nvx0Jvc=;
        b=jnNMRJ6MTzcXqkGeymzUZ0mFWy8lxPrl9Zqo0Zn+op94W6/dYQXA8SSdfApjxzvIBS
         wy+Jb5GPNaZ3OSgpWKLWRArsSZurjkE9WGwMZyaEAsDfbEW2sILDrcmI1BpAtI+Siiso
         LoK3Nu2KNnDQ95Fvdtod3UWYkzhZSz+UMBs9/oZRlKm/zv/e+nluLGeJ/FY/sp4mMhAQ
         wru+zWwN8LF5kziRc34eXm23UaDoI7DS4Ux+GPIydWCXXc6itnvEsZlio+AKdQuCa3aU
         ZdGb5hHNCTYoCOHXbpKsPdhMXhghki91pmbRekrS0nOYpHmZW/hew8QL/B3SqV6Uu4J5
         6MNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=W8lpQVG8ePYMnh4pGcFX3jfa1hPiIZ3pcQe2nvx0Jvc=;
        b=UaSJAgJgw8lBYO2fKoX2rHeNFJ1p1dPiWGogWIE3NefM9i8BBSIn5uqBGPruxZM3T9
         QOI3UgbEvtpTxm2B+RvdbOiOc5eGof6BNvW6ceS8VMOndxlZiHP2VfqTasG9ajMU21kJ
         f3rU9nhR0qLb1E8UECHuH1zr9EmM9spuqTKoEuf8rrkJhHq3C0x6r4bzsqhC6LfwIhBy
         nq56LSfmNLjjShMmel6by9FY+5cQ31bunUyqQZXVKYCxz93Dy9hMhJqwsCnqoEGOmKbk
         9KtZekRSGkViGonhr/f2Cs9GY/4IOEr6O1vfuzTYd6U61WBkA9lQZ/0Cigp/3SCksb13
         oWyA==
X-Gm-Message-State: AOAM531Q8CYpsB4oSwISSJnKNELY+Ld6iUXkfift/DVJ+G26uH60CCTH
        W3oBqmp2ZOnuyqolbwMerjvWJC9Ny6OJCw==
X-Google-Smtp-Source: ABdhPJyYTN2brL5DVNiFybcelmeKRMNmr26Zwf8m/z9zEohUMU2zPcwb2kZE8iB5wwCGGfBFaEZuxw==
X-Received: by 2002:a17:906:eb89:: with SMTP id mh9mr30480564ejb.399.1643909937539;
        Thu, 03 Feb 2022 09:38:57 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id s7sm16950447ejo.53.2022.02.03.09.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 09:38:56 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nFg4O-0056oR-0k;
        Thu, 03 Feb 2022 18:38:56 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 03/15] merge-tree: add option parsing and initial
 shell for real merge function
Date:   Thu, 03 Feb 2022 18:15:18 +0100
References: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
 <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
 <63f42df21aec5bda50e4414493eb59dcb64e5558.1643787281.git.gitgitgadget@gmail.com>
 <220203.86a6f87lbl.gmgdl@evledraar.gmail.com>
 <CABPp-BHKZnmaq3NM5_D6pwkw2+91EsdJ-uqjfFPBYiUSE28k1g@mail.gmail.com>
 <CABPp-BHZYUmWBvzgFkRYddnUJQWrtah=JJ-yaW9Km8+qWcCfUw@mail.gmail.com>
 <220203.86wnic5lba.gmgdl@evledraar.gmail.com>
 <CABPp-BF8VoQ7F7yvfzrpQEZwErxHzb9x8M_R9PrrM7vWzw=wSw@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CABPp-BF8VoQ7F7yvfzrpQEZwErxHzb9x8M_R9PrrM7vWzw=wSw@mail.gmail.com>
Message-ID: <220203.86bkzn6ea8.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 03 2022, Elijah Newren wrote:

> On Thu, Feb 3, 2022 at 1:52 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <av=
arab@gmail.com> wrote:
>>
>> On Thu, Feb 03 2022, Elijah Newren wrote:
>>
> [...]
>> > ...also, even if we did require the `--write-tree` flag, we'd still
>> > have to look at argc.  Since the option parsing handles both modes,
>> > someone could leave off --write-tree, but include a bunch of other
>> > options that only make sense with --write-tree.  Individually checking
>> > the setting of every extra flag along with write_tree is a royal pain
>> > and I don't want to repeat that for each new option added.  Simply
>> > checking argc allows you to provide an error message if the user does
>> > that.
>> >
>> > (And I think it's sad that in Git we often forgot to warn and notify
>> > users of options that are only functional with certain other
>> > arguments; it makes it harder for users to figure out, and has in the
>> > past even made it harder for other developers to figure out what was
>> > meant and how things are to be used.  I think I've seen multiple Git
>> > devs be confused over ls-files --directory and --no-empty-directory
>> > options, assuming they'd do something sensible for tracked files, when
>> > in fact those arguments are simply ignored because they are only
>> > modifiers for how untracked files are treated.)
>>
>> There's a much simpler way to do what you're trying to do here which is
>> to only parse --write-tree, and as soon as you have that pass off two
>> one function or the other, and have those functions call
>> parse_options().
>
> But that makes --write-tree a mandatory argument when trying to use
> that mode, right?  If so, that is not a simpler way to do what I'm
> trying to do at all; it breaks my intended usage.
>
> --write-tree is a documentation-only construct that users should never
> have to pass.
>
> Also, what happens if we remove the --trivial-merge flag and its whole
> mode after a sufficient deprecation period?  Would the --write-tree
> parameter remain required in your model to select the only existing
> mode, simply due to us having gone through a transition period?

You can have your cake and eat it too by running parse_optionss() N
number of times. Although perhaps in this case the end result isn't
worth it.

I was hoping this could be a simpler case of a subcommand dispatch, and
perhaps it can still be generalized to that.

If the "trivial" mode never takes options and always 3 argv elements, we
could just run parse_options() for it with no options, after checking
that we have 3 arguments, and none start with '-'.

But the below is a generalization of this I tried out just now, it
passes all your tests, and means that whenever you add new options you
don't need to keep saying "no, not with the trivial mode" for each one.

Basically we run parse_options() once with the full set of options, and
save away argc/argv (note the lack of strvec_clear() there, that's a
TODO memory leak).

Then we've got a o.mode, which along with argc is the *only* thing we
pay attention to at that point.

Then we dispatch to the "trivial" or "write" functions, which do
parse_options() again, this time with only their options.

It means that e.g. this now works as expected:
=20=20=20=20
    ./git merge-tree --trivial-merge -z origin/{master,next,seen}
    error: unknown switch `z'
    usage: git merge-tree [--trivial-merge] <base-tree> <branch1> <branch2>
=20=20=20=20
        --trivial-merge       do a trivial merge only

I.e. we error out, with your verison we'll just ignore the -z.

Your "--trivial-merge is incompatible with all other options" doesn't
work as you expect, and is buggy whether you want to go this route or
not, as the added tests show.

Basically it does nothing at all. Because if you add --foo we'll die
before we get there, parse_options() will die for us.

But if you do --trivial-merge -z your argc/argv will be trimmed, because
-z is a known option. So your check is doing nothing. Your tests also
pass with this removal of the only option compatibily check on top:
=09
	diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
	index 58c0ddc5a32..08f18d43334 100644
	--- a/builtin/merge-tree.c
	+++ b/builtin/merge-tree.c
	@@ -476,7 +476,6 @@ int cmd_merge_tree(int argc, const char **argv, const =
char *prefix)
	 {
	 	struct merge_tree_options o =3D { .show_messages =3D -1 };
	 	int expected_remaining_argc;
	-	int original_argc;
=09=20
	 	const char * const merge_tree_usage[] =3D {
	 		N_("git merge-tree [--write-tree] [<options>] <branch1> <branch2>"),
	@@ -505,7 +504,6 @@ int cmd_merge_tree(int argc, const char **argv, const =
char *prefix)
	 	};
=09=20
	 	/* Parse arguments */
	-	original_argc =3D argc;
	 	argc =3D parse_options(argc, argv, prefix, mt_options,
	 			     merge_tree_usage, PARSE_OPT_STOP_AT_NON_OPTION);
	 	if (o.mode) {
	@@ -517,8 +515,6 @@ int cmd_merge_tree(int argc, const char **argv, const =
char *prefix)
	 			usage_with_options(merge_tree_usage, mt_options);
	 		o.mode =3D (argc =3D=3D 2 ? 'w' : 't');
	 	}
	-	if (o.mode =3D=3D 't' && original_argc < argc)
	-		die(_("--trivial-merge is incompatible with all other options"));
=09=20
	 	/* Do the relevant type of merge */
	 	if (o.mode =3D=3D 'w')

So, here it is in all its glory :) A bit nasty for sure, but IMO
preferrable to an ever expanding list of "X isn't compatible with A".

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 58c0ddc5a32..1d47912816d 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -12,6 +12,7 @@
 #include "exec-cmd.h"
 #include "merge-blobs.h"
 #include "quote.h"
+#include "strvec.h"
=20
 static int line_termination =3D '\n';
=20
@@ -371,13 +372,66 @@ static void *get_tree_descriptor(struct repository *r,
 	return buf;
 }
=20
-static int trivial_merge(const char *base,
-			 const char *branch1,
-			 const char *branch2)
+struct merge_tree_options {
+	int mode;
+	int allow_unrelated_histories;
+	int show_messages;
+	int exclude_modes_oids_stages;
+};
+
+#define BUILTIN_MERGE_TREE_USAGE_WRITE \
+		N_("git merge-tree [--write-tree] [<options>] <branch1> <branch2>")
+#define BUILTIN_MERGE_TREE_USAGE_TRIVIAL \
+		N_("git merge-tree [--trivial-merge] <base-tree> <branch1> <branch2>")
+
+#define BUILTIN_MERGE_TREE_OPT_CMDMODE_TRIVIAL \
+		OPT_CMDMODE(0, "trivial-merge", &o.mode, \
+			    N_("do a trivial merge only"), 't')
+
+#define BUILTIN_MERGE_TREE_OPT_CMDMODE_WRITE \
+		OPT_CMDMODE(0, "write-tree", &o.mode, \
+			    N_("do a real merge instead of a trivial merge"), \
+			    'w')
+
+#define BUILTIN_MERGE_TREE_OPT_WRITE \
+		BUILTIN_MERGE_TREE_OPT_CMDMODE_WRITE, \
+		OPT_BOOL(0, "messages", &o.show_messages, \
+			 N_("also show informational/conflict messages")), \
+		OPT_SET_INT('z', NULL, &line_termination, \
+			    N_("separate paths with the NUL character"), '\0'), \
+		OPT_BOOL_F('l', "exclude-modes-oids-stages", \
+			   &o.exclude_modes_oids_stages, \
+			   N_("list conflicted files without modes/oids/stages"), \
+			   PARSE_OPT_NONEG), \
+		OPT_BOOL_F(0, "allow-unrelated-histories", \
+			   &o.allow_unrelated_histories, \
+			   N_("allow merging unrelated histories"), \
+			   PARSE_OPT_NONEG)
+
+static int trivial_merge(int argc, const char **argv, const char *prefix)
 {
 	struct repository *r =3D the_repository;
 	struct tree_desc t[3];
 	void *buf1, *buf2, *buf3;
+	struct merge_tree_options o =3D { 0 };
+	const char * const usage[] =3D {
+		BUILTIN_MERGE_TREE_USAGE_TRIVIAL,
+		NULL,
+	};
+	struct option options[] =3D {
+		BUILTIN_MERGE_TREE_OPT_CMDMODE_TRIVIAL,
+		OPT_END()
+	};
+	const char *base, *branch1, *branch2;
+
+	argc =3D parse_options(argc, argv, prefix, options, usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
+	if (argc !=3D 3)
+		BUG("should have ensured remaining argc =3D=3D 3 already! Got %d", argc);
+
+	base =3D argv[0];
+	branch1 =3D argv[1];
+	branch2 =3D argv[2];;
=20
 	buf1 =3D get_tree_descriptor(r, t+0, base);
 	buf2 =3D get_tree_descriptor(r, t+1, branch1);
@@ -391,24 +445,34 @@ static int trivial_merge(const char *base,
 	return 0;
 }
=20
-struct merge_tree_options {
-	int mode;
-	int allow_unrelated_histories;
-	int show_messages;
-	int exclude_modes_oids_stages;
-};
-
-static int real_merge(struct merge_tree_options *o,
-		      const char *branch1, const char *branch2,
-		      const char *prefix)
+static int real_merge(int argc, const char **argv, const char *prefix)
 {
 	struct commit *parent1, *parent2;
 	struct commit_list *common;
 	struct commit_list *merge_bases =3D NULL;
 	struct commit_list *j;
+	struct merge_tree_options o =3D { .show_messages =3D 1 };
 	struct merge_options opt;
 	struct merge_result result =3D { 0 };
=20
+	const char * const usage[] =3D {
+		BUILTIN_MERGE_TREE_USAGE_WRITE,
+		NULL,
+	};
+	struct option options[] =3D {
+		BUILTIN_MERGE_TREE_OPT_CMDMODE_WRITE,
+		BUILTIN_MERGE_TREE_OPT_WRITE,
+		OPT_END()
+	};
+	const char *branch1, *branch2;
+
+	argc =3D parse_options(argc, argv, prefix, options, usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
+	if (argc !=3D 2)
+		BUG("should have ensured remaining argc =3D=3D 2 already! Got %d", argc);
+	branch1 =3D argv[0];
+	branch2 =3D argv[1];
+
 	parent1 =3D get_merge_parent(branch1);
 	if (!parent1)
 		help_unknown_ref(branch1, "merge-tree",
@@ -431,7 +495,7 @@ static int real_merge(struct merge_tree_options *o,
 	 * merge_incore_recursive in merge-ort.h
 	 */
 	common =3D get_merge_bases(parent1, parent2);
-	if (!common && !o->allow_unrelated_histories)
+	if (!common && !o.allow_unrelated_histories)
 		die(_("refusing to merge unrelated histories"));
 	for (j =3D common; j; j =3D j->next)
 		commit_list_insert(j->item, &merge_bases);
@@ -440,8 +504,8 @@ static int real_merge(struct merge_tree_options *o,
 	if (result.clean < 0)
 		die(_("failure to merge"));
=20
-	if (o->show_messages =3D=3D -1)
-		o->show_messages =3D !result.clean;
+	if (o.show_messages =3D=3D -1)
+		o.show_messages =3D !result.clean;
=20
 	puts(oid_to_hex(&result.tree->object.oid));
 	if (!result.clean) {
@@ -453,7 +517,7 @@ static int real_merge(struct merge_tree_options *o,
 		for (i =3D 0; i < conflicted_files.nr; i++) {
 			const char *name =3D conflicted_files.items[i].string;
 			struct stage_info *c =3D conflicted_files.items[i].util;
-			if (!o->exclude_modes_oids_stages)
+			if (!o.exclude_modes_oids_stages)
 				printf("%06o %s %d\t",
 				       c->mode, oid_to_hex(&c->oid), c->stage);
 			else if (last && !strcmp(last, name))
@@ -464,7 +528,7 @@ static int real_merge(struct merge_tree_options *o,
 		}
 		string_list_clear(&conflicted_files, 1);
 	}
-	if (o->show_messages) {
+	if (o.show_messages) {
 		putchar(line_termination);
 		merge_display_update_messages(&opt, &result, stdout);
 	}
@@ -474,40 +538,32 @@ static int real_merge(struct merge_tree_options *o,
=20
 int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 {
-	struct merge_tree_options o =3D { .show_messages =3D -1 };
+	struct merge_tree_options o;
 	int expected_remaining_argc;
-	int original_argc;
-
+	int original_argc =3D argc;
+	struct strvec original_args =3D STRVEC_INIT;
 	const char * const merge_tree_usage[] =3D {
-		N_("git merge-tree [--write-tree] [<options>] <branch1> <branch2>"),
-		N_("git merge-tree [--trivial-merge] <base-tree> <branch1> <branch2>"),
+		BUILTIN_MERGE_TREE_USAGE_WRITE,
+		BUILTIN_MERGE_TREE_USAGE_TRIVIAL,
 		NULL
 	};
 	struct option mt_options[] =3D {
-		OPT_CMDMODE(0, "write-tree", &o.mode,
-			    N_("do a real merge instead of a trivial merge"),
-			    'w'),
-		OPT_CMDMODE(0, "trivial-merge", &o.mode,
-			    N_("do a trivial merge only"), 't'),
-		OPT_BOOL(0, "messages", &o.show_messages,
-			 N_("also show informational/conflict messages")),
-		OPT_SET_INT('z', NULL, &line_termination,
-			    N_("separate paths with the NUL character"), '\0'),
-		OPT_BOOL_F('l', "exclude-modes-oids-stages",
-			   &o.exclude_modes_oids_stages,
-			   N_("list conflicted files without modes/oids/stages"),
-			   PARSE_OPT_NONEG),
-		OPT_BOOL_F(0, "allow-unrelated-histories",
-			   &o.allow_unrelated_histories,
-			   N_("allow merging unrelated histories"),
-			   PARSE_OPT_NONEG),
+		BUILTIN_MERGE_TREE_OPT_CMDMODE_TRIVIAL,
+		BUILTIN_MERGE_TREE_OPT_CMDMODE_WRITE,
+		BUILTIN_MERGE_TREE_OPT_WRITE,
 		OPT_END()
 	};
=20
+	/* We only care about deciding "o.mode" here */
+	o.mode =3D 0;
+	/*
+	 * We need our original argv, and
+	 * PARSE_OPT_KEEP_{ARGV0,UNKNOWN} would do the wrong thing
+	 */
+	strvec_pushv(&original_args, argv);
 	/* Parse arguments */
-	original_argc =3D argc;
 	argc =3D parse_options(argc, argv, prefix, mt_options,
-			     merge_tree_usage, PARSE_OPT_STOP_AT_NON_OPTION);
+			     merge_tree_usage, 0);
 	if (o.mode) {
 		expected_remaining_argc =3D (o.mode =3D=3D 'w' ? 2 : 3);
 		if (argc !=3D expected_remaining_argc)
@@ -517,12 +573,10 @@ int cmd_merge_tree(int argc, const char **argv, const=
 char *prefix)
 			usage_with_options(merge_tree_usage, mt_options);
 		o.mode =3D (argc =3D=3D 2 ? 'w' : 't');
 	}
-	if (o.mode =3D=3D 't' && original_argc < argc)
-		die(_("--trivial-merge is incompatible with all other options"));
=20
 	/* Do the relevant type of merge */
 	if (o.mode =3D=3D 'w')
-		return real_merge(&o, argv[0], argv[1], prefix);
+		return real_merge(original_argc, original_args.v, prefix);
 	else
-		return trivial_merge(argv[0], argv[1], argv[2]);
+		return trivial_merge(original_argc, original_args.v, prefix);
 }
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tr=
ee.sh
index 4de089d976d..749bdb6862d 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -92,6 +92,18 @@ test_expect_success 'Barf on too many arguments' '
 	grep "^usage: git merge-tree" expect
 '
=20
+for opt in $(git merge-tree --git-completion-helper-all)
+do
+	if test $opt =3D "--trivial-merge" || test $opt =3D "--write-tree"
+	then
+		continue
+	fi
+
+	test_expect_success "usage: --trivial-merge is incompatible with $opt" '
+		test_expect_code 129 git merge-tree --trivial-merge $opt side1 side2 sid=
e3
+	'
+done
+
 test_expect_success 'test conflict notices and such' '
 	test_expect_code 1 git merge-tree --write-tree --exclude-modes-oids-stage=
s side1 side2 >out &&
 	sed -e "s/[0-9a-f]\{40,\}/HASH/g" out >actual &&
