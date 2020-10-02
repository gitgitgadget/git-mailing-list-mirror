Return-Path: <SRS0=3i0n=DJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB9BC4363D
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 04:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DF3B20780
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 04:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i38cBnN9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbgJBECE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Oct 2020 00:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgJBECE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Oct 2020 00:02:04 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB86C0613D0
        for <git@vger.kernel.org>; Thu,  1 Oct 2020 21:02:04 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id k13so367290pfg.1
        for <git@vger.kernel.org>; Thu, 01 Oct 2020 21:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EF27T1UintoX01htfTJJgRVpQxbYYvErde3QBUeDk+o=;
        b=i38cBnN9/mhEO0gJfiWWfAFSDiGi3C7FlxThM3yvjweTPEOFxSNrxuL6dTu6VFt+by
         dJmA6x6CthW30WBgQ+0fxGukBcF8Cz/aQLO2zU+4nZeSa/jaovvGWulk0pG4ReUfEsP6
         IWstAYESQO+YkBb5ngbJ92VbGOOvl8YIJHfTQixJyoRyGBFJdJ3v5SOTdY8vV/CX4nhY
         vbIlTBaJgDYqkkc04eXWFjJz859NstEo+5+Ss60LDmYAQzVPVdAX6Zp1On9gW/5ggTQ3
         bJHQ0G4cEC3vOsu1tkk/x5D20myMOmash/tFjpSNMLAfYg7zBIc+p0kQIej7AYWvfsI6
         56TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EF27T1UintoX01htfTJJgRVpQxbYYvErde3QBUeDk+o=;
        b=MbGPfTRQxGz7WjVuitjXqTPxxh026IsWK/I/WuRBKMOxiOp8R6J4/7qNalElFmUBxq
         hh5WL0p2nAOD9epQAf981o/fU1lQ4q+bvc0LYXcyONsOyydLDA/kgmy6UntHAntUwga0
         5ObqhIBY6K9YsBBj+q9ayy8L7v2Y7yFjdObHsldIsz1EfwUJLeTDt5Fr6JTwFRh+EyN4
         Y42iNp6wk58tB0zeN7TTEFrW8EcpX5P/fvEcjBNdfFaefOv701X0FHxqIzAKzi7z4Bnh
         NQnMVgcKFV+9XO1zsrMHu89Ye9MPdvvLZqme3wvWg3CYYmpm/MYRy7XTjLz78nIH1kTj
         irLA==
X-Gm-Message-State: AOAM531pGshXpL3gkSTNNuuN0sIWJEy8SfgecFfwlxRVG507so6C4Vdh
        R99zMex0KXzbjMjCIsNakxs=
X-Google-Smtp-Source: ABdhPJyhKQ0Mpsw20EFdOClIU1IuSaA4GYruvEQ5emnY9TaF2/X5wuKe1okqo6NwoMWeVA65+ohDHg==
X-Received: by 2002:a65:64cc:: with SMTP id t12mr256308pgv.106.1601611323436;
        Thu, 01 Oct 2020 21:02:03 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id 137sm119215pfu.149.2020.10.01.21.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 21:02:02 -0700 (PDT)
Date:   Thu, 1 Oct 2020 21:02:00 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 03/13] vcxproj: adjust for the reftable changes
Message-ID: <20201002040200.GC3252492@google.com>
References: <pull.847.git.git.1600283416.gitgitgadget@gmail.com>
 <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com>
 <01a669a731dfce02c714a40af999b100c75815e4.1601568663.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01a669a731dfce02c714a40af999b100c75815e4.1601568663.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> This allows Git to be compiled via Visual Studio again after integrating
> the `hn/reftable` branch.

nit: This branch name is no longer meaningful to the primary audience
for the commit message (people discovering this commit in git history
later).

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  config.mak.uname                           |  2 +-
>  contrib/buildsystems/Generators/Vcxproj.pm | 11 ++++++++++-
>  2 files changed, 11 insertions(+), 2 deletions(-)

Can this be squashed into or put immediately after patch 5 which
introduces the Makefile?

Thanks,
Jonathan
