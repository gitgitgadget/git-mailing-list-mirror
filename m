Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4902DC433EF
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 01:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348569AbiBCBWe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 20:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234817AbiBCBWd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 20:22:33 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A7DC061714
        for <git@vger.kernel.org>; Wed,  2 Feb 2022 17:22:32 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id p15so2986493ejc.7
        for <git@vger.kernel.org>; Wed, 02 Feb 2022 17:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=IKJX6PQ5UOerkOdWWPEum6IXctTFJNFtqOYBHb0z+Xw=;
        b=iVuHCcOCq9fEuJH5lJibgWoS9k9Bt76PECiqJ57TPV+N6M1uMyfuCXPPOXKWGJ8FjW
         TD2JOulgPo0dMz82Toz+Xft0UIakPZs9rCJ/I0IoakP4zjJtk3pKWYX/sgnZ3/vYWH3i
         94BgshcEtEq2L3N1t+SFmiG1H6Kiszg+ISXvu5z4tzqUI+lWyz7ZpUy/aLrW9CPATCfq
         CbcVzLCI3NLndamyxCJjE6ny2wqBgLhy0PSrrlsFrAU7s+KPbh6IysGjNKGzm55uGafZ
         Slf2ArBxij268q75sle3QmcCLafpAYDxLPhfeEmZufd/YF9oDrEaKs2JoC0yrFL80NQl
         Q7Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=IKJX6PQ5UOerkOdWWPEum6IXctTFJNFtqOYBHb0z+Xw=;
        b=zlqeJ5qVWg2os1UWeNXdz8UWTO+hb58/A9r+C/TjoxcI+XDH3v6Xgpi5oipLjw8ohr
         u/Zvjm0LwAJLQ9hr+WvTDskGGdb1NVxJsMuSGupVZUsp/R0C58VaA4L4Zmu2de6KqPzW
         DP+m7os2PuVChW3OKLmHVI/LjaPhtREZEIDtDMq4pOqwtff2Bgx3Hs9fiTKwOB1FYzvW
         jYTe99lxkQ63lGZu8senWWNk7++iH5OnAwbxbb1H5EWQ6Gyuuqbf9uGvCwouLUYbluiI
         QR1phunQm584aRgReIE7QzYyRjQtnYZtRt06Wagm5jOYL7++tke81wLhiEQ0+1nHYhs+
         yyxw==
X-Gm-Message-State: AOAM53294ddV+xLXf5It95nyUqG6/OC32e5vEYX6n5x2sBFRnbz9KzBz
        KFxE7AY29EBWG9SzeWOoPpU=
X-Google-Smtp-Source: ABdhPJxrX25fYozrvdMDRIBif44NIg+SyI+tOlQD6x2yXrwliJT1L3TXX110L2ATevQHMcdJw4KTmw==
X-Received: by 2002:a17:907:869e:: with SMTP id qa30mr18158522ejc.163.1643851351020;
        Wed, 02 Feb 2022 17:22:31 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id c5sm21686117edk.43.2022.02.02.17.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 17:22:30 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nFQpR-004oHx-Mf;
        Thu, 03 Feb 2022 02:22:29 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 11/13] merge-tree: provide easy access to `ls-files
 -u` style info
Date:   Thu, 03 Feb 2022 02:08:43 +0100
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
 <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
 <c322e4c6938b7270b6e90998994642074a2813e0.1643479633.git.gitgitgadget@gmail.com>
 <xmqqr18lvts0.fsf@gitster.g>
 <CABPp-BGd38Yb_LaJWLG+oiTit0CVRkE-5vmviGfoUOtBFP6yMg@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CABPp-BGd38Yb_LaJWLG+oiTit0CVRkE-5vmviGfoUOtBFP6yMg@mail.gmail.com>
Message-ID: <220203.86iltw7nhm.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 02 2022, Elijah Newren wrote:

> On Wed, Feb 2, 2022 at 1:32 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>> > @@ -450,7 +451,11 @@ static int real_merge(struct merge_tree_options *o,
>> >               merge_get_conflicted_files(&result, &conflicted_files);
>> >               for (i = 0; i < conflicted_files.nr; i++) {
>> >                       const char *name = conflicted_files.items[i].string;
>> > -                     if (last && !strcmp(last, name))
>> > +                     struct stage_info *c = conflicted_files.items[i].util;
>> > +                     if (!o->exclude_modes_oids_stages)
>> > +                             printf("%06o %s %d\t",
>> > +                                    c->mode, oid_to_hex(&c->oid), c->stage);
>> > +                     else if (last && !strcmp(last, name))
>> >                               continue;
>> >                       write_name_quoted_relative(
>> >                               name, prefix, stdout, line_termination);
>>
>> OK.  The addition (and disabling of the deduping) is quite trivial.
>> We do not even have to worry about line termination since the extra
>> pieces of info are prepended to the pathname.  Nice.
>>
>> > @@ -485,6 +490,10 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
>> >                           N_("do a trivial merge only"), 't'),
>> >               OPT_BOOL(0, "messages", &o.show_messages,
>> >                        N_("also show informational/conflict messages")),
>> > +             OPT_BOOL_F('l', "exclude-modes-oids-stages",
>> > +                        &o.exclude_modes_oids_stages,
>> > +                        N_("list conflicted files without modes/oids/stages"),
>> > +                        PARSE_OPT_NONEG),
>>
>> Why does "-l" give shorter output than without it?  "-l" strongly
>> hints a longer output than without, at least to me.  Just wondering
>> if this will not become a source of confusion to future scripting
>> users.
>
> Here's another example where I was struggling with naming.  Something
> like ls-tree's `--name-only` would have been nice, but I was worried
> it'd be confusing since it only affected the conflicted info section
> and does not suppress the printing of the toplevel tree or the
> informational messages sections.  And the name
> --exclude-modes-oids-stages was long enough that I wanted a short flag
> for it, and just used the first letter of the description ("list
> conflicted files...").  I'm happy to change either the long or the
> short name for this flag if anyone has suggestions.

There's always sidestepping it by replacing it with a --format :)

Anyway, I'd mentioned that in an earlier review in
<220124.864k5tigto.gmgdl@evledraar.gmail.com>. FWIW here's an experiment
to do that that I polished up (mostly copied from the ls-tree WIP code
I'd written already).

I don't know if it will ever be useful, or if you think it's
worthwhile/simpler, but in either case I think in doing this I spotted
the following issues or otherwise noted inconsistencies in the pre-image:

   The docs say that "<stage> <path>" is SP-separated, but it's
   actually TAB-separated, the rest is SP-separated.

 * That you de-dupe --exclude-modes-oids-stages is a bit of a hidden feature,
   but argubly initiative. Should it by optional? In any case my formatting
   experiment makes it optional, since it then needs to be generalized to de-dupe
   after we've formatted.

 * Perhaps we should support --abbrev as ls-tree does? The below diff shows
   it's easy enough.

 * The dance you have with sed-ing out the hash in the tests could be made much
   easier with "sed 1d <out >actual" and --no-messages for some existing tests.

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index 6a2ed475106..e906d1dc9bf 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -44,10 +44,9 @@ OPTIONS
 	newline.  Also begin the messages section with a NUL character
 	instead of a newline.  See OUTPUT below for more information.
 
---exclude-oids-and-modes::
-	Instead of writing a list of (mode, oid, stage, path) tuples
-	to output for conflicted files, just provide a list of
-	filenames with conflicts.
+--conflict-format::
+	Override the default "%(objectmode) %(objectname)
+	%(stage)%x09%(path)" format.
 
 --[no-]messages::
 	Write any informational messages such as "Auto-merging <path>"
@@ -89,13 +88,13 @@ Conflicted file info
 
 This is a sequence of lines with the format
 
-	<mode> <object> <stage> <filename>
+	%(objectmode) %(objectname) %(stage)%x09%(path)
 
 The filename will be quoted as explained for the configuration
-variable `core.quotePath` (see linkgit:git-config[1]).  However, if
-the `--exclude-oids-and-modes` option is passed, the mode, object, and
-stage will be omitted.  If `-z` is passed, the "lines" are terminated
-by a NUL character instead of a newline character.
+variable `core.quotePath` (see linkgit:git-config[1]).
+
+If `-z` is passed, the "lines" are terminated by a NUL character
+instead of a newline character.
 
 Informational messages
 ~~~~~~~~~~~~~~~~~~~~~~
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 58c0ddc5a32..14fed95a8ce 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -395,9 +395,64 @@ struct merge_tree_options {
 	int mode;
 	int allow_unrelated_histories;
 	int show_messages;
-	int exclude_modes_oids_stages;
+	const char *conflict_format;
+	int unique_conflicts;
+	int abbrev;
 };
 
+struct expand_conflict_data {
+	const char *prefix;
+	struct string_list_item *item;
+	struct strbuf *scratch;
+	int abbrev;
+	struct strbuf *sb_tmp;
+};
+static size_t expand_conflict_format(struct strbuf *sb,
+				     const char *start,
+				     void *context)
+{
+	struct expand_conflict_data *data = context;
+	struct string_list_item *item = data->item;
+	struct stage_info *info = item->util;
+	const char *end;
+	const char *p;
+	size_t len;
+
+	len = strbuf_expand_literal_cb(sb, start, NULL);
+	if (len)
+		return len;
+
+	if (*start != '(')
+		die(_("bad format as of '%s'"), start);
+	end = strchr(start + 1, ')');
+	if (!end)
+		die(_("format element '%s' does not end in ')'"), start);
+	len = end - start + 1;
+
+	if (skip_prefix(start, "(objectmode)", &p)) {
+		strbuf_addf(sb, "%06o", info->mode);
+	} else if (skip_prefix(start, "(objectname)", &p)) {
+		strbuf_addstr(sb, find_unique_abbrev(&info->oid, data->abbrev));
+	} else if (skip_prefix(start, "(stage)", &p)) {
+		strbuf_addf(sb, "%d", info->stage);
+	} else if (skip_prefix(start, "(path)", &p)) {
+		const char *name = item->string;
+
+		if (data->prefix)
+			name = relative_path(name, data->prefix, data->scratch);
+		strbuf_addstr(sb, name);
+
+		strbuf_reset(data->sb_tmp);
+		/* The relative_path() function resets "scratch" */
+
+	} else {
+		unsigned int errlen = (unsigned long)len;
+		die(_("bad format specifier %%%.*s"), errlen, start);
+	}
+
+	return len;
+}
+
 static int real_merge(struct merge_tree_options *o,
 		      const char *branch1, const char *branch2,
 		      const char *prefix)
@@ -446,23 +501,43 @@ static int real_merge(struct merge_tree_options *o,
 	puts(oid_to_hex(&result.tree->object.oid));
 	if (!result.clean) {
 		struct string_list conflicted_files = STRING_LIST_INIT_NODUP;
-		const char *last = NULL;
-		int i;
+		struct string_list_item *item;
+		char *last = NULL;
+		struct strbuf sb = STRBUF_INIT;
+		struct strbuf tmp = STRBUF_INIT;
 
 		merge_get_conflicted_files(&result, &conflicted_files);
-		for (i = 0; i < conflicted_files.nr; i++) {
-			const char *name = conflicted_files.items[i].string;
-			struct stage_info *c = conflicted_files.items[i].util;
-			if (!o->exclude_modes_oids_stages)
-				printf("%06o %s %d\t",
-				       c->mode, oid_to_hex(&c->oid), c->stage);
-			else if (last && !strcmp(last, name))
+		for_each_string_list_item(item, &conflicted_files) {
+			struct expand_conflict_data ctx = {
+				.prefix = prefix,
+				.item = item,
+				.abbrev = o->abbrev,
+				.scratch = &sb,
+				.sb_tmp = &tmp,
+			};
+
+			strbuf_expand(&sb, o->conflict_format, expand_conflict_format, &ctx);
+			strbuf_addch(&sb, line_termination);
+
+			if (o->unique_conflicts && last && !strcmp(last, sb.buf)) {
+				free(last);
+				last = strbuf_detach(&sb, NULL);
 				continue;
-			write_name_quoted_relative(
-				name, prefix, stdout, line_termination);
-			last = name;
+			}
+
+			fwrite(sb.buf, sb.len, 1, stdout);
+
+			if (o->unique_conflicts) {
+				free(last);
+				last = strbuf_detach(&sb, NULL);
+			} else {
+				strbuf_reset(&sb);
+			}
 		}
 		string_list_clear(&conflicted_files, 1);
+		strbuf_release(&sb);
+		strbuf_release(&tmp);
+		free(last);
 	}
 	if (o->show_messages) {
 		putchar(line_termination);
@@ -474,7 +549,11 @@ static int real_merge(struct merge_tree_options *o,
 
 int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 {
-	struct merge_tree_options o = { .show_messages = -1 };
+	struct merge_tree_options o = {
+		.show_messages = -1,
+		.conflict_format = "%(objectmode) %(objectname) %(stage)%x09%(path)",
+		.unique_conflicts = 1,
+	};
 	int expected_remaining_argc;
 	int original_argc;
 
@@ -493,14 +572,15 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 			 N_("also show informational/conflict messages")),
 		OPT_SET_INT('z', NULL, &line_termination,
 			    N_("separate paths with the NUL character"), '\0'),
-		OPT_BOOL_F('l', "exclude-modes-oids-stages",
-			   &o.exclude_modes_oids_stages,
-			   N_("list conflicted files without modes/oids/stages"),
-			   PARSE_OPT_NONEG),
+		OPT_STRING(0, "conflict-format", &o.conflict_format, N_("format"),
+			   N_("specify a custom format to use for conflicted files")),
+		OPT_BOOL(0, "unique-conflicts", &o.unique_conflicts,
+			 N_("omit duplicate --conflict-format lines")),
 		OPT_BOOL_F(0, "allow-unrelated-histories",
 			   &o.allow_unrelated_histories,
 			   N_("allow merging unrelated histories"),
 			   PARSE_OPT_NONEG),
+		OPT__ABBREV(&o.abbrev),
 		OPT_END()
 	};
 
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index 4de089d976d..e6354b2d284 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -93,7 +93,7 @@ test_expect_success 'Barf on too many arguments' '
 '
 
 test_expect_success 'test conflict notices and such' '
-	test_expect_code 1 git merge-tree --write-tree --exclude-modes-oids-stages side1 side2 >out &&
+	test_expect_code 1 git merge-tree --write-tree --conflict-format="%(path)" side1 side2 >out &&
 	sed -e "s/[0-9a-f]\{40,\}/HASH/g" out >actual &&
 
 	# Expected results:
@@ -115,8 +115,35 @@ test_expect_success 'test conflict notices and such' '
 	test_cmp expect actual
 '
 
+test_expect_success 'merge-tree --unique-conflicts is the default' '
+	test_expect_code 1 git merge-tree --write-tree --conflict-format="%(path)" --no-messages side1 side2 >out &&
+	sed 1d <out >actual &&
+	cat >expect <<-\EOF &&
+	greeting
+	whatever~side1
+	EOF
+	test_cmp expect actual &&
+
+	test_expect_code 1 git merge-tree --write-tree --conflict-format="%(path)" --no-messages side1 side2 >out2 &&
+	sed 1d <out2 >actual2 &&
+	test_cmp actual actual2
+'
+
+test_expect_success 'merge-tree --no-unique-conflicts' '
+	test_expect_code 1 git merge-tree --write-tree --conflict-format="%(path)" --no-unique-conflicts --no-messages side1 side2 >out &&
+	sed 1d <out >actual &&
+	cat >expect <<-\EOF &&
+	greeting
+	greeting
+	greeting
+	whatever~side1
+	whatever~side1
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'Just the conflicted files without the messages' '
-	test_expect_code 1 git merge-tree --write-tree --no-messages --exclude-modes-oids-stages side1 side2 >out &&
+	test_expect_code 1 git merge-tree --write-tree --no-messages --conflict-format="%(path)" side1 side2 >out &&
 	sed -e "s/[0-9a-f]\{40,\}/HASH/g" out >actual &&
 
 	test_write_lines HASH greeting whatever~side1 >expect &&
