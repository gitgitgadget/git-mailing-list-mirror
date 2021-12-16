Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078C4C433F5
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 20:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbhLPUKX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 15:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbhLPUKX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 15:10:23 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B75C061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 12:10:22 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id e3so92160475edu.4
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 12:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=00LjONyr8MsJp5hC3B3Huns5oSvd/xaQXqm1Q3Pa23s=;
        b=YY7DRJJssdBSr09RJAJkYru9tVOHdoDeRMtaaWZHpRROniM9dauasq3q6/r/LSgw01
         TE0XFYNz3hUY+wh34opxeqVAiMSm4nFM1tlY9XzHU4373kuPT+NK840fjrk+gaG6nuIX
         93+YZtQQ313AmSoUPlO54FUIRdC9zqwl/VaTRFxP63BemDI6yUqcopByxYlWMoaFZCgh
         mQzKaxBqFRhbekcroM5bmkO3qL2IdhEAHNNIggYN/Y+eak4ghPe27Ul54RtuDsPDU8c0
         wbFH9R5Ww7ehiqWPHUu+CezUvmzTftsm8I4etCTwvkc8tpHltzxo1jmGzJBcoRV16fzm
         /A3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=00LjONyr8MsJp5hC3B3Huns5oSvd/xaQXqm1Q3Pa23s=;
        b=hXKFVXSVu7X7wgPQjckDRiK/RHJ9B3agxbS//SgM4WntJ+xvc6fu3Y7GNanf34pB3w
         ToG0TcOICPaJuJpqjVZg146zNbrWUnJE2wS0dBxzUxTRCOHPvgzf4n6iS/YYpNh+YAVN
         qvrskea/E66+6m5MTLoKsY6U/rZYp1E7Am5MbiScS9n6oiYj0K8R8lhECzY4Ngt/XiDr
         ovm7C1SIceiP2eKIeWLkY9plZOp1VonIGYGgkff7Tx4pjwBPGP0UecwR+mej7vUMZfrJ
         OFdW8hAhHL/ZE3kvg2RL0p7xjAuJVLenTSK6l+xMszfY9An2bca6FRepsbFc8TwISYIn
         XKHA==
X-Gm-Message-State: AOAM530KDTIlwnAiNDx0vUuPFAMDFaowQnRoQQi1s9YgvebDQhox3K1W
        KaXcAD89D2Y2VLMbigosBqk=
X-Google-Smtp-Source: ABdhPJyZG5+EUAutVKLPN73JQVFoHbkrFCw8g3FwCPvS9ixy/6xErs6V1ZGqMCyYd4ITBomnapWRyw==
X-Received: by 2002:a17:906:c155:: with SMTP id dp21mr17090886ejc.450.1639685421210;
        Thu, 16 Dec 2021 12:10:21 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id oz31sm2160938ejc.35.2021.12.16.12.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 12:10:20 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mxx51-000ZU9-OO;
        Thu, 16 Dec 2021 21:10:19 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Fabian Stelzer <fs@gigacodes.de>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 05/15] t/Makefile: optimize chainlint self-test
Date:   Thu, 16 Dec 2021 20:26:12 +0100
References: <20211213063059.19424-1-sunshine@sunshineco.com>
 <20211213063059.19424-6-sunshine@sunshineco.com>
 <20211213102224.y5psbojmivlxe5px@fs>
 <CAPig+cSKn6wdPKc=b8Xjqy5D=bVdu6FQtYKJuwN2VoV7pEEgHw@mail.gmail.com>
 <20211213154327.pmhopjbdlkz7dgjh@fs>
 <211216.86zgp0adls.gmgdl@evledraar.gmail.com>
 <CAPig+cT_38g51RtcMAf184jjB3Zr67gv=rO0oEY1DG7asnyUJg@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CAPig+cT_38g51RtcMAf184jjB3Zr67gv=rO0oEY1DG7asnyUJg@mail.gmail.com>
Message-ID: <211216.86r1ac9uqc.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 16 2021, Eric Sunshine wrote:

> On Thu, Dec 16, 2021 at 8:22 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> > On 13.12.2021 09:27, Eric Sunshine wrote:
>> >>It's not seen in the patch context, but earlier in the file we have:
>> >>
>> >>    CHAINLINTTESTS =3D $(sort $(...,$(wildcard chainlint/*.test)))
>> >>
>> >>which provides stability via `sort`, thus ensures that the order of
>> >>the ".test" and ".expect" match.
>> >>
>> >>I think that addresses your concern (unless I misunderstand your obser=
vation).
>>
>> But just FWIW I think both of you are wrong about the potenital for a
>> ".test" and ".expect" bug here.
>>
>> I.e. yes the CHAINLINTTESTS variable is sorted:
>>
>> But in Eric's patch we just have this relevant to this concern of
>> (paraphrased) "would it not be sorted break it?":
>>
>>         +       sed -e '/^# LINT: /d' $(patsubst %,chainlint/%.test,$(CH=
AINLINTTESTS)) >'$(CHAINLINTTMP_SQ)'/tests && \
>>         +       cat $(patsubst %,chainlint/%.expect,$(CHAINLINTTESTS)) >=
'$(CHAINLINTTMP_SQ)'/expect && \
>>
>> So it doesn't matter if it's sorted our not.
>>
>> I.e. we've got {A,B,C}.{test,expect} files in a directory, and we're
>> constructing a "A.test" and "A.expect" via "$(patsubst)".
>>
>> So if it's "A B C", "C B A", "A C B" etc. won't matter. We'll always get
>> ".test" files corresponding to ".expect".
>
> Yes, sorry, I meant to say something along these lines in my reply, in
> addition to mentioning `sort`, but forgot. Taking a look at this
> again, though, makes me wonder if the CHAINLINTTESTS assignment should
> be done with `:=3D` rather than `=3D` (unless GNU make is smart enough to
> only invoke the `wildcard` operation only once, in which case it
> wouldn't particularly matter).

It appears to be smart enough to do that, i.e. it'll invoke a $(shell)
assignment N times for -jN unless you use simply-expanded variables, but
not for a simple wildcard.

But I really don't think that'll matter, doing that I/O is trivial
compared to other things involved there.

If for some weird reson (e.g. hundreds of thousands of dependency files)
you find yourself trying to optimize make runs on this basis, this is
the wrong way to go about it.

Instead you'd have a rule depending on the contain directory, whose
mtime will be updated should anything there change. You shouldn't need
that trickery for anything the size of the git codebase, but that
approach will beat trying to optimize the O(n) lstat() calls you'll
otherwise be doing on the contents of the directory.
