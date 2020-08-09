Return-Path: <SRS0=dguO=BT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E15BC433E0
	for <git@archiver.kernel.org>; Sun,  9 Aug 2020 02:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47A64206B2
	for <git@archiver.kernel.org>; Sun,  9 Aug 2020 02:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f49bxje2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgHICTc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Aug 2020 22:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgHICTb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Aug 2020 22:19:31 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE174C061756
        for <git@vger.kernel.org>; Sat,  8 Aug 2020 19:19:31 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 74so3262990pfx.13
        for <git@vger.kernel.org>; Sat, 08 Aug 2020 19:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l9ndQPNNkLs4BzkE1h2zTs58WXQE/L2OzLMhX9pcI28=;
        b=f49bxje2k1Rw/DR0Q80fFawvomCjCHttuzqdvo4kabL1YUinBc37yzZsDtbcdAqvId
         UufSwaXLh68JzWACXSJVy1oVbirv86R9BrhYXqcQM1exbn6z/sr5vwt+V38ZYCEKXXzb
         c9qDePxlD4tJH7LwhP+DzgaCw23a2CB7NDa/mitDfn35tV1enY38/K0g3ohRFdmAC2/x
         ZCotxj2gCb2VUGT23oTWXqWBge1iqhrXxfiY90Pf2ljNY8CP45Zw9TbTv/L9G16qTAvW
         qp6IcEzvlgtUYq4oylkEZdFsRMDMgW4Acv2q4cX0iPp2MpxNjk93biPiSgWtSjFS+hId
         xKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l9ndQPNNkLs4BzkE1h2zTs58WXQE/L2OzLMhX9pcI28=;
        b=Zj1/4IaABBQ29LhxiSdQy64JgsJ93UjhMh379LoyKRKTJj40hjuYltS5QFkuQnkTKl
         kixT/RHnb388XBwqIK3OTRyIETxSChOcWX16+peD5E/yfQIldMS5/n5RsySkdPMW/8sG
         Qr4tu//k+AAIZTXA+KChDDXSFiI90Khq8p4CQEKfMeSPr9WuwCgLS95kv9VPNRUtA/bS
         rcXhwT9Z4t5xjjmSIODBBDdVGN2iZSVbsvL6x1xk9Dv/vpqPNQrwypz0yCJijEcjaPvh
         bgJrhtkMOqjwTPGQBRJh66YNieVncq7Uf1+CiWmjB6a2iN4adwO3JBF/3qlPr0G46zlh
         F5CA==
X-Gm-Message-State: AOAM533u9xaYWeiyu4ejLZOOyiHgrRiXbYNXE5hv+hJmWGN8bwCQeHXa
        IbXUrDUor2kFNHn4ZT98ISwwY2XT
X-Google-Smtp-Source: ABdhPJzuo5pCrRABELjctlg57HfzonMOS6wh1JOw39elLX1I1/q+5ATQk2AdYidRwfs9VGiFGNEefg==
X-Received: by 2002:aa7:9535:: with SMTP id c21mr19826277pfp.322.1596939571096;
        Sat, 08 Aug 2020 19:19:31 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:ea17:7ad5:df16:a252:473b])
        by smtp.gmail.com with ESMTPSA id g129sm17631235pfb.33.2020.08.08.19.19.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Aug 2020 19:19:30 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [RFC PATCH 0/2] extend --abbrev support to diff-patch format
Date:   Sun,  9 Aug 2020 09:19:03 +0700
Message-Id: <cover.1596887883.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.28.0.215.g32ffa52ee0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For some reason, projects tracks local copy of released version of other
projects, and backports change to earlier version.

Due to lower number of object in simplified history,
abbreviated object id has fewer characters, thus generate some noise
when projects try to compare the backported patch with original patch
if the file hunk is an exact match.

This series try to lower that noise.
Since this is very localised use case,
and the noise is not completely eliminated,
other experienced developers may have better opinions.

Đoàn Trần Công Danh (2):
  revision: differentiate if --no-abbrev asked explicitly
  diff: extend --abbrev support to diff-patch format

 Documentation/diff-options.txt                |  9 +++---
 diff.c                                        |  5 +++-
 revision.c                                    |  2 +-
 t/t4013-diff-various.sh                       |  3 ++
 ...ff.diff-tree_--root_-p_--abbrev=10_initial | 29 +++++++++++++++++++
 ...--root_-p_--full-index_--abbrev=10_initial | 29 +++++++++++++++++++
 ...f.diff-tree_--root_-p_--full-index_initial | 29 +++++++++++++++++++
 7 files changed, 100 insertions(+), 6 deletions(-)
 create mode 100644 t/t4013/diff.diff-tree_--root_-p_--abbrev=10_initial
 create mode 100644 t/t4013/diff.diff-tree_--root_-p_--full-index_--abbrev=10_initial
 create mode 100644 t/t4013/diff.diff-tree_--root_-p_--full-index_initial

-- 
2.28.0.215.g32ffa52ee0

