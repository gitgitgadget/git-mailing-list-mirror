Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E81AC433FE
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 07:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10B8921734
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 07:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgLGH1A (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 02:27:00 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54002 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgLGH1A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 02:27:00 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6C101A95AF;
        Mon,  7 Dec 2020 02:26:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=J8/73gTcg9oDYXU7rjKalnrLnkE=; b=HQTWcO
        pyexmyMB93/dRipTMUcJd80Ax1x2JjM45NBYUV2KUbJS7SHOhdexzJN08dBx3/Qd
        FUBA9o7mUuuUlhB+ySTCIJfkFiT+BVKybG7ov5sK3Ae0pv3wLgfhiO3MjAti+W98
        lvwDLtAdOGtBgxM9wYfofr4g3WSbboelxglUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Y36pUtl5bLsyRoG5a13woJ5p0Vz5De3Z
        XSaO1l/iJFyTq2ad34rCJP/6ilom8QqYxMJIBmli2yPJYRXXUnDnXw2mR3W31vtj
        G5Ja73ZNA1DRlqqtd+8QMM9nAez7oWxqVZMzoqG94JoSCH/PipCp/4hRW/oH4EV1
        UZTMuH3s5xU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 62C1DA95AE;
        Mon,  7 Dec 2020 02:26:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E0A86A95AD;
        Mon,  7 Dec 2020 02:26:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?Q?V=C3=ADt?= Ondruch <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jacob Keller <jacob.keller@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v2 02/14] pull: improve default warning
References: <20201204061623.1170745-1-felipe.contreras@gmail.com>
        <20201204061623.1170745-3-felipe.contreras@gmail.com>
        <CABPp-BFdjj=+4jk0vo=kpNc6ug1=UgtKfXJZkseyyxut2VB=Uw@mail.gmail.com>
        <CAMP44s1eTc4+tbULbyz5ENgbcN4tOVBA3Z-4GS4yMpciUD_1Hw@mail.gmail.com>
        <CABPp-BFwWBLdFPsKi3o9hznFtAeWWfhNAyuymPS4BhMAHpnSfw@mail.gmail.com>
        <CAMP44s1=aZL7BMKSjzKJ7qYqg-usScwzRUJmaOhsCGvQ4ieYow@mail.gmail.com>
        <CABPp-BF4rXBOKsn8bG6y3QUEtNVV9K2Pk5NmwrU5818CqhRt_Q@mail.gmail.com>
        <CAMP44s2L24jhCG9ps72--ZiJkXUovR726jCf8JTLHAs0jV7Whg@mail.gmail.com>
        <CABPp-BGdNt8TBMTE9zvaicF5AtvyTBhpiJXqkuZc7mBLGbw0Qw@mail.gmail.com>
Date:   Sun, 06 Dec 2020 23:26:15 -0800
In-Reply-To: <CABPp-BGdNt8TBMTE9zvaicF5AtvyTBhpiJXqkuZc7mBLGbw0Qw@mail.gmail.com>
        (Elijah Newren's message of "Sat, 5 Dec 2020 17:01:36 -0800")
Message-ID: <xmqqeek2cc14.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7DD8EEF6-385D-11EB-A3E9-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>>   Pulling without specifying how to reconcile divergent branches is discouraged;
>>   you need to specify if you want a merge, a rebase, or a fast-forward.
>>   You can squelch this message by running one of the following commands:
>>
>>     git config pull.rebase false  # merge (the default strategy)
>>     git config pull.rebase true   # rebase
>>     git config pull.ff only       # fast-forward only
>>
>>   You can replace "git config" with "git config --global" to set a default
>>   preference for all repositories.
>>   If unsure, run "git pull --merge".
>>   Read "git pull --help" for more information.
>>
>> This warning says:
>>
>> 1. There's 3 options: merge, rebase, fast-forward
>> 2. merge is the default strategy
>> 3. If unsure, specify --merge (the default strategy)
>>
>> So taken altogether it does say what is the default strategy.
>
> We don't need to take them together.  #2 by itself states the default
> strategy.  I don't see why defending #3 as being for the purpose of
> documenting the default strategy is helpful, since it doesn't do that.

Would it work if the line were

	If unsure, run "git -c pull.rebase=false pull".

then?

The reason why I bring this up is because the first part only talks
about the choices in the terms of configuration variables, and for
those who are afraid of committing, there is no easy way, unless
they know the "git -c" single-shot mechanism, to "go ahead with one
choice in an experimental basis to see if that is what they want",
and "specify --merge" does not click well with "pull.rebase=false"
that is given in the first part.  "git pull --no-rebase" may also
work better than "git pull --merge" from that point of view, though.

But see below.


>> Do you think the crew should disregard the passenger's volition and
>> force him to pay attention to the safety demonstration?

An example that is irrelevant.  Passengers who sit on the aisle side
and clutter the floor with their luggages can pose public hazard,
and it is quite sensible for crews to remove them from the plane.  

A team member who runs "pull --[no-]rebase" pushes the result, which
may be a new history in a wrong shape, back to the shared repository
probably falls into a different category.  ... Or perhaps in the
same public hazard category?

> Useful link there.  Based on his comments, we may want to make
> --ff-only, --merge, and --rebase all be mutually exclusive and result
> in an error message if more than one is specified at the command line.

I hope "his comment" does not refer to what I said.  Redefining the
semantics of --ff-only (but not --ff=no and friends) to make it
mutually incompatible with merge/rebase was what Felipe wanted to
do, not me.

FWIW, I see the general direction as

 - When the history you are pulling is not a descendant of what you
   have on your current branch, you must show your preference
   between merging their history into yours or rebasing your history
   onto theirs.

 - In such a case, we error out, with an error message telling them
   that they must tell us which one they want in this invocation
   (e.g. with "--rebase" or "--no-rebase").  We further tell them
   that pull.rebase can be used to record their preference, if they
   almost always use the same.

	Side note: I earlier said "see below" to refer to this.  I
	think the message should offer what they can do right now
	with command line option first, and then give an option to
	configure.  IOW, the message quoted in the beginning of this
	response gives information in a wrong order.  Also,
	"discouraged" is misleading, isn't it?  When we give this
	message, we refuse to proceed until the user specifies.

	Another thing to consider is that pull.ff=only (and
	--ff-only) may be wrong choice to offer in the error message
	quoted above, if one of the objectives is to reduce the
	"annoying" message that tells the user that they must
	choose.  By definition, we do not give the message when our
	side do not have our own development, so "I could run 'pull
	--ff-only'" is a unusable knowledge to those who see the
	message and want to get out of the situation.

 - But when the history being pulled is a descendant of the current
   branch, and the user does not give us preference between merge
   and rebase (either from the command line or with configuration),
   there is no need to give such an error message---if you do not
   have your own development, we can just fast-forward the current
   branch to what we fetched from the other side.  This does not
   happen with the current system, which is what we want to fix.

 - Also when the history from the other side is a descedant and the
   user has preference, either to rebase or to merge, either from
   the command line or with configuration, we can fast-forward the
   current branch to their tip, but there are wrinkles:

   . when --ff=no is given and the choice is to merge (not rebase),
     we must create an extra merge commit.

   . when the choice is to rebase, by definition, rebasing what you
     have on top of theirs in this case is the same as fast-forwarding
     the current branch to theirs, because "what you have" is an
     empty set.

   . I am not sure how "pull --rebase --ff=no" should interact if we
     don't have our own development.  Rebasing our work on top of
     theirs is philosophically incompatible with marking where the
     side branch begins and ends with an extra commit, so it either
     should be rejected when the command line and configuration is
     parsed (i.e. regardless of the shape of the history we have at
     hand), or --ff=no gets silently ignored when --rebase is given.
     I haven't thought this one through.
