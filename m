Return-Path: <SRS0=xG8z=6E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075D4C54FCC
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 23:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D471622202
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 23:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATugLfk2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgDTXVI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 19:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726055AbgDTXVH (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Apr 2020 19:21:07 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E8EC061A0E
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 16:21:07 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id i5so2900424uaq.1
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 16:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pZ01hIo7LP/Z2mPXLsIPIG5aVaUEhFSJ19E2baHdrxs=;
        b=ATugLfk2zdOfSw7myn5RWYen3G1O7sKG84GY2WGcvRA8Jq9huozGl3pcytHSu2cbLx
         kNlxCDjGZlxtHPY/no2fgQKcbPNHm3kph9wXYCCzLsvUcPCRflMEhAIhwVm4DDZTOqQq
         9FzJXtHRueE4e01mlYoxEbkv0To0lNSnIBrwgsUbXveISdZaYI6tGEmu3g0JJhnyjDgF
         eaKWxPfcsmAjElbrhe6aLtSGZXmAntoYvxBbNwBQQ7qQGGZ5mTP0hoJmrzRrgaOu5jyP
         xWpjvwWnOm22Y46/lXC4MiCLOiffyyVizUGHJMq3MdFvnpfH4muhL0esm6+PVF+8A6bO
         P5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pZ01hIo7LP/Z2mPXLsIPIG5aVaUEhFSJ19E2baHdrxs=;
        b=O52cY3HJuz8HhVXIN04snnojam6W31iZrW+P8Kj21TNdPehY4qfPC11ZEOcQhuA/O1
         s8DF3c2C+LLpRbvPBb8L03LlUKBxUYCZ8aNByXPqVLlWpPAijZ1Lq8SeM6Ue3H+mO98o
         psI1tygEszxYzLWk5CpWfDNSsieD5ABUH6fVQ6y2KQMtSVpzAzJRuIBShDora5cefjNz
         /K0bwNT1hvH+UBcHcSO0Iew2dik9SaLoqSd2lCkQoRwkHntCKBVBAtE4hOzXlCOfOatM
         bri2A4RUPTAK5IeppraVr6eoWNHTRGvsIajn52OhGjbuX4QkLDuVRD5WnjNAT3TUn0r1
         R8kQ==
X-Gm-Message-State: AGi0PuYkzfEBy6VvFSlkukRHnbCkTURMdIOB+vdw5QMoq+GNvCpCQlNX
        r/fP2O76tQU8+Tbp9Dyu/7kYXoBS8cQpQrc9sNc=
X-Google-Smtp-Source: APiQypILElswZ39Cgp+p+vsaF1fqY281PuiJjlL/iBsb/mzt8/DUWpMt62lVgW2C0+1YavP2HWHcxsOXQAvg0ARAK8I=
X-Received: by 2002:ab0:6850:: with SMTP id a16mr9766335uas.43.1587424866570;
 Mon, 20 Apr 2020 16:21:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200420224310.9989-1-carenas@gmail.com> <xmqqa735rbyh.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqa735rbyh.fsf@gitster.c.googlers.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 20 Apr 2020 16:20:55 -0700
Message-ID: <CAPUEspiBqCGTOfEESAqY=JR5jHhARSAODjsg5rGLxWEqzFH0zw@mail.gmail.com>
Subject: Re: [PATCH] osxkeychain: restrict queries to requests with a valid host
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 20, 2020 at 4:09 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Just to clarify, you do not need this patch to "fix" it, as long as
> you are running up-to-date Git, right?  In other words, this is more
> like a belt-and-suspender protection, isn't it?

the fixes in master do most of the work, but the way the underlying
macOS function
used works, will still randomly select a credential for cases where host=""

Carlo
