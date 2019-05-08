Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5B801F45F
	for <e@80x24.org>; Wed,  8 May 2019 03:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfEHD50 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 23:57:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65354 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbfEHD50 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 23:57:26 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DAEFC14F0D3;
        Tue,  7 May 2019 23:57:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=jicawxPzjVWA
        WKBkiMJz3p1fHDU=; b=Lee0pYyVQqFQnQJ7dnCeAPH5Kx/uGYg5sgyo5sBMfi4W
        yk5V7sj/6eRZGnMsn0jqp8F1c6VElS9s70osmvKpjBUcQdO5fo3vV7peADlr0A5h
        0H7a1Snd1+qPm/OjjidxOsod0NuhzLuj2nReLoFFeP/Rv6HmOpGgcOM+xM+It8o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ORTIG9
        6KXKW6oX3gT88iTKGeCPcMfWHApVXwJpgzWn47jFFZjnJpS4ivqe1rEZwgIrtnvt
        w58IGCLjnMwN3tnWqyGBwNIUGJ5X57HnjzjEQW+qAO/HSYx1Zj9xztqUD+a+w2Z7
        irO5DRR8O/MmUkspAv1epGFOobrDWZibXLNWE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D113014F0D2;
        Tue,  7 May 2019 23:57:23 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 39D7214F0D1;
        Tue,  7 May 2019 23:57:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [RFC WIP PATCH v8 00/13] learn --keep-base & more
References: <cover.1555832783.git.liu.denton@gmail.com>
        <20190508001252.15752-1-avarab@gmail.com>
Date:   Wed, 08 May 2019 12:57:22 +0900
In-Reply-To: <20190508001252.15752-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 8 May 2019 02:12:39 +0200")
Message-ID: <xmqqa7fxionx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 629B8724-7145-11E9-AD45-46F8B7964D18-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> This is a WIP series I have that I figured I'd send out as-is for
> comment since Junio said he'd be merging dl/rebase-i-keep-base down.
>
> So I wanted to test it, and as seen early in this series in 3/13 and
> 4/13 we had significant blindspots in our tests, i.e. there were no
> tests for whether --no-ff bypassed the amended logic as it should.
>
> As seen from those tests we may have some bugs here, either existing
> or new, needs more poking at it.

Thanks.  I am actually OK to keep dl/rebase-i-keep-base out of
'next' to iron out the kinks.  It's not like we are in a hurry to
deliber an important fix to our users---the topic is adding a new
feature and attempting to fix a minor irritation (i.e. lost
opportunity to fast-forward).

> Then in 9/13 and 10/13 I re-added the incomplete patches I had in
> https://public-inbox.org/git/20190221214059.9195-1-avarab@gmail.com/
> to see if my tests passed with Denton's --fork-point code, they
> do. Yay!
>
> Left them there because I was wondering if I needed to port some/all
> of the tests over, and maybe amend a commit message to reword some of
> my findings in
> https://public-inbox.org/git/871s3z6a4q.fsf@evledraar.gmail.com/
>
> Then I have 11/13 and 12/13 which seem pretty sensible to me as-is,
> and finally I wanted --preserve-merges and --rebase-merges to also
> benefit from this logic, so 13/13 is a WIP patch for that. The code
> should be done (although maybe there's a better way to do it...), but
> it needs a better commit message & tests.
