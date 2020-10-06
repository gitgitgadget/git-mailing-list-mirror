Return-Path: <SRS0=+hCi=DN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D832C4363D
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 22:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C53E2208B6
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 22:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TR2GHd7h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgJFWFQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Oct 2020 18:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbgJFWFQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Oct 2020 18:05:16 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2578C061755
        for <git@vger.kernel.org>; Tue,  6 Oct 2020 15:05:15 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id g12so9700071wrp.10
        for <git@vger.kernel.org>; Tue, 06 Oct 2020 15:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jWSynWloemCY0ERb9dOL5i1UJMRLuuasnJU2FvWPrj8=;
        b=TR2GHd7hyiMLNP50vzXzgMPF4BMTWvZ0VRKF5jOJrVhzhvutZgICxea41CddTw+nLU
         MKhEFSfzqvTCC10v3wXwQRHVK62LfsGORJ5QUMPI/1PuwsXuHEHwEgqzwvzupvx5jmLF
         Yl3lGI7UcR8PIBjOLHG9kkWmyjlwlFMv9H7CgLtvDuTP1Jx43j82QIc28qKYNc0gXX99
         IOHZNB3ASSFXLEhDEgCQBPFFTCsQdRsfKBxTK8zco8H24Ri5usrAzNgsfmvXyD8+QmfL
         oJUaWWt0L/t/UHjhiMDdx0YrSVsU+FAWN+M8I6PrgXpMW3ZQR6CK5TkrVulVwBED0EDJ
         YtJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jWSynWloemCY0ERb9dOL5i1UJMRLuuasnJU2FvWPrj8=;
        b=AHVz3lFl8bGriG6DO1err3TDJmcDj8hXEgX/n3v0UBWriRxPnz3QxyJD+9/5s1NekV
         TyixHPo7Fh6NjAZkBomqYRbTvTyq3rSI+TZ3LLisTnT8ARF+2ATZnui+H2B3mQFEkvty
         SAnUsAgTxprSjhQr2EFeV3R7Ip/AE9jYoYMuREAyUt+P7+yoend4E2cfL8kEHXnF3EIj
         xIIfRC/T7vFfX3IwKJpgWWvd+1SsSZHQZd0gydBq7oqaTqDzI7KQRbizhtPb/6z6hRQh
         0BcbNWDSiL0GZ7/E9lOImx/EOVE1KI6x3iE7bSCNAjR//aIjj1WnIs2X+DaPsaicrb/p
         QWQg==
X-Gm-Message-State: AOAM533WeH4cI7ef5wlNEPHnhaoV3qjAY1bJtKIqn/FfZ14wsbf4RSFJ
        Ri1joY8tpPDzbvGANwOLmxZCbJlbdk0=
X-Google-Smtp-Source: ABdhPJydwhSvsHXzlvG4YbW+t+z/fUSjhtkgNtuS+3o4z+N2sZ09BWptmtwQKreSw5Mxy0Wv0+8hEQ==
X-Received: by 2002:a05:6000:110f:: with SMTP id z15mr32020wrw.87.1602021914462;
        Tue, 06 Oct 2020 15:05:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 10sm119248wmn.9.2020.10.06.15.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 15:05:13 -0700 (PDT)
Message-Id: <pull.493.v2.git.1602021913.gitgitgadget@gmail.com>
In-Reply-To: <pull.493.git.1589176201.gitgitgadget@gmail.com>
References: <pull.493.git.1589176201.gitgitgadget@gmail.com>
From:   "Tom Clarkson via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 06 Oct 2020 22:05:06 +0000
Subject: [PATCH v2 0/7] subtree: Fix handling of complex history
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Avery Pennarun <apenwarr@gmail.com>, Ed Maste <emaste@freebsd.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tom Clarkson <tom@tqclarkson.com>
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

 contrib/subtree/git-subtree.sh  | 183 ++++++++++++++++++++++++++------
 contrib/subtree/git-subtree.txt |  24 +++++
 2 files changed, 175 insertions(+), 32 deletions(-)


base-commit: 47ae905ffb98cc4d4fd90083da6bc8dab55d9ecc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-493%2Ftqc%2Ftqc%2Fsubtree-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-493/tqc/tqc/subtree-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/493

Range-diff vs v1:

 1:  74fa670490 = 1:  9cff2a0cf6 subtree: handle multiple parents passed to cache_miss
 2:  87af5a316a ! 2:  79b5f4a651 subtree: exclude commits predating add from recursive processing
     @@ contrib/subtree/git-subtree.sh: find_existing_splits () {
      +	debug "Looking for first split..."
      +	dir="$1"
      +	revs="$2"
     -+	main=
     -+	sub=
     -+	local grep_format="^git-subtree-dir: $dir/*\$"
     -+	git log --reverse --grep="$grep_format" \
     ++
     ++	git log --reverse --grep="^git-subtree-dir: $dir/*\$" \
      +		--no-show-signature --pretty=format:'START %H%n%s%n%n%b%nEND%n' $revs |
      +	while read a b junk
      +	do
 3:  c892ee9828 = 3:  8eec18388c subtree: persist cache between split runs
 4:  a67c256a59 = 4:  1490ce1114 subtree: add git subtree map command
 5:  a76a49651b = 5:  2d103292ce subtree: add git subtree use and ignore commands
 6:  27a43ea2c4 = 6:  a7aaedfed3 subtree: more robustly distinguish subtree and mainline commits
 7:  19db9cfb68 = 7:  fe2e4819b8 subtree: document new subtree commands

-- 
gitgitgadget
