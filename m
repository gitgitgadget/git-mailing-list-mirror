Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88176C2BB55
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 16:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ED84206F9
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 16:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="pWNbC2Es"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbgDPQcJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726307AbgDPQcF (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Apr 2020 12:32:05 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EBCC061A0C
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 09:32:04 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id a23so1544566plm.1
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 09:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x5K1lJ/qLq+saeNX0p9fY04ipJhjcQ5zABwAgqtMq2U=;
        b=pWNbC2EsC9B/Y6HrStmRW7B+6S17XI76PBUl5GKkk49+KcSGJpxllAEUBopzLkGuH/
         FkWMW4IZdhBvRk+aU+Z8mR8k38zdUS7+22faTOVGY5KOthrqLiNF9BuQqx6c66uFr1w0
         JuzDCjilDRyx6tqnnqfRA2yGJEsjF5SzLCtnWHl+C0B6kELWdFnVphoCoPRgzAJprain
         1najhHhtApoe/m9N3Ac4VQu0Abffq3ulekhlM7BOYNAXyB6RGFIFWkkYauGtF6IRU43f
         iA915Nxx4DvpPy3IW+SpdqPSlvTkDHv6KL2t+2kR/eYiNcpaXv9IIC+/wTk+pENA2Z7D
         I4FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x5K1lJ/qLq+saeNX0p9fY04ipJhjcQ5zABwAgqtMq2U=;
        b=ZHE6t+hraG8UlQAH16umN5owYgX4TnQycVKmzTA/iTSXC95JurHzMKq/ZGFN/dgMVu
         aRUMB/iy8o+WsXypKQ3oU7N4+87WF9j/UxJA6BS6E6dDxNqymLVEvFgkfjo3REIQiuFU
         ET0IUD13ylVbd93Pqe+f3X9lfxlogQsJ1VO9St19Fslp9B3gG/H2KLy/xURh7DfFv5T8
         w685s2QWgXOyWsG+EnhXG1siU46RA9X0vyuBcZAArj4l1s3jkADas7sWkF1X/gaa9Slq
         sU9dc+aNTYw8iRXjZAptTYM5H55OgTRS0WMn3DFYHdhzyiKSzpq0hbG1kKaFnXg8oQVI
         nteQ==
X-Gm-Message-State: AGi0Pua/T1TUeSdZsIxe/7i192RA3+cGpdOkXmrWlDfWfLAj1+bjnyAG
        bZ6aPoUxCT4l4ZMdkcSTQA98I2VA5p6kLA==
X-Google-Smtp-Source: APiQypLKd83mAS6lOcU77qyrA0jOioBM9kgIlgyK0S8YivVnmSEJ+OMyaHFTTy4zUqrJe0aJ+xZDbQ==
X-Received: by 2002:a17:902:7449:: with SMTP id e9mr10306491plt.140.1587054722643;
        Thu, 16 Apr 2020 09:32:02 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id d5sm17262401pfa.59.2020.04.16.09.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 09:32:01 -0700 (PDT)
Date:   Thu, 16 Apr 2020 10:32:00 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git Test Coverage Report (April 16, 2020)
Message-ID: <20200416163200.GA78342@syl.local>
References: <c797df50-ec21-98a3-58c4-ade0c04284c9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c797df50-ec21-98a3-58c4-ade0c04284c9@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On Thu, Apr 16, 2020 at 09:57:07AM -0400, Derrick Stolee wrote:
> Here is today's test coverage report.
>
> Thanks,
> -Stolee
>
> [1] https://derrickstolee.github.io/git-test-coverage/reports/2020-04-16-commits.txt
> [2] https://derrickstolee.github.io/git-test-coverage/reports/2020-04-16.txt
> [3] https://derrickstolee.github.io/git-test-coverage/reports/2020-04-16.htm
>
> ---
>
> pu	89b51f611e0e8e10d254fbbfd738adc6d1ea1764
> jch	c58d47de3eb380e6178eb51a4dc97aa59ddd5ea8
> next	55bc3eb7cb9c200ab95bbd2415bc0a35fbf29053
> master	efe3874640e2e58209ddbb3b072f48f6b7094f34
> master@{1}	9fadedd637b312089337d73c3ed8447e9f0aa775
>
>
> Uncovered code in 'pu' not in 'jch'
> --------------------------------------------------------
>
> Taylor Blau	fdbde82f builtin/commit-graph.c: introduce split strategy 'no-merge'
> commit-graph.c
> fdbde82f 1777) break;
>

Good, it looks like the other spot that I was worried about went away.
That was easy ;).

Thanks,
Taylor
