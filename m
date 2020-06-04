Return-Path: <SRS0=8h89=7R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2B0C433DF
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 07:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F2E0206DC
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 07:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcEVup7v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgFDHR1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 03:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgFDHR0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jun 2020 03:17:26 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9983AC03E96D
        for <git@vger.kernel.org>; Thu,  4 Jun 2020 00:17:26 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b5so2868449pfp.9
        for <git@vger.kernel.org>; Thu, 04 Jun 2020 00:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ytKbukUvVztojDvYw4hbabzZrgsjEKGSq4RX1PrPS2s=;
        b=RcEVup7vJZZnidIl4RSGzLW074dFedP5+7Ttc5pDsT2tFIOITs7oAXpUuFs8X4mJgP
         KNQl/tGl/9URN4HFw3fR9yjZSH7vrGhnkstAZa2gGMB+XigWr0OC3eCRtGzr9/PQ9pZd
         XEw7/+mj/v/UQPgWuWb+dF8xoi9XheweUyycikfHaA475dw8CSP6BPVLhtZ+qDYypzKH
         bosWHg3ZhsXx/treacJsloxaeSzUkUblUMF/LVMwNaYrBdmpiwd0Tg7MseMMH6BgEZFa
         RHQuaewiIV1eV4jCXcZNUjK/UK22v5sRyLPjqafrZT1UAQIq8ySO7GO0sQyQbI7X8rjS
         X20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ytKbukUvVztojDvYw4hbabzZrgsjEKGSq4RX1PrPS2s=;
        b=gXmQ5k92bJYeZXVfH4M/EJ6yo5UC6JQpgvnelUbWllZ/ryqcUyknZGDgvDuEzYlENo
         31AjpjK0mFiEZLGYw1iQ2Dv+CJ6ImKQ3WMgQAfrA/ajyZ+Y/c3KogkzxsQlLj7V/a4Ip
         Hcd6xduDfKKsd0IPmRF7DqA7yEfofzvAI+ds9qPDY5tZxM24qrx9ki2+ADRtqpBTTxOT
         KyYQk3XNAceseyg5WjFt2GDdAFhiB73TsxS2e5UyXMPFSu1rQWZkhhIHMh5odDnUdfhn
         juiKfRV/LudSnQhqI1cgqA7Lr1O6S0G8ZC+KuNrArLg9TYfx0H93x2pTf4L8zR/0eKhz
         RxYw==
X-Gm-Message-State: AOAM531eF0hwICp51vuokNWUSQmCFG85nNkgQagdsoopBhj49he5+Htz
        q/cF1TEJC7QX+tQ1JPRVvks=
X-Google-Smtp-Source: ABdhPJxENRktKFflFiwlselxMb/tyPAPTzv4AZqepldAhmCL3Hgf2BZTgjj71F1AdCHnpnmmNbi+iw==
X-Received: by 2002:a62:1a0f:: with SMTP id a15mr3079344pfa.177.1591255045996;
        Thu, 04 Jun 2020 00:17:25 -0700 (PDT)
Received: from konoha ([103.37.201.179])
        by smtp.gmail.com with ESMTPSA id np5sm5116842pjb.43.2020.06.04.00.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 00:17:25 -0700 (PDT)
Date:   Thu, 4 Jun 2020 12:47:19 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     congdanhqx@gmail.com, Johannes.Schindelin@gmx.de,
        christian.couder@gmail.com, git@vger.kernel.org,
        kaartic.sivaraam@gmail.com, liu.denton@gmail.com,
        sunshine@sunshineco.com
Subject: Re: [GSoC][PATCH v5] submodule: port subcommand 'set-branch' from
 shell to C
Message-ID: <20200604071719.GC8686@konoha>
References: <20200523163929.7040-1-shouryashukla.oo@gmail.com>
 <20200602163523.7131-1-shouryashukla.oo@gmail.com>
 <xmqqzh9ls622.fsf@gitster.c.googlers.com>
 <20200603001225.GB2222@danh.dev>
 <xmqqtuzrrk8r.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtuzrrk8r.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/06 01:02, Junio C Hamano wrote:
> I'd expect that when that day with no scripted parts of "git
> submodule" remains comes, the main entry point functions in
> builtin/submodule--helper.c (like module_list(), update_clone(),
> module_set_branch(), etc.) will become helper functions that live in
> submodule-lib.c and would be called from builtin/submodule.c.  And
> the conversion would rip out calls to parse_options() in each of
> these functions that would migrate to submodule-lib.c
> 
>     Side note: instead of adding submodule-lib.c, you could add them
>     directly to submodule.c if they are small enough.  I am however
>     modeling after how the "diff" family was converted to C; the
>     diff-lib.c layer is "library-ish helpers that get pre-parsed
>     command line arguments and performs a single unit of work" that
>     utilizes service routines at the lower layer that are in diff.c
>     and submodule-lib.c and submodule.c will be in a similar kind of
>     relationship.

There does exist a `submodule.c` outside of `builtin/` which has various
helper functions. Will that require renaming to `submodule-lib.c`? BTW
`set-branch` is a subcommand of `git submodule` so do we have to put it
into `submodule-lib.c` if there were to be one?
What is the motivation behind modelling it on the diff-family?

