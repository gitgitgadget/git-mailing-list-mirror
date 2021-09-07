Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D52CC433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 09:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10C26610E8
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 09:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245123AbhIGJRl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 05:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244488AbhIGJRk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 05:17:40 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B9FC061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 02:16:34 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id j13so12912798edv.13
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 02:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=14wpQzdDehUpp11MLkjyfXKfNow+0tG/N/FAhTilKEs=;
        b=dvfCTqEIaerKl82Tsp+mAkH/nKJ+Y3Mu/mWFYMI5m4SveHy1c/G3EeoHQSUYijuHKa
         8F1x/8IRc+qSTQolxas+/Shf/e8a79HNvg3SAoYV22SOZQ8cV3NQozB2QHnec71eMxI3
         oNU8HCSm7pIAHkPsdv9XTwOAgMUi17rxzeAYLOIDlgq8gFboXwl7ldJjwjK43tOcSeEU
         hPoA0P3faVkBn06MNBpkXAaMl7GO3tuZ22jbu9BwFdp46zqKc6EiMaV2olixpqhEOdKy
         UczDe8VTQplILPwYYfAWPYkP8Q8kHUUfyxyO31XCtEA9iiBmS0niLekvoXeBlsiwy41c
         dwvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=14wpQzdDehUpp11MLkjyfXKfNow+0tG/N/FAhTilKEs=;
        b=nkF/M0OQ34Tpe/ZdfNRUPo789R0W1V6UvaJ7J82d0ZthF+iIMKdK7qa8Ei6J0ko+Xs
         Q6Qg8cux7MEldTP+qsxE86utitnVkQgbF9r2ySxJstZ3bZlUoElumKv9rmeQ9vMFJvG8
         Ct7pGhnl1DzykGKhd9kqEvPO+9588GroRSwvxLXObvpFnRzC5DsLJecKVLs6cysetSpC
         pkTSgw8RAUSXPrEUxyd+Xn/L2puLfngY+lwvP71NI1xi3uijGmQLv0ZYzMqdGDWJTkdv
         bV0DnG6a9JghB2d4oB3D+Jz0F+Yt9ffout22GdzGn0EiqVTh1WZb2N2n8wXs67no0NBl
         HU2A==
X-Gm-Message-State: AOAM531eY6C9ev9poyzexsQnxuAp9I42Jnb2fAIIf1DqcAnJeo4/GXxz
        h9ftAhH3R8KhBo1V4yScHTrUWwideM8=
X-Google-Smtp-Source: ABdhPJxbklYb3oITNTv0h2a0YbFnO7Q0jCkKBSUWXy5eAPIL7XnNIzSj6ZJrzzSgkRcNaraO9E/BEA==
X-Received: by 2002:a05:6402:1768:: with SMTP id da8mr17059461edb.80.1631006192569;
        Tue, 07 Sep 2021 02:16:32 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id b13sm5638316ede.97.2021.09.07.02.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 02:16:32 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eli Schwartz <eschwartz@archlinux.org>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] send-email: fix a "first config key wins" regression in
 v2.33.0
Date:   Tue, 07 Sep 2021 11:15:11 +0200
References: <96814e5e-54be-1eca-0d75-68be53b1be3d@archlinux.org>
 <patch-1.1-ae6ff9f77f1-20210906T073306Z-avarab@gmail.com>
 <ce194f13-2b1f-fb21-e224-80190f3b2fd6@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <ce194f13-2b1f-fb21-e224-80190f3b2fd6@gmail.com>
Message-ID: <87mtoon3tc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 06 2021, Bagas Sanjaya wrote:

> On 06/09/21 14.33, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> +test_expect_success $PREREQ 'sendemail.8bitEncoding in .git/config over=
rides --global .gitconfig' '
>> +	clean_fake_sendmail &&
>> +	git config sendemail.assume8bitEncoding UTF-8 &&
>> +	test_when_finished "rm -rf home" &&
>> +	mkdir home &&
>> +	git config -f home/.gitconfig sendemail.assume8bitEncoding "bogus too"=
 &&
>> +	echo bogus |
>> +	env HOME=3D"$(pwd)/home" DEBUG=3D1 \
>> +	git send-email --from=3Dauthor@example.com --to=3Dnobody@example.com \
>> +			--smtp-server=3D"$(pwd)/fake.sendmail" \
>> +			email-using-8bit >stdout &&
>> +	egrep "Content|MIME" msgtxt1 >actual &&
>> +	test_cmp content-type-decl actual
>> +'
>> +
>
> Did you mean overrides global .gitconfig (s/--global/global/)?

I mean config set with the equivalent of "git config --global", but yeah
this is probably an awkward way to phrase that.

> Anyway, compiled and tested successfully (test suite passed).
>
> Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

Thanks, FWIW the test suite passing doesn't mean much in this case, the
only test that stresses this is the above. The issue being that the
regression wasn't caught by any existing test...
