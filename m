Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBA3C47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 16:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F347661362
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 16:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhFJQhU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 12:37:20 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:43827 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhFJQhS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 12:37:18 -0400
Received: by mail-ot1-f43.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso262653otu.10
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 09:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=8OPLPUnMPRRAB/ku9bLYB2ajHCxumhYR9dExhDjV9oo=;
        b=k1BrBikkmRUIgbqqKzF1atQdvGQ8POefHi9NnX2YfICGa66akhuD+p1MbltPp1o6bN
         pFqT9lcEK/HCgG9Ma1NoEXqB5vlRPUDm6qgCc3b0A+zTh79gSZtGsQ+/4aX1aPSIfDvH
         KB0wDxla7UYRJx36sh/mhF/aXP3qRlVrG65VaW9BEO7Yy93eIB14Vn9WwtyzXhWTfio5
         LxnE4c78a22vIRdTq6v6T0N2XQcgeRORTkOWQA6YC5k6VhsrmWNucYwNe2zIGEu8vQjl
         Wu99B3EUDHUR/NMzX/PwtVxMUUSlHmuwFPlwhVFb6Jh/5RZCNwU50WXFxfbibfOnKJ06
         7K/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=8OPLPUnMPRRAB/ku9bLYB2ajHCxumhYR9dExhDjV9oo=;
        b=Tz2HaEgh/lsCeR/XyVI8b+i7x6pYTOtq/9bQEsAWxaua9B8UwU7LqZYQ7u1CQCbU9d
         ZF2aQbYcRAZpqfSOea7fkWrUF8/relEzH2cOnSWPw71yeVAu8aaMf9SjuTpeGR4BoyJY
         djGnouCHyvtuyxxGMLMACGYogdu9wUzbUTJxYjwnjYabKnT7aCKbj5oHnDW/q9SUl3Gn
         ayjtgU6eR0Tq4DkBpjypbM1rmZEI7z56wEdgw3tgFyGgLdjk/82HUpEl3VY+y0fLpNgN
         1EO04Z6kgjQrkualSApn58DptoqcFcAZ/At4eHKXqQ2uXekxIT2jyivWCQCbpzgQog/H
         /Y5A==
X-Gm-Message-State: AOAM5303PBfwA40nfOnF9J1edbp64O5EBObYsJUqWa1pw0R/urynu0nh
        PGW/KcC4E7A5FW/rJJ+WDTU=
X-Google-Smtp-Source: ABdhPJwJv7pKo1BSU8F3AY3BAQn6YzaiLEByXpgnCeoBxone5wALMtHVVgDEeQfteQx7dFy57lVung==
X-Received: by 2002:a05:6830:181:: with SMTP id q1mr3262844ota.360.1623342848016;
        Thu, 10 Jun 2021 09:34:08 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id o2sm610657oom.26.2021.06.10.09.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 09:34:07 -0700 (PDT)
Date:   Thu, 10 Jun 2021 11:34:06 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Cc:     David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Denton Liu <liu.denton@gmail.com>
Message-ID: <60c23efe4405d_b25b1208e3@natae.notmuch>
In-Reply-To: <a819dd7d-e690-baa7-b6c8-2b1fabe51522@gmail.com>
References: <20210609192842.696646-1-felipe.contreras@gmail.com>
 <20210609192842.696646-2-felipe.contreras@gmail.com>
 <b2436790-bbf0-2623-5e29-a6f6b4959974@gmail.com>
 <60c2130178831_b25b1208f5@natae.notmuch>
 <a819dd7d-e690-baa7-b6c8-2b1fabe51522@gmail.com>
Subject: Re: [PATCH 1/7] test: add merge style config test
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood wrote:
> On 10/06/2021 14:26, Felipe Contreras wrote:
> > Phillip Wood wrote:
> >> There are already diff3 tests for checkout
> > 
> > This file is not doing diff3 tests.
> > 
> > 
> > As stated above, it's testing different *combinations* of
> > merge.conflictstyle, diff3 is only *one* of the possibilities, another
> > possibility is:
> > 
> >    git -c merge.conflictstyle=diff3 checkout -m --conflict=merge
> > 
> > That is *not* a diff3 test.
> 
> I think that is an artificial distinction, it is testing the behavior of 
> checkout when merge.conflictStyle=diff3

That is one of the things it's testing, it's not the only thing it's
testing, it's testing other things as well.

-- 
Felipe Contreras
