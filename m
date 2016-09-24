Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FD0A1F935
	for <e@80x24.org>; Sat, 24 Sep 2016 18:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934876AbcIXS1A (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Sep 2016 14:27:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53913 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932768AbcIXS07 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Sep 2016 14:26:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9AAF33BDF9;
        Sat, 24 Sep 2016 14:26:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=36hkfSxuqgx3O0y7UWIECOx/aQo=; b=ElSAaY
        dCXNCxvCA/yUjjR1hX2BrQHkBpisv9pIBagZmj2Kb0fgiZyJFwvfk0CzhWG3N2uI
        F3ZiFVZx/7rnTwPE7yMyOwSOFHuHKLxIQX+g4wz6WzKgIZKpcwD+uBVPi5sHtXu3
        zcbN7IBfDkEbGYXcIi6ViecHjJhDAMZMeTXYw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WYRjlCX9u7uHk1BEAoSuzhVjV/gSXbiR
        aq7crXYW8BBaU+/M18ZbM7/3M37O91rA4USTtJ7g/ZBW+6Gqyu3oMmN8MeHmQxvP
        8HP1oU6KoBj6Ru+ia9lq1KXAYYgoqfvo90kVHw//ER/uQc6QSCba1Ss+DRVvFG+9
        BKt1Cv6S67Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 923BC3BDF7;
        Sat, 24 Sep 2016 14:26:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0C1883BDF6;
        Sat, 24 Sep 2016 14:26:57 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philip Oakley" <philipoakley@iee.org>
Cc:     "Ben Peart" <Ben.Peart@microsoft.com>, <pclouds@gmail.com>,
        <git@vger.kernel.org>
Subject: Re: [PATCH v3] checkout: eliminate unnecessary merge for trivial checkout
References: <20160913142628.15440-1-benpeart@microsoft.com>
        <xmqq7fafv376.fsf@gitster.mtv.corp.google.com>
        <BL2PR03MB3232D3128A72D4EC9ADC2C6F4F10@BL2PR03MB323.namprd03.prod.outlook.com>
        <BL2PR03MB323E1B2F810C63CB01AA234F4F30@BL2PR03MB323.namprd03.prod.outlook.com>
        <007401d21278$445eba80$cd1c2f80$@gmail.com>
        <xmqqzin3g8di.fsf@gitster.mtv.corp.google.com>
        <xmqqr38fg6tk.fsf@gitster.mtv.corp.google.com>
        <BL2PR03MB323ADC371E49EFD1CBBC566F4F60@BL2PR03MB323.namprd03.prod.outlook.com>
        <99A866BEF8944598A50C6E061A703297@PhilipOakley>
Date:   Sat, 24 Sep 2016 11:26:54 -0700
In-Reply-To: <99A866BEF8944598A50C6E061A703297@PhilipOakley> (Philip Oakley's
        message of "Sat, 24 Sep 2016 15:28:11 +0100")
Message-ID: <xmqqd1jtyx01.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 79BFAAA0-8284-11E6-8BD6-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

>> > >"git checkout -b foo" (without -f -m or <start_point>) is defined in
>> > >the manual as being a shortcut for/equivalent to:
>> > >
>> > >        (1a) "git branch foo"
>> > >        (1b) "git checkout foo"
>> > >
>> > >However, it has been our experience in our observed use cases and all
>> > >the existing git tests, that it can be treated as equivalent to:
>> > >
>> > >        (2a) "git branch foo"
>> > >        (2b) "git symbolic-ref HEAD refs/heads/foo"
>> > >...
>> > >
>> > I am still not sure if I like the change of what "checkout -b" is this
>> > late in the game, though.
>>
>> ...
>> That said, you're much more on the frontline of receiving negative
>> feedback about doing that than I am. :)  How would you like to
>> proceed?
>
> I didn't see an initial confirmation as to what the issue really
> was. You indicated the symptom ('a long checkout time'), but then we
> missed out on hard facts and example repos, so that the issue was
> replicable.

I took it as a given, trivial and obvious optimization opportunity,
that it is wasteful having to traverse two trees to consolidate and
reflect their differences into the working tree when we know upfront
that these two trees are identical, no matter what the overhead for
doing so is.

> At the moment there is the simple workaround of an alias that executes
> that two step command dance to achieve what you needed, and Junio has
> outlined the issues he needed to be covered from his maintainer
> perspective (e.g. the detection of sparse checkouts). Confirming the
> root causes would help in setting a baseline.
>
> I hope that is of help - I'd seen that the discussion had gone quiet.

Some of the problems I have are:

 (1) "git checkout -b NEW", "git checkout", "git checkout HEAD^0"
     and "git checkout HEAD" (no other parameters to any of them)
     ought to give identical index and working tree.  It is too
     confusing to leave subtly different results that will lead to
     hard to diagnose bugs for only one of them.

 (2) The proposed log message talks only about "performance
     optimization", while the purpose of the change is more about
     changing the definition of what "git checkout -b NEW" is from
     "git branch NEW && git checkout NEW" to "git branch NEW && git
     symbolic-ref HEAD refs/heads/NEW".  The explanation in a Ben's
     later message <007401d21278$445eba80$cd1c2f80$@gmail.com> does
     a much better job contrasting the two.

 (3) I identified only one difference as an example sufficient to
     point out why the patch provided is not a pure optimization but
     behaviour change.  Fixing that example alone to avoid change in
     the behaviour is trivial (see if the "info/sparse-checkout"
     file is present and refrain from skipping the proper checkout),
     but a much larger problem is that I do not know (and Ben does
     not, I suspect) know what other behaviour changes the patch is
     introducing, and worse, the checks are sufficiently dense too
     detailed and intimate to the implementation of unpack_trees()
     that it is impossible for anybody to make sure the exceptions
     defined in this patch and updates to other parts of the system
     will be kept in sync.

So my inclination at this point, unless we see somebody invents a
clever way to solve (3), is that any change that violates (1),
i.e. as long as the patch does "Are we doing '-b NEW'?  Then we do
something subtly different", is not acceptable, and solving (3) in a
maintainable way smells like quite a hard thing to do.  But it would
be ideal if (3) is solved cleanly, as we will then not have to worry
about changing behaviour at all and can apply the optimization for
all of the four cases equally.  As a side effect, that approach
would solve problem (2) above.

If we were to punt on keeping the sanity (1) and introduce a subtly
different "create a new branch and point the HEAD at it", an easier
way out may be be one of

 1. a totally new command, e.g. "git branch-switch NEW" that takes
    only a single argument and no other "checkout" options, or

 2. a new option to "git checkout" that takes _ONLY_ a single
    argument and incompatible with any other option or command line
    argument, or

 3. an alias that does "git branch" followed by "git symbolic-ref".

Neither of the first two sounds palatable, though.




        
