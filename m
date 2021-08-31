Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465B9C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 00:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B2E560FF2
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 00:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239201AbhHaASv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 20:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239182AbhHaASu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 20:18:50 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB31CC061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 17:17:55 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id s16so18211518ilo.9
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 17:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZCn4DxEXOicPmErmX1mcBf/csAc0lMk1u2GnhVzLGhU=;
        b=g7GPeB9xTxx5mJdJzuglmTqMl4sj/RPLQUNNJ+/y2HyxFWPHeJomXq8Z8SUNZHIUEd
         qc3SHH+V1QBfc71eeBU5fRzL8z5kBjlR0p4Ie/24TlSXx1Q3LJoz6r4OcZShq2Evk+UQ
         yIR0OC0GXNBDiLzcWf38duH69qDux70gu4CQMwS5l6+2QJsU12hMh/vpcRFOWWhNPrvN
         KSyA8ih3mZMS5qbX0v4s6qkTHJ/lSrF98SwjLB/mm2GC5IJcTydGliMkHGrNbno54q+b
         Y6+v/OuvBHpzRab6aNui/ZayGDY/Rtmj7fCOoAyczmDRGcxDchzhRDoRQhkcbK9191Ar
         EK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZCn4DxEXOicPmErmX1mcBf/csAc0lMk1u2GnhVzLGhU=;
        b=GuWGsol9d8VgaBlmZW49fbxxcFgqWyS2jNDkh0H4agICo3skrpoeNcyitzaKnUgE0C
         jZuzRNYMShRBwD7SIqIgyyhw0siJ4Obs1m8WFsfvOV3CwJJp0nWMtN00w2kO+X8AW8rO
         S/YWii/xiPsNrQdbdZDt+NQTagh0RwdTOlVmJg0iZouZWhoT02bd7gGNK8aWhqrwyp5J
         XRNP0PooUXJEQMNTgY6QRxWl1SUx7I3vhXFIukjctnIL8f0AUtb8Yq6SdkdPtPgiAavl
         qww6aAxctdA9Nu46kcc5woJqMW+InLO8gSGLz/X+X2us2SL5QdT15l7ILqCZVnNy4HG2
         w+aw==
X-Gm-Message-State: AOAM531KWoNbTX0c8BezLSxKwJSYhXhyzZ1EoY0WaPnzRibznINKpzKS
        eOmV9C1gzC8RCFVEH+drtbpzi2RqvTPRe5DB
X-Google-Smtp-Source: ABdhPJwfQPb58wY6/supi6hfp9B+L5Eg57scSNjv8r6t99/+RNpxyee6WuIVu+I2NIeufQTfSWMStw==
X-Received: by 2002:a92:c151:: with SMTP id b17mr18402175ilh.1.1630369075319;
        Mon, 30 Aug 2021 17:17:55 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p15sm10085767ilc.12.2021.08.30.17.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 17:17:54 -0700 (PDT)
Date:   Mon, 30 Aug 2021 20:17:54 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 0/6] tr2: plug memory leaks + logic errors + Win32 &
 Linux feature parity
Message-ID: <YS11MuO6j9N1mzvm@nand.local>
References: <cover-v2-0.6-00000000000-20210826T121820Z-avarab@gmail.com>
 <cover-v3-0.6-0000000000-20210827T080054Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-v3-0.6-0000000000-20210827T080054Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 27, 2021 at 10:02:12AM +0200, Ævar Arnfjörð Bjarmason wrote:
> Range-diff against v2:
> 1:  8c649ce3b4 = 1:  306f14a0f7 tr2: remove NEEDSWORK comment for "non-procfs" implementations
> 2:  0150e3402a = 2:  a999e016a9 tr2: clarify TRACE2_PROCESS_INFO_EXIT comment under Linux
> 3:  1d835d6767 = 3:  45769da953 tr2: stop leaking "thread_name" memory
> 4:  1aa0dbc394 ! 4:  946140691f tr2: fix memory leak & logic error in 2f732bf15e6
>     @@ Metadata
>      Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>
>       ## Commit message ##
>     -    tr2: fix memory leak & logic error in 2f732bf15e6
>     +    tr2: leave the parent list empty upon failure & don't leak memory

I agree with Junio that the earlier subject line could be improved, but
the replacement is a little verbose for my taste. On the other hand, I'm
not sure how to simplify it without it becoming:

    tr2: memory leaks and bug fixes

;-).

So I think that what you wrote here is perfectly good. This version
looks good to me, too.

Thanks,
Taylor
