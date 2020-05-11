Return-Path: <SRS0=tgTL=6Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C50C54E8D
	for <git@archiver.kernel.org>; Mon, 11 May 2020 11:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EAE1206F5
	for <git@archiver.kernel.org>; Mon, 11 May 2020 11:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhBR8vZJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbgEKL4b (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 07:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729868AbgEKL43 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 May 2020 07:56:29 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4E8C05BD0A
        for <git@vger.kernel.org>; Mon, 11 May 2020 04:56:28 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id y16so3407649wrs.3
        for <git@vger.kernel.org>; Mon, 11 May 2020 04:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=w5R3fvbChOogMJmaRFfwAONf/Hm4fSZS4S5dv4d04tk=;
        b=bhBR8vZJgdwsBFWl5JeOPRbO55UnZIdFbftNZ4mqZHJz7bGfALXuQ/IK/C6BvDYAkW
         6C3gtJiZZFePWi2LU7eg6krxdRPhW53qenhyaQ+U4HEy+dMSQakG+SdSiAF9wbQYCj3o
         TYXU9a2yLbtUWLDne9kdD5WBcjL6jzQAMmsFCuZF9VLNWaWPHCMoQZgzWe6EvAnGIPs5
         sZNzBdFJ9V21xZOHvBfd2fJyrL0n6DcY6mGgsJ+FfzVr4Weyrq7YtW00aaf3Gby7J/vH
         /xrqMroWPGtslqxm/ilVmxlPUVjA0ODPAXtIJGLQUDy9UJ2kKR+4ZBDdVk2sU+TEv6Vl
         gguA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=w5R3fvbChOogMJmaRFfwAONf/Hm4fSZS4S5dv4d04tk=;
        b=EDeOA4GuIQbF6DWKi0SovOiWmJ3fvUOH4Ojhh7o5SKmdILb/tASvghlZXgcD4RtDwH
         bKE1duxixBiVUtScm1V8gjGyqbYG1fzx3wZQgY0TbBLpCYHBlfffDfepo0rmQSdRsoYG
         yU4Q1hfdyNMzODIzg7KoWAmktJnyn/8lLnWKSTLan4VNdyhVjtElCvAve6Nxb9UKol3m
         IO8E7Qk9Pj/JfeR76Pt1TcMu1A/A0vE9bU3cUKyH51UXz1Bxb3HGQOXyqsZEQEDq92RC
         Gh4BkFss7QO760FobdmgPNhvzPF5STW5WeL4oMru9bW0yjzCnnLr3PXtTRUMgPptXBO2
         sdZw==
X-Gm-Message-State: AGi0PuZ8hoY4MPIzmbJvCNksc32/fPQOFAtSaPDrEXwu8K3e/hBB2ZHV
        5F8qVZZT13w7fdmZ/uTVTdy7LFZj
X-Google-Smtp-Source: APiQypKMmUt+U3kIFd9SWlYwgiWxVTVWBrGxm1pLuYV0thgXgVvZwuGl1GrJD2Xk/EzdWtf5gcv8mg==
X-Received: by 2002:a5d:6448:: with SMTP id d8mr19738576wrw.118.1589198187219;
        Mon, 11 May 2020 04:56:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r14sm2169264wmb.2.2020.05.11.04.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 04:56:26 -0700 (PDT)
Message-Id: <05f8ee147527f44fa673ebab26f2a08db0068ffe.1589198180.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.622.v2.git.1589198180.gitgitgadget@gmail.com>
References: <pull.622.git.1588347029.gitgitgadget@gmail.com>
        <pull.622.v2.git.1589198180.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?SZEDER=20G=C3=A1bor?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Mon, 11 May 2020 11:56:14 +0000
Subject: [PATCH v2 07/12] completion: offer '--(no-)patch' among 'git log'
 options
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     peff@peff.net, me@ttaylorr.com, garimasigit@gmail.com,
        szeder.dev@gmail.com, jnareb@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 contrib/completion/git-completion.bash | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c21786f2fd0..ec6ff1d5fb8 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1860,6 +1860,7 @@ _git_log ()
 			$merge
 			$__git_diff_common_options
 			--pickaxe-all --pickaxe-regex
+			--patch --no-patch
 			"
 		return
 		;;
-- 
gitgitgadget

