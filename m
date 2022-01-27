Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63650C433F5
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 01:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbiA0Bto (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 20:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiA0Btn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 20:49:43 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F07C06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 17:49:43 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id f17so2048225wrx.1
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 17:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=69XB+lqn+oi1UPQKLHxlLnRoQ7Qzu8qhWfy2Ir7xLsY=;
        b=GwBGSsKfdAvHi3d3afx0JmI0QhfuwPZCmAMTREq1PDT5Y/JSnYZJrrSSjJxU3FbAiN
         5YGMb5GGbHHBLDl+EnKb3HQCzCOzvRtq/mRxztaRlGtMOBsEFJMJqbT60RPe9g7Tq7fY
         IovTH85qhFMOAtYaViet8Msz5n2rnIHu9wJjE9nEhwvscgwMF1Ey1RrK553UIMNjJ+3i
         6sYB2uyqnkXJRJDwqHhCvicg+ynwZiEyBmhFnqtThXhktTRFKWwatm89sANGr13YePVF
         b4YdvfM4pmRZ7vUxp0BzsC5/kLYi69J1VzKRnOrWMv6T1Xy76F63WO+BAuRCxE+ncHUU
         8Bcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=69XB+lqn+oi1UPQKLHxlLnRoQ7Qzu8qhWfy2Ir7xLsY=;
        b=XkoFLZVzmhFjtb9nFQllutidf55scgVjdKU5nqahtdeM+VbQTx26UlWft8xBFGnZ08
         7pdkTn7FTrK2GCbn/qEGyUeAFCCiCynLTvPjAXWRG8xEyZ0vWGAP9ZUpQb0VDVuMejE/
         Dm3GSmz6PfXqc4XBtm8CIREZYnsepnCVH1SXbqdzcx6ReUWWiJKPwnsKtwtihXO8aW1a
         duFwKWDdI4xDK83EVbIa8ivb/xzpV7jKaDxWN/BY3c4y5KwFV70MUzqVlKpiZzP23FZm
         jJaRAP9R5JhVH//SoHAmoJNxlEeC3x8h7K1Q0+UeMTO8F+TzLQKRPsyG4dEk7r6AVyuz
         1kFg==
X-Gm-Message-State: AOAM532Rns5gXcpcOAgYfGRd3iIS7uKiAVKDFJGhpG8CP8eN/f0Y9th/
        CVpAY0/tSY/Y1A+ROgh1VGp2jEdejRg=
X-Google-Smtp-Source: ABdhPJy4blYMdnef2uawWNIHXkK6rwFXqI0A8gQhb9TccrEVB4hI6ptAdNEvnJ4dRhda7PX0Xopl6g==
X-Received: by 2002:adf:f905:: with SMTP id b5mr1032405wrr.173.1643248181576;
        Wed, 26 Jan 2022 17:49:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bd20sm4784091wmb.38.2022.01.26.17.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 17:49:41 -0800 (PST)
Message-Id: <pull.1206.git.git.1643248180.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 27 Jan 2022 01:49:38 +0000
Subject: [PATCH 0/2] repack: add --filter=
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series aims to make partial clones more useful by allowing repack
to create packfiles with promisor objects. The longer vision is to be able
to use partial clones on a git server to offload large blobs to an http
server. We can then store large blobs on said http server, and use a remote
helper to grab these objects when necessary.

This is the first step in allowing a repack to honor a filter spec.

John Cai (2):
  pack-objects: allow --filter without --stdout
  repack: add --filter=<filter-spec> option

 Documentation/git-repack.txt   |   5 +
 builtin/pack-objects.c         |   2 -
 builtin/repack.c               |  10 ++
 t/lib-httpd.sh                 |   2 +
 t/lib-httpd/apache.conf        |   8 ++
 t/lib-httpd/list.sh            |  43 +++++++++
 t/lib-httpd/upload.sh          |  46 +++++++++
 t/t0410-partial-clone.sh       |  52 ++++++++++
 t/t0410/git-remote-testhttpgit | 170 +++++++++++++++++++++++++++++++++
 t/t7700-repack.sh              |  20 ++++
 10 files changed, 356 insertions(+), 2 deletions(-)
 create mode 100644 t/lib-httpd/list.sh
 create mode 100644 t/lib-httpd/upload.sh
 create mode 100755 t/t0410/git-remote-testhttpgit


base-commit: 89bece5c8c96f0b962cfc89e63f82d603fd60bed
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1206%2Fjohn-cai%2Fjc-repack-filter-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1206/john-cai/jc-repack-filter-v1
Pull-Request: https://github.com/git/git/pull/1206
-- 
gitgitgadget
