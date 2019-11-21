Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD395C43215
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A8AF206D8
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRP0RuBc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfKUWUc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 17:20:32 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:45706 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbfKUWUc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 17:20:32 -0500
Received: by mail-wr1-f52.google.com with SMTP id z10so6297341wrs.12
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 14:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QhdTjpNyLlaQTnceyP3CQGFetOmTYh2FYhesHNIX4gQ=;
        b=hRP0RuBcGyUmRvK/NxJuYeECO9/Tq13XBR8CERFSsYeOTi5h5FuTXUv25crI6zzpMw
         AUrfkzxHv5KlY3bGEdgkufYLiM41RkZCjBwIirLkWqfi2QuUdNA6hKmVuBGRfBMIDuGb
         Cot/hq+tGN2tDmu9zpSx0NGtojOwgUzLRX2riEXL78h1qPpdWmmVVSPN09NeAUp2qQno
         WM6zJtWkFpMJBTt++X9ibrBJK+FCv7dcryuA6fz0cP+GBwlZ0L15rigSsA1yoqqv5Sly
         rHjvkbv+xUKOb9uoNFAT2bsQ6WoXckZCbQaG/xyCB4tSGfNXWal4LZjOofnG1dI0cPA9
         2KcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QhdTjpNyLlaQTnceyP3CQGFetOmTYh2FYhesHNIX4gQ=;
        b=HMy8cX+EGpYgbpxmTxfuUwSDShYgj2IaL74YNZxHHc0f2TlS1NYjQfZyUAV2cZ1Med
         9Tm/cGVvCuMxhNy0vaJZrcn2WfYzL6VDkUbbshwYiSHyBuBRA5pyBbSK3lf6N/8Y8MBl
         Fm/BGVKm/Z4EmqZBCCtRpdmQOyFvomtsBeDBALFpLcJY2GXsWOTA1i3g1BcaOVubC8zE
         gk930ABHj1NGoKOZbbtKhnXP7+NqBJvRH3+/1yCYGdtaKSOfqAUNHj4+9puraAza3T9M
         4IhB6cLCi/uNR6Pt5CKEMFIkJGFg6BPfJ50LFHOOchAg9EVvL+S6UbWM5ioUXHEfK0fN
         aPsg==
X-Gm-Message-State: APjAAAXH9k1cW3i8EuhMMdieHxdYs25gGFGx2yjlUakvWI07GZg37CrD
        /poF6MhMCXbVbRai03TZL76sQjMD
X-Google-Smtp-Source: APXvYqyrx+8JZvpguqSCWaEuFoqRNcRWC9vIBFYus+z2Czkr+etyzpI/4aVuQEkFVtYS0T6h4nIlVg==
X-Received: by 2002:a5d:4142:: with SMTP id c2mr14145008wrq.60.1574374830053;
        Thu, 21 Nov 2019 14:20:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d7sm5141191wrx.11.2019.11.21.14.20.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 14:20:29 -0800 (PST)
Message-Id: <91797769825438318d243b4dfddd6784b733fe4d.1574374826.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.466.git.1574374826.gitgitgadget@gmail.com>
References: <pull.466.git.1574374826.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Nov 2019 22:20:19 +0000
Subject: [PATCH 04/11] t1510-repo-setup.sh: disable fsmonitor if no .git dir
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1510-repo-setup.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 9974457f56..28dce0c26f 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -775,6 +775,7 @@ test_expect_success '#29: setup' '
 	setup_repo 29 non-existent gitfile true &&
 	mkdir -p 29/sub/sub 29/wt/sub &&
 	(
+		GIT_TEST_FSMONITOR="" &&
 		cd 29 &&
 		GIT_WORK_TREE="$here/29" &&
 		export GIT_WORK_TREE &&
-- 
gitgitgadget

