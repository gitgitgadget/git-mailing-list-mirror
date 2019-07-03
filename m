Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDA6F1F461
	for <e@80x24.org>; Wed,  3 Jul 2019 17:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfGCRGB (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jul 2019 13:06:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50822 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfGCRGA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jul 2019 13:06:00 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 78A8E1530FC;
        Wed,  3 Jul 2019 13:05:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ztb62yBvjsgK
        2d5P7ogvrQcy4RI=; b=O1ThJjvKIaJPCSFnuwtM9uMAFXEIh2mrT7dr5OQUIKOy
        h2ihPwGZQbr2Cw2VYJIYiA0SslhF7Yu8nXL8kgqguXKMiKz38jbNTTGQgv/l3kXD
        B19nA4wsXb4TvCi6eQYxUtrZFM2GbwEVEeLMXiZr+r1Ce0KxWQz5/OOiAY/TrU8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=m3iLYi
        4QRy++Q8EDybd+2Hw5nuyUvsYv/rwtKNB+bTpH0tfRt8CdvbBAB+t/yLJD4tjYAB
        rN6gC9g9dk+jLadf9lOG513C1YfYQtAV8NwdXJJdgbGB1Y2H+BzV5hN8SXB1711J
        qfVDGqClPymYX42sGxQeF5t0GiiYYcoWhm6+M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 705471530FB;
        Wed,  3 Jul 2019 13:05:58 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A41AE1530F8;
        Wed,  3 Jul 2019 13:05:57 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 2/2] check_everything_connected: assume alternate ref tips are valid
References: <20190701131713.GA25349@sigill.intra.peff.net>
        <20190701131815.GB2584@sigill.intra.peff.net>
        <20190703091225.GQ21574@szeder.dev>
        <20190703164116.GA23260@sigill.intra.peff.net>
        <20190703165036.GS21574@szeder.dev>
Date:   Wed, 03 Jul 2019 10:05:56 -0700
In-Reply-To: <20190703165036.GS21574@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Wed, 3 Jul 2019 18:50:36 +0200")
Message-ID: <xmqqwogz1217.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D35BEC56-9DB4-11E9-A8AD-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> On Wed, Jul 03, 2019 at 12:41:16PM -0400, Jeff King wrote:
>> On Wed, Jul 03, 2019 at 11:12:25AM +0200, SZEDER G=C3=A1bor wrote:
>>=20
>> > On Mon, Jul 01, 2019 at 09:18:15AM -0400, Jeff King wrote:
>> > > diff --git a/t/t5618-alternate-refs.sh b/t/t5618-alternate-refs.sh
>> > > new file mode 100755
>> > > index 0000000000..3353216f09
>> > > --- /dev/null
>> > > +++ b/t/t5618-alternate-refs.sh
>> > > @@ -0,0 +1,60 @@
>> >=20
>> > > +test_expect_success 'log --source shows .alternate marker' '
>> > > +	git log --oneline --source --remotes=3Dorigin >expect.orig &&
>> > > +	sed "s/origin.* /.alternate /" <expect.orig >expect &&
>> >=20
>> > Unnecessary redirection, 'sed' can open that file on its own as well=
.
>>=20
>> Sure, but is there a compelling reason not to feed it as stdin?
>
> Not really, other than there is no compelling reason to do so :)

For this particular one, it would not make much difference, but when
feeding a single file to a command that can take many instructions
as command line arguments, I tend to prefer

	$ cmd <input \
		-e 's/foo/bar/' \
		-e 's/xyzzy/frotz/g' \
		...

which I find slightly easier to read than

	$ cmd \
		-e 's/foo/bar/' \
		-e 's/xyzzy/frotz/g' \
		... \
		input


