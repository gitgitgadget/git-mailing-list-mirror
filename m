Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0B8C433ED
	for <git@archiver.kernel.org>; Thu,  6 May 2021 10:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACBD861176
	for <git@archiver.kernel.org>; Thu,  6 May 2021 10:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234598AbhEFKqL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 06:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234434AbhEFKqH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 06:46:07 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607F1C061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 03:45:08 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id i23-20020a9d68d70000b02902dc19ed4c15so473203oto.0
        for <git@vger.kernel.org>; Thu, 06 May 2021 03:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=TiD6WR6QpVgzXyxRlrRwtGc6Hw3rbrn/RYujgBRBDaA=;
        b=oAUoiN05sT4KTvNOfXu0+XEb+Fxcame4cWc9tslsWvqwLlp0OTwDWrQuh1CtLXjcUh
         nuFXmTJhEagyBW3ZPxRk2ZAWGHjKOLAShPSopwmXbHPC/EMABPD4IN0oD05uka1Jvgtw
         wJh5ovhHYyXPdwvWwpDip54QmXeJ0tlIcU1KbcWTJR/1ajXKg8VNd+gAkDyIdZKw3d3F
         QRakqHH2kNrIHsEFQPptj2T0zJnOpmIxBP7M5R1vFMOWFY41131/kTv1K1muhNHjlL7H
         yfBd1z71AJ1TNtzSwW+/m1sNMOkSU1boNWOIBozcHVd0+5+CgYfYXa+dgvs5ukYmoam4
         59/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=TiD6WR6QpVgzXyxRlrRwtGc6Hw3rbrn/RYujgBRBDaA=;
        b=fGdVEop6xgQ0W8/zVnhInAetfMVyBbYYfp1WufEsImdtM6trWUNZ4WYRCuZQhruQQB
         5lVuKRHRWwhpD41aeK8DLurH7yZpxvENkkZ9M0o61RVeVgYlN+TZ3SXxjLEb6v6plcR1
         IL7BytoDT0OYF3c8MCl2T4q4XjWKtMZbkEONAxZeSEPyBhcRMt58YaLbpMqpv2cmlNqL
         e2cqau7muCZm/cmIawGXOJPkUuUlot5oZaDzses64O0fDZ9V2niB7097TRnOqaDrrhDW
         7WyxWRe0hPqWbT2jpzS7e5fLlPgFGloF5TrYEdBTBUnuUCirrIco9Kg8KPGfZsQafL+z
         vmjQ==
X-Gm-Message-State: AOAM530RtdBFM9Z/zz5Bb+oEqTDu+6jk5vv6WRKLG3Y9U7Or3GHp2ahU
        LhRUEc10UhHjoKyDRX6xK8Y=
X-Google-Smtp-Source: ABdhPJzGUnCXFY+zztfuuzp5eNauMsr8Oc/JSQmEy96AZPHXpQp5d8svObJvz8V8VI686590Y/4r1g==
X-Received: by 2002:a9d:459a:: with SMTP id x26mr3081159ote.337.1620297907811;
        Thu, 06 May 2021 03:45:07 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id v19sm491028otq.35.2021.05.06.03.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 03:45:07 -0700 (PDT)
Date:   Thu, 06 May 2021 05:45:06 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Yuri <yuri@rawbw.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Message-ID: <6093c8b236630_32572086a@natae.notmuch>
In-Reply-To: <8c802d6a-3cba-4c10-0430-0dbf95a56760@rawbw.com>
References: <d8aef355-0718-8b3d-7e9f-614673dd250f@rawbw.com>
 <fff9baee-ac4e-66ea-1dfb-791a8b044527@kdbg.org>
 <e75f000b-e376-45d5-ee5a-2a555076a3d9@rawbw.com>
 <35877543-93b8-00f8-692e-09a06d4679aa@kdbg.org>
 <d4ae27b9-3911-506c-a23c-3ed91bb250d1@rawbw.com>
 <6093ab6bd3ea8_24e620862@natae.notmuch>
 <8c802d6a-3cba-4c10-0430-0dbf95a56760@rawbw.com>
Subject: Re: [feature suggestion] Add 'git stash export', 'git stash import'
 commands to allow to backup stash externally
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yuri wrote:
> On 5/6/21 1:40 AM, Felipe Contreras wrote:
> > No. Commits are most definitely not public. Not unless you do
> > `git push`, and only if you push to a public repository.
> >
> > I have countless commits on local branches that nobody would every see.
> > Many on a "tmp" branch.
> 
> So you advocate to use branches? If branches are same or better than 
> stash, why was the stash feature created?

Branches are for long-term sequences of useful commits.

Stashes are for short-term crappy commits.

They serve a different purpose.

-- 
Felipe Contreras
