Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDEDC433F5
	for <git@archiver.kernel.org>; Thu, 26 May 2022 18:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241892AbiEZS3R (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 14:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346111AbiEZS3O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 14:29:14 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02FA4BFDA
        for <git@vger.kernel.org>; Thu, 26 May 2022 11:29:13 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id o28so2811875edi.1
        for <git@vger.kernel.org>; Thu, 26 May 2022 11:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=4iKxqgXkpDPyr02mVWUnPWqFeqh9Q3h/Z9r0iQd/waI=;
        b=oTLtuIqcQXH9lTofjxztHRF5IZ7SvEqbEbbHQlUmwgkaOm6zUrD5QtGjWuFZm80hgN
         0HS5d+fyVAsb4ebqyEPnwJSOKrXbBpe8CXDdda/nhwGUKhdk4lIA/Yc0Q7hRE33skSZ6
         4Qts7QuY+aqaE5VLU0x+NJyFKwBJm2lqDlnNjICf1BAgfC1bYzE6gjR0j2B8m4aUahTv
         GXtuRf6vR5/YNKzgzcQ5c7urwpxnsA55HHqrNGn2nKMZ8r9xBkXZr3pKThc8p3RznAXg
         Q2JoQ+ayfySkl98kABn1EgibzpaVWfgZRCf7DjeWLWAsJfP5reCekPNjHxw2VWcZMITO
         KvAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=4iKxqgXkpDPyr02mVWUnPWqFeqh9Q3h/Z9r0iQd/waI=;
        b=adCF8p9oSOmVbxJWusGKoihIPCW26Nx02KPR06CVM4c99+qaVLWO8yyTtSf952IxeS
         wD6l1WM4NHXp1pDySUK+pMtoBdhOyXpNS4PTPbSBtcSGnSAz0x17q2vQ1gzSnh3/KZgj
         LpS1LK0OAkiwt/m3G52ZhM0IB3ZmcyRerUdXjmKH4mNELCYYflZAH8/ZfX7Uqu6BV8qR
         OqXlx55yLnoveX2jtziocHRh9SeBsk7ymdG76qFav1diOmLKFGTbIVS6XNtgDH3+vH8t
         BUyJgNy/ixMaBJEuDhwBPm/rGI8pghfidqForLpLeG3NPjv2AMLzEOLthOyFDXsNQ3kS
         oIBw==
X-Gm-Message-State: AOAM533DwbeqHswpSwaFg72IrYyOw5n9O+lQLxAFH0ZLLndrwDL3vPpo
        zh2pdRHdnXnBN1NBCX5tciw=
X-Google-Smtp-Source: ABdhPJzBpNnxZxqBc58KyZiZOLQ0AXZunEWdq+q4LXQ5phXdUmiRJ6X3L8GZTgsNM7n2lOQGt7GwpA==
X-Received: by 2002:a05:6402:1d4a:b0:42b:73bc:28d7 with SMTP id dz10-20020a0564021d4a00b0042b73bc28d7mr20414395edb.78.1653589752042;
        Thu, 26 May 2022 11:29:12 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id ga11-20020a170906b84b00b006fec56a80a8sm704401ejb.115.2022.05.26.11.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 11:29:11 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nuIEQ-000EzM-IY;
        Thu, 26 May 2022 20:29:10 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
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
Date:   Thu, 26 May 2022 20:25:57 +0200
References: <xmqqtu9d45f7.fsf@gitster.g>
 <20220526021540.2812-1-worldhello.net@gmail.com>
 <xmqqo7zl2b66.fsf@gitster.g>
 <CANYiYbEcNJ7+7XW-8-v+p8q=aiOP9RJYvST8ethVjxVdNugR5Q@mail.gmail.com>
 <xmqq5yls3j8i.fsf@gitster.g>
 <CANYiYbGn08N_9bOw+ss6L4U_iTomc-08_961bk40eq1BnEstiw@mail.gmail.com>
 <220526.86tu9c625s.gmgdl@evledraar.gmail.com> <xmqq8rqo1ad3.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqq8rqo1ad3.fsf@gitster.g>
Message-ID: <220526.86czg05ert.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 26 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> I pointed out then that with --sort-by-file added we:
>>
>>  * Don't group the translations by C/SH/Perl anymore
>>  * Change the sort order within files, to be line/sorted instead of
>>    line/order (i.e. first occurring translations first)
>>
>> I suggested then to just use $(sort) on the respective lists.
>>
>> So why not just:
>>
>>  1. Switch to the $(FOUND_C_SOURCES) (good)
>>  2. Filter that by C/Perl/SH as before (just a simple $(filter)
>>  3. $(sort) that (which as noted, also de-dupes it)
>>
>> Then we don't have any of the behavior change of --sort-by-file, and we
>> don't have to carefully curate the ls-files/find commands to not include
>> duplicates (although as seen here that seems to have been a useful
>> canary in the "find" case).
>
> Does "--sort-by-file" really mean that?
>
> The option is documented to sort output by file location, but does
> it mean without the option (i.e. default), there is no guarantee in
> the output order?  Or are we sure that the output is sorted by the
> order of input files, and that is guaranteed to hold in the future?
>
> If we are depending on certain ordering of the output produced by
> gettext suite of programs, I would keep the option, regardless of
> what we do to the input to them, if I were running the i18n part of
> this project.
>
> But I am not, so I would not complain if --sort-by-file is dropped
> against my advice ;-)

The gettext docs are pretty light on the subject, but the default "sort
order" is none at all. I.e. it'll just inhale source and spew out
translations in the order you feed them to xgettext.

So in order of input files, and then in order they're seen in the
program.

I don't think that's ever going to change.

The --sort-output and and --sort-by-file then re-sort that.

AFAICT the --sort-by-file could be more accurately named
--sort-by-file-then-line-number-then-by-msgid.

I.e. the semantics seem to be to sort by file, then emit messages in the
order they appear in the file *by line*, but within a line act as though
--sort-output was given. I don't know if that's intentional or not.

