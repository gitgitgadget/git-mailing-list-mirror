Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C51561F404
	for <e@80x24.org>; Fri,  7 Sep 2018 21:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeIHBw6 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 7 Sep 2018 21:52:58 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43723 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbeIHBw6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 21:52:58 -0400
Received: by mail-qk1-f196.google.com with SMTP id 130-v6so10557149qkd.10
        for <git@vger.kernel.org>; Fri, 07 Sep 2018 14:10:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5MBZpYVQRdFkCC0PrAkZWagnvUzqhfvNxsS5nsBG96A=;
        b=uTzA5ub1oaNnAdgcd8pbtOBZUY3YuQwmTM4OmVirKNFyd6ArYiCus2vF+cwm0cvx+m
         6mYaygX9XHRhWof/p+ZFaB1T3UzpOCBhJas7O8lJGtN9FgnMuF+djkXSmv/F+96CqEps
         2qS7AIsrZ5CJZ1D3/njVCehzrfve/L7qaNzW5T7hz8ql22i24AmrAWQb4UAETljidVN3
         B1xG9R8f/At23W4lj7xtwnM6PSmlm8OvV403UT1UT2w0ec9s3v5w13za5a3AjwP83hOE
         m0RNTvEIaVa6pJbzTRgafOk7SNlbHHr/aMsz3DGYhfKMeZvTxdKC6u65KsRTbKSfBOGB
         XGGA==
X-Gm-Message-State: APzg51AqEkJtpveAN0k3kqHbh/Ir1tWB8303x2hCRSr4xnhzN9m9V+cz
        l2S7tbwxl3gee9quEhmx+zpVeOwL1H50Kbhdu78=
X-Google-Smtp-Source: ANB0VdbwAemmRS1jqd6GBMrZsCjrLAmM0n+PZga2DFR5yEtJCQB6q+kltGo/+MUnMIegWm+v6rTCOS/sH7Oal+EJHzU=
X-Received: by 2002:a37:48e:: with SMTP id 136-v6mr7426968qke.26.1536354612743;
 Fri, 07 Sep 2018 14:10:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180907155133.27737-1-pclouds@gmail.com> <CAPig+cQVCUyt5NvcSCAO63b1aO8HSc5AobCRKP5mp9jT_LYuJQ@mail.gmail.com>
 <796edb6b-74ec-35dc-4bae-7a817f8fa9b5@gmail.com>
In-Reply-To: <796edb6b-74ec-35dc-4bae-7a817f8fa9b5@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 7 Sep 2018 17:10:00 -0400
Message-ID: <CAPig+cRvbvH4cZZhWTf2xHrJuD8n75bdJNX2BMHgSCveppOC+w@mail.gmail.com>
Subject: Re: [PATCH] status: show progress bar if refreshing the index takes
 too long
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 7, 2018 at 4:29 PM Derrick Stolee <stolee@gmail.com> wrote:
> On 9/7/2018 1:38 PM, Eric Sunshine wrote:
> > On Fri, Sep 7, 2018 at 11:51 AM Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> >> +               if (progress)
> >> +                       display_progress(progress, i);
> >> +       if (progress)
> >> +               stop_progress(&progress);
> > Nit: Both display_progress() and stop_progress() behave sanely when
> > 'progress' is NULL, so no need for the conditional.
>
> Don't forget this one in preload-index.c:preload_index():
> +       if (pd.progress)
> +               stop_progress(&pd.progress);
>
> I found this extra one by creating the following rules in a Coccinelle script:
> - if (e) { stop_progress(&e); }
> - if (e) { display_progress(e, i); }
> Not sure if we want to put these in a .cocci script or not.

If so, we'd want to match display_throughput() and stop_progress_msg(), as well.
