Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6821CC433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 07:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbiCAHfm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 02:35:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbiCAHfl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 02:35:41 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D157DE2F
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 23:35:01 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1EAE41886B9;
        Tue,  1 Mar 2022 02:35:01 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=JhFI2m6UtC52
        KG78fNs6EdgTOwBq3iw7LZerWp2HziI=; b=yeHysG2Iuc3VTp+Q4kFpTURsgGHv
        DrBlAuDspHpBtmfQkSd8+dILtnScF4/afjeRuJqDyPdSTGPi6LNPPcwnETzTQ7kY
        9HOEhF0FEnwQXLkE9NhpJrMA6MWUsRnMYKl4XmAVcL++oIcHw2PYDPzx8/wK1pTm
        8tB4rK9KCZgxOpI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 06A851886B8;
        Tue,  1 Mar 2022 02:35:01 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5D1FC1886B5;
        Tue,  1 Mar 2022 02:34:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Glen Choo <chooglen@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 13/13] submodule--helper update-clone: check for
 --filter and --init
References: <20220301000816.56177-1-chooglen@google.com>
        <20220301044132.39474-1-chooglen@google.com>
        <20220301044132.39474-14-chooglen@google.com>
        <220301.86o82q16ib.gmgdl@evledraar.gmail.com>
Date:   Mon, 28 Feb 2022 23:34:57 -0800
In-Reply-To: <220301.86o82q16ib.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 01 Mar 2022 08:21:58 +0100")
Message-ID: <xmqqbkyqt9b2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 18BAAA14-9932-11EC-B98B-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>> index 2ffc070319..3e8a05a052 100644
>> --- a/builtin/submodule--helper.c
>> +++ b/builtin/submodule--helper.c
>> @@ -2543,7 +2543,12 @@ static int update_clone(int argc, const char **=
argv, const char *prefix)
>>  	};
>> =20
>>  	const char *const git_submodule_helper_usage[] =3D {
>> -		N_("git submodule--helper update-clone [--prefix=3D<path>] [<path>.=
..]"),
>> +		N_("git submodule [--quiet] update"
>> +		"[--init [--filter=3D<filter-spec>]] [--remote]"
>> +		"[-N|--no-fetch] [-f|--force]"
>> +		"[--checkout|--merge|--rebase]"
>> +		"[--[no-]recommend-shallow] [--reference <repository>]"
>> +		"[--recursive] [--[no-]single-branch] [--] [<path>...]"),
>
> Since this has <repository>, <path> etc. it should still be marked for
> translation with N_().

Yeah, that sounds like a good idea.  Isn't it already inside N_()?
