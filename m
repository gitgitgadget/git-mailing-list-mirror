Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1661C433F5
	for <git@archiver.kernel.org>; Thu, 26 May 2022 19:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348393AbiEZTAh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 15:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbiEZTAh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 15:00:37 -0400
Received: from pb-sasl-trial20.pobox.com (pb-sasl-trial20.pobox.com [173.228.157.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E206CFE24
        for <git@vger.kernel.org>; Thu, 26 May 2022 12:00:35 -0700 (PDT)
Received: from pb-sasl-trial20.pobox.com (localhost.local [127.0.0.1])
        by pb-sasl-trial20.pobox.com (Postfix) with ESMTP id B12BB320E0;
        Thu, 26 May 2022 15:00:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=YtZafFMt7ESd
        9AFhVmYyUW9bPhY=; b=ac89Whh79UGPQtzoLo+Bx6x7OwRvTXTwB42/uB6v0QvR
        khysQRBnDAu0hh3XG+PrEYXw90v2P1jda5pemSKfjT5OKZfJWSfFN+b0tEGavOYL
        sr3W+cvHDeDfqJXCubQoen7FY1Pb0ytxL0s+Yd6WszjqrdzQO08pGmDQRmC/ZVE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=lPxZn5
        wsRfeUPEeUnYGpSyTiDaSK2jz5DelA1GipmAYJFtvCnmABk0Uq6Qi61ACFPEE1Fd
        hLGqCXcmljftQfV46UYkY2wBdHeZZt9FMEQrGVXBQP3MKfCm0JwdPBu6j6AXQMq+
        VfX82weqIUmm/1lW18+i/0/ANyKmF7DYujjZU=
Received: from pb-smtp20.sea.icgroup.com (pb-smtp20.pobox.com [10.110.30.20])
        by pb-sasl-trial20.pobox.com (Postfix) with ESMTP id 95518320DD;
        Thu, 26 May 2022 15:00:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2A458192E5B;
        Thu, 26 May 2022 15:00:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Matthias =?utf-8?Q?R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        Christopher =?utf-8?Q?D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <dacs.git@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Fangyi Zhou <me@fangyi.io>, Yi-Jyun Pan <pan93412@gmail.com>
Subject: Re: [PATCH] Makefile: dedup git-ls-files output to prevent
 duplicate targets
References: <xmqqtu9d45f7.fsf@gitster.g>
        <20220526021540.2812-1-worldhello.net@gmail.com>
        <xmqqo7zl2b66.fsf@gitster.g>
        <CANYiYbEcNJ7+7XW-8-v+p8q=aiOP9RJYvST8ethVjxVdNugR5Q@mail.gmail.com>
        <xmqq5yls3j8i.fsf@gitster.g>
        <CANYiYbGn08N_9bOw+ss6L4U_iTomc-08_961bk40eq1BnEstiw@mail.gmail.com>
        <220526.86tu9c625s.gmgdl@evledraar.gmail.com>
        <xmqq8rqo1ad3.fsf@gitster.g>
        <220526.86czg05ert.gmgdl@evledraar.gmail.com>
Date:   Thu, 26 May 2022 12:00:29 -0700
In-Reply-To: <220526.86czg05ert.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 26 May 2022 20:25:57 +0200")
Message-ID: <xmqqh75cyv8y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1CB7E1A8-DD26-11EC-BE2D-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> Does "--sort-by-file" really mean that?
>>
>> The option is documented to sort output by file location, but does
>> it mean without the option (i.e. default), there is no guarantee in
>> the output order?  Or are we sure that the output is sorted by the
>> order of input files, and that is guaranteed to hold in the future?
>>
>> If we are depending on certain ordering of the output produced by
>> gettext suite of programs, I would keep the option, regardless of
>> what we do to the input to them, if I were running the i18n part of
>> this project.
>>
>> But I am not, so I would not complain if --sort-by-file is dropped
>> against my advice ;-)
>
> The gettext docs are pretty light on the subject, but the default "sort
> order" is none at all. I.e. it'll just inhale source and spew out
> translations in the order you feed them to xgettext.
>
> So in order of input files, and then in order they're seen in the
> program.
>
> I don't think that's ever going to change.

OK, so as long as make's notion of $(sort) and gettext suite's
notion of --sort-by-file are the same, we didn't make any change,
and even if they were different, since there is no version of Git
that uses "--sort-by-file" while preparing the po and pot files, it
still is OK.  As long as make's $(sort) is as stable as gettext
suite's "--sort-by-file" across developer locales (and our filenames
are ascii-only and hopefully will stay that way), everybody will get
the messages in the same order either way (or we would have the same
problem so switching from --sort-by-file to $(sort) is not making
anything worse).


