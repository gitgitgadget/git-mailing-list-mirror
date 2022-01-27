Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A51C433F5
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 02:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235101AbiA0CqU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 21:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiA0CqT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 21:46:19 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEDDC06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 18:46:19 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id r10so1738075edt.1
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 18:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=CazJWSRtS81hfniu/U7IHqOcVsyDD2N3q9nFp7HZS1c=;
        b=dyXFF30GS/0R1APiDRtDIdIjCvEEL/6p6B6voERbF0TzRdg/fVSR2zPhvruEjwn0//
         wuNmL5tMklrBE9BYp+x8mFxe290itQkLFonjP2OF1h2dJIUgvLMyUb8KPgz0HYO/FKep
         AMmiA3AjTLTWG98rFNnaElTFPQ4got83pchiNywGPZLsrNa04vuqHVo6Gqjo0aiwaUXL
         19bLIDwJ8v4sGZUWd1IPf+h5St2rY2mlRjFCp22VcFvjojeB8EiwTSgkqQJ89ll1UXD5
         VMtpTtER0+LEzBQ70JaIIeMhbCnMtA2SNU6tBfdaBw8Pukc0cS8IzYZ9C+Jw+1BMDVBl
         RjxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=CazJWSRtS81hfniu/U7IHqOcVsyDD2N3q9nFp7HZS1c=;
        b=Hk87uIU0RD3AlhIA26c/Xe2Pj4mBNKNk6jRUhDq/1y0orUd3LtQx2OFH19D01ot0Dl
         IBBRWMS33D+vnh+xqV6/dAtCA8549EeFywpV0VztlXq1P6bFC7UHfuuzBvBnAbJeUoE2
         GBkcuQJHJbfzxpx1rcEu9vmAFKLs6CJ7prSKeqUlSYmLb6S7L05Z3qi4HCgfPemQw9+l
         zDllDas1xfRRfu2gkvmMwKBh7DClJWbvFXTowNSIV7XbiB94F66+j3x7db3T1QpgRFGv
         2LDwv/iDdIBvlwAmW8f/UvwCe/8Y+MQ4WGwzjtZVjK4aUvgTx+fNBxUTyDVmDpWg2mof
         qBow==
X-Gm-Message-State: AOAM533b9HZyffy7xfaDcC2Dpam07vzzdeL7CFRG8T+hUdMao8OskCaT
        sIn3+CKsT4w9IDa1mdI9/yg=
X-Google-Smtp-Source: ABdhPJxZzesRo88mu/FP0bzAWJV1lUpFTJA+hRBTGE7F9ePnfGtKBMgKS3NldMs1dewaiWGPM5gAYA==
X-Received: by 2002:a05:6402:280f:: with SMTP id h15mr1697594ede.113.1643251576844;
        Wed, 26 Jan 2022 18:46:16 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id dk3sm10512234edb.33.2022.01.26.18.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 18:46:16 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nCune-003Fo6-TV;
        Thu, 27 Jan 2022 03:46:14 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Yuri <yuri@rawbw.com>, Git Mailing List <git@vger.kernel.org>
Subject: Re: 'git stash push' isn't atomic when Ctrl-C is pressed
Date:   Thu, 27 Jan 2022 03:36:21 +0100
References: <4493bcea-c7dd-da0a-e811-83044b3a1cac@tsoft.com>
 <220126.86bkzyfw3q.gmgdl@evledraar.gmail.com> <xmqqlez2qnfi.fsf@gitster.g>
 <220126.864k5qdx66.gmgdl@evledraar.gmail.com> <xmqqczkeozpx.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqczkeozpx.fsf@gitster.g>
Message-ID: <220127.86zgnhdhft.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 26 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> I understood this problem as being one where we do the ref work first,
>> which we could start a transaction for, the user then ctrl+c's after the
>> ref work is done, but before the working tree is updated.
>
> If the process is killed while the working tree is half updated,
> nothing you do with ref transaction will help.

This thread is about Ctrl+C, i.e. SIGINT, but presumably we'd use
sigchain_push_common() which covers that and various other signals.

Of course if you're talking about SIGKILL all bets are off.

>>> I suspect that the untold thinking behind your statement was that we
>>> should try not to discourage new users from asking, and I agree with
>>> the sentiment to a certain degree.  But at the same time, I think it
>>> is simply irresponsible to do so without distinguising between
>>> asking for something realistic and unrealistic.
>>
>> I must admit I'm not deeply familiar with builtin/stash.c in particular,
>
> Then you can try to be on the conservative side, perhaps, to avoid
> misleading less experienced folks next time?  Thanks.

I meant I'm not too familiar with details of how "git stash" interacts
with the working tree etc., which is part of what you brought up in your
reply.

But I was mainly commenting on what I think is a fairly straightforward
way to address the original report of wanting references rolled back on
SIGINT, i.e. to move it to the reference transaction API, and to have it
roll back changes in certain scenarios.

Of course it's possible that I'm just missing something, do you see a
reason for why having a signal handler be responsible for rolling back a
reference transaction wouldn't work?
