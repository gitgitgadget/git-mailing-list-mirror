Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAA101F462
	for <e@80x24.org>; Fri, 14 Jun 2019 16:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbfFNQM5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 12:12:57 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63789 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfFNQM5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 12:12:57 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9BEE9688FB;
        Fri, 14 Jun 2019 12:12:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/XCXs8LOhN8K
        sGJfdcuWXDAxTuA=; b=OKJTX9DAcbTHSFC/uAuntQlvRyke+KJH23mwLp6S3t/e
        dcCKHls5sElqUL+1pziuCBOC0Zhu7Mik36YVolruGhhGl5Yei03pktswsAi8WqLR
        YcyShuUGQ9CccZPTGh608GyaHtyvWQJeIdr9Pq0GDSMUUGZZqPXyg6deO2YMDbE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=fGx7R+
        AmStK5/p3WWzNC++KlVAbfk+TUzbFDTffRfnwcrO6YA2YppH2NyJd+evWZzZvipI
        BXSwpa/VSwepih9uPuDjmAHG3evHcnTSHTc8X3W1Oahr7EUWeuWnId2NYmfqc48/
        ILd+rrFs6Hxb9QuZ6zK7JjoX/Iii+Lg2VlG/c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 956F2688FA;
        Fri, 14 Jun 2019 12:12:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BECDA688F9;
        Fri, 14 Jun 2019 12:12:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/4] kwset: allow building with GCC 8
References: <pull.265.git.gitgitgadget@gmail.com>
        <c1527a71672056859a4613f2318bcbfce31e8b50.1560426581.git.gitgitgadget@gmail.com>
        <20190614095308.GG31952@szeder.dev>
Date:   Fri, 14 Jun 2019 09:12:50 -0700
In-Reply-To: <20190614095308.GG31952@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Fri, 14 Jun 2019 11:53:08 +0200")
Message-ID: <xmqq4l4suovx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4325D98E-8EBF-11E9-89AA-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

>> Now, the proper thing to do would be to switch to `size_t`. But this
>> would make us deviate from the "upstream" code even further,
>
> This is not entirely true: upstream already uses 'size_t', so the
> switch would actually bring our copy closer to upstream.

Ah, earlier I said that within the context how kwset uses obstack,
it is perfectly proper to fix it like the patch in question did, but
the upstream already using size_t changes the picture quite a bit.

I do not mind updating our copy of obstack, but make sure you pick
the version with license compatible with ours.

Thanks.
