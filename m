Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498E9C47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 16:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29D2A613E7
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 16:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbhFJQuR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 12:50:17 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:38881 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbhFJQuQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 12:50:16 -0400
Received: by mail-oi1-f176.google.com with SMTP id z3so2788011oib.5
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 09:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=4/5vH52oW2/p51Dlbm5JKccBu14h39lzvgUXP0RelxY=;
        b=GqpcFu2uEB7R9agXjPJW88tc+qW/QPTVMEVuSu4my7FsXzX5X7bOZlit05LPiRmAbv
         bAH9S0anxDj8Zr0KX5SPfwng9FaAwaEQUoQfjN/Q0IiMqwQwLGBxC+xka8x6xMO2u6RK
         pf/BpEbFx5ln0AUmvZM28buPShMs0RkYKEGwcKnd5LIIE44DJqR63PiWJn2lCqFAdEEZ
         HdxcyVC9xo9hEPXYZtWHVu4RUiRF8a3JKf9iUsiB/Gf6bqUYC6J9qMfT/VOM0uoRGGMo
         D9Vnr4vNll4FFuUHjKoVP+vekT/Yr5Fe+ZSJ+VKPk6PcYQaD/0z723U1qFVvZAGoscIa
         C9xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=4/5vH52oW2/p51Dlbm5JKccBu14h39lzvgUXP0RelxY=;
        b=NMS9T4osSspt+slNLIa7MUiHkwXsV69dQcQD5ubk70z+ImKWz4bMDyDffBe9sNjpJV
         ehSqmkwIRvMsXfGzbrUa/IaipvM7SptidvhXyjmtvMDNRfVJmSp9HnTvY8bBL0Er40ed
         DSKBtw9aXuixkbMRnPqx50hHFroNVeOBzL5BViPJpdYJSLKkUAzZK/cHhJ+HzEAlGRSA
         a8NStzG606VACckcyz6zrKJPHJcbIK9ZyIoccgh0wvTVR5CO7mapPwfA/bngkx6uvC8H
         xDAir077P21pBw3oyTLt8JKcyDtddG/VIxt0Koewn7ZaLH0Jxu1an9mROXBclJKyNsW1
         wgUQ==
X-Gm-Message-State: AOAM530IgqnlRemMzbP/OJcP954glh1PaYnHyQW9m8TB1TRlnlrsNZaN
        Ca2pt4y/USjkxvOQRR9lAJg=
X-Google-Smtp-Source: ABdhPJy+ArZtXRtmU1fcMHcNpcSaMVeLN8ahxxRS63zI1azf+ckuwgaZy7qbAjCqoxwKPKbKt0MTFw==
X-Received: by 2002:aca:1210:: with SMTP id 16mr5223518ois.14.1623343627965;
        Thu, 10 Jun 2021 09:47:07 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id 102sm704018otf.37.2021.06.10.09.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 09:47:07 -0700 (PDT)
Date:   Thu, 10 Jun 2021 11:47:06 -0500
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
Message-ID: <60c2420a2dd73_b25b1208f1@natae.notmuch>
In-Reply-To: <bef8e373-20d8-3545-ba43-00108b2e77df@gmail.com>
References: <20210609192842.696646-1-felipe.contreras@gmail.com>
 <20210609192842.696646-2-felipe.contreras@gmail.com>
 <b2436790-bbf0-2623-5e29-a6f6b4959974@gmail.com>
 <60c2130178831_b25b1208f5@natae.notmuch>
 <bef8e373-20d8-3545-ba43-00108b2e77df@gmail.com>
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
> >> On 09/06/2021 20:28, Felipe Contreras wrote:
> >>> We want to test different combinations of merge.conflictstyle, and a new
> >>> file is the best place to do that.
> >>[...]
> >>> diff --git a/t/t6440-config-conflict-markers.sh b/t/t6440-config-conflict-markers.sh
> >>> new file mode 100755
> > 
> >>> +test_expect_success 'merge' '
> >>> +	test_create_repo merge &&
> >>> +	(
> >>> +		cd merge &&
> >>> +
> >>> +		fill 1 2 3 >content &&
> >>> +		git add content &&
> >>> +		git commit -m base &&
> >>> +
> >>> +		git checkout -b r &&
> >>> +		echo six >>content &&
> >>> +		git commit -a -m right &&
> >>> +
> >>> +		git checkout master &&
> >>> +		echo 7 >>content &&
> >>> +		git commit -a -m left &&
> >>> +
> >>> +		test_must_fail git merge r &&
> >>> +		! grep -E "\|+" content &&
> >>
> >> ! grep "|"  would be simpler and just as effective.
> > 
> > But that would fail if there's a "command1 | command2".
> 
> I don't understand. What are you expecting content to contain?

Not a sequence of |.

> Why doesn't "\|+" fail in that case?

It would, perhaps "\|\|+" would be better, or maybe "\|{2,}".

> >> This is quite a weak
> >> test, something like "^|||||| " would be a stronger test for conflict
> >> markers
> > 
> > But that doesn't work in all the tests.
> 
> So test for what you actually expect, you don't need to have the same 
> check in all the tests if the expected output is different.

I don't need to, but it makes the tests simpler, and as you pointed out
in another comment: more tests are needed.

Perhaps once we know exactly what we want to test, and how to fix the
current issues it would make sense to revisit these.

-- 
Felipe Contreras
