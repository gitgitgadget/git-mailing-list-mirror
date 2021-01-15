Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073F8C433E0
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 19:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC8EB235F8
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 19:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732952AbhAOTxk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jan 2021 14:53:40 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53560 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbhAOTxj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jan 2021 14:53:39 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D7133118380;
        Fri, 15 Jan 2021 14:52:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ws8WOpoYy2/VXZVgA8K4qknOJ8Y=; b=rEoa+H
        l3EEsUEsB2kAfyQV46FFeHuUp09Ru2MXzqbTJre/srSUONhEOUMXAko/+Lv2yTKW
        Dt2SU355T2rygw45jl3Zg/Pcz+7je6j3q5MfyDX6IQpfBFfi+tsVMNS7JsT6Ecoa
        lh43/H8Vc9Wf81k9C11erLmMxZoIctyrSqp2k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BNnOinQcyAsUf91RDIQdIjvLfOl+zURN
        9HikweGbtXVzlLYrBkO30zZbEtYn6YkYMxD5pKPWsuqyrH6RiIvrH1OyhctFmWdw
        aoKh7veUG32U8pEvH77X9O9KCNqXGkS2kMiODHp/QKBm6zqByXmHI1I/iTFIvA/0
        qhdkQSTsU9E=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D117611837F;
        Fri, 15 Jan 2021 14:52:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 25A6C11837E;
        Fri, 15 Jan 2021 14:52:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] ci/install-depends: attempt to fix "brew cask" stuff
References: <xmqqk0sevqlh.fsf@gitster.c.googlers.com>
        <xmqqa6tavjgm.fsf@gitster.c.googlers.com>
        <19de3b73-80c6-ccea-9289-fd3f82c103ac@gmail.com>
Date:   Fri, 15 Jan 2021 11:52:53 -0800
In-Reply-To: <19de3b73-80c6-ccea-9289-fd3f82c103ac@gmail.com> (Derrick
        Stolee's message of "Fri, 15 Jan 2021 09:27:56 -0500")
Message-ID: <xmqqpn26rn8q.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4260FB16-576B-11EB-BCD6-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 1/15/2021 12:48 AM, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>>> It seems that homebrew suddenly started giving us trouble, like this:
>>>
>>> https://github.com/git/git/runs/1705953982?check_suite_focus=true#step:3:70
>>>
>>> Here is my attempt to work it around by blindly following the
>>> suggested course of action in the error message, without knowing
>>> what I am doing X-<.  I am not a Mac person.
>>>
>>> What is frustrating is that every time we hit a minor snag like this
>>> to break one of the jobs, all other unrelated jobs are also taken
>>> down.
>>>
>>> Help by those who know what they are doing on macOS would greatly be
>>> appreciated.  Thanks.
>> 
>> After seeing 'seen' with this patch at its tip pass the tests [*1*],
>> I prepared a merge of this change into the tip of 'next' and
>> tentatively updated 'seen' with it.
>> 
>> The test is still running [*2*], but the problematic part in the
>> macOS build has already passed, so I am planning to fast-track this
>> change down to 'next', 'master' and eventually down to 'maint' to
>> keep the CI going to help other platforms catch more interesting
>> problems.
>> 
>> Help from those who are more familiar with macOS and homebrew is
>> still appreciated, though.
>> 
>> 
>> [References]
>> 
>> *1* https://github.com/git/git/actions/runs/486978562
>> *2* https://github.com/git/git/runs/1706704233?check_suite_focus=true#step:3:81
>
> We recently hit this same issue with our macOS builds for Scalar
> and GCM core. Your solution looks very similar to how we fixed
> the problem.
>
> Reviewed-by: Derrick Stolee <dstolee@microsoft.com>

Thanks.
