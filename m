Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B19C433E0
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 22:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89D5064EC6
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 22:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbhBAWMl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 17:12:41 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65193 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhBAWMi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 17:12:38 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F26B4B4538;
        Mon,  1 Feb 2021 17:11:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=xottmPpwimErEO3K7yFTK4+xXow=; b=QjsET4W7QETA5oLRiaL8
        Suk81VFmsj+r6He706o/yBVY/dqHS6Cq1OltTFO3YS1PCoOPXD/J0G8NBU7uaoBU
        F0GN6/Ym218YJ9IFDOSDZn5lH1K7+w8xjptzgH1GuJp1AHPsXSspv0UMvqW1kp0c
        ALviO6zllItfZ/5wLVQ6Ces=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=DN6l8cMbFruameChQFGMTVlTGedd/RJUoEdkw4QeS3SmrM
        1emweTj1I0iLUC3hJcHP08JOMJA7mmkhdnJ62AOifHKM6m0JONFOSR65Vnx69aCP
        TOI2/VRi+BhrGEucBzsqR1VGbLKHyrllxHPaiHZH+Tpm5JKb0DmO4+oTW7Y2s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E9B06B4537;
        Mon,  1 Feb 2021 17:11:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 72535B4536;
        Mon,  1 Feb 2021 17:11:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v7 01/17] doc: propose hooks managed by the config
References: <20201222000220.1491091-1-emilyshaffer@google.com>
        <20201222000220.1491091-2-emilyshaffer@google.com>
Date:   Mon, 01 Feb 2021 14:11:53 -0800
Message-ID: <xmqqa6snjv4m.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7E056842-64DA-11EB-8B12-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> +ways, providing an avenue to deprecate these "legacy" hooks if desired. The
> +handling is based on a config `hook.runHookDir`, which is checked against a
> +number of cases:

Don't we want to also warn when the setting "no" or something
similar prevents the legacy hook from running, to help users
who wonder why their hook scripts are not running?  I.e.

> +- "no": the legacy hook will not be run

+- "warn-no": Git will print a warning to stderr before ignoring the
+  legacy hook

> +- "interactive": Git will prompt the user before running the legacy hook
> +- "warn": Git will print a warning to stderr before running the legacy hook
> +- "yes" (default): Git will silently run the legacy hook

> +In case this list is expanded in the future, if a value for `hook.runHookDir` is
> +given which Git does not recognize, Git should discard that config entry. For
> +example, if "warn" was specified at system level and "junk" was specified at
> +global level, Git would resolve the value to "warn"; if the only time the config
> +was set was to "junk", Git would use the default value of "yes".

Hmph, instead of complaining "value 'junk' is not recognized" and
erroring out?  Why?

> +[[stage-3]]
> +==== Stage 3
> +
> +`.git/hooks` is removed from the template and the hook directory is considered
> +deprecated. To avoid breaking older repos, the default of `hook.runHookDir` is
> +not changed, and `find_hook()` is not removed.

Presumably, we'll have documentation somewhere that instructs users
(who were taught by slashdot and other site to add certain scripts
under their .git/hooks/) how to do the equivalent without adding
scripts in .git/hooks/ directory and instead using the config
mechanism (e.g. "when told to add script X in .git/hooks/, read such
an instruction as if telling you to do Y instead") by the time this
happens?  It probably makes sense to do so as part of stage-2, at
which point the users are _ready_ to migrate.

> +[[security]]
> +=== Security and repo config
> +
> +Part of the motivation behind this refactor is to mitigate hooks as an attack
> +vector;footnote:[https://lore.kernel.org/git/20171002234517.GV19555@aiede.mtv.corp.google.com/]
> +however, as the design stands, users can still provide hooks in the repo-level
> +config, which is included when a repo is zipped and sent elsewhere.  The
> +security of the repo-level config is still under discussion; this design
> +generally assumes the repo-level config is secure, which is not true yet. The
> +goal is to avoid an overcomplicated design to work around a problem which has
> +ceased to exist.

I doubt we want to claim anything about security as part of this
series.  As you say in the paragraph, .git/config and .git/hooks/
are equally (un)protected and if we decide to punt .git/config
security, then not moving away from .git/hooks would not hurt
security-wise, either (in other words, security is not a viable
motivation behind this series).

And if we stop advertising 'security merit' that does not exist,
what remains?  Isn't the biggest selling point that an identical set
of hook configuration can be shared among multiple repositories, and
it allows more than one hook scripts to be triggered by a single
"hook event"?  There may be other good things we should be able to
sell the new mechanism to our users, and we do stress on them, which
is done in the motivation section.  So...

> +.Comparison of alternatives
> +|===
> +|Feature |Config-based hooks |Hook directories |Status quo

Sorry, but I did not find this table particularly convincing.

The only thing I sense is a hand-wavy desire that "we could make it
better than everybody else if we work on it in this area", which can
apply equally for other approaches---they could enhance what they
already have (e.g. "discoverability & documentation").

As a list of "these are the points we aspire to do better than other
people", I think it is an excellent idea to have a table like this
here in the documentation.  But that is not a "comparison".

> +[[execution-ordering]]
> +=== Execution ordering
> +
> +We may find that config order is insufficient for some users; for example,
> +config order makes it difficult to add a new hook to the system or global config
> +which runs at the end of the hook list. A new ordering schema should be:
> +
> +1) Specified by a `hook.order` config, so that users will not unexpectedly see
> +their order change;
> +
> +2) Either dependency or numerically based.
> +
> +Dependency-based ordering is prone to classic linked-list problems, like a
> +cycles and handling of missing dependencies. But, it paves the way for enabling
> +parallelization if some tasks truly depend on others.
> +
> +Numerical ordering makes it tricky for Git to generate suggested ordering
> +numbers for each command, but is easy to determine a definitive order.

OK.

Have we decided what we do for hooks whose interface is to feed
their input from their standard input?  The current system, I think,
just feeds the single hook by writing into a pipe to it, but if we
were to drive multiple hooks, we'd need to write the same thing to
each of these hook programs?  

Do we have a plan to deal with hooks whose outcome is not just
"yes/no", e.g. "proc-receive" hook that munges the list of refs to
be updated and the new values for them, or "applypatch-msg" that
munges the incoming proposed commit log message?  Does the second
hook work on the result of the first hook?  Do the two hooks work on
the vanilla state and their output have to agree with each other?

> +[[parallelization]]
> +=== Parallelization with dependencies
> +
> +Currently hooks use a naive parallelization scheme or are run in series.  But if
> +one hook depends on another's output, then users will want to specify those
> +dependencies.

An untold assumption here is that the questions I asked earlier on
having more than one hooks that is not just yes/no is something
readers know the same answer, and that answer is "the outcome of the
first hook is passed along (as if it were the input given by Git
directly, if the first hook did not exist), to the second hook.  It
should be spelled out somewhere before the execution ordering
section, I think.
