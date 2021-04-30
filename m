Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298B4C433ED
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 20:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEE256145B
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 20:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbhD3Ugu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 16:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbhD3Ugs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 16:36:48 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042BFC06174A
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 13:35:59 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id v23-20020a9d60570000b02902a53bac99a3so10778241otj.5
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 13:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=IDLloyxe2RmJqdvOSIIrUd9DJ9XxVTE4ASLuJpUIBKg=;
        b=Rt5V6ZwNXkZZg5WqFkFk5KG+kFPn1XBr2yRcF3mp0UW2aSL/8rLHi7CPwHNCQOYEOK
         z7j3tp2BNpyOVMGIVZunQKXeaN0H92t7KR1/9Y37TH5UHwXpmOgSqhESVE/9d636tFLf
         0p6CT1LLSbT8IiN7DNprulrLFL895J9xbV3qAi9qVUwu6EMRRjLrJrJocDnY1q2cbBKA
         xL7uYKR5rlgXduQkZ+Yw/ptuGwuGMYKMfLKskd4m+/NdRPYQR1jmsvakPM2a4ky6+Oll
         IG/R4uOEGmLR/o1lOtlghNVd4y84TyqRCm4rIJWTLN1qUVLbrsLaBwU7YpW/Zyg5btID
         yGjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=IDLloyxe2RmJqdvOSIIrUd9DJ9XxVTE4ASLuJpUIBKg=;
        b=EKvbra//1l0yUju8sfxxy50/BrqYtuyL8HAo30YSsvZIIrb8oNcicM99mJM8NtPpcA
         TZALHm36VF0hzFXysdFLeRIXgTLfLUPXHpaSbnrkd3UNBRNU8PIenZWG4YZc/lAqLv9b
         J3psIjS/91o8nB4XHav0os/QJ+aTz8i2peG8f2gg0JtsTehodFA+/tWhX9XuGpH+m7Ni
         jA2gKviyN78YcpfGNkr9ErgPlog0/tzqt9zeHXG47mQ98gzus/MmcpZVGGHEvb5RNrwC
         qmvz+kSHXOlJXNqkI11Clllr+6aMiTd+6KnOnngw8dSjYt8wkiSnZOAjrsufu9a4FJt+
         SvTA==
X-Gm-Message-State: AOAM531ynbf0zBLFfF73ugrp3uAXwe4Fk4vLbwn+3fhF7nGjRzc4pB1n
        PS501v9YfvPt+NpnRUbXe7o=
X-Google-Smtp-Source: ABdhPJwhD5bwCnbj5LYzRvM1t4h43x+F+00nnUefxCyAnbk368S95iqe+z+e+ijbA+dfv5jpWIfaDg==
X-Received: by 2002:a05:6830:1449:: with SMTP id w9mr802192otp.183.1619814958444;
        Fri, 30 Apr 2021 13:35:58 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id f9sm1015898oou.48.2021.04.30.13.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 13:35:57 -0700 (PDT)
Date:   Fri, 30 Apr 2021 15:35:56 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Raxel Gutierrez <raxelgutierrez09@gmail.com>,
        mricon@kernel.org, patchwork@lists.ozlabs.org,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>
Message-ID: <608c6a2cca7dc_2cb2088@natae.notmuch>
In-Reply-To: <YIYfsMsz0Uz48GaI@camp.crustytoothpaste.net>
References: <YHaIBvl6Mf7ztJB3@google.com>
 <YIYfsMsz0Uz48GaI@camp.crustytoothpaste.net>
Subject: Re: Pain points in Git's patch flow
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

brian m. carlson wrote:
> I find I'm often unsure what to put in the cover letter for a v2 or
> subsequent series.  Clearly people don't want the same thing as v1, but
> I rarely have useful information other than a summary of changes.
> 
> I have tooling to automatically generate the proper range for
> range-diffs in cover letters, but that tooling requires some sort of
> manual timestamp, which means I need to go search for my previous series
> to find the date and generate the range diff, or if I'm in a rush, I
> just have to omit it.  This can take some time, having to guess what I
> named the cover letter the last time and search for it in a mailbox with
> a 6-digit quantity of mails[0].

I wrote a tool to deal precisely with that: git-send-series[1]. All the
metadata in the patch series is stored in a text file (version, subject, cc,
cover letter, etc.).

So when you want to send the next version of your series you just do
`git send-series` and it deals with all that tedious stuff
automatically. You just need to update the cover letter.

It also keeps track of the previous versions of your series in order to
automatically generate the range-diff.

> In general, I have trouble keeping track of the patch mails I've sent.
> I do definitely need to refer to them later, but I don't generally keep
> them around on my system since they tend to duplicate my repository, so
> I end up needing to find them in my mailbox, which as mentioned, is
> slow and error prone.

I have my mailbox stored in my machine syncronized with isync[2], and
indexed with notmuch[3]. I can view all mails I've ever sent instantly
with a simple search:

  nmm tag:git tag:sent subject:PATCH

> I find that the git-contacts script is often not helpful to find
> reviewers.

git-contacts is a subpar rewrite of my original script: git-related[4].

Using git-contacts on your last merged patch I get this:

  Cornelius Weig <cornelius.weig@tngtech.com>
  Jeff King <peff@peff.net>
  Junio C Hamano <gitster@pobox.com>
  Johannes Schindelin <Johannes.Schindelin@gmx.de>

However, with git-related I get this:

  Junio C Hamano <gitster@pobox.com> (signer: 62%, author: 37%)
  Johannes Schindelin <Johannes.Schindelin@gmx.de> (author: 37%)
  Jeff King <peff@peff.net> (reviewer: 12%, author: 12%)
  Cornelius Weig <cornelius.weig@tngtech.com> (author: 12%)

Which is much more useful.

However, you actually have options to catch more changes:

  % git related --min-percent=5 --since=10-years-ago 75555676ad -1
  Junio C Hamano <gitster@pobox.com> (signer: 80%, author: 20%)
  Jeff King <peff@peff.net> (reviewer: 10%, author: 30%)
  Johannes Schindelin <Johannes.Schindelin@gmx.de> (author: 30%)
  Patrick Steinhardt <ps@pks.im> (author: 10%)
  Cornelius Weig <cornelius.weig@tngtech.com> (author: 10%)

This may not solve your paticular complaint, but it's clearly superior.

Cheers.

[1] https://github.com/felipec/git-send-series
[2] https://isync.sourceforge.io/
[3] https://notmuchmail.org/
[4] https://github.com/felipec/git-related

-- 
Felipe Contreras
