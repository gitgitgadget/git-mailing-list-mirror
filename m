Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A84D4C4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 05:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AB3023A57
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 05:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbgLRFwL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 00:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgLRFwL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 00:52:11 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7455CC0617A7
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 21:51:30 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id q18so832556wrn.1
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 21:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Q0T9dTBzYaoejxK9VZWwcQi2E3NS06Mc02LZSRNj79c=;
        b=nG+uRB0kBnotDkoxXH1L8wZRnk04GEO+DvTxPQ2vRZZr637naEcciFtBVFa8JOJ88L
         48cf77pdFWBrpwsy0mDD2rn9TYOiXZO4vGG937mopvLU8XZjsnkj8phRwMPBlY2rUMpB
         c8Ry6cpka79rMH7qP25zLLDcGCtDuHqTsJiiXPP7ryZU+wiOr+EgRGvw8lqrLOC9K2D4
         481wAF4xV5gCSuaRo7gnYcWjmKI6v6nVQhD9SDY5ORx25DjzXIRPsHjq09h9AlDhDoKh
         mST6RxkbHiqkhJmKruh/uuGaVBvqF+NUAEPXaYTX036GeUiSjZnlnRDUWsTbhLH9bHIl
         +YXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Q0T9dTBzYaoejxK9VZWwcQi2E3NS06Mc02LZSRNj79c=;
        b=qZFAHzqL7PUlJrL000E0HJ/yhbb3g2ECOzQOTaAZimWxvdNr3QdM18dCdWujW2WUWF
         gALaU5Nc8+ahFb35A5T10TCri86E7Sq0mVY9ugVE7L4UFPI+W4rrwAqaiH0ERZDH+xcy
         1czWoOGoLiji3ziRkteWY9HuPxjxG+ZPOC9ZGLRy/V7l6uA6J4iK1+waz4rFfYLV+9B7
         Nby9ASc0WTnWnHYvUrwNNAIN2EwqUV7bvclJLg4bSM8Pj56xxBECqN3sWZ7D4CejS+Gb
         HL6EURaJZ2RyI3JGYvskDU79kVt+DDDdxOZwVUbFZsW1w8MQKvrZneOxNN4ELjKHJ5mL
         dsbg==
X-Gm-Message-State: AOAM533tXWbkQKCmzbI98P9fWxwwjAWyVfwYlhVZw+2yIl/dbDzJE2tn
        lT+bdfQ1Lo0QAetfHpNuRcTt1AHbf98=
X-Google-Smtp-Source: ABdhPJzl8BS2HOiBhTVTIC4eu3A7peADOz3vJ5wwjjabqaWtSu6813iJgA/SNBCyWPcWUXoEHOiVng==
X-Received: by 2002:adf:fbd2:: with SMTP id d18mr2380225wrs.222.1608270689047;
        Thu, 17 Dec 2020 21:51:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b127sm7029709wmc.45.2020.12.17.21.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 21:51:28 -0800 (PST)
Message-Id: <pull.815.git.1608270687.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 18 Dec 2020 05:51:17 +0000
Subject: [PATCH 00/10] merge-ort: add more handling of basic conflict types
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series depends on en/merge-ort-2 (it does not depend on en/merge-ort-3
or en/merge-ort-recursive).

This series adds handling of additional basic conflict types (directory/file
conflicts, three-way content merging, very basic submodule divergence
reconciliation, and different filetypes). This series drops the number of
test failures under GIT_TEST_MERGE_ALGORITHM=ort by 211 (from 1448 to 1237).

Further, if en/merge-tests, en/merge-ort-3, en/merge-ort-recursive, and this
series are all merged down (in any order), then collectively they drop the
number of test failure under GIT_TEST_MERGE_ALGORITHM=ort from 1448 down to
60.

Elijah Newren (10):
  merge-ort: handle D/F conflict where directory disappears due to merge
  merge-ort: handle directory/file conflicts that remain
  merge-ort: implement unique_path() helper
  merge-ort: handle book-keeping around two- and three-way content merge
  merge-ort: flesh out implementation of handle_content_merge()
  merge-ort: copy and adapt merge_3way() from merge-recursive.c
  merge-ort: copy and adapt merge_submodule() from merge-recursive.c
  merge-ort: implement format_commit()
  merge-ort: copy find_first_merges() implementation from
    merge-recursive.c
  merge-ort: add handling for different types of files at same path

 merge-ort.c | 671 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 653 insertions(+), 18 deletions(-)


base-commit: c5a6f65527aa3b6f5d7cf25437a88d8727ab0646
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-815%2Fnewren%2Fort-conflict-handling-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-815/newren/ort-conflict-handling-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/815
-- 
gitgitgadget
