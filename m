Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1F1F1F87F
	for <e@80x24.org>; Tue,  4 Jun 2019 21:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfFDVeA (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jun 2019 17:34:00 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61585 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfFDVeA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jun 2019 17:34:00 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CF18C741D2;
        Tue,  4 Jun 2019 17:33:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=FcA+EYzeoru7
        yGU4xM2yUyPqTP4=; b=aseeXwotDm+Q5zGUO0npt9IqIOA6vtWXvWMGNGaMItJd
        eYkOCKMWypnMmahEQg2rYF3auYo3go34M/cpXB2z+2qKaAB+rNhgr4bIVLNfxTmh
        JdeZLL3nhSc33T5Z02Jo3ndDCb6Z7YSKdXcCCypTx41GDCOwRxbFW5qILhj/A1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=fMIsTc
        RFJF5GYMqigZyfhoD8bQoN7hsl4eSsFrK9rUmE34FalgXXboZ6J5CntPPGBZz1Ff
        m3iAIi8Y5L7+MaWQVOQTuNHHc2tuBnsJs/XzcjwBZzCyNOdqIp9pZ6XQuaMwu7S7
        WiMuYMFBHdx6EnLdMKfq3rB+BMshOHH2PwLqw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C7C2F741D0;
        Tue,  4 Jun 2019 17:33:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 01B91741CF;
        Tue,  4 Jun 2019 17:33:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        ben.humphreys@atlassian.com,
        Ben Humphreys <behumphreys@atlassian.com>
Subject: Re: [PATCH v2] merge-recursive: restore accidentally dropped setting of path
References: <20190604072614.26885-1-newren@gmail.com>
        <20190604202750.3925-1-newren@gmail.com>
        <20190604210754.GT951@szeder.dev>
Date:   Tue, 04 Jun 2019 14:33:53 -0700
In-Reply-To: <20190604210754.GT951@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1b?=
 =?utf-8?Q?or=22's?= message of
        "Tue, 4 Jun 2019 23:07:54 +0200")
Message-ID: <xmqqzhmxrq66.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 74CB978C-8710-11E9-86A8-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

>> +		test_must_fail git merge-file \
>> +			-L "HEAD" \
>> +			-L "" \
>> +			-L "A^0" \
>> +			ours empty theirs &&
>> +		git hash-object b >actual &&
>> +		git hash-object ours >expect &&
>> +		test_cmp ours b
>
> Here, however, you only changed what test_cmp looks at, but still kept
> the two 'git hash-object' invocations, and their output will never be
> looked at.

Thanks for quickly responding to a problem report and coming up with
a solution with further polishing, all.


