Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA8E81F991
	for <e@80x24.org>; Mon, 31 Jul 2017 22:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751607AbdGaW2V (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 18:28:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55016 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751176AbdGaW2U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 18:28:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3F6B4A76B2;
        Mon, 31 Jul 2017 18:28:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=3r5tfdJt2u2u
        yKf3wLoFMIsx/Sk=; b=CgYcon2O1G79z72Sh+H9plMOsSU/vAdQklYeuy20CgFP
        9ypArAnTcCMnbYvY/2oXXU2hO3pMju8bYag6kHXBCFjZtpyeWXSSAF3fTd3swMXm
        5ErkoAYekju7lzihFeFcQ1hdrkXHN8pEz1K7tYokJ70vf9DCx7i3N0GXeypU82g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=pScaT+
        xLdtvTidQ3WDlt5ssqrGDbR5wBT3itzCV11ExPwIFVRSoymDQexpCbnhgoT9eOty
        NqhKWCPunrQ0t1+33DNKrQ6sl6mMpKhMwi1QiuUr7Spto9LanmkpuPamXZDiZyid
        1g5oAlRo7vaQvTIaX2VImsbumkyN/J9j6Lb54=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 385F0A76B1;
        Mon, 31 Jul 2017 18:28:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8EA49A76B0;
        Mon, 31 Jul 2017 18:28:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Takashi Iwai <tiwai@suse.de>,
        Git Mailing List <git@vger.kernel.org>,
        Andreas Stieger <astieger@suse.com>
Subject: Re: [PATCH] hash: Allow building with the external sha1dc library
References: <s5hh8y19hyg.wl-tiwai@suse.de>
        <CACBZZX5yv-NzL7H-CH1yMeM9dWkz=PUhx=2wek_jBGpsz1=EAA@mail.gmail.com>
        <CACBZZX7M=H8tNkZXpHBvv0rbY58EJk4dkoUzGKMftWoKUqF8sA@mail.gmail.com>
Date:   Mon, 31 Jul 2017 15:28:11 -0700
In-Reply-To: <CACBZZX7M=H8tNkZXpHBvv0rbY58EJk4dkoUzGKMftWoKUqF8sA@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 28 Jul
 2017 18:04:18
        +0200")
Message-ID: <xmqqk22ogs1w.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 89DB7F5E-763F-11E7-815F-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> So the upstream library expects you (and it's documented in their READM=
E) to do:
>
>     #include <sha1dc/sha1.h>
>
> But your patch is just doing:
>
>     #include <sha1.h>
>
> At best this seems like a trivial bug and at worst us encoding some
> Suse-specific packaging convention in git, since other distros would
> presumably want to package this in /usr/include/sha1dc/sha1.h as
> upstream suggests. I.e. using the ambiguous sha1.h name is not
> something upstream's doing by default, it's something you're doing in
> your package.

It seems there still needs a bit more work on this patch.  Thanks
for reviewing and pointing out what needs to be addressed.

