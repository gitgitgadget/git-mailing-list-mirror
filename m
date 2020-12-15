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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB10C4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 17:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1223622B2D
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 17:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731149AbgLORyr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 12:54:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbgLORyK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 12:54:10 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE7CC06179C
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 09:53:29 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id w5so17007594wrm.11
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 09:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=TFMSu/oqfHckzc8ycVrCxz8yn3r9KRTpZtLbUBGRZ3I=;
        b=Bf+pGH/jcuU+DClT+YqqFLQEkwhwmjsC1yuyhzftHLRarVWQcjSESFnT69sY3DD3E0
         7R6RfLUjJU87AFJjyDRqhNMc6Ixf3jyZG2Ej4wsazHM6r5OYYfNMNTANlnXS7f96hypE
         o3UQoYbqYGNXGJElImZQsg5izo22eMuqvQc+PPSjKJxXcXstJDzfyZuSatAl25qsLAFY
         zr1OQRBt9r9ykflc71/IGC/gX5hPTLqc07pTkZbFIMSv4VT7jDb47AZ5Y72D/gMomfzW
         IOQM4i8svV9iavsdcPvaks9my3PyN9zwIHzsNgfdELRFSGpQkKlbca65q9Ta1EDBfJ+b
         WgGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TFMSu/oqfHckzc8ycVrCxz8yn3r9KRTpZtLbUBGRZ3I=;
        b=AW2btK/XfyMxQ5ipb/jKFFaAy7JLBOvGzhZCT4DlpsFLmPsQaQwebkOgL9Z3nGGBWW
         uK3PoUi3Jwo8fkmwNiTZNe7ZRjoxaJfves27zHBp/+ZeGhE9kjlCxgZKa4ANHrGfBII5
         52uBzdOHH7CMTH+6sL65anrmXoxNL7hN4ZZ7j5B7O0yDnLc9CfrxpDQPgCmqepVnt3sh
         4BDf/nC23ZwZ6gash/PSmazF8aQW87ib81KQMBCYLKenUaKPni7piXpwcEhPxotY/1ZR
         nWtcbM9xnwjQ5eQi3IUQ3M5bRkqXFC05XJ6UMjppJrBgLxx5TdxNsY2oEWV5FyIAteeM
         xR7w==
X-Gm-Message-State: AOAM532C/DBM+V5uSlOrX3/KLirKtdQS+S3MAvaIrQ6XPmD7aIU5+0LX
        teyx1WJS835kZ93cby2wsJegun0LquY=
X-Google-Smtp-Source: ABdhPJwwvnIROXniZCuLAvrzWzZWgua7PaBwiFgOST/bc14Q7Iky92qurIxL/sRO2XQDFFWfeeqPNw==
X-Received: by 2002:adf:902d:: with SMTP id h42mr34348365wrh.175.1608054808489;
        Tue, 15 Dec 2020 09:53:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b14sm38394863wrx.77.2020.12.15.09.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 09:53:27 -0800 (PST)
Message-Id: <pull.814.git.1608054807.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Dec 2020 17:53:24 +0000
Subject: [PATCH 0/3] merge-ort: implement recursive merges
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series depends on en/merge-ort-2 (it does NOT depend on en/merge-ort-3
and can thus be reviewed/merged independently of it).

This short series adds handling of recursive merges (merging of multiple
merge-bases to create a virtual merge base) to merge-ort. With this short
series the number of test failures under GIT_TEST_MERGE_ALGORITHM=ort drops
by 801 (from 1448 to 647).

Elijah Newren (3):
  merge-ort: copy a few small helper functions from merge-recursive.c
  merge-ort: make clear_internal_opts() aware of partial clearing
  merge-ort: implement merge_incore_recursive()

 merge-ort.c | 133 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 126 insertions(+), 7 deletions(-)


base-commit: c5a6f65527aa3b6f5d7cf25437a88d8727ab0646
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-814%2Fnewren%2Fort-recursive-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-814/newren/ort-recursive-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/814
-- 
gitgitgadget
