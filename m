Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CE261F461
	for <e@80x24.org>; Thu, 27 Jun 2019 19:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfF0THD (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 15:07:03 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52453 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfF0THD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 15:07:03 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B4A1D7BC6E;
        Thu, 27 Jun 2019 15:07:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=v/H7O6soIaYMtn/K9PjKKaH8tbU=; b=W/IQcT
        ootTKDT7xFAgHO2cU6ttmcw0P44USKOGLwzanQVtA2VOU7ZHuoLXykuOxi2T9RKD
        eHRuQ/6mZ7sn7mnexXzcO6Ad+310w3rO2OyNIFfDc+Wo9bWFoC1UUFoT/zRRWkEe
        DcA1RoJCpVR5bVVyWtvKk+0yQroQJmSOaAhu4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PZKXV7mDFGi3Ww5t1m9ElVXbNteH6fOi
        a6THMsRTfZVwaaC3ax4F5nbFf4hpHdELZtHSvshKuu8AkQRiaiN+sO9CeacFxNua
        MBUWXEVHI3c42RtHVRRuhD+0uKcSM3HSsklU16wvfOwZ9dACojPPFLlWdnf8t3Hj
        Tgb5qI1wwu8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ACC937BC6C;
        Thu, 27 Jun 2019 15:07:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D4FCB7BC6A;
        Thu, 27 Jun 2019 15:06:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, git-packagers@googlegroups.com,
        gitgitgadget@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net, szeder.dev@gmail.com
Subject: Re: [RFC/PATCH 7/7] grep: use PCRE v2 for optimized fixed-string search
References: <87r27u8pie.fsf@evledraar.gmail.com>
        <20190626000329.32475-8-avarab@gmail.com>
        <nycvar.QRO.7.76.6.1906261610310.44@tvgsbejvaqbjf.bet>
        <xmqqo92kchjm.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1906271129370.44@tvgsbejvaqbjf.bet>
        <nycvar.QRO.7.76.6.1906272042350.44@tvgsbejvaqbjf.bet>
Date:   Thu, 27 Jun 2019 12:06:57 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1906272042350.44@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 27 Jun 2019 20:45:47 +0200 (CEST)")
Message-ID: <xmqqv9wqalv2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BD78334A-990E-11E9-82A6-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > > If we would not have plenty of exercise for the PCRE2 build options, I
>> > > would be worried. But AFAICT the CI build includes this all the time, so
>> > > we're fine.
>> >
>> > Well, I'd feel safer if it were not "all the time", i.e. we know we
>> > are testing both sides of the coin.
>>
>> AFAIR at least the Linux32 job is built without PCRE2 by default. I might
>> be wrong on that, though...
>
> Actually, it seems that _all_ of the Linux builds in our Azure Pipeline
> compile without pcre2. It seems you have to pass `USE_LIBPCRE2=1` to
> `make`, and we do not do that in `ci/run-build-and-tests.sh` nor in
> `azure-pipelines.yml`. I do not even see that for the macOS builds.
>
> So we got PCRE2 covered only in the Windows build, it seems.

OK, it sounds like we have sufficient coverage on both fronts.
Good.
