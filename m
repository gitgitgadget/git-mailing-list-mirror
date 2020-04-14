Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1EAC2BB1D
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 04:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBEAF206D5
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 04:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="ZoXM5yP+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405060AbgDNEEE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 00:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726058AbgDNEED (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 14 Apr 2020 00:04:03 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C598EC0A3BDC
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 21:04:02 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id q16so3734268pje.1
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 21:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=QLt0FezmkPeprR9nv1zEqUI7NOAheGSRHgD0ZkDr1BI=;
        b=ZoXM5yP+gKNYiM8oO2j9uML3SdfSO0eUWzlJNGM+d4nMEhDvCXCHHuyrb5vZ+BT0tX
         AgfngTyRUgLk4AbiuQuD8LIkKL7yLZudLndwt50BTSy54LevnWZmNINiOYPdwVSKpj6L
         HQ84n648LGl/AQh4ne/z7K70EVKs9p8ZWu4TGMVYr5tHdYHDpSpSdXCrAOy6YSC67jrn
         6kpYQv+jnhwOhUGuQPAkqyDCz5H9wwmnpTUJVwzSwiW/E9LhBSRlipIE214/TamPKl2l
         6K+j2ezH1C+ytqYXLO/Ke1HGeEDo94cudIdfwIASKxc1MHVAR7sP+3RvEQ/aqDM+9TOg
         zc3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=QLt0FezmkPeprR9nv1zEqUI7NOAheGSRHgD0ZkDr1BI=;
        b=B4/0FtVncMNbw8Ez0HiD0QMx6XVpbX/ArTjqfLy5uwQho6JwfLDIMrFTfqbptbBpyL
         w3QrUM5n+4jCz8/PtTREoKz/qsH0y/oBkMlpWVP8SyxofPOMRiYyNqvkWP7u9NSMtWN5
         Ev6XF3VQ0TOq/ofySIo49GW+/ktEUcHCuBu36fI2chc8SWBsXy725Hjvy0r4g4m/5h2+
         OwJuWZvVlL3Z4za3CpEOxuPj49y0Z+rukr4FcNF9qyciW9fD+pcC1BCFHr2yWYiFY+kI
         eChARzfzs4oixNIi/2JRkIIOWHcWNpIQH2JpRWHTyrYA02AOe4dXzjzc636+HYVIOKmS
         JRLw==
X-Gm-Message-State: AGi0PuY/btnBnVkk3H4YDcYNlXfuUJeIbXB2lIDSD8ASDSTOvEMHQPxu
        y081Kv4TpOwj8PcLJ7EH/Duc7m86h8L4ixkD
X-Google-Smtp-Source: APiQypJgG10sxcuqFgcirmGBx3c8hNrO+VxdKKkkc102M+2D5XYY/ZIq0aSF5EwfLCLSd76SxdrPPg==
X-Received: by 2002:a17:90b:4396:: with SMTP id in22mr25485520pjb.10.1586837041615;
        Mon, 13 Apr 2020 21:04:01 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id f15sm9897814pfq.100.2020.04.13.21.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 21:04:00 -0700 (PDT)
Date:   Mon, 13 Apr 2020 22:03:59 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, szeder.dev@gmail.com
Subject: [PATCH 0/7] commit-graph: split strategies, '--[no-]check-oids'
Message-ID: <cover.1586836700.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

This is a reworked version of a couple of series [1, 2] that add various
options to the 'git commit-graph write' builtin. I had developed [1, 2]
while deploying incremental commit-graphs at GitHub, and so there was a
lot in flux about what options we needed and so on.

Now that the dust has settled, I cleaned up all of the patches generated
during that time into a grab-bag series that reflects what we ended up
sticking with.

Namely, I got rid of the '--input=<source>' options ('--input=none' was
confusing at best, and we ended up not needing it), as well as
'--split=merge-all'. We used to use this to roll up all of the
incremental graphs generated during pushes into one big length-1 chain
every N pushes. But, we ended up abandoning this, too, in favor of
'--split=replace', which is described in the fourth patch. I'm not sure
if anyone will be sad to see '--split=merge-all' go, so if you are,
please let me know and I'll drag that patch back in.

Thanks for all of the review that I've received so far, and thanks in
advance for your review on these patches.

[1]: https://lore.kernel.org/git/cover.1580430057.git.me@ttaylorr.com/
[2]: https://lore.kernel.org/git/cover.1584762087.git.me@ttaylorr.com/

Taylor Blau (7):
  t/helper/test-read-graph.c: support commit-graph chains
  builtin/commit-graph.c: support for '--split[=<strategy>]'
  builtin/commit-graph.c: introduce split strategy 'no-merge'
  builtin/commit-graph.c: introduce split strategy 'replace'
  oidset: introduce 'oidset_size'
  commit-graph.h: replace 'commit_hex' with 'commits'
  commit-graph.c: introduce '--[no-]check-oids'

 Documentation/git-commit-graph.txt |  22 +++--
 builtin/commit-graph.c             |  59 +++++++++++--
 commit-graph.c                     | 129 +++++++++++++++++++----------
 commit-graph.h                     |  10 ++-
 oidset.c                           |   5 ++
 oidset.h                           |   5 ++
 t/helper/test-read-graph.c         |  13 +--
 t/t5318-commit-graph.sh            |  30 ++++++-
 t/t5324-split-commit-graph.sh      |  30 +++++++
 9 files changed, 230 insertions(+), 73 deletions(-)

--
2.26.0.106.g9fadedd637
