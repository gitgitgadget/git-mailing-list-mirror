Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AD8C433E0
	for <git@archiver.kernel.org>; Thu, 28 May 2020 19:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B5A1207BC
	for <git@archiver.kernel.org>; Thu, 28 May 2020 19:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sn7aqWyS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406249AbgE1TRq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 15:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405596AbgE1TRo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 15:17:44 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549EFC08C5C6
        for <git@vger.kernel.org>; Thu, 28 May 2020 12:17:43 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id p21so30106pgm.13
        for <git@vger.kernel.org>; Thu, 28 May 2020 12:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=alLQyYf4yD6jNhMfvoFDB0ZhJIYZiscpBM8I5g9ZlhM=;
        b=sn7aqWySFeyan8uGTS6yoQAJI6JSAYR6pd4/+m6kVRdn2EfYdgyomYw6sJqAi6xa5P
         yDirqAvSsaFolx3atTmJRf5SE4tMb7IWJJDg+gGD/o63gzuM2F1OGfbX7WzMggVUeVba
         0+uNbhoivCt7/b+uhvjXgySyEsCbN6cJ8iOuGDGBxU5dax+pE8HkxRkG/imPus1bnl/R
         DCh/l2lBKnnFF/0qNwUsdmNuGbX3rApmbHH0FKsEVTF5m/zaZ5tvB57wVzGrMoy8J0NE
         ubG3ZZ4JJQZVZhogC3+okLxMalIM1i49Kke7YYQjSHfZX7ziKECU+knowkNDRv11mFas
         5VUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=alLQyYf4yD6jNhMfvoFDB0ZhJIYZiscpBM8I5g9ZlhM=;
        b=eqDLC5XdEmiSRGzhBiZnIvEKO3hNh1JoecleGOW/Th0hqPEGHotkQA9hGkc+QoVl5z
         RTekuTJKSVCImMjzpcFP6ho1R80szzaIzA1BkrC0seRvorXCLKucfQR4MCw0tZU53MI/
         WsBaUsrfhStoOShdPmQokr4uqbWqpl4hKH2VcYMTxJrCKU7AWPwPD+PeuG+y2qfbTHQH
         KfLIsN63fxd2+/ZXgunNr0w9OJFwJ9z3qgYaRG6iF2RLWNqE3lpWHNv2ipjBEblYA2Xg
         wYqgGMhve8hsGDs5e4ZfyyvH9OXM1KHICJ9g2Yh8wvkMnE2xltGzYeNaNbC1DT6I/sHC
         UXdg==
X-Gm-Message-State: AOAM533stLB+TaVUSR6Zcwv+Ntk3x+1zlF9AIRMiyu7DCG/00c7uij9X
        Wy5PHegFfqG14dyTXBDACMQ=
X-Google-Smtp-Source: ABdhPJytH4WlD3yQVcgsTpSmHB0u7vpU3nn22KGTzH4JRoNA/6VpXfsS2zj79U6DqnNmvGt57ka/IA==
X-Received: by 2002:a62:dd56:: with SMTP id w83mr4787032pff.35.1590693462783;
        Thu, 28 May 2020 12:17:42 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id x62sm5319967pfc.46.2020.05.28.12.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 12:17:42 -0700 (PDT)
Date:   Thu, 28 May 2020 12:17:39 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Xin Li <delphij@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 1/1] fetch: allow adding a filter after initial clone.
Message-ID: <20200528191739.GA114915@google.com>
References: <20200528025359.20931-2-delphij@google.com>
 <xmqqsgfk3xtd.fsf@gitster.c.googlers.com>
 <20200528171924.GC58643@google.com>
 <CAOhzdugK7FQSnWruUrX8gQ98AF6kGvNWqPfHmE+qjGjBgzvmiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOhzdugK7FQSnWruUrX8gQ98AF6kGvNWqPfHmE+qjGjBgzvmiQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Xin Li wrote:

> I found that the current code doesn't really check
> repositoryformatversion for e.g. partialclone, so without setting
> repositoryformatversion to 1, just setting extensions.partialclone =
> origin will still make fetch --filter work and some test cases are
> depending on this, do we want to keep this feature/bug?

It's orthogonal to this patch, but no, we don't.

Thanks,
Jonathan
