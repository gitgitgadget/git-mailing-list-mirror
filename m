Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB84C433EF
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 15:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238496AbiF0Plj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 11:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238485AbiF0Pli (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 11:41:38 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B091211A29
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 08:41:37 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 945E8192408;
        Mon, 27 Jun 2022 11:41:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=eC4DiRdgOIB+
        bzAB/jpvbrfCpnzuIgAw6H0ZJ9eJhq4=; b=Hbur21NPrh2XP7pUHZ83w/rZX4D8
        SIx4RnmPm3IQNPDW2BbnsCnG5HYfInp3AbYulmKcVkJqQeg/jUb0jsZsQR4KX1L0
        ahNINRiARcrHJh0jeFLGuMawycBZIZQJZFiui4DnQkVX9MIlWEH93OQokJ670c6m
        1E93rhGb7IZEoPk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8C178192406;
        Mon, 27 Jun 2022 11:41:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1AC6B192405;
        Mon, 27 Jun 2022 11:41:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3] ls-files: introduce "--format" option
References: <pull.1262.v2.git.1655629990185.gitgitgadget@gmail.com>
        <pull.1262.v3.git.1655777140231.gitgitgadget@gmail.com>
        <220624.86letmi383.gmgdl@evledraar.gmail.com>
        <xmqqsfnuvzxc.fsf@gitster.g>
        <CAOLTT8Tc95-aUE+uN2d8QjTJpGpGw6cBJfG+bpmyE55OcXTSRA@mail.gmail.com>
        <xmqq7d52sehc.fsf@gitster.g>
        <CAOLTT8RpBXR4PaHkaBADG9rWXyV0tRwsFD0VUqBEvPJVofMCNQ@mail.gmail.com>
Date:   Mon, 27 Jun 2022 08:41:30 -0700
In-Reply-To: <CAOLTT8RpBXR4PaHkaBADG9rWXyV0tRwsFD0VUqBEvPJVofMCNQ@mail.gmail.com>
        (ZheNing Hu's message of "Mon, 27 Jun 2022 19:06:25 +0800")
Message-ID: <xmqqh746qfkl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9E4B656A-F62F-11EC-855A-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> =E4=BA=8E2022=E5=B9=B46=E6=9C=8827=E6=
=97=A5=E5=91=A8=E4=B8=80 16:22=E5=86=99=E9=81=93=EF=BC=9A
>>
>> ZheNing Hu <adlternative@gmail.com> writes:
>>
>> >> >> +    else if (skip_prefix(start, "(path)", &p))
>> >> >> +            write_name_to_buf(sb, data->pathname);
>> >>
>> >> These are just "values".
>> >> ...
>> >> >> +    else if (skip_prefix(start, "(size)", &p))
>> >> >> +            strbuf_addf(sb, "size: %u", sd->sd_size);
>> >> >> +    else if (skip_prefix(start, "(flags)", &p))
>> >> >> +            strbuf_addf(sb, "flags: %x", data->ce->ce_flags);
>> >>
>> >> These are not.
>> >>
>> > ... If someone else
>> > need them for some reason, we can add them back.
>>
>> If someone else needs to see "size:" printed in front of the value
>> of sd_size member, we DO NOT HAVE TO DO ANYTHING!  That someone else
>> can write "--format=3Dsize: %(size)" to do so themselves.
>
> Oh, sorry, I mean if someone need some atoms from %(size) to %(flags), =
we can
> add them back.

Ah, I see.  I am not sure about the %(flags) to help the debugging
mode, but giving a single bit "is it dirty?" would be more useful
than giving the cached stat info, I would think.

Thanks.

