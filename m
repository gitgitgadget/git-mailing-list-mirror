Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1EA31F461
	for <e@80x24.org>; Fri, 19 Jul 2019 19:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbfGSTPT (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jul 2019 15:15:19 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58080 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727734AbfGSTPT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jul 2019 15:15:19 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0EF6179EBE;
        Fri, 19 Jul 2019 15:15:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nXGy7J63QinEKMxpD8KNpxZldhk=; b=vNcku1
        o//y6sru1fC4eCl1vw9kk2yY8f3XjbNWriYATulgGZu7nQWkSJ9ByP++GxKRK208
        BLaQqy4kY3pRu91FSXAHfJgSIQxQZNhlYYZybOkCNtJa1pGH06tzT6uVAsbf7MQ+
        2p9wswOGCvi8rmnbJL+oxmKRcueQefPZfaP/0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aJR5aYzNnPbB3yB/8gYG0VuJ4IT9Qrih
        eOD9MFJYxjuDXMqhlEOcvaqBfj6c5Pi2qge27ZX6THUrXDOpM2ybRbM0WqmE5U1T
        euRflJzxQj7+pBeEJ9dcBtJ7x00fFbYKwnS6+fkwclQ6gg+kMWJYg+N1UCoVC6OY
        6sfQmdEYtS8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0579679EBD;
        Fri, 19 Jul 2019 15:15:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 10DEC79EBC;
        Fri, 19 Jul 2019 15:15:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] transport-helper: enforce atomic in push_refs_with_push
References: <20190702005340.66615-1-emilyshaffer@google.com>
        <20190709211043.48597-1-emilyshaffer@google.com>
        <CAPUEspgjSAqHUP2vsCCjqG8b0QkWdgoAByh4XdqsThQMt=V38w@mail.gmail.com>
        <xmqq8ssx53a0.fsf@gitster-ct.c.googlers.com>
        <20190718152234.GI20404@szeder.dev>
        <20190719013128.GB251102@google.com>
        <CAPUEsphnCvK+RZ+h30ZarA1zo9yZ=ndEBrcAbKGf4W92j647vA@mail.gmail.com>
Date:   Fri, 19 Jul 2019 12:15:10 -0700
In-Reply-To: <CAPUEsphnCvK+RZ+h30ZarA1zo9yZ=ndEBrcAbKGf4W92j647vA@mail.gmail.com>
        (Carlo Arenas's message of "Thu, 18 Jul 2019 21:49:47 -0700")
Message-ID: <xmqqwogdvnsx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 891F6C6A-AA59-11E9-9E86-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

> On Thu, Jul 18, 2019 at 6:31 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>>
>> This makes sense to me.  Not really for the 'for' loop declaration
>> aspect: for that, I'd want some more specialized tool that allows
>> turning on such a check specifically.  But more because Ubuntu trusty
>> is still a platform that some people use (though hopefully not for
>> long), so it's helpful as a representative old platform to see if we
>> break the build on it.
>
> FWIW this also breaks Centos 7 using gcc 4.8.5, as well as the one
> originally reported (Centos 6), and anything else that uses gcc 4
> (tested up to 4.9.4)

Thanks.
