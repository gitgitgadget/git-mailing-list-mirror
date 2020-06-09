Return-Path: <SRS0=lPKc=7W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A83C433E0
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 00:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88545207C3
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 00:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNnG40+P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387997AbgFIADu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387925AbgFIADq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 20:03:46 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FD6C08C5C2
        for <git@vger.kernel.org>; Mon,  8 Jun 2020 17:03:44 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id y17so19294091wrn.11
        for <git@vger.kernel.org>; Mon, 08 Jun 2020 17:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=RhqA52o3yjmXQPfMVJGxstfmlE2DXrg4DdlHlps39ow=;
        b=MNnG40+PZ0gslbW1gbaSHKth4ooOFnbpZhjFb1e9wot8w8ERWjyvcmMc5VFj2r9wtg
         N6rY+paBdfJjAB8Mj6Qrm/OgYrBPrHzXEce9MYdRzfT2+gb1HUUS8svhslzgRPcsTpiL
         ZDIm4Ir8i0MUpATmAWX3vaD5NjxxGmn7e0iqmd0IkBn67R3R1/hO6v4OHwv2IsSSH0jV
         lovCAysJs1XXrKcStzDrHR9is0rdIKOl0ORsf3i+/2CCtBIrA0K1WRpw4NX7bflAtkjX
         N+K6ieFIqEPZ+zCr+snfqxlgjRRJ4qqia3amzr+DMZXoIQ7VjtRjoiOChGC8C9hUq0HI
         TNRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RhqA52o3yjmXQPfMVJGxstfmlE2DXrg4DdlHlps39ow=;
        b=UfjNYzV1cCzLdMmP9IclOwpANhZkzrbvAAj69UoTbcyWZmTnPFRbvPcDS85MkQSZEe
         f24R2mTQmDLefgYbwSvVYhwx0qnYjEAgw4jdyNyckjLF1i0Fp9QI8eJsj0Z85proEHpG
         HSGV6s3R3UYkMB9LamY0DyF2s5YnBBNEsHKi9iOvKjLgaTTNlgmtszBv6fiaUWxRMOIg
         c41yEAgHW1NiHiI9Ym9FsBhlYozJfPpGCBjGzHneL7rHV2lzN5jyNkHiCG4ZuQ9bUb+0
         SfkKbBTtN9h/viUeTrBTiUFwF7u4vfV9HBsSE1suNAYIk0BNZ0Eojcy7AFU86f/uTBUF
         EoPg==
X-Gm-Message-State: AOAM532EH7Wv7ELNOAnsURpmL8jvzHcv+JzG1m9v3q8IjqE2xzS6FIiF
        hbSd0RZV199eBB3SdBFjKfSvG8/E
X-Google-Smtp-Source: ABdhPJzikHwAmcxlKbqsrSn642be6oYrXlZs0HQ8EwZh+9t3Xw5EWV3LdrFdP9gxzvD/Rye8pLBNdQ==
X-Received: by 2002:adf:e887:: with SMTP id d7mr1300259wrm.62.1591661022904;
        Mon, 08 Jun 2020 17:03:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q128sm1008336wma.38.2020.06.08.17.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 17:03:42 -0700 (PDT)
Message-Id: <pull.804.git.git.1591661021.gitgitgadget@gmail.com>
From:   "Chris Torek via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 Jun 2020 00:03:38 +0000
Subject: [PATCH 0/3] improve git-diff documentation and A...B handling
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git diff -h help is succinct, but perhaps too much so.

The symmetric-diff syntax, git diff A...B, is defined by the documentation
to compare the merge base of A and B to commit B. It does so just fine when
there is a merge base. It compares A and B directly if there is no merge
base, and it is overly forgiving of bad arguments after which it can produce
nonsensical diffs.

The first patch simply adjusts a test that will fail if the second patch is
accepted. The second patch adds special handling for the symmetric diff
syntax so that the option parsing works, plus a small test suite. The third
patch just updates the SYNOPSIS section of the documentation and makes the
help output more verbose (to match the SYNOPSIS and provide common diff
options like git-diff-files, for instance).

Chris Torek (3):
  t/t3430: avoid undocumented git diff behavior
  git diff: improve A...B merge-base handling
  Documentation: tweak git diff help slightly

 Documentation/git-diff.txt |   2 +
 builtin/diff.c             | 138 ++++++++++++++++++++++++++++++++-----
 t/t3430-rebase-merges.sh   |   2 +-
 t/t4068-diff-symmetric.sh  |  81 ++++++++++++++++++++++
 4 files changed, 206 insertions(+), 17 deletions(-)
 create mode 100755 t/t4068-diff-symmetric.sh


base-commit: 20514004ddf1a3528de8933bc32f284e175e1012
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-804%2Fchris3torek%2Fcleanup-diff-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-804/chris3torek/cleanup-diff-v1
Pull-Request: https://github.com/git/git/pull/804
-- 
gitgitgadget
