Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A5DC19F2A
	for <git@archiver.kernel.org>; Mon,  1 Aug 2022 14:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbiHAOmq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 10:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbiHAOmS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 10:42:18 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A793DF3C
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 07:41:47 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id i13so13996287edj.11
        for <git@vger.kernel.org>; Mon, 01 Aug 2022 07:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=UiRuUXy0kOuPleT1EwXPDlBhLyZ9ZaqfAvJH331ryXE=;
        b=M6tDyDKIZtNrvsftOF3pVUjbJET8DB52t9claCB4eKmQM+N/rpjr7Xq29nTsiSCnqu
         mSWz5qaWhnpSq6f+rDqsqECkUDZMlaq7bY9A+5yeDYxk5uoIf8KKu4g/LdlyXhI5Itic
         AknnTJAPCXbLVtuX//mpwfTUcII7acWjlx7Hht6yVGYcgCdabTmBZjUVJHrHaNGv2EDu
         ZuO0HlmnNvPRuTic/8fj+LvBVSxFsX0e/AEuJOZYwMlCNgw/v+B79/UjjIg6ggN+sqRJ
         3yN8sfzNIO7LfptV4dZBg4IJuym03U2XI2/vcFlcQU1A6IuIAssUOxaBAZFMMi7dJHcS
         iBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=UiRuUXy0kOuPleT1EwXPDlBhLyZ9ZaqfAvJH331ryXE=;
        b=rgUUtfcyiSMvPcVAiUb2zG8od5SLA8nLp5ZVwOnWrgZoNbh2sAr6SW1/tSXh48xHes
         D1wp6im4vW4v/XGNPqjFzZ35LD+qPuJ+gKxDcP00Aj/hd8bsDwuyyYQqmUjtf9X+riI0
         2+CvAicKvb+aUzSnG4lUqnS3w2gWbKdtdwdiY3sN/0eW247+Eb64H4AWOwqWKowdDSxM
         HzMUW1uZ/2j2QwaNdzIK4u+wlVWrx0c4xG2NVWsCWPmiXKykk8WKrzsQPKdR4HI8W4gT
         wNoh66uTyLs93l1WbjiCGHVcr+W9S4TkmgATQgenA3Lj53GcOCTWnpr2LNdV1J/lMLt7
         zGIw==
X-Gm-Message-State: ACgBeo1nlyl98dOyxCG8S/QsaxdEQd8soTP6fbbXPUgJggQD/sV4qs/F
        gg0chfWLc+1FsY4o03V8sM0=
X-Google-Smtp-Source: AA6agR51Zwiyj+DsE4YXtP0Nq1Qxpt8R+tscGPD3gM6ZoVxzldheRs3oopcwHyD5A5cM0+q7UQZgBA==
X-Received: by 2002:a05:6402:388b:b0:42b:5f20:c616 with SMTP id fd11-20020a056402388b00b0042b5f20c616mr1596413edb.50.1659364906029;
        Mon, 01 Aug 2022 07:41:46 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id f7-20020a056402068700b0043adc6552d6sm6862271edy.20.2022.08.01.07.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 07:41:45 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oIWc4-008xbs-2E;
        Mon, 01 Aug 2022 16:41:44 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        newren@gmail.com, dyroneteng@gmail.com, Johannes.Schindelin@gmx.de,
        szeder.dev@gmail.com, mjcheetham@outlook.com, steadmon@google.com
Subject: Re: [PATCH 1/5] remote-curl: add 'get' capability
Date:   Mon, 01 Aug 2022 16:39:34 +0200
References: <pull.1300.git.1658781277.gitgitgadget@gmail.com>
 <40808e92afb7bcf3e8e9b4b53d5e30b5e17816f8.1658781277.git.gitgitgadget@gmail.com>
 <220728.86a68ukvg6.gmgdl@evledraar.gmail.com>
 <71afa569-7071-466f-11af-3bbf856b4bef@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <71afa569-7071-466f-11af-3bbf856b4bef@github.com>
Message-ID: <220801.86zggogh5j.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Aug 01 2022, Derrick Stolee wrote:

> On 7/27/2022 7:00 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Mon, Jul 25 2022, Derrick Stolee via GitGitGadget wrote:
>>=20
>>> From: Derrick Stolee <derrickstolee@github.com>
>>> [...]
>>=20
>> Add a:
>>=20
>> 	TEST_PASSES_SANITIZE_LEAK=3Dtrue
>
> I trust this is important for your series that flags tests
> that _could_ pass with this. Thanks.

Not really, it does add a "check" mode, and this is one of the few tests
crop up when merged with "seen" if run in that mode, but currentlny it's
only run manually, and we have other outstanding deviations.

It's just something for "master": We have the "linux-leaks" job for a
while now, so it makes sense for new tests to declare if they're
leak-free or not, so we guard against the introduction of leaks with new
code, if possible.

I (or someone else) can always follow-up with something like[1], but as
it's easy it makes sense to just add it in the first place, thanks.

1. https://lore.kernel.org/git/patch-v3-13.15-28255ac3239-20220727T230800Z-=
avarab@gmail.com/
