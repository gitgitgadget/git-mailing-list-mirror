Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA129C433E0
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 22:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E56522E01
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 22:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731809AbhASWLX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 17:11:23 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54363 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729484AbhASWKt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 17:10:49 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7DF51A2078;
        Tue, 19 Jan 2021 17:10:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0UPw9yM/q66gFR57YIhvtLwHNcI=; b=WZyVJ+
        87ULPcaTTDn0gyNdQSCWR0gS8T9eSazVdjI/b1Gl4XhYSwURD3zLhNkB3xXQMGv9
        kvtu5/mNOHxV7gIHpqDhOtfkbP4JCi5pvF3T/4zTdQrMk9JDjnfQpMr8NAUJ3mGE
        Xk0ZNl5g3CODtbAlD0oAOCxQTnWL7KjsNh/mo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZQ5sIzsUaE8MgYILH2FIu47XjdegPToj
        338eS8q15gERG2fan3Qxjss0a1WmznlU7GvPfRvvR2qFXoxxhmRrukEhsHVRJgPu
        MA1s2I5l7DctL8tqw8lijrDgOxbqF3Lat3Ke9KuRfAwNe1FK3Z7EFZrP9HmCu7e/
        +GbjmhtkMBw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6B540A2077;
        Tue, 19 Jan 2021 17:10:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.99.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2B1AFA206E;
        Tue, 19 Jan 2021 17:10:04 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kyle Marek <kmarek@pdinc.us>
Cc:     Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 1/2] revision: Denote root commits with '#'
References: <196101d6eab6$20714550$6153cff0$@pdinc.us>
        <20210117110337.429994-1-kmarek@pdinc.us>
        <20210117110337.429994-2-kmarek@pdinc.us>
        <xmqq7dobmfrq.fsf@gitster.c.googlers.com>
        <e0264a29-2112-f8c8-f066-2be445654d8e@pdinc.us>
        <xmqqwnwajbuj.fsf@gitster.c.googlers.com>
        <xmqqr1mij88k.fsf@gitster.c.googlers.com>
        <237aeef3-239f-bff4-fa17-5581092c8f51@pdinc.us>
Date:   Tue, 19 Jan 2021 14:10:01 -0800
In-Reply-To: <237aeef3-239f-bff4-fa17-5581092c8f51@pdinc.us> (Kyle Marek's
        message of "Tue, 19 Jan 2021 02:43:57 -0500")
Message-ID: <xmqq1reginnq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 14EA0D54-5AA3-11EB-8C54-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kyle Marek <kmarek@pdinc.us> writes:

>> So the condition we saw in your patches, !commit->parents, which
>> attempted to see if it was root, needs to be replaced with a helper
>> function that checks if there is any parent that is shown in the
>> output.
>> ...
>> Hmm?
>
> Okay, I see what you mean. Fixing --graph to avoid implying ancestry
> sounds like a better approach to me.

Sorry, I do not know how you drew that conclusion from my
description.

All I meant to convey is "roots are not special at all, commits that
do not have parents in the parts of the history shown are, and care
must be taken to ensure that they do not appear to have parents".

And the argument applies equally to either of two approaches.
Whether the solution chosen is

 (1) to use special set of markers "{#}" for commits that do not
     have parents in the displayed part of the history instead of
     the usual "<*>", or

 (2) to stick to the normal set of markers "<*>" but shift the graph
     to avoid false ancestry.

we shouldn't be special casing "root commits" just because they are
roots.  Exactly the same issue exists for non-root commits whose
parents are not shown in the output, if commits from unrelated
ancestry is drawn directly below them.

> That being said, I spoke to Jason recently, and he expressed interest
> in optionally marking root commits so they are easy to search for in a 
> graph with something like /# in `less`. I see value in this,

I do not mind to denote the "this commit may appear directly on top
of another commit, but there is no ancestry" situation with a
special set of markers that is different from the usual "<*>" (for
left, normal and right) set.  I agree pagers are good ways to /search
things in the output.

> So would you be open to my modifying of the patch in question (patch
> 1+2 squashed, I guess) to instead use "--mark-roots=<mark>" to
> optionally mark root commits with a string <mark>, and pursue fixing
> the --graph rendering issue in another series?

I do not mind if the graph rendering fix does not happen yet again;
IIRC the past contributors couldn't implement it, either.

I think this new feature should be made opt-in by introducing a new
option (without giving it a configuration variable), with explicit
"--no-<option>" supported to countermand a "--<option>=#" that may
appear earlier on the command line (or prepare your scripts for
later introduction of such a configuration variable).

I do find it troubling if the <option> has "root" in its name, and I
would find it even more troubling if the feature somehow treated
root commits specially but not other commits that do not have their
parents shown.  It was the primary point I wanted to stress in the
previous two message [*1*].

I am hoping that a single option can give three-tuple that replaces
the usual "<*>", with perhaps the default of "{#}" or something.

I however offhand do not think of a way to make "left root" appear
in the output, but because we'd need "right root" that looks
different from ">" anyway, it may make sense to allow specifying
"left root" just for symmetry.


[Footnote]

*1* But if we do not think of a good option name without the word
    "root" in it, I might be talked into a name with "root", as long
    as we clearly describe (1) that commits that has parents that
    are not shown in the history are also shown with these letters,
    and (2) that new contributors are welcome to try coming up with
    a new name for the option to explain the behaviour better, but
    are not welcome to argue that the option should special case
    root commits only because the option is named with "root" in it.


