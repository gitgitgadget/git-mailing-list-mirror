Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D9CC433B4
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 08:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1256C61369
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 08:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242673AbhDMITg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 04:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241675AbhDMITg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 04:19:36 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E47DC061574
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 01:19:16 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id mh2so2954693ejb.8
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 01:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=oXFfKfo/3RzGyTDNpPts9dh/ZcM1SB0iEF8y0CBuK0o=;
        b=NbQNISP/l0qPsjAfFLl1yVN9YZwwlRrp+x2Np6kOY75ukVtC3PfMVS3dDNZxUxr8h+
         RT14/USb3RctcLsOdSEg/M0Au8fjE7nKdX8WYZqq3eX1TAZLdl5nmpLFu/9zhGLmTRjS
         hTOsrBH+mxd8wrq1UUnyvG8E462JqL5+4rdGQNx6dk162HeQ8aGFAq9uJPVKX3SKWYpb
         HQimnbGBwHhNhWMy3wCEdLJoDICp5yJGlr1fMW73MmFaHaI2lixrvtrlETps3lNuwv96
         BUmJAKqXJS9m2bcqfGVGlp47Er+A+N65fYr01WR0vy6YyRpSkPiz90moSM14hQr2zCjF
         iJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=oXFfKfo/3RzGyTDNpPts9dh/ZcM1SB0iEF8y0CBuK0o=;
        b=PV5qxBY8yCEr6Ax9pmiss11kTxu4WBGl9FHGSyEr6JhqGqMnxVpOtJkKvmUEtQchXG
         rRiBwDkhh9zx7JVOZwPn+cnFcCctybJN4PFg1UpqXbe+2t88JkaqS1C0R8uRyXSDiPFD
         F/xOARmfe+uMsLrs1+q3PIb6pctAKUSNEShmGWBd1D9lApKvjiIuxHWC2PImGdsp2HI9
         EKD55TOZWEAFOVg8g5sh5ikO291TQTvnUSXwJbxJC6CfuxR3iNcSGFiguUo0YXOpMUHz
         EAiMXSR1/tUNWxaKIx+cCBkpkPb3ml9gpO+qhsvM2jxvN8UcGqFhPVL2o3nXjNznB0oG
         awqQ==
X-Gm-Message-State: AOAM532SiAfXIWbFVuIQSkJuuSpZ+yQ8mX/6UnoBUPbe7fFYI9WRY0h7
        gCrVbkI8cXpARf4X0sQOI3tOsE4wfBbJvw==
X-Google-Smtp-Source: ABdhPJwdDAjd9pRGhV1foAx9sJXUxZWbRyC8d3HwisZ0HrsNLAFsgIIJ9FTXzf3io1QOBi58/I1iUQ==
X-Received: by 2002:a17:906:7c9:: with SMTP id m9mr12802897ejc.54.1618301954825;
        Tue, 13 Apr 2021 01:19:14 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id o17sm8518689edt.10.2021.04.13.01.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 01:19:14 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v6 07/20] reftable: reading/writing blocks
References: <pull.847.v5.git.git.1615580397.gitgitgadget@gmail.com>
 <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
 <9297b9c363f6d922443d261375759046e303351d.1618255553.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <9297b9c363f6d922443d261375759046e303351d.1618255553.git.gitgitgadget@gmail.com>
Date:   Tue, 13 Apr 2021 10:19:13 +0200
Message-ID: <87a6q2egvy.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 12 2021, Han-Wen Nienhuys via GitGitGadget wrote:

> Includes a code snippet copied from zlib
> [...]
> +int ZEXPORT uncompress_return_consumed (

Pending the "how is this integrated?" question I had in
http://lore.kernel.org/git/87fszuej8y.fsf@evledraar.gmail.com it's a bit
odd to have a "compat" we unconditionally compile.

Since this is for post-2017 zlib doesn't putting it in top-level
compat/* and having a flag to enable it make more sense, and then not
renaming the function.

Thus those who need it will have a symbol conflict when they upgrade
their zlib to not need the compat wrapper, but that's a feature.

> +    Bytef *dest,
> +    uLongf *destLen,
> +    const Bytef *source,

I see this is modified from upstream's which would trip our
DEVELOPER=*-only -Wold-style-definition under -Werror. We have other
disabling of flags for compat/* already, seems better to use the
upstream source file as-is with that.
