Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFB6C433E0
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 17:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8972064E77
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 17:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhBVRg3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 12:36:29 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56388 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbhBVRg1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 12:36:27 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 75A8F11E19A;
        Mon, 22 Feb 2021 12:35:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eNz6cETm7eEZtWThBZ/7+ZIwmqw=; b=W+4XPI
        WlWLEGU67fsJl7nDkjPfDFmO7dnIfUKcmsHFXGnL6cOWAQK7l937RHwxa1tDJdGA
        cHfWhOzbzxyt0RACNQspx7dnIfd+KNnsTZ1u6xQBPRXNe+NQsX9U6r6mDk5RpwUX
        X5lSCKY5GOIjqKFJ0ZtIM41tQdD2Oc7/P/fLM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CrTgpjdLPtCf8zjvFID1J7vY9bIuG5SW
        F4KUjUihv9ahBga/DGLBdx/usJdaOcsZgUrmjpFFX1HLaocvjjbNS0GdbKU69v+z
        UfontHWQUoJL9De45nMbKVGreaeVGM/6TNxf7PTXcpMQYH/WFERcstM+CU3eRUTA
        uMplwGFP1NA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6D4BD11E199;
        Mon, 22 Feb 2021 12:35:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B590A11E198;
        Mon, 22 Feb 2021 12:35:42 -0500 (EST)
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
        <xmqq4ki7bf9y.fsf@gitster.g>
        <CAPSFM5cRq9OfxypwTAsv3OFpTPM88e4_agTmFEGbaVyLi6Qbig@mail.gmail.com>
        <xmqqtuq599zj.fsf@gitster.g>
        <CAPSFM5dZ=CR21eqE7Y-4AssD9h0ddnUYpy4PSzWVaf8kzsLv_g@mail.gmail.com>
Date:   Mon, 22 Feb 2021 09:35:41 -0800
In-Reply-To: <CAPSFM5dZ=CR21eqE7Y-4AssD9h0ddnUYpy4PSzWVaf8kzsLv_g@mail.gmail.com>
        (Charvi Mendiratta's message of "Sun, 21 Feb 2021 14:50:05 +0530")
Message-ID: <xmqqft1o80pe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 632D73E2-7534-11EB-A298-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Charvi Mendiratta <charvi077@gmail.com> writes:

>>  So, if it is more work to make the code notice when
>> these options are given in useless combinations and stop with an
>> error message
>
> Sorry I didn't get this and would like to once confirm here that, are
> you pointing to output an error message when the `-m`/`-F` option is
> passed with `git --fixup=amend/reword` ? Because I think we can do
> this also. Otherwise ....

If we were to make -m/-F incompatible with these new features, then
sure, we'd notice the combination, show an error message and abort.

>>than just accepting and doing useless thing, I am OK
>> if we left them as they are.
>
> ....If we allow both `m` and `F` to work with `git commit
> --fixup=amend/reword` with the same working as it is doing now i.e to
> use `m` to write new commit message, upon `--autosquash`, If it is
> okay? then I also agree to update the documentation more precisely and
> include the uses when passed with `m` /`F`(not yet added) option.

What would that more precise documentation would say, though?  

"'-m message' gets appended to the message taken from the original
commit"?  Saying that alone, without explaining why doing such an
appending is useful, would puzzle users and makes them ask "but why
such a useless feature exist?" and that was why I was trying to
figure out what it is useful for with you, which I think we have
failed to do so far.

My preference at this point is to error out the combination that we
cannot figure out how it could be useful at this moment, so that
users who find how it would be useful to come to us and present a
hopefully good case for using -m <msg> with --fixup=amend:<commit>.
I am assuming that allowing the combination at that point is easy,
and the user request will give us a good use case we can use in the
documentation to explain for what purpose a user may want to use -m
<msg> to append a short string at the end.  The end users' use case
we see at that point might even suggest that it would be more useful
to prepend (as opposed to append) the message we get from -m <msg>
to the original log message, and such a change will not be possible
if we just choose to append without thinking through the use case we
intend to support and release "we do not know what good it would do
to append with -m <msg>, but that is what the code happens to do now"
version to the users, as people will depend on the behaviour of any
released versions.
