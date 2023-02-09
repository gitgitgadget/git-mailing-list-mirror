Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98161C636D7
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 16:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjBIQha (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Feb 2023 11:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjBIQh2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2023 11:37:28 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B93E5D1D8
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 08:37:27 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id g18so2567174qtb.6
        for <git@vger.kernel.org>; Thu, 09 Feb 2023 08:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1/XXRKmoXfWQfDxdhkxG2b+38fshJ5e3cuUr15BaE38=;
        b=H2Ekx/2emXZJugfLMsEV6nB287xFJok87U+EqQP4TdrZ45jZxvys/aCHXpW5++5SeG
         W8Wyj5N+CoDk1ewrUGzm0ZC82QUDfizMZX5yS0U6aWvIqh3Dbkb78DjL/fDDLdv+RB0z
         I7zyNYLhvMTEDlG+SJQ4K/4vNO6kiQkF6hnEtqxeG+GTOiEALlsd2IY7V2sMUlwaipuS
         MZb9crCmZ1h0ngqD0QkEG2FyJpr+qFLR6xobrYy1PMMulWW1/5uNsz1zlt/uxx1Ldh5T
         q5SLqAw513iykn5Qd1KWkKeOLGne7M7LqMZE9gQzrlYGztbo/j8M12s0EeSHtRoJ9gqk
         OOBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/XXRKmoXfWQfDxdhkxG2b+38fshJ5e3cuUr15BaE38=;
        b=bneO8LFdvfMWhuO76vhGXycVvMznRZo4zWBhv+ePXi+Qb64fm0uh2IVye5c96dhkML
         pYv09OolR/Gz3j2Xlv1RYjFH2wRHn0/sysO3PbE1H+Qb41ns6Nx8Eu6gkFWdZeu1wybC
         0tFFJvWxZw9+z2DLL0uwp7QNWfa+Tze8OesLBhFrP4mqoep6Ca9/TcUnNXe6osj2XAAx
         +meh7ygbNc9KzdwzhcOxkXhDPy032WU2/ANugCh+pL5MY9yNlYCh9v/L0Od8hEQ3RSGc
         d7qebX2cvzhGID79w5sYD9VNoWcQFaLRPV0kqSFVON4ZFwaQYMF4zngGJ0TyI+agHiki
         SqWQ==
X-Gm-Message-State: AO0yUKXANTSf1d1B3+iIn9h/OATn5A070ewOrX1EJpz5rQM3uhst345T
        UK53E5NycIpAwHQDzgV/JDzg2EdP5vA=
X-Google-Smtp-Source: AK7set8AiHOOqLPypn55WBfHJaGKQ8OHqUMXq/YRAi1SZowbRLurSM0QBpZPVMhF0jX/QnjktPlyzA==
X-Received: by 2002:ac8:57c3:0:b0:3a5:f916:1d2c with SMTP id w3-20020ac857c3000000b003a5f9161d2cmr22739229qta.5.1675960646476;
        Thu, 09 Feb 2023 08:37:26 -0800 (PST)
Received: from localhost (pool-74-105-67-34.nwrknj.fios.verizon.net. [74.105.67.34])
        by smtp.gmail.com with ESMTPSA id t13-20020ac86a0d000000b003b82a07c4d6sm1524999qtr.84.2023.02.09.08.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 08:37:26 -0800 (PST)
Date:   Thu, 9 Feb 2023 11:37:25 -0500
From:   John Cai <johncai86@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     phillip.wood@dunelm.org.uk,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] diff: teach diff to read gitattribute diff-algorithm
Message-ID: <20230209163725.hyx62qwveut4sj5x@jcai-ubuntu>
References: <pull.1452.git.git.1675568781.gitgitgadget@gmail.com>
 <8e73793b0db3e84366a9c6441cc0fdc04f9614a5.1675568781.git.gitgitgadget@gmail.com>
 <19f6b40b-d8e8-e86c-5a9a-b35f42909118@dunelm.org.uk>
 <7852AC7B-7A4E-4DD0-ADEA-CFFD5D16C595@gmail.com>
 <CABPp-BGhuTyq_hrpMc+Ky3yt1UgO7DcAsgcYH15FK--QLdCsQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BGhuTyq_hrpMc+Ky3yt1UgO7DcAsgcYH15FK--QLdCsQw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/02/09 12:26AM, Elijah Newren wrote:
> Hi John,
> 
> On Mon, Feb 6, 2023 at 12:02 PM John Cai <johncai86@gmail.com> wrote:
> >
> > Hi Phillip,
> >
> > On 6 Feb 2023, at 11:27, Phillip Wood wrote:
> >
> > > Hi John
> > >
> > > On 05/02/2023 03:46, John Cai via GitGitGadget wrote:
> > >> From: John Cai <johncai86@gmail.com>
> > >>
> > >> It can be useful to specify diff algorithms per file type. For example,
> > >> one may want to use the minimal diff algorithm for .json files, another
> > >> for .c files, etc.
> > >
> > > Have you got any examples of why this is useful? I find myself occasionally changing the algorithm when the default gives a sub-optimal diff but I've not really noticed any pattern with respect to file types.
> >
> > At $DAYJOB, there has been a discussion and request for a feature like this [1].
> > One use case that came up was to be able to set a different diff algorithm for
> > .json files.
> >
> > 1. https://gitlab.com/gitlab-org/gitaly/-/issues/2591
> 
> A couple points:
> 
> First, there seems to be a misunderstanding in that issue.  In
> particular, the merge algorithm does call into the xdiff library to do
> the three-way content merge of individual files, and when it does so,
> it has to specify the diff algorithm (or take the default, currently
> myers).  merge-recursive allows the diff algorithm to be specified by
> the user (there are
> -Xdiff-algorithm={histogram,minimal,patience,myers} flags to
> merge/rebase for it), while merge-ort uses histogram (though it uses
> the same parser as merge-recursive and thus gets the variables set
> from the -Xdiff-algorithm flag, it just ignores those values and
> hardcodes histogram).
> 
> Second, I also think the user request got converted to a particular
> solution without looking at the wider problem space:  The idea seemed
> to assume "myers" is default for a good reason, and thus asked for an
> option to use something else.  I'm not sure the assumption is valid; I
> think "myers" is default for historical reasons and histogram is
> better not just for special Salesforce xml files, but code files too.
> The output makes more sense to users.  So much so that even though my
> simple testing suggested it had a 2% performance penalty compared to
> myers, I forced ort to use it[1] even though I designed  everything
> else in that algorithm around eking out maximum performance.  Others
> who have tested the diff algorithms have also found histogram has very
> similar performance to myers, and oftentimes even beats it[2][3].
> Also, worries about invalidating rerere caches[4] was real, but we
> already paid that price when we switched to ort.  And if performance
> is still a worry, [3] gives me reason to believe we can make our
> histogram implementation faster.  Finally, for the period of time when
> Palantir was letting me make an internal git distribution (mostly for
> testing ort), I also carried a patch that changed the default diff
> algorithm to histogram (not just for ort, but for diff/log/etc. as
> well).  Never had any complaints from the users from it.  Perhaps you
> could do the same in your local version of git used by gitaly?

Thanks for that suggestion, Elijah. Changing the diff alg to histogram has been
something we've considered doing as well. However, we've gotten customer
requests to also have the option to view their diffs with patience. Seeing as
the diff algorithm is sometimes a matter of preference, we thought giving users
the control through the repository would be nice.

thanks
John

> 
> [1] See c8017176ac ("merge-ort: use histogram diff", 2020-12-13)
> [2] From 85551232b5 ("perf: compare diff algorithms", 2012-03-06):
> "This does indeed show that histogram diff slightly beats Myers, while
> patience is much slower than the others."
> [3] https://github.com/pascalkuthe/imara-diff
> [4] https://lore.kernel.org/git/20120307114714.GA14990@sigill.intra.peff.net/
