Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6C8C2D0A3
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 20:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 818F221556
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 20:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Nnq3XwyJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbgKCUVo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 15:21:44 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52232 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbgKCUVo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 15:21:44 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 320E79AE75;
        Tue,  3 Nov 2020 15:21:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=I/xt5Q0ulWFEObLNKvqgMOV1liI=; b=Nnq3Xw
        yJz2EjqOiWdFF54BvTr51E9v+5ZDCtj+F1fUs/APbmyDccO251L2UM7CGdsuJ38j
        8qalEI4rvD9sCNqMXxagG42agbRQo6Tz8T4MVRH64mPLC7lQye/J1vsV0drN9ih+
        wap4ivxk5w36Ue00BgTjUSF5nVFQ8Q1bHlJ7g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rJxuA8dPctUU3GD+qzCiObB8WcQJTWI5
        WfUdCwXu0u5luxus9yuy9MmT0sWxAp0UOmQuxsQfelB1mNuLyspKRWmeBRQEk3N4
        WrQuCHuJk3ALVAB7EMx/NeNerfIyUbT2Ys+7l4Fz1XmNsojL/I89pLPZ9Q7FIU//
        +fXfF7LZ8KU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 283C89AE74;
        Tue,  3 Nov 2020 15:21:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 94F389AE71;
        Tue,  3 Nov 2020 15:21:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Sathyajith Bhat <sathya@sathyasays.com>, git@vger.kernel.org
Subject: Re: Segfault in git when using git logs
References: <CAMsWJsyPVQWV++gc2YJriEOEWBELa_xj2G0NWFMSgNYt47swiQ@mail.gmail.com>
        <20201102144321.GA3962443@coredump.intra.peff.net>
        <20201103101553.GH24813@szeder.dev>
        <20201103182102.GA459792@coredump.intra.peff.net>
        <xmqq361qs31a.fsf@gitster.c.googlers.com>
        <20201103185711.GA461461@coredump.intra.peff.net>
Date:   Tue, 03 Nov 2020 12:21:42 -0800
In-Reply-To: <20201103185711.GA461461@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 3 Nov 2020 13:57:11 -0500")
Message-ID: <xmqqimamqjhl.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2FDE235C-1E12-11EB-8E93-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Nov 03, 2020 at 10:34:09AM -0800, Junio C Hamano wrote:
>
>> > On our side, I don't think it would be _wrong_ to catch and disallow the
>> > combination. But it may be nicer to them if we continue to quietly
>> > ignore --follow and the pathspec in that case, for working with older
>> > versions. (OTOH, if I understand correctly they're segfaulting every
>> > time VS Code is used with v2.29 now, so they may have to accept it as an
>> > urgent fix anyway).
>> 
>> So something like this won't harm VS Code more than we currently do,
>> while telling users what is wrong with their command line?
>
> Yeah, I was wondering if we'd want the patch you sent, or if we should
> turn those die() calls into warning() and disable the flags up front.
>
>> We may still want the "silently disable follow" at low-level
>> protection, but that does not give feedback why the end-user option
>> is silently ignored, so...
>
> I'd be just as happy to leave it out, if we think it isn't triggerable.
> The segfault would let people know we missed a spot. ;)
>
>> diff --git c/builtin/log.c w/builtin/log.c
>> index 9f939e6cdf..8811084f02 100644
>> --- c/builtin/log.c
>> +++ w/builtin/log.c
>> @@ -206,6 +206,13 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
>>  	if (argc > 1)
>>  		die(_("unrecognized argument: %s"), argv[1]);
>>  
>> +	if (rev->line_level_traverse) {
>> +		if (rev->diffopt.filter)
>> +			die(_("-L<range>:<file> cannot be used with pathspec"));
>
> Should this be checking rev->diffopt.pathspec.nr?

Embarrassing but yes ;-).
