Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07ED7C43464
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 10:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9280420758
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 10:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHdIhEBt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgIUKPx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 06:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgIUKPx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 06:15:53 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0217C061755
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 03:15:52 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id l17so12143670edq.12
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 03:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=xwAHoGr45qL0a9Qa9Tg8y5lZOJn+7lGB5ZMRJLKrrqQ=;
        b=dHdIhEBtNoMBaMe8RKG3233eUq0GmCoM13gAoJxnnWbn+29rhhjjxa4CAgOYOHI/xM
         TC2GDxdlk2ViSGN3ahXVU8sOjgrkcm2uzOSVUgV3GLUvZEMP6nro5nYbsAK9qY24PlRS
         Jtl1/B2QOHedAh6fYvFrbWT96hZF5LLIAbeGhe+Cr3PiUFkTHOL4ZFmezhoqsCL605fy
         EnCIztjBZvzplMRTfW4gTlrT61nlFG0oyezKBC+JS+jCJO5+4oXWgbvgu4MiKTec/FEb
         7PfPoIQYOZEU7RAJCmu62CZvhYfiuXs/Taip3h14th3/oMqjO2P7dT9AmHka1FReU3Na
         04Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=xwAHoGr45qL0a9Qa9Tg8y5lZOJn+7lGB5ZMRJLKrrqQ=;
        b=g24KGpTeH2OtMML46gHZ7kCJb0cXH5RdQVTZgpek16TDf/3Q3gWW3b0sQhN4lQisCc
         afu6N2/9UuaQoxUIEeDw1qjPAFHfZ4i2BAXk3DhJFl++dRpzPhnoh9qrkBxX48yNZcDr
         y4kLN3coX62Yj5psfHAe7Px1RI2lClaA9eTY0j6HGBAE+YpsJVZBsU28IjJtfQTWzy9q
         Jk3H7PUTBWbuvLG6MxZJ4+KRgHjISfMA/mOeh79y0A3ygLtsaSOa8QYWkmLZ9o3Lf+ed
         j8bMxJF+R+21rVJfRgsiQbZTwjRBizJbdvPPaTjnfisSMFGTtcKeecw+7LYrWGTdnW/2
         UHdA==
X-Gm-Message-State: AOAM532T6UxAm5mqYfJd6sHs6DrjsEnRzqtNbRpIaKSKk3pOoiktEqcC
        oBycjhnpyePGZMigC8teij8=
X-Google-Smtp-Source: ABdhPJwctMh+kdoA56ELvhyEuvu1A2emiCVY0263UT6Z2n5XEAMVBMOgq5GrSTHWMStizQ/CzFxmGA==
X-Received: by 2002:a05:6402:3076:: with SMTP id bs22mr28660764edb.17.1600683351401;
        Mon, 21 Sep 2020 03:15:51 -0700 (PDT)
Received: from evledraar (dhcp-077-248-252-018.chello.nl. [77.248.252.18])
        by smtp.gmail.com with ESMTPSA id o15sm8563556ejr.1.2020.09.21.03.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 03:15:50 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Antoine =?utf-8?Q?Beaupr=C3=A9?= <anarcat@debian.org>,
        Simon Legner <Simon.Legner@gmail.com>
Subject: Re: [PATCH 00/15] remote-mediawiki: various fixes to make tests pass
References: <20200916102918.29805-1-avarab@gmail.com> <nycvar.QRO.7.76.6.2009162144390.56@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <nycvar.QRO.7.76.6.2009162144390.56@tvgsbejvaqbjf.bet>
Date:   Mon, 21 Sep 2020 12:15:49 +0200
Message-ID: <87lfh3igfe.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 16 2020, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> On Wed, 16 Sep 2020, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> I had occasion to look at remote-mediawiki and I couldn't even get the
>> test suite to run. The patches below have more detail but there's
>> issues like a hard error on any Perl release newer than ones released
>> in 2013, and the MediaWiki release it tries to use spewing errors on
>> any modern PHP version.
>>
>> This series fixes these issues. With it applied it's possible to run
>> the tests, and they all pass.
>
> I glimpsed through the patches, and they all look in pretty good shape. I
> just wish that the TODO in Simon's patch had been resolved, and that the
> test failures had been root-caused, but then, I personally do not really
> care all that much about the `remote-mediawiki` backend any longer, so I
> am fine with the patches as-are (modulo Danh's/Eric's nit about the
> extra tests before `test_cmp`).

I didn't look into it much, but isn't it just some general "feature" of
the remote protocol that it might tell you about a refname twice, and
you have to de-duplicate them? I searched a bit for whether that was
documented or not, didn't find it, and moved on.

>>
>> Simon Legner (1):
>>   remote-mediawiki: fix duplicate revisions being imported
>>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (14):
>>   remote-mediawiki doc: correct link to GitHub project
>>   remote-mediawiki doc: link to MediaWiki's current version
>>   remote-mediawiki doc: bump recommended PHP version to 7.3
>>   remote-mediawiki tests: use the login/password variables
>>   remote-mediawiki tests: use a 10 character password
>>   remote-mediawiki tests: use test_cmp in tests
>>   remote-mediawiki tests: guard test_cmp with test_path_is_file
>>   remote-mediawiki tests: change `[]` to `test`
>>   remote-mediawiki tests: use "$dir/" instead of "$dir."
>>   remote-mediawiki tests: use a more idiomatic dispatch table
>>   remote-mediawiki tests: replace deprecated Perl construct
>>   remote-mediawiki tests: use inline PerlIO for readability
>>   remote-mediawiki tests: use CLI installer
>>   remote-mediawiki tests: annotate failing tests
>>
>>  contrib/mw-to-git/git-mw.perl                 |   2 +-
>>  contrib/mw-to-git/git-remote-mediawiki.perl   |   5 +-
>>  contrib/mw-to-git/git-remote-mediawiki.txt    |   2 +-
>>  contrib/mw-to-git/t/.gitignore                |   2 +-
>>  contrib/mw-to-git/t/README                    |  10 +-
>>  contrib/mw-to-git/t/install-wiki/.gitignore   |   1 -
>>  .../t/install-wiki/LocalSettings.php          | 129 --------------
>>  .../mw-to-git/t/install-wiki/db_install.php   | 120 -------------
>>  contrib/mw-to-git/t/t9360-mw-to-git-clone.sh  |   8 +-
>>  .../t/t9363-mw-to-git-export-import.sh        |  15 +-
>>  contrib/mw-to-git/t/test-gitmw-lib.sh         | 159 +++++++++---------
>>  contrib/mw-to-git/t/test-gitmw.pl             |  22 ++-
>>  contrib/mw-to-git/t/test.config               |  23 +--
>>  13 files changed, 129 insertions(+), 369 deletions(-)
>>  delete mode 100644 contrib/mw-to-git/t/install-wiki/.gitignore
>>  delete mode 100644 contrib/mw-to-git/t/install-wiki/LocalSettings.php
>>  delete mode 100644 contrib/mw-to-git/t/install-wiki/db_install.php
>>
>> --
>> 2.28.0.297.g1956fa8f8d
>>
>>

