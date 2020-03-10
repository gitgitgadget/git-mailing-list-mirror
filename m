Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D314AC10F27
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 16:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D25C21D7E
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 16:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvGsmf/7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgCJQ5a (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 12:57:30 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33551 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgCJQ5a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Mar 2020 12:57:30 -0400
Received: by mail-wm1-f67.google.com with SMTP id r7so1205512wmg.0
        for <git@vger.kernel.org>; Tue, 10 Mar 2020 09:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=mJF1abg4N5fZ29twjZcBrNFf5PHcgndB4IBgXd6gkl0=;
        b=kvGsmf/79GraU/9kK7m6C0kohj5qqGO7GOlnbS77wHW1YhDALPAMeCwv8Wv4px5HfK
         32sG9jCHEOJ6Dugn5FCJLDGhHaiJAo1xNUFNJU/xRNJkU03/H9ymRA+NE+d5P1/4lXYu
         c6DbX4eAeTuLeqXfkQeswXySZDiZQTs3uOwFYW0nfXarHuNhhlw9a7BQqT76I32ooxjs
         OEXov3tEOyERgEZOrAODrlqPDf2EaP03MdnZnRlGYq5rb1YT8WNJ/sE/XZp5hirZgJUU
         IZQvzFP47G1+VP2g6L7pwOttRL50Pg5x3nkLccqKiD23FTaNho9+KsojqMUERyWqwz9M
         uVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=mJF1abg4N5fZ29twjZcBrNFf5PHcgndB4IBgXd6gkl0=;
        b=S3pIbQFryeGleS5ibsnEVdLQfXaMnOTiF8nt8gFtk+o35gLnMQOmh+E2X/Z/4xJS70
         CZh2/iWkijn+avaDOf6A05knsLUQzN61TT4R8Qu6SSKHp8ryY8y0oAv/AL6S1Pn1XL11
         gu/dmPpKdFcGVKwKwwQtPq4eh4Rf3XZD2h1weGV3CXpieVKwDiFYqwtkuqHRmjJRvAcC
         vfKq0p+hidOKy1Ll3A/mo56WenvuiZlfGTShm+q5HgkNHyHBjmGxvskUKCYCtAXGhggr
         X8uitbceL7RbT3uBORZaixwUmHEOa1yzFMWLzKDs8fMQtoXe3hMSYgC/08pAGU4TVisG
         vSwQ==
X-Gm-Message-State: ANhLgQ2qvTYnd6Lf/ry2KiHX6/7oHAuSCZ7f3+3WxpWB+SQ4pmyx0nOv
        WFp4ySCJOH7m76G9Cd9MtPc=
X-Google-Smtp-Source: ADFU+vujrdojhoXHvEx1dHAS4dyh0s6v2j5FjKQu6cye/BlJb/MjhuJtZTjzr7WWbK1kEMOEmh1tiw==
X-Received: by 2002:a1c:5457:: with SMTP id p23mr3095681wmi.45.1583859446690;
        Tue, 10 Mar 2020 09:57:26 -0700 (PDT)
Received: from szeder.dev (94-21-29-150.pool.digikabel.hu. [94.21.29.150])
        by smtp.gmail.com with ESMTPSA id y8sm4818232wmj.22.2020.03.10.09.57.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Mar 2020 09:57:25 -0700 (PDT)
Date:   Tue, 10 Mar 2020 17:57:23 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Cc:     Ondrej Pohorelsky <opohorel@redhat.com>, git@vger.kernel.org
Subject: Re: git-core: try_to_follow_renames(): git killed by SIGSEGV
Message-ID: <20200310165723.GB3122@szeder.dev>
References: <CA+B51BFFvn9puia8+kheeWkDfOQ7RYHTcGa74M5aeiTd8-QJXA@mail.gmail.com>
 <3c722d21-ee57-7d20-81fb-0399f02f1bc7@syntevo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3c722d21-ee57-7d20-81fb-0399f02f1bc7@syntevo.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 06, 2020 at 03:44:34PM +0100, Alexandr Miloslavskiy wrote:
> Since I like studying crashes and noone else replied, I decided to have a
> look.
> 
> The problem is easy to reproduce with this (replace 1.c with any file):
>   git log --follow -L 1,1:1.c -- 1.c

Don't do this.  In particular:

  - Don't use line-level log with a pathspec, because the
    documentation of 'git log -L' explicitly told you not to do so
    ("You may not give any pathspec limiters.").  This should have
    errored out since the beginning, but, unfortunately, has never
    been enforced.

  - Don't use '-L' with '--follow'.  On one hand, line-level log on
    its own already follows file renames, even multiple files at once,
    there is no need for an additional '--follow' (which can only
    follow one file).  OTOH, you shouldn't be able to use '-L' and
    '--follow' together, because the former forbids a pathspec, while
    the latter requires one.

In any case, '--follow' has always been an ugly hack on top of the
revision walking machinery, while line-level log is a rather poorly
integrated bolt-on.  They simply weren't designed to work together, as
evidenced by their contradicting requirements about the pathspec.

> It occurs because `opt->pathspec.items` gets cleaned here:
>     clear_pathspec
>     queue_diffs
>         /* must look at the full tree diff to detect renames */
>         clear_pathspec(&opt->pathspec);
>         DIFF_QUEUE_CLEAR(&diff_queued_diff);
>     process_ranges_ordinary_commit
>     process_ranges_arbitrary_commit
>     line_log_filter
>     prepare_revision_walk
>     cmd_log_walk
>     cmd_log
> 
> And on next iteration it crashes in 'try_to_follow_renames' on this line:
>     diff_opts.single_follow = opt->pathspec.items[0].match;
> 
> I think that bug comes from commit:
>     a2bb801f by SZEDER Gábor, 2019-08-21 13:04:24
>     line-log: avoid unnecessary full tree diffs
> 
> @szeder could you please look into that?
> 
> On 27.02.2020 13:56, Ondrej Pohorelsky wrote:
> >Hi,
> >
> >there is a SIGSEGV appearing in Fedora[0] with Git 2.24.1
> >
> >This bug started to appear after update to Git 2.24.1.
> >Bug reporter said that Git crashed on him while running VS Code with
> >Git Lens extension[1]
> >I have tried to reproduce this bug with my own compiled Git with debug
> >flags, but sadly SIGSEGV never appeared.
> >
> >To me it seems like there is a problem in commit a2bb801f6a[2] which
> >changes move_diff_queue() function. This function calls
> >diff_tree_oid() that calls try_to_follow_renames(). In the last two
> >functions there are no arguments checks.
> >
> >Best regards,
> >Ondřej Pohořelský
> >
> >[0] https://retrace.fedoraproject.org/faf/problems/bthash/?bth=25aa7d7267ab5de548ffca337115cb68f7b65105
> >[1] https://bugzilla.redhat.com/show_bug.cgi?id=1791810
> >[2] https://git.kernel.org/pub/scm/git/git.git/commit/?id=a2bb801f6a430f6049e5c9729a8f3bf9097d9b34
> >
> 
