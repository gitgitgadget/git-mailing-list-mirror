Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE33FC00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 21:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239238AbiG2VXs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 17:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238328AbiG2VXq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 17:23:46 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4261988CCF
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 14:23:46 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CB8CE1A41CE;
        Fri, 29 Jul 2022 17:23:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ohCG0w838ly9EF1PwcL0S8Wi6UybQYS6LFmbDL
        xUaTQ=; b=B9bZ9shmfxlvVtfk8jjW/ru9W7YtTxdr5DJUzcwKeLriOXBmp0pECH
        qRP6rRttSLPkZv9tgIuqZ1vIBGPgrcJDx9sdp29T5g1Gu4BRGHTvYwMAJgrAs8Qv
        JjHwYeFPTCmsmaCmnNXpXHyetAKSIfSJO2pig3SUdxYpLYw0azOLo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C4AED1A41CD;
        Fri, 29 Jul 2022 17:23:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5DF8F1A41CB;
        Fri, 29 Jul 2022 17:23:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqn?= =?utf-8?B?biBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH] merge-file: fix build warning with gcc 4.8.5
References: <365e01e93dce582e9d926e83bdc6891310d22699.1659084832.git.congdanhqx@gmail.com>
        <xmqqbkt7api9.fsf@gitster.g>
        <YuQ60ZUPBHAVETD7@coredump.intra.peff.net>
        <CAPig+cSiAEgopj1zwR4kUG=ZLJQrNAVj0P5g4veWYD-ERr=irw@mail.gmail.com>
        <YuRKe/LdNs0u7G2w@coredump.intra.peff.net>
Date:   Fri, 29 Jul 2022 14:23:41 -0700
In-Reply-To: <YuRKe/LdNs0u7G2w@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 29 Jul 2022 17:00:43 -0400")
Message-ID: <xmqqzggr4nqa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B88270F4-0F84-11ED-AE35-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Jul 29, 2022 at 04:48:55PM -0400, Eric Sunshine wrote:
>
>> Leaving aside for the moment the problem with Apple's oddball invented
>> version numbers for `clang`, should this patch also take older `clang`
>> versions into consideration rather than focusing only on `gcc`? (Of
>> course, `clang` could be dealt with in a separate patch if you'd
>> rather not worry about it here.)
>
> I was just fixing the reported gcc issue, and forgot totally that clang
> had been mentioned in previous rounds. I'd be happy to just see a clang
> patch on top of this once somebody figures out the right versions (but
> it may be impossible without figuring out the oddball Apple thing).

I am willing to say that we do not care about "oddball Apple thing"
and have developers on that platform to propose how to handle their
compiler.

In any case, https://gcc.gnu.org/bugzilla/show_bug.cgi?id=53119
seems to indicate that given enough time this problem will
disappear, so I'd refrain from suggesting to use -Wno-missing-braces
everywhere.

Thanks.
