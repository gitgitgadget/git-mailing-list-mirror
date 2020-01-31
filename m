Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1B3C33CB3
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 00:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0FC220661
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 00:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="fQ0YianV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbgAaA2R (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 19:28:17 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:52342 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbgAaA2R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 19:28:17 -0500
Received: by mail-pj1-f65.google.com with SMTP id ep11so2050767pjb.2
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 16:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=FBYajqKe4DhVmge/7XKHXb05uLUAfPuK8m8RQx4Wzn0=;
        b=fQ0YianVWVmH0/sUgA+gDJhlWQuINzDI2hYIv/pT6CR7diLNholGY7rX8RM3YSjsEM
         9mkfGU/QCUHFgNjU38vTN573kzc+WtQLAq/g74OpgukFgk09zO3T2Zs/OVhI/uWDgkha
         P1YTQjXe22vB5ExQNCZgfOcFaf0J2ESzGYqU0hkzt/e4XuctwYxkKQzbHvtNtmGZ2OJQ
         /vp14Fp3xLlByxDpR2NoMTwIcsQ9JTCWp/NFXWjYsc3BvuUetTDakDWYzz+dYjHZL5It
         ZqsYOAFSgbzb0xC1KzDojQiHO00VQtM47JDgo7qjwfHy6XYk0uipLqAJVb+Xi/ARBWRE
         0+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=FBYajqKe4DhVmge/7XKHXb05uLUAfPuK8m8RQx4Wzn0=;
        b=B7LudwjE7xdg8YqI2xqhAlXHTgYY8xu0FyePghgg4yVBzeAzOuywmaaNrs7yc1zLy6
         EO5RGlEz+XCr1x0VclkgPr3oydJFDRZnKIGy+oh7GVNCPZqh3wxK0ZU4+Wf64Vs/7shq
         BYeb4qPePppm5gYx+cp2Bmxnshm7mB5wxWaPYGKnZFp6Mb+AY6cbFrJDXe69VuWAONG/
         lZ9neBEEWbIinRawHUXjVNvLO6PZppOtDIZ+yCt5HF2Zm1Eut9MXN1eOIqDapC52Zz7K
         GoYK1ijiOgBY8y6WqtGWLknnZ63HFZC46e0TZQsdNXwAeku6tvZjYU4GgoizWNeRIpvX
         sEYg==
X-Gm-Message-State: APjAAAXvgpkvft/std9qYZtUGUx1h92fZULyOLtfoWyXpuhe2sv5tBiG
        Rz49WkYui4EvuNHlooBnoXspETqZftYVbg==
X-Google-Smtp-Source: APXvYqx5vQfxF/X5aiXS7848sGVt2ajWykuf66MMC/4hb+dTN028KGzxAaU06NmWJpQBSk7x1iCa0A==
X-Received: by 2002:a17:902:16b:: with SMTP id 98mr7470219plb.218.1580430496112;
        Thu, 30 Jan 2020 16:28:16 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:5c8f:7dac:47b8:95ff])
        by smtp.gmail.com with ESMTPSA id a16sm7569754pgb.5.2020.01.30.16.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 16:28:15 -0800 (PST)
Date:   Thu, 30 Jan 2020 16:28:14 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com
Subject: [PATCH 0/3] builtin/commit-graph.c: new split/merge options
Message-ID: <cover.1580430057.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Here are another few patches that came out of working on GitHub's
deployment of incremental commit-graphs. These three patches introduce
two new options: '--split[=<merge-all|no-merge>]' and
'--input=<source>'.

The former controls whether or not commit-graph's split machinery should
either write an incremental commit graph, squash the chain of
incrementals, or defer to the other options.

(This comes from GitHub's desire to have more fine-grained control over
the commit-graph chain's behavior. We run short jobs after every push
that we would like to limit the running time of, and hence we do not
want to ever merge a long chain of incrementals unless we specifically
opt into that.)

The latter of the two new options does two things:

  * It cleans up the many options that specify input sources (e.g.,
    '--stdin-commits', '--stdin-packs', '--reachable' and so on) under
    one unifying name.

  * It allows us to introduce a new argument '--input=none', to prevent
    walking each packfile when neither '--stdin-commits' nor
    '--stdin-packs' was given.

Together, these have the combined effect of being able to write the
following two new invocations:

  $ git commit-graph write --split=merge-all --input=none

  $ git commit-graph write --split=no-merge --input=stdin-packs

to (1) merge the chain, and (2) write a single new incremental.

Thanks in advance for your review, as always.

Taylor Blau (3):
  builtin/commit-graph.c: support '--split[=<strategy>]'
  builtin/commit-graph.c: introduce '--input=<source>'
  builtin/commit-graph.c: support '--input=none'

 Documentation/git-commit-graph.txt |  55 ++++++++------
 builtin/commit-graph.c             | 113 +++++++++++++++++++++++------
 commit-graph.c                     |  25 ++++---
 commit-graph.h                     |  10 ++-
 t/t5318-commit-graph.sh            |  46 ++++++------
 t/t5324-split-commit-graph.sh      |  85 +++++++++++++++++-----
 6 files changed, 239 insertions(+), 95 deletions(-)

--
2.25.0.dirty
