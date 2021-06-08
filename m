Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC68FC47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 09:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 841BD61278
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 09:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhFHJZx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 05:25:53 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:39768 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFHJZw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 05:25:52 -0400
Received: by mail-ot1-f51.google.com with SMTP id 5-20020a9d01050000b02903c700c45721so18604460otu.6
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 02:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=QqzyoLiOHDSAngm9RoN1vBQefCuTgfbXVdzwO9BjSlI=;
        b=dyLexVfqBRr1uhl2KJdCHqFQjJ6DgJFIUYRYqDkFRol2MIDI6P6uLsikgMG5/p651F
         V0DknvR0APhA8u2YtVRqPOwVMU7OFTXh3VoYM6OIs0g7XSsxEzntayx+DoCrDbqGVwWU
         xuE3obymaVfRyoWviYhWmv5/jFQwt/RrcCVhC5QS3QTkIGwnBV1zJGObhURpzCUO2BfM
         mmy1DdvNxO79LpcnAdbjrwF1gIfXaz0dY7nv8f4rVMGmV6kR/yj7WIpYYbARFFtk8NAc
         yRr3hiZwO+pJKCGo1upniYkz8JYP5G7I7Rw3uaxE0rqnFgSMu2L8ZKLycYjpyQXW7tmG
         7OPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=QqzyoLiOHDSAngm9RoN1vBQefCuTgfbXVdzwO9BjSlI=;
        b=L3ue9yUHBS0z1U9cMjtkpSu19J2qb8BMjLCpTsx4IYuh3OHOUoJqLrEd/R5eynTIZX
         d5krZ81TwlCYvg8l1rZcK6ETctYgba8TpErbtiCjU5vgkFSrOVfmZCNk79qmG7NfzdAJ
         LlRqp145appNImNzTUXqc2iIkzzd+oKqwpUCnH6p1H85WCXJgU6ZEjjvDwvukVnARTFc
         1Ad9zL6o8s5urn8k8iF75DzY0EIuWRDzyBcQo4sXufTy3pPGax6Os0K777aPX2MnTe/W
         SN3MZmh1OeOSmZCcCVq+vmepWTku0Ldx2emanNp8H1CG2xARy79XPjaC9foVW5iT+7Wj
         Q0Pg==
X-Gm-Message-State: AOAM530xRASXst/KuGs95npOlJdnWND08wD0bjnLnNpeft3m9s1Ee9o8
        38AjVnJCWP8lQ8HEN8pC2Krhr6LnFszV6w==
X-Google-Smtp-Source: ABdhPJzBleSBTwn6ckiG7I2euomwanbCYEoa22NhvgIqSEgceK8DSZuMxI2HrZakwqbrv1QcagiqTA==
X-Received: by 2002:a9d:585:: with SMTP id 5mr17634691otd.12.1623144179795;
        Tue, 08 Jun 2021 02:22:59 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id 35sm2985436oth.49.2021.06.08.02.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 02:22:59 -0700 (PDT)
Date:   Tue, 08 Jun 2021 04:22:58 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     "Kerry, Richard" <richard.kerry@atos.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <60bf36f24d2e2_1a848720836@natae.notmuch>
In-Reply-To: <AS8PR02MB7302DF058D13CAE11A1086FD9C379@AS8PR02MB7302.eurprd02.prod.outlook.com>
References: <20210605011339.2202-1-felipe.contreras@gmail.com>
 <87czt059sn.fsf@evledraar.gmail.com>
 <YLv8NWL7WfBRkiGe@coredump.intra.peff.net>
 <60be41f6473e2_39c0a208f6@natae.notmuch>
 <YL8KiiGXF8LdGmQ2@coredump.intra.peff.net>
 <60bf1997b1a72_1a2ac520865@natae.notmuch>
 <AS8PR02MB7302DF058D13CAE11A1086FD9C379@AS8PR02MB7302.eurprd02.prod.outlook.com>
Subject: RE: [PATCH] branch: make -v useful
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kerry, Richard wrote:
> 
>  > Git is a distributed VCS, most people don't have commit access to
>  > the original repository, therefore they push to their personal
>  > repository (e.g. github fork).
> 
> [RK] When you say "most people", do you mean "most people who are
> working on open source projects"?

Both.

Two-way workflows are present both in open source projects and private
projects.

Triangular workflows are present both in open source projects and
private project.

> [RK] I'm working using Git every day, and I pull from the original
> repository and push back to it. I am working on closed source company
> projects.

The triangularity I'm referring to is not per repository, it's per
branch.

Do you always push to the same remote branch you pull from?

How about rebasing or merging? Do you use the same remote branch?

Cheers.

-- 
Felipe Contreras
