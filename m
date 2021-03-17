Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D554C4332B
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 13:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD4E264F30
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 13:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbhCQN2z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 09:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbhCQN2m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 09:28:42 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589A1C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 06:28:33 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id b9so1819984wrt.8
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 06:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K0BsB/MTQKmThdNTWgeIroFWqGYP7VzUtguCL0T1fOs=;
        b=DM5xMDtZ5RlC3zf2PVU0340KFG0RSjlI8AEvgjYCoAa5ZfB5m2NvN9FhC7DKyut12l
         TJI/wlJvm30Gt2cku3sQfMQm8zVI0MNmcroqH0zXoCMj+SD5tlRV/dJSEnyY++cV6J4f
         T1Yj65lxLCJ1hVYaa/QLVfTttkhQclCt82Dki3UOVjPG8Ju5amJDMM+XKpRnpj4Nv3qt
         uNs19P7Ux3CsToNr8a2DoyfQN28d5CECjWLn1Odd3wqzvt2t0ZMF700AeuRjzMNrkN3O
         ix4zAqKG0XQQW1wniyB6hjZeFarB6dRrGllJoFqCfceI8JXUCTHe30m1iVRPr1xdNuOK
         Tqdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K0BsB/MTQKmThdNTWgeIroFWqGYP7VzUtguCL0T1fOs=;
        b=R2KxmkChUlN58RmCYRrLkW4dxyaqp9p8uEvBnnxA2/gsimorSi7CBhPorRV9XwumqU
         C5B0JmKEBVp+m6vYMLiPu1F6pN/B55hWzb/JcNUao0hkiC3xhYHiRkausLH8XXHsIem/
         OlBb5HFW5wvPaDn5wGPwS5rZwwVAL5TAvxTzj6Q0V9EhVlByiolPShKf9mYZW+7Rhj2L
         PHEMitaVIrUZKStX+feB49EjApg5zFlhAeSO8esWMp+rTZsNH2b5XZ53aGjnl/4+YPI0
         1/clSMZQfXN6wSP8Ek/R9Ccw3N7AGhil1cvdQPKrG2mHKygCbXlCINU9TVVXGhx9N0Vy
         /r2A==
X-Gm-Message-State: AOAM531oH+I72ZxbHs9eG+D5tw1dARoaj1nWcFIfFQZfIWziLNBtG2mQ
        DUkEj6Ywj5sNVmvlOhZQhUdWhjn59RMhSg==
X-Google-Smtp-Source: ABdhPJxltXYNv+FQf1lYemKgWE1BF1tdRqnea6asnaJzcysFjXDsGZOKBifBqaYwOzcjvjAr81lcog==
X-Received: by 2002:adf:dfc9:: with SMTP id q9mr3055970wrn.200.1615987711482;
        Wed, 17 Mar 2021 06:28:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z7sm26061448wrt.70.2021.03.17.06.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 06:28:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, pclouds@gmail.com,
        jrnieder@gmail.com,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        dstolee@microsoft.com
Subject: [RFC/PATCH 0/5] Re: [PATCH v3 07/20] test-read-cache: print cache entries with --table
Date:   Wed, 17 Mar 2021 14:28:09 +0100
Message-Id: <20210317132814.30175-1-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.260.g719c683c1d
In-Reply-To: <dffe8821fde290a1e19b2968098b007b9ac213e6.1615912983.git.gitgitgadget@gmail.com>
References: <dffe8821fde290a1e19b2968098b007b9ac213e6.1615912983.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: Derrick Stolee <dstolee@microsoft.com>
>
> This table is helpful for discovering data in the index to ensure it is
> being written correctly, especially as we build and test the
> sparse-index. This table includes an output format similar to 'git
> ls-tree', but should not be compared to that directly. The biggest
> reasons are that 'git ls-tree' includes a tree entry for every
> subdirectory, even those that would not appear as a sparse directory in
> a sparse-index. Further, 'git ls-tree' does not use a trailing directory
> separator for its tree rows.
>
> This does not print the stat() information for the blobs. That could be
> added in a future change with another option. The tests that are added
> in the next few changes care only about the object types and IDs.
>
> To make the option parsing slightly more robust, wrap the string
> comparisons in a loop adapted from test-dir-iterator.c.
>
> Care must be taken with the final check for the 'cnt' variable. We
> continue the expectation that the numerical value is the final argument.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/helper/test-read-cache.c | 55 +++++++++++++++++++++++++++++++-------
>  1 file changed, 45 insertions(+), 10 deletions(-)
>
> diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
> index 244977a29bdf..6cfd8f2de71c 100644
> --- a/t/helper/test-read-cache.c
> +++ b/t/helper/test-read-cache.c
> @@ -1,36 +1,71 @@
>  #include "test-tool.h"
>  #include "cache.h"
>  #include "config.h"
> +#include "blob.h"
> +#include "commit.h"
> +#include "tree.h"
> +
> +static void print_cache_entry(struct cache_entry *ce)
> +{
> +	const char *type;
> +	printf("%06o ", ce->ce_mode & 0177777);
> +
> +	if (S_ISSPARSEDIR(ce->ce_mode))
> +		type = tree_type;
> +	else if (S_ISGITLINK(ce->ce_mode))
> +		type = commit_type;
> +	else
> +		type = blob_type;
> +
> +	printf("%s %s\t%s\n",
> +	       type,
> +	       oid_to_hex(&ce->oid),
> +	       ce->name);
> +}
> +

So we have a test tool that's mostly ls-files but mocks the output
ls-tree would emit, won't these tests eventually care about what stage
things are in?

What follows is an RFC series on top that's the result of me wondering
why if we're adding new index constructs we aren't updating our
plumbing to emit that data, can we just add this to ls-files and drop
this test helper?

Turns out: Yes we can.

Ævar Arnfjörð Bjarmason (5):
  ls-files: defer read_index() after parse_options() etc.
  ls-files: make "mode" in show_ce() loop a variable
  ls-files: add and use a new --sparse option
  test-tool read-cache: --table is redundant to ls-files
  test-tool: split up test-tool read-cache

 Documentation/git-ls-files.txt           |  4 ++
 Makefile                                 |  3 +-
 builtin/ls-files.c                       | 29 +++++++--
 t/helper/test-read-cache-again.c         | 31 +++++++++
 t/helper/test-read-cache-perf.c          | 21 ++++++
 t/helper/test-read-cache.c               | 82 ------------------------
 t/helper/test-tool.c                     |  3 +-
 t/helper/test-tool.h                     |  3 +-
 t/perf/p0002-read-cache.sh               |  2 +-
 t/t1091-sparse-checkout-builtin.sh       |  9 +--
 t/t1092-sparse-checkout-compatibility.sh | 57 ++++++++++------
 t/t7519-status-fsmonitor.sh              |  2 +-
 12 files changed, 131 insertions(+), 115 deletions(-)
 create mode 100644 t/helper/test-read-cache-again.c
 create mode 100644 t/helper/test-read-cache-perf.c
 delete mode 100644 t/helper/test-read-cache.c

-- 
2.31.0.260.g719c683c1d

