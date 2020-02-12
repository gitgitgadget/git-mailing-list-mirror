Return-Path: <SRS0=D6Hn=4A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E0EC352A4
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 05:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B5E2073C
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 05:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Ql7W4hTY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbgBLFry (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Feb 2020 00:47:54 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33913 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgBLFrx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Feb 2020 00:47:53 -0500
Received: by mail-pl1-f194.google.com with SMTP id j7so527607plt.1
        for <git@vger.kernel.org>; Tue, 11 Feb 2020 21:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=sC/D/e9+2AyF5QfgHstvgi1Jq6hnrBDosp21U36E1eM=;
        b=Ql7W4hTYpgAUnhT+/QUs7/y7VZV6X/DYd6JGg1YKmT+rxT/boWdRSi1MrdD3BKQWcc
         vQvFyRnQDmQmuRvpNuykV84O8Kq+aLmSLRMHZ7owNtylemQgcSgy01+SPLDiiezbFO/f
         YapMLy8xhuXEEbb9jHbl1SwYOg+Sck54yholGyEm+CutaKeTFgwEoiymmu9g/zDnkAwo
         eBReLxrrDQxxrqBrl7STy06KCysqfGUvoJGnS5ayogPw7gWz/CE+mv0z1fhhTzoMPN3j
         uqzof16I3Fz9URCQ1jZhDGHPeJut1ZPyJ/erHhT9sO0UezDIgU2DlGbi+8Tgy2ZO/342
         Cz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=sC/D/e9+2AyF5QfgHstvgi1Jq6hnrBDosp21U36E1eM=;
        b=ucoKJMVHV0fE4uN/UC2oXwuN4smouqq1BDNvDd89QDWeFNVA9THQrl5NKQdg5Pjjw5
         yREIw6D+BitOyyMGJ3R5QISS6OX2YiH4CHVvSTfMuu67lkG1FlNqwuhEDMmfP1/PPFkp
         V18mL4Zo5J9hP8Nb/F8S5PxQTn/evHFWQ1gkkuDZly8QVm9enD7BGtRhbY93icPEbtin
         eU+rIhyoVqkR6T4bzq0W7eXgkSYnkKptW5wrHFx295Rn2I+BcWq0vUXCt43YenaF1nQh
         4Byn6wZh3UVHQ4aEtWahszn9H150Lz2AB4d3gj6yFIP2QCSOpABdN4QqGTvZmxpQ+3ii
         MrNw==
X-Gm-Message-State: APjAAAXCysAzJUistvc/cv4nAi3Qd3pHGGO8JhH7uCEnutqkjxnalftk
        gobwY04TXwpbmugwOh7C7N6wS46Y0p7N4A==
X-Google-Smtp-Source: APXvYqxbneVFKHR1OdgkOUqBE+ZtSaKGpHb/pvn6RY9DZhgCpNIEWSCzHp35+dBssfBUx30qjQ3L2Q==
X-Received: by 2002:a17:90a:7781:: with SMTP id v1mr8107395pjk.108.1581486472735;
        Tue, 11 Feb 2020 21:47:52 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:e4b4:608a:57ae:c0a6])
        by smtp.gmail.com with ESMTPSA id h62sm6205370pfg.95.2020.02.11.21.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 21:47:51 -0800 (PST)
Date:   Tue, 11 Feb 2020 21:47:50 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        martin.agren@gmail.com
Subject: [PATCH v3 0/3] builtin/commit-graph.c: new split/merge options
Message-ID: <cover.1581486293.git.me@ttaylorr.com>
References: <cover.1580430057.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1580430057.git.me@ttaylorr.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everybody,

Attached is what I anticipate/hope to be the final reroll of my series
to add new arguments to the 'git commit-graph write --split' flag to
allow callers to force or prohibit the commit-graph machinery to merge
multiple commit-graph layers.

I was keeping an eye out for more discussion about whether or not these
flags were acceptable by reviewers. Martin Ågren and Derrick Stolee have
both chimed in that they seem OK.

Since there hasn't been much more discussion in this thread, I replayed
this series on top of 'tb/commit-graph-use-odb' (which was itself
rebased on 'master'). I picked up a couple of ASCIIDoc changes along the
way, and a range-diff is included below.

Thanks again.

Taylor Blau (3):
  builtin/commit-graph.c: support '--split[=<strategy>]'
  builtin/commit-graph.c: introduce '--input=<source>'
  builtin/commit-graph.c: support '--input=none'

 Documentation/git-commit-graph.txt |  51 ++++++++-----
 builtin/commit-graph.c             | 115 +++++++++++++++++++++++------
 commit-graph.c                     |  28 ++++---
 commit-graph.h                     |  10 ++-
 t/t5318-commit-graph.sh            |   4 +-
 t/t5324-split-commit-graph.sh      |  53 ++++++++++++-
 6 files changed, 205 insertions(+), 56 deletions(-)

Range-diff against v2:
1:  6428dac6e5 ! 1:  e1635a0e34 builtin/commit-graph.c: support '--split[=<strategy>]'
    @@ Documentation/git-commit-graph.txt: or `--stdin-packs`.)
     +strategy and other splitting options. The new commits not already in the
     +commit-graph are added in a new "tip" file. This file is merged with the
     +existing file if the following merge conditions are met:
    +++
     +* If `--split=merge-always` is specified, then a merge is always
     +conducted, and the remaining options are ignored. Conversely, if
     +`--split=no-merge` is specified, a merge is never performed, and the
2:  c7ba70e19d = 2:  655fe63076 builtin/commit-graph.c: introduce '--input=<source>'
3:  7d6a608acd ! 3:  4e85c6f7e4 builtin/commit-graph.c: support '--input=none'
    @@ Documentation/git-commit-graph.txt: walking commits starting at all refs. (Canno
      +
     +With the `--input=none` option, behave as if `--input=append` were
     +given, but do not walk other packs to find additional commits.
    -+
    +++
     +If none of the above options are given, then generate the new
     +commit-graph by walking over all pack-indexes.
     ++
--
2.25.0.119.gaa12b7378b
