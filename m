Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DA9C2D0DB
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 17:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 321BF206D5
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 17:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQl4c3g1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgAaRNs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 12:13:48 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42866 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbgAaRNs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 12:13:48 -0500
Received: by mail-wr1-f65.google.com with SMTP id k11so9520416wrd.9
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 09:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m3pH0gCQ9eAbKaTEu0i29zzwDwfdowY2qWdujDAyj2g=;
        b=QQl4c3g1B3OdlB20EGfJ4Owx3l3smB8GmTGiBOIc3wT2KRErhJx+IDAV07+W4o3z4H
         8edGBp/W9uKB9soMGd8ODmnlTQ6gSLY3u/6LfAXytAKbHsFp++2gBfCLkqyUVaTcdn0J
         G18yAs4TZgMh5jwqdhnCFtGGxKw5dQC/Qf1yrQj9cjX0pgnKsO//rT7VP8COu2w9TDCN
         YoS6JJA8gobYK+OLYlg3DyUV9qGsnnV/kdce28QG3euMy6RkL/g9iWtSiVv3I7stztaH
         n/iY+suAn8GDoFJiX6yQFpkL/sLpYlYFvw17JlZnF3D89ZVnSoSW4GwkOVZliF8vWpxx
         VuCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m3pH0gCQ9eAbKaTEu0i29zzwDwfdowY2qWdujDAyj2g=;
        b=X9J0fgpeQO4yZ6StKN/6cJtvWFv82PlV3TL0S/izYd0rJHpyhqKhF+Dcpmbf5VRydg
         WG0Q5JoSycGrf9ervq0thtg7SuLniH6wlEHSBb6o6g1BcF6zoo8n42MmTDAfXFTeTHsw
         xMmgNfiwwWmK1k1ZdN+2+nXgq9WgDgunBoG6t9PcFJ6WoOTl+MUW44nSUB7lsEcLLUh2
         vs81rTAqin2hiIllUUWf4CS2kUf6g3ZIfQaX1jLUy0DS/PlYNsXv90CFuNKXiIKa2qOM
         dle9oJE/nFO97NLVta3PQ+yGQ8ilRyZd/l5W2YVotu/pl/aPBzNsEhCVVp2ZORpIv0GP
         rCVw==
X-Gm-Message-State: APjAAAU/ey9YnSiuhnz4tDm8tR0aItXFLNK1MAWs/2IK+DC3KiJtLQK8
        8GHjIOP9nVYaknuJzdQNyMs=
X-Google-Smtp-Source: APXvYqziazUb/32iuEr0gkJHz20eWtRI613WjOB6tkz5rgE8SrNCi8DPdYylU0c4WbF4l6F82FJvqQ==
X-Received: by 2002:adf:ef4c:: with SMTP id c12mr13534378wrp.203.1580490826300;
        Fri, 31 Jan 2020 09:13:46 -0800 (PST)
Received: from szeder.dev (x4db61755.dyn.telefonica.de. [77.182.23.85])
        by smtp.gmail.com with ESMTPSA id f127sm11527931wma.4.2020.01.31.09.13.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Jan 2020 09:13:44 -0800 (PST)
Date:   Fri, 31 Jan 2020 18:13:41 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Martin Melka <martin.melka@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 5/6] dir: replace exponential algorithm with a linear one
Message-ID: <20200131171341.GH10482@szeder.dev>
References: <pull.700.git.git.1580335424.gitgitgadget@gmail.com>
 <40b378e7adbbff5ecfd95fd888465fd0f99791c8.1580335424.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <40b378e7adbbff5ecfd95fd888465fd0f99791c8.1580335424.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 29, 2020 at 10:03:42PM +0000, Elijah Newren via GitGitGadget wrote:
> Part of the tension noted above is that the treatment of a directory can
> changed based on the files within it, and based on the various settings

s/changed/change/, or perhaps s/changed/be changed/ ?

> Since dir.c is somewhat complex, extra cruft built up around this over
> time.  While trying to unravel it, I noticed several instances where the
> first call to read_directory_recursive() would return e.g.
> path_untracked for a some directory and a later one would return e.g.

s/for a some/for some/

> However, on the positive side, it does make the code much faster.  For
> the following simple shell loop in an empty repository:
> 
>   for depth in $(seq 10 25)
>   do
>     dirs=$(for i in $(seq 1 $depth) ; do printf 'dir/' ; done)
>     rm -rf dir
>     mkdir -p $dirs
>     >$dirs/untracked-file
>     /usr/bin/time --format="$depth: %e" git status --ignored >/dev/null
>   done
> 
> I saw the following timings, in seconds (note that the numbers are a
> little noisy from run-to-run, but the trend is very clear with every
> run):
> 
>     10: 0.03
>     11: 0.05
>     12: 0.08
>     13: 0.19
>     14: 0.29
>     15: 0.50
>     16: 1.05
>     17: 2.11
>     18: 4.11
>     19: 8.60
>     20: 17.55
>     21: 33.87
>     22: 68.71
>     23: 140.05
>     24: 274.45
>     25: 551.15
> 
> After this fix, those drop to:
> 
>     10: 0.00
>     11: 0.00
>     12: 0.00
>     13: 0.00
>     14: 0.00
>     15: 0.00
>     16: 0.00
>     17: 0.00
>     18: 0.00
>     19: 0.00
>     20: 0.00
>     21: 0.00
>     22: 0.00
>     23: 0.00
>     24: 0.00
>     25: 0.00

I agree with Derrick here: if you just said that all these report
0.00, I would have taken your word for it.

Having said that...  I don't know how to get more decimal places out
of /use/bin/time, but our trace performance facility uses nanosecond
resolution timestamps.  So using this command in the loop above:

  GIT_TRACE_PERFORMANCE=2 git status --ignored 2>&1 >/dev/null |
    sed -n -e "s/.* performance: \(.*\): git command.*/$depth: \1/p"

gave me this:

  1: 0.000574302 s
  2: 0.000584995 s
  3: 0.000608684 s
  4: 0.000951336 s
  5: 0.000762019 s
  6: 0.000816685 s
  7: 0.000672516 s
  8: 0.000912628 s
  9: 0.000661538 s
  10: 0.000687465 s
  11: 0.000708880 s
  12: 0.000693754 s
  13: 0.000726120 s
  14: 0.000737334 s
  15: 0.000787362 s
  16: 0.000856687 s
  17: 0.000780892 s
  18: 0.000790798 s
  19: 0.000834411 s
  20: 0.000859094 s
  21: 0.001230912 s
  22: 0.001048852 s
  23: 0.000891057 s
  24: 0.000934097 s
  25: 0.001051704 s

Not sure it's worth including, though.

