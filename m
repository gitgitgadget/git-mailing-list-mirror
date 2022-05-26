Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E298C433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 06:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244685AbiEZGXe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 02:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbiEZGXc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 02:23:32 -0400
Received: from pb-sasl-trial3.pobox.com (pb-sasl-trial3.pobox.com [64.147.108.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D099CC99
        for <git@vger.kernel.org>; Wed, 25 May 2022 23:23:31 -0700 (PDT)
Received: from pb-sasl-trial3.pobox.com (localhost.local [127.0.0.1])
        by pb-sasl-trial3.pobox.com (Postfix) with ESMTP id C7771327AD;
        Thu, 26 May 2022 02:23:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fJO38hKbedat79yk/vr+4EexOgA=; b=eNU0GT
        3ZzUc2vN/RWBIWIn4fvY+0NYDlG9YrZhBtM3BADn11AA/mjTI0dQxRbYnnJB/z9H
        gusTJqwAIEUImTSWJnjsHp4Y0eoFo1cPEiNHzyrvfn7TAW30P6chG4fIUOpDT+qa
        ylp9x3vVobUeXiOo/XFmnYSdKVdsKLxKJeOYM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eycrZ4MsZogUq68012OcERRMewGIh1mK
        BtqQKewoQMZF7mlx886HNhH/AW9tUI3dNAHJY536YveYdr8xOAQfoRbz11RMoMO9
        EYvOgtZHvsTbjFugppx+JRZGF89QWrFu2yQGAE8QWhwP2AFfXRkqv44ibDEe+TNF
        DnvmwNaifEE=
Received: from pb-smtp1.nyi.icgroup.com (pb-smtp1.pobox.com [10.90.30.53])
        by pb-sasl-trial3.pobox.com (Postfix) with ESMTP id A7686327AC;
        Thu, 26 May 2022 02:23:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DDBEA121019;
        Thu, 26 May 2022 02:23:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
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
Date:   Wed, 25 May 2022 23:23:25 -0700
In-Reply-To: <CANYiYbEcNJ7+7XW-8-v+p8q=aiOP9RJYvST8ethVjxVdNugR5Q@mail.gmail.com>
        (Jiang Xin's message of "Thu, 26 May 2022 14:06:54 +0800")
Message-ID: <xmqq5yls3j8i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5A58102E-DCBC-11EC-B17A-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

>>         )
>> -FOUND_SOURCE_FILES := $(shell $(SOURCES_CMD))
>> +FOUND_SOURCE_FILES := $(sort $(shell $(SOURCES_CMD)))
>>
>>  FOUND_C_SOURCES = $(filter %.c,$(FOUND_SOURCE_FILES))
>>  FOUND_H_SOURCES = $(filter %.h,$(FOUND_SOURCE_FILES))
>>
>
> If I disabled the git-ls-files command like below,
>
>     @@ -846,7 +846,7 @@ generated-hdrs: $(GENERATED_H)
>...
> This is because the three generated header files (defined in
> $(GENERATED_H)) are also included in the result of "SOURCES_CMD". We
> can fix this by sorting LOCALIZED_C:
>
>     -LOCALIZED_C = $(FOUND_C_SOURCES) $(FOUND_H_SOURCES) $(SCALAR_SOURCES) \
>     -             $(GENERATED_H)
>     +LOCALIZED_C = $(sort $(FOUND_C_SOURCES) $(FOUND_H_SOURCES)
> $(SCALAR_SOURCES) \
>     +               $(GENERATED_H))

If you make FOUND_SOURCE_FILES unique upfront, the at least there
wouldn't be any duplicates there.  Do you mean that some of what is
in FOUND_SOURCE_FILES appear in either SCALAR_SOURCES or GENERATED_H?

If not, I think deduplicating near the source of the issue, i.e.

  FOUND_SOURCE_FILES := $(sort $(shell $(SOURCES_CMD)))

may be sufficient.  Deduplicating near the consumer, like
LOCALIZED_C, may force us to dedup all the consumers of it (e.g.
LOCALIZED_C is not the sole consumer of FOUND_C_SOURCES; you'd need
to sort the input to COCCI_SOURCES, for example).

Thanks.
