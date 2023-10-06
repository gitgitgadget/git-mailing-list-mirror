Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5954EE81E1E
	for <git@archiver.kernel.org>; Fri,  6 Oct 2023 18:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbjJFSJf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Oct 2023 14:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbjJFSJe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2023 14:09:34 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C21CBE
        for <git@vger.kernel.org>; Fri,  6 Oct 2023 11:09:32 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3231dff4343so1534799f8f.0
        for <git@vger.kernel.org>; Fri, 06 Oct 2023 11:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696615770; x=1697220570; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0ZfPfo89qgB3KyOeSy0gYI6P1XqmDFr7PXzKZNEAhEQ=;
        b=LPmB+9gXPVguzYLgSKmeJj9FX8Fn5C26gYYz4VBTWAThTeVDc2I7axQdnLCkW/ma0p
         AogG2DlV2m8Pe79ditzxCghNHjfJDZELBTKaYaj7SCsAyqZDXB/ADfa153Ht/1ikRFTI
         wfn8IkqUtpxPJ1+mZ2divNktKSH6sO0ky2TLP7TdXB5nih4L6PMoemebdjA0ckn2pbwU
         3TZ915wgFM9o8HbZakPhOscCn2Wb6mk1IIemAlVkdZCG7P4BzjCpWK/jyze3Kw2Au82S
         bVBd0Ivl1gxqJE/KL1o0UXZig69GkYuflPBkdvqFOGA/Qi9rUDNNdV8LYirecePFoLtG
         eoWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696615770; x=1697220570;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ZfPfo89qgB3KyOeSy0gYI6P1XqmDFr7PXzKZNEAhEQ=;
        b=mpNFWf2eAE+Igsp2WaZ7oPAogoiBImLYxErCS2Tm9+cWPAlrumXKh26OsIopkGildS
         lNujcSHaE53tCuNyPEmWCpGtfiUyxV1vplnsI1rqVaZ518GSE0pSz5k1RWvFaPXKEMSe
         g05mEtX+NfVdx+gsPZ/st7YK74UK86pZgnMPAt9qvUnTYoOlRsK7nFOcNCBRfCDzm9bb
         VX3d/yTLKDaNZqxFpKBNaqs6qC2ro7iS9BuUx3yFErGZ2UUGUkAt8cpdvJZzRGdEURia
         AN13gHi/gMPyb6AxewySlUy8gxm4+QFfpjsGY8IukPNXgQ4BdKJ5NnnwkXKPvewdH1DZ
         311A==
X-Gm-Message-State: AOJu0Yw8Ks7QMgKVUYq1ZKX3a3eXUVuj4ZHRgQTStMw+lmbctWUWnbIR
        oWKdNo5CG/wJnWd43AkYlxXqyR8hUiA=
X-Google-Smtp-Source: AGHT+IGTQqcU5qkLjZTrEuw51TtRJYgPxf9FzOVrWw4IdUvCdXq46TxCnqSR98zc99TW9qkvKmz9Wg==
X-Received: by 2002:adf:e48d:0:b0:31f:fa48:2056 with SMTP id i13-20020adfe48d000000b0031ffa482056mr5406130wrm.27.1696615770168;
        Fri, 06 Oct 2023 11:09:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g7-20020a5d5407000000b00327df8fcbd9sm2178973wrv.9.2023.10.06.11.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:09:29 -0700 (PDT)
Message-ID: <pull.1594.git.1696615769.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 06 Oct 2023 18:09:25 +0000
Subject: [PATCH 0/4] Performance improvement & cleanup in loose ref iteration
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While investigating ref iteration performance in builtins like
'for-each-ref' and 'show-ref', I found two small improvement opportunities.

The first patch tweaks the logic around prefix matching in
'cache_ref_iterator_advance' so that we correctly skip refs that do not
actually match a given prefix. The unnecessary iteration doesn't seem to be
causing any bugs in the ref iteration commands that I've tested, but it
doesn't hurt to be more precise (and it helps with some other patches I'm
working on ;) ).

The next three patches update how 'loose_fill_ref_dir' determines the type
of ref cache entry to create (directory or regular). On platforms that
include d_type information in 'struct dirent' (as far as I can tell, all
except NonStop & certain versions of Cygwin), this allows us to skip calling
'stat'. In ad-hoc testing, this improved performance of 'git for-each-ref'
by about 20%.

Thanks!

 * Victoria

Victoria Dye (4):
  ref-cache.c: fix prefix matching in ref iteration
  dir.[ch]: expose 'get_dtype'
  dir.[ch]: add 'follow_symlink' arg to 'get_dtype'
  files-backend.c: avoid stat in 'loose_fill_ref_dir'

 diagnose.c           | 42 +++---------------------------------------
 dir.c                | 33 +++++++++++++++++++++++++++++++++
 dir.h                | 16 ++++++++++++++++
 refs/files-backend.c | 14 +++++---------
 refs/ref-cache.c     |  3 ++-
 5 files changed, 59 insertions(+), 49 deletions(-)


base-commit: 3a06386e314565108ad56a9bdb8f7b80ac52fb69
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1594%2Fvdye%2Fvdye%2Fref-iteration-cleanup-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1594/vdye/vdye/ref-iteration-cleanup-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1594
-- 
gitgitgadget
