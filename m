Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A427C2D0A3
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 20:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2155620657
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 20:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZNUUHEp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgKBUvw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 15:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgKBUnu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 15:43:50 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859BDC0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 12:43:50 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id k3so2040406otp.12
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 12:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/yqyKYTKqHP/rETrVtLz4EZ37hoJzs/dcuPP7BiLhRA=;
        b=ZZNUUHEp6qCYhEWqHDI6udQiUj3AenmHp2AAFLOH+z4INwBBO4HzrTBjBixEO/cdDp
         w53XPkltu1kZ2jK+XaiyM3jMm2C7utENGrZY0zgk7+kjlnh+rSMV08fpD3Lc2OzkP3ta
         pG57oxAjyR0cGT7mPU9D9raxGc7bGuJ17iXjWj/OTFYTNdt9ctdEU3Knh1D2ZlkVzPE6
         7Xg/zEZAMo3m8vXcrPAN9VQJsaaUsTHsi1vWYuQERjECxZfxVr5PV8foNdDp1WQe+CdE
         X15L11X7RKbkGLCJe+kJAJ1VhpAS8DhzwwVyLcRN8xzJBhwzeyXKAKb1y+ttgtVeFJhY
         yrMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/yqyKYTKqHP/rETrVtLz4EZ37hoJzs/dcuPP7BiLhRA=;
        b=TLNwNCbBxQc0SzozG8t9Hg7KG6vPVNbvefCjO5UfaP43dn44gnXicUii8+wvPJBLgu
         5GLz6Pojisa3qMspFknZQTmGVFF0sdObwcIGNafMFoqPn/t0fkje65WaTOlLnSz/UsTG
         2yaFkJGETarpCCmFz0oy1oA5L/FMJsywPqV1pQ6PC0eCw5Tfakkdwz5iVKvMoPrxCqTX
         W4ZRLEicQm1TgV8o6VQd3pxwJ/zkcFq+jR1Q+6ELSDXnFtYU+Vh5MQUGDLd32A+7uTpW
         Ls4v7mkFVBfBz5/DkD/SU81YqV3YtFqVCddlsajalc5Ee8O/OEhZq7vE1dzJ8O9AMs4J
         uScA==
X-Gm-Message-State: AOAM532jOmFiiIjNRdDnBjsCiIutafhDZFPuXChLE4aZO4n5njfTiJde
        hObRUU6XGbxPT/saymIKUowqZMK6XQ3MNQ==
X-Google-Smtp-Source: ABdhPJwwWeV+CbvZCETP7nJmmyia97PY0D0TZis6rqL1IKWZGbdALWizDqbWnppi/Sk91mGfi6CkPw==
X-Received: by 2002:a05:6830:615:: with SMTP id w21mr5512395oti.126.1604349829667;
        Mon, 02 Nov 2020 12:43:49 -0800 (PST)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id t27sm3848512otc.14.2020.11.02.12.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 12:43:49 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 00/20] fundamentals of merge-ort implementation
Date:   Mon,  2 Nov 2020 12:43:24 -0800
Message-Id: <20201102204344.342633-1-newren@gmail.com>
X-Mailer: git-send-email 2.29.0.471.ga4f56089c0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series depends on a merge of en/strmap (after updating to v3) and
en/merge-ort-api-null-impl.

As promised, here's the update of the series due to the strmap
updates...and two other tiny updates.

Changes since v1:
  * updates needed based on changes to made in v3 of strmap series
  * fixed a typo in a comment
  * tiny tweak to move a strmap_put() into setup_paths()

Elijah Newren (20):
  merge-ort: setup basic internal data structures
  merge-ort: add some high-level algorithm structure
  merge-ort: port merge_start() from merge-recursive
  merge-ort: use histogram diff
  merge-ort: add an err() function similar to one from merge-recursive
  merge-ort: implement a very basic collect_merge_info()
  merge-ort: avoid repeating fill_tree_descriptor() on the same tree
  merge-ort: compute a few more useful fields for collect_merge_info
  merge-ort: record stage and auxiliary info for every path
  merge-ort: avoid recursing into identical trees
  merge-ort: add a preliminary simple process_entries() implementation
  merge-ort: have process_entries operate in a defined order
  merge-ort: step 1 of tree writing -- record basenames, modes, and oids
  merge-ort: step 2 of tree writing -- function to create tree object
  merge-ort: step 3 of tree writing -- handling subdirectories as we go
  merge-ort: basic outline for merge_switch_to_result()
  merge-ort: add implementation of checkout()
  tree: enable cmp_cache_name_compare() to be used elsewhere
  merge-ort: add implementation of record_unmerged_index_entries()
  merge-ort: free data structures in merge_finalize()

 merge-ort.c | 929 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 tree.c      |   2 +-
 tree.h      |   2 +
 3 files changed, 929 insertions(+), 4 deletions(-)

-- 
2.29.0.471.ga4f56089c0

