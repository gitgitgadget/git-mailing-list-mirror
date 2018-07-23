Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FA021F597
	for <e@80x24.org>; Mon, 23 Jul 2018 23:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388087AbeGXAX6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 20:23:58 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:43206 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387975AbeGXAX6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 20:23:58 -0400
Received: by mail-yw0-f196.google.com with SMTP id l189-v6so868302ywb.10
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 16:20:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+NRZA0DG3q2I+9FoAc3NH7KySfyBSIchTldQiQL/sN8=;
        b=i2y88qwwDcJIjrmCpUY6yP27a4eFaP4jsygvIsFFpFjXZSfNvgpEtVCQDtKYI2QThi
         x7kNIvn0OZVbtxj6l0NSxpaCt9Ua/dfLuWW0yf8IMKw9EoVkaHV0roa9AKvgJKXcJBU3
         /y86NgvixjsfB4aZXBy0RyrTZVH77DPEHdF2UChKibYEg45Q3dvkjKUkO0PJHOyrv0TD
         NiT3mijlPYBY4RF4V3HfbDfi2ZljhxOkZoFolzSNVX6ennybjcxbQHCjRejB+Sop8dJh
         vWthhD35w/kCzmD4mBXBOm3ChB10buL5Ax+k/TLCR7KVmaAwfRWAZj2yO3zJg5OdV6n3
         THXQ==
X-Gm-Message-State: AOUpUlF4+1LcZfCKhD1uBOQ/bP0tVk1mjwNj+SlTS4mb3SvqekpybNhm
        TwdHKtWb1YqkCjoCqT+9m9nsUAtZ3CDW5SanWsY=
X-Google-Smtp-Source: AAOMgpeoukmaX0YcnJI2wDiQTClxtEtP0ox7a+mEAakJDCDCDy4ct3GpescdUt5BqhAFYbHaniq/kFn6jdef5hWuXdg=
X-Received: by 2002:a0d:c105:: with SMTP id c5-v6mr7736310ywd.131.1532388026720;
 Mon, 23 Jul 2018 16:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180722095717.17912-1-sunshine@sunshineco.com>
 <20180722095717.17912-8-sunshine@sunshineco.com> <CAGZ79kZ0OMrU_O5_rPdG7bNHRWQxVV1RguEg3g-pOa+kkgPCaA@mail.gmail.com>
In-Reply-To: <CAGZ79kZ0OMrU_O5_rPdG7bNHRWQxVV1RguEg3g-pOa+kkgPCaA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 23 Jul 2018 19:20:15 -0400
Message-ID: <CAPig+cQtzs5ENzOR2sJVkZu13OF7iMnEcf4GG1jKGrzRhE0AUg@mail.gmail.com>
Subject: Re: [PATCH 07/14] range-diff: respect diff_option.file rather than
 assuming 'stdout'
To:     Stefan Beller <sbeller@google.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 23, 2018 at 6:59 PM Stefan Beller <sbeller@google.com> wrote:
> On Sun, Jul 22, 2018 at 2:58 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > The actual diffs output by range-diff respect diff_option.file, which
> > range-diff passes down the call-chain, thus are destination-agnostic.
> > However, output_pair_header() is hard-coded to emit to 'stdout'. Fix
> > this by making output_pair_header() respect diff_option.file, as well.
> >
> > Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
>
> Depending how much the range diff series has progressed
> already, it might make sense to squash it there?

It could be done that way, though it would be nice for Dscho's
range-diff series to land without another re-roll, and it looks like
I'll probably be re-rolling this series, anyhow, to move
show_interdiff() to diff-lib.c and to fix its signature. Junio could
manage it as a "squash", but that's probably more work for him than
for me to retain it in this series. *And*, this change _is_ required
for this series, whereas it doesn't really matter for Dscho's series,
even though it's an obvious "fix".

Anyhow, whichever way Junio and Dscho would like to play it is fine with me.
