Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64DB21F404
	for <e@80x24.org>; Fri, 31 Aug 2018 21:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbeIABrI (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 21:47:08 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:40668 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbeIABrI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 21:47:08 -0400
Received: by mail-qt0-f193.google.com with SMTP id h4-v6so16166083qtj.7
        for <git@vger.kernel.org>; Fri, 31 Aug 2018 14:37:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B+nIvl+u/ODqc73wTlBpaYT0D+WRe3LWzlRQ2uRjrBI=;
        b=nweDMukN54EofIMnxXEdKX/ugHEDH5XvDMCsf+paksItvxMmpaorzJhQRXAmrVEzGv
         VGsM69hCT8sVVQpMSkoNChMwDmCVwd1hHdKixvLwXKOhrT1+slD5Tld1lTcetQuNgXtK
         kjGAlT1R2am886pdg28lzwgRGPsLpi+beq2ptv6ICnkDlhXpJ5/5VK+lUtbEFRyw8Qsl
         BbGcub3Hho95sK4MRdAFmXI7LXNaZOPodCs/7EFDLC9piJh4Xnj3U89DvCwsGCZ0e5kx
         tHyNGqF5Fl5vo4xQh0GdNLHjNUillwi6ISSDvQBkdmAe+5KKAu37iUtfbfhfVEqgUpMl
         YMEg==
X-Gm-Message-State: APzg51A92i9OLptrGnhh2GLrDrS0TXi8DVkUEfkGC4H8P9b/Dgh4hUSk
        /eoQZ/iQ5Jf/jL14Vk/qKYKw0oH79jDWFA1up80=
X-Google-Smtp-Source: ANB0VdYJQhHU3HGTKLeMxBlb+zWbX+u/k5h9fyPyctFOB1g6iYxBsB7usrgZbm185RInn7uYDQHogr5998l56KxyDoU=
X-Received: by 2002:aed:2aa1:: with SMTP id t30-v6mr17988989qtd.101.1535751465191;
 Fri, 31 Aug 2018 14:37:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180830195546.GA22407@sigill.intra.peff.net> <20180831063318.33373-1-sunshine@sunshineco.com>
 <20180831063318.33373-4-sunshine@sunshineco.com> <20180831200748.GD5120@sigill.intra.peff.net>
In-Reply-To: <20180831200748.GD5120@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 31 Aug 2018 17:37:33 -0400
Message-ID: <CAPig+cSktNnaWBew02Di5BaCQAqP6kXtMyoC3=g1A9hZcT-BEw@mail.gmail.com>
Subject: Re: [PATCH 3/3] doc/Makefile: drop doc-diff worktree and temporary
 files on "make clean"
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 31, 2018 at 4:07 PM Jeff King <peff@peff.net> wrote:
> On Fri, Aug 31, 2018 at 02:33:18AM -0400, Eric Sunshine wrote:
> > diff --git a/Documentation/Makefile b/Documentation/Makefile
> > @@ -332,6 +332,7 @@ clean:
> >       $(RM) manpage-base-url.xsl
> > +     '$(SHELL_PATH_SQ)' ./doc-diff --clean
>
> This spelling took me by surprise. The doc-diff script itself specifies
> /bin/sh, and we do not build it, so the #! line is never replaced. [...]
>
> I don't think the script does anything complicated that would choke a
> lesser /bin/sh. But it doesn't hurt to be defensive, since this bit of
> the Makefile will be run for everyone, whether they care about doc-diff
> or not.
>
> So that all makes sense. I initially wrote this to suggest that we call
> out this subtlety in the commit message. But I see this is based on
> existing instances from ee7ec2f9de (documentation: Makefile accounts for
> SHELL_PATH setting, 2009-03-22). So maybe I am just showing my
> ignorance. ;)

Correct. I was concerned that invoking it simply as "./doc-diff
--clean" could be problematic, so, knowing that the Makefile invoked
other scripts in Documentation/, I mirrored their invocation. If it
didn't follow existing practice of invoking the command with
$(SHELL_PATH_SQ), then that would merit mention in the commit message,
but as it is, the commit message is probably fine.

Thanks for the review.
