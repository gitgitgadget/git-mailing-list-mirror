Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5388FECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 21:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbiH3V2G (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 17:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiH3V2E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 17:28:04 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A432685FA8
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 14:28:03 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id z3-20020a17090abd8300b001fd803e34f1so10630762pjr.1
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 14:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=6+2yFRFtzb4LKflCayuzQPdEI2XR2QRugSq9zLurJ7k=;
        b=J0nQ04FkqqU6a+jZWxFobuFV4o46jLaZgeKuFe6J/dAZgl+2uMn1D9+144mwVZoS5c
         +TG3vLh23k7+7gFy6cPFMDQo8o2V95oyowxLrHlr5nv6XuoRyeQMFeGEfKl1Oq407Wtt
         fdyXRXhswaL8ESwcJW3sv7LbnKhiuQA9auCQ0VQRHEg/uGlVHUk+GdRyIwmDrWUej7Y5
         4yZtdkc6mlf3CsKoqvciOfSNFvydLSPoZAkKtXTW5hhGJGwODrVc/hBDxWaKRrDi5O+Y
         1fjIwcBHcE/b1g84L5JWSKwWfpGSPqFND/7xDHJHaER3UUvRU8hpKN8RyqXrJMo5JW3V
         bb+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=6+2yFRFtzb4LKflCayuzQPdEI2XR2QRugSq9zLurJ7k=;
        b=UKkRNg4mJqWg4Vm4ipWqlgJTaFi/86hBLYIBTZBxsf/mW8YkXz7RGwu0D1Ex77ryQf
         4oO5HGlaqKpnIsQm35RJ1soh8I/pD+YXdP7PmobDCp75AwSONu4fnveQNJODTteDx4PK
         DN/Bh0li5x6HJihv8eKGLPeGSk+jc28XgZ6MmPJvzoEXfbRUzoyTaX6en/hjjWeKuW+C
         +i84yZBAbXlT9H9XVy5E94hwUTHFB0/30/XkgSVgVxTFG+kr2ToJeDMm0vntZFaqukeH
         AgHoPV7PgeHxFn67Rdn/Ut6dJQmaw+TOfFwR2J4EaDcOJ35AiBLLA8DC9sb8QcxcboWc
         GBTg==
X-Gm-Message-State: ACgBeo2dv0Rq7dvn2WatU5IM9n+sVvVkruw4NRJaB0h37MpenJpLysTC
        DWJcSmvKvjIA2Ut2aQ4TwynR60YWjzo=
X-Google-Smtp-Source: AA6agR5b/ITRR/ANXGHvb4Nc84I8B0POfzEXo4694X+ASEnJ1ljdWIhxVc22M9TZSz2MYzdVhffzdg==
X-Received: by 2002:a17:90b:4b47:b0:1f7:2e06:5752 with SMTP id mi7-20020a17090b4b4700b001f72e065752mr178993pjb.187.1661894883111;
        Tue, 30 Aug 2022 14:28:03 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id ot17-20020a17090b3b5100b001fb3522d53asm14103pjb.34.2022.08.30.14.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 14:28:02 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v6 05/16] bisect--helper: make `terms` an explicit
 singleton
References: <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
        <pull.1132.v6.git.1661885419.gitgitgadget@gmail.com>
        <92b3b116ef8f879192d9deb94d68b73e29d5dcd6.1661885419.git.gitgitgadget@gmail.com>
        <xmqqmtblighr.fsf@gitster.g>
Date:   Tue, 30 Aug 2022 14:28:02 -0700
In-Reply-To: <xmqqmtblighr.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        30 Aug 2022 14:11:28 -0700")
Message-ID: <xmqqfshdifq5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Well, I do not find the above all that convincing.

Having said all that, quite honestly, I do not care all that deeply.

It just looked suboptimal, even if we were to take the "as long as
the end result 'works', we do not care" attitude, to deliberately
make the code worse with a larger-than-necessary patch, and then
complain that use of OPT_SUBCOMMAND() made you write unnecessary
code.

Will push out another round of integration result sometime today and
this series will be part of 'seen'.

Thanks.
