Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4D1C4708C
	for <git@archiver.kernel.org>; Fri, 28 May 2021 21:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D081B613B6
	for <git@archiver.kernel.org>; Fri, 28 May 2021 21:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbhE1Vac (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 17:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhE1Vab (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 17:30:31 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16EDC061574
        for <git@vger.kernel.org>; Fri, 28 May 2021 14:28:56 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id z3so5597691oib.5
        for <git@vger.kernel.org>; Fri, 28 May 2021 14:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=onAiML4bHE/H/x3Msh+4oYeUFNleWwHQOa/rwhkTf8w=;
        b=IrTg4HyEHWctA5fVRjOAGmE9SFRQqg9jpj31ggWv2wBCKPvbL/urKkyvtzJzbzBnuh
         CvuFocxpds3hBf4SlEJMsNB0tUXWtks0rc39NJFbkrPZ6r9620zgC9uN6cf6yygJQfr6
         916msMfpXYnkgKJ1WTmj2uO7sMOSrfxzEUBpDPqQFYoU/5lHbP1dHa/gJGYHn7u1WVrr
         8ndh4sexxOcg+LuCgEHx8U0Qws/p6xT/TUsMyJR79nvzChLFXnk56YaFew/CXwFE2aG4
         vFG9XUEMPIo8V7+yHaI0aDWECeFKff15GwvrYK9salSRZ0Y0ZVDqx/zZnugo60XCy2tJ
         E30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=onAiML4bHE/H/x3Msh+4oYeUFNleWwHQOa/rwhkTf8w=;
        b=fhqpOfX+3ud9G7XO3qUqn27IP0s0HsycSx9QEVwgDyXiD5jp7jwHgU/E4AqeYAv+LS
         feG4C8+RMZxVJvl14z9poxd8neSzVc3rS7eNPAuPyviZg/oh2P7VKMrrYWp4MtsN8928
         g+tk3GzDprRGIDoXeg849fHzC1gd47RM/h1Zmi1isg1s7FrYlmWgHvYAxnaMFeeo/7Vx
         ps0EG1msziHcMwYwX/elNkYD378P0aI1/X1FCFwJhRyUo7zqZnUESYYGyJmTm2DsNcBa
         jPkt4tWoOuhb0X/xsjcDgc9YzW19ZKg/cW1oSIieC673mA1dczJO1fXnRv8GSRG6ib6t
         IBDQ==
X-Gm-Message-State: AOAM533Qm+VdnrnGxnYP2sGV+ixiD3WJ7RQi8+T8aY2lD7YHvZX97M5d
        CPRKvjBcDdgIogUzpb+Kh9A=
X-Google-Smtp-Source: ABdhPJwcLUJd9y/OJokSaeRLMTKRMAJyNcLzRsZSizBxOeCiqlG8WhBjdYhymGmpMx46O1uzvf2N9w==
X-Received: by 2002:aca:4ed4:: with SMTP id c203mr10531649oib.51.1622237336240;
        Fri, 28 May 2021 14:28:56 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id l141sm1373735oib.44.2021.05.28.14.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 14:28:55 -0700 (PDT)
Date:   Fri, 28 May 2021 16:28:54 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Mathias Kunter <mathiaskunter@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramkumar Ramachandra <r@artagnon.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <60b1609665443_2a371720853@natae.notmuch>
In-Reply-To: <CABPp-BG=496bZ78ToKK0vwmmtWDDC4qbCZfXbL+odzecy8U7vw@mail.gmail.com>
References: <20210528201014.2175179-1-felipe.contreras@gmail.com>
 <20210528201014.2175179-5-felipe.contreras@gmail.com>
 <CABPp-BG=496bZ78ToKK0vwmmtWDDC4qbCZfXbL+odzecy8U7vw@mail.gmail.com>
Subject: Re: [PATCH 04/11] push: simplify setup_push_simple()
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> On Fri, May 28, 2021 at 1:10 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> >
> > branch->refname can never be different from branch->merge[0]->src.
> 
> This statement isn't true without additional qualifications.  Perhaps
> extend your commit message with "...since the 'Additional safety'
> check dies if they differ." or some other wording that qualifies why
> it's true at the point of the code in question.

Will do. That in fact was in the back of my mind.

-- 
Felipe Contreras
