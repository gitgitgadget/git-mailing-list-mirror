Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CC5C48BD1
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 11:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED123613CA
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 11:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhFKLyf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 07:54:35 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]:45801 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbhFKLye (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 07:54:34 -0400
Received: by mail-lf1-f45.google.com with SMTP id a1so8108984lfr.12
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 04:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=wAL1BPo7FtV7gzrgjuYJzTFAzYIEkuSPz5CKBaLp8Jg=;
        b=InlqFZI7SdbIJtRVl1He/xR5TQgV8q9fK4iFX/wiIEBkE3O030zvczXQPlV1BoIelf
         9mswjM78pBlaIWxfG4T8qB2VK9HIudXzkEuJVMJZPUNi9Y29WETP+1LZ4D87oy3BHeVi
         lmLVBZdD811nRNVyo0NZ6DkMdZ6B/RAmsVyEmp+xRMZgjYN434X2UfGlbNohhX0HHgkz
         mjjrAsSdueyQuYML70rwaGLQuc0Xat7wYQQ8m1mm4V2Sqv7beiPKyZdmw8B++BEV8VRz
         1v0OW6qf6O1COR27OEKeph3UjG3phsVR+ObWnSj/3MuYYMYmn/tL7Cn3MOXi/RfmhmJj
         jPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=wAL1BPo7FtV7gzrgjuYJzTFAzYIEkuSPz5CKBaLp8Jg=;
        b=i6WQrBs5oGk0CZn6SQM+q2mlEe195k4PY/3NO05b+GZSvPjaEt9kZwbbRoDIkUal4o
         YaLT9Qj1mBv9A9rbt55txPBOEihO467ErssTt+1AJJAB6rdbvYdglL1KXx2JDeIFCxLd
         f2p6gV3ZW1tn1A8VtPTpPZejbK2K05+LVwPP5FRu11lZaRRdLNlasJASLJndMF6gb29J
         3TojAbkq2E3MOD2XOGvpweAkvHtgg5wcaNuUEqh1aflnX2Css2t6+GI9Fr30lr8ty9Ca
         he7Otn3YtzOddAWE2JXS0BxHjY3vtU4S46rQ0+c2tbfblH2L/hesykDcEt0Yw/Kdz5Y2
         PGHA==
X-Gm-Message-State: AOAM532dNP+O1AR7XLCZvPlZ361ReGxkr0KsLL8mjI59imdBD4xlSiiU
        FeUU6rfqRaJs+Ms13zWAU485gb+SeyI=
X-Google-Smtp-Source: ABdhPJyKTDDuZoApIa6B14Uj++EpWkH483QpB4V9gLZidHWnv6pmd0XTgPHJp6zNVeAAmUdIUAcOsA==
X-Received: by 2002:a05:6512:32ab:: with SMTP id q11mr2302425lfe.21.1623412295197;
        Fri, 11 Jun 2021 04:51:35 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id k20sm569689lfu.177.2021.06.11.04.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 04:51:34 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Denton Liu <liu.denton@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 7/7] xdiff: make diff3 the default conflictStyle
References: <20210609192842.696646-1-felipe.contreras@gmail.com>
        <20210609192842.696646-8-felipe.contreras@gmail.com>
        <60883e1b-787f-5ec2-a9af-f2f6757d3c43@kdbg.org>
        <YMIYUgo71aKJ1Nnx@coredump.intra.peff.net>
        <xmqqh7i5ci3t.fsf@gitster.g>
        <638a0500-459a-a25b-afca-904ec0e09866@kdbg.org>
        <xmqqy2bg3nqw.fsf@gitster.g>
        <07ef3a3b-4812-4fa1-c60c-b9085a268bc3@kdbg.org>
        <xmqqo8cc3maq.fsf@gitster.g>
Date:   Fri, 11 Jun 2021 14:51:33 +0300
In-Reply-To: <xmqqo8cc3maq.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        11 Jun 2021 16:14:37 +0900")
Message-ID: <875yykipq2.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Sixt <j6t@kdbg.org> writes:
>
>> The case that inner conflicts are presented sub-optimally under diff3
>> remains, though.
>
> I agree that until that happens (necessary but not sufficient
> condition), it is premature to recommend diff3 style to be the
> default.

Yep. A work-around could be to fix diff3 to rather produce RCS merge
style in such situations?

>
> I notice that "git merge --help" tells what each part separated by
> conflict markers mean in both output styles, but does not make a
> specific recommendation as to which one to use in what situation,
> and it might benefit a few additional sentences to help readers
> based on what you said, i.e. the "RCS merge" style that hides the
> original is succinct and easier to work with when you are familiar
> with what both sides did, while a more verbose "diff3" style helps
> when you are unfamiliar with what one side (or both sides) did.

I don't get it. Once you have diff3 output, and you want something
simpler, you just kill the inner section, right? RCS merge output style
is simply inferior.

Thanks,
-- Sergey Organov
