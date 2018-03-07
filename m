Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B4651F404
	for <e@80x24.org>; Wed,  7 Mar 2018 18:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754491AbeCGSih (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 13:38:37 -0500
Received: from mail-wr0-f180.google.com ([209.85.128.180]:43729 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753934AbeCGSig (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 13:38:36 -0500
Received: by mail-wr0-f180.google.com with SMTP id u49so3188033wrc.10
        for <git@vger.kernel.org>; Wed, 07 Mar 2018 10:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=sEl9Fd/FwiGdaKZE1pPzAhrMM1saoOjQaR2jJQgCYI4=;
        b=pZoTvGY7gc7wGQie1x/RscVDZeIronqhM+5KaOiOfnzUlWap+y9JNUD9pFErAlF+cM
         mdLwD3yUVeMwpHqEvuyMqwGtxsA4jB8qlYotTmH8RdsEl3fUcfNvXoVhdk2d26YLnJ3O
         NFY1rlvhMaMOIgarUpGVJ6nR8RnrRDiliO68huIc4RPnlA5n44tqTbbs+Msthd70G0UU
         D4+84HJ+ZumAi093xj3OVDMCIvxk3KBn4C4FxWFfeCAqFegT+LC3+kH7OsDS3fNfDOWS
         Xu4Tb/mmbbJVR7qDO7xh2hvgs2xSLYPtUqnO2oCHHC9yGl8/SR5gPkQdi0InHBzqThKD
         6bvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=sEl9Fd/FwiGdaKZE1pPzAhrMM1saoOjQaR2jJQgCYI4=;
        b=juHP39tNMGwZmFr3eL1hPmG9OzFOl96Jr9Vok+yFCr7uVXxJ7+qM80Ut3DH+MNbtO3
         FVOXa+4yB6iSB3C3jxGyIXCmMP5KsPktwuWmsBiRmQDj8dfwvoNRT7YvxfVmsFCj4aAj
         nkoPNqaMqiEm7URjyI+ojrAg+LdjGEivzASklGmd/n6DvDjrzDMTkSqH0xP4jrfGC2sQ
         8p+TsT7fIYNh6YELwTMmmK4bu8azl9ll/8Hx7KLOVJPghEEPtslZ5xG0WPlvNJVozIfL
         NS17POuaXA9a3oR2zRf65l4XYq9rHXs4yTlnHB3j8VEZsX2mS05xlLELF3/umUPiERkH
         Opqg==
X-Gm-Message-State: APf1xPCUgKEqW/U8Tcq/5dwBY4eIi2NzZwpdo1ri40nLKwQ1VqCDmTTc
        xGzb0gQSYdI1poad5YeFUdawK1UMC5w=
X-Google-Smtp-Source: AG47ELsyf8aSv3zAAJEHMiH3e3mBgz30K29vIKMNKtCqIonUaKrK1Zkn6ZmE2JwabZD1wmhf+eR31g==
X-Received: by 10.223.182.156 with SMTP id j28mr19778008wre.66.1520447914403;
        Wed, 07 Mar 2018 10:38:34 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 1sm5768685wmj.35.2018.03.07.10.38.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Mar 2018 10:38:33 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Eric Wong <e@80x24.org>, Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 3/5] gc --auto: exclude base pack if not enough mem to "repack -ad"
References: <20180301092046.2769-1-pclouds@gmail.com>
        <20180306104158.6541-1-pclouds@gmail.com>
        <20180306104158.6541-4-pclouds@gmail.com>
        <xmqqfu5d3tbn.fsf@gitster-ct.c.googlers.com>
        <CACsJy8C2j2dLozhHf4zE--KYPZ2VjOW2tobmczh3rf6L==Q1vw@mail.gmail.com>
Date:   Wed, 07 Mar 2018 10:38:33 -0800
In-Reply-To: <CACsJy8C2j2dLozhHf4zE--KYPZ2VjOW2tobmczh3rf6L==Q1vw@mail.gmail.com>
        (Duy Nguyen's message of "Wed, 7 Mar 2018 17:48:59 +0700")
Message-ID: <xmqqd10f20k6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>>> +Set environment variable `GIT_TRACE` in order to see the memory usage
>>> +estimation in `git gc --auto` that determines whether the base pack is
>>> +kept.
>>
>> This is somewhat a puzzling use of trace.  It sounds more like a way
>> to find out "how" memory usage estimation is done and arriving at a
>> wrong value for those who want to debug the feature.
>
> Yeah. I'm not sure if this estimation could be really problematic that
> people need to debug this way. A cleaner way (if we think people will
> need this often) is just add a new option in "git gc" to report this
> estimation breakdown and do nothing else.

Actually after reading the implementation and seeing what it does, I
personally do not have any problem with the way GIT_TRACE is used
for this purpose in this patch.  I am not sure how interesting the
information given by that codepath in real life; it looks even less
intereseting than say what comes out of "verify-pack --stat".

>> This is finding the largest pack.
>
> The discussion on .keep files raises one question for me, what if the
> largest pack already has a .keep file, do we still consider it the
> base pack, or should we find the next largest non-kept pack?
>
> I'm guessing we keep things simple here and ignore .keep files.

I agree that it is a sensible design decision.

>>> +#elif defined(GIT_WINDOWS_NATIVE)
>>> +     MEMORYSTATUSEX memInfo;
>>> +
>>> +     memInfo.dwLength = sizeof(MEMORYSTATUSEX);
>>> +     if (GlobalMemoryStatusEx(&memInfo))
>>> +             return memInfo;ullTotalPhys;
>>
>> Is this legal C in Microsoft land?
>
> That's the problem with writing code without a way to test it. At
> least travis helped catch a compiler bug on mac.
>
> I'm torn between just #error here and let Windows/Mac guys implement
> it (which they may scream "too much work, I don't wanna") but if I
> help write something first, yes things are potentially broken and need
> verification from those guys. I guess I'll just fix this up and hope
> non-linux guys do the rest.

Yup, we all collaborate and help in ways each of us can.  None of us
can be expected to do any more than that ;-)

>> I wonder if the above should go somewhere under compat/ without
>> ifdef but split into separate files for individual archs (I do not
>> know the answer to this question).
>
> My first choice too. I chose this way after seeing online_cpus()
> thread-utils.c. Not sure which way is best either.

OK.

>> But to those who say "packs larger than this value is too big" via
>> configuration, keeping only the largest of these above-threshold
>> packs would look counter-intuitive, wouldn't it, I wonder?
>
> I think I'll just clarify this in the document. There may be a use
> case for keeping multiple large packs, but I don't see it (*). We can
> deal with it when it comes.

When the project's history grows too much, a large pack that holds
its first 10 years of stuff, together with another one that holds
its second 20 years of stuff, may both be larger than the threshold
and want to be kept.  If we pick only the largest one, we would
explode the other one and repack together with loose objects.

But realistically, those who would want to control the way in which
their repository is packed to such a degree are very likely to add
".keep" files to these two packfiles themselves, so the above would
probably not a concern.  Perhaps we shouldn't do the "automatically
pick the largest one and exclude from repacking" when there is a
packfile that is marked with ".keep"?

> The use of super large gc.bigBasePackThreshold to disable this keeping
> base pack is intended. But I can't go too high here it may break
> limits on 32 bit platforms. And 2g sounds really arbitrary.

You could use 42m instead to clarify that it really is an arbitrary
threshold that was chosen only for the purpose of this test perhaps?
;-)
