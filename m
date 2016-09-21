Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCB0C1F935
	for <e@80x24.org>; Wed, 21 Sep 2016 17:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758275AbcIURtz (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 13:49:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55229 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756421AbcIURty (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 13:49:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A9E743E910;
        Wed, 21 Sep 2016 13:49:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ot5QDN4ifxK1v/ba7mnJlY2CgTo=; b=IE42Bo
        bT+6mK/NdFmHRg2296tpBIITcvMQH6bGnZ0R/AgWus9lf2xXGu5hToypJiMsNL+z
        JURl9ms9gbpiGODlx60WaKzWgypf5C6hJeNjbDfypFc1tQpe584gLUObwiqao80G
        BXCpVswQ80LpRSfUyhOJm4Jz0LBfrBbAMVbag=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uOY1Otb3wBENxVFb5GD0om+/TSvD/VSD
        Ex+wof0pF1snIgH+geZHuNdKLpYDDeICnNz4kp8baCD0uGQ2QJLhN/+HwHqRFOni
        TDBdu2n9T73NqC4ZjCxKQn8NDSIErpr/o0Gc06R6WK2BR4TBmoZ3mKRx5pzJo8ok
        n+v3pky7uII=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A181D3E90F;
        Wed, 21 Sep 2016 13:49:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 32B8D3E90E;
        Wed, 21 Sep 2016 13:49:50 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2] ls-files: add pathspec matching for submodules
References: <CAKoko1qrAuLhn6qQax-BSZFhEqbFdiBbVrip8TD3NVjD8Xzy0g@mail.gmail.com>
        <1474311151-117883-1-git-send-email-bmwill@google.com>
        <xmqqh99bcw6m.fsf@gitster.mtv.corp.google.com>
        <CAKoko1oU+QR61Vy0eSxaRe_w8u4q_bC9gx9H7oMqH=CwNzBVCA@mail.gmail.com>
        <CAKoko1qS0+DgnMeNnjayEK3sWnvpuiS4oRDBSR=6s8i4okQ_Hw@mail.gmail.com>
        <xmqqmvj19nyp.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 21 Sep 2016 10:49:48 -0700
In-Reply-To: <xmqqmvj19nyp.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 21 Sep 2016 10:12:14 -0700")
Message-ID: <xmqq37kt9m83.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CB2BCBC0-8023-11E6-872B-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Brandon Williams <bmwill@google.com> writes:
>
>> On a similar but slightly different note.  In general do we want
>> the pathspec '??b' to match against the sib/ directory and
>> subsequently have ls-files print all entries inside of the sib/
>> directory?  (this is in the non-recursive case)
>
> I'd need to find time to dig a bit of history before I can give a
> firm opinion on this, but here is a knee-jerk version of my reaction.

In the context of what you are doing, i.e. "ls-files that recurses
into submodules", my opinion is that "ls-files --recurse-submodules"
should behave wrt pathspecs AS IF all the submodule contents are
flattened into a single index of the superproject.

In the sample scenario under discussion, i.e.

    In the superproject we have these
    $ git ls-files -s
    100644 c489803d5bdec1755f650854fe7ef5ab7a3ee58d 0       .gitmodules
    100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0       sib/file
    160000 1f5a0695289c500f25e7fa55e3ad27e394d1206b 0       sub

    In 'sub' submodule we have this
    100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0       file

such a flattend index would look like this:

    100644 c489803d5bdec1755f650854fe7ef5ab7a3ee58d 0       .gitmodules
    100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0       sib/file
    100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0       sub/file

i.e. removing 'sub' submodule entry from the index of the
superproject and overlay everything in the submodule with sub/
prefixed to its path.

And with such an index, if and only if a path matches a pathspec,
"git ls-files --recurse-submodules" run at the toplevel with the
same pathspec should show the path.  That means

    $ git ls-files --recurse-submodules '??b'

would show nothing (not even 'sub'), while

    $ git ls-files --recurse-submodules '??b*'

should show sib/file and sub/file.  That is because that is how the
command without "--recurse-submodules" working on that flat index
would produce.

The "we have historically two kinds of pathspecs and they differ how
they work with wildcard" is a separate issue, I would think, even
though the result would affect what should happen in the above
example (i.e. if we said "either a pattern match or a literal match
to a leading directory path should make everything underneath
match", '??b' would make sib/<anything> and sub/<anything> to be
shown).
