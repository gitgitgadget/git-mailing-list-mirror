Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC6DC433FE
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 12:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiDFMsW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 08:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiDFMrx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 08:47:53 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB40D44DCCC
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 02:01:41 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id l26so2904638ejx.1
        for <git@vger.kernel.org>; Wed, 06 Apr 2022 02:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=0lSYEp7e8yk2vVIuqOb7Imf/CaGiah/CFb95oBf7NH8=;
        b=Bqwv7vOH0es2J6e75tWjVBStuboKcQP/rPibWSApIAIrIz/e7+Yz0TunoJ/orH/bew
         k13x1kXORUcQ1g2btFbD4VmOnvmfo5elM9xeujKfiZVG7yntpQ5nnEquUvT83cIhvvgi
         XZ1TTfIWRXxzcHkXXXj+BMYrvxpwQGOsAjyoN/Z2I5KPg/akGNRIFbpHaLMuUSdkL8OC
         xCZO+GusEKgNSw1B9GPYZXIRyYs8j+jv27bKxlYenedVNEa/bNliLVOE4pI80ej/h6hz
         y+i2NaRHGqkEn4Uw6d4mVcRZl095D4d92k9JIbYX6fqI0fPEvNF0ZRMaeif/1Eyh61PD
         RpKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=0lSYEp7e8yk2vVIuqOb7Imf/CaGiah/CFb95oBf7NH8=;
        b=dvfzSCUvI4pL4EhTUnTl54MkDuEEym/ONriQdh5irn45LW1deIsaK9Aro16keTqHwC
         pMBVsYxvLo5LyHzWlfdHFZyYXJ85lYaHH8q+JwhkpwAw20vQPpHsWBd0KU/aKFFsA1f2
         D7uarpyF2HbmwCNywV2AB1s8RP2EDa7lI9DxLvcwQ5xh1VAxMR/fMpZkfGF6Bbt3agua
         x/CatttGN2JLZVatako547Dbskckj/Ilj+v0eE5IjH7ksq6ayQ7iXJEu+NL1VNdseYdu
         JqnLJIuMyvBAMdhokaai5hldMaHB5mZarCsn7TrS/Grp38MGat6Ek59MKRfCa1d5QPp9
         wJPg==
X-Gm-Message-State: AOAM531lspOstSRU71YHCrN0z9AnNOVlntLWcrGN0AxqasndhayTJg0E
        KJG5dLDmrvypWsARNLmFICE=
X-Google-Smtp-Source: ABdhPJy73Gi8cVANAUnNHbXEMWQHF6/Oa+u/qZ+g4B75FyGBjiBOkE5Om3TFlK+kVmZ6UBNtBSO+1g==
X-Received: by 2002:a17:906:a1c2:b0:6d6:d54d:4fb1 with SMTP id bx2-20020a170906a1c200b006d6d54d4fb1mr7571170ejb.490.1649235700316;
        Wed, 06 Apr 2022 02:01:40 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id p6-20020a170906614600b006e133d37f8bsm6352723ejl.138.2022.04.06.02.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 02:01:39 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nc1Xn-000aiO-54;
        Wed, 06 Apr 2022 11:01:39 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 4/4] builtin/stash: provide a way to import stashes
 from a ref
Date:   Wed, 06 Apr 2022 11:00:44 +0200
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
 <20220403182250.904933-1-sandals@crustytoothpaste.net>
 <20220403182250.904933-5-sandals@crustytoothpaste.net>
 <220404.86czhxjewx.gmgdl@evledraar.gmail.com>
 <YkwT6pwfC1d/PG4Q@camp.crustytoothpaste.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <YkwT6pwfC1d/PG4Q@camp.crustytoothpaste.net>
Message-ID: <220406.86k0c2egb0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 05 2022, brian m. carlson wrote:

>> This test has an implicit dependency on your earlier test and will break
>> if it's not defining stash0, e.g. if you use --run=N or use other skip
>> test features of test-lib.sh.
>> 
>> Just factor that into a setup function & have the rest call it?
>
> Yes, most of our tests have that problem.  I don't think it's worth
> changing the way we do things unless we plan to make a concerted effort
> to do that across the codebase and verify that in CI.
>
> If we really want to make that change across the codebase for the
> future, that's fine, but I haven't seen such a discussion on the list so
> far.

Fair enough.

I do think it's a good pattern when adding /new/ code to follow that
practice, even if it requires the first added test to have a "git reset
--hard" (in liue of fixing various tests above).

But not enough to quibbly about it here :) Thanks.
