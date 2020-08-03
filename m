Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE879C433E0
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 19:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 231EA207DF
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 19:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="DKl5kXpP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgHCTCO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 15:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgHCTCO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 15:02:14 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FECC06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 12:02:13 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id j10so11158838qvo.13
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 12:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GWIAjSuLk7YDImUx1SgdM+zVO0L7gmsIr0gnhI4p22M=;
        b=DKl5kXpPY3PEnlnq3uonjkeFF7uiBK7qUFWD+I2KalEw8oEhMetrqMflXGZc3c8ots
         /sTu3AT+NiD/Dt9zsGzNNEOEY0cbcK8I7Q1v9paP9ME2GshbYSOGP94+Jpr1j3y+Xe2X
         EM5waFyic9kajM0ow8yiHPB7TD7jk/d6vH+Rj298hIrBPYJs7OLw5ZbRErrErrB94LNg
         MUHREKa5xIVc42GViK54+MQTHZ09S+7iF4Lvf/sUCI3g0b5P7b8/5ZDTRQ6BcHQL1jJ4
         fjdBC+hv+qfvwHHs6mwl9DXuftJO7qlocTCF5Oa+dPlyEkOCJeUCjCyqEz+Md3sJ6q53
         TgVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GWIAjSuLk7YDImUx1SgdM+zVO0L7gmsIr0gnhI4p22M=;
        b=t23yqUyhDre0Rj5sTI2TIzTv8h0AtSp5ylFtw2f1DLEe9ThBzBgeAZ5wfBVwiJW6pE
         jZ0G6VPD9D90l/962r8PBc+32xi6EKtXRak+0YIV9BkywQVYEm9vA+9jcuxgBlzerw2z
         5H856G4qA0l16RTP168rXXAIl7H4yVBjDe3QSUtMGBQ5T7H7iJ5NTQuRJZY8q4lXmsUm
         uPoYn2+MYLaKKMQF+Zz1ZflCu4z83/BLUIAG3cjpQswDaOnmK2Faajnn6d9QEC3eW6UV
         fC3eDn8/qyIv8ZJNafxeNH3/5cUS2KGPMFDKOZ866jkhg07PNm3zbzD25Vdk4NxCiD2S
         mxzg==
X-Gm-Message-State: AOAM532XmH2YzZZA760djsJr2w1GfVfjXsW7h6zhVUKTcZZ21kp+x2F0
        aBHv30azmjox7CNCjY+F0vGWhw==
X-Google-Smtp-Source: ABdhPJwG7o7agzAxLXBMcQuIFU7xogoxjKGAO0KcN4VHJmbNzfexRM7THkxhLLLSToK+qwJeArGiDQ==
X-Received: by 2002:a0c:bd8d:: with SMTP id n13mr9463680qvg.199.1596481333100;
        Mon, 03 Aug 2020 12:02:13 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:3475:b417:c07c:c811])
        by smtp.gmail.com with ESMTPSA id d15sm18970277qka.91.2020.08.03.12.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 12:02:12 -0700 (PDT)
Date:   Mon, 3 Aug 2020 15:02:11 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com
Subject: Re: [PATCH 0/3] commit-graph: introduce 'core.useBloomFilters'
Message-ID: <20200803190211.GA67539@syl.lan>
References: <cover.1593536481.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1593536481.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 30, 2020 at 01:17:36PM -0400, Taylor Blau wrote:
> Hi,
>
> Here are some patches that we have been using at GitHub to control
> whether or not Bloom filters stored in commit-graphs are read during
> normal operation.

I took the suggestions raised here and incorporated them into a
much-larger series that contains updated versions of these patches here:

  https://lore.kernel.org/git/20200803185947.GA67482@syl.lan/

This thread should be discarded, and future discussion redirected above.

Thanks.

>
> -Taylor
>
> Taylor Blau (3):
>   commit-graph: pass a 'struct repository *' in more places
>   t4216: fix broken '&&'-chain
>   commit-graph: respect 'core.useBloomFilters'
>
>  Documentation/config/core.txt |  5 +++++
>  builtin/commit-graph.c        |  2 +-
>  commit-graph.c                | 17 ++++++++++-------
>  commit-graph.h                |  4 +++-
>  fuzz-commit-graph.c           |  5 +++--
>  repo-settings.c               |  3 +++
>  repository.h                  |  1 +
>  t/helper/test-read-graph.c    |  3 ++-
>  t/t4216-log-bloom.sh          |  6 ++++--
>  9 files changed, 32 insertions(+), 14 deletions(-)
>
> --
> 2.27.0.224.g4cfa086e50

Thanks,
Taylor
