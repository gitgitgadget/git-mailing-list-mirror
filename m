Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E209C433EF
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 21:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240826AbiGNV2H (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 17:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240795AbiGNV17 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 17:27:59 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A23426AC0
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 14:27:57 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id fy29so4561437ejc.12
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 14:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=mQ+rw6Lciyb1G8r9n4v5mLl37BHDT6TIGu7cR6RSO1M=;
        b=U44PQxqx6Aw6X9apKCuiY4D4mJsoT/hghSozX6iEx8b6crQjxhLdtHlwbxmfccgbN8
         lVm67wSet/3DwdrIgA4iRbrlophIOwoE07ihIApxWRy9dOz2GUUCGhm1hxHvdvziq8C0
         y7Dq6zqR+YCIoy0EGboznWvNoGzQ6c3rSu/PXXkkdn5lmHiGtiadMhpynAP3GPDVQ5SM
         Kr9dNWqkfxd3HwZUqtiXeFX4zVxlw71NHfgg9+2IsJWVCjkQ8kD1P9zvA//cTTGm3lA6
         BCW8fgnp/STxeLLO4+4diDDNHEX46wXBiw+Hbquh5bj+hQbgvg7v4/D8a1QjVou2Qicz
         kpSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=mQ+rw6Lciyb1G8r9n4v5mLl37BHDT6TIGu7cR6RSO1M=;
        b=Ufsmm75YFPMoVV8/9bif7/Lsm39pmBLU9bAj5POHH3CbFapYAH3uwI20UBw8kA8oh3
         p6ARaqWismQ1JCfWx5IXbnkCzKQU5eyiGvD1e9FioXwlChE2s5V8gvtKFGg/EnQ9Qzs5
         hBTk7nOg37vbjSAuZzsrH7zr0ZCqmFA8ILjPEnaT8iUi4qFgsk0BQ2uAisGc0LtljZXn
         iCcXcg62R/dWKe9gxcAU0ZyX9FySIM3M+m9Ipc5TQunEei4PYXhf2pewZCaIIgJ1Joag
         PDAErc9dxP/6ZkHw54/Ml68i5qJfms8BL6fFla4qo5fFsJOx1c+0Dizqhm7kMBEVSTiY
         QnoA==
X-Gm-Message-State: AJIora9TDMlSjmU2pR34/DdHGJA9Ihjy/e/IYTRnui+u8sfpnZEBv1dD
        tOcpYhnuZOpNWBC5rFphuYwgiqRU7I4HAw==
X-Google-Smtp-Source: AGRyM1trpEKDF3Y3woN4Q2y3TmkDTLu/d90a78ZOjZwsvO3OkEXan8mD+VKgdE/k1lnotBklFrg4mA==
X-Received: by 2002:a17:907:2c6a:b0:72b:52eb:1681 with SMTP id ib10-20020a1709072c6a00b0072b52eb1681mr10812273ejc.232.1657834075540;
        Thu, 14 Jul 2022 14:27:55 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id t18-20020a1709067c1200b00722bc0aa9e3sm1142149ejo.162.2022.07.14.14.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 14:27:54 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oC6NG-002VSb-0F;
        Thu, 14 Jul 2022 23:27:54 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/3] doc: unify config info on some cmds
Date:   Thu, 14 Jul 2022 23:17:25 +0200
References: <cover.1657819649.git.matheus.bernardino@usp.br>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <cover.1657819649.git.matheus.bernardino@usp.br>
Message-ID: <220714.86ilnz1j1i.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 14 2022, Matheus Tavares wrote:

> These three patches attempt to remove duplication between some
> config/*.txt and git-*.txt files, to facilitate maintenance and fix any
> divergences.
>
> This series targets the most straightforward conversions, but there are
> also other commands whose config documentation could possibly be unified
> (maybe #leftoverbits):

Great think alike & all that, these patches are pretty much what I've
had locally & been meaning to submit for (check notes) around a year and
a half. So having this move forward is great.

Here's a cleaned up version of what I have, which I figure is probably
better linked-to than contributing to my E-Mail quota :):

	https://github.com/git/git/compare/master...avar:git:avar/doc-config-inclu=
des

I cleaned that up just now for this discussion, but I've had these
relatively more messy changes on top too, but I think those could/should
follow:

	https://github.com/avar/git/compare/avar/doc-config-includes...avar:git:av=
ar/doc-config-includes-split

I in that second part I end up e.g. splitting config/gc.txt into that
and config/gc/rerere.txt, so that we can include the latter in both
config/gc.txt (which is included in git-gc.txt) and in git-rerere.txt
(along with config/rerere.txt itself).

I.e. to have all CONFIGURATION sections discuss all the config relevant
to that command, if possible. Not just in the straightforward cases, but
also e.g. the "rerere" case where it needs to "borrow" a part of the
"gc" section.

Another notable one is the config/color.txt, i.e. we want "git branch"
and the like to discuss its part of the "color" configuration.

Anyway, I'm happy to have your versions of this, although maybe the
range-diff below is useful to you to see if there's anything you'd like
to change or steal (it's to the part one above).

The one thing I'd like you to reconsider is to drop the idea of adding
these "ifndef::git-grep[]" defines and the like. In your version it
yields an arguably better result.

But I think what we should be going for is the more general direction
outlined above, at which point that becomes quite a mess of
ifdefs. I.e. config/gc/rerere.txt would need to know what it's going to
get include in, which would be N number of manpages in the genreal case,
not just "main or config" as this series leaves it.

I think the solution I have to that in 1/9 in that first series is a
better trade-off, i.e. we just (eventually, your series doesn't need to
do that) include some standard wording saying that what you're looking
at in git-CMD(1) is transcluded as-is from the relevant part of
git-config(1). I.e.:

	Everything below this line in this section is selectively included
	from the linkgit:git-config[1] documentation. The content is the same
	as what's found there:

What do you think about doing that instead?

 -:  ----------- >  1:  5d0a4562ea8 docs: add and use include template for =
config/* includes
 -:  ----------- >  2:  450a9d82bf2 docs: include a CONFIGURATION section
 -:  ----------- >  3:  03cdf2d4e4e docs: add includes to the CONFIGURATION=
 section
 -:  ----------- >  4:  959b6ccd6e2 docs: move config discussion to CONFIGU=
RATION section
 1:  439cfdf858f !  5:  f20f207ece7 doc: grep: unify configuration variable=
s definitions
    @@
      ## Metadata ##
    -Author: Matheus Tavares <matheus.bernardino@usp.br>
    +Author: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
=20=20=20=20=20
      ## Commit message ##
    -    doc: grep: unify configuration variables definitions
    +    grep docs: de-duplicate configuration sections
=20=20=20=20=20
    -    The configuration variables for git-grep are duplicated in
    -    "Documentation/git-grep.txt" and "Documentation/config/grep.txt", =
which
    -    gqcan make maintenance difficult. The first also contains a defini=
tion
    -    that is not present in the latter (grep.fullName), and the latter
    -    received a wording improvement that was not replicated in the form=
er:
    -    see 91028f765 ("grep: clarify what `grep.patternType=3Ddefault` me=
ans",
    -    2021-12-05).
    +    Include the "config/grep.txt" file in "git-grep.txt", instead of
    +    repeating an almost identical description of the "grep" configurat=
ion
    +    variables in two places.
=20=20=20=20=20
    -    To avoid such problems, unify the information in one file and incl=
ude it
    -    in the other.
    +    There is no loss of information here that isn't shown in the addit=
ion
    +    to "grep.txt". This change was made by copying the contents of
    +    "git-grep.txt"'s version over the "grep.txt" version. Aside from t=
he
    +    change "grep.txt" being made here the two were identical.
=20=20=20=20=20
    -    Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
    +    This documentation started being copy/pasted around in
    +    b22520a37c8 (grep: allow -E and -n to be turned on by default via
    +    configuration, 2011-03-30). After that in e.g. 6453f7b3486 (grep: =
add
    +    grep.fullName config variable, 2014-03-17) they started drifting
    +    apart, with only grep.fullName being described in the command
    +    documentation.
    +
    +    In 434e6e753fe (config.txt: move grep.* to a separate file,
    +    2018-10-27) we gained the include, but didn't do this next step, l=
et's
    +    do it now.
    +
    +    Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmai=
l.com>
=20=20=20=20=20
      ## Documentation/config/grep.txt ##
     @@ Documentation/config/grep.txt: grep.extendedRegexp::
    @@ Documentation/config/grep.txt: grep.extendedRegexp::
      grep.threads::
     -	Number of grep worker threads to use.
     -	See `grep.threads` in linkgit:git-grep[1] for more information.
    -+	Number of grep worker threads to use. See `--threads`
    -+ifndef::git-grep[]
    -+	in linkgit:git-grep[1]
    -+endif::git-grep[]
    -+	for more information.
    ++	Number of grep worker threads to use. If unset (or set to 0), Git wi=
ll
    ++	use as many threads as the number of logical cores available.
     +
     +grep.fullName::
     +	If set to true, enable `--full-name` option by default.
    @@ Documentation/config/grep.txt: grep.extendedRegexp::
      	If set to true, fall back to git grep --no-index if git grep
=20=20=20=20=20
      ## Documentation/git-grep.txt ##
    -@@ Documentation/git-grep.txt: registered in the index file, or blobs =
in given tree objects.  Patterns
    - are lists of one or more search expressions separated by newline
    - characters.  An empty string as search expression matches all lines.
    -=20
    --
    - OPTIONS
    - -------
    - --cached::
    -@@ Documentation/git-grep.txt: providing this option will cause it to =
die.
    - 	custom hunk-header' in linkgit:gitattributes[5]).
    -=20
    - --threads <num>::
    --	Number of grep worker threads to use.
    --	See `grep.threads` in 'CONFIGURATION' for more information.
    -+	Number of grep worker threads to use. If not provided (or set to
    -+	0), Git will use as many worker threads as the number of logical
    -+	cores available. The default value can also be set with the
    -+	`grep.threads` configuration.
    -=20
    - -f <file>::
    - 	Read patterns from <file>, one per line.
     @@ Documentation/git-grep.txt: performance in this case, it might be d=
esirable to use `--threads=3D1`.
      CONFIGURATION
      -------------
    @@ Documentation/git-grep.txt: performance in this case, it might be de=
sirable to u
     -grep.fallbackToNoIndex::
     -	If set to true, fall back to git grep --no-index if git grep
     -	is executed outside of a git repository.  Defaults to false.
    --
    -+:git-grep: 1
    ++include::includes/cmd-config-section-all.txt[]
    +=20
     +include::config/grep.txt[]
=20=20=20=20=20=20
      GIT
 2:  a25a6d89647 <  -:  ----------- doc: apply: unify configuration variabl=
es definitions
 -:  ----------- >  6:  58f8fccef11 send-email docs: de-duplicate configura=
tion sections
 -:  ----------- >  7:  acb6fc2aef5 apply docs: de-duplicate configuration =
sections
 3:  699dda58fc6 !  8:  c8725b99483 doc: notes: unify config variable defin=
itions
    @@
      ## Metadata ##
    -Author: Matheus Tavares <matheus.bernardino@usp.br>
    +Author: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
=20=20=20=20=20
      ## Commit message ##
    -    doc: notes: unify config variable definitions
    +    notes docs: de-duplicate configuration sections
=20=20=20=20=20
    -    Unify duplicated configuration descriptions from git-notes.txt and
    -    config.txt in order to facilitate maintenance and update. There ar=
e some
    -    discrepancies between these two files: git-notes.txt received two
    -    updates that were not made in config.txt: see 66c4c32
    -    ("Documentation/notes: simplify treatment of default display refs",
    -    2010-05-08) and c5ce183 ("Documentation/notes: clean up descriptio=
n of
    -    rewriting configuration", 2010-05-08 ). And there was also an upda=
te to
    -    config.txt not propagated to git-notes.txt: see 2b4aa89 ("Document=
ation:
    -    basic configuration of notes.rewriteRef", 2011-09-13). Let's make =
sure
    -    to include all these three updates in the unified version.
    +    Let's also fix the "git-notes(1)" docs so that we link to
    +    "git-config(1)", not "git-log(1)" as a reference for the "notes" d=
ocs.
=20=20=20=20=20
    -    Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
    +    Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmai=
l.com>
=20=20=20=20=20
      ## Documentation/config/notes.txt ##
     @@ Documentation/config/notes.txt: notes.mergeStrategy::
    - 	Which merge strategy to choose by default when resolving notes
      	conflicts.  Must be one of `manual`, `ours`, `theirs`, `union`, or
      	`cat_sort_uniq`.  Defaults to `manual`.  See "NOTES MERGE STRATEGIES"
    --	section of linkgit:git-notes[1] for more information on each strateg=
y.
    -+	section
    -+ifdef::git-notes[above]
    -+ifndef::git-notes[of linkgit:git-notes[1]]
    -+	for more information on each strategy.
    + 	section of linkgit:git-notes[1] for more information on each strateg=
y.
    +++
    ++This setting can be overridden by passing the `--strategy` option to
    ++linkgit:git-notes[1].
=20=20=20=20=20=20
      notes.<name>.mergeStrategy::
      	Which merge strategy to choose when doing a notes merge into
    - 	refs/notes/<name>.  This overrides the more general
    --	"notes.mergeStrategy".  See the "NOTES MERGE STRATEGIES" section in
    --	linkgit:git-notes[1] for more information on the available strategie=
s.
    -+	"notes.mergeStrategy".  See the "NOTES MERGE STRATEGIES" section
    -+ifdef::git-notes[above]
    -+ifndef::git-notes[in linkgit:git-notes[1]]
    -+	for more information on the available strategies.
    +@@ Documentation/config/notes.txt: notes.<name>.mergeStrategy::
    + 	linkgit:git-notes[1] for more information on the available strategie=
s.
=20=20=20=20=20=20
      notes.displayRef::
     -	The (fully qualified) refname from which to show notes when
    @@ Documentation/config/notes.txt: notes.mergeStrategy::
     -	several times.  A warning will be issued for refs that do not
     -	exist, but a glob that does not match any refs is silently
     -	ignored.
    --+
    --This setting can be overridden with the `GIT_NOTES_DISPLAY_REF`
    --environment variable, which must be a colon separated list of refs or
    --globs.
    --+
    --The effective value of "core.notesRef" (possibly overridden by
    --GIT_NOTES_REF) is also implicitly added to the list of refs to be
    --displayed.
     +	Which ref (or refs, if a glob or specified more than once), in
     +	addition to the default set by `core.notesRef` or
     +	`GIT_NOTES_REF`, to read notes from when showing commit
     +	messages with the 'git log' family of commands.
    -+	This setting can be overridden on the command line or by the
    -+	`GIT_NOTES_DISPLAY_REF` environment variable.
    -+	See linkgit:git-log[1].
    + +
    + This setting can be overridden with the `GIT_NOTES_DISPLAY_REF`
    + environment variable, which must be a colon separated list of refs or
    + globs.
    + +
    ++A warning will be issued for refs that do not exist,
    ++but a glob that does not match any refs is silently ignored.
    +++
    ++This setting can be disabled by the `--no-notes` option to the 'git
    ++log' family of commands, or by the `--notes=3D<ref>` option accepted =
by
    ++those commands.
    +++
    + The effective value of "core.notesRef" (possibly overridden by
    + GIT_NOTES_REF) is also implicitly added to the list of refs to be
    + displayed.
=20=20=20=20=20=20
      notes.rewrite.<command>::
      	When rewriting commits with <command> (currently `amend` or
    @@ Documentation/config/notes.txt: notes.mergeStrategy::
     +	notes from the original to the rewritten commit.  Defaults to
     +	`true`.  See also "`notes.rewriteRef`" below.
     ++
    -+This setting can be overridden by the `GIT_NOTES_REWRITE_REF`
    -+environment variable.
    ++This setting can be overridden with the `GIT_NOTES_REWRITE_REF`
    ++environment variable, which must be a colon separated list of refs or
    ++globs.
=20=20=20=20=20=20
      notes.rewriteMode::
    --	When copying notes during a rewrite (see the
    --	"notes.rewrite.<command>" option), determines what to do if
    --	the target commit already has a note.  Must be one of
    --	`overwrite`, `concatenate`, `cat_sort_uniq`, or `ignore`.
    --	Defaults to `concatenate`.
    -+	When copying notes during a rewrite, what to do if the target
    -+	commit already has a note.  Must be one of `overwrite`,
    -+	`concatenate`, `cat_sort_uniq`, or `ignore`.  Defaults to
    -+	`concatenate`.
    - +
    - This setting can be overridden with the `GIT_NOTES_REWRITE_MODE`
    - environment variable.
    + 	When copying notes during a rewrite (see the
    +@@ Documentation/config/notes.txt: environment variable.
=20=20=20=20=20=20
      notes.rewriteRef::
      	When copying notes during a rewrite, specifies the (fully
    @@ Documentation/config/notes.txt: notes.mergeStrategy::
     -environment variable, which must be a colon separated list of refs or
     -globs.
     +Can be overridden with the `GIT_NOTES_REWRITE_REF` environment variab=
le.
    ++See `notes.rewrite.<command>` above for a further description of its =
format.
    +
    + ## Documentation/git-log.txt ##
    +@@ Documentation/git-log.txt: log.showSignature::
    + mailmap.*::
    + 	See linkgit:git-shortlog[1].
    +=20
    +-notes.displayRef::
    +-	Which refs, in addition to the default set by `core.notesRef`
    +-	or `GIT_NOTES_REF`, to read notes from when showing commit
    +-	messages with the `log` family of commands.  See
    +-	linkgit:git-notes[1].
    +-+
    +-May be an unabbreviated ref name or a glob and may be specified
    +-multiple times.  A warning will be issued for refs that do not exist,
    +-but a glob that does not match any refs is silently ignored.
    +-+
    +-This setting can be disabled by the `--no-notes` option,
    +-overridden by the `GIT_NOTES_DISPLAY_REF` environment variable,
    +-and overridden by the `--notes=3D<ref>` option.
    ++include::includes/cmd-config-section-rest.txt[]
    ++
    ++include::config/notes.txt[]
    +=20
    + GIT
    + ---
=20=20=20=20=20
      ## Documentation/git-notes.txt ##
    +@@ Documentation/git-notes.txt: using the `--notes` option. Such notes=
 are added as a patch commentary
    + after a three dash separator line.
    +=20
    + To change which notes are shown by 'git log', see the
    +-"notes.displayRef" configuration in linkgit:git-log[1].
    ++"notes.displayRef" configuration in linkgit:git-config[1].
    +=20
    + See the "notes.rewrite.<command>" configuration for a way to carry
    + notes across commands that rewrite commits.
     @@ Documentation/git-notes.txt: core.notesRef::
      	This setting can be overridden through the environment and
      	command line.
    @@ Documentation/git-notes.txt: core.notesRef::
     -+
     -This setting can be overridden by the `GIT_NOTES_REWRITE_REF`
     -environment variable.
    --
    ++include::includes/cmd-config-section-rest.txt[]
    +=20
     -notes.rewriteMode::
     -	When copying notes during a rewrite, what to do if the target
     -	commit already has a note.  Must be one of `overwrite`,
    @@ Documentation/git-notes.txt: core.notesRef::
     -enable note rewriting.
     -+
     -Can be overridden with the `GIT_NOTES_REWRITE_REF` environment variab=
le.
    --
    -+:git-notes: 1
     +include::config/notes.txt[]
=20=20=20=20=20=20
    +=20
      ENVIRONMENT
    - -----------
 -:  ----------- >  9:  cffa925ccf9 log docs: de-duplicate configuration se=
ctions
