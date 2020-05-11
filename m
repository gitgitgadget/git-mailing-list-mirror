Return-Path: <SRS0=tgTL=6Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15B4C47255
	for <git@archiver.kernel.org>; Mon, 11 May 2020 05:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBD7B20735
	for <git@archiver.kernel.org>; Mon, 11 May 2020 05:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmzGeGaK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgEKFuF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 01:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725906AbgEKFuF (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 May 2020 01:50:05 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0250C061A0C
        for <git@vger.kernel.org>; Sun, 10 May 2020 22:50:04 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k1so9266346wrx.4
        for <git@vger.kernel.org>; Sun, 10 May 2020 22:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=hrtVJSDMktIW7CjSriN7IuOgvr95Yg6NHRiBgiva5Mo=;
        b=DmzGeGaKw6x3/d45qa/NneYR7zx8VuhGU4gYGs4WSqW93H6h39Xsm7siFd/7omcGB2
         dtRvarHOqyrED6jjT4Ce2OWlUOFpAxTw09kHx9nYFeWCzAq7X2ekmXz6g6UWDag+akj4
         biW9IDOCDOMWlHZ68FFCcO3lp/93dWn6f6KBP+YtdCb4i+9EfiFm5x/Ra6PHE/ynn63F
         +baK2qKLe7EhSWxB6R+rcXukoMlV91zmWMQxJIb6H3KjpbP90lTrHT81OMjhUrcVPp9N
         VfE4ZMvWVXhIDGW0LY9NXmxs51SF+n4STJM6XvldWZY7Q36evIzR/yajEr0MV3wSpLvb
         p6Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hrtVJSDMktIW7CjSriN7IuOgvr95Yg6NHRiBgiva5Mo=;
        b=o/3Yiv9wwX5XmRVmvaAaXFWJcNDyvf4QqxrADVC/pUM2UGhjF3ff94EfzF18sseC5c
         fdpXqlD9Zmq6KOm3LR8RZGZgzXXTSvPMvPgUO077HrJag4hCIOoW2NPqr4XIi5WhoIVg
         ytLOiPwVGgzLnotEwL/lqM6HPGAF+vYhORk/WeauereCTgQFcQlbCT9XXkoA1kI1UqLp
         q/9ksLhCGCS+iauvf7YWeGMPRuzjxDEbjInKfUY7lGCi637cQQmmz2w7eDdyek9E2s0N
         wBL5LVPyT82Qa7Ccp5ilu1VUG6gVa8jnreSql2Yh4AcJWJvqJHKwQ8PA+SnGEHy4O+U8
         /lRg==
X-Gm-Message-State: AGi0PuaEVzZpOpwSpc9CqCGedAlnlhV3HZNNlrqzaiRehKJ7yUK90a62
        hRht29gRx1GI7uBdS8ab7WxdhoWp
X-Google-Smtp-Source: APiQypKJhsePwLVhFHqA6NN527B2oQwd5tFLOrSdK0V3vq/OS2q/3ljAsS6xewgc7GoCDmQC+KG/FQ==
X-Received: by 2002:adf:eac8:: with SMTP id o8mr1437663wrn.268.1589176202943;
        Sun, 10 May 2020 22:50:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m18sm9372497wru.78.2020.05.10.22.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 22:50:02 -0700 (PDT)
Message-Id: <pull.493.git.1589176201.gitgitgadget@gmail.com>
From:   "Tom Clarkson via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 11 May 2020 05:49:54 +0000
Subject: [PATCH 0/7] subtree: Fix handling of complex history
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Avery Pennarun <apenwarr@gmail.com>,
        Tom Clarkson <tom@tqclarkson.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fixes several issues that could occur when running subtree split on large
repos with more complex history.

 1. A merge commit could bypass the known start point of the subtree, which
    would cause the entire history to be processed recursively, leading to a
    stack overflow / segfault after reading a few hundred commits. Older
    commits are now explicitly recorded as irrelevant so that the recursive
    process can terminate on any mainline commit rather than only on subtree
    joins and initial commits.
    
    
 2. It is possible for a repo to contain subtrees that lack the metadata
    that is usually present in add/join commit messages (git-svn at least
    can produce such a structure). The new use/ignore/map commands allow the
    user to provide that information for any problematic commits.
    
    
 3. A mainline commit that does not contain the subtree folder could be
    erroneously identified as a subtree commit, which would add the entire
    mainline history to the subtree. Commits will now only be used as is if
    all their parents are already identified as subtree commits. While the
    new code can still be tripped up by unusual folder structures, the
    completely unambiguous solution turned out to involve a significant
    performance penalty, and the new ignore / use commands provide a
    workaround for that scenario.

Tom Clarkson (7):
  subtree: handle multiple parents passed to cache_miss
  subtree: exclude commits predating add from recursive processing
  subtree: persist cache between split runs
  subtree: add git subtree map command
  subtree: add git subtree use and ignore commands
  subtree: more robustly distinguish subtree and mainline commits
  subtree: document new subtree commands

 contrib/subtree/git-subtree.sh  | 185 ++++++++++++++++++++++++++------
 contrib/subtree/git-subtree.txt |  24 +++++
 2 files changed, 177 insertions(+), 32 deletions(-)


base-commit: af6b65d45ef179ed52087e80cb089f6b2349f4ec
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-493%2Ftqc%2Ftqc%2Fsubtree-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-493/tqc/tqc/subtree-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/493
-- 
gitgitgadget
