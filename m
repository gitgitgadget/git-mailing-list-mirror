Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C510C388F7
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 17:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEC392074F
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 17:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hj0pcjEr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730227AbgKIRCG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 12:02:06 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55184 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729432AbgKIRCF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 12:02:05 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A2108FC895;
        Mon,  9 Nov 2020 12:02:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=JyUtHyT5CYrS
        ep5DeIfqQ8p5P7I=; b=hj0pcjErOTLS4sONYBhvKlxyg7+dRxIqQapwd4be9Q1S
        TotzyHMtcVUymZOJZ4cCWucA2o8UIFChuUAwx1ws0I2KeKJXNxed53qfPlrmPK6s
        iclk/s4v0wr4MQcK/4yS72zVwCBqL5yDuZWseyi/rSQi8TLn6LgRcDB7bB3Gn50=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=cuBmCY
        48AydM/8eNABVS2Mx7rHCdxpNRylGJE7yT5MVOF+xvXpNL5kS9ti8eA7jSXp9lAV
        mr6YYmFSm6Xm6YmjHYiXrq+LWy5dQP5PcoG+gveEilr9vnOq59A3Yf0+ywA2bGso
        hIQ3HsJFKi3cD4cP48GoekSQzHNKNXlOW7dTc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9930DFC894;
        Mon,  9 Nov 2020 12:02:03 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CAEFDFC891;
        Mon,  9 Nov 2020 12:02:00 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sangeeta <sangunb09@gmail.com>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [Outreachy][PATCH v6] diff: do not show submodule with
 untracked files as "-dirty"
References: <pull.751.git.1602781723670.gitgitgadget@gmail.com>
        <20201026175742.33356-1-sangunb09@gmail.com>
        <20201107111002.GA21309@danh.dev>
        <CAHjREB4=ESipt0r00WmueTH8h+2zQxLjJhky72M6dF-EX3WafQ@mail.gmail.com>
Date:   Mon, 09 Nov 2020 09:01:58 -0800
In-Reply-To: <CAHjREB4=ESipt0r00WmueTH8h+2zQxLjJhky72M6dF-EX3WafQ@mail.gmail.com>
        (Sangeeta's message of "Mon, 9 Nov 2020 20:49:51 +0530")
Message-ID: <xmqqr1p2cvll.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 48B06954-22AD-11EB-80EF-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sangeeta <sangunb09@gmail.com> writes:

>> > diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
>> > index ca04fac417..9104d1946d 100755
>> > --- a/t/t3701-add-interactive.sh
>> > +++ b/t/t3701-add-interactive.sh
>> > @@ -765,6 +765,11 @@ test_expect_success 'setup different kinds of d=
irty submodules' '
>> >       cat >expected <<-\EOF &&
>> >       dirty-both-ways
>> >       dirty-head
>> > +     EOF
>> > +     git -C for-submodules diff-files --name-only --ignore-submodul=
es=3Dnone >actual &&
>> > +     cat >expected <<-\EOF &&
>> > +     dirty-both-ways
>> > +     dirty-head
>>
>> This will throw-away above change to "expected", I think this is not
>> what you expected to write!
>
> I am sorry I couldn't understand what you mean by that. I think that
> is what I expected to write. I want those changes to be in "expected".

Looking at the above quoted part again...

	cat >expected <<-\EOF &&
		... content 1 ...
	EOF
        git ... >actual &&
	cat >expected <<-\EOF &&
		... content 2 ...
	EOF

I think =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wants to say is that e=
xpected originally
has content 1, and that is discarded because you overwrite the same
file with content 2.  So either

 - if content1 and content2 are identical, perhaps you do not have
   to write content2 into expected at all, or

 - if content1 and content2 are different, perhaps you forgot to
   consume content1 before overwriting it.

THe latter is quite plausible, as the original test without your
addition must be consuming content1 after the part you added.

