Return-Path: <SRS0=qItC=6C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10484C2BA19
	for <git@archiver.kernel.org>; Sat, 18 Apr 2020 03:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC2E3221EA
	for <git@archiver.kernel.org>; Sat, 18 Apr 2020 03:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKuhrv59"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725796AbgDRDW4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Apr 2020 23:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725320AbgDRDW4 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 17 Apr 2020 23:22:56 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BE0C061A0C
        for <git@vger.kernel.org>; Fri, 17 Apr 2020 20:22:56 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id c138so2032450pfc.0
        for <git@vger.kernel.org>; Fri, 17 Apr 2020 20:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ywgd6H5lSMz+fUOttCIWbrB5VUnqo2XAuzuN3Xzu7Us=;
        b=dKuhrv59JivIYkmh2BUF3Uj8OPy3M2Oz+dVsYBXlwrmOfF7+Q1lr8aSQyMDTcXB5fx
         azG+jDONCHqcRGldbK2tEMMSaVorNddB0251aiVMYfdStbSAgRwXsd/dET5wR+ImNAXt
         UXrxv0ZAUTrWl9ODQj9R1nhgRrtZ7CnXPNIPR7SNCtz7DPRqQ0Hdv+gEWiUbJgLrU/HM
         drK0Nd7T0FJJME6VSR3zq7ZnIukU41xW+Y0eoku5Jdiz0MX2eHFXoGPawNujONGNE5Df
         QIFTowF3K8oLkO5Q+qeRYPqjpPqA9n5w5ehsoOAtkGYAwEPDLf4XAMKmDDVGxYlbCLt9
         YvCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ywgd6H5lSMz+fUOttCIWbrB5VUnqo2XAuzuN3Xzu7Us=;
        b=r+onJJbJpcWkcQ8wqZ9++/60kxi5q8nerHV7l57iGJXmXlyJHG3wtjBRMgn5LBT7VS
         GaEtycHqBLMWlaQMq0mkeMK1qp/qC7LnP+VImHhk6M994SLkRzFM0+z2HwR43ZodQ3t6
         evdbBgbvsK3HqkDggXnQHjNNgt+0vgitw/8m+zfWje+B0UZEagxGzTlgGtm+7IpxvRHe
         YuuxyRHwOgltTSH4mh9JXwIGqHFj7gV0uyiB6E3A7P1Jf+K9+owKNWZ3bmA6Unnc7Eru
         Ni3Mv2h6xKiHgiUKPdwYwtoHfY6jQ0u7b6cecTnS0Jvyj/t2ENkjeGSQv7rr0ptWHM8e
         wloA==
X-Gm-Message-State: AGi0PuaGMPa0SA7/9bnQNxiOWcuPe7LgMuqD/gKzBOJN/kWZeQiWKAI7
        H89rgz17Qb31Ulb6ZIfzFDI=
X-Google-Smtp-Source: APiQypKC7SZWrAuVfnALmHKEAX0eferCxo2Hc8pOWD3lBuLMONKmBjhEAQk1nvlRQsvUGzPswl+ecg==
X-Received: by 2002:aa7:8649:: with SMTP id a9mr6405525pfo.138.1587180175488;
        Fri, 17 Apr 2020 20:22:55 -0700 (PDT)
Received: from localhost ([2402:800:6374:5380:b9e1:93e1:68db:b9f6])
        by smtp.gmail.com with ESMTPSA id f10sm1684214pju.34.2020.04.17.20.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 20:22:54 -0700 (PDT)
Date:   Sat, 18 Apr 2020 10:22:52 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v8 0/9] Reftable support git-core
Message-ID: <20200418032252.GA9169@danh.dev>
References: <pull.539.v7.git.1582706986.gitgitgadget@gmail.com>
 <pull.539.v8.git.1585740538.gitgitgadget@gmail.com>
 <xmqqmu7c49b6.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmu7c49b6.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-15 16:29:33-0700, Junio C Hamano <gitster@pobox.com> wrote:
> "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > This adds the reftable library, and hooks it up as a ref backend.
> 
> Since I queued the topic to 'pu', I needed to apply these fix-up
> patches on top.  The change to the Makefile is about "make clean"
> which forgot to clean the reftable library.  All the rest are ws
> clean-ups.
> 
> There are build breakages reported on Windows, with possible fixes
> (which IIRC were reported to segfault X-<), but I do not have URL or
> message-IDs handy.

FYI, it's also segfault in Linux even if only the test is applied.
IOW, the code to fix breakages on Windows doesn't affect the segfault.

Here is the message: <nycvar.QRO.7.76.6.2004101604210.46@tvgsbejvaqbjf.bet>

-- 
Danh
