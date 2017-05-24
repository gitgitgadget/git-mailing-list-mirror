Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA07C20281
	for <e@80x24.org>; Wed, 24 May 2017 04:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938189AbdEXEmn (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 00:42:43 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33143 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938184AbdEXEmj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 00:42:39 -0400
Received: by mail-pf0-f178.google.com with SMTP id e193so133137981pfh.0
        for <git@vger.kernel.org>; Tue, 23 May 2017 21:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=xYGzMxRAxOWgti5WCEmM60iHs6aJW8WP1nteBa7KfMQ=;
        b=MIrRc8D48wAOs6q9bFRJyIjHmuOnoN1AzX+cnCaRXYluk4mV14tbVCvHgmcO04Pft4
         spROqXSwXDLZV5d2UcH78mzixMjBMSc8six4EY6X35TbKdc+U9Uo2Q/nXErvSWPUr6Cv
         VFShE5SwKl3cCmSX555PUkutA8ukceTaiKgWajbE2kGGhOWtqKVXvAk2DAup+goc+suR
         npx6HaghPUh1ihxQDkr77+J305yacck/1Jeml6or8fdEgF1TCdcoBhpS6cEKzvMKsEtN
         br+0KTK93HVvaaZga8GKuaXJdJY0tBS7tg5tJ05Orqt6Eh3oNzy6rzTVpIiEC9ktY2Zs
         B9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=xYGzMxRAxOWgti5WCEmM60iHs6aJW8WP1nteBa7KfMQ=;
        b=SC6yxdIbCJ47AROrIf+PEI20bGahLJ37ywsRz2/gfvjgS5BNV0ySRLU3GhjcfkgO+f
         1WiYO9mD8BTNpTuSLfjEFFnKU83cCkFttNIg/Ik85MAoOORAG5XZOgRRdKHYrLZQjMx9
         Z5J1uVa7lYydO1t2LSvWU7sanQtAMg7iZA2rYPHTexwrFaMFflCTOOwfUurpS47oR2gh
         otogF9stPv8eMZjgXYIIXiC8tpHBLDjMP7XP2+RIIJe6PVosC0T/BDGH5ZDpi3J16t7U
         7s8ZPZRK0fdEB9hWbPwcCFJnCpAYO+Ko2/FjrB0ox4CHU5X5uMmnUyy0kmhdMAlB+pfa
         zrXA==
X-Gm-Message-State: AODbwcDQci0TfsFzZjqkdlEl9NWaodBN2KleYvBb0bqHotYNTqigLGIx
        +X41Y3YkMEvLOg==
X-Received: by 10.84.217.218 with SMTP id d26mr41542871plj.47.1495600958587;
        Tue, 23 May 2017 21:42:38 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:167:7063:293b:a24d])
        by smtp.gmail.com with ESMTPSA id 204sm3970561pfu.19.2017.05.23.21.42.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 23 May 2017 21:42:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Simon Ruderich <simon@ruderich.org>
Subject: Re: [PATCH v2 1/7] grep: don't redundantly compile throwaway patterns under threading
References: <20170523192453.14172-1-avarab@gmail.com>
        <xmqqshjzqe9o.fsf@gitster.mtv.corp.google.com>
        <20170523192453.14172-2-avarab@gmail.com>
Date:   Wed, 24 May 2017 13:42:35 +0900
In-Reply-To: <20170523192453.14172-2-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 23 May 2017 19:24:47 +0000")
Message-ID: <xmqqvaoqhnlw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Rather, it's just to make the code easier to reason about. It's
> confusing to debug this under threading & non-threading when the
> threading codepaths redundantly compile a pattern which is never used.
>
> The reason the patterns are recompiled is as a side-effect of
> duplicating the whole grep_opt structure, which is not thread safe,
> writable, and munged during execution. The grep_opt structure then
> points to the grep_pat structure where pattern or patterns are stored.
>
> I looked into e.g. splitting the API into some "do & alloc threadsafe
> stuff", "spawn thread", "do and alloc non-threadsafe stuff", but the
> execution time of grep_opt_dup() & pattern compilation is trivial
> compared to actually executing the grep, so there was no point. Even
> with the more expensive JIT changes to follow the most expensive PCRE
> patterns take something like 0.0X milliseconds to compile at most[1].

OK.

> The undocumented --debug mode added in commit 17bf35a3c7 ("grep: teach
> --debug option to dump the parse tree", 2012-09-13) still works
> properly with this change. It only emits debugging info during pattern
> compilation, which is now dumped by the pattern compiled just before
> the first thread is started.

When opt is passed to run(), opt->debug is still true for the first
worker thread.  As long as opt->debug never makes difference after
compile_grep_patterns(opt) returns, I think the change in this patch
safe.  I do not know if we want to rely on it, but we can explain it
away by saying "we'll only debug the runtime behaviour for the first
worker only", or something, so it is not a big deal either way.

Thanks.
