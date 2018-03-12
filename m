Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D73361F404
	for <e@80x24.org>; Mon, 12 Mar 2018 18:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751320AbeCLS4I (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Mar 2018 14:56:08 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:33031 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751284AbeCLS4H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Mar 2018 14:56:07 -0400
Received: by mail-wm0-f45.google.com with SMTP id s206so14766376wme.0
        for <git@vger.kernel.org>; Mon, 12 Mar 2018 11:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=pqSP8D146Hm5RXRYGwFgf7PXGHABO25X4nr/brXViZQ=;
        b=AOaZ42LGlBALQWgGDiDWCmd7yDFK08SeY8vPMmVNSlZjmgJLUpmSdtA9yhCA0p/Q7/
         hkf2zv7cBGVKuey/fcgxNWn3OQTVodvVkYDaq9q8F6EVq+IekTYZSKwDT2Wk3eq+w8Vv
         A8YpJLPPwqt1oHK8qbyA1qtyYAuyPO16+osLgYKrsrBvwVDgUYNn5zhmgl1eWhqWzt5t
         KM3iCntoWBwwivuLVfB4HwmA9KTdKwpSa9usPIBj3YJQn+jAkdNQNJ555yiHErlfeLdT
         FuWNQrd/TtEmYsbis1XcQNlOsglBKdBk/A4ZANx08PiLzLSOjGskG2l6EsQqOtPjLN4k
         3Jqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=pqSP8D146Hm5RXRYGwFgf7PXGHABO25X4nr/brXViZQ=;
        b=adz2hIpsSUcOh0c81xV5qgitmbdA/rO+/G19hFh2jRSU2OVnUd2WMnqz8PXjpPZ1l2
         01tHj99i7YNbqDTx/8ETT7aeb3Q5cH89eePgwlsQ19/oMEdcOGfIx0N5RIq1HXKLFbis
         Eu8JUvrUrnKZ2N3hppCza5VLKv+Btysm4aYdmuAX7rkXIdr7ONhuuld7hYwBTyEbwF/l
         3PrjpfISQmkgWBphMnMQl5Tg1R1fy9wHBWB9hOrLYMZLhJcDBK4kQ8hXoqz7hxtTEd+F
         DcnfbfZfIMzNEM+qPCj+s9n2SNwvdnxvyCMgAivu2C8dJBQRmBwzZ8zv96NsvAQ6J0bH
         eWYg==
X-Gm-Message-State: AElRT7Gkv2PgqVzhHZ3euOAi0SbumDN//rwM+YP+PlJc9G49XqFbcZjp
        9jJM6MHR/M3wGiw+tMDH5sI=
X-Google-Smtp-Source: AG47ELuUye1P7bDSkcKXaxQfHwH5LanhZocDV5zpTvdCoasn+OYb2U7diZkuhX19SurBckNFOgjK4A==
X-Received: by 10.28.4.20 with SMTP id 20mr6956882wme.100.1520880966632;
        Mon, 12 Mar 2018 11:56:06 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id w134sm6181703wmd.45.2018.03.12.11.56.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Mar 2018 11:56:05 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, Eric Wong <e@80x24.org>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/5] gc --auto: exclude base pack if not enough mem to "repack -ad"
References: <20180301092046.2769-1-pclouds@gmail.com> <20180306104158.6541-1-pclouds@gmail.com> <20180306104158.6541-4-pclouds@gmail.com> <xmqqfu5d3tbn.fsf@gitster-ct.c.googlers.com> <CACsJy8C2j2dLozhHf4zE--KYPZ2VjOW2tobmczh3rf6L==Q1vw@mail.gmail.com> <xmqqd10f20k6.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <xmqqd10f20k6.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 12 Mar 2018 19:56:04 +0100
Message-ID: <87bmftqg1n.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 07 2018, Junio C. Hamano jotted:

> Duy Nguyen <pclouds@gmail.com> writes:
>>> But to those who say "packs larger than this value is too big" via
>>> configuration, keeping only the largest of these above-threshold
>>> packs would look counter-intuitive, wouldn't it, I wonder?
>>
>> I think I'll just clarify this in the document. There may be a use
>> case for keeping multiple large packs, but I don't see it (*). We can
>> deal with it when it comes.
>
> When the project's history grows too much, a large pack that holds
> its first 10 years of stuff, together with another one that holds
> its second 20 years of stuff, may both be larger than the threshold
> and want to be kept.  If we pick only the largest one, we would
> explode the other one and repack together with loose objects.
>
> But realistically, those who would want to control the way in which
> their repository is packed to such a degree are very likely to add
> ".keep" files to these two packfiles themselves, so the above would
> probably not a concern.  Perhaps we shouldn't do the "automatically
> pick the largest one and exclude from repacking" when there is a
> packfile that is marked with ".keep"?

As someone who expects to use this (although hopefully in slightly
modified form), it's very useful if we can keep the useful semantics in
gc.* config values without needing some external job finding repos and
creating *.keep files to get custom behavior.

E.g. I have the use-case of wanting to set this on servers that I know
are going to be used for cloning some big repos in user's ~ directory
manually, so if I can set something sensible in /etc/gitconfig that's
great, but it sucks a lot more to need to write some cronjob that goes
hunting for repos in those ~ directories and tweaks *.keep files.
