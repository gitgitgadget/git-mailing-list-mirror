Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AD942047F
	for <e@80x24.org>; Mon,  7 Aug 2017 21:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751950AbdHGVhD (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 17:37:03 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60384 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751589AbdHGVhC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 17:37:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A1BF8A0A41;
        Mon,  7 Aug 2017 17:37:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tE9irWROfXJiropYShKo71F0+O0=; b=uoAkOp
        jhC+W7CTwsJUFPuY2UpS7jaMN4oCX52X7SbBW9Qk7wGEGr+6/a1ImqaLtBSY2wO+
        fz/cSGylwpEs/qg/pCnU1RUZtUXDkyRl7Y266UA3EwYkuzPAJzQ9J8YvpUJeQKl7
        pVC1Ted4tjwtg/MtMkRUTZhuvufq7kDmUIzAk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=G9kJm3H5LR24mZURVIX0/A/2m0BHbZCI
        yCDWUSzADzv+wvCO+sLsaSls4Djv2CTxQfK0umtlTeFnxc32FDEBRuN9c4/GKjqu
        AP7FHiDV37O2l+ex/npgBCrS9jEp1IM4NqPm2pXIHvsOejkKZMZWOlGGFaAr27pJ
        A0CqKXvOt0M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 97A59A0A40;
        Mon,  7 Aug 2017 17:37:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7C9CBA0A3E;
        Mon,  7 Aug 2017 17:37:00 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Martin Koegler <martin.koegler@chello.at>, git@vger.kernel.org
Subject: Re: [PATCH] Fix delta integer overflows
References: <1502129437-31226-1-git-send-email-martin@mail.zuhause>
        <xmqq1sonql76.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1708072136290.4271@virtualbox>
        <xmqqshh3p3b0.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1708072307410.4271@virtualbox>
Date:   Mon, 07 Aug 2017 14:36:59 -0700
In-Reply-To: <alpine.DEB.2.21.1.1708072307410.4271@virtualbox> (Johannes
        Schindelin's message of "Mon, 7 Aug 2017 23:10:39 +0200 (CEST)")
Message-ID: <xmqqwp6fnjpg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8BA6CAEA-7BB8-11E7-8C40-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> So are you saying that starting with v2.14.0, you accept patches into `pu`
> for which you would previously have required multiple iterations before
> even considering it for `pu`?
>
> Frankly, I am a bit surprised that this obvious change from `unsigned
> long` to `size_t` is not required in this case before queuing, but if the
> rules have changed to lower the bar for patch submissions, I am all for
> it. I always felt that we are wasting contributors' time a little too
> freely and too deliberately.

This is not about where the bar is set.  It is about expectation.  I
do not expect much from occasional (or new) contributors and I try
not to demand too much from them.  The consequence is that as long
as a small patch makes things better without making anything worse,
I'd want to be inclusive to encourage them to build obvious
improvements on top.  Maybe they just want a single patch landed to
fix their immediate needs (which may be generic enough and expected
to be shared with many other people) without going further, so I may
end up queuing something that only helps 40% of people until follow
up patches are done to cover the remaining 60% of people, but that
is fine as long as the patch does not make things worse (it is not
like a patch that helps 40% while hurting the remaining 60% until
a follow-up happens).

I would expect a lot more from experienced contributors, when I know
they are capable of helping the remaining 60% inside the same series
and without requiring too much hand-holding from me.  The same thing
I cannot say to a occasional (or new) contributor---they may not be
coorperative, or they may be willing to do more but may require more
help polishing their work than the bandwidth I can afford.

So if you are volunteering to help by either guiding Martin to aim
higher and make this a series with a larger and more complete scope,
I'd very much appreciate it.  Or you can do a follow-up series on
top of what Martin posted.  Either is fine by me.  Just do not step
on each others' toes ;-)

I avoided saying all of the above because I didn't want my word
taken out of context later to make it sound as if I were belittling
the competence of Martin, but you seem to want to force me to say
this, so here it is.

