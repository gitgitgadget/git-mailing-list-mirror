Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6CBC63777
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 16:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DDAD206D5
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 16:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IN3qRvnM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390325AbgKXQoh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 11:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389515AbgKXQoh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 11:44:37 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E6EC0613D6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 08:44:36 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id o9so29478653ejg.1
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 08:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9LnuAGdHWlijauq33YdJQ6DnzPL000t64qMp0lua6wQ=;
        b=IN3qRvnMLwU8o/wrFUv+ZZoasiUjbOTmqCqiBTMDf4dPhiZLDDoRnWbmWjRmQS/vb9
         wWKi7Ht4AGNqSt4wsMcbXcJhbaaNwYNbi+KEGH3NETIWfEq0EnC1ZWVtDmdDi6SqrK8C
         p8GV2uTwP0BTb9OY61dgEpvN9VNOocoUlPODJcDHebGZOMSiuUVcVa5fHlS3cNR0gVCn
         i5UDQg+0ClAjczE9z3xtm0xLk80kg5g63xnmq/4gU89rUm60LI28xc3dEb36IIQ33hV9
         FVF8E4ieNszJPsnyN143sj6feLch7SiEISaiTGWNIVOxpDs5CWPOXI/YWiDsFSZoSueK
         jfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9LnuAGdHWlijauq33YdJQ6DnzPL000t64qMp0lua6wQ=;
        b=ovLgizgNj11719eSbbU0BxqDPSUfvwQYE8aKZb4D+jhomDNFs8VCknRj8BPP1a8WYf
         t5e+5oGz+BYEljeiABUZl8guBjV9iuK5aAgCCY2RnMjbTD5NqQaVf4pfepB01SWZwnJW
         snafgCxRz2aIAzndLbdp0oTCpVX1QMl2uQG/stGfqrFNYVXWc7rr9OKwQ5n0JU94gFSy
         FSHPtfxF+TiCi7caryxSOzheCAUX1QwKbeIHwjaAOuYwT7bqre8BO/HNb9CEdq0QXIVQ
         1L6525CR192gIZ6Jn8t8K+0cP2pGWIcrJSjREtgR90AocBcouLrt1SQ1Bv8I7F39rjzJ
         oIOg==
X-Gm-Message-State: AOAM53014X0VQjdplTCJz91qzYv1zi5c2fRxfu0TVuW9kwzgQwZmxyJk
        b+wvjj4cC/uMyqyoYqINoLxPNbtmnjRqyw==
X-Google-Smtp-Source: ABdhPJyuOgySIxonTjVXz0KRsSc75lP5n3gOI1x0R/uBSYzXLs9qiMkwJk4MoRpxsEn9i9vOgwstDw==
X-Received: by 2002:a17:906:60d0:: with SMTP id f16mr5193699ejk.148.1606236275155;
        Tue, 24 Nov 2020 08:44:35 -0800 (PST)
Received: from contrib-buster.auto1.local ([79.140.115.35])
        by smtp.gmail.com with ESMTPSA id c8sm7347884edr.29.2020.11.24.08.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 08:44:34 -0800 (PST)
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [PATCH 0/1] maintenance: Fix a SEGFAULT when no repository when running git maintenance run/start
Date:   Tue, 24 Nov 2020 16:44:04 +0000
Message-Id: <20201124164405.29327-1-rafaeloliveira.cs@gmail.com>
X-Mailer: git-send-email 2.29.2.505.g04529851e5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In d7514f6ed5 (maintenance: take a lock on the objects directory, 2020-09-17) [1],
and 2fec604f8d (maintenance: add start/stop subcommands, 2020-09-11) [2] The
"git maintenance run" and "git maintenance start" was taught to hold a file-based
lock at the .git/maintenance.lock and .git/schedule.lock respectively because these
operations involves writing data into the .git/repository. 

The lock file path string is built using the the_repository->objects->odb->path,
in case the_repository->objects->odb is NULL when there is not repository available,
resulting in a SEGFAULT.

[1] https://lore.kernel.org/git/1a0a3eebb825ac3eabfdd86f82ed7ef6abb454c5.1600366313.git.gitgitgadget@gmail.com/
[2] https://lore.kernel.org/git/5194f6b1facbd14cc17eea0337c0cc397a2a51fc.1602782524.git.gitgitgadget@gmail.com/

In order to reproduce the error, one can execute maintenance "run" and/or
"start" subcommand with a non valid repository: 

    $ git -C /tmp maintenance start
    Segmentation fault

    $ git -C /tmp maintenance run
    Segmentation fault

The above test was executed from a git built from commit: faefdd61ec (Sixth batch, 2020-11-18):

For reference here's the output from GDB when debugging the "start" command

	Program received signal SIGSEGV, Segmentation fault.
	0x00005555555b9b4c in maintenance_run_tasks (opts=0x7fffffffded4) at builtin/gc.c:1268
	1268		char *lock_path = xstrfmt("%s/maintenance", r->objects->odb->path);

This patch serie adds a check on the maintenance_run_tasks() and update_background_schedule()
to check if the_repository->git_dir is set to validate if a git repository is available and
return error otherwise. The logic is borrowed from maintenance_unregister() that performs
the same validation with different error message.

A new test case is added into t/t7900-maintenance.sh to cover these cases. The test is based on
the assumption that the `/tmp` directory is available, readable and is not a git repository
which I hope is fine for the running the test is all platforms. 

This patch is based on faefdd61ec (Sixth batch, 2020-11-18) (master branch) as the both commits
that introduced the file-based lock are graduated to master already. Hope this also plays nice
with the integration branches maintenance-part-v[1,4]. 

Rafael Silva (1):
  maintenance: fix a SEGFAULT when no repository

 builtin/gc.c           | 14 ++++++++++++--
 t/t7900-maintenance.sh |  5 +++++
 2 files changed, 17 insertions(+), 2 deletions(-)

-- 
2.29.2.505.g04529851e5

