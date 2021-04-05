Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE54C433ED
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 13:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15C83611BE
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 13:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237078AbhDENE2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 09:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235661AbhDENE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 09:04:26 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F46CC06178C
        for <git@vger.kernel.org>; Mon,  5 Apr 2021 06:04:20 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id j18so10861112wra.2
        for <git@vger.kernel.org>; Mon, 05 Apr 2021 06:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wuRuYYWVThwVuKMtFPkVF2Ilw+IL9JMWGp2mFqIegZM=;
        b=eb95RImDZQuiUourk2hqgPzAJwJYFF25zcRR+SfynHpoj6eNbR7hz5/tjNWOpgcicJ
         nVLOu6oJOoiRiM+9zZ0B2a9rSkCuPL3uQBAMUyBqnvOdUu5XmkzDGw5cW9iIHC70vvmM
         V4+nuj4roz52M5G1rtxIMeFCuTQrugyrqw0V+lRHzgciEzLCC+25OYIz9yQThqp3NppH
         wRxudNxc4Zk8vO/Lcge2dW4l0GkEvs9ZwvSQFXlC0CwPpnKoaqz5iHm1E5psh5xT589p
         dThwJAz8kDBfT/Z72SUyTTXa6sxUWjdGtrOovoJpeoXotZexyin/7NC4oACQnaVXV8pP
         qtGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wuRuYYWVThwVuKMtFPkVF2Ilw+IL9JMWGp2mFqIegZM=;
        b=f+Tu/dxFv09wqJuiNgmFtyoCD5D97ZXPDc64t6+3SanYbJ8lfVyIoHtNgsO0ATa7oR
         Yoq+i6YwskF0GMLqVopukZEsC1GAKRhAKsxnNIT9kLW8WXtFd72ft3fh3QMN1kcvyXuR
         mqbvUjfPTfE0uqETW2hFCY/WVMgJTcpLq82BpGgCafABSz9vQFF5B94JYS68ePDSEK87
         IyM5v/I+c6HIkzOphqZkqYA3MXRfRdvOkH4cmhIHIj7q+RyTkwvFowwIcQ+p6HF51vkk
         v458RBlC3F2Lsy7CWh1hWbUKH4CYotu64gKxvryFgdPFSDvkuDJKSzL56oM4Z4NjrGm4
         kNcQ==
X-Gm-Message-State: AOAM532Ptuo1covV0nkRaBHOhJHYo2GVvE55heueaF1Ms7Jk66ePKqsf
        ZFnnv5GfjGnPNnnT9ogSn9oaPfXUwoA=
X-Google-Smtp-Source: ABdhPJymM5Y88g6uGWyWEadNqvtV2P8F0xEBMDvluKKBHjlGffPuDZaTPULdg9ASPI3GfCIlugbhSw==
X-Received: by 2002:adf:e68e:: with SMTP id r14mr28700027wrm.273.1617627859304;
        Mon, 05 Apr 2021 06:04:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q10sm12125205wrx.35.2021.04.05.06.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 06:04:19 -0700 (PDT)
Message-Id: <2b74889c2a323f03be477ffdf9ff388405779c3b.1617627856.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.924.git.1617627856.gitgitgadget@gmail.com>
References: <pull.924.git.1617627856.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 05 Apr 2021 13:04:12 +0000
Subject: [PATCH 2/5] test-lib: use exact match for test_subcommand
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     tom.saeger@oracle.com, gitster@pobox.com, sunshine@sunshineco.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The use of 'grep' inside test_subcommand uses general patterns, leading
to sometimes needing escape characters to avoid incorrect matches.
Further, some platforms interpret different glob characters differently.

Use 'grep -F' to use an exact match. This requires removing escape
characters from existing callers. Luckily, this is only one test that
expects refspecs as part of the subcommand.

Reported-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t7900-maintenance.sh  | 4 ++--
 t/test-lib-functions.sh | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 2412d8c5c006..fc2315edec11 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -142,8 +142,8 @@ test_expect_success 'prefetch multiple remotes' '
 	test_commit -C clone2 two &&
 	GIT_TRACE2_EVENT="$(pwd)/run-prefetch.txt" git maintenance run --task=prefetch 2>/dev/null &&
 	fetchargs="--prune --no-tags --no-write-fetch-head --recurse-submodules=no --refmap= --quiet" &&
-	test_subcommand git fetch remote1 $fetchargs +refs/heads/\\*:refs/prefetch/remote1/\\* <run-prefetch.txt &&
-	test_subcommand git fetch remote2 $fetchargs +refs/heads/\\*:refs/prefetch/remote2/\\* <run-prefetch.txt &&
+	test_subcommand git fetch remote1 $fetchargs +refs/heads/*:refs/prefetch/remote1/* <run-prefetch.txt &&
+	test_subcommand git fetch remote2 $fetchargs +refs/heads/*:refs/prefetch/remote2/* <run-prefetch.txt &&
 	test_path_is_missing .git/refs/remotes &&
 	git log prefetch/remote1/one &&
 	git log prefetch/remote2/two &&
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 6348e8d7339c..a5915dec22df 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1652,9 +1652,9 @@ test_subcommand () {
 
 	if test -n "$negate"
 	then
-		! grep "\[$expr\]"
+		! grep -F "[$expr]"
 	else
-		grep "\[$expr\]"
+		grep -F "[$expr]"
 	fi
 }
 
-- 
gitgitgadget

