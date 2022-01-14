Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298C5C433F5
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 22:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbiANW3P (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 17:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbiANW3P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 17:29:15 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D96C06173E
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 14:29:14 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id v1so14028692ioj.10
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 14:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hqVtKq3/PQOU+WRK7eTUpFpwPfw6Lh0B6fuBiMHelmM=;
        b=Fe4czO39GvsaxMK3LGD3PekDBU1z2bCr9J25OfBenmlv79DaVBRxJTcpFHFnZFJunr
         Aiu0OSIUdNqR/jgVCLz6TZR9B4uH9eSzRaSjIEbSnLEkoSs0RUNXSxzbtPhj92P8Khcg
         N4qHnhA5TAR2apSrUjGMSLsFvgX+P1wRvANZbV1a8fx0esmOnN2KQ+62Svx8XUfR30ld
         vU1DXqiolfKCtIdcdOUGMv4EsUe0/JNJuHKzYm7153Gv57eG9WrxRqhIAvaRjlEBtF4h
         NraRlkTBZpn5muEJ8RyK02LbUN2AN1YdMTM+RYHFxcao6F+yYF6hcMHgwysZfg85D1Li
         tW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hqVtKq3/PQOU+WRK7eTUpFpwPfw6Lh0B6fuBiMHelmM=;
        b=bQ7HXslcNrOrvyat+Z6pBDMhwS90pu1LGQ/W/rwXvcW/e/UO9jO2HVYHHgeCkAU6I3
         wG/jdYvFB++W7vfXTK0ZMLiMO9TsqF/ljtpsZ8jdLjwAEJcx/7gs0hGsX/2tpB+5V9nQ
         LLGieUkiVPWjkIZS2V27sdqpliMWnF4M+lDF3Uq6EWDp/suIdAvK3AklUfd0mkOmMHda
         fl54DlrUso//H9rcyr09+do+KLheNsB+jmyR9mxMFPu6vn62GR34atpPY1qXx3E0nku+
         Yyv0s1R4J1A+Maw3vpQGRoe5RsrBATo1bs7ts0x/wfSj2VxMiE13WhwPkU/HTBDjHQ8K
         a8Wg==
X-Gm-Message-State: AOAM530dXqQRPhKOQ06+uMolxpUT52PLnNEk5MwZw59W/Ylfrd4NqdpZ
        S3exeZ4K6OxzT+0GpAA+zyqlBg==
X-Google-Smtp-Source: ABdhPJws1pnLXGhRRrKCMrWPmLVDzc96214qCqzZjXMtDK+Ko3U4ZoUHEsIy++AX/U6Mu9eNF3lXSw==
X-Received: by 2002:a05:6602:148e:: with SMTP id a14mr2931915iow.186.1642199354337;
        Fri, 14 Jan 2022 14:29:14 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i8sm4978396ilm.63.2022.01.14.14.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 14:29:14 -0800 (PST)
Date:   Fri, 14 Jan 2022 17:29:13 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: merge-ort assertion failure
Message-ID: <YeH5OSG0RW29REhn@nand.local>
References: <YeHTIfEutLYM4TIU@nand.local>
 <CABPp-BFM+fU+jVJwrU4ooPGvHbw859M+RNb+MvJe12MPV_=q7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BFM+fU+jVJwrU4ooPGvHbw859M+RNb+MvJe12MPV_=q7g@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 14, 2022 at 02:15:31PM -0800, Elijah Newren wrote:
> On Fri, Jan 14, 2022 at 11:46 AM Taylor Blau <me@ttaylorr.com> wrote:
>
> > I haven't had a chance to look into it very deeply yet. Elijah: I figure
> > that this is the sort of thing that may be totally obvious to you, so
> > I'm sharing it here in case it is.
>
> I don't have a testcase (though I think there is probably enough
> information here for me to create one), but I think I know the
> problem.  Does this fix it for you? :
> https://github.com/git/git/pull/1193

Unfortunately not. With a sufficiently small value of merge.renameLimit
(in my case, just 1) I can trigger the same assertion failure:

    $ GIT_DEBUGGER=1 git.compile -c merge.renameLimit=1 rebase $onto
    [...]
    Thread 1 "git" hit Breakpoint 1, clear_or_reinit_internal_opts (opti=0x55555b0cf3f0, reinitialize=0) at merge-ort.c:546
    546				assert(renames->cached_pairs_valid_side == 0);
    (gdb) p renames->cached_pairs_valid_side
    $1 = -1

Short of providing a small, reproducible test-case, I'm happy to share
any information I can about the repository that might be useful to you.

Thanks,
Taylor
