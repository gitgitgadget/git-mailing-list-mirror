Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00E8C43464
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 14:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CF8C208C3
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 14:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Wlu/Gnaz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgIROLa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 10:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgIROLa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 10:11:30 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4FDC0613CE
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 07:11:29 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id v54so5035850qtj.7
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 07:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R943XkCwTpUMBINKio74tLrmzUt79LxSRjE94YXgofs=;
        b=Wlu/GnazOZp266lzyRC2EJQZsDHGYWe0BWcX7vB3xoP6++dEQaQiVVYN3eF4R2Cx3P
         /+uwPPstukqW4pF08+z/1HQ9aPYaK0VSE5UPGxaZPEm9zQAVXL+T23x9JIzUv1gDjz59
         ffJegG5EYKfSSxLOVsO9VdpW4HqDZ70wmRBlMW5F7mtTQ57qHIg6xbMyEtZilb8e1JvF
         aXwske4UAo8ObwxAIHC8TMKaYbyV8T7LixWFatI6hs8qXwnMJ83E0tOQ7FPT/CUPWDYB
         kuPrWJcUMe+TwWS97t/IoVFvbmq5VtF+N++kMvvALx9yxuSq08nyHKaGkMQd/SDXtWMM
         xniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R943XkCwTpUMBINKio74tLrmzUt79LxSRjE94YXgofs=;
        b=RYbpaWQp7Wa01zIQoJuRw+UPliHz0xQ6FzdOg1d6XpC9tMyBEBS9Ma7qmpe0E7jJDJ
         RKC3Ht6bmgcQk60B0SBgPsEHbdF19N8w7EQ/A7u5Xj+4Arkdb7PzcO58gm3+P6WESyJT
         n3OqGf1q7CXGKkY1HQN2wUTOoBshegIjB//U0TJ1y+E61V6Se/uymVdUr06lB++/O1wS
         ZnLy9hVWbiPwenCwGsLsqEqi5N9Ri7nUCnPaMT99IY7DuEqhRGAWuVrCqJ9MVR9jlIn4
         qI9u0TxTsiFElxlUbVSkHjEDZGxesb72ZAPP/if62qwB2UlbRZ+9oJsSPwhaLS8nPGnq
         7cbA==
X-Gm-Message-State: AOAM530v6fWIX8HOFmsu0nB/OVeDVbKdYa9/GP44URXCZnwwUMKaJik4
        qyKKNixXdVU8TxsX0pdy7z0PypGf7TyxV0XpYLU=
X-Google-Smtp-Source: ABdhPJycMDS5perd5sHrPDU/B6H4xxZOoWzNRp/9FwcNQ0x9b43RctZzpijyNbk0exmXGf+d0SrglA==
X-Received: by 2002:aed:2646:: with SMTP id z64mr20337218qtc.194.1600438288988;
        Fri, 18 Sep 2020 07:11:28 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:2003:d617:ca70:4fd1])
        by smtp.gmail.com with ESMTPSA id 205sm2108889qki.118.2020.09.18.07.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 07:11:28 -0700 (PDT)
Date:   Fri, 18 Sep 2020 10:11:25 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 2/4] builtin/rev-parse: learn --null-oid
Message-ID: <20200918141125.GB1602321@nand.local>
References: <cover.1600427894.git.liu.denton@gmail.com>
 <004f2e4c92918a7a4e452d49e98ef15f1c5ac545.1600427894.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <004f2e4c92918a7a4e452d49e98ef15f1c5ac545.1600427894.git.liu.denton@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton,

On Fri, Sep 18, 2020 at 04:19:03AM -0700, Denton Liu wrote:
> When a user needed the null OID for scripting purposes, it used to be
> very easy: hardcode 40 zeros. However, since Git started supporting
> SHA-256, this assumption became false which may break some scripts.
> Allow users to fix their broken scripts by providing users with a
> hash-agnostic method of obtaining the null OID.

I have not been very involved in the hash transition, so please take my
comments with a grain of salt (and if they are misplaced, feel free to
ignore them).

This '--null-oid' thing makes me wonder exactly what it does. Yours
gives a type-less object back, but what about scripts that want the OID
of the empty blob or tree?

Would having something like '--null-oid[=<type>]' be useful for them? On
the one hand, it seems like a thing that would be useful, but on the
other, those aren't *the* null OID when 'type' is 'blob' or 'tree'. A
more appropriate name in that case might be '--empty-oid=tree'.

So, that's an argument that '--null-oid' and '--empty-oid[=<type>]'
should be two distinct things. I think I like that best. Do you have any
thoughts about it?

Thanks,
Taylor
