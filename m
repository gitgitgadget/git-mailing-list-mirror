Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC1DC433EF
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 21:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236579AbiDFVzv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 17:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235298AbiDFVzT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 17:55:19 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F04B8
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 14:51:32 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5FB1312DF5E;
        Wed,  6 Apr 2022 17:51:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=6zUivpOaWbRW
        BaBVf/sigoJfHOQV7hUX68/NenY/KLs=; b=gz+FMeA/oKD2nkWSsaK2dbnIsUwF
        SpPGYcKAhTJ0bajrBmvVc96mTv75Bpu7SfANNBxNp9eFmbSuvfNMSwTRMuDk17nw
        hO9OoWpUdaQM8bfK2+CTeoshcHj6Te8QdsEFHn4oudq9z23GU5NGNGDBwrnAcyP6
        ZCoggNwNsqCkiWY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 56B0312DF5D;
        Wed,  6 Apr 2022 17:51:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BD38C12DF5C;
        Wed,  6 Apr 2022 17:51:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Josh Steadmon <steadmon@google.com>,
        Johannes.Schindelin@gmx.de, congdanhqx@gmail.com,
        dyroneteng@gmail.com, martin.agren@gmail.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v2] ls-tree: fix --long implying -r regression in
 9c4d58ff2c3
References: <9ce4dadf140204e934f7025bb91385c376118940.1649111831.git.steadmon@google.com>
        <patch-v2-1.1-ed83b3b74ab-20220404T234507Z-avarab@gmail.com>
        <xmqqwng2xfi8.fsf@gitster.g>
        <220406.8635iqdjzl.gmgdl@evledraar.gmail.com>
Date:   Wed, 06 Apr 2022 14:51:29 -0700
In-Reply-To: <220406.8635iqdjzl.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 06 Apr 2022 22:36:20 +0200")
Message-ID: <xmqq4k35x4m6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B7DB3F2C-B5F3-11EC-A116-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>>> +	cat >expect &&
>>> +	cat <&6 >expect.-d &&
>>> +	cat <&7 >expect.-r &&
>>> +	cat <&8 >expect.-t &&
>>
>> Let's not go too cute like this.  This forces the caller to remember
>> which among 6, 7, and 8 corresponds to which option.  It is too ugly
>> to live.
>
> I think it's rather elegant actually, but to be fair it would, per:
>
> 	git grep '<&[1-9]| [1-9]<<-'
>
> Be the user with the most FD's using this sort of pattern.

Please give a clear explanation why "-d" has to be 6, "-r" 7 and
"-t" 8, that can be used by developers as a memory aid to help them
write new tests using the helper.

Or justify why the developers have to memorize such a meaningless
correspondence, if there is no any good reason.

Alternatively, you can stop abusing the word "elegant".  It is not a
synonym to "what I wrote" ;-).
