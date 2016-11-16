Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 499E92021E
	for <e@80x24.org>; Wed, 16 Nov 2016 00:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935318AbcKPAOE (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 19:14:04 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55824 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932822AbcKPAN7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 19:13:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 42FD74E349;
        Tue, 15 Nov 2016 19:13:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8W8uFfipfnKP0BU16rpWbS4UCD8=; b=uxmMdq
        MvTHUI1CHawOeoS8nZHrzKe8HbKFusOoFbhNI4Qi6vJbGx25bhknKAdtILZwciVp
        6ISRVTu3dCkJkjwBY5Y+m/3BT9Lxh8kXs+6HJqfaqNiJAvm8/IlUlv6KQO/epqK2
        tl49XjBpOKT7cbuHwwHchZ8jfB9InU2UrMhG8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vPUD+xAXreE168cjFsa9ilsLjn9mubE+
        1FVtAn9wI6Z7d0P7+5BL34YhUA2BRdvjRXdY1RcjE1nMeToefctc4B3L+6uDPjrg
        2BclD+zAvU8EPPL4fInJCu7qH+ke15Lr5SzVBeDv3WxvKa4tsEErPsvgkwO1RiZp
        RE9kQOkcd7w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 39C7B4E347;
        Tue, 15 Nov 2016 19:13:53 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A9FD74E346;
        Tue, 15 Nov 2016 19:13:52 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Heiko Voigt <hvoigt@hvoigt.net>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Jens Lehmann <Jens.Lehmann@web.de>,
        Fredrik Gustafsson <iveqy@iveqy.com>,
        Leandro Lucarella <leandro.lucarella@sociomantic.com>
Subject: Re: [PATCH v3 4/4] submodule_needs_pushing() NEEDSWORK when we can not answer this question
References: <cover.1479221071.git.hvoigt@hvoigt.net>
        <1d87628994df89751afdcc7e180ebcdc29dde722.1479221071.git.hvoigt@hvoigt.net>
        <CAGZ79kYyyjP7W7gWq6WomVSkhRtMbZZMKYQPFszko4_f9oprgg@mail.gmail.com>
Date:   Tue, 15 Nov 2016 16:13:51 -0800
In-Reply-To: <CAGZ79kYyyjP7W7gWq6WomVSkhRtMbZZMKYQPFszko4_f9oprgg@mail.gmail.com>
        (Stefan Beller's message of "Tue, 15 Nov 2016 14:39:10 -0800")
Message-ID: <xmqqtwb8s2m8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8E52FC34-AB91-11E6-A406-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> "We do not know" ...
>
> ... because there is no way to check for us as we don't have the
> submodule commits.
>
>     " We do consider it safe as no one in their sane mind would
>     have changed the submodule pointers without having the
>     submodule around. If a user did however change the submodules
>     without having the submodule commits around, this indicates an
>     expert who knows what they were doing."

I didn't think it through myself to arrive at such a conclusion, but
to me the above sounds like a sensible reasoning [*1*].

>>   We currently
>> +                * proceed pushing here as if the submodules commits are
>> +                * available on a remote. Since we can not check the
>> +                * remote availability for this submodule we should
>> +                * consider changing this behavior to: Stop here and
>> +                * tell the user how to skip this check if wanted.
>> +                */
>>                 return 0;
>
> Thanks for adding the NEEDSWORK, I just wrote the above lines
> to clarify my thought process, not as a suggestion for change.

One thing I would suggest would be "Stop here, explain the situation
and then tell the user how to skip".  I am not convinced that it
would _help_ users and make it _safer_ if we stopped here, though.

> Overall the series looks good to me; the nits are minor IMHO.

Ditto.


[Footnote]

*1* My version was more like "we do not know if they would get into
    a situation where they do not have enough submodule commits if
    we pushed our superproject, but more importantly, we DO KNOW
    that it would not help an iota if we pushed our submodule to
    them, so there is no point stopping the push of superproject
    saying 'no, no, no, you must push the submodule first'".
