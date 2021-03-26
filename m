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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5517C433C1
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 19:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB947619F9
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 19:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhCZTMZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 15:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbhCZTML (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 15:12:11 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E8AC0613AA
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 12:12:11 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id c8so6633175wrq.11
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 12:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=QXuOP+E86BIzaASqq4IxZaRkMoCLNcPu3ISSr/yHfYY=;
        b=b3x3z7Nw103zBw48j4OpbUStjSj/uvjPJvJ/nODdTEVYLUDAirpTZtj+AQAYtprZCV
         fTQGvxXtWJjYCnw84vdV+NTgSfuW6PRFGXX1NiU+tu0R8DN0r+a6/0N/k8i+nmvb7xxw
         yT2qTJkaA48x+aJc77orwjlZOckCP8MyiHEizePkDxWb+NBQ0GM0AY7wSawNUT9fUTiT
         N4Fk5m5iclCBp5rGCUuJOTcm1YCkzmuMiXXaogphx2UXP4F1/9QSurzXnTyKESMYJJae
         /fEbCrCxoRxumA42vRxOCSM4KmEecRgublSYMlL+wqh1aUsCUf/gTAUZ4WObm3ae0C8g
         1GVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QXuOP+E86BIzaASqq4IxZaRkMoCLNcPu3ISSr/yHfYY=;
        b=LzJNWu4pq/MAdsqxQz6V1Pf++0P0GijVYWYVMo1iFlC3C9N0nl0SnMWaPW3SqX/oDK
         kcG0b6/QJbw45yksNMVorZJWJcVONiuJzfj69immGpK9QL3pAzeFvPlFPzZZ4YLCmE97
         aFZB//JiqQdhEebnM85rXbTm1MJVMLuhYC+9iEcOvnO2aseNNv1UOCK/i2dmAH9X5GNI
         HV0gHEsrbXJvvMYYzWRZEnGGs8MFxP17Lrud50WAyI2ICDKujQx7aLDA5JS51iqWorNO
         7Lhdzod8rh6IN8JI3SrI6+Ao6s0fFopOeT1hKxUOeJ2w3Hq87FznV/5HRzUL8P8fDZLK
         bW+g==
X-Gm-Message-State: AOAM533f4hBIvNq2d1aex/UuYRV3zd7xHmVPNXRUeKt0ZWBYx1WiodcL
        VycrLjgPOVTRM4hD024UGHpQbnjOwpM=
X-Google-Smtp-Source: ABdhPJz56Ik1XthgaZl9KGaYPhLxedLrlzDAwuvju2r/5nUS4gUqx+D8vwzSBJHYw5KC3jdAYl3Psg==
X-Received: by 2002:a5d:664e:: with SMTP id f14mr16679124wrw.382.1616785929880;
        Fri, 26 Mar 2021 12:12:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u2sm16386110wmm.5.2021.03.26.12.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 12:12:09 -0700 (PDT)
Message-Id: <pull.916.git.1616785928.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 Mar 2021 19:12:04 +0000
Subject: [PATCH 0/3] Convert index writes to use hashfile API
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, stolee@gmail.com,
        git@jeffhostetler.com, Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As I prepare some ideas on index v5, one thing that strikes me as an
interesting direction to try is to use the chunk-format API. This would make
our extension model extremely simple (they become optional chunks, easily
identified by the table of contents).

But there is a huge hurdle to even starting that investigation: the index
uses its own hashing methods, separate from the hashfile API in csum-file.c!

The internals of the algorithms are mostly identical. The only possible
change is that the buffer sizes are different: 8KB for hashfile and 128KB in
read-cache.c. I was unable to find a performance difference in these two
implementations, despite testing on several repo sizes.

There is a subtle point about how the EOIE extension works in that it needs
a hash of just the previous extension data. This is solved by adding a new
"nested hashfile" mechanism that computes the hash at one level and then
passes the data below to another hashfile. (The good news is that this
extension will not need to exist at all if we use the chunk-format API to
manage extensions.)

Thanks, -Stolee

Derrick Stolee (3):
  csum-file: add nested_hashfile()
  read-cache: use hashfile instead of git_hash_ctx
  read-cache: delete unused hashing methods

 csum-file.c  |  22 +++++++
 csum-file.h  |   9 +++
 read-cache.c | 182 ++++++++++++++++-----------------------------------
 3 files changed, 89 insertions(+), 124 deletions(-)


base-commit: 142430338477d9d1bb25be66267225fb58498d92
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-916%2Fderrickstolee%2Findex-hashfile-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-916/derrickstolee/index-hashfile-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/916
-- 
gitgitgadget
