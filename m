Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_SBL,URIBL_SBL_A shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89FC71F462
	for <e@80x24.org>; Wed, 19 Jun 2019 06:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730996AbfFSGkX (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 02:40:23 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35019 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfFSGkW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 02:40:22 -0400
Received: by mail-wr1-f68.google.com with SMTP id m3so2025203wrv.2
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 23:40:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w626cbxxSfxtBC/yLFNYWlfcmMLlDD5Gg7vY9fwK/GI=;
        b=CiE1Oi/YBMyc6tvfTcWQ7P+50KOVY4mY6UH/3kGdhikrk1f/XbuhoVHB/nTDKR/tMe
         WHQqx9fe/npob78WFr99Pf81EiOyUIgsvZaxA/SnhIuHexiH3MOJ5qhMSDyvNnYaL22G
         2Q6ZCMlNT7+GQzflCdvfgbPwKs91rkm25p4hC0ZRNJ2TNPj1t5Ks2lgQbMaWrf6yrXXq
         +xCrqsSNhfkkMmPpxfF7hwdz7gckdkYHcyLCO6i70nmCiU5cQMGbiTj+ldLYiPr2l7UU
         PxS2Ziw5yqIz0IQ03DipfPrvJQt6KP1Ouz3wCv3dWKzojnYFUahdfChx5AnZ+jJOE7qg
         85Dw==
X-Gm-Message-State: APjAAAXRVgqJXuj8+lZ7AEQu8qt/eoiRwfsBd8j0rFiGPgiTnRoeWbua
        sk8yJt+cgQCAGR39rYYrndAGwWSrf3tOaIMFCCw=
X-Google-Smtp-Source: APXvYqwJs8tyjpDorZr9C1uSV92yCYJJMNoeQQg65BahZEdmu/UXzXF1Zutus52vRMTpA4U5ChNpAufrjR0CISWIX58=
X-Received: by 2002:adf:8b83:: with SMTP id o3mr79682844wra.278.1560926420530;
 Tue, 18 Jun 2019 23:40:20 -0700 (PDT)
MIME-Version: 1.0
References: <pull.149.git.gitgitgadget@gmail.com> <d551cdeafbf2953ba340aa16554fbd5ac6194a6e.1560860634.git.gitgitgadget@gmail.com>
 <CAPig+cQaoRBnH0JrUwXTo1hSwjrZ1vJHewjCAkKPeCrRwo=P2w@mail.gmail.com> <40cfbb30-c632-54da-62d9-9b31bc878806@kdbg.org>
In-Reply-To: <40cfbb30-c632-54da-62d9-9b31bc878806@kdbg.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 19 Jun 2019 02:40:09 -0400
Message-ID: <CAPig+cTTAgYia6DUOrg7AuLmGSbqn5u=iy3wx-=--NJuyULwaQ@mail.gmail.com>
Subject: Re: [PATCH 02/17] t0001 (mingw): do not expect a specific order of stdout/stderr
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 19, 2019 at 2:19 AM Johannes Sixt <j6t@kdbg.org> wrote:
> Am 19.06.19 um 01:12 schrieb Eric Sunshine:
> > On Tue, Jun 18, 2019 at 8:24 AM Johannes Schindelin via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >>         printf ".git\nfatal: Needed a single revision\n" >expect &&
> >> -       test_cmp expect output.txt
> >> +       sort <output.txt >output.sorted &&
> >> +       test_cmp expect output.sorted
> >
> > It was quite surprising to see this sorting only 'output' but not
> > 'expect'. I see now that 'output' is already "sorted" (in that sense),
> > but it feels fragile. More robust would be to sort 'expect' as well:
> >
> >     printf ".git\nfatal: Needed a single revision\n" | sort >expect &&
>
> Following Dscho's recent objection elsewhere that tests tend to check
> for much more than regressions, wouldn't it be logical to write these as
>
>         grep -F .git" output.txt &&
>         test_i18n_grep "Needed a single rev" output.txt
>
> without an 'expect' file at all?

I considered suggesting that, as well, as being more obvious and less
fragile (with the exception that "Needed a single rev" isn't currently
localizable in builtin/rev-parse.c, so plain 'grep' instead of
'test_i18n_grep').
