Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8D3D208B8
	for <e@80x24.org>; Tue, 15 Aug 2017 16:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752681AbdHOQA1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 12:00:27 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:35369 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751539AbdHOQA0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 12:00:26 -0400
Received: by mail-pg0-f51.google.com with SMTP id v189so8066296pgd.2
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 09:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to;
        bh=3F5hM9hc6Po/VgSqGarrWKSoKM72A0peDNZkgCPfbxA=;
        b=pbO+UMIE88rY65CUN9XjavB61KJF95WS4SQ0P4MT4TYH1TwU+GA3GM5Ezyf5ZDHiwp
         bd1O7SCdyGEWJJveUh+zGhLJ1ApEZHrdM/kNYnGjnDyGLwOKD8N5CWwK2u2rrXR9vbz9
         mgn7ef6EHGtAhWkeYSwMgvUwagLhNdYgW1UtAaAhMRkChBj2M+CZvpXxyIBi0tZzSvSL
         m86wZpZ2pwD+EzgDJ1X8chSmNzPrZZuV2SC/tRBbirSpbNAvx1xwbUSJfyG0i01fBrP2
         bWyRUwwTb6hwkgyzId6l0NisQwz5T1kUP0xPevMkSpvu6ps63guugHNDCuzRpq+wvRqG
         c5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=3F5hM9hc6Po/VgSqGarrWKSoKM72A0peDNZkgCPfbxA=;
        b=qAtRyCG1gT/STLdAqTUdj1VSertrA6GSzBNHZdHuuH3pWEbzsSKnVEv2LR9s2vmlyu
         DHYBse9gBpKs+I1faXgqjm/lGd1yjWGNBiaqYdQGBYWkxrthhDyEwSrNcRID5pll1ckp
         +CLKP6Ys6ee45DDK4tQ0wBfLAqv7csQF9GeR6qQsnc4BKHPoC8E1T8Q6DIOHS8LnyXpE
         p83yJ6z0Zge/EUSrjbEGMF28rVlcwx0JFF3m2aSWtwEt6AXWkA66R8LHjwL872UmlSg6
         nCsLwrmvSIq+BIKz4qIhlE0UCT1OHZs1/akmCYvSeH9eqJ8OeU0hXl01QR8gBGH8xXeh
         kyhA==
X-Gm-Message-State: AHYfb5j3PWk4ddo4V0pr92d6l6NuXQ7+h/IN0fYmKSWpP4+R76e46YIk
        iXEoO6hYujyJAkDH6FcSZFwFo8PIXyE9DZA=
X-Received: by 10.84.232.76 with SMTP id f12mr31494563pln.249.1502812825654;
 Tue, 15 Aug 2017 09:00:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.132.193 with HTTP; Tue, 15 Aug 2017 09:00:25 -0700 (PDT)
From:   Anthony Sottile <asottile@umich.edu>
Date:   Tue, 15 Aug 2017 09:00:25 -0700
Message-ID: <CA+dzEBnvVFc2DotLBjAQudFJdSN3NMDAV=UTqzZdxCFTa_BkSQ@mail.gmail.com>
Subject: Inconsistent exit code for `git grep --files-without-match` with `--quiet`
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using the latest revision of git:

$ ./git --version
git version 2.14.GIT

$ ./git-grep --files-without-match nope -- blob.c; echo $?
blob.c
0

$ ./git-grep --files-without-match --quiet nope -- blob.c; echo $?
1

I expect both to exit 0

Note that blob.c does not contain "nope", here is the revision I am
using: https://github.com/git/git/blob/b3622a4ee94e4916cd05e6d96e41eeb36b941182/blob.c
-- this file / case isn't special I just picked a reproduction that
may be convenient for git developers.

Anthony
