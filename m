Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8FBC47096
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 08:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CF7F61207
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 08:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhFCIEb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 04:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhFCIEb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 04:04:31 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32336C06174A
        for <git@vger.kernel.org>; Thu,  3 Jun 2021 01:02:34 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id jt22so7879934ejb.7
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 01:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=c0ejkpipk9WtLJ54Eqlg3UFK4Y9lbzSJPHAOfcBHInw=;
        b=cpGD4wYeLv0KAWU+kQDwrdYr96QN+6uQhM9aa6MnhB/6CAAffKcyDu0tqgnREawARX
         j7eXNfCLSPVdTkOGw6ikCRqr4av8sEADVTCmZP952Egv8FfmAMEIa/8Xime5in1xS5Gp
         Y6c6qPt54gGwlcxRmUX2/biVFVR8vGrBF68BVp9aUybEq5psWgy2KyT5PjI4HwzlF3H5
         YAkV4Bbhhh6iZDWtxXS8OR/nr75DAk44VrttqE9IBujQsBpr/IO/JHe2SeIdQghKyMma
         ryWFQCa/lw/TC21vHTMXcAuaGjI0j1QMbLoD6DWLbzZTsCTBfHIiQ0l60ks8qiSrrfIr
         K6nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=c0ejkpipk9WtLJ54Eqlg3UFK4Y9lbzSJPHAOfcBHInw=;
        b=VPM2kDWd37+YSRMnyE/cwb94LEbxDtkDjoZrq7Uq9RQRFRbUqFcuSU8G8f10nKI8Cu
         EjG+FTlfX0RHj3s457ESReImzHjutI2QfbHpXZnd5/5/vJf4QwRU6gmfq4j+l3xT5aya
         bcwcauHr/a5MDRCt0C0hh9YjTPJg5AIjBMpsur1bC38h/ILaypl+gcBOLzr6CBmKsEuI
         IiVKAMrRi32LXQKIfYGS+ZG4IkSXj98NQ1mnpX5to1lE+1lS92L3Zv2UqMZzNGRGSxog
         KJnkf/v/4mvFjoFHk+SvwdELCimmB/uVHdXh6VuYpXnKImugpoDxy4MlvdT34jAx8m5k
         MfRQ==
X-Gm-Message-State: AOAM533R1iwnq4X+MMhBZBPAqY6c3y7BsaCQELzkz306okcJax8zoPxM
        wGhnZUW4YeUdZDWuY0wX4ZE=
X-Google-Smtp-Source: ABdhPJxexGfuyxwsAi4jRoPOBYGJ3GMBWeE9dWi35MYDCmvacXoYq6achHcuPrPSmEzimcY7zEiUUg==
X-Received: by 2002:a17:906:d1d2:: with SMTP id bs18mr38116923ejb.56.1622707352604;
        Thu, 03 Jun 2021 01:02:32 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id h22sm1335250edv.0.2021.06.03.01.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 01:02:31 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com
Subject: Re: [PATCH] config doc: indent descriptions of feature.* variables
Date:   Thu, 03 Jun 2021 09:43:35 +0200
References: <20210602001132.459705-1-rybak.a.v@gmail.com>
 <87k0nb77lq.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <87k0nb77lq.fsf@evledraar.gmail.com>
Message-ID: <87h7if74vd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 03 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Wed, Jun 02 2021, Andrei Rybak wrote:
>
>> Config variables feature.experimental and feature.manyFiles are grouped
>> together under "feature.*".  However, this is not easily visible when
>> scanning the help page of git-config.
>>
>> Indent the descriptions of individual feature.* config variables to help
>> the reader distinguish this group of variables.
>>
>> Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
>> ---
>>  Documentation/config/feature.txt | 40 +++++++++++++++++---------------
>>  1 file changed, 21 insertions(+), 19 deletions(-)
>>
>> diff --git a/Documentation/config/feature.txt b/Documentation/config/fea=
ture.txt
>> index cdecd04e5b..2c4dee170b 100644
>> --- a/Documentation/config/feature.txt
>> +++ b/Documentation/config/feature.txt
>> @@ -3,24 +3,26 @@ feature.*::
>>  	a group of other config settings. These groups are created by the Git
>>  	developer community as recommended defaults and are subject to change.
>>  	In particular, new config options may be added with different defaults.
>> -
>> -feature.experimental::
>> -	Enable config options that are new to Git, and are being considered for
>> -	future defaults. Config settings included here may be added or removed
>> -	with each release, including minor version updates. These settings may
>> -	have unintended interactions since they are so new. Please enable this
>> -	setting if you are interested in providing feedback on experimental
>> -	features. The new default values are:
>>  +
>> -* `fetch.negotiationAlgorithm=3Dskipping` may improve fetch negotiation=
 times by
>> -skipping more commits at a time, reducing the number of round trips.
>> +--
>> +	feature.experimental::
>> +		Enable config options that are new to Git, and are being considered f=
or
>> +		future defaults. Config settings included here may be added or removed
>> +		with each release, including minor version updates. These settings may
>> +		have unintended interactions since they are so new. Please enable this
>> +		setting if you are interested in providing feedback on experimental
>> +		features. The new default values are:
>> +	+
>> +	* `fetch.negotiationAlgorithm=3Dskipping` may improve fetch negotiatio=
n times by
>> +	skipping more commits at a time, reducing the number of round trips.
>>=20=20
>> -feature.manyFiles::
>> -	Enable config options that optimize for repos with many files in the
>> -	working directory. With many files, commands such as `git status` and
>> -	`git checkout` may be slow and these new defaults improve performance:
>> -+
>> -* `index.version=3D4` enables path-prefix compression in the index.
>> -+
>> -* `core.untrackedCache=3Dtrue` enables the untracked cache. This settin=
g assumes
>> -that mtime is working on your machine.
>> +	feature.manyFiles::
>> +		Enable config options that optimize for repos with many files in the
>> +		working directory. With many files, commands such as `git status` and
>> +		`git checkout` may be slow and these new defaults improve performance:
>> +	+
>> +	* `index.version=3D4` enables path-prefix compression in the index.
>> +	+
>> +	* `core.untrackedCache=3Dtrue` enables the untracked cache. This setti=
ng assumes
>> +	that mtime is working on your machine.
>> +--
>
> I don't know if/how this helps readability, but this breaks the
> feature.* generation of these variables in config-list.h, see
> generate-configlist.sh.
>
> So if you make this change you need to fix that script as well.

Being a bit more awake I'd prefer not to see this patch go in in its
current form, here's why:

I've got a WIP series I was going to submit soon that:

 1. Ensures that all config variables are discussed canonically in
    git-config(1), e.g. for sendemail.* we now point elsewhere.

 2. Adds a "CONFIGURATION" section to all relevant manpages, which then
    include the relevant section(s) for variables that affect those
    commands.

 3. #2 requires splitting up many of Documentation/config/whatever.txt
    into Documentation/config/whatever/<sub-lists>.txt, notably things
    like Documentation/config/color.txt need to become
    Documentation/config/color/{diff,status,...}.txt so
    Documentation/git-{status,diff,...}.txt can include them.

This only works because we don't have something like your proposed patch
here.

I.e. asciidoc isn't going to take kindly to feature.manyFiles being
indented when I include it in git-{status,checkout}.txt, in its
CONFIGURATION section that'll be either a syntax error, or look out of
place.

But more importantly there seems to just be a better way to do it,
looking at the current config file we have the pattern you're trying to
introduce for advice.* already, except it's differently formatted, i.e.:

    advice.*
        SubVariaBle::

But yours is:

    feature.*
        feature.SubVariaBle::

The advice.* ones also have the config-list.h issue I noted. But in any
case, it seems to me that the issue is that we group these things at the
top-level under git-config(1)'s "CONFIGURATION FILE" section, we should
really split them into a CONFIGURATION VARIABLES, and then have these
advice.* or whatever be a section on the level of the current
"Variables", i.e. something like the incomplete patch below[1].

That would both look nicer IMO, and allow us to not indent things in
Documentation/config/*.txt. If you agree I'd very much like you to pick
up & run with that alternate approach instead, what do you think?

1.

diff --git a/Documentation/config.txt b/Documentation/config.txt
index bf82766a6a2..5e52b0db1fa 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -299,9 +299,8 @@ pathname::
 	is expanded to the value of `$HOME`, and `~user/` to the
 	specified user's home directory.
=20
-
-Variables
-~~~~~~~~~
+CONFIGURATION VARIABLES
+-----------------------
=20
 Note that this list is non-comprehensive and not necessarily complete.
 For command-specific variables, you will find a more detailed description
@@ -312,10 +311,24 @@ inventing new variables for use in your own tool, mak=
e sure their
 names do not conflict with those that are used by Git itself and
 other popular tools, and describe them in your documentation.
=20
+
+advice.*
+~~~~~~~~
+
+These variables control various optional help messages designed to aid
+new users. All 'advice.*' variables default to 'true', and you can
+tell Git that you do not need help by setting these to 'false':
+
 include::config/advice.txt[]
=20
+core.*
+~~~~~~
+
 include::config/core.txt[]
=20
+add.*
+~~~~~
+
 include::config/add.txt[]
=20
 include::config/alias.txt[]
diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.=
txt
index 8b2849ff7b3..35d6b0e20ff 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -1,126 +1,119 @@
-advice.*::
-	These variables control various optional help messages designed to
-	aid new users. All 'advice.*' variables default to 'true', and you
-	can tell Git that you do not need help by setting these to 'false':
-+
---
-	fetchShowForcedUpdates::
-		Advice shown when linkgit:git-fetch[1] takes a long time
-		to calculate forced updates after ref updates, or to warn
-		that the check is disabled.
-	pushUpdateRejected::
-		Set this variable to 'false' if you want to disable
-		'pushNonFFCurrent', 'pushNonFFMatching', 'pushAlreadyExists',
-		'pushFetchFirst', 'pushNeedsForce', and 'pushRefNeedsUpdate'
-		simultaneously.
-	pushNonFFCurrent::
-		Advice shown when linkgit:git-push[1] fails due to a
-		non-fast-forward update to the current branch.
-	pushNonFFMatching::
-		Advice shown when you ran linkgit:git-push[1] and pushed
-		'matching refs' explicitly (i.e. you used ':', or
-		specified a refspec that isn't your current branch) and
-		it resulted in a non-fast-forward error.
-	pushAlreadyExists::
-		Shown when linkgit:git-push[1] rejects an update that
-		does not qualify for fast-forwarding (e.g., a tag.)
-	pushFetchFirst::
-		Shown when linkgit:git-push[1] rejects an update that
-		tries to overwrite a remote ref that points at an
-		object we do not have.
-	pushNeedsForce::
-		Shown when linkgit:git-push[1] rejects an update that
-		tries to overwrite a remote ref that points at an
-		object that is not a commit-ish, or make the remote
-		ref point at an object that is not a commit-ish.
-	pushUnqualifiedRefname::
-		Shown when linkgit:git-push[1] gives up trying to
-		guess based on the source and destination refs what
-		remote ref namespace the source belongs in, but where
-		we can still suggest that the user push to either
-		refs/heads/* or refs/tags/* based on the type of the
-		source object.
-	pushRefNeedsUpdate::
-		Shown when linkgit:git-push[1] rejects a forced update of
-		a branch when its remote-tracking ref has updates that we
-		do not have locally.
-	statusAheadBehind::
-		Shown when linkgit:git-status[1] computes the ahead/behind
-		counts for a local ref compared to its remote tracking ref,
-		and that calculation takes longer than expected. Will not
-		appear if `status.aheadBehind` is false or the option
-		`--no-ahead-behind` is given.
-	statusHints::
-		Show directions on how to proceed from the current
-		state in the output of linkgit:git-status[1], in
-		the template shown when writing commit messages in
-		linkgit:git-commit[1], and in the help message shown
-		by linkgit:git-switch[1] or
-		linkgit:git-checkout[1] when switching branch.
-	statusUoption::
-		Advise to consider using the `-u` option to linkgit:git-status[1]
-		when the command takes more than 2 seconds to enumerate untracked
-		files.
-	commitBeforeMerge::
-		Advice shown when linkgit:git-merge[1] refuses to
-		merge to avoid overwriting local changes.
-	resetQuiet::
-		Advice to consider using the `--quiet` option to linkgit:git-reset[1]
-		when the command takes more than 2 seconds to enumerate unstaged
-		changes after reset.
-	resolveConflict::
-		Advice shown by various commands when conflicts
-		prevent the operation from being performed.
-	sequencerInUse::
-		Advice shown when a sequencer command is already in progress.
-	implicitIdentity::
-		Advice on how to set your identity configuration when
-		your information is guessed from the system username and
-		domain name.
-	detachedHead::
-		Advice shown when you used
-		linkgit:git-switch[1] or linkgit:git-checkout[1]
-		to move to the detach HEAD state, to instruct how to
-		create a local branch after the fact.
-	checkoutAmbiguousRemoteBranchName::
-		Advice shown when the argument to
-		linkgit:git-checkout[1] and linkgit:git-switch[1]
-		ambiguously resolves to a
-		remote tracking branch on more than one remote in
-		situations where an unambiguous argument would have
-		otherwise caused a remote-tracking branch to be
-		checked out. See the `checkout.defaultRemote`
-		configuration variable for how to set a given remote
-		to used by default in some situations where this
-		advice would be printed.
-	amWorkDir::
-		Advice that shows the location of the patch file when
-		linkgit:git-am[1] fails to apply it.
-	rmHints::
-		In case of failure in the output of linkgit:git-rm[1],
-		show directions on how to proceed from the current state.
-	addEmbeddedRepo::
-		Advice on what to do when you've accidentally added one
-		git repo inside of another.
-	ignoredHook::
-		Advice shown if a hook is ignored because the hook is not
-		set as executable.
-	waitingForEditor::
-		Print a message to the terminal whenever Git is waiting for
-		editor input from the user.
-	nestedTag::
-		Advice shown if a user attempts to recursively tag a tag object.
-	submoduleAlternateErrorStrategyDie::
-		Advice shown when a submodule.alternateErrorStrategy option
-		configured to "die" causes a fatal error.
-	addIgnoredFile::
-		Advice shown if a user attempts to add an ignored file to
-		the index.
-	addEmptyPathspec::
-		Advice shown if a user runs the add command without providing
-		the pathspec parameter.
-	updateSparsePath::
-		Advice shown when either linkgit:git-add[1] or linkgit:git-rm[1]
-		is asked to update index entries outside the current sparse
-		checkout.
---
+advice.*fetchShowForcedUpdates::
+	Advice shown when linkgit:git-fetch[1] takes a long time
+	to calculate forced updates after ref updates, or to warn
+	that the check is disabled.
+advice.pushUpdateRejected::
+	Set this variable to 'false' if you want to disable
+	'pushNonFFCurrent', 'pushNonFFMatching', 'pushAlreadyExists',
+	'pushFetchFirst', 'pushNeedsForce', and 'pushRefNeedsUpdate'
+	simultaneously.
+advice.pushNonFFCurrent::
+	Advice shown when linkgit:git-push[1] fails due to a
+	non-fast-forward update to the current branch.
+advice.pushNonFFMatching::
+	Advice shown when you ran linkgit:git-push[1] and pushed
+	'matching refs' explicitly (i.e. you used ':', or
+	specified a refspec that isn't your current branch) and
+	it resulted in a non-fast-forward error.
+advice.pushAlreadyExists::
+	Shown when linkgit:git-push[1] rejects an update that
+	does not qualify for fast-forwarding (e.g., a tag.)
+pushFetchFirst::
+	Shown when linkgit:git-push[1] rejects an update that
+	tries to overwrite a remote ref that points at an
+	object we do not have.
+pushNeedsForce::
+	Shown when linkgit:git-push[1] rejects an update that
+	tries to overwrite a remote ref that points at an
+	object that is not a commit-ish, or make the remote
+	ref point at an object that is not a commit-ish.
+pushUnqualifiedRefname::
+	Shown when linkgit:git-push[1] gives up trying to
+	guess based on the source and destination refs what
+	remote ref namespace the source belongs in, but where
+	we can still suggest that the user push to either
+	refs/heads/* or refs/tags/* based on the type of the
+	source object.
+pushRefNeedsUpdate::
+	Shown when linkgit:git-push[1] rejects a forced update of
+	a branch when its remote-tracking ref has updates that we
+	do not have locally.
+statusAheadBehind::
+	Shown when linkgit:git-status[1] computes the ahead/behind
+	counts for a local ref compared to its remote tracking ref,
+	and that calculation takes longer than expected. Will not
+	appear if `status.aheadBehind` is false or the option
+	`--no-ahead-behind` is given.
+statusHints::
+	Show directions on how to proceed from the current
+	state in the output of linkgit:git-status[1], in
+	the template shown when writing commit messages in
+	linkgit:git-commit[1], and in the help message shown
+	by linkgit:git-switch[1] or
+	linkgit:git-checkout[1] when switching branch.
+statusUoption::
+	Advise to consider using the `-u` option to linkgit:git-status[1]
+	when the command takes more than 2 seconds to enumerate untracked
+	files.
+commitBeforeMerge::
+	Advice shown when linkgit:git-merge[1] refuses to
+	merge to avoid overwriting local changes.
+resetQuiet::
+	Advice to consider using the `--quiet` option to linkgit:git-reset[1]
+	when the command takes more than 2 seconds to enumerate unstaged
+	changes after reset.
+resolveConflict::
+	Advice shown by various commands when conflicts
+	prevent the operation from being performed.
+sequencerInUse::
+	Advice shown when a sequencer command is already in progress.
+implicitIdentity::
+	Advice on how to set your identity configuration when
+	your information is guessed from the system username and
+	domain name.
+detachedHead::
+	Advice shown when you used
+	linkgit:git-switch[1] or linkgit:git-checkout[1]
+	to move to the detach HEAD state, to instruct how to
+	create a local branch after the fact.
+checkoutAmbiguousRemoteBranchName::
+	Advice shown when the argument to
+	linkgit:git-checkout[1] and linkgit:git-switch[1]
+	ambiguously resolves to a
+	remote tracking branch on more than one remote in
+	situations where an unambiguous argument would have
+	otherwise caused a remote-tracking branch to be
+	checked out. See the `checkout.defaultRemote`
+	configuration variable for how to set a given remote
+	to used by default in some situations where this
+	advice would be printed.
+amWorkDir::
+	Advice that shows the location of the patch file when
+	linkgit:git-am[1] fails to apply it.
+rmHints::
+	In case of failure in the output of linkgit:git-rm[1],
+	show directions on how to proceed from the current state.
+addEmbeddedRepo::
+	Advice on what to do when you've accidentally added one
+	git repo inside of another.
+ignoredHook::
+	Advice shown if a hook is ignored because the hook is not
+	set as executable.
+waitingForEditor::
+	Print a message to the terminal whenever Git is waiting for
+	editor input from the user.
+nestedTag::
+	Advice shown if a user attempts to recursively tag a tag object.
+submoduleAlternateErrorStrategyDie::
+	Advice shown when a submodule.alternateErrorStrategy option
+	configured to "die" causes a fatal error.
+addIgnoredFile::
+	Advice shown if a user attempts to add an ignored file to
+	the index.
+addEmptyPathspec::
+	Advice shown if a user runs the add command without providing
+	the pathspec parameter.
+updateSparsePath::
+	Advice shown when either linkgit:git-add[1] or linkgit:git-rm[1]
+	is asked to update index entries outside the current sparse
+	checkout.
