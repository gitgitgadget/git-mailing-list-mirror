Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC7291F461
	for <e@80x24.org>; Thu, 18 Jul 2019 16:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731620AbfGRQM5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jul 2019 12:12:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58017 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727623AbfGRQM5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jul 2019 12:12:57 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 89E1E159280;
        Thu, 18 Jul 2019 12:12:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/os9GaFWOCK2
        F4Ia438/sCwfJok=; b=HWZi2E+B8WXr2q/s/h3u7HNjXH4PyXmkqxWOSV3dB7bc
        w3GeujzsVCw0KfUe5Gh8oQ/f+egy9NM17kYdIL7rgH/aBYlAHBOQhUtmR0W57Xdq
        M/vlly47H0vXBsH+3jvacOsfFf/F9UcWk6FpZvkem6B3J/w9/5hhgUzjRZgS7vI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=v7x2s8
        zOg8px8o+rQzX5FEVV3ciO5wihKeEuAD8Isw/sLljwQSQP3woGEZvk36ZjUCCi2a
        PzCqRbjYQdCywYMLjfInUqo3e3JIhq5XACMmSQClN+er8yx1FNU1kuXn4G02+Lhu
        def8pj68ChdO0B/09yHByTWzLtMc5TbNkijzk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 80B5215927F;
        Thu, 18 Jul 2019 12:12:54 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E522015927D;
        Thu, 18 Jul 2019 12:12:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Carlo Arenas <carenas@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] transport-helper: enforce atomic in push_refs_with_push
References: <20190702005340.66615-1-emilyshaffer@google.com>
        <20190709211043.48597-1-emilyshaffer@google.com>
        <CAPUEspgjSAqHUP2vsCCjqG8b0QkWdgoAByh4XdqsThQMt=V38w@mail.gmail.com>
        <xmqq8ssx53a0.fsf@gitster-ct.c.googlers.com>
        <20190718152234.GI20404@szeder.dev>
Date:   Thu, 18 Jul 2019 09:12:52 -0700
In-Reply-To: <20190718152234.GI20404@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Thu, 18 Jul 2019 17:22:34 +0200")
Message-ID: <xmqqa7dbz5h7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E5E1DDCC-A976-11E9-85D8-46F8B7964D18-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> With that patch issues like this could be caught earlier, while they
> are only in 'pu' but not yet in 'next'.  But do we really want to do
> that, is that the right tradeoff?

I am sort of in favor of having at least one build with an older
compiler without "-std=3Dc99", like the set-up you are proposing.
I got an impression from an earlier message that Jonathan's
preference is the opposite.  I'd prefer to hear opinions from
others, too.

The main reason why we accept other new features like trailing comma
in enum def and designated initializers while rejecting for loop
init is because there apparently are those who build Git with
compilers that accept & reject these combinations of features and
who care enough to report compilation failure from their build.  And
apparently gcc4.8 can serve as a representative "old" compiler,
so...
