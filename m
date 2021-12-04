Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7CAC433FE
	for <git@archiver.kernel.org>; Sat,  4 Dec 2021 02:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384099AbhLDC7C (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 21:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238466AbhLDC7C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 21:59:02 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB96C061751
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 18:55:37 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id u1so9576206wru.13
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 18:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=BRbFsIWE8FRYYsLc9p3xKYutVaHyD9NwxFuE6OgGodc=;
        b=Zfh30ZpEfj9EuJBiv8O7eOd/2skCHvl7j8RswLOathoWoz9yDUn2itE9yidewK9N0U
         yoCWyP2VFFOzIw/872s2RW7kAVrU/utYTdwRirvUGBV2svTSxbAp9dk3O2CtFQW4li6/
         k4qut4Axb6YsJ1Hs2AgSsw2lxWEP90qRhSNQNAXTvoC7O25W/n2NXQ6QpuM9ls8IDFqk
         7aBKlk/k1J3sZ/Z2njF079myynM1O0wpSgocC6Du9zCa2SFhxGqEVeSITwVtNup+uOyA
         pOoIvE7Wi/G46P7RAbqhEKvAXXcN47YBzryBMxJ4oMkc80G7aHyVJuO4w7yTrxG+DP8L
         TZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BRbFsIWE8FRYYsLc9p3xKYutVaHyD9NwxFuE6OgGodc=;
        b=h66yAdHO4AeMVtV3djVEJ4JB5MWRXj3F4hCVNOEZug/pB+pWJ4GYZj43WGL1r2H8z/
         9Bbrwos7DyHxP5eUSyw0gM0KHfuOS6Uuux/QNYfTFJAHuvXOAffxZTcYKNq5+A1+ZKRM
         UlvByH9Nc3MjoiUa10BksIfDSS6bWc7WfooSKV7OfAA8C681YY0sTGXV1BVEReH5sMG1
         yldOODP2J/IN0sWeiyj5Y3/5sqoA+aTnG1v25vP/WFpCJ32Xxt5Fuuhs1dbsU4Na9jMn
         zSnAS3zVPbgSwcJH/Sd8bn6wk7erjvBm55Er7wLs3W6Rf6kf1NMjs4EtmNgclTgCSYfw
         G4fQ==
X-Gm-Message-State: AOAM530wPhhaDu2kc6sTVHWMUVMK7qK37Ki+KDXPymqRdmSM1H5Lo8ox
        4xbowNB9C+PmbdT5nNcNzdQIA+/gNZ4=
X-Google-Smtp-Source: ABdhPJwls6duV6T5Vb4Q3IudVyP6+82Q3XMw9cu3y0T4SXZh0c6jOVMT8zHTW0JTGUcZgOAgV/3x9A==
X-Received: by 2002:adf:d1c1:: with SMTP id b1mr4526093wrd.204.1638586535806;
        Fri, 03 Dec 2021 18:55:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z15sm3892325wrr.65.2021.12.03.18.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 18:55:35 -0800 (PST)
Message-Id: <pull.1092.git.1638586534.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 04 Dec 2021 02:55:32 +0000
Subject: [PATCH 0/2] Sparse Index: fix a checkout bug with deep sparse-checkout patterns
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, vdye@github.com, gitster@pobox.com,
        newren@gmail.com, Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This week, we rolled out the sparse index to a large internal monorepo. We
got two very similar bug reports that dealt with a strange error that
involved the same set of paths. One was during git pull (pull was a red
herring) and the other was git checkout. The git checkout case gave enough
of a reproduction to debug deep into unpack-trees.c and find the problem.

This bug dates back to 523506d (unpack-trees: unpack sparse directory
entries, 2021-07-14). The reason we didn't hit this before is because it
requires the following:

 1. The sparse-checkout definition needs to have recursive inclusion of deep
    folders (depth 3 or more).
 2. Adjacent to those deep folders, we need a deep sparse directory entry
    that receives changes.
 3. In this particular repo, deep directories are only added to the
    sparse-checkout in rare occasions and those adjacent folders are rarely
    updated. They happened to update this week and hit our sparse index
    dogfooders in surprising ways.

The first patch adds a test that fails without the fix. It requires
modifying our test data to make adjacent, deep sparse directory entries
possible. It's a rather simple test after we have that data change.

The second patch includes the actual fix. It's really just an error of not
understanding the difference between the name and traverse_path members of
the struct traverse_info structure. name only stores a single tree entry
while traverse_path actually includes the full name from root. The method we
are editing also has an additional struct name_entry that fills in the tree
entry on top of the traverse_path, which explains how this worked to depth
two, but not depth three.

Thanks, -Stolee

Derrick Stolee (2):
  t1092: add deeper changes during a checkout
  unpack-trees: use traverse_path instead of name

 t/t1092-sparse-checkout-compatibility.sh | 16 +++++++++++++++-
 unpack-trees.c                           | 10 +++++-----
 2 files changed, 20 insertions(+), 6 deletions(-)


base-commit: cd3e606211bb1cf8bc57f7d76bab98cc17a150bc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1092%2Fderrickstolee%2Fsparse-index%2Fcheckout-bug-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1092/derrickstolee/sparse-index/checkout-bug-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1092
-- 
gitgitgadget
