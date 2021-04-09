Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710DDC43461
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4928C6115B
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234592AbhDISrx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 14:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234313AbhDISrv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 14:47:51 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6B3C061764
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 11:47:36 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id d11so2670156wro.13
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 11:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ONyYZPlflv7LE+CjKCTTmkOSEuiP/OegeOE/527FNBQ=;
        b=E2uzHVTPXSzUB9vST0YfAkcdZMc9O0jwrt8EqdoFoE5WfQVilTjyzXqRDPoSizFUzP
         hiwXeBA7fHPbwqgvoS+Qs3CnQbO8i+LV9LXZBWVGxV3Y7YZVbw6/47VEGFqCZK+K21+/
         q+sG9a011qmnTLxqIKkG4zAYnc9IaaDPdw6AVXgJFe1agKdC12UY0nBqhQG3C+fBcu5M
         P37eo+8a/Z9HWkKpZ8b/E7/KhLmJ1cymI8suTFKFoiTibUwCLakkys/6NQC6s/G6N0Ma
         MMqoHtD1zpAv/hGCqpEhVmXn2rHrwHQ2bRslu/RgwEogBa4JRNPf0dbkEon2OEfvRzlx
         wbXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ONyYZPlflv7LE+CjKCTTmkOSEuiP/OegeOE/527FNBQ=;
        b=fH5HYVyBSBf7RAvmQ1be8UdTUe2E6xsRHT5ZH78vsheFUAlMPUErt2UPvB9hVoGBD7
         DX91gdvSfq/2Xal7L/ArZRooqn3yCY3MXEsJk3FaaHCf5Gt957m4Hd9otPkT7meWLY+h
         KtTBY4J3TG96CEZ1cdJppc3xJ5yniJio4WiPQ/c1azPwZ3m+lkjhUtXIUQqvQMSJ5CmL
         VtPAR1i7ggZiBQ8Zc1ogwQbjJUrIjpN16p4yqqhldkRxtraPecz6afoqdXksw76fEVhO
         ql9YitZazMxoV7zwwu2WQ13lSIc7pjb4NhdEfQFEGlXqebs0IhrxBuGr9nrwpPurrbhJ
         29xg==
X-Gm-Message-State: AOAM533ShpVOYV4De0nXlex3Y0BcxMMnpZukvvVod7A8lOuu+bILev9m
        k8Nzz16bjaCLwZtLn1iEk4Gqwb4Daxk=
X-Google-Smtp-Source: ABdhPJyc4tN/a7deeo6CVX4sE6r+hQLvD/Y/sJ5moH5XBW1g8jBVdcNVvq/xYv4HpJ5/pmMp4gkk8A==
X-Received: by 2002:adf:f584:: with SMTP id f4mr19377225wro.260.1617994055472;
        Fri, 09 Apr 2021 11:47:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k16sm6014733wro.11.2021.04.09.11.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:47:35 -0700 (PDT)
Message-Id: <beccdb1778697a2a46b81c85fc91c477c040397c.1617994052.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.929.git.1617994052.gitgitgadget@gmail.com>
References: <pull.929.git.1617994052.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 09 Apr 2021 18:47:22 +0000
Subject: [PATCH 03/12] ls-files: free max_prefix when done
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Andrzej Hunt <andrzej@ahunt.org>, Andrzej Hunt <ajrhunt@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrzej Hunt <ajrhunt@google.com>

common_prefix() returns a new string, which we store in max_prefix -
this string needs to be freed to avoid a leak. This leak is happening
in cmd_ls_files, hence is of no real consequence - an UNLEAK would be
just as good, but we might as well free the string properly.

Leak found while running t0002, see output below:

Direct leak of 8 byte(s) in 1 object(s) allocated from:
    #0 0x49a85d in malloc /home/abuild/rpmbuild/BUILD/llvm-11.0.0.src/build/../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:145:3
    #1 0x9ab1b4 in do_xmalloc wrapper.c:41:8
    #2 0x9ab248 in do_xmallocz wrapper.c:75:8
    #3 0x9ab22a in xmallocz wrapper.c:83:9
    #4 0x9ab2d7 in xmemdupz wrapper.c:99:16
    #5 0x78d6a4 in common_prefix dir.c:191:15
    #6 0x5aca48 in cmd_ls_files builtin/ls-files.c:669:16
    #7 0x4cd92d in run_builtin git.c:453:11
    #8 0x4cb5fa in handle_builtin git.c:704:3
    #9 0x4ccf57 in run_argv git.c:771:4
    #10 0x4caf49 in cmd_main git.c:902:19
    #11 0x69ce2e in main common-main.c:52:11
    #12 0x7f64d4d94349 in __libc_start_main (/lib64/libc.so.6+0x24349)

Signed-off-by: Andrzej Hunt <ajrhunt@google.com>
---
 builtin/ls-files.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 60a2913a01e9..53e20bbf9cce 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -781,5 +781,6 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	}
 
 	dir_clear(&dir);
+	free((void *)max_prefix);
 	return 0;
 }
-- 
gitgitgadget

