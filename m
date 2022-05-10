Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F164C433EF
	for <git@archiver.kernel.org>; Tue, 10 May 2022 20:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbiEJUHE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 16:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiEJUHD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 16:07:03 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A834950B36
        for <git@vger.kernel.org>; Tue, 10 May 2022 13:07:00 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id v66so319914oib.3
        for <git@vger.kernel.org>; Tue, 10 May 2022 13:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dpbdWx6ZyaNtqRFnV2Nk49gopMsn/D9yK25L9/DBVxw=;
        b=LlUEFroIVc76PjocO/VwXjXfMc2ZYlk0JaRyK8BjhZfVKov3HaNMMKfG4NB4GSw2JX
         woDu/U3aqAmHmqc3FlkxSZOSXqej61pYubuNyPszVjedeg5VFUzBEM0boDDAY/5TWbFk
         yAVI6DPqr3m770Ojnt/xSQ6thsOzqSvSYaR3LOHlgIpe93B/EA1uPuuPkPNwz79E+OXd
         Jj+iE4D3TKqMvkYIo2w5nuj5mfv3J/g6NXF+EerxW7yZhMB8pJUzx3c5beLPtxsBtWwi
         vq66LxP04murY+EjgEyXrniP2gvbp7NEz1XjKgpMkHH1oBw5NpGZmfxtI0bSyC3I0EOD
         iV0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dpbdWx6ZyaNtqRFnV2Nk49gopMsn/D9yK25L9/DBVxw=;
        b=B88UTZ+tspJG3004HkI4TVQIzGfgGydyMPwMcfl1f95BSsTauFlwn12JAE9oyIP9cG
         b5HxPTa0Pl9nUxmVoRwMJfY684wtDW7GHIxqLxD/NnpWt2D/mTGJpWKnNYXuWDybbK7s
         Q2seqY5z+dGIwt98XL4QXik2C9RfbjQS7Hl6r0dlAiFt97EDWN9R2Ptue7NhelZEpjJY
         HibUNG082a6e2c70vBdPUzFngg/i0ZIdmm2r8OnwA+cZoMmSyPUioGLLog0StQJCk9vy
         u4ZYMG/qiBUYdZC63t0CMESFqm/mmGonyGSRme/NhWO1OTLTOBcBeyNN8yLDQcxNxGjL
         9ErA==
X-Gm-Message-State: AOAM530M3a928U7PRtyz+6GUr6lPLCydpPRTBiqjFKu3ZAtoLegU/nUa
        tuk+qeEUd/huuQTUL7vE3XY=
X-Google-Smtp-Source: ABdhPJyUQCIyBdC1BZ24xQX/x2gC/uJULYoty5Usa7drlNtRy8ioNRPAn1QQFHNSrwGN9mpSUUa+WQ==
X-Received: by 2002:a05:6808:2008:b0:326:78ed:afe0 with SMTP id q8-20020a056808200800b0032678edafe0mr951175oiw.188.1652213220067;
        Tue, 10 May 2022 13:07:00 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id u28-20020a056871009c00b000d6c86ea98dsm6091019oaa.1.2022.05.10.13.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 13:06:59 -0700 (PDT)
Date:   Tue, 10 May 2022 13:06:58 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/3] t0033-safe-directory: check when 'safe.directory' is
 ignored
Message-ID: <20220510200658.n2ythd5soyzguqb4@carlos-mbp.lan>
References: <pull.1215.git.1649863951.gitgitgadget@gmail.com>
 <20220427170649.4949-1-szeder.dev@gmail.com>
 <20220427170649.4949-3-szeder.dev@gmail.com>
 <xmqqr15il0uo.fsf@gitster.g>
 <a44b4f0e-038c-9bcd-80d6-f53c87bd7f2d@github.com>
 <xmqq8rrndb6h.fsf@gitster.g>
 <20220429190625.GA1626@szeder.dev>
 <b6deba3f-9019-fb6f-7bb3-cc2f647dcff6@github.com>
 <20220510183321.GA4408@szeder.dev>
 <YnrDK0wCV6taY1QX@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnrDK0wCV6taY1QX@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 10, 2022 at 03:55:23PM -0400, Taylor Blau wrote:
> > >
> > > 	GIT_TEST_ASSUME_DIFFERENT_USER=0 git config --unset safe.directory
> >
> > Oh, wow.  This is so obvious, no wonder it didn't occur to me :)
> 
> Don't we consider this one-shot environment variable to be sticky on
> some shells (i.e., that it persists beyond just the "git config"
> invocation here)?

do you have an example of such a shell?, I would assume that since the
mechanism to implement these would be similar to local and we already
require local for running our tests, that shouldn't be an issue (at
least in the test suite), right?

any such variables should be only set as part of the environment used
by the posix shell before it call execve to invoke the next command IMHO.

Carlo
