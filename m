Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35413C433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 22:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbiDUWoY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 18:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiDUWoX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 18:44:23 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EA53DA5B
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 15:41:33 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A3ACD196EBA;
        Thu, 21 Apr 2022 18:41:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=s/0IoMII0fWrLspBomt2v4P5410kfzzSYKI+eU
        s7t44=; b=G/BIIVLPW7DshZ8ksHODea0oz2RZZXKNPp476WWcLzc6AxAR9P4kzV
        Zpl6tLOZoHpjqu9EqL6Jo3qunO/vk3XIbPDSqnGVBIzpSmF++cUnI9cfGNWU764b
        G1Y2/vWbUgT/wHFi7cSCMKvANpqS/CwaLU67TTApBGj22JfG/D9Ys=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9B810196EB9;
        Thu, 21 Apr 2022 18:41:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2CFF0196EB5;
        Thu, 21 Apr 2022 18:41:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] CI: don't care about SHA256 mismatch on upstream
 "perforce" package
References: <cover-0.2-00000000000-20220421T124225Z-avarab@gmail.com>
        <patch-2.2-28208bac859-20220421T124225Z-avarab@gmail.com>
        <xmqqo80uf9jn.fsf@gitster.g>
        <220421.86pmla5eja.gmgdl@evledraar.gmail.com>
        <CAPig+cTWj2Xf4sfMJBkzLhG5oUBS+Pb5-D-K50xMt9rP0doBRA@mail.gmail.com>
        <xmqq7d7if76u.fsf@gitster.g>
        <CAPig+cSMJJem_1t0rVwjbU9SsQfBpmbE2Yn6wZeNsY=h-1MAkg@mail.gmail.com>
Date:   Thu, 21 Apr 2022 15:41:27 -0700
In-Reply-To: <CAPig+cSMJJem_1t0rVwjbU9SsQfBpmbE2Yn6wZeNsY=h-1MAkg@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 21 Apr 2022 17:48:20 -0400")
Message-ID: <xmqq5yn2dppk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2F3E4BAA-C1C4-11EC-8C17-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Thu, Apr 21, 2022 at 5:38 PM Junio C Hamano <gitster@pobox.com> wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>> > Any of
>> > the following would likely be less confusing (in no particular order
>> > of preference):
>> >
>> >     * sed -i .bak -e '...' "$path"
>> >     * rename dance
>> >     * perl -pi -e ...
>>
>> That order happens to match my preference, but if the first one
>> comes with a comment to dissuade readers to copy-and-paste the
>> construct to other places in our code, that would be even better.
>
> Bikeshedding: I think I would prefer the rename-dance over a lengthy
> comment meant to dissuade people from copying this non-portable usage,
> especially since people often fail to read comments. The rename-dance
> idiom, on the other hand, can be cargo-culted without harm.

Yeah, that is fine, too.
