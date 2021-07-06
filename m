Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B4DC07E9B
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 20:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E66261C30
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 20:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhGFUNu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 16:13:50 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59883 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbhGFUNt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 16:13:49 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C103614920E;
        Tue,  6 Jul 2021 16:11:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=mUlXjhZrEIQe
        ua33/SctC1MDBe2NUq0e46eb0m4UYcc=; b=YPqZ81cPZOw+SfDmHW3UM8grNSLh
        4X4tUH7T9gZ8jsxCnxI12bbkPlh3a3zXyFTBlisCsom42SboBfKHJImxw43sjY+B
        ueo5++QrqkgClhOIra1F/HTtjcv0PoE6Klq43w9/zkcjcnOvk3XjrDdqfUiAXfxE
        /Y0rwaDxWVu+ZFg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B9E7714920D;
        Tue,  6 Jul 2021 16:11:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 29C171491F6;
        Tue,  6 Jul 2021 16:11:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Andrei Rybak <rybak.a.v@gmail.com>, git@vger.kernel.org,
        Christian Couder <christian.couder@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH resend] help: convert git_cmd to page in one place
References: <20210626163219.4137317-1-rybak.a.v@gmail.com>
        <20210704153912.2742106-1-rybak.a.v@gmail.com>
        <87tul9706u.fsf@evledraar.gmail.com>
Date:   Tue, 06 Jul 2021 13:11:05 -0700
In-Reply-To: <87tul9706u.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 05 Jul 2021 08:15:25 +0200")
Message-ID: <xmqqfswri4o6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4C528060-DE96-11EB-99AE-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> @@ -606,16 +604,17 @@ int cmd_help(int argc, const char **argv, const =
char *prefix)
>> =20
>>  	argv[0] =3D check_git_cmd(argv[0]);
>> =20
>> +	page =3D cmd_to_page(argv[0]);
>
> Nit not requring a re-roll: I'd snuggle this with the argv[0], not the
> switch statement, i.e. like the existing code.

Makes sense.

>>  	switch (help_format) {
>>  	case HELP_FORMAT_NONE:
>>  	case HELP_FORMAT_MAN:
>> -		show_man_page(argv[0]);
>> +		show_man_page(page);
>>  		break;
>>  	case HELP_FORMAT_INFO:
>> -		show_info_page(argv[0]);
>> +		show_info_page(page);
>>  		break;
>>  	case HELP_FORMAT_WEB:
>> -		show_html_page(argv[0]);
>> +		show_html_page(page);
>>  		break;
>>  	}
>
> More generally (not the fault of this patch) the control flow in that
> file is quite a mess. I wondered why we can't just add this to
> check_git_cmd() then, it's also only called in that one place.
>
> We can, but it and cmd_to_page() return in multiple places, and
> help_unknown_cmd() might return, might exit(1) itself etc, so fixing
> similar to my 338abb0f045 (builtins + test helpers: use return instead
> of exit() in cmd_*, 2021-06-08) should probably be part of some general
> refactoring... :)

True, too.
