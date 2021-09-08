Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D4AC433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 16:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0750861154
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 16:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347311AbhIHQZU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 12:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238352AbhIHQZT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 12:25:19 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4633EC061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 09:24:11 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id y18so4056777ioc.1
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 09:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=BxTQSwElcL0hNV6sJWXFIm2sZcfSAmx56RdqXvADtTg=;
        b=FXPsuzUWj7r57AJxciym3vFn7dxVR5zjgQDufapSMxvC5hYadUItbnHvKiL7Rx0hgi
         CHo/cC6pxMITMTGdSURzb/UjAC/cWQvbqYMG1PwwTGSHbDKchbvv+TwKR0QfSIqEAxwF
         g3O7MU9vxoBpG64M3cph5SIaktGXS5hVZwH3cQpHMzZFPm2Kupka2VhD4vBuSelkX9hv
         jgktfh+Th+YoD2OvTs0MQGtCXe64TVC9F0TurGAhpYMh7qLgQF4AuwWLt45L56CNS5Rv
         /qgS1/gqrMZDWVJ4DoPX70k660MHRfzuxca/606/U5i5Ba/ABBZKibBqin6FZTY7ZBfg
         hiRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=BxTQSwElcL0hNV6sJWXFIm2sZcfSAmx56RdqXvADtTg=;
        b=3I1M51hb8MGaaPOYAZcNY4aWoCmZxa9YoL91BfQLNz8lc+vjPft+qUwcEq+FMUbcfB
         TZFJLL6hEZCecwImXyIVvI1fWPJz0FEAzYQzpmKtxy8PpoaHj+Joz3FxUxKZvBKj+nFK
         EyY1dRC1542NoLvlCGUGi9GKs8Llz6oB3lkJu6rJddhV4uES13XN1vo6bu4zgqoyt0N6
         1mFxsffO4kyt699lkG6ZN6hS0+EdMxC9a+XxLkSDNqF6esqGj9CJzeYowJ3owXPJ7L9P
         v6L3bxTTkEnWfTFlaaPmhptCmAcz4CLbuAdS29xqpIN8WzIfBHn30rMRLvzohM1E60VL
         4aww==
X-Gm-Message-State: AOAM532BWp48w2fJ9nkUk2a0HvOtXtHxHZRTA4H7HPANz5U3wvLsrATE
        ASxn3yHbQ2jVfMbbYGY53lKIWMYOOssGjb0E
X-Google-Smtp-Source: ABdhPJwt0eubG9TdnCbnAkIxSdC+tncQwzy4oVuZdlP/0GRj8J4X8bxfJKHOdA8GFm5YBTXoQ1yG1A==
X-Received: by 2002:a05:6638:1384:: with SMTP id w4mr4444865jad.21.1631118250591;
        Wed, 08 Sep 2021 09:24:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x13sm1436080ilq.18.2021.09.08.09.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 09:24:10 -0700 (PDT)
Date:   Wed, 8 Sep 2021 12:24:09 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2021, #02; Wed, 8)
Message-ID: <YTjjqV/4/oceM3lM@nand.local>
References: <xmqqsfyf5b74.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqsfyf5b74.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 08, 2021 at 08:38:55AM -0700, Junio C Hamano wrote:
> * tb/pack-finalize-ordering (2021-09-07) 2 commits
>  - builtin/repack.c: move `.idx` files into place last
>  - pack-write.c: rename `.idx` file into place last
>
>  The order in which various files that make up a single (conceptual)
>  packfile has been reevaluated and straightened up.  This matters in
>  correctness, as an incomplete set of files must not be shown to a
>  running Git.
>
>  Will merge to 'next'?

Ævar has a series [1] that complements this one nicely, so I would be
happy to see them both queued.

I had some suggestions inline, but I don't feel strongly about whether
or not they are implemented.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/cover-v2-0.4-0000000000-20210908T003631Z-avarab@gmail.com/
