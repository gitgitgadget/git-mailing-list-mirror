Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC2DC07E98
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 08:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3E88613B2
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 08:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhGEIHj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 04:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbhGEIHi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 04:07:38 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E90AC061574
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 01:05:02 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id ga42so10567606ejc.6
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 01:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=ODl3pfzZp8Oh6hcSdg4/WJGztIEa0V2l/mr1MCAFidw=;
        b=G5Oqei7sSYBN2+5l5ljB+xyCgeasW5NkCX4WZkhZKXOiQzWNmFqRvciFS9k1v9fkyi
         zTjqtIiIkmVx7rXql0X2k4XN61Arm3SEVDSUnLe3LGmhEKEhTHF1aIAur1ftdz0F4QW7
         MFlq3UqDh1YQC0Sq2wM7noSzNZyd6USxxFksYCfseKZ9za4gZVIcDDdv0LTEs9wbgCU5
         xCoTLsMMBItY+d7WUv5DQeLNU+fgoj5sNNR88aFhxZcj/SVomCgS5lG6XOF+eGD+tqvO
         bd4x0CcnHhQ7It5bPDHC7Yq1OaFIT3IEcxuuEpmW/2L44xSOTHJkuUFHCu4SxkoEd35s
         edrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=ODl3pfzZp8Oh6hcSdg4/WJGztIEa0V2l/mr1MCAFidw=;
        b=XXRGjEEvX6jF8vXKKTOz9J3mz5zA54+tyI1dpMVn3qR+7d26+v/gER9fMJhLywDGr+
         Q12w3qnnn85YEEhRBedazSurJrSU3sKkuW0owlbasGcdmgEMYszsQhZlcXxxxQryEUC+
         ipW/7rX1fgCPZDTXVZD94hpG6c1iqulKSvUrVDE2SghbTgNrf5Sodfm56wewimerf/N0
         xZL+5xQXBmbTDOaTQSZkvlbN2zYWy3nJGqkzkD1lkDN7fp8AdPnPL0hB2sG2+hnCrItE
         UU7EU5x8xyFEDJAk+aDSHhHFqXSgjId5OiyeTY+ZY7I5bPAYqUpfO2Fg4HATMTg4Pngt
         bE7A==
X-Gm-Message-State: AOAM533OpPdztkpf6tY7MN8t21i3wwta6DH89XNsW7KBG76VYcLAo4Eu
        x3XW98lAImFkuMxYLzspACY=
X-Google-Smtp-Source: ABdhPJx7S108YTXdORV5dSZhl0nxm5FelDITf/IJKdvwzmQ5fAI+tztnAQ0P0KnthAP5+01A0GRCpA==
X-Received: by 2002:a17:907:10d8:: with SMTP id rv24mr12018041ejb.542.1625472300747;
        Mon, 05 Jul 2021 01:05:00 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id b12sm5039892edu.30.2021.07.05.01.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 01:05:00 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2021, #07; Wed, 30)
Date:   Mon, 05 Jul 2021 10:03:58 +0200
References: <xmqq4kdft122.fsf@gitster.g>
 <CABPp-BGF4K4mAXf6X1rTpTmPCfQgwdhv_VUVg2icGk5Dw7Q1yw@mail.gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <CABPp-BGF4K4mAXf6X1rTpTmPCfQgwdhv_VUVg2icGk5Dw7Q1yw@mail.gmail.com>
Message-ID: <87czrx6v9w.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 02 2021, Elijah Newren wrote:

> On Wed, Jun 30, 2021 at 3:58 PM Junio C Hamano <gitster@pobox.com> wrote:
> [...]
>> * ab/send-email-optim (2021-05-28) 13 commits
>>  - perl: nano-optimize by replacing Cwd::cwd() with Cwd::getcwd()
>>  - send-email: move trivial config handling to Perl
>>  - perl: lazily load some common Git.pm setup code
>>  - send-email: lazily load modules for a big speedup
>>  - send-email: get rid of indirect object syntax
>>  - send-email: use function syntax instead of barewords
>>  - send-email: lazily shell out to "git var"
>>  - send-email: lazily load config for a big speedup
>>  - send-email: copy "config_regxp" into git-send-email.perl
>>  - send-email: refactor sendemail.smtpencryption config parsing
>>  - send-email: remove non-working support for "sendemail.smtpssl"
>>  - send-email tests: test for boolean variables without a value
>>  - send-email tests: support GIT_TEST_PERL_FATAL_WARNINGS=true
>>
>>  "git send-email" optimization.
>>
>>  Will merge to 'next'.
>
> Wahoo!

Do you find the faster t9001*.sh helps your overall test-run time?
