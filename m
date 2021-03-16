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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F55C433E9
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 15:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE50C650FB
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 15:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbhCPPxW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 11:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbhCPPwt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 11:52:49 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE724C06174A
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:52:48 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id p19so1444673wmq.1
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2+lbye5D96lhfpNssvIVr5DWRPUe+Uj9c/pg7GVqbtI=;
        b=VuPQpFmGP2kjqEUmvRIk/0CfJKegBQgEpQB2nS8QSzX0wdpErHq0e8oKUDr4JOFH4o
         xgkgbHOpMDJUkISEeg7EJl/rZAC9VLzvbus9YPijKOFc/xaM/HeeiNwJmEADlilfILEG
         clzsZSWT+hbow5YC97B1ZN1Pn98/S7cMOhEhPcImcniMIdOL/GADXbPlJVdwn1iSElXR
         zHZD6OQkSzLJI/jwSkW7j/hUhdYYnYmckHrviB+1kSssvjTEFfh/++ExeBoPkHa7VXwa
         r0UTr+zuf1oynFcp+M947Z2pWOhiGUmkOUdqFV7UA4VWLaKPF355NfatoZSnEH3r756m
         NDDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2+lbye5D96lhfpNssvIVr5DWRPUe+Uj9c/pg7GVqbtI=;
        b=hlWM3kxgC/y3cFo7fwqtszcllGgyo78mEmYbmTgidSdpaVe1W+bvv9JvQFJEnincPu
         fVmxjXLFc0U37etPMnQlpekuT6J+QE870BQDJ+EsltqFg/QdrM54oisjJqh6HFR0T0dG
         wPdBvIXNlzM+S/4Jik+Kk2p95+08coCzo6mQi6C2VtYATLc64vb1C4hifX1syBcmdYnm
         jMnxd80q77hqO2zTbADQTDI0DPEBxPyJ7CR+BPZSOEkyY18N0o4IuYrtBX1bppj8s//A
         WL1Rza+RWniAXHJ37hVVnC2+GGSZL/xOzbMzoSu20FJ26wKjCZybxl4EnX/nkCikVyqL
         0rGQ==
X-Gm-Message-State: AOAM530abeQFDKBZSJRkydCIUhDHXnfrg/+w1M3tCk1ILYhZLfcYRr/V
        6wXy5VqrmqwP2FO6NQ2AW/4WGEFS5dt1rA==
X-Google-Smtp-Source: ABdhPJwIQRNMubRTjiq3b7ebBGDB3RtlrWIR8VXU7svq8ONElSD/zx8fWFm/aoC5xO16Nlb9fEct0w==
X-Received: by 2002:a1c:448a:: with SMTP id r132mr260218wma.157.1615909967371;
        Tue, 16 Mar 2021 08:52:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i11sm22224228wro.53.2021.03.16.08.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 08:52:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 0/9] read_tree() and read_tree_recursive() refactoring
Date:   Tue, 16 Mar 2021 16:52:35 +0100
Message-Id: <20210316155244.28328-1-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.256.gf0ddda3145
In-Reply-To: <20210315234344.28427-1-avarab@gmail.com>
References: <20210315234344.28427-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The only changes since v3[1] is a fix for a small test nit by
Elijah[2].

1. https://lore.kernel.org/git/20210315234344.28427-1-avarab@gmail.com/
2. https://lore.kernel.org/git/CABPp-BHWDffkqXsisp9E-FJPR4PmByPWuxWkAir24WpqUu43Lg@mail.gmail.com/

Ævar Arnfjörð Bjarmason (9):
  ls-files tests: add meaningful --with-tree tests
  tree.c API: move read_tree() into builtin/ls-files.c
  ls-files: don't needlessly pass around stage variable
  ls-files: refactor away read_tree()
  tree.h API: remove support for starting at prefix != ""
  tree.h API: remove "stage" parameter from read_tree_recursive()
  tree.h API: rename read_tree_recursive() to read_tree()
  show tests: add test for "git show <tree>"
  tree.h API: expose read_tree_1() as read_tree_at()

 archive.c                     |  19 +++---
 builtin/checkout.c            |   8 +--
 builtin/log.c                 |   8 +--
 builtin/ls-files.c            |  76 +++++++++++++++++++++-
 builtin/ls-tree.c             |   6 +-
 cache.h                       |   2 +-
 merge-recursive.c             |   6 +-
 t/t3060-ls-files-with-tree.sh |  41 ++++++++++++
 t/t7007-show.sh               |  39 ++++++++++++
 tree.c                        | 117 ++++------------------------------
 tree.h                        |  24 +++----
 11 files changed, 205 insertions(+), 141 deletions(-)

Range-diff:
 -:  ---------- >  1:  b338f2c01a ls-files tests: add meaningful --with-tree tests
 -:  ---------- >  2:  4578b83944 tree.c API: move read_tree() into builtin/ls-files.c
 -:  ---------- >  3:  33656ff63b ls-files: don't needlessly pass around stage variable
 -:  ---------- >  4:  1c96d5d361 ls-files: refactor away read_tree()
 -:  ---------- >  5:  367cb99224 tree.h API: remove support for starting at prefix != ""
 -:  ---------- >  6:  38e36780e2 tree.h API: remove "stage" parameter from read_tree_recursive()
 -:  ---------- >  7:  859902ffd8 tree.h API: rename read_tree_recursive() to read_tree()
 1:  a63c9b49f1 !  8:  8a6bebde23 show tests: add test for "git show <tree>"
    @@ t/t7007-show.sh: test_expect_success 'showing two commits' '
     +
     +test_expect_success 'showing two trees' '
     +	cat >expected <<-EOF &&
    -+	tree main1:
    ++	tree main1^{tree}
     +
     +	main1.t
     +
    -+	tree main2:
    ++	tree main2^{tree}
     +
     +	main1.t
     +	main2.t
     +	EOF
    -+	git show main1: main2: >actual &&
    ++	git show main1^{tree} main2^{tree} >actual &&
     +	test_cmp expected actual
     +'
     +
    @@ t/t7007-show.sh: test_expect_success 'showing two commits' '
     +	mkdir not-recursive/a &&
     +	test_commit -C not-recursive a/file &&
     +	cat >expected <<-EOF &&
    -+	tree a/file:
    ++	tree HEAD^{tree}
     +
     +	a/
     +	main1.t
     +	EOF
    -+	git -C not-recursive show a/file: >actual &&
    ++	git -C not-recursive show HEAD^{tree} >actual &&
     +	test_cmp expected actual
     +'
     +
 2:  570642c862 =  9:  29996dd82b tree.h API: expose read_tree_1() as read_tree_at()
-- 
2.31.0.256.gf0ddda3145

