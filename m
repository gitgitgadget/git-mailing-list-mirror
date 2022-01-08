Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3255C433EF
	for <git@archiver.kernel.org>; Sat,  8 Jan 2022 00:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbiAHAwH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 19:52:07 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51583 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiAHAwG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 19:52:06 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4EE3716F971;
        Fri,  7 Jan 2022 19:52:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=wVWchtv7+O9f
        XkO0hrvtUfCCdlEDicDvSWFlbfBZ91A=; b=cJY+8meiwxjL/okKhaw9Ne0qmikF
        ADoxWMYfoAnNete39fMefTEs2PZdJlpjI4NEqAbi+g4LCFHBCae5a7IBEiO47xYk
        AeSINVUJ4hDOSThTuDxyVfIRwZ+PvxEeUtTTcQBODL+5yLvIIsacNQxsQzW9il1C
        AzyzcQxVT+x39e0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4774216F970;
        Fri,  7 Jan 2022 19:52:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B3EE916F96F;
        Fri,  7 Jan 2022 19:52:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Jessica Clarke <jrtc27@jrtc27.com>, git@vger.kernel.org
Subject: Re: [PATCH] apply: Avoid ambiguous pointer provenance for
 CHERI/Arm's Morello
References: <20220105132310.6600-1-jrtc27@jrtc27.com>
        <xmqqczl4bhmo.fsf@gitster.g>
        <8739caad-aa3d-1f0f-b5dd-6174a8e059f6@web.de>
        <xmqq35lz9vxl.fsf@gitster.g>
        <4f05f434-7bd1-d563-94bd-607858deb1f8@web.de>
Date:   Fri, 07 Jan 2022 16:51:57 -0800
In-Reply-To: <4f05f434-7bd1-d563-94bd-607858deb1f8@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 8 Jan 2022 01:04:23 +0100")
Message-ID: <xmqqsftz3v82.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3209B584-701D-11EC-AE2C-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>>> Or strsets -- we only need two.
>>
>> True.
>>
>> When we check a path, we make a single look-up of two bit in a
>> single hashtable but now we need two look-ups, but addition, removal
>> and renaming of a symlink would be rare enough to matter either way.
>
> Hmm, symlinks changes are rare, but this only affects the register phas=
e
> (which should be noticeably slow for the string_list based code with it=
s
> O(n*log(n)) lookup per registered symlink if there were a lot of them).
> But the final lookups are done for each path _component_, of any file
> type.
>
> I suspect that two lookups in (sparsely populated) hash tables are stil=
l
> fast enough.  (At least I couldn't measure any difference with git appl=
y
> and a patch between v2.33.0 and v2.34.0.)

Yup.  I do not think it matters, and the resulting code is certainly
a lot simpler and easier to read ;-)

Thanks.
