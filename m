Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30560C433DB
	for <git@archiver.kernel.org>; Sat, 20 Feb 2021 03:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02781600CC
	for <git@archiver.kernel.org>; Sat, 20 Feb 2021 03:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbhBTDQm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Feb 2021 22:16:42 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57555 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhBTDQl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Feb 2021 22:16:41 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8D77C11607D;
        Fri, 19 Feb 2021 22:15:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OJLQIAXPp+ips9Vv9S7lStNocwo=; b=O7wzLX
        HpTjfN6WcDk/Tn+KWj5QOX7Tr2TH/6/mrLk36TNOAx6UJU9esvWJX0hHVublJmGK
        4uEI/AtCqxvw83rUaWsh/B+KdM9x0zjl5wBgU9OIRBPjfsOUqHR3wQ0q7c4RxNvz
        E4bsZKZruGVi4+L0W7YuCoA9qdgyGzKofEYs8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mgwIrNmhSXYhkoGm+t3bw0+2nhjqtnmO
        FaDpTsuGCtTH2Y03/MaGu4bQajZBNVCEUtU3TF5Dx8syqxL1zkxiEAzEhALmjcS6
        x5D1VG+NJGpf/jrvPqxt9T4SEk4m+29u5QkuSMLkEJ3yS6oKIrsxsjyol0fVDj/E
        3ziHIpd6bsw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8595711607C;
        Fri, 19 Feb 2021 22:15:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7DA4C11607B;
        Fri, 19 Feb 2021 22:15:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 2/6] commit: add amend suboption to --fixup to create
 amend! commit
References: <20210217072904.16257-1-charvi077@gmail.com>
        <20210217073725.16656-1-charvi077@gmail.com>
        <20210217073725.16656-2-charvi077@gmail.com>
        <xmqq35xulbj0.fsf@gitster.g>
        <CAPSFM5ddkALLCU+k+Th=pvKHEaarr_45DSn=N5DCJu1o7_5-Eg@mail.gmail.com>
        <xmqqpn0xfal8.fsf@gitster.g>
        <CAPSFM5eJNUdzy0CA1GNjNkqL_a7ivM8qydxvHf3208nznkG9KQ@mail.gmail.com>
Date:   Fri, 19 Feb 2021 19:15:53 -0800
In-Reply-To: <CAPSFM5eJNUdzy0CA1GNjNkqL_a7ivM8qydxvHf3208nznkG9KQ@mail.gmail.com>
        (Charvi Mendiratta's message of "Fri, 19 Feb 2021 11:39:34 +0530")
Message-ID: <xmqq4ki7bf9y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F1F71DEC-7329-11EB-9ADB-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Charvi Mendiratta <charvi077@gmail.com> writes:

> For end-users "-m" or "-F" will make it easier to prepare an "amend!"
> commit. Because using the "-m" reduces the cost of opening an editor
> to prepare "amend!" commit and it can be done with command line only.

Hmph.  That is not very convicing to me.  The user is motivated
enough to fix a wrong commit log message and replace it with an
improved one by using the "--fixup:amend" feature---why would that
improved message can sufficiently be written with just an "-m
message", which by definition would be much less capable of
preparing a well-thought-out message than with an editor?

Yes, with "-m", you can add some short string easily at the end of
the existing commit message without opening an editor.  But I am
trying to see why it is a good thing to be able to do so in the
first place.  It is very easy to make typoes while doing so and it
would be hard to fix these typoes, exactly because you are doing so
without being in an editor.  And the whole point of --fixup=amend is
about improving the message (as opposed to --fixup that is to record
the contents that have already been improved in the index).

This is why I kept asking what the use case would look like.  I am
trying to find out if you have a good end-user story in mind that we
can use in the documentation to sell the feature to end-users, but I
am not seeing one.

Is the combination of "--fixup=amend" and "-m <msg>" meant to be
used primarily "to leave a note to myself" when the user runs
--fixup=amend:<commit>, to just record the points to be elaborated
when the message is written for real much later?  E.g.

    ... hack hack hack ...
    ... good stopping point, but cannot afford time to write
    ... a good log message now
    $ git commit --fixup=amend:HEAD~2 -m 'talk about X, Y and Z' -a
    ... hack hack hack ...
    ... possibly doing something entirely different ...
    ... finally comes back to finish cleaning up the branch for real ...
    $ git rebase --autosquash -i origin

And one of the insn created in the todo sheet would be amend!, whose
commit message has the message taken from the original HEAD~2 PLUS the
reminder to the user that s/he needs to talk about X, Y and Z?  And
the user at that point writes more comprehensive message about these
three things?

That is a made-up example of what "appending some short strings
possibly full of typoes without having to open an editor" could be
useful for.  I am not sure if it is truly useful, or if it is just a
hand wavy excuse not to mark -m/-F incompatible with --fixup=amend
without a real merit [*].

    Side note: one reason why I do not find it realistic is that it
    is unlikely that the user would use --fixup=amend to slurp in
    the original log message when recording "good stopping point,
    but cannot afford time" fixup.  "--squash HEAD~2 -m <msg>" would
    be much faster to record the "note to myself" reminder, and when
    the user finally comes back to clean things up, the amount of
    work to edit the original's message while looking at the "note
    to myself" appended at the end would not be any different in
    either workflow.

In any case, that was the kind of answer(s) I was looking for when I
asked "what is this good for?" question.

Thanks.
