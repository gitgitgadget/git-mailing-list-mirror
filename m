Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C80CCA47A
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 10:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiFPKWk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 06:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiFPKWj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 06:22:39 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981506402
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 03:22:32 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 25so1520959edw.8
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 03:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=VW7EAs5L/4edtUlWNYn7285ZAMNciwVwp/lMlNAQ3ag=;
        b=nFdlj2ubrlLmS1i/FnlRdVUbqJDYqTmWgCTVIwJofniBYjHvlTlYeezPz2sR/X/X55
         XNbFokcxTehYXDE5QCUtjOJLajX4JFjKgHn6uTI3SfljSCEVkt2MEtOhfN9de3EwswWC
         mpV/6c6vOXLzOK3uiIBPadYmiwFS8XsHNmjBNF9nswrprTvAlh7VzVrRmxZjcgd5jTez
         8xOLT58a7LGbFgymBpuS/+xhKbQGke73DsVdgop9vX1+BT/X+DPKxZOJKsvp6du6W8JB
         m1UVwJiA2H1EG/CAc5ma072MfPclg6fL4JPeHa0Wmc32FQhgwpoWk5MdJFU8jE1LFpOi
         l/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=VW7EAs5L/4edtUlWNYn7285ZAMNciwVwp/lMlNAQ3ag=;
        b=bGO1t4cFQFaBiap9nwjUx/vOzjhwGPO/Z6ruvpF48StBU1S7mo5wJX0FHwQKN2Xq05
         eCc85tGlMUFXdFSSyN2UwzRisHjHw3A4duVjZV+MLbt1ma4C9qrcAXOA4Fw8W5WGIEEQ
         Dz180CvtZuuSnC9kBNj702UufCM9QzS82z8PayaKUKwwTut/4rgdNmbOdvv0BA57TYqr
         jn1HUFNUlD0Z22uqhfhhg4FRc/zPJD0C+nvXIEeW9/2wGCs6/t8sVdg6Q0A0NjYVFW3J
         e8GXl/ft2k7E+BdS/2zNx+j1XxhrgVtoB+64tC0vk4Me1DeWLuEvpOSRRiNADluUQLxR
         /FFw==
X-Gm-Message-State: AJIora8Kfr2aoWB4LPAidDImddZRcLqZiwe3X6hmPCHxtZoPuLJfMzIg
        eKpIDNrf22QJSIQNVw1SG25AFFcP6MvnkA==
X-Google-Smtp-Source: AGRyM1vqa/fxDPUy6eTNWZYFzhMfb34WvS6eyWgrf6v/HPwRa6sy8Wh2MxmPDzbLanQLBZIemeEBng==
X-Received: by 2002:a05:6402:11c7:b0:42e:c47a:ffdf with SMTP id j7-20020a05640211c700b0042ec47affdfmr5457789edw.113.1655374950481;
        Thu, 16 Jun 2022 03:22:30 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id i25-20020a50fc19000000b0042bc54296a1sm1423360edr.91.2022.06.16.03.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 03:22:28 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o1mdv-000ydp-PN;
        Thu, 16 Jun 2022 12:22:27 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Michael J Gruber <git@grubix.eu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] add -i tests: mark "TODO" depending on
 GIT_TEST_ADD_I_USE_BUILTIN
Date:   Thu, 16 Jun 2022 12:16:46 +0200
References: <cf6aee9acadfb666de6b24b9ed63e1a65bfc009e.1655220242.git.git@grubix.eu>
 <patch-v2-1.1-13c26e546f6-20220614T153746Z-avarab@gmail.com>
 <YqlIRveupj6tOO4P@pobox.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <YqlIRveupj6tOO4P@pobox.com>
Message-ID: <220616.86sfo4x5zw.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 14 2022, Todd Zullinger wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Fix an issue that existed before 0527ccb1b55 (add -i: default to the
>> built-in implementation, 2021-11-30), but which became the default
>> with that change, we should not be marking tests that are known to
>> pass as "TODO" tests.
> [...]
>> ---
>> Just converting it to "test_expect_success" will break CI and other
>> setups that are testing with GIT_TEST_ADD_I_USE_BUILTIN=3Dfalse.
>>=20
>> The below fixes it, however.
>
> Nice catch.  FWIW, I tested w/GIT_TEST_ADD_I_USE_BUILTIN=3D0
> and without.

My patch landed on "master" as 7ccbea564e8 (add -i tests: mark "TODO"
depending on GIT_TEST_ADD_I_USE_BUILTIN, 2022-06-14) so this is water
under the bridge.

But just to tie this loose knot I think something went wrong in your
testing.

If I:

    git checkout v2.37.0-rc0
    # Apply your patch from <20220614185218.1091413-1-tmz@pobox.com>

I'll consistently get a failure from:

    GIT_TEST_ADD_I_USE_BUILTIN=3Dfalse ./t3701-add-interactive.sh

Since we do fail that test with the Perl implementation, and now it's no
longer a TODO test.

Perhaps you used it as a parameter to "make"? I.e.:

    make GIT_TEST_ADD_I_USE_BUILTIN=3Dfalse
    make test

Which isn't how it works, just speculating...
=20
>> diff --git a/t/t2016-checkout-patch.sh b/t/t2016-checkout-patch.sh
>> index bc3f69b4b1d..a5822e41af2 100755
>> --- a/t/t2016-checkout-patch.sh
>> +++ b/t/t2016-checkout-patch.sh
>> @@ -4,7 +4,7 @@ test_description=3D'git checkout --patch'
>>=20=20
>>  . ./lib-patch-mode.sh
>>=20=20
>> -if ! test_bool_env GIT_TEST_ADD_I_USE_BUILTIN true && ! test_have_prere=
q PERL
>> +if ! test_have_prereq ADD_I_USE_BUILTIN && ! test_have_prereq PERL
>>  then
>>  	skip_all=3D'skipping interactive add tests, PERL not set'
>
> It's not the fault of this patch, but it makes it obvious
> that the `skip_all` message is no longer accurate.  Perhaps
> somethine like this?
>
>     skip_all=3D'skipping interactive add tests, missing ADD_I_USE_BUILTIN=
 or PERL'
>
> Maybe a separate `ADD_I` prereq would be better?  Though
> without looking closer, I don't know if that would end up
> being clearer to anyone running the tests without either
> PERL or the add -i builtin enabled.

Yeah seems like a good idea for a follow-up, but since it's landed I'll
probably forget :)

> Thanks for the keen eye and attention to detail, =C3=86var,

Happy to have it fixed!
