Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEEA5C433EF
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 09:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235937AbiBOJew (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 04:34:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235024AbiBOJev (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 04:34:51 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC812B717F
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 01:34:41 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id t14-20020a1709027fce00b0014d5ddc9dfbso7958437plb.22
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 01:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=dTeAkOLczizTPTu/F/S0j3xhGrsTWwSOiQ6OT7DwLxQ=;
        b=U8X3aH+ANnYZn21/evqe5tMpT60fsQ2eIg2yaeVyy6tozuB2f1yLHukVvAYON8IdXP
         ZqW37xIy5X33uGXLr3j+2OeYcstPamJOMpEAW0NFHCCL1GNJ3VmE/28XAxw7a8ts2cbw
         hW/d8LbT7PRpDf2nQCAt3irljHMDl0+TSAwUGP8BLj1TppMzqRZdWZwZjbl/gInD6zOU
         m2+uoKiojM3uWKzsQ+mW5L05xfCjQBRQ9omY4LiLBE676PZk1KuaMXQzZ/9twaamlO9R
         Y8tFsg7uVsc1j+ruwhCd5VcElQIXSWVOkPTOoQTuTfg0h7aQAlGWRxH8571rv8edBSgH
         nzAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=dTeAkOLczizTPTu/F/S0j3xhGrsTWwSOiQ6OT7DwLxQ=;
        b=VSkXBSIL01hVV5BLoPU4jk4ptXEczp2yoB+hDI2Do332M8OTjyPn2xqgY8hXRniQ43
         0RA9B1543OxCeKFA1qGBCZe5QMB11NnckcCCg9616lhvxLU06eqptvLmhyvuC1KHeT58
         UR9XltZV5TH92JGQIS1Ut6zACeRDhqc3sLb5LEmp0BQhDOr5OtV+5/E/6CmYCZwVpfM/
         9y+G8WKpAeBt3t0kyonvE0P/t8LBDSxQ+Z6SgEUnKfKZYeYD0wPBcs3mn+VPKBIHYBpe
         s6laXVj2LIYUub8Y9OHyHKqdS044tgnb6XcUBsD0VVtpcqVne5S+ti4/GUW44wjkfg8l
         j/Vg==
X-Gm-Message-State: AOAM532k1uuMtpughUYRa8knBTjBWZMFr/0AvBJ6PzigdY8sn47ABZy8
        G5bHoaOJ9Yvhi65iAT2YPc/A1IcVWAWifA==
X-Google-Smtp-Source: ABdhPJwZVUwEvLvFcSKeMsr9R0+C5WwkHAXSNT4L8p0HdlWWOLY6mPKFULGIVIUylEhgSVtlEyD9jDxx1QQb+w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:24d1:: with SMTP id
 d17mr2996617pfv.81.1644917681070; Tue, 15 Feb 2022 01:34:41 -0800 (PST)
Date:   Tue, 15 Feb 2022 17:34:38 +0800
In-Reply-To: <220214.86h791xsza.gmgdl@evledraar.gmail.com>
Message-Id: <kl6lzgms5v80.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220208083952.35036-1-chooglen@google.com> <20220210092833.55360-1-chooglen@google.com>
 <xmqqv8xj71mt.fsf@gitster.g> <xmqqr18770pc.fsf@gitster.g> <kl6la6et76bb.fsf@chooglen-macbookpro.roam.corp.google.com>
 <220214.86h791xsza.gmgdl@evledraar.gmail.com>
Subject: Re: [PATCH v7 00/20] submodule: convert the rest of 'update' to C
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Tue, Feb 15 2022, Glen Choo wrote:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>>> This seems to heavily conflict with "clone, submodule: pass partial
>>>> clone filters to submodules, 2022-02-04" by Josh Steadmon
>>>> <690d2316ad518ea4551821b2b3aa652996858475.1644034886.git.steadmon@goog=
le.com>
>>>> in both builtins/submodule--helper.c and git-submodule.sh.
>>>>
>>>> It also removes the code that "submodule: record superproject gitdir
>>>> during 'update', 2022-02-03" by Emily Shaffer
>>>> <20220203215914.683922-5-emilyshaffer@google.com>, so what the other
>>>> topic ends up adding to the shell script needs to eventually be
>>>> redone in the C code.
>>>>
>>>> I think "superproject aware" topic would see a reroll due to a
>>>> slight redesign.  I am not sure how solid the design of the
>>>> "pass down partial clone filter" topic is at this moment.
>>
>> Hm, I haven't looked at where the conflicts are yet, but I'll get to it
>> as I'm reviewing the rest of the feedback.
>
> To save you some time, my v4 CL summarizes the semantic conflict between
> the two:
> https://lore.kernel.org/git/cover-v4-0.7-00000000000-20220127T143552Z-ava=
rab@gmail.com/
>
> I.e. Atharva Raykar had working C code to do what an older version of
> that superproject config series was doing, but the semantics changed in
> a later version. It needs some new usage of path.c (or similar) API
> adjusted, but I didn't (and still don't) have time to look into it.

Ah, thanks for the reminder. That should help.

>>> I can merge this to seen minus the above two topics and get it
>>> compile, but it also seems to have some interaction with 961b130d
>>> (branch: add --recurse-submodules option for branch creation,
>>> 2022-01-28) and makes the t3207, tests added by that other topic,
>>> fail X-<.
>>
>> Oof, that's embarrassing of me, let me take a look at that. There's a
>> nontrivial chance that the "branch --recurse-submodules" tests caught an
>> actual regression.
>
> FWIW one thing I did as an extra sanity check was to run the whole test
> suite with --tee with/without this series (or rather, my earlier
> version), and diffing the full test-results output (which you'll need to
> save in-between the two runs, and IIRC hack t/Makefile to stop removing
> it on successful runs).
>
> There's a lot of differences in output due to general issues in the test
> suite output not being reproducable (writing timestamps etc.), but I
> could not find any issues with the "git submodule" output being
> different, of course we may not have tests, or it may be piped to
> /dev/null....
>
> But I've found it to be a helpful additional validation technique for
> this series & others where I'm not as confident in the test coverage.

Thanks for the tip! I hadn't considered trying this, but this makes a
lot of sense. I can see this being even more useful for this series
since it's supposed to be a faithful conversion of sh->c.
