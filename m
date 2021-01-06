Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52359C433DB
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 08:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 136BC23106
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 08:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbhAFIbP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 03:31:15 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56416 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbhAFIbO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 03:31:14 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9B3EC110E9B;
        Wed,  6 Jan 2021 03:30:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=umB96yH7jxgJreRq3D/H+C4NPsQ=; b=F0PhwSpDdXT6DzI0CpL1
        lhU2PYVIug3HfWQ1ELtb1V/jovlWAs8PftvJCUSrNKh5fwmXn3G55/xNbFr9cbCm
        ojcgCLdjfgutT/TGY62c5Y+QfpOyNm7xIvnxSrG8ED87kjmtCtDhQv3pNbkxz0FF
        +y2yNzFJUhbL6q0GaCzW7jw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=opmSra2x9zrM0lGTIBuB2z6ClPB+qsSFk7Njlu40jwN8zk
        vOAxE3HDjrIICCTavvEQkhs3vpw3XwU67a9fAUsEN3bgE13rtyCE1ZXJQmxaB9+Y
        unmUxdHlVQA7+cD9Any4denecyKhjWqjTPsIKbvwCutC9ZsXGB4bJr2CjYTu4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 861A7110E9A;
        Wed,  6 Jan 2021 03:30:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BCE3D110E99;
        Wed,  6 Jan 2021 03:30:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 1/3] completion: bash: add __git_have_func helper
References: <20201229170837.297857-1-felipe.contreras@gmail.com>
        <20201229170837.297857-2-felipe.contreras@gmail.com>
        <1402dabd-089d-616a-ef79-ff1ae3fcb438@web.de>
        <5fecbb6b2f9a_871cb208f6@natae.notmuch>
X-Gnus-Delayed: Wed, 06 Jan 2021 00:58:27 -0800
Date:   Wed, 06 Jan 2021 00:30:28 -0800
Message-ID: <xmqqh7nusc0r.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6F50A244-4FF9-11EB-8D7C-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> Anyway, this seems to work for me:
>> 
>> 	__git_have_func () {
>> 		case "$1" in
>> 		-*) return 1 ;;
>> 		esac
>> 		declare -F "$1" >/dev/null 2>&1
>> 	}
>
> I wondered some of those things too, but opted for the minimal approach.
>
> Your change seems good to me, however I prefer this to the case
> statement:
>
>   [[ "$1" == -* ]] && return 1
>
> But doesn't seem to be too welcomed in git's bash style.

Actually, there is no formal "bash style" guide for our codebase.
In bash completion script, you are free to use any bashisms as you
find convenient, as long as it is consistent with the surrounding
code.

As SZEDER and you later agree in the downthread, Zsh compatibility
would be a lot more important than sticking to general POSIX shell
subset (and following our shell style guide for the rest of the
system that tries hard to be independent from bashism) when
improving this script.

> Looks like this would be prefered:
>
>   if [[ "$1" == -* ]]; then
>     return 1
>   fi

This is another example that we do not apply the shell style guide
in Documentation/CodingGuidelines to this script (if we did, we
wouldn't see the semicolon there).

Thanks.
