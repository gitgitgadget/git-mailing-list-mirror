Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C70F20986
	for <e@80x24.org>; Tue, 27 Sep 2016 21:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752240AbcI0Vi5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 17:38:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50046 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752124AbcI0Viz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 17:38:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 059DB3DB21;
        Tue, 27 Sep 2016 17:38:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xdFvPnV3f7WYUg+WhksICcbJOwg=; b=AyL6lX
        MLxqedVnbDSuYdfOBEeWF1QVtQsKTbEdfIT8jTL6mgOMH6TC2+tHOM6q36DKIKNR
        s5RwQSxLosiVJRWgMBL2tJCxU1K/3m619td7vHS9/pg+oy/LHp8QzenSW/F67Jn4
        oq25Ny+tb0luaEwpq7SAPzKR8i/M8CgISsLwE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jJMhdowAqqtJXZb5wSRqfUZz3xjhmq00
        8Ftdg1p9w/0r6fgsDcXAlyYzDAFlNaVw2xv7abdC8bXwaZlQ8MinEZsvjlDyNGGf
        0YNROB6Z5wiaNb3I5QuYMA7sHmDXI4soNEhUFqMrDCOgK01nlMAxj+kt4+TjTQ7F
        gPjBOxyflSw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F227A3DB1F;
        Tue, 27 Sep 2016 17:38:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 765E23DB1E;
        Tue, 27 Sep 2016 17:38:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] ls-files: adding support for submodules
References: <1474495472-94190-1-git-send-email-bmwill@google.com>
        <CAKoko1q7Mb6_cnaA1ecZJ2y1PWUrW4RSu6RiviyN91JV5-QR5g@mail.gmail.com>
        <xmqq1t0c7ur2.fsf@gitster.mtv.corp.google.com>
        <CAKoko1qch_odsEWba0rtCv-DWO0ABS2yprnwGPCgyT6-7H-LdQ@mail.gmail.com>
        <xmqqponw6e3x.fsf@gitster.mtv.corp.google.com>
        <20160922041854.7754ujcynhk7mdnh@sigill.intra.peff.net>
        <xmqq7fa36bwm.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 27 Sep 2016 14:38:51 -0700
In-Reply-To: <xmqq7fa36bwm.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 22 Sep 2016 11:13:13 -0700")
Message-ID: <xmqq60phm39w.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C947C710-84FA-11E6-B803-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As this is relevant to what to call the prefix thing that is passed
down to an internal re-invocation of ls-files and how to explain it
to end-users...

Junio C Hamano <gitster@pobox.com> writes:

> I agree that this is not specific to submodules; this is closely
> related to what we internally call "prefix", but is different.
>
> In any case, I would strongly recommend against exposing this (or
> anything for that matter) "--prefix" to the end-user,...

I have a slight suspicion that this was what made you say earlier
that I was against exposing this at all to end users, but what I
meant was a plain boring "prefix" is a bad name and nothing more
than that.

> What we internally call "prefix" and "--submodule-prefix" is closely
> related in that they both interact with pathspecs.  "prefix" gets
> prepended to elements of an end-user supplied pathspec before a
> full-path-in-the-repository (i.e. a path in the index and a path
> relative from the top of the working tree) is matched against them.

In a sense, this new thing is a superset of the existing GIT_PREFIX,
which gives the current working directory from the end user's point
of view relative to the actual current working directory.  The "git"
wrapper, when running a "git thing" from a subdirectory of a working
tree, chdir(2)s up to the top-level before spawning the "thing"
subcommand that is not built-in or a third-party "git-thing" binary
on user's $PATH; so "git-thing" binary will be told via $GIT_PREFIX
relative to what directory path-like things the end user supplied to
the command (e.g. "-o outfile" argument and pathspecs) need to be
interpreted.  The new thing can override the $GIT_PREFIX to allow
path-like things to be interpreted relative to somewhere _above_ the
top-level of the working tree.

I am tempted to suggest GIT_SUPER_PREFIX, 50% because I cannot think
of any better word, 40% because I think it actually makes sense (in
the sense that this comes _above_ it, hence "super", and also in the
sense that this is something your "super" project would give you),
and 10% because I hope that being ridiculous would nudge people to
come up with a better alternative ;-)

And from that point of view ...

>  * It is unclear how this should interact with commands that are run
>    in a subdirectory of the working tree.  E.g. what should the
>    prefix and the pathspec look like if the command in the above
>    example is started in w/git.git/Documentation subdirectory, i.e.
>
>     $ cd ~
>     $ git -C w/git.git/Documentation ls-files \
>         --submodule-prefix=??????? -- '???????' |
>       xargs ls -1 -l
>
>    Should we error out if we are not at the top of the working tree
>    when --submodule-prefix is given?

... the answer to this question becomes clear.  It is not possible
to _be_ in a subdirectory "Documentation" of this working tree and
in a directory "~" above this working tree at the same time, so we
simply should forbid running the command from anywhere other than
the top of the working tree (i.e. the internal "prefix" and
GIT_PREFIX must be empty) when the super-prefix is set by erroring
it out.  When we realize that "prefix" adds to the paths that are
supplied by the user (e.g. when the user says Makefile while in t/
subdirectory, i.e. GIT_PREFIX=t/, s/he means t/Makefile), but this
new thing subtracts from the paths given by the user (e.g. when the
user gives a pathspec 'w/git.git/D*' while setting the super thing
as w/git.git, because s/he is at ~/, the pathspec matcher
conceptually subtracts w/git.git/ from the pathspec before matching
them against the paths it finds in the index), it becomes clear that
giving both at the same time is awkward and not very useful.
