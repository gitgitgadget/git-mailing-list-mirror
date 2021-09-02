Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EE2C432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 15:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9146A61074
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 15:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345731AbhIBPgq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 11:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234465AbhIBPgp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 11:36:45 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F71C061575
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 08:35:46 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id jg16so2213282ejc.1
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 08:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=J+fEEJctmzc/+/WwZLNMZ6kqb0JPyNJf4lJqavhRbgI=;
        b=AYzb+2Ls1CRfyMbYnWhVF4KjPLAqvi+wJ6W+BEAyh/0KIP0L9VJerP9pZsJWD/6ofc
         iOCuykqObaoC9MY5TThqJ8xbvQ4mb7KlyVZYz9rB4Rwpzv4/FHW1yOgmu2dBnmXRTmFP
         SfkgqaC6wqib4Kq4f12A2+jtbO+8TeocCJ5fRsovr09aXo7rxumgbvJmWm2wGJFbehrX
         BJ/KT9GTXMg4/eRgxWYkmPdNRjHLdD1iphIdrwIBl0BdOvHldTofJLW/D2EYhdG/P+n5
         7w9b/LZRJwtsy1t82BrM/ZB7Gl+s3vQHP3I39e11gNDmF3Ec/6JyU+EDgpL+2PW8oXlk
         F13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=J+fEEJctmzc/+/WwZLNMZ6kqb0JPyNJf4lJqavhRbgI=;
        b=b+NbOFrYMCM22nk32QUiZ4Meww620fZ+BfQKYSL1MVQGMI8TtTGFrM2/TxDRLks2UB
         WRCPQt3Ck6b+Ylis9aZYCo+wWQYVUOhnq3h2demqgJsFgMYgGWvvHyqF0iHLn07P93fD
         WHBwuIIT4RgAuKpL0eQJmNynVDX3WF3y8asrM4cfZf/uQYINGk6IhEZ1hAhzMTT5vG34
         ZOIRTrfJti7a0QKmB+ezHbKLrzLxnDRhPD3D+KslzGq3N4Qx0Kb14u0tRxtZBBZ8U+9r
         K45LJ48DIirXxgYmRQ+3wA5s3aSOqcIt6ad4uAhHGrjMeObc+CU4MxP75VKiq+aQ3hwm
         mjnQ==
X-Gm-Message-State: AOAM530el5Im+B+Gq3zuBXRwemxOYiJEry4ToVaOXMxTFWEX9/Q57gFe
        /ThzG13ovc47RQ9qV27p9x0=
X-Google-Smtp-Source: ABdhPJxtK/wVNc9DFxQxDSlH46LcSSMz7ZYGrE0T/0WALQN0rX24MR0HCNvJfTXRRkUamunZFbBx8A==
X-Received: by 2002:a17:907:2d8b:: with SMTP id gt11mr4509989ejc.432.1630596945189;
        Thu, 02 Sep 2021 08:35:45 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id m23sm1353119eje.105.2021.09.02.08.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 08:35:44 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 5/7] rebase: drop support for `--preserve-merges`
Date:   Thu, 02 Sep 2021 17:34:56 +0200
References: <pull.195.git.1574542242.gitgitgadget@gmail.com>
 <pull.195.v2.git.1630497435.gitgitgadget@gmail.com>
 <eb738b1bf05dceb1d119e3adcd732d968407c757.1630497435.git.gitgitgadget@gmail.com>
 <87lf4f9gre.fsf@evledraar.gmail.com> <87czpr9fwz.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <87czpr9fwz.fsf@evledraar.gmail.com>
Message-ID: <878s0f9ei8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 02 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Thu, Sep 02 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> On Wed, Sep 01 2021, Johannes Schindelin via GitGitGadget wrote:
>>
>>>  git-rebase--preserve-merges.sh | 1057 --------------------------------
>>
>> You could, but certainly don't have to, squash in the below. I.e. this
>> is the last user of eval_ngettext!
>
> Also get_author_ident_from_commit() in git-sh-setup.sh and
> Documentation/git-sh-setup.txt can be removed,
> git-rebase--preserve-merges.sh is the last user of it.
>
> I looked over the other git-sh-setup functions, it seems that's the only
> one that could be removed along with git-rebase--preserve-merges.sh.

Although with git-rebase--preserve-merges.sh gone the
get_author_ident_from_commit(), parse_ident_from_commit() and
pick_ident_script() can all be moved to its last user:
git-filter-branch.sh
