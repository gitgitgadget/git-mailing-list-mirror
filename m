Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460A7C433F5
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 11:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355345AbiCPLda (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 07:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355347AbiCPLd3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 07:33:29 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F79369F3
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 04:32:15 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id e6so3271405lfc.1
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 04:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZpIydRrHlIT+1PV9pa2Mq19V0qbtzt0D+5EKzpAbN5o=;
        b=I3heCDXZXc2F69C4hdx1aXgDzRbGYMnLIeNeqN1Ij1Wy8XtyzdSWCDcHoWjViwNbNH
         mXPb2DSVveV9s1JBLjziON3VZAEckx0rnyx8nS0ICJEq3k7xG78jCohyi6fVSkYYhBgn
         Nsj+H8oCw9EtvRbXLvLryOv2FrQ1dhVmgIsIiPc4yFtaNKjauEsAXN0TdH8/uNPpHkOK
         S26fxKVQsjEo2596lExsB9gOA6G9iWiuMex9jtunM9aOq4+50uPd6nlkH/m04ZuYgllI
         +d9RKRvss2bHJ8HFswBwGO8jYKqr9IddSxsOlTY5VCSTqGdIwn8DSPxvcAhs/HdHNxAQ
         DWwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZpIydRrHlIT+1PV9pa2Mq19V0qbtzt0D+5EKzpAbN5o=;
        b=2zzx9x527Op86qnaliIzT1IFr0SsATqhlaHY8O8W/KOa12zT4gbLB/JIXbM3mRDlbt
         l1ZoNscBfwBqXSdNmPJ6gYG+8+5cqgwZDdl2NM+A7RHBSbqPI6xwWH8NUKH9t01QTiOz
         co97gLUW8K0z1QZOe4aCZO8qgPTzpAJ2yJk1jycX55AkocamABFCuA8wmEQsthLF/OMm
         yOPGJB5w162ZKIBnEy/J0p3zSIBXl7vdqyWEDtPPePgKyIfIZYJyKzCr73GAKZij6oLl
         PUKcnbRwQFIVGZsSLfejEt4TkTO3+7i412OjcsG7HAhcq4fimoWVbjHUbWT1Ys/S86a9
         Pp3Q==
X-Gm-Message-State: AOAM5332wiVBm2YHHLa2BFtQPau0soj/bF3MbESE+BmWQZUoOyiTM5TZ
        /WDuj5rrCKhn44YS0/s6R6szeb4Oxhm0SgOOrcM=
X-Google-Smtp-Source: ABdhPJwxcWzFOFnOLVuOJn2jAMXnwh820ATfBwFHisAKN/gX7+nbMcqt+K+c+ZcD9HI1qOo6HTqUsk6AhmVQtBU8TE0=
X-Received: by 2002:a05:6512:1382:b0:445:9536:903 with SMTP id
 p2-20020a056512138200b0044595360903mr20028859lfa.89.1647430333530; Wed, 16
 Mar 2022 04:32:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220314080601.10504-1-gaurijove@gmail.com> <CANsrJQd0v2V9H8HPkiH2179C1c-NOSTRRB8YXt8v6R0YAbFPDQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.2203161028560.357@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2203161028560.357@tvgsbejvaqbjf.bet>
From:   Jayati Shrivastava <gaurijove@gmail.com>
Date:   Wed, 16 Mar 2022 17:02:02 +0530
Message-ID: <CANsrJQcfSrmgCQn6ozvhunPXK6zfg33j40nQS0b70xnvJWO8iw@mail.gmail.com>
Subject: Re: [PATCH 1/1] Use reverse_commit_list helper function for in-place
 list reversal
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>,
        Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dsho,

Thanks for reviewing.

On Wed, Mar 16, 2022 at 2:59 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

> This information is quite useful. Can you please integrate it into the
> commit message before sending the next iteration?

I have incorporated the changes here :
https://lore.kernel.org/git/pull.1177.v3.git.1647429623830.gitgitgadget@gmail.com/
.
I had to shift to another thread using Gitgadget since the patches
that I am mailing using git send-email were not getting delivered to the
public mailing list
