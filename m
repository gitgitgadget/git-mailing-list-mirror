Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563C2C6FA82
	for <git@archiver.kernel.org>; Wed, 21 Sep 2022 17:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiIURuA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Sep 2022 13:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiIURt6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2022 13:49:58 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81659248F9
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 10:49:55 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 85ADB1CE08E;
        Wed, 21 Sep 2022 13:49:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=aba3OIjHELBb
        LFNMK0z5YT4/lJ/g8tgOsff3/kgZDuY=; b=ZmdHQlqEk+dqzOeX3/m+XzoMlb3d
        bFT5/lKBXtr8k+k+SvaameBV095EaJ9LVB5hkzNf2dnpQTFan0o6msdjkbQqSNxi
        p7XX7PdwV0O0zve73mvGAiSbG8ClSlsGPehkniw0npJswu1vwq5kRbc8guutcxlD
        1m4+HfVMeIMIZ2w=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7F83A1CE08D;
        Wed, 21 Sep 2022 13:49:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 164081CE08C;
        Wed, 21 Sep 2022 13:49:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] t/Makefile: remove 'test-results' on 'make clean'
References: <20220920105407.4700-1-szeder.dev@gmail.com>
        <20220920201619.40972-1-szeder.dev@gmail.com>
        <220921.865yhh5hx0.gmgdl@evledraar.gmail.com>
Date:   Wed, 21 Sep 2022 10:49:48 -0700
In-Reply-To: <220921.865yhh5hx0.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 21 Sep 2022 08:59:54 +0200")
Message-ID: <xmqqzges39dv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CA2C6DD4-39D5-11ED-BDE8-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Tue, Sep 20 2022, SZEDER G=C3=A1bor wrote:
>
>> The 't/test-results' directory and its contents are by-products of the
>> test process, so 'make clean' should remove them, but, alas, this has
>> been broken since fee65b194d (t/Makefile: don't remove test-results in
>> "clean-except-prove-cache", 2022-07-28).
>>
>> The 'clean' target in 't/Makefile' was not directly responsible for
>> removing the 'test-results' directory, but relied on its dependency
>> 'clean-except-prove-cache' to do that [1].  ee65b194d broke this,
>> because it only removed the 'rm -r test-results' command from the
>> 'clean-except-prove-cache' target instead of moving it to the 'clean'
>> target, resulting in stray 't/test-results' directories.
>>
>> Add that missing cleanup command to 't/Makefile', and to all
>> sub-Makefiles touched by that commit as well.
>>
>> [1] 60f26f6348 (t/Makefile: retain cache t/.prove across prove runs,
>>                 2012-05-02)
>>
>> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
>> ---
>
> Thanks, and sorry about the breakage. I've looked this over carefully &
> it fixes the edge-case you noted without making anything else that I
> could spot worse.
>
> In case it helps:
>
> 	Reviewed-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>
> It's still a bit odd to have a "clean" that cleans up a thing it *might
> have* generated, i.e. sometimes we create & use these via a Makefile
> target, and sometimes by manually invoking test scripts.

I think this is perfectly fine, but we could also use "distclean"
for cleaning up something that might have been created.

Thanks, both.

Will queue.

