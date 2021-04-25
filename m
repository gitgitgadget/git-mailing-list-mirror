Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DBCC433B4
	for <git@archiver.kernel.org>; Sun, 25 Apr 2021 14:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E98C960232
	for <git@archiver.kernel.org>; Sun, 25 Apr 2021 14:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbhDYORH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Apr 2021 10:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbhDYORF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Apr 2021 10:17:05 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B44C061756
        for <git@vger.kernel.org>; Sun, 25 Apr 2021 07:16:25 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id f15-20020a05600c4e8fb029013f5599b8a9so1681588wmq.1
        for <git@vger.kernel.org>; Sun, 25 Apr 2021 07:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=y5a3mcCcFnlbBQlIZ6kqrlD9aVEgZBkUVW53CuJkvac=;
        b=G3TKTqYYnzTRtBHOpPceQnWDjiGi5Kt880495gGr0vyoE3JhJZLaHlxxnvfzn6Ep7G
         TIZi+H5gciNW8lBOdII8rFU4Zq68qAC7YMG0/jTxZ11je1C7XEQMYduSioIwXRav1h9a
         QFDe/DzUADVY6EChTAxwcp811qF2oGJqRSTaxZJOp+gKHWlQvnW2kJ5exWSVtRVF2z3a
         +i5sIe0yf21ImeH2Wo3PYWPPwSEJgM7S3pcnJCH4HLJmUhqvyHnSBtTL8F2Aqpq9HE0A
         aft8/NVovoW3lyUZ7zax9/p6mtNJMjAK3/SH8MqahPzjFtenjDBEqXGO/qprhcYyv7mG
         XT/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=y5a3mcCcFnlbBQlIZ6kqrlD9aVEgZBkUVW53CuJkvac=;
        b=EZHb+GNBpiLiRRxI5P0cbDgs1zf0M1YwMCEf1u20ubSuPViv1lCH/lITPpiQcK76Ki
         5xnNxDXcWoeH3YTN+/Vj0KRuGWn28C8sFd1QoEQPvAPOBMNsHPjPEj+Q051mEtWQCisy
         DVBIyYI8mWd7mY9tBDgzH73GEXhU2j6P66GwTt8CQRUBPIm8cEuIvIXzy9NZqnOVeiQu
         CW3KIQnAZ/qAM+dTtHXHM77AixaJ2jeWmzxA/D93+lZWcOmtVle7wsbM42uP6BXRihi3
         rjpTz6NqcAzW1JILeQiAgvmd/tSgeAxiNkCDYzksFVm3+5ZLc0D5sPDzCZwPv5s2eULF
         ZXEg==
X-Gm-Message-State: AOAM530lq2uP3vHZTP7KadgGcpFREo0aTIRFXdiwuYuRUpkONvb+iYYl
        7jCql3qNgozAcJ2hHNUVLyGer2bRTpw=
X-Google-Smtp-Source: ABdhPJx1Iq0ODXp8qgDcMGjTUdAnI6VS7vYiZ4gAShs75jPgIUqknPCCxYaVZ3n9Pe2974XJoYkeWA==
X-Received: by 2002:a1c:7516:: with SMTP id o22mr15876291wmc.91.1619360184011;
        Sun, 25 Apr 2021 07:16:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a2sm15371767wmn.48.2021.04.25.07.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Apr 2021 07:16:23 -0700 (PDT)
Message-Id: <fb64a3dcd0b077b1b818a285ada066a135f911a6.1619360180.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.929.v2.git.1619360180.gitgitgadget@gmail.com>
References: <pull.929.git.1617994052.gitgitgadget@gmail.com>
        <pull.929.v2.git.1619360180.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 25 Apr 2021 14:16:11 +0000
Subject: [PATCH v2 04/12] bloom: clear each bloom_key after use
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrzej Hunt <ajrhunt@google.com>

fill_bloom_key() allocates memory into bloom_key, we need to clean that
up once the key is no longer needed.

This leak was found while running t0002-t0099. Although this leak is
happening in code being called from a test-helper, the same code is also
used in various locations around git, and can therefore happen during
normal usage too. Gabor's analysis shows that peak-memory usage during
'git commit-graph write' is reduced on the order of 10% for a selection
of larger repos (along with an even larger reduction if we override
modified path bloom filter limits):
https://lore.kernel.org/git/20210411072651.GF2947267@szeder.dev/

LSAN output:

Direct leak of 308 byte(s) in 11 object(s) allocated from:
    #0 0x49a5e2 in calloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:154:3
    #1 0x6f4032 in xcalloc wrapper.c:140:8
    #2 0x4f2905 in fill_bloom_key bloom.c:137:28
    #3 0x4f34c1 in get_or_compute_bloom_filter bloom.c:284:4
    #4 0x4cb484 in get_bloom_filter_for_commit t/helper/test-bloom.c:43:11
    #5 0x4cb072 in cmd__bloom t/helper/test-bloom.c:97:3
    #6 0x4ca7ef in cmd_main t/helper/test-tool.c:121:11
    #7 0x4caace in main common-main.c:52:11
    #8 0x7f798af95349 in __libc_start_main (/lib64/libc.so.6+0x24349)

SUMMARY: AddressSanitizer: 308 byte(s) leaked in 11 allocation(s).

Signed-off-by: Andrzej Hunt <ajrhunt@google.com>
---
 bloom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bloom.c b/bloom.c
index 52b87474c6eb..5e297038bb1f 100644
--- a/bloom.c
+++ b/bloom.c
@@ -283,6 +283,7 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 			struct bloom_key key;
 			fill_bloom_key(e->path, strlen(e->path), &key, settings);
 			add_key_to_filter(&key, filter, settings);
+			clear_bloom_key(&key);
 		}
 
 	cleanup:
-- 
gitgitgadget

