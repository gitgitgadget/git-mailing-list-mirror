Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6063AC433E0
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 16:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14CA564E74
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 16:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbhB1QI1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Feb 2021 11:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbhB1QI0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Feb 2021 11:08:26 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F4EC06174A
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 08:07:45 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id l12so17396318edt.3
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 08:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=jrIA/ufIbZmod1IFeSPKiR3h+ISHgaDKYHb+cMeZL7A=;
        b=iENdodgY6RO/0nV3IDzPqbU5gUt/D/UY1QCtVvFwYmpuE8LoVVzRrRsbdWVK0JkFW4
         N6ZL8ft8TEbeOEoFFXwqUNxm/AsdW4FDgB+DjxRxnshiIYyX+hSdJhujiwIxPs3qtEZu
         ErUl6L62413LVEBbrB23qSNXaUwrgqv2F2QE9WmOhTV/D24IsGf3OJ2oUtDrM8AHw0C/
         +QTwB4521jAW7NBwX0GZ8TV0uA88+2cEt88RWKeuI57IHqWOg+t8S0TH87QQquBNBois
         cMYto9anN+FyolK4i6rpeHk5YAti4ZHb7PU0UVpcFt/R5hQMseJ/WI6rLPsngSgu//BO
         PRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=jrIA/ufIbZmod1IFeSPKiR3h+ISHgaDKYHb+cMeZL7A=;
        b=mlKhNrX87l4UV9090nYUwWAl4W7sSddgaKVsP3yRN0G1uBR3N3mouAHQQozAGctWxz
         oNonKVg8YtCOh35N5bKa8YdDi84qe94YvvEJoHMYYBiFprM7s351R8JTBU72YvRZ1/hQ
         2QvwP9uoY3VP/ECLwnhOzH12OviC5ErKFJSrKJT+dRN652KGlnptVSEp80y7uYJ9PhTJ
         c9XEb+P2jFj8oFFayCk/2xfoP5uig/JfIB5r9/cDuTXFbW4syaneoh8VQEo/slNfooX6
         Hsl2LOdhPh7wxPUDr50EAglZwGqpbbeCD0F2OnoH4X3jk/MNAk7ByPwZTJNvaBMuOXAX
         n2fg==
X-Gm-Message-State: AOAM533oeTKPGJP09wcwBok1X9zvR1H+TbSvJJIr8BOwbIAUBBC+xcmt
        YO9RND2ec5qfsUgL8Tyfv7/ZJ/ttCAo=
X-Google-Smtp-Source: ABdhPJwwJfoiNqOCqgA+b9tVxoV3dBsuPZnUsUtSkXbWsadSG5T8bjryydxGJxvHMglTyACd6sWkDQ==
X-Received: by 2002:aa7:d686:: with SMTP id d6mr1778994edr.146.1614528464001;
        Sun, 28 Feb 2021 08:07:44 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id hd39sm10070986ejc.116.2021.02.28.08.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 08:07:43 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v3 00/35] 20210215154427.32693-1-avarab@gmail.com
References: <20210215154427.32693-1-avarab@gmail.com>
 <20210224195129.4004-1-avarab@gmail.com>
 <c2e90134-35bb-24b2-a334-7c6abdd6dc6f@kdbg.org>
 <3519e86e-d9eb-a9e0-ed28-72d32271d2bf@kdbg.org>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <3519e86e-d9eb-a9e0-ed28-72d32271d2bf@kdbg.org>
Date:   Sun, 28 Feb 2021 17:07:42 +0100
Message-ID: <875z2ckwfl.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Feb 28 2021, Johannes Sixt wrote:

> Am 27.02.21 um 08:47 schrieb Johannes Sixt:
>> Am 24.02.21 um 20:50 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>> Addresses feedback on v2. Since Junio & Johannes expressed a desire to
>>> keep the existing test scheme in t4018/* it's still there, but it's
>>> also possible to add *.sh tests in that directory to use the more
>>> familiar test framework used elsewhere in the test suite.
>>>
>>> The tests added here make use of it to e.g. supply custom -U<n>
>>> arguments, set config before the tests etc.
>>>
>>> I also improved that existing test support so you can have N tests in
>>> one file with (mostly) the existing test syntax. See the "userdiff
>>> tests: add a test with multiple tests in a LANG file" patch.
>>=20
>> I've read through all patches and had a comment here and there. I like a
>> lot that we can now put more than one test into a single file.
>>=20
>> However, I do not like the shell script version of tests, because the
>> syntax is so hard to read. Also, it looks to me that they are only
>> needed for a few tests that could just as well be coded as one-off tests
>> outside the framework.
>>=20
>> I've now pulled avar/t4018-diff-hunk-header-regex-tests-3 from your
>> github repo and will check again if I missed some cruicial points.
>
>
> I've now looked through the patch series again.
>
> I appreciate that you dug through the history and discovered and fixed a
> few deficiencies and loose ends. The way to throw all test cases for a
> language driver into a single file I like a lot, too. The way to specify
> expected results is manageable (modulo the dependency on the test
> number, t4018, that Junio mentioned).

Yes, maybe just "HEADER:" or something would be better. I was trying to
come up with something guaranteed not to conflict with the language in
question. Maybe:

    =3D> HEADER      =3D=20
    =3D> description =3D=20

> But I do not see the need for the framework provided by the new
> test_diff_funcname. At the end of the series, it is only used by Perl
> and custom driver tests. (I discount the new ADA and Ruby tests as they
> can easily migrated to the simple test scheme.) But then the Perl tests
> do not do anything special, either. The multi-line pattern test is just
> a nice add-on but not strictly needed. In the end, the Perl test is just
> as straight-forward as all others.

The benefit now is:

 1. Unlike the new plain-text "all test cases for a language driver" in
    the same file mechanism you can have test descriptions. The
    "description" in the golang one is just for show, you won't get
    anything informative from test-lib.sh when your test fails.

 2. I think having #1 beats not having test descriptions at all, or
     having to shove a description like the Ruby:

    "picks first "class/module/def" before changed context"

    into something that would make all the FS's we have to support
    happy.

 3. A test in the new perl.sh one sets config. I think in both that case
    and custom.sh it's more readable to carry such config setting with
    the test, rather than at a distance in the main setup of t4018-*.sh.

That being said I'd like to improve the syntax a bit, in particular
instead of having a wrapper for test_expect_success I think it makes
sense just to have the test call test_expect_success, and then provide a
couple of helper functions.
