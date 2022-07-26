Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF67C25B0E
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 13:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbiGZNmu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jul 2022 09:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiGZNmt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jul 2022 09:42:49 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDE91AD9C
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 06:42:48 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id c72so14886162edf.8
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 06:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=8MGJDmpzmQYlM4Mo41R+QyltP773lHwD/4X/m1Uvobk=;
        b=esU77cNJ43FAsedZO/rLVhSaAktWWtA8xJ7+OP90qsp3iBRT7Rtd2vubM/lAi2NfxW
         lWP3LNfqJAGEfW/X9Qhv0Nh+nlKeQVkHmsm0E6xpfyVi7MQKcIOFfIW/NzJMBoL7JLBK
         v+Ql2eNtVddNaia2TrarA7NqVKCMYEHF3PoRZsLSOFdhcJMinCjG5eiXS7DBsYktCiAt
         hO6+cZCC/83BzjBgeO7A6bvWD7VROlu/JryMvDztjIPkFHD/a7EtGyWEEB/rgPN5/qcx
         bTaicUsg2WbGsqGxQt5xKgXKPJsub/qROvUiwh0MEEVPwpKYeWtoHnJgywISOuhNg/lZ
         Xb2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=8MGJDmpzmQYlM4Mo41R+QyltP773lHwD/4X/m1Uvobk=;
        b=1uzU0nI+h+vFPmgBBQWZqgSFSAtmDXD8xOdBNhxfYoLkEi55/vMW+nV1FlYRpFWgQY
         tkWFIhjumTFLzsjP9/4o6YgynUDbvmgH3x6OJw9IX1lrsv4VnVut+hgS8WOtIGfCfv9n
         YotWuIYmhSoINU+W5ya8Pdbvpuf9B4eosRHOpmsoBrtu849k0aLg1Q64yGUaohF1S9+t
         llMsV3oEo673xiHV6f0DONACaGwVCbHUMYOwhrjvXfDCJpkfyx9+5tFlf8v1VkyZrjN6
         /IxIwNy+Whm9Mie8NDktg5ZSfjCsmMUoV4piBSH7/kXKTqM1O/TLvBr6sEqAXkwCSEDf
         XUbA==
X-Gm-Message-State: AJIora8RCofKuRagonOqO/xYI9dPhD5k18ZK0RWjExq8eZLoN20qL2P3
        D2Hf25/xPBl5xogmUZC3gDw=
X-Google-Smtp-Source: AGRyM1t1DPcHiG28q1WhA1R2wie+T8VFSByx1HrDLgZ48oJpWZidBotBOuQeXnc5CqnJAt0gNqUy8A==
X-Received: by 2002:a05:6402:518d:b0:43c:32b2:a0a with SMTP id q13-20020a056402518d00b0043c32b20a0amr6726727edd.388.1658842966777;
        Tue, 26 Jul 2022 06:42:46 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id ba17-20020a0564021ad100b0043c87da1ab6sm454528edb.48.2022.07.26.06.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 06:42:46 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oGKpg-0068DB-Od;
        Tue, 26 Jul 2022 15:42:44 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] CI: add SANITIZE=[address|undefined] jobs
Date:   Tue, 26 Jul 2022 15:33:50 +0200
References: <patch-1.1-e48b6853dd5-20220726T110716Z-avarab@gmail.com>
 <d4dcb1f6-6076-3725-d479-7e9f1fece2a3@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <d4dcb1f6-6076-3725-d479-7e9f1fece2a3@github.com>
Message-ID: <220726.867d40ng6j.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 26 2022, Derrick Stolee wrote:

> On 7/26/2022 7:09 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Add CI targets for SANITIZE=3Daddress and SANITIZE=3Dundefined. The form=
er
>> would have caught a regression in 18bbc795fc5 (Merge branch
>> 'gc/bare-repo-discovery', 2022-07-22) which made its way to
>> "master"[1].
>>=20
>> Per [2] the GitHub fork of git.git runs with these in CI, so it's
>> already useful to some forks of this repository.
>
> I'm a fan of adding additional sanitizer checks in our CI. Let's let
> computers do the work for us here instead of relying on humans.

Thanks, good to have agreement on adding these CI runs.

>> Also per [2] we could use SANITIZE=3Daddress with some ASAN_OPTIONS
>> instead of our SANITIZE=3Dleak job added in 956d2e4639b (tests: add a
>> test mode for SANITIZE=3Dleak, run it in CI, 2021-09-23), but unifying
>> those two with these new jobs would be a lot harder, so let's leave
>> that for now.
>>            - jobname: linux-leaks
>>              cc: gcc
>>              pool: ubuntu-latest
>> +          - jobname: SANITIZE=3Daddress
>> +            cc: gcc
>> +            pool: ubuntu-latest
>> +          - jobname: SANITIZE=3Dundefined
>> +            cc: gcc
>> +            pool: ubuntu-latest
>
>> @@ -277,6 +277,12 @@ linux-leaks)
>>  	export SANITIZE=3Dleak
>>  	export GIT_TEST_PASSING_SANITIZE_LEAK=3Dtrue
>>  	;;
>> +SANITIZE=3Daddress)
>> +	export SANITIZE=3Daddress
>> +	;;
>> +SANITIZE=3Dundefined)
>> +	export SANITIZE=3Dundefined
>> +	;;
>
> In both of these cases, we are breaking from the nearby pattern. These
> jobs could be renamed to linux-address and linux-undefined to match the
> linux-leaks job.
>
> Alternatively, we could rename linux-leaks to SANITIZE=3Dleak[...]

I deliberately deviated from the "linux-leaks" pattern since it's a lot
more than just:

	make SANITIZE=3Dleak test

I.e. we instrument what tests we run, skip some individual ones
etc. These are different in that we can run the entire set. I'd think
the reverse would make sense, i.e. one day if we run fully with
SANITIZE=3Dleak enabled to rename that job to "SANITIZE=3Dleak".

> [...], since the
> point is not to test the Linux platform but to use the additional runtime
> checks (and Linux is the fasted CI platform).

Strictly speaking these tests are platform-specific in that they require
us to take certain codepaths at runtime, so if we have any
platform-specific code, or code that's affected by compilation options
(say NO_REGEX=3DY v.s. using the libc's) we might see failures on one
platform, but not another. Compilation flags also matter (e.g. -O0
v.s. -O3).

But I think for all of [leak,address,undefined] it's a sensible
trade-off for now to just pick one specific platform.

Since it's very unlikely that the resulting issues are OS-specific I
thought it made sense to leave "linux" out of it, just like we have
"pedantic", not "linux-pedantic", ditto "sparse" which is also
platform-specific around the edges.

Having said all that I really don't care much what we call these as long
as we get the test coverage, but I'll hold off on any possible re-roll
to see if others chime in about the bikeshed :)
