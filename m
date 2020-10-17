Return-Path: <SRS0=oQO4=DY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD66C43467
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 05:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8C23207EA
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 05:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="UsIX8x+0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411786AbgJQFew (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Oct 2020 01:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411763AbgJQFeo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Oct 2020 01:34:44 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDA9C0613D5
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 17:08:42 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id p9so4621599ilr.1
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 17:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HHr3iHNpVY5w5oTZOpmMbETdfhYwmBgFy94xgAP4Ptc=;
        b=UsIX8x+0M4qsYA25GjkfQbzDqMLOQEl8TjS4Uj1n0Or1z0IbFMrXPPWp2JlXB0xT4P
         zqNfvOrcxPRJO4PyfqoVDdwGEEjQI79362sq63+58E+EkpQw0odHCueBEFnrTm+QJCQ+
         HIlTD9AKWKeu6bGUarCdVJjFcW86/MafsN6luldC0hBKGuLkaEuy4OWv690KIHJakGf9
         Cm/bfmaf4F/3ZHSXaNSlVAOUG0kgIiv6ytMSx75nbd4bZVgaawvVEKHDrCQwpt34so01
         yBXIzSH348ANzXLkQSFGAhTqRBfaS4CQzIIUAeHgzO14T4KAsCILuqSTNNFBP1HBy60+
         5P5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HHr3iHNpVY5w5oTZOpmMbETdfhYwmBgFy94xgAP4Ptc=;
        b=PlI+UsHDVlMB5U75m5U6uDooUqcYk0zK+zOBu2hAvxsaYBggYSX68OeQqbWYl/Oue8
         DOe47YBfxtiYqi3I2bIQa1MbzW++Qb6WjnPKey3GWiAGjjeJ32Ri6u5NkfO+wrqB45un
         vKghlgO6h7QXcvBU6QEgQmZ59VZrA0lrZucmII0pNctpWRlPGqHbooRDvaU33Vc+C0rB
         nMv6z73Uhz1UgiDWwo9T0d0nrWnaMjQjGVi+VAT4bXLtreCiN3SMHA1mrs9AmUnotz/w
         djGevlGizKX6mXrL/xD2WS9mOSDvMi62sNatg0SPnqC280I/EaA5oX9g3s5TITfNwcPe
         ZosQ==
X-Gm-Message-State: AOAM533Aaqtg0L2eHpOmwD6bXCf57vw/tszRCbcCniAt7Xvr7gCqdztD
        EYrl9WBaaU9SrVsE5BvUaC9gMg==
X-Google-Smtp-Source: ABdhPJwM6t5wHHq1Q3vejw3ubCttTmMDf1s+uyaCvGS6rozir4klSTq9/xJyifJmVOZ6NoVh5R1fcw==
X-Received: by 2002:a92:c88e:: with SMTP id w14mr4246983ilo.185.1602893321971;
        Fri, 16 Oct 2020 17:08:41 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:64b4:b8fe:39a9:61ea])
        by smtp.gmail.com with ESMTPSA id w14sm3373458ilm.88.2020.10.16.17.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 17:08:41 -0700 (PDT)
Date:   Fri, 16 Oct 2020 20:08:38 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] t7518: fix flaky grep invocation
Message-ID: <20201017000838.GA2211921@nand.local>
References: <pull.884.git.git.1602891594738.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.884.git.git.1602891594738.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Fri, Oct 16, 2020 at 11:39:54PM +0000, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
>
> t7518.1 added in commit 862e80a413 ("ident: handle NULL email when
> complaining of empty name", 2017-02-23), was trying to make sure that
> the test with an empty ident did not segfault and did not result in
> glibc quiety translating a NULL pointer into a name of "(null)".  It did
> the latter by ensuring that a grep for "null" didn't appear in the
> output, but on one automatic CI run I observed the following output:

:-). I have always been surprised by glibc's behavior here; I'd almost
always rather have a segfault than silently turning a NULL pointer into
"(null)" when formatted with "%s".

> fatal: empty ident name (for <runner@fv-az128-670.gcliasfzo2nullsdbrimjtbyhg.cx.internal.cloudapp.net>) not allowed
>
> Note that 'null' appears as a substring of the domain name, found
> within 'gcliasfzo2nullsdbrimjtbyhg'.  Tighten the test by searching for
> "(null)" rather than "null".

Yep; that sounds like a straightforward fix that will make this test
non-flaky.

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
