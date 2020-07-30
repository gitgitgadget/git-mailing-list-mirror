Return-Path: <SRS0=t8Cj=BJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CC8C433DF
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 19:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 629A520829
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 19:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730405AbgG3TA5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 15:00:57 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43472 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbgG3TA5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 15:00:57 -0400
Received: by mail-wr1-f67.google.com with SMTP id a15so25850178wrh.10
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 12:00:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8jWIoSSzeAMB2Nz95rkuHgfGVzZrVKQT1H/eDV3hUoE=;
        b=RsAj+7Ev/BVUgMbdIlgn+VzyaNz8V+0HqNeAYihm31pQ/N/vSbdHGQEJE4r1T/t1wR
         vB5g1+WS/mQHYnKlO2myrUf+EeudVFiO74+RUBQsBqdYxUt/ZtRbJsYfKq8C8CI2niBR
         DIkJLNR72tM3h99v/T+Ul1oDdwrU+wvVQTIvtgLvOVbojcNEopoLB02ohTgBH270CmYy
         8ScIlRcYPWuXEPkYexM91fQEMAFkOeO40rY+/Tp4Nr9W4gSfJ+BDy1GJewA4y2m1U+HA
         A00EKkV0QoiD9mlNXq02OfTKhhRKpDjz9NfCOJvMnMrTI3yiTuKKN7SyWik1MHNQC0Y3
         WA0g==
X-Gm-Message-State: AOAM533TMV5ZMWqgV+65eX7QK7GCR9UQHYgzJc+qW9zbeTTgkvlTq4Pc
        9AAStTNcyrI3xsZ4jsHf4SEe1zS8pPjgHqBza5I=
X-Google-Smtp-Source: ABdhPJylF08s5+kuUG9GnJ8xLdekStjVxLexFvFLRZIwKw8sXXfAsFjrEDRPDUugsN2OtJIewZyB+3uO1Hw7tDDGCVI=
X-Received: by 2002:a5d:540c:: with SMTP id g12mr168682wrv.120.1596135655238;
 Thu, 30 Jul 2020 12:00:55 -0700 (PDT)
MIME-Version: 1.0
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
 <pull.671.v2.git.1595527000.gitgitgadget@gmail.com> <f164d1a0b4363eb6eb174e90e88211829f8a1d55.1595527000.git.gitgitgadget@gmail.com>
 <xmqqblk6q8ws.fsf@gitster.c.googlers.com> <9aadb889-007a-c973-c59c-a471436368bb@gmail.com>
 <5757360f-a9e5-0bd2-b933-7efddee29cf6@gmail.com>
In-Reply-To: <5757360f-a9e5-0bd2-b933-7efddee29cf6@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 30 Jul 2020 15:00:43 -0400
Message-ID: <CAPig+cT50u=she6xm-zam-Qxtt5c7RTUTme+tj4GBGnQ_nus8g@mail.gmail.com>
Subject: Re: [PATCH v2 03/18] maintenance: replace run_auto_gc()
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff King <peff@peff.net>,
        Doan Tran Cong Danh <congdanhqx@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 30, 2020 at 9:31 AM Derrick Stolee <stolee@gmail.com> wrote:
> int run_auto_maintenance(int quiet)
> {
>         struct child_process maint = CHILD_PROCESS_INIT;
>         maint.git_cmd = 1;
>
>         argv_array_pushl(&maint.args, "maintenance", "run", "--auto", NULL);
>         if (quiet)
>                 argv_array_push(&maint.args, "--quiet");
>         else
>                 argv_array_push(&maint.args, "--no-quiet");

It's subjective, but this might be a good fit for the ternary operator:

    argv_array_pushl(&maint.args, "maintenance", "run", "--auto", NULL);
    argv_array_push(&maint.args, quiet ? "--quiet" : "--no-quiet");

Or even:

    argv_array_pushl(&maint.args, "maintenance", "run", "--auto",
        quiet ? "--quiet" : "--no-quiet", NULL);

The latter is a bit less readable to me.
