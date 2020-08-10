Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D94C433E0
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 22:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDAC820748
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 22:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="n/AaO9Qg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbgHJWJo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 18:09:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58944 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgHJWJn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 18:09:43 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1EA0587D2B;
        Mon, 10 Aug 2020 18:09:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xjbh4S1ZI8CUqpLeVs4Sau+hEC4=; b=n/AaO9
        QgFu3FJJLQVe1z3rwQ1dvXhKpsV9UoakcIK7tbPZ+bC3RjA2Eu5lOUSlCBwroHs0
        uaRTNjEZGkSe9H3iuScEX32JxtP/KACQOAY3nxEcUIcSwcdAotLyNdfZnl4s5xEY
        /YSLjySyiWKQWFjDSYPkiklHsTJiCiLktRw0E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lwdWpInaPNWmwpYotreaqDByB9fWtfom
        Xz7yuELQn3jYWAhN7XbaJvXZg3UL5djNpbgS50jCjE/2QIoNgMeTMUJeABm6yruk
        1QtpWRCil3QcweZNX/Wt9ZpwqGziEo3949CXbBrVYQLO/ffZ1e0aF46kRmQiC9we
        uaIsCIu2YVw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 174FB87D2A;
        Mon, 10 Aug 2020 18:09:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9ABC887D29;
        Mon, 10 Aug 2020 18:09:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     "Raymond E. Pasco" <ray@ameretat.dev>,
        Git List <git@vger.kernel.org>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH] t4069: test diff behavior with i-t-a paths
References: <20200808075323.36041-1-ray@ameretat.dev>
        <20200810085343.43717-1-ray@ameretat.dev>
        <CAPig+cSn_wrBuMKzoUZ720Hy-Y9RuPpJtmZ1mr--cnyAP866-Q@mail.gmail.com>
        <CAPig+cQCMG3Dx99LWTOAe8wZ2ocdikQAzdDS=-APfYE9HVn+=A@mail.gmail.com>
Date:   Mon, 10 Aug 2020 15:09:39 -0700
In-Reply-To: <CAPig+cQCMG3Dx99LWTOAe8wZ2ocdikQAzdDS=-APfYE9HVn+=A@mail.gmail.com>
        (Eric Sunshine's message of "Mon, 10 Aug 2020 17:47:46 -0400")
Message-ID: <xmqqk0y6b1b0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2FF51FA2-DB56-11EA-853A-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, Aug 10, 2020 at 12:23 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>> To tighten this test, perhaps it makes sense to take a different
>> approach and check the exact output rather than merely grepping for a
>> particular string. In other words, something like this might be better
>> (typed in email, so untested):
>>
>>     cat >expect <<-\EOF &&
>>     diff --git a/test-file b/test-file
>>     index HEX..HEX HEX
>>     --- a/test-file
>>     +++ b/test-file
>>     EOF
>>     cat blueprint >test-file &&
>>     git diff --ita-visible-in-index -- test-file >raw &&
>>     sed "s/[0-9a-f][0-9a-f]*/HEX/g' raw >actual &&
>>     test_cmp expect actual
>
> This can be improved by taking advantage of the OID_REGEX variable
> defined by the test suite for matching an OID. So something like this
> would be even better:
>
>     cat >expect <<-\EOF &&
>     diff --git a/test-file b/test-file
>     index OID..OID 100644
>     --- a/test-file
>     +++ b/test-file
>     EOF
>     cat blueprint >test-file &&
>     git diff --ita-visible-in-index -- test-file >raw &&
>     sed "s/$OID_REGEX/OID/g" raw >actual &&
>     test_cmp expect actual

OID_REGEX is [0-9a-f]{40} while what is used here is [0-9a-f]{1,}.
Unless --full-index is in use, they mean different things, no?
