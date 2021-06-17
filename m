Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAE4C2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 15:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C88DC61159
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 15:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbhFQPZW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 11:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbhFQPZV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 11:25:21 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6492BC061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 08:23:13 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id q20-20020a4a6c140000b029024915d1bd7cso1657204ooc.12
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 08:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=h4kjp9FkiXcfzRBoJx+KqKUPldjTnC0MYQwGv3ome8c=;
        b=sUdanE02HkMB1+bu1gtZeoFRiPrNAwRfG11mr2M5rnGNJ+K8BJbBANWgt0xWXs8knc
         ezF29W+/PPCqgCYLH1RGND9HW86++f+aZxaXdWmqIpSZ/9Pd4FCbGoN01U2WMQNx/xVw
         gIlmavIKptbuuP62NcTIDFyGNM6IbScz3oie076UmBEuOfghXiaPZPpgzpnZCa63X/cN
         r+qpJsSpO+mZnQabHLCdV+kYE09AuTJB+jkbHcMJooCyfRwxKpHxzmwXWVLFTvoKAg3S
         +ksWpASTFS+KhK6d2dOlxlWXSx3yjfkGP0xYN665dinOcj1kQNWLtJc+286OoIyEHK02
         9vfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=h4kjp9FkiXcfzRBoJx+KqKUPldjTnC0MYQwGv3ome8c=;
        b=Q4GFwms1kPJoIM4Y4vgCLDeG1o6TnGC/TSpK9UIJ9ykHiNI7NLDW6ROIvFOYVUGuQ+
         mOm9LTw9YpG4Y08qJykm3mxhFC0PssV3QxSaWs6gPI1G66nXdga6wC77c9ZZSJw8Qa3w
         6wf9pldq1vvXCX/MwglLM6HYdvkkKMiMQdjxF94JiAsKr0rm1kTZeOVMtTnT0puJUWoj
         kk5MHIDRkAC+zsaI+H0DKgwW6X77l5keVoWRwOyVsPXeENsoAKCEE1uYbpxEgpEoCpVA
         hZfNbMOM+D5ThGNaNQIfD3XLB7w8WpPnxt2nH747xBa1VFCHqJL+DxzIkr94UmuTOXte
         zUGA==
X-Gm-Message-State: AOAM532obJuN30Um3NdJ9DiKRJco2XUoC/mNwBrVa4FbQ3Z0waTZaXpb
        SCQ8Bw+5aySMOvF4hc2g79aqHjMcXDmDGQ==
X-Google-Smtp-Source: ABdhPJzqANf55e7cVr77kcsGDlFJohCzFRwh1S6HRHE+EL8cDe+jbdKZn9tZOtt0ty+dTkTjjIgH2g==
X-Received: by 2002:a4a:b60b:: with SMTP id z11mr4952957oon.57.1623943392766;
        Thu, 17 Jun 2021 08:23:12 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id u15sm1198325ooq.24.2021.06.17.08.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 08:23:12 -0700 (PDT)
Date:   Thu, 17 Jun 2021 10:23:10 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sandals@crustytoothpaste.net,
        stolee@gmail.com, jrnieder@gmail.com, emilyshaffer@google.com,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Jeff King <peff@peff.net>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        Phillip Susi <phill@thesusis.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Message-ID: <60cb68debacbc_13057208e4@natae.notmuch>
In-Reply-To: <xmqqtulxnyhb.fsf@gitster.g>
References: <pull.975.v2.git.1623246878.gitgitgadget@gmail.com>
 <pull.975.v3.git.1623766273.gitgitgadget@gmail.com>
 <f06092a9053e40d93c4ec94b7fbbb1b8d563957b.1623766273.git.gitgitgadget@gmail.com>
 <87a6nryt51.fsf@evledraar.gmail.com>
 <xmqqsg1iseza.fsf@gitster.g>
 <xmqqbl86qtyf.fsf@gitster.g>
 <87bl85y15s.fsf@evledraar.gmail.com>
 <xmqqtulxnyhb.fsf@gitster.g>
Subject: Re: [PATCH v3 4/4] CodingGuidelines: recommend singular they
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> > The references to "gendered prounouns" etc. are gone, perhaps there's=
 a
> > good reason to re-include them, but the point of "isn't that issue
> > solved by recommending an orthagonal approach?" is one of the many
> > things Stolee hasn't been addressing in the threads related to this
> > series.
> >
> > To me that whole approach is somewhere between a solution in search o=
f a
> > problem and a "let's fix it and move on". Not something we need
> > explicitly carry in our CodingGuidelines forever.
> =

> This I think is the crux of the differences between you two.  I'd
> love to hear Derrick's response and eventually see a middle ground
> reached.

A middle ground is not always the best solution. The solution between
punching people you disagree with and tolerance is not punching them a
little bit.

Sometimes one side is just incorrect.

Also, a principle of logic is the burden of proof. =C3=86var doesn't have=
 to
prove that there's something wrong with Derek's proposal, Derek has the
burden of proof.

Why do we need a writing style lesson for one particular issue (that has
never really been an issue) in CodingGuidelines?

I have not seen an answer to that question--let alone a satisfactory
one.

-- =

Felipe Contreras=
