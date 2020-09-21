Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F831C43464
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 10:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08B3620EDD
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 10:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJB/ZL0i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgIUKmI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 06:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgIUKmH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 06:42:07 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3FAC061755
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 03:42:07 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id n13so12212206edo.10
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 03:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=3pHMIKHNawWuI4HEfFc1rLBo8WWEbxU9bRZc2PPdltI=;
        b=kJB/ZL0ivHaBXgMjm9yjUCYl5V0sxdo3bXjjrhuxW22/5/J/T/emM4O2f2MLbgR1Yh
         0FCUYpV53RNm4rZRSDj0U4Ts05H33bvY5zmPNtu/uexK6caOFpZ40UHnwD8FCCGEIA97
         nGJs8mjDB5jRMKNLfUnDZzMBP+ZlXyYImYDK0uVypiYuMmUeli18YDgLRgFG/OhlATvS
         33akEjFIeUBFfm/xNvYCAvX0pD9H/blynBZTsBmFyUnr1xB0a6TtBgGGbTBeYhaMQPmW
         HZ/SU5XS78jlEeAy4+9UVHun0YjT8Ww/yUz3JDSU9wMGRR23qFM2M1aoLTffRBSJMyTJ
         3KJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=3pHMIKHNawWuI4HEfFc1rLBo8WWEbxU9bRZc2PPdltI=;
        b=Jx+KzTXX1iXr9ErqYp5EnqW00OB429zBq+6KarXdgHBFgOg+oUOOcbfkCgJdhwrzQo
         /7wiCEjh6ia+9EGDbH035mc4n7j9TJUx4x9ijpYFW5xMMtP7Pg0erqb3zoD4GQwdw4PN
         dM9uT8/xLeICWJj1aRqwxiJW+VwtYmNuyJ74XqGQFp1MyUD+OfNEzu6IBQVIR+x3Ohd/
         LWzfTlPnqE07OvQITNLyxCCH0iD18JCQZU2izuzzaysY09o5upUxAC19kZf01SLJSVd0
         kaLDdBX5v78bcSMHtDIXQsX/R3oOgq6CSnDAJSlqBIvYkcOBmd1mvJT704S0JFrrHf0u
         S1Pg==
X-Gm-Message-State: AOAM531ibAZKswOUNostwZes51Ydw3kXiN0Pg6q/rsGt2s8mgBqd7NAn
        M2L1WjnwtnNM98G2G8bgp3I=
X-Google-Smtp-Source: ABdhPJyHnUKgUGniN8q8WFQq4UXHDYV8NEyH9W5gR41Sm5NU0aDSzV7Y0TbwJla1+6y/iDiQCyopkA==
X-Received: by 2002:a05:6402:228c:: with SMTP id cw12mr53277325edb.174.1600684926039;
        Mon, 21 Sep 2020 03:42:06 -0700 (PDT)
Received: from evledraar (dhcp-077-248-252-018.chello.nl. [77.248.252.18])
        by smtp.gmail.com with ESMTPSA id m2sm8507547ejo.4.2020.09.21.03.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 03:42:05 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Antoine =?utf-8?Q?Beaupr=C3=A9?= <anarcat@debian.org>,
        Simon Legner <Simon.Legner@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH 07/15] remote-mediawiki tests: guard test_cmp with test_path_is_file
References: <20200916102918.29805-1-avarab@gmail.com> <20200916102918.29805-8-avarab@gmail.com> <CAPig+cRg2tuOiQH_CQoHMjkX2gbRPJoV8NPJZnu3=bfo4wk-cQ@mail.gmail.com> <87mu1jh5mv.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <87mu1jh5mv.fsf@evledraar.gmail.com>
Date:   Mon, 21 Sep 2020 12:42:04 +0200
Message-ID: <87imc7if7n.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 21 2020, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Wed, Sep 16 2020, Eric Sunshine wrote:
>
>> On Wed, Sep 16, 2020 at 8:17 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>> <avarab@gmail.com> wrote:
>>> Change a test that used a plain test_cmp to first check the file(s)
>>> using test_path_is_file. If some of these file(s) don't exist (as
>>> happened to me during debugging), test_cmp will emit a way less useful
>>> message about the failure.
>>
>> An alternative would be to update test_cmp() to present a more helpful
>> error message so that all test scripts can benefit rather than just
>> this script. By the way, were you testing with a reasonably recent
>> version of Git? I ask because test_cmp() was updated not long ago to
>> provide better diagnostics when one of the files is missing.
>>
>> [1]: d572f52a64 (test_cmp: diagnose incorrect arguments, 2020-08-09)
>
> Thanks (and also to =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh in a side-=
thread). I've dropped
> this patch. It's indeed better to leave this to a more general facility
> as in your now-integrated test_cmp patch.
>
> The reason I came up with this now-useless patch is because I originally
> started hacking this series on a slightly older version of git, which
> didn't have that patch.

Correction: It was the other way around, but I ran into the case with
your patch + converting a test to test_expect_failure, where before that
would be an "ok" failure since a file was missing, but now hard errosr
with a BUG.

I think that behavior is OK, but in going back&forth and rebasing
managed to miss it the first time around. The v2 of this series has a
more narrow fix for that.
