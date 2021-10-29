Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE18C433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 11:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC5FF60F9C
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 11:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbhJ2Ljw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 07:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbhJ2Ljv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 07:39:51 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3ADC061570
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 04:37:23 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id w1so18775906edd.0
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 04:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=wayvnAlZn48x3+LZKR4fzZMggTIyo3ZHtNKGut7fI60=;
        b=AxzbVe81r1Hh7G+xck12K2+8R76F3ciliARTWgwVYei+Sp2HSXp2XBdqHBT00bqArN
         32ro7CMkWI66yTHIHGHQhwG0lEVFiLe38dmSak0sbXojcmw0GXmbqsi+qxT8rSDXT5Gr
         cMHAcypJfTfLGY778ui7BlSTyusAYOafcUrVDqvQfTZYG4lUtkl3Eefkk0nZxeqSe6ZX
         ZAzWdqONE5bzInHqHm20Vj46weTDnTDVRcgIHE4Fn0zulk+VNSqy5gKxwaVQtWvr8gDJ
         QiDh4hp6wt/JrvX+UCfz/Jm+bVFNlU3b6tXaZIBo/B+4M36T9dLwjYKaTtkhv3zS+Lrm
         i0Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=wayvnAlZn48x3+LZKR4fzZMggTIyo3ZHtNKGut7fI60=;
        b=U5imMEB0+zl0WbSK0Y3pFYJHwgguE+PHexZ60yYkxjC41Gk6ec8lVcwdQ6kiAPzvTl
         DhoSZ/IGOGIrp3Bji2w3eYUZWSSIfWCM8JYEFIEs8Q6ViTbQmLHTW6tJEMTxbGeQAQ2K
         zDmJoHlBo0E/TWMhRneFu8UTYXc530blNFGnUH+o+kAI7We009A27+0SnynL+WgS6HZU
         X0kayL5mtGacvSrUrmQUSGmir+RS9+TuM9hTtehX+NmyWk4RL6YQesTv1reNbK4Cbr2v
         IY9c7qQaODssk0pP01HBIPpmPGtiyEO+xUAajt8xMEjT9tefJ+wbsI8kCjn1HN09CvDh
         8I1g==
X-Gm-Message-State: AOAM530rOAAUeWp0QTPmLXAB2FfJ0n7pxW61KB0svguN2u7Wpn+mSXy+
        HLTBtlQ1gg6H3N5tU62vbh4S6y80PKurrg==
X-Google-Smtp-Source: ABdhPJyyHktXRqLrOVOJppe6L68u/uXsrUvWQ66sHtNAmqxIKBlps/0TlZjGvaeTqUYJbndZ64nMKA==
X-Received: by 2002:a17:906:15d0:: with SMTP id l16mr13294135ejd.462.1635507441682;
        Fri, 29 Oct 2021 04:37:21 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id n1sm3302898edf.45.2021.10.29.04.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 04:37:21 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mgQCG-0024s8-P3;
        Fri, 29 Oct 2021 13:37:20 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org, Neeraj Singh <nksingh85@gmail.com>
Subject: Re: [PATCH] allow disabling fsync everywhere
Date:   Fri, 29 Oct 2021 13:20:29 +0200
References: <20211028002102.19384-1-e@80x24.org>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <20211028002102.19384-1-e@80x24.org>
Message-ID: <211029.86v91g3vv3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 28 2021, Eric Wong wrote:

> "core.fsync" and the "GIT_FSYNC" environment variable now exist
> for disabling fsync() even on packfiles and other critical data.

First off, I think this would be useful to add, even as a non-test
thing.

There's plenty of use-cases where users don't care about fsync(), and
aside from data reliability it also has implications for say laptop
battery use.

I care about my E-Mail, but my E-Mail syncing thingy's (mbsync) has an
fsync=off in its config, I'm pretty confident that I won't lose power on
that *nix laptop, and even if I did I have other recovery methods.

I wouldn't use this in general, but might for some operations, e.g. when
I'm doing some batch operation with git-annex or whatever.

> Running "make test -j8 NO_SVN_TESTS=1" on a noisy 8-core system
> on an HDD, adding "GIT_FSYNC=0" to the invocation brings my test
> runtime from ~4 minutes down to ~3 minutes.

On a related topic: Have you tried having it use an empty template
directory? I have some unsubmitted patches for that, and if you retain
all trash dirs you'll find that we have IIRC 100-200MB of just
accumulated *.sample etc. hooks, out of ~1GB total for the tests.

> +core.fsync::
> +	A boolean to control 'fsync()' on all files.
> ++
> +Setting this to false can speed up writes of unimportant data.
> +Disabling fsync will lead to data loss on power failure.  If set
> +to false, this also overrides core.fsyncObjectFiles.  Defaults to true.
> +

Per the recent threads about fsync semantics this should really be
worded to be more scary, i.e. it's not guaranteed that your data is
on-disk at all. So subsequent git operations might see repo corruption,
if we're being POSIX-pedantic.

So some more "all bets are off" wording would be better here, and any
extra promises could be e.g.:

    On commonly deployed OS's such as Linux, OSX etc. a lack of fsync()
    gives you extra guarantees that are non-standard, primarily that a
    subsequent running process that accesses the data will see the
    updated version, as the VFS will serve up the new version, even if
    it's not on-disk yet. Even these light guarantees may not be
    something you're getting from our OS. Here be dragons!

> [...]
> --- a/git-cvsserver.perl
> +++ b/git-cvsserver.perl
> @@ -3607,6 +3607,25 @@ package GITCVS::updater;
>  use strict;
>  use warnings;
>  use DBI;
> +our $_use_fsync;

s/our/my/?

> +# n.b. consider using Git.pm
> +sub use_fsync {
> +    if (!defined($_use_fsync)) {
> +        my $x = $ENV{GIT_FSYNC};
> +        if (defined $x) {
> +            local $ENV{GIT_CONFIG};
> +            delete $ENV{GIT_CONFIG};
> +            my $v = ::safe_pipe_capture('git', '-c', "core.fsync=$x",
> +                                        qw(config --type=bool core.fsync));
> +            $_use_fsync = defined($v) ? ($v eq "true\n") : 1;
> +        } else {
> +            my $v = `git config --type=bool core.fsync`;
> +            $_use_fsync = $v eq "false\n" ? 0 : 1;
> +        }
> +    }
> +    $_use_fsync;
> +}

I wonder most of all if we really need these perl changes, does it
really matter for the overall performance that you want, or was it just
to get all fsync() uses out of the test suite?

This is a more general comment, but so much of scaffolding like that in
the *.perl scripts could go away if we taught git.c some "not quite a
builtin, but it's ours" mode, and had say code for git-send-email,
git-svn etc. to just set the various data they need in the environment
before we invoke them. Then this would just be say:

    our $use_fsync = $ENV{GIT_FOR_CVSSERVER_FSYNC};


> +    if ($self->{dbdriver} eq 'SQLite' && !use_fsync()) {
> +        $self->{dbh}->do('PRAGMA synchronous = OFF');
> +    }

..in particular if we're doing this we should update the docs to say
that we'll also tweak third-party software's use of fsync() in some
cases.

Even if we "own" that sqlite DB a user might not expect a git option to
have gone so far as to be the cause of their on-disk sqlite DB's
corruption.

> [...]
>  	my $sync;
>  	# both of these options make our .rev_db file very, very important
>  	# and we can't afford to lose it because rebuild() won't work
> -	if ($self->use_svm_props || $self->no_metadata) {
> +	if (($self->use_svm_props || $self->no_metadata) && use_fsync()) {
>  		require File::Copy;
>  		$sync = 1;
>  		File::Copy::copy($db, $db_lock) or die "rev_map_set(@_): ",

This doesn't just impact $io->sync, but also $io->flush, which is a
different thing. PerlIO flushing to the OS != fsync().

So even on OS's that make the above noted guarantees you'd get nothing,
since we're now at the mercy of perl not crashing in the interim, not
kernel or stdlib behavior.

> @@ -57,7 +58,9 @@ void fprintf_or_die(FILE *f, const char *fmt, ...)
>  
>  void fsync_or_die(int fd, const char *msg)
>  {
> -	while (fsync(fd) < 0) {
> +	if (use_fsync < 0)
> +		use_fsync = git_env_bool("GIT_FSYNC", 1);
> +	while (use_fsync && fsync(fd) < 0) {
>  		if (errno != EINTR)
>  			die_errno("fsync error on '%s'", msg);
>  	}

This patch direction looks good to me, aside from the above we should
really update any other fsync() docs we have, maybe with a
cross-reference in core.fsyncObjectFiles?

I'm not sure offhand what the state of the other fsync patches that
Neeraj Singh has been submitting is, but let's make sure that whatever
docs/config knobs etc. we have all play nicely together, and are
somewhat future-proof if possible.
