Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C2DC433FE
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 18:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234375AbiKVSIL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 13:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234470AbiKVSH7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 13:07:59 -0500
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748EA165B1
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 10:07:48 -0800 (PST)
Received: by mail-pl1-f182.google.com with SMTP id g10so14405726plo.11
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 10:07:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P1Umb1CkuafzQm8w6snp/aVTrYQW3mWGj/UR0DEyDJw=;
        b=V03RpahPBK+S+3GNJ13PgIQT2tlg0XirFizEfpfgnR5p9yJKvx8dtUAV8OMLgUpVNB
         Wc1uw9+rDQ8BXfjkDP4RdAkZXaQUCIPy+tozw6yvUlwZzeks3cgJXpUmxuXZnfa5duPb
         YpgjvpBURpWJ/0Kj5kVPEjcmvTQlUP72N6mL0OJPRBQeWlep7iIdU2nKCfmUzNh8lBPX
         YuKC6YM0/i+5huo7Nej7grXQ3PquQfsABR6qrwlmv6KghlANuiR2OF2j1xcH68AVe3RZ
         hgj//eDap7EKONQzhqFopcBwELSIi6ZAIoRzMCeqMI8myKUlZDZHW9wRlzBZCGl5M/tt
         O9AQ==
X-Gm-Message-State: ANoB5pnmhpJ4ja+GESh1N6kCG3JvU5MtZ/BxG0LePSsxgsDDOoZzMoii
        8B95F5pDBNE5OK10t5+KKeMeY/QjcB6/hnZkikEnFZH5Xbc=
X-Google-Smtp-Source: AA0mqf7esKwodfneNgdFkFUQNjkVwPnw+kGgrmyOHEzwaKryO8UTUs97g057SzG8HWNgl/Fag25GPbdlN9hJmroC0tI=
X-Received: by 2002:a17:90a:5d81:b0:212:cf2e:2b0b with SMTP id
 t1-20020a17090a5d8100b00212cf2e2b0bmr32777867pji.169.1669140467534; Tue, 22
 Nov 2022 10:07:47 -0800 (PST)
MIME-Version: 1.0
References: <pull.1384.v5.git.1668110679098.gitgitgadget@gmail.com>
 <pull.1384.v6.git.1668547188070.gitgitgadget@gmail.com> <CAPig+cRPQ7bmG6+U+oQGGUFiSiHoMMpMk8FDJ7GMJvwCXifa9g@mail.gmail.com>
 <CANaDLWJM1VRivm8VLqxg+w8K-+49E0km6AgOzWzN9X=TgzaEiA@mail.gmail.com>
 <CAPig+cQgu=i6pZTzoNYGZ_6X=DGdmwa=dPhSQVqD+eLCZCGJSg@mail.gmail.com>
 <CANaDLWJ+Suye98QKub9nfnknLEsyQ4PK1LxDkPmzGC_-hApkFw@mail.gmail.com>
 <CAPig+cTrpnVOW0Y2m5xtPhLudY=rPCn3qPQA0RSso7ueFytZbQ@mail.gmail.com> <CAPig+cQF8vjGNUux-ZMBRxbEd3V0p27oLWZ7k2=mf40kAkWVeg@mail.gmail.com>
In-Reply-To: <CAPig+cQF8vjGNUux-ZMBRxbEd3V0p27oLWZ7k2=mf40kAkWVeg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 22 Nov 2022 13:07:36 -0500
Message-ID: <CAPig+cSR0MAYRLtPS1YcegqMZn4FDbdRvbCbuDfXWR=wF_ofGw@mail.gmail.com>
Subject: Re: [PATCH v6] status: long status advice adapted to recent capabilities
To:     Rudy Rigot <rudy.rigot@gmail.com>
Cc:     Rudy Rigot via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 22, 2022 at 12:40 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> A minor additional comment if you do go this route and place the new
> tests in an existing script...

And one more comment...

By placing:

    GIT_TEST_UF_DELAY_WARNING=1
    export GIT_TEST_UF_DELAY_WARNING

at the top of the existing script into which you add the new tests, we
have to worry about potential side-effects in other tests in the
scripts. Better would be to place these lines just above the new
tests, so that the effects are better isolated. However, even better
than that would be to isolate the environment variable to exactly the
point it is needed. For instance:

    test_expect_success 'when core.untrackedCache and fsmonitor are unset' '
       test_unconfig core.untrackedCache &&
       test_unconfig core.fsmonitor &&
       GIT_TEST_UF_DELAY_WARNING=1 git status >out &&
       ...
    '
