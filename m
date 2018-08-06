Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 933FA208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 17:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733076AbeHFUDE (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 16:03:04 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:41807 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732511AbeHFUDE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 16:03:04 -0400
Received: by mail-yb0-f193.google.com with SMTP id q5-v6so2454418ybk.8
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 10:52:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bg6e07AiNfHmlGDVPAZh1sR6a91TeVFGOxcDNSs0s+k=;
        b=fOnu0PAHv2aPkaQaQYl1ZTbaHKSlJglv1JTy6rxWMpFS/Au4H9sjj5iChATcvN58gn
         AW+n9rrRCFGEtUqb8lKfLX0LI848fmr1SnJMJbzAAoidi/i5eGxIrZRWkHWUTDiDTXao
         xWvbvUIPxXZ4/HbHa/KXUL96g7o0282/hFTjhodeGEAernhedCdpw4sYNPnL+QP2ghO1
         I3McLMTiNJXwRozhS3QGs3TerC0ESQoR42PslJWCVPcpBCyk1cD1lDkf7lqoxBEmrthb
         ZcyHtO/8evwqqex2MghK+2nAU0ytbQZQ4Q1eqX1ylxNHyakJ6J1BtOXrdqrnnTwHbS59
         ET2g==
X-Gm-Message-State: AOUpUlHdfuA8guj0rMninVorHEh1Uc/YEIpylecjv+6UiI7lGN6Zc1W7
        7a3r1Pav7+Ql3Lz4od9L3ixAQBiH/0MIxkdf3H0=
X-Google-Smtp-Source: AAOMgpc5yRGlkmy/+KCMgtV76VR2Hk7Ik/wNwFhOS+rWJ9ari6LDSXIefEp14x0QotHgLClgQF3lm9+Q7049qyDUxTk=
X-Received: by 2002:a25:8b04:: with SMTP id i4-v6mr8130292ybl.12.1533577973466;
 Mon, 06 Aug 2018 10:52:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180805022002.28907-1-wchargin@gmail.com> <20180805022002.28907-2-wchargin@gmail.com>
 <20180805041956.GI258270@aiede.svl.corp.google.com> <CAPig+cQSryjWrFZML_g0fR5oq6dzVaWPXm_4R-Jg_ay1R2DzbQ@mail.gmail.com>
 <20180805205231.GA14688@sigill.intra.peff.net> <20180806130216.GA29966@sigill.intra.peff.net>
In-Reply-To: <20180806130216.GA29966@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 6 Aug 2018 13:52:41 -0400
Message-ID: <CAPig+cQK7JSosa0hNhgw7xoSui2f0m6yfRLWytsg_Zow3bN5bg@mail.gmail.com>
Subject: Re: [PATCH 1/1] t/test-lib: make `test_dir_is_empty` more robust
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        William Chargin <wchargin@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 6, 2018 at 9:02 AM Jeff King <peff@peff.net> wrote:
> On Sun, Aug 05, 2018 at 04:52:31PM -0400, Jeff King wrote:
> > Perhaps even simpler:
> >
> >   test "$1" = "$(find "$1")"
>
> Actually, I guess it needs to add "-print", since IIRC that is not the
> default on some old versions of "find".

You recall correctly.

I tend to avoid 'find' in scripts when I don't need its recursive
behavior due to *extremely* poor performance on Windows (at least that
was the case years ago), especially when there are a lot of files in
the directory being listed. However, for this usage, we expect the
directory to be empty, so perhaps performance isn't an issue.
