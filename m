Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE3EC433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 17:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244317AbiEZRSH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 13:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbiEZRSF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 13:18:05 -0400
Received: from pb-sasl-trial3.pobox.com (pb-sasl-trial3.pobox.com [64.147.108.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7951B175A5
        for <git@vger.kernel.org>; Thu, 26 May 2022 10:18:04 -0700 (PDT)
Received: from pb-sasl-trial3.pobox.com (localhost.local [127.0.0.1])
        by pb-sasl-trial3.pobox.com (Postfix) with ESMTP id 494F434892;
        Thu, 26 May 2022 13:18:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=DdK3bjTVeMqN
        voGJztYyh3MDnk4=; b=inIjKIG3PB+kVt1as5VGHw5+LWqmfP+L6BXAlbSJKcqG
        XConVbQpYG1GzN/f1/lHATduajol8747Izkw/U3QMhRnq7frl8/AYS9l4Lovsqnh
        0B4iUbqXjVmXeBVTDogRLXFyU5moz+UjHNihqxG5JUfZIwV8+R+1nKMySctmvNg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=FJNjju
        On/JlojyeNkkQvBL3fNVgsYOgtxgzPr5fpMkPfeWpPo8YaQAJvFsz03kxV99GvU/
        jEBOWHLL+fedXpOnr2PjSvmvu7JPLY2EaVvm0zWJ8S/b78dDYgq0Pklg553JONvw
        sfQP4ek2OsfE1T0h+qswG4/cDAAhatEOWsG5E=
Received: from pb-smtp1.nyi.icgroup.com (pb-smtp1.pobox.com [10.90.30.53])
        by pb-sasl-trial3.pobox.com (Postfix) with ESMTP id 22A5C34891;
        Thu, 26 May 2022 13:18:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4E12B12516F;
        Thu, 26 May 2022 13:18:02 -0400 (EDT)
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
Date:   Thu, 26 May 2022 10:18:00 -0700
In-Reply-To: <220526.86tu9c625s.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 26 May 2022 12:00:04 +0200")
Message-ID: <xmqq8rqo1ad3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CC50F7EE-DD17-11EC-9E71-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I pointed out then that with --sort-by-file added we:
>
>  * Don't group the translations by C/SH/Perl anymore
>  * Change the sort order within files, to be line/sorted instead of
>    line/order (i.e. first occurring translations first)
>
> I suggested then to just use $(sort) on the respective lists.
>
> So why not just:
>
>  1. Switch to the $(FOUND_C_SOURCES) (good)
>  2. Filter that by C/Perl/SH as before (just a simple $(filter)
>  3. $(sort) that (which as noted, also de-dupes it)
>
> Then we don't have any of the behavior change of --sort-by-file, and we
> don't have to carefully curate the ls-files/find commands to not includ=
e
> duplicates (although as seen here that seems to have been a useful
> canary in the "find" case).

Does "--sort-by-file" really mean that?

The option is documented to sort output by file location, but does
it mean without the option (i.e. default), there is no guarantee in
the output order?  Or are we sure that the output is sorted by the
order of input files, and that is guaranteed to hold in the future?

If we are depending on certain ordering of the output produced by
gettext suite of programs, I would keep the option, regardless of
what we do to the input to them, if I were running the i18n part of
this project.

But I am not, so I would not complain if --sort-by-file is dropped
against my advice ;-)

