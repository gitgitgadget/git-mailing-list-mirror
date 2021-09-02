Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E78FC432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 15:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02F87610A2
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 15:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345700AbhIBPGU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 11:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234984AbhIBPGS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 11:06:18 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D41FC061575
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 08:05:20 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id jg16so1979388ejc.1
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 08:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=u4bH7MlfGWSrh7Czy2C+Zj58+v3eqj5ZCKxz2m5Jq80=;
        b=CuZZRQ6f6MrGQEINtLXAOl30CNUFgyF54ghGIxdqStMAbLxshNSiLPttt57oHBl4R9
         TPLp0gjkjL4nA7SA/QABBP59IaCPHtxeGUBYHnRRjAUZvgZp3tUzAasGzwV2iTJeu2Fi
         9APOC+p2ahwm36CHV/LaGDYxq1WhUZ3Qn5GjNVnVKSph08Y5RMXJ5gaWCr+7POEsRi9A
         gbvLcGuTYT2EVnC8fcapAe7H3lPnTOZGQSChkQRfn1kRFZe2mIlf5Vhw0EYd1/fJnkvZ
         9MzqU/XoX0XVlpBSmmEiNcd6m49ho15wz/xYbOibEIPj0Ibx0UV9zV/MPFKUWDGnkNhT
         eQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=u4bH7MlfGWSrh7Czy2C+Zj58+v3eqj5ZCKxz2m5Jq80=;
        b=GyZ9ncte2rhSWlgTUYw0Pin3KKrUyFIt5qQln4J9xKZtMOLwGF+whXGPiO0lC43b0o
         U2/MuVHSIwBs4rLT5tJgaxHT/bW4hmBYTC1o2M3J2aZnGNxkDJfdu2fc8X0IFX0yWVmw
         nJbw0p6xKCuEnn906mbH28DBRqDSd9B348/9WNqsBeB+lpIZhRJecMAoQlzHZSyrFIYX
         IR+VBSiy/lsxdHez0CY2WWabJjq/xpvrMKw3cTrIXYRR+SZRuRizpgY1s7yXuTeHhRsX
         7ZoWmVmsBSFYq+tuSFIPzOzLFqi1c5rZr8IX1eX0AOJeOAt0w3pTgC3E1sQYhui7Bjzf
         Z+0Q==
X-Gm-Message-State: AOAM531X1dv2uPN7UApz18kcmtBu2ab3ysYtW+fevfizaqtdwTXdGr7c
        5VXAMrqcYSfSlGEp1oT2O4w=
X-Google-Smtp-Source: ABdhPJxQ/FDl66/1rgPl4Lw8G18JlG13N39CLidEml54gufHNyC2zZowyeuW6j1BvOm+x6Mc62nSJA==
X-Received: by 2002:a17:906:16c4:: with SMTP id t4mr4264930ejd.302.1630595118345;
        Thu, 02 Sep 2021 08:05:18 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id dy7sm1353349edb.38.2021.09.02.08.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 08:05:17 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 5/7] rebase: drop support for `--preserve-merges`
Date:   Thu, 02 Sep 2021 16:56:18 +0200
References: <pull.195.git.1574542242.gitgitgadget@gmail.com>
 <pull.195.v2.git.1630497435.gitgitgadget@gmail.com>
 <eb738b1bf05dceb1d119e3adcd732d968407c757.1630497435.git.gitgitgadget@gmail.com>
 <87lf4f9gre.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <87lf4f9gre.fsf@evledraar.gmail.com>
Message-ID: <87czpr9fwz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 02 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Wed, Sep 01 2021, Johannes Schindelin via GitGitGadget wrote:
>
>>  git-rebase--preserve-merges.sh | 1057 --------------------------------
>
> You could, but certainly don't have to, squash in the below. I.e. this
> is the last user of eval_ngettext!

Also get_author_ident_from_commit() in git-sh-setup.sh and
Documentation/git-sh-setup.txt can be removed,
git-rebase--preserve-merges.sh is the last user of it.

I looked over the other git-sh-setup functions, it seems that's the only
one that could be removed along with git-rebase--preserve-merges.sh.
