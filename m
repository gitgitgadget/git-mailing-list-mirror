Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5979C28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 16:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8372E208E4
	for <git@archiver.kernel.org>; Wed,  6 May 2020 16:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgurbiQE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730355AbgEFQbh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 12:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729927AbgEFQbf (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 6 May 2020 12:31:35 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C9BC061A0F
        for <git@vger.kernel.org>; Wed,  6 May 2020 09:31:35 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d22so1335030pgk.3
        for <git@vger.kernel.org>; Wed, 06 May 2020 09:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kyOw6ldJRhJL9TEawrp8CUm4Cq4IEn61sXZo1XCcN9k=;
        b=FgurbiQEzpDaboJW+rtJ7aYh0HpfsMkBbf95Uc5U2qSrBPTDvOqgmeaJh+rYIXdvfJ
         Xu0Idt3FYEfZHuWO+IPdXXFUrx/tu7dRN5cfVIy+qpTnsHUfi0l70AN1CXEvsvs139CW
         g8Rf94eN9d+UQkQQQLfiqGVu9UvLIxp2YFKYpAM1ktLrUbUxSEFCBr4YcEmf3SaXFAQX
         Xck5/d1fG8zbmJ/C4Wshejlor/iCa/2FhcbhZcbkjEK6aqoRWWn90hjHKTMRJS22ejDc
         vEIAQffqdnOjp3E52+32C9ez+iHnPTq1leM2r0NezWm/cI9IMNHYiYHMRn20XkOGmMhN
         2AgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kyOw6ldJRhJL9TEawrp8CUm4Cq4IEn61sXZo1XCcN9k=;
        b=hKl5y/LMkG3PZ0MN+J8ceKBO+8mu6VKl/b5mAhTVidxM2VgfG22rybcC6ijUQxo0qK
         WFRb7y/hh316dF2+0OBR1SC2lX6b3T33SR4SAUuJI7TMGhfWpBN26U/2jNyslxV+NSGq
         dHQRX7dIQjg2BGs/mz6cIT91sfBWUXSDgZZli9s/1HJeLJ4xcd7cfL+5x1CcJ+VKIEcl
         wICdD678OTy2YP1LFDrgdEKnGLplRMO3mAJ9SeI9TIS3y4GeJT+0XR8GM8irR9yLtxvR
         cs0X4WyjWA6+RY0xl1gADsPl5J4bnKkwARul2GVPVW9DekGtGlf/bFM/4jXlU6GaGnuW
         56rA==
X-Gm-Message-State: AGi0PuYHdaJ5BBNd+JhXnzvgPLmRFEs+Rj8Ig1j+kcj9HdKaR/ixt/YC
        HgVPdWsOYwHlG36idGRPT/w=
X-Google-Smtp-Source: APiQypLmRyzLRwoA51/iHHCi04jhmXq5/FA9VMGiAA//YjXt8ToTgT0MgmLNI61kMbqW+EmniuZKgg==
X-Received: by 2002:a63:a36f:: with SMTP id v47mr7594405pgn.242.1588782694537;
        Wed, 06 May 2020 09:31:34 -0700 (PDT)
Received: from konoha ([103.37.201.172])
        by smtp.gmail.com with ESMTPSA id n30sm2288280pfq.88.2020.05.06.09.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 09:31:33 -0700 (PDT)
Date:   Wed, 6 May 2020 22:01:28 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, liu.denton@gmail.com,
        kaartic.sivaraam@gmail.com
Subject: Re: [PATCH v4] submodule: port subcommand 'set-url' from shell to C
Message-ID: <20200506163128.GA14899@konoha>
References: <20200506073717.9789-1-shouryashukla.oo@gmail.com>
 <CAP8UFD0o7WwibV8+cwYOO949BkBggSphi0zbgPUZsk6nfvYyHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP8UFD0o7WwibV8+cwYOO949BkBggSphi0zbgPUZsk6nfvYyHQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/05 10:09, Christian Couder wrote:
> > +       strbuf_addf(&config_name, "submodule.%s.url", path);
> > +
> > +       config_set_in_gitmodules_file_gently(config_name.buf, newurl);
> > +       sync_submodule(path, prefix, quiet ? OPT_QUIET : 0);
> > +
> > +       strbuf_release(&config_name);
> 
> Nit: it might be a bit simpler to define config_name as a "char *",
> and then use xstrfmt() and free() instead of strbuf_addf() and
> strbuf_release().

Apart from the simplicity purposes, does doing this aid in performance
in any way?

> > +       return 0;
> > +}
