Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B39C4332F
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 21:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14992611C1
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 21:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236554AbhJEVw1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 17:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233576AbhJEVwZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 17:52:25 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A68C061749
        for <git@vger.kernel.org>; Tue,  5 Oct 2021 14:50:34 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id x7so2033457edd.6
        for <git@vger.kernel.org>; Tue, 05 Oct 2021 14:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=5V+aDsZNNIUq7nwX883p6pKtWO19uV+oeEH6ObJOwBM=;
        b=KqJLHVz+209gipE6+TMMFY2SPs4UTi4YmsVt0CwhTKIK4Ghenh7IOSqcBOKGMvgKzd
         uuAsOfXqBvR6zA5FLaZVsoNeqp+u0+pmkr2Tyu80b2F63dfHEqFO/d+QaBOuY3G/QyEG
         qC3E6jb4BNJ7r5KqbEgIpS62eyC0cA/JrL1lFhZu23gGyIpBcstsZmHa6BrFRdlqylTe
         AEZC7NXsssaqfoFit5tbec/hkP1bZoIng6mfBfwfiUGESbNShQC/rvuloVVqh+htBDfN
         fSY0LGHmPR88/2grOFQpXDOXYMzORhIutY6oExN0nxzGtVeW8vFoUI89Ts2Q7qfBEbBo
         IklA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=5V+aDsZNNIUq7nwX883p6pKtWO19uV+oeEH6ObJOwBM=;
        b=r/bNC80KCm/Yi1Bxn5JIwJbSBSm39T6HdykBpWscXjTwsEuPd+HvOE+qep2amvcQr7
         q3dJj7X7HhliItarxP56161UNyj3pYpuvVUf2SLkpwggJt1GisXb2wmvkoIpeqdVLwMC
         elan4VnTmc2HTNgmVTIE4vn/HVsNMAD7QgTxAKtoYvj3tTgH7oqQLms6NxWHwpufgMbd
         ViGSgtICXV0965GbzHvfIhOc+biP91GRrjg2mRSbeYUmLHICEjbmTERBpSB4Zg4a3WIy
         o3j0ygDPL0mNIo7Zub89y6lm9ClYGikarqRmfKTNNoiDbFjIMNGjapvHZsNHJsnMeOpO
         itVQ==
X-Gm-Message-State: AOAM530bMswvgZFIo8zQStaOGBgdMbmIC5Etm1tAC+SSZ42cEasSX4EC
        FvXiFFx0Q8RqwDE/cqrhqHafgvka5nvGNw==
X-Google-Smtp-Source: ABdhPJyDmnYbd3HxSAqv8rBew92maKNODANfuBZUu5ZMV9Xygk5wngXNJoRhb1xePEvaPagILlI9Ig==
X-Received: by 2002:a17:907:6283:: with SMTP id nd3mr26141722ejc.362.1633470633124;
        Tue, 05 Oct 2021 14:50:33 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id i2sm9242794edu.48.2021.10.05.14.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 14:50:32 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: p2000 failure due to empty reflog
Date:   Tue, 05 Oct 2021 23:38:09 +0200
References: <b25ac1cc-8e77-17e6-602a-b289c1e1cfeb@web.de>
 <30df5e39-3f2a-00d8-541b-347c43f36b38@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <30df5e39-3f2a-00d8-541b-347c43f36b38@gmail.com>
Message-ID: <8735pfjg47.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 04 2021, Derrick Stolee wrote:

> On 10/2/2021 1:37 PM, Ren=C3=A9 Scharfe wrote:
>> p2000 fails for me and reports:
>>=20
>>    perf 18 - git checkout -f - (full-v3):
>>    running:
>>    			(
>>    				cd full-v3 &&
>>    				echo >>f2/f4/a &&
>>    				git checkout -f -
>>    			)
>>=20
>>    error: pathspec '-' did not match any file(s) known to git
>>=20
>> checkout fails because the reflog is empty, so the "-" can't be
>> resolved.  The pathspec error message is confusing, though.
>>=20
>> The patch below adds a reflog entry and allows the script to
>> succeed.
>>=20
>> Before the "test_perf_on_all git commit -a -m A", there are two
>> reflog entries in each of the five clones, after it there are
>> none.  How is that even possible?
>
> That is certainly confusing. Is there something about your global
> (or local to your test repo) GC settings that cause an auto-GC to
> prune the reflog aggressively?

Perhaps something to do with certain parts of the code doing a
time(NULL), and other parts faking up times to be 2005-something?

I have some WIP patches that run concurrent "git gc --auto" with a
detach across the whole test suite, and IIRC I had to search/replace all
time(NULL) with my own time() that faked up (looks it up) an epoch of
1113465166 to avoid this exact issue.

If you try doing that across our tests I think you'll find that the
@{-1} syntax (reflog-powered) will start failing.

But that's from vague memory, but perhaps it'll point you in the right
direction...
