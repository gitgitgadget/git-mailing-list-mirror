Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47C671F461
	for <e@80x24.org>; Wed,  3 Jul 2019 16:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfGCQqc (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jul 2019 12:46:32 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56663 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfGCQqc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jul 2019 12:46:32 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 255657A799;
        Wed,  3 Jul 2019 12:46:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=dwuC3S/6YeRx
        8ejp38/T6Zt2lgg=; b=m+S7PsJvU0fcf6VrvxPX75YT5Lo4gc7+evZVbpMSN8ul
        7EIpalX7bNgG2BuD5DEjmI0Y79bB08o2W69nLLSQnIINwLUYIVUAeiTXqgTeVq6g
        44I1GTLGPxkTxgXl/ZCrct+Pq7638+xqZj+v+IZ8kua6JyCimCwo5VEKWXe0MZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ACh7tp
        hFlx89sTeoV1YLrsKw32mZZ1fdx0wcnsoQg4mQ02Wi5R4R6RSRS1CFzD8aKcSxlX
        80iWF5FRofLQcTosd3/vOgtvHCzR2hU9owfi5RxuDEdO7td/m7MnJn+f4pTcMiaT
        YQY3pargYpdPnuKA4WYyLHHKRrQDb7rbnLes4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1D6117A798;
        Wed,  3 Jul 2019 12:46:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7915E7A797;
        Wed,  3 Jul 2019 12:46:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 2/2] check_everything_connected: assume alternate ref tips are valid
References: <20190701131713.GA25349@sigill.intra.peff.net>
        <20190701131815.GB2584@sigill.intra.peff.net>
        <20190703091225.GQ21574@szeder.dev>
        <20190703164116.GA23260@sigill.intra.peff.net>
Date:   Wed, 03 Jul 2019 09:46:25 -0700
In-Reply-To: <20190703164116.GA23260@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 3 Jul 2019 12:41:16 -0400")
Message-ID: <xmqq5zoj2hi6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 19DC926E-9DB2-11E9-91F0-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Jul 03, 2019 at 11:12:25AM +0200, SZEDER G=C3=A1bor wrote:
>
>> On Mon, Jul 01, 2019 at 09:18:15AM -0400, Jeff King wrote:
>> > diff --git a/t/t5618-alternate-refs.sh b/t/t5618-alternate-refs.sh
>> > new file mode 100755
>> > index 0000000000..3353216f09
>> > --- /dev/null
>> > +++ b/t/t5618-alternate-refs.sh
>> > @@ -0,0 +1,60 @@
>>=20
>> > +test_expect_success 'log --source shows .alternate marker' '
>> > +	git log --oneline --source --remotes=3Dorigin >expect.orig &&
>> > +	sed "s/origin.* /.alternate /" <expect.orig >expect &&
>>=20
>> Unnecessary redirection, 'sed' can open that file on its own as well.
>
> Sure, but is there a compelling reason not to feed it as stdin?

FWIW I do not think it is bad to redirect into a command at all ;-)



