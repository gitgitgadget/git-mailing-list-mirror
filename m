Return-Path: <SRS0=WTnS=CW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DFAC433E2
	for <git@archiver.kernel.org>; Sun, 13 Sep 2020 10:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E0D1207BB
	for <git@archiver.kernel.org>; Sun, 13 Sep 2020 10:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ma0pFjR3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbgIMKwA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Sep 2020 06:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbgIMKv6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Sep 2020 06:51:58 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01149C061573
        for <git@vger.kernel.org>; Sun, 13 Sep 2020 03:51:56 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id k15so10219172pfc.12
        for <git@vger.kernel.org>; Sun, 13 Sep 2020 03:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5RN7juk6weluqwOGjdHLqyZ5IFqwNWQWlB4Ktq58VWU=;
        b=Ma0pFjR3MCFxM5CdwNR5uPKherm5rLAsTXPUEOCpF9D8r3wuKp5QyOQFPQ5LRuhAh2
         4xVQkN0u5civQHwkHjqxAd1SOxnyADJ0pQD/s9Y32LagWzaZBZo1jxDWIitVw+POcF/n
         eDmNtE0B9pPFT8bdn6R44nzy/dHr+bkvrz7fSj9jw61z6Ui1Ivy9SvtiGbYS9MyefWu1
         a+LIwDXal6RFTlaBWTHyaQyCYE5yiYGGVyejc6g4/pekFXYtUPxQ+txp6BKit6aREXul
         YbyYPz01uVm+95iC01r73kMshvgkdB5aQil+8k3fjyGlw1E9nqZTcYIruIVJknjadBjl
         j74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5RN7juk6weluqwOGjdHLqyZ5IFqwNWQWlB4Ktq58VWU=;
        b=dwLAOE6LQN9Mg1Dq1GPs3gh/IMBiepZU5gwXayvn0YhrGVvkKzvdm9ya/pF8JV4a+s
         TZ3dLt7x5W+uwz41Ps9dTE5E3vzqW2P3Jx/no031mlvSFclNLfECWZRbqM//2BDiLkP5
         DWkZdlAaqgKNC8C+apXRQcHX0QnTxpxTvQ4BIkl7Cb3V4rXE4CI4abV6pHEp1qDx2And
         M5EmgivL5oeJ8q+okXm1OZilXHLCS0HNH8x8sWY28qpMOkgYBJg/lPH4kJCubVs0dah0
         idxrnaPQ7OP/7YfSUuT4Ghhnnx9ejaqEHOX67q6fZ9XmYfpkMMAOwnOIOJRZt81f0qma
         /TeA==
X-Gm-Message-State: AOAM533lqdX0q5mqDRSarXsH9WsOE5Pr3K1ZjoYdx1tcaS6gMMqkDBp3
        DhFMt7C8kvQm0ySjGjvX4Kk=
X-Google-Smtp-Source: ABdhPJz3pCcGGJoGWPEh0CG1BAKVfFJH5kdJbyfyJeU7pSmfZyN5v3bv5vTldrFMf3X+nRQ8CWcGAg==
X-Received: by 2002:aa7:8084:0:b029:13f:b82a:1725 with SMTP id v4-20020aa780840000b029013fb82a1725mr7264470pff.9.1599994314947;
        Sun, 13 Sep 2020 03:51:54 -0700 (PDT)
Received: from localhost ([2402:800:63a8:edfa:1ca8:8e9c:e6de:6bb2])
        by smtp.gmail.com with ESMTPSA id l13sm6234978pgq.33.2020.09.13.03.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2020 03:51:54 -0700 (PDT)
Date:   Sun, 13 Sep 2020 17:51:51 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] ls-files: respect 'submodule.recurse' config
Message-ID: <20200913105151.GA18403@danh.dev>
References: <pull.732.git.1599707259907.gitgitgadget@gmail.com>
 <xmqqv9gms1fp.fsf@gitster.c.googlers.com>
 <45EB4E9E-1819-41D6-839E-A3812456478C@gmail.com>
 <20200913104703.GA2034@danh.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200913104703.GA2034@danh.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-09-13 17:47:03+0700, Đoàn Trần Công Danh <congdanhqx@gmail.com> wrote:
> On 2020-09-11 09:05:42-0400, Philippe Blain <levraiphilippeblain@gmail.com> wrote:
> > I understand, but I would argue that such a user could easily adapt their
> > script to add '--no-recurse-submodules' to their ls-files invocation if that 
> > is the case, no ?
> 
> There're people still live in the past, for example those poor souls
> still live in Ubuntu 16.04 LTS, they don't have the luxury of using
> Git with ls-files that understand --recurse-submodules and
> --no-recurse-submodules.

For this statement, I meant:

: those poor souls that needs to write script for both old and new machine.

Sorry for missing that information, and this noise.

> > > So, no.  I am not enthused to see this change.
> > 
> > OK, if I'm not able to change your mind, what would you think of a separate
> > config variable then, say `ls-files.recurseSubmodules` ? This would be more granular,
> > so less chance of breaking existing scripts, but still provide for a way to configure 
> > Git to always recurse in submodules, including for 'ls-files'...
> 
> If you're really buy into configuration and using ls-files
> interactively, I think it's better to make a Git-alias instead.
> 
> 	alias.ls = ls-files --recurse-submodules

-- 
Danh
