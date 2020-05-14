Return-Path: <SRS0=p0jH=64=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48FDC433E0
	for <git@archiver.kernel.org>; Thu, 14 May 2020 23:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF3CB20734
	for <git@archiver.kernel.org>; Thu, 14 May 2020 23:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vVacqHtM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbgENXa4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 May 2020 19:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727956AbgENXa4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 May 2020 19:30:56 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDE6C061A0C
        for <git@vger.kernel.org>; Thu, 14 May 2020 16:30:54 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id r22so84619pga.12
        for <git@vger.kernel.org>; Thu, 14 May 2020 16:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zwyXuDCIK7c4bxdl/vLJuCrvE2uBA3KvPZS8J6peFgQ=;
        b=vVacqHtMviYyQoXynuA9xZR4A/qsHktVJkS3aOrAAI1qtrO6PRqi/AEq0p1rQHhNPG
         TnUuI5oZ44evSJYJT3TuBRIOugyYVHZ71OvRrM+Q8cSnIjoSWXkDL2D0kc/tlBRpqk7P
         3jjYTkd3ghKEekBNHYyonRLvW4TJmtZZsFLvx8DFzxMR0uswGmupVfHZO1quE6NsxfS6
         naDw75TMZjraA1463LPD2xpKQjZRaUpnj8rwcZHzMBn2Pia2/FTmttUxawxAq7frT6Ap
         3+uOqgQ1bfxH1Z2POIf/LjpRDkryl/09mzSbTzDreNAwkhFmfl/fp3grQFMdqiTAE5Os
         JqXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zwyXuDCIK7c4bxdl/vLJuCrvE2uBA3KvPZS8J6peFgQ=;
        b=pfo2swYU1e8nxZRgZOVqVTm7LOw3Qdoaw6xy91ggTjAPukEPYb1Y0A8hpJH2EVrOum
         oUCfeytkggeQH4YLwzqX67jLCKKYrYb2zjVCIitZNpQ18Bw/euMj3u9sz8c33+JrLvBk
         b+CQuGZgVMqyHRzLbNgmKkvevgrMsoA8tp+YUh4FIVonT+BLC2+MNELr5r6Qk/8mWxsC
         Mvvj4r/ihL0N8BRBzafSsxeDwkk6Ek5pg18gimzGts/mTuOaR9lV0Mz3SpaazdtxBdUJ
         Hc0plfzExGpYeiWe3G+eDQQZV7gXV7pPugeotm/adtX4TW4P6p2ccst1I9ikHPadMe5q
         mDnQ==
X-Gm-Message-State: AOAM533v9iwxdtco5WmB84/JyNTynCyPo7Sm67WruS1HUKJfnEZPbRMz
        fTeSrfybvkv+wcLPHhHHLcvsh984
X-Google-Smtp-Source: ABdhPJwhCSTTg+ZnXWG9wZ7E7UUNq6dBZZVfFZ2OjZu1TkFsZ9EUrdmEcguQ7dvpf8LIh31tNegMVw==
X-Received: by 2002:a63:e550:: with SMTP id z16mr477198pgj.92.1589499054214;
        Thu, 14 May 2020 16:30:54 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id 78sm245238pgd.33.2020.05.14.16.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 16:30:53 -0700 (PDT)
Date:   Thu, 14 May 2020 16:30:51 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t0300: workaround bug in FreeBSD < 10 sh
Message-ID: <20200514233051.GB38566@Carlos-MBP>
References: <20200514210518.56101-1-carenas@gmail.com>
 <20200514220346.GA3074610@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200514220346.GA3074610@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 14, 2020 at 06:03:46PM -0400, Jeff King wrote:
> On Thu, May 14, 2020 at 02:05:18PM -0700, Carlo Marcelo Arenas Belón wrote:
> 
> > 4c5971e18a (credential: treat "?" and "#" in URLs as end of host,
> > 2020-04-14) introduces check_host_and_path to t0300 and some tests that
> > use it, but fail in at least FreeBSD 9.3.
> > 
> > The variables in the here-doc fail to be expanded until they are used as
> > part of the eval in check(), resulting in (ex: url=fill) instead of what
> > was expected.
> 
> Wow, that's very surprising.

And luckily, also a problem that is no longer present with newer versions of
the shell and neither NetBSD's or OpenBSD's AFAIK.

> Just to be clear, if you run:
> 
> foo() {
>   for i in "$@"; do
>     echo "arg:$i"
>   done
>   sed s/^/stdin:/
> }
> set -- outer
> foo inner <<EOF
> $1
> EOF
> 
> do you get:
> 
> arg:inner
> stdin:inner

correct, so the problem was in the here-doc, not the eval; thanks for your
explanation and reproduction, will update it in the reroll.

$ foo() {
>   for i in "$@"; do
>     echo "arg:$i"
>   done
>   sed s/^/stdin:/
> }
$ set -- outer
$ foo inner <<EOF
> $1
> EOF
arg:inner
stdin:inner

> ? (on dash and bash, I get stdin:outer as expected). I don't think the
> fact that check() uses eval() should matter, because we'd be
> interpreting that here-doc earlier as part of read_chunk().

indeed, apologies for the extra quoting which was part of my original
debugging and wasn't really needed.

will keep it without the inversion, only because I think it looks also
clearer with the added indentantion.

Carlo
