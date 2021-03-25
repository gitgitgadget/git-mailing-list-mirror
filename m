Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7AAC433DB
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 03:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFD7961A24
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 03:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbhCYDm3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 23:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhCYDmB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 23:42:01 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AE6C06174A
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 20:42:00 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id h10so774985edt.13
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 20:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=scqnZdRuyWv7RUYuopqxAutN5cnGN2IpxNAFG0WH6+o=;
        b=Tsu5q/KckmcsJiFusDOl6mpRL5noCjExvW+NZAo5qHLpn1gOBh548kPNiQ4CrTkMyY
         KbqIATqWgTvwMdBpYgcIny0271llW+PiQMmslxpZV5tAtVsx3N27EsWERH4HTiOD/KZ6
         1LY5MXdiWO3zXzpQpqX15Fs5H46p9NRUqSJZdUWqrRDDQUDz+EHvlgChGNYoKCLxU8l1
         2FUPM8RQz8oKaIWTWAC4jq5ZzE7bi3R4rRdzEOJ5RW0aCmC+JmB0Ives+Yjz+15ukE52
         UmL2SVqyUdgETJ6lmR88uhGl4ehFNVemoSK4teK02VCLmhp1fPF7zW62WYp4BQ0dI0sw
         GvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=scqnZdRuyWv7RUYuopqxAutN5cnGN2IpxNAFG0WH6+o=;
        b=U2vIDoAkeQ8PdcykeANL5FZizolKAEH6c8hW4XOILYd6ht1xWUGCkcMxBtqR4t1A70
         EVaG/QjFhLseKBGlApF/m2NBPrJ3rltcRdnYU7e+ecvNeZEXoUNbDOHOEx0ZozAdbAqU
         fiWcFtP5oqpNePQ+VMSrzhOxuiHVWeL23bGFOvev6wHhSTqTQp0QJ0Vl9R8BRrEwdiRG
         U9M7PnYLpOjVyFMAX7M5BDONq00bE39YurpPV9JnCcqk8LXbPYS12oRs4Jzf1B3IMdGt
         i65/zq4o+WOa6Srr77TcmcKquOrDhctDd3hCf76M0eoQjKM63w9jtsT/M8Q6czrll2M/
         sLFg==
X-Gm-Message-State: AOAM533s5IW2szV3/vXKKWG3eTerNMOl3Cl20J6Omxt0PV9tAcZ7nct+
        dak8CQ2FZ+MUZ7mbaIIpWk++5bSyyzcjxQ==
X-Google-Smtp-Source: ABdhPJw571kvpDpK9IkaRqsmjIeqO5lBopwIvUOmrGCVOm6XTiXZAnBwMm7PrX1kXsxCZsW9nxxVSQ==
X-Received: by 2002:a05:6402:520b:: with SMTP id s11mr6928391edd.212.1616643718606;
        Wed, 24 Mar 2021 20:41:58 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id c17sm2089736edw.32.2021.03.24.20.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 20:41:58 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, newren@gmail.com, gitster@pobox.com,
        pclouds@gmail.com, jrnieder@gmail.com,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 07/20] test-read-cache: print cache entries with --table
References: <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
 <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
 <7ebd9570b1ad81720569a770526651c62c152b9f.1616507069.git.gitgitgadget@gmail.com>
 <87r1k5pcmx.fsf@evledraar.gmail.com>
 <ca8a96a4-5897-2484-b195-57e5b3820576@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <ca8a96a4-5897-2484-b195-57e5b3820576@gmail.com>
Date:   Thu, 25 Mar 2021 04:41:57 +0100
Message-ID: <874kgzq4qi.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 24 2021, Derrick Stolee wrote:

> On 3/23/21 9:24 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Tue, Mar 23 2021, Derrick Stolee via GitGitGadget wrote:
>>=20
>>> From: Derrick Stolee <dstolee@microsoft.com>
>>>
>>> This table is helpful for discovering data in the index to ensure it is
>>> being written correctly, especially as we build and test the
>>> sparse-index. This table includes an output format similar to 'git
>>> ls-tree', but should not be compared to that directly. The biggest
>>> reasons are that 'git ls-tree' includes a tree entry for every
>>> subdirectory, even those that would not appear as a sparse directory in
>>> a sparse-index. Further, 'git ls-tree' does not use a trailing directory
>>> separator for its tree rows.
>>>
>>> This does not print the stat() information for the blobs. That will be
>>> added in a future change with another option. The tests that are added
>>> in the next few changes care only about the object types and IDs.
>>> However, this future need for full index information justifies the need
>>> for this test helper over extending a user-facing feature, such as 'git
>>> ls-files'.
>>=20
>> Is that stat() information that's going to be essential to grab in the
>> same process that runs the "for (i =3D 0; i < istate->cache_nr; i++)"
>> for-loop, or stat() information that could be grabbed as:
>>=20
>>     git ls-files -z --stage | some-program-that-stats-all-listed-blobs
>
> The point is not to find the stat() data from disk, but to ensure that
> the stat() data is correctly stored in the index (say, after converting
> an existing index from another format). This pipe strategy does not
> allow for that scenario.

So a dump of ce->ce_stat_data, i.e. the same thing ls-files --debug
prints out now, or...?

>> It's not so much that I still disagree as I feel like I'm missing
>> something. I haven't gone through this topic with a fine toothed comb,
>> so ...
>>=20
>> If and when these patches land and I'm using this nascent sparse
>> checkout support why wouldn't I want ls-files or another not-a-test-tool
>> to support extracting this new information that's in the index?
>>=20
>> That's why I sent the RFC patches at
>> https://lore.kernel.org/git/20210317132814.30175-2-avarab@gmail.com/ to
>> roll this functionality into ls-files.
>
> And I recommend that you continue to pursue them as an independent
> series, but I'm not going to incorporate them into this one. I'm
> not going to distract from this internal data structure with changes
> to user-facing commands until I think it's ready to use. As the design
> document describes the plan, I don't expect this to be something I
> will recommend to users until most of "Phase 3" is complete, making
> the most common Git commands aware of a sparse index. (I expect to
> fast-track a prototype to willing users that covers that functionality
> while review continues on the mailing list.)

This series is 20 patches. Your current derrickstolee/sparse-index/wip
is another 36, and from skimming those patches & your design doc those
56 seem to be partway into Phase I of IV.

So at the rate things tend to get reviewed / re-rolled & land in git.git
it seems exceedingly likely that we'll have some part-way implementation
of this for at least a major release or two. No?

Which is why I'm suggesting/asking if we shouldn't have something like
this debugging helper as part of installed tooling, because people are
going to try it, it's probably going to have bugs and do other weird
things, and I'd rather not have to manually build some test-tool to
debug some local sparse checkout somewhere.

> Making a change to a builtin is _forever_, and since the only
> purpose right now is to expose the data in a test environment, I
> don't want to adjust the builtin until either there is a real user
> need or the feature has otherwise stabilized. If you want to take on
> that responsibility, then please do.

That's just not the case, we have plenty of unstable debug-esque options
in various built-in commands, in fact ls-files already has a --debug
option whose docs say:

    This is intended to show as much information as possible for manual
    inspection; the exact format may change at any time.

It was added in 84974217151 (ls-files: learn a debugging dump format,
2010-07-31) and "just tacks all available data from the cache onto each
file's line" so in a way not adjusting it and using it would be a
regression, after all this is new data in the cache, so it should print
it :)

There's also PARSE_OPT_HIDDEN for other such in-tree use. Whatever the
sanity/merits of me suggesting that this specific thing be in ls-files
instead of a test-helper, it seems far fetched that something like that
hidden behind a GIT_TEST_* env var (or hidden option, --debug etc.) is
something we'd need to worry about backwards compatibility for.

So, whatever you think about the merits of including this functionality
in ls-files I think your stance of this being a no-go for adding to the
builtin is based on a false premise. It's fine to have
unstable/transitory/debug output in the builtins. We just name &
document them as such.

I also had some feedback in that series and on the earlier iteration
that I think is appropriate to be incorporated into a re-roll of this
one, which doesn't have anything to do with the question of whether we
use ls-files or the helper in the tests. Such as us showing more stuff
into the read-cache.c test-tool v.s. splitting it up making that code
needlessly convoluted.

I don't see how recommending that I pursue that as an independent series
is productive for anyone. So as you re-roll this I should submit another
series on top to refactor your in-flight code & tests?

Either my suggestions are just bad, and we shouldn't do them at all, or
it makes sense to incorporate relevant feedback in re-rolls. I'll let
other reviewers draw their own conclusions on that.

That's not a snarky "I'm right" b.t.w., I may honestly be full of it on
this particular topic.

But if those suggested changes are worth doing at all, then doing them
in that way seems like a massive waste of time for everyone involved, or
maybe I'm not getting what you're suggesting by pursuing them as an
independent series.

> Otherwise, I will need to eventually handle "git ls-files" being
> sparse-aware when eventually removing 'command_requires_full_index',
> (Phase 4) so that would be a good opportunity to adjust the
> expectations.

At which point you'd be adjusting your tests that expect ls-tree format
output to using ls-files output, instead of using ls-files-like output
from the beginning?

At the end of this E-Mail is a patch on top that adds an undocumented
--debug-sparse in addition to the existing --debug. Running that in the
middle of one of your tests:
=20=20=20=20
    $ ~/g/git/git ls-files --debug -- a folder1
    a
      ctime: 1616641434:474004002
      mtime: 1616641434:474004002
      dev: 2306     ino: 28576528
      uid: 1001     gid: 1001
      size: 8       flags: 0
    folder1/a
      ctime: 0:0
      mtime: 0:0
      dev: 0        ino: 0
      uid: 0        gid: 0
      size: 0       flags: 40000000
    $ ~/g/git/git ls-files --debug --debug-sparse -- a folder1
    a=20
      ctime: 1616641434:474004002
      mtime: 1616641434:474004002
      dev: 2306     ino: 28576528
      uid: 1001     gid: 1001
      size: 8       flags: 0
    folder1/
      ctime: 0:0
      mtime: 0:0
      dev: 0        ino: 0
      uid: 0        gid: 0
      size: 0       flags: 40004000
    $ ~/g/git/git ls-files --stage -- a folder1
    100644 e79c5e8f964493290a409888d5413a737e8e5dd5 0       a
    100644 e79c5e8f964493290a409888d5413a737e8e5dd5 0       folder1/a
    $ ~/g/git/git ls-files --stage --debug-sparse -- a folder1
    100644 e79c5e8f964493290a409888d5413a737e8e5dd5 0       a
    040000 f203181537ff55dcf7896bf8c5b5c35af1514421 0       folder1/

I.e. it gives you everything your helper does and more with a trivial
addition of a --debug-sparse (which we can later just remove, it's a
debug option...).

See e.g. my recent 15c9649730d (grep/log: remove hidden --debug and
--grep-debug options, 2021-01-26) which is already in a release, and
AFAICT nobody has noticed or cared.

I don't know if that's the stat() information you wanted (your WIP
branch doesn't have such a change), but presumably it either is the info
you want, or ls-files's --debug would want to emit any such such info
that's now missing too.

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 13bcc2d8473..e691512d4f8 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -34,6 +34,7 @@ static int show_valid_bit;
 static int show_fsmonitor_bit;
 static int line_terminator =3D '\n';
 static int debug_mode;
+static int debug_sparse_mode;
 static int show_eol;
 static int recurse_submodules;
 static int skipping_duplicates;
@@ -242,9 +243,17 @@ static void show_ce(struct repository *repo, struct di=
r_struct *dir,
 		if (!show_stage) {
 			fputs(tag, stdout);
 		} else {
+			unsigned int mode =3D ce->ce_mode;
+			if (debug_sparse_mode && S_ISSPARSEDIR(mode))
+				/*
+				 * We could just do & 0177777 all the
+				 * time, just make it clear this is
+				 * for --debug-sparse.
+				 */
+				mode &=3D 0177777;
 			printf("%s%06o %s %d\t",
 			       tag,
-			       ce->ce_mode,
+			       mode,
 			       find_unique_abbrev(&ce->oid, abbrev),
 			       ce_stage(ce));
 		}
@@ -667,6 +676,7 @@ int cmd_ls_files(int argc, const char **argv, const cha=
r *cmd_prefix)
 			N_("pretend that paths removed since <tree-ish> are still present")),
 		OPT__ABBREV(&abbrev),
 		OPT_BOOL(0, "debug", &debug_mode, N_("show debugging data")),
+		OPT_BOOL(0, "debug-sparse", &debug_sparse_mode, N_("show sparse debuggin=
g data")),
 		OPT_BOOL(0, "deduplicate", &skipping_duplicates,
 			 N_("suppress duplicate entries")),
 		OPT_END()
@@ -681,9 +691,6 @@ int cmd_ls_files(int argc, const char **argv, const cha=
r *cmd_prefix)
 		prefix_len =3D strlen(prefix);
 	git_config(git_default_config, NULL);
=20
-	if (repo_read_index(the_repository) < 0)
-		die("index file corrupt");
-
 	argc =3D parse_options(argc, argv, prefix, builtin_ls_files_options,
 			ls_files_usage, 0);
 	pl =3D add_pattern_list(&dir, EXC_CMDL, "--exclude option");
@@ -700,6 +707,10 @@ int cmd_ls_files(int argc, const char **argv, const ch=
ar *cmd_prefix)
 		tag_skip_worktree =3D "S ";
 		tag_resolve_undo =3D "U ";
 	}
+	if (debug_sparse_mode) {
+		prepare_repo_settings(the_repository);
+		the_repository->settings.command_requires_full_index =3D 0;
+	}
 	if (show_modified || show_others || show_deleted || (dir.flags & DIR_SHOW=
_IGNORED) || show_killed)
 		require_work_tree =3D 1;
 	if (show_unmerged)
@@ -743,6 +754,12 @@ int cmd_ls_files(int argc, const char **argv, const ch=
ar *cmd_prefix)
 		max_prefix =3D common_prefix(&pathspec);
 	max_prefix_len =3D get_common_prefix_len(max_prefix);
=20
+	/*
+	 * Read the index after parse options etc. have had a chance
+	 * to die early.
+	 */
+	if (repo_read_index(the_repository) < 0)
+		die("index file corrupt");
 	prune_index(the_repository->index, max_prefix, max_prefix_len);
=20
 	/* Treat unmatching pathspec elements as errors */
