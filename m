Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F838C12002
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 22:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 121A3613B2
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 22:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbhGNWrw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 18:47:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63883 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbhGNWrw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 18:47:52 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8AC58C86DC;
        Wed, 14 Jul 2021 18:44:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=M7ME/qEnKHXu
        9qbYYqFUatlvDNtSVYimgXzJiCRmKsI=; b=bTCAoR/SEG06uPoIbDKCj5mnQJzo
        l7celvBQOkBO7cpt5gLvsYardk9NNaZT9F+88UZEhtHwy6pe6ijhve5mON+3SuPk
        juTfQ356UKSStc8HCPFvfqhZKB//nhKrXvEjadWc73OLYL85Vc4GWVodDQbY+ftd
        nun1EPXE/9nJrNY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 82595C86D8;
        Wed, 14 Jul 2021 18:44:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 09054C86D6;
        Wed, 14 Jul 2021 18:44:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Stephen Manz <smanz@alum.mit.edu>
Subject: Re: What's cooking in git.git (Jul 2021, #03; Tue, 13)
References: <xmqqmtqpzosf.fsf@gitster.g>
        <CAPig+cQfsACHAQhCrXDs==18p1Ds8MtMRZDmSfso9HsO6dF-qg@mail.gmail.com>
        <xmqqlf68yi1z.fsf@gitster.g>
        <CAPig+cQjyYGidKA3sNc6Xr3aw0mk_t-s_64qaX13ffv5R_CHLA@mail.gmail.com>
Date:   Wed, 14 Jul 2021 15:44:58 -0700
In-Reply-To: <CAPig+cQjyYGidKA3sNc6Xr3aw0mk_t-s_64qaX13ffv5R_CHLA@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 14 Jul 2021 18:39:27 -0400")
Message-ID: <xmqqo8b4tt05.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1E3FA6F2-E4F5-11EB-9EAE-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Jul 14, 2021 at 12:30 PM Junio C Hamano <gitster@pobox.com> wro=
te:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>> > I think this series is ready and gave my Reviewed-by: here[1]. One o=
f
>> > the new tests contains an unnecessary but harmless `test -f`[2], but
>> > it's such a minor nit that I doubt it's worth demanding a re-roll.
>>
>> I think having "test -f" is the right thing to do, so [2] is
>> probably OK as-is.  test_cmp may want to complain about a possible
>> bug in the test when given a missing file.  [...]
>
> We tried relatively recently to have test_cmp() complain about a
> missing file[1], but both =C3=86var[2] and Peff[3] ran into problems in
> which tests (presumably) legitimately called test_cmp() on missing
> files, so the suggestion was made to revert the check[4], which is
> indeed what happened[5].

Yes, I know all that, and even with that, having "test -f" is the
right thing to do, so [2] is probably OK as-is.

> [1]: https://lore.kernel.org/git/20200809174209.15466-1-sunshine@sunshi=
neco.com/
> [2]: https://lore.kernel.org/git/20200921104000.2304-15-avarab@gmail.co=
m/
> [3]: https://lore.kernel.org/git/20201016001704.GA2937048@coredump.intr=
a.peff.net/
> [4]: https://lore.kernel.org/git/CAPig+cSU=3D1GcQuqZab+0Vff_A-JmD59wEc3=
RMr3wDojpgRYUuw@mail.gmail.com/
> [5]: https://lore.kernel.org/git/xmqqv9f9ao0v.fsf@gitster.c.googlers.co=
m/
