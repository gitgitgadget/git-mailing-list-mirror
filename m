Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1065320C32
	for <e@80x24.org>; Wed,  6 Dec 2017 21:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752274AbdLFVr0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Dec 2017 16:47:26 -0500
Received: from mail-it0-f44.google.com ([209.85.214.44]:40078 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752150AbdLFVrZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Dec 2017 16:47:25 -0500
Received: by mail-it0-f44.google.com with SMTP id f190so9709510ita.5
        for <git@vger.kernel.org>; Wed, 06 Dec 2017 13:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h+xi16mapuuOAybyXkDThzG97GqmHUs/5ghhJU1T3rE=;
        b=hFqQnGkH5bGCh8GzcZpcPLcN7jLoJmQa3/fB16p4KS1dJ7AtveDygGOY/1WfEhUCnn
         uFQarsyeuuubchiA+SYgmfvPNFKeI9HI3NF744koA7WPed1w/OdANUK+qIdTE745cL7t
         zls3N3X/Ul0YqEgQ1HPF3R5Clb+s+P8g53jEYcL0eQShm6a+8Wl3aeG1SsEXXbc69xx9
         rFfpCdpOCv950HQcZOJ9HWTlpQeccHR3Dr+UH7FMzImQC049oQbWTI8HqhzwPHq1R23d
         e6c6j41vJsVatWI5hWnA8SKwwqdIjS8yuv115H1hZnrnRQ0MYdzVWjEmJoqGQYDiyvI/
         fGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h+xi16mapuuOAybyXkDThzG97GqmHUs/5ghhJU1T3rE=;
        b=k7fmbpIXZ2nq1NboHoLabrRzgQPNzxbgzdoCuR/BmXsl1ApPdqMAzy/LFVO/Zp/jEu
         fZW9Bflzq3kwfLvwRQq6M3tlow/ZudFFMrs1SZqJdtaWpZKmdJxVIXOUV8pO5Sp6KL+F
         /nNIwOgAT1SpJhIe5O+vuu9vGQJCJTJidECObfSW2vBkH456uPZP0P5QGPlY/Ix0FDr0
         DmEXcen8kyhKyOTJMlgVVDX3yyzyt9UCZBT10IegzsddpzQdKYzy1QNtu6/9/ZclR0CP
         Wto9qAQXW6VroyZcEpUt+pBIPqCrc9KYP7DNlyzoNwJroeAbBpRzQxGumo0ahHQu1xyX
         pWwA==
X-Gm-Message-State: AKGB3mIS9EdLowR7wjTX13mIASsiZqn9G18pijekf6SiZmo5SJyo1/YN
        E9FRl+7e4EIJ2SuJH9jCKS2FIg==
X-Google-Smtp-Source: AGs4zMb7P7kXycG6chKnmIiNBvWArpOKRcy/nDtTqJxoHdpZoEKZw/H3ALMonwoXwVQ/LqcqgNEMhA==
X-Received: by 10.36.151.198 with SMTP id k189mr17156193ite.100.1512596844588;
        Wed, 06 Dec 2017 13:47:24 -0800 (PST)
Received: from google.com ([2620:0:100e:422:1db0:e823:6c98:b5e2])
        by smtp.gmail.com with ESMTPSA id x82sm2065507itb.36.2017.12.06.13.47.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 06 Dec 2017 13:47:23 -0800 (PST)
Date:   Wed, 6 Dec 2017 13:47:22 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, ben.boeckel@kitware.com
Subject: Re: [PATCH] diff-tree: read the index so attribute checks work in
 bare repositories
Message-ID: <20171206214722.GA118027@google.com>
References: <20171205194801.GA31721@megas.kitware.com>
 <20171205221337.140548-1-bmwill@google.com>
 <CAGZ79kbvkopatFZi64Hxoa=wX6CJxJw6V+9RnQqrx6gTBL-78w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kbvkopatFZi64Hxoa=wX6CJxJw6V+9RnQqrx6gTBL-78w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/05, Stefan Beller wrote:
> On Tue, Dec 5, 2017 at 2:13 PM, Brandon Williams <bmwill@google.com> wrote:
> > A regression was introduced in 557a5998d (submodule: remove
> > gitmodules_config, 2017-08-03) to how attribute processing was handled
> > in bare repositories when running the diff-tree command.
> >
> > By default the attribute system will first try to read ".gitattribute"
> > files from the working tree and then falls back to reading them from the
> > index if there isn't a copy checked out in the worktree.  Prior to
> > 557a5998d the index was read as a side effect of the call to
> > 'gitmodules_config()' which ensured that the index was already populated
> > before entering the attribute subsystem.
> >
> > Since the call to 'gitmodules_config()' was removed the index is no
> > longer being read so when the attribute system tries to read from the
> > in-memory index it doesn't find any ".gitattribute" entries effectively
> > ignoring any configured attributes.
> >
> > Fix this by explicitly reading the index during the setup of diff-tree.
> >
> > Reported-by: Ben Boeckel <ben.boeckel@kitware.com>
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >
> > This patch should fix the regression.  Let me know if it doesn't solve the
> > issue and I'll investigate some more.
> >
> 
> Thanks for fixing this bug! The commit message is helpful
> to understand how this bug could slip in!
> 
> > diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
> > index d66499909..cfe7d0281 100644
> > --- a/builtin/diff-tree.c
> > +++ b/builtin/diff-tree.c
> > @@ -110,6 +110,7 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
> >
> >         git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
> >         init_revisions(opt, prefix);
> > +       read_cache();
> 
> 
> Although we do have very few unchecked calls to read_cache, I'd suggest
> to avoid spreading them. Most of the read_cache calls are guarded via:
> 
>     if (read_cache() < 0)
>         die(_("index file corrupt"));

Thanks, I'll add this change.

> 
> I wonder if this hints at a bad API, and we'd rather have read_cache
> die() on errors, and the few callers that try to get out of trouble might
> need to use read_cache_gently() instead.
> (While this potentially large refactoring may be deferred, I'd ask for
> an if at least)
> 
> Thanks,
> Stefan

-- 
Brandon Williams
