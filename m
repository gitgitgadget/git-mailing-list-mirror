Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1D1C433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 17:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbhKVRi0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 12:38:26 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56872 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbhKVRiY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 12:38:24 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 124AEF39B0;
        Mon, 22 Nov 2021 12:35:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=1jyrD+gXUHTO
        2YtFsPPyEjIXvq3uXS64sjUZI5E60w8=; b=E0tOYckpALQsvZ69jkcAXqxGLeCH
        CHGs2Myo/rTCRtXbYc0db8cLjWPU7LY1AmQFsENEU2ozvWhrn4lb2yKm5uVPiPAY
        ucyNHLIUN1rJ36HNeuR6FVBH1I2xzfpdDd22lbJgFCSD/vu+mWFjPiiCMCWy8U9a
        2WtPgybC5Fuwcjw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 095F3F39AE;
        Mon, 22 Nov 2021 12:35:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 68296F39AC;
        Mon, 22 Nov 2021 12:35:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v3] fetch-pack: parameterize message containing 'ready'
 keyword
References: <20211122123415.464783-1-bagasdotme@gmail.com>
        <211122.86tug4z6ih.gmgdl@evledraar.gmail.com>
Date:   Mon, 22 Nov 2021 09:35:15 -0800
In-Reply-To: <211122.86tug4z6ih.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 22 Nov 2021 14:02:40 +0100")
Message-ID: <xmqqwnl0gkks.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8E43A882-4BBA-11EC-8781-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Mon, Nov 22 2021, Bagas Sanjaya wrote:
>
>> The protocol keyword 'ready' isn't meant for translation. Pass it as
>> parameter instead of spell it in die() message (and potentially confus=
e
>> translators).
>>
>> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
>> ---
>>  Changes since v2 [1]:
>>    - Add missing closing single quote after the parameter (suggested b=
y
>>      Eric)
>>    - Remove stray 'no' at the second message (suggested by =C3=86var)
>>
>>  [1]:
>> https://lore.kernel.org/git/20211118103424.6464-1-bagasdotme@gmail.com=
/T/#u
>>
>>  fetch-pack.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/fetch-pack.c b/fetch-pack.c
>> index a9604f35a3..62d6313708 100644
>> --- a/fetch-pack.c
>> +++ b/fetch-pack.c
>> @@ -1410,9 +1410,13 @@ static int process_ack(struct fetch_negotiator =
*negotiator,
>>  	 * otherwise.
>>  	 */
>>  	if (*received_ready && reader->status !=3D PACKET_READ_DELIM)
>> -		die(_("expected packfile to be sent after 'ready'"));
>> +		/* TRANSLATORS: The parameter will be 'ready', a protocol
>> +		 * keyword */
>> +		die(_("expected packfile to be sent after '%s'"), "ready");
>>  	if (!*received_ready && reader->status !=3D PACKET_READ_FLUSH)
>> -		die(_("expected no other sections to be sent after no 'ready'"));
>> +		/* TRANSLATORS: The parameter will be 'ready', a protocol
>> +		 * keyword */
>> +		die(_("expected no other sections to be sent after '%s'"), "ready")=
;
>> =20
>>  	return 0;
>>  }
>>
>> base-commit: cd3e606211bb1cf8bc57f7d76bab98cc17a150bc
>
> This looks good to me & ready to go. Thanks for sticking with this
> across various nits/small isues for all 3x iterations.
>
> The TRANSLATORS comments being added here don't use our usual style, bu=
t
> I'd be happy just to leave this be & take it as-is without a re-roll,
> don't know about Junio...

I think in ancient time gettext suite required "/* TRANSLATORS:" at
the beginning, which made us deliberately violate our usual
multi-line comment style convention, but it seems that is no longer
the case?  Hits from "git grep -e '[  ]\* TRANSLATORS \*.c" are
fairly common, it seems.

So, yes, it would be better to fix these comments up, to avoid
misleading people into thinking that the old comment-style exception
still applies.

Thanks, both, for working on this.

