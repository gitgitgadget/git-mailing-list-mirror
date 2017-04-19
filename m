Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1266F207BC
	for <e@80x24.org>; Wed, 19 Apr 2017 02:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759013AbdDSCkl (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 22:40:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58464 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1758883AbdDSCkk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 22:40:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0609982055;
        Tue, 18 Apr 2017 22:40:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=G8IzPWk8+aGI
        LZS+y++3p/4mRQ4=; b=qG0M/s1zRE3meOUKphr1bS1xryZfKPHouMxl85hHmxch
        TGum+N5Y9eYhc1wGuVOe+eqR29FVBK3lUETypVPd7j8gVayU1l9zoYc5Dn1F+u76
        0kd5Avx/1tId6sOu4H23GPkuM5FA+rkBTecT5y7TAOY1gr1rfZLimAOeuBbNMps=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=hDOi9J
        2GcDMmPOrs3KJ7W16HutMwwesXLU815XvdIp40TCHmgsu5LhL4+uWmtILIz4SkFQ
        dV3EOTXyEuIAAfsrbgHxOwI34HQ0LVPn6gKLkYt/J0D/YYDLIfeR5oSduXChmBNF
        e/PEVJ/KunceQalDzOKHfGqAZjQhocsPy9EtY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F253582053;
        Tue, 18 Apr 2017 22:40:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6D7AE82052;
        Tue, 18 Apr 2017 22:40:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] various: disallow --no-no-OPT for --no-opt options
References: <20170418170914.9701-1-avarab@gmail.com>
        <de79d366-3609-8efe-b23a-7e793036b3ef@web.de>
        <20170419014143.56io56xn6mawy5xi@sigill.intra.peff.net>
Date:   Tue, 18 Apr 2017 19:40:37 -0700
In-Reply-To: <20170419014143.56io56xn6mawy5xi@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 18 Apr 2017 21:41:43 -0400")
Message-ID: <xmqqh91lce6y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9289041A-24A9-11E7-9B05-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Apr 19, 2017 at 12:29:18AM +0200, Ren=C3=A9 Scharfe wrote:
> ...
>> PARSE_OPT_NONEG should only be used for options where a negation doesn=
't
>> make sense, e.g. for the --stage option of checkout-index.
>
> I think we do strive to avoid "--no-no-foo", and instead have "--no-foo=
"
> and "--foo" to cover both sides.  So for example:
>
>> > -		OPT_BOOL(0, "no-add", &state->no_add,
>> > +		OPT_BOOL_NONEG(0, "no-add", &state->no_add,
>> >   			N_("ignore additions made by the patch")),
>
> This could be more like:
>
>   OPT_NEGBOOL(0, "add", &state->no_add, ...)
>
> where NEGBOOL would be smart enough to show "--no-add" in the help as
> the primary.

I very much appreciate that this topic to avoid --no-no-OPT
nonsense, but just disabling --no-no-OPT without giving --OPT the
meaning the user who would have used --no-no-OPT wanted does not
sound like a good solution.  Your NEGBOOL looks like a better
approach.

> It might even be possible to detect the existing line and
> have parse-options automatically respect "--foo" when "--no-foo" is
> present.  But that may run afoul of callers that add both "--foo" and
> "--no-foo" manually.

True but wouldn't that something we would want to avoid anyway?
That is, "git cmd [--OPT | --no-OPT | --no-no-OPT]" from the end
user's point of view should be an error because it is unclear what
difference there are between --OPT and --no-no-OPT.  And we should
be able to add a rule to parse_options_check() to catch such an
error.

Having said that, I am not sure if we want to go the route of
"existing line that begins with 'no-' behaves magical".  For
boolean, I suspect we may be get away with such a magic without
confusing ourselves too much, though.

Thanks.
