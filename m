Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C5CC433E0
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 17:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CC38207E8
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 17:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G859BSR8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406959AbgFYRxq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 13:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406955AbgFYRxp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 13:53:45 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC340C08C5C1
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 10:53:44 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id f139so6850890wmf.5
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 10:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jzq5Z8sPrMzIYKA6uw17FQivGsH+sEOsh8uUK5cMTDo=;
        b=G859BSR80Jvoywpwg0RYOZPvfNht3j5SKiUze4caCfcUEF3yl9O4yOKMv+ZK1et94w
         TvpA4h6EX43Kc+6yT4GBmWBgcE2R04mkH60Mn1hMNrUdRiifD5gUqP8J+OiSoQSPPm+0
         PMg5XuiCzvByf92DR7+s7jktL+A2zlXfKI7Pq9xUet4jN0b1GTl1TVq7rXYwD2LQCPcF
         Q2oN6YmVBpL8YXW5FD4eDbIRZMpkg6KmXIygmp8hF1qVqj7yTJuxgRIYoK2sQJCQcwcq
         /L/bAyjGJ2HmES761qtisoBOFgvCaI6EVwoA+DttLqMXf6w41CkmKl48bEwzHMv/SXFY
         UPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jzq5Z8sPrMzIYKA6uw17FQivGsH+sEOsh8uUK5cMTDo=;
        b=kjqPVeG7IXxH2HV4U1h0Mzcyw+8t6kXEFcxc09sKZzlWmcwbqfXTJslWPqfu+GLqIl
         cfbicDk0Mw77rdG9tS3LiszXACpvQAW+xVvF+wjSbesO84m+tt22BNk8fW5N8LP3gMNx
         u25bl3+Cdcb67BkiFsKxre1qr9Xmn1Y8XBCwCaFWY6DIpy1V8Fqh7E1eKbOzAOdGPKFH
         jLOD9Tau7qzPwPh3GvfqlERSW0VG6l2w8YCZR5+smNfOqh2C5pD4S5OddrSTKWru8U8c
         dQ/utSPB7LXHBJ6ZIW45ZnQtk/9oNDDrtN6sqZ5YELboC2jmAYd9dZ/FxSeuPXQ7yXmu
         xh/A==
X-Gm-Message-State: AOAM532p3kMuTCSbmj6doZzlsUN3Wkx+XvpKJyLCDS1CDRGbm0XKJtBf
        lPOevM4Aj4Tvm/3yvVmPxvhVS/al
X-Google-Smtp-Source: ABdhPJwBBcTg5oI8EOzzIPoqWRdMPRdxrHnrCI91nY7Tu8x8z1S6Z0H+UGFa+uoU1kaxc3qD19TN1g==
X-Received: by 2002:a7b:cf12:: with SMTP id l18mr4904304wmg.131.1593107623640;
        Thu, 25 Jun 2020 10:53:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c143sm14925990wmd.1.2020.06.25.10.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 10:53:43 -0700 (PDT)
Message-Id: <9bb8d84ea956dcddefbe7b62baa3a5ff23b6b1e2.1593107621.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.654.v4.git.1593107621.gitgitgadget@gmail.com>
References: <pull.654.v3.git.1593010066.gitgitgadget@gmail.com>
        <pull.654.v4.git.1593107621.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 25 Jun 2020 17:53:41 +0000
Subject: [PATCH v4 2/2] difftool -d: ensure that intent-to-add files are
 handled correctly
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In https://github.com/git-for-windows/git/issues/2677, a `git difftool
-d` problem was reported. The underlying cause was a bug in `git
diff-files --raw` that we just fixed.

Make sure that the reported `difftool` problem stays fixed.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t7800-difftool.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 29b92907e2..524f30f7dc 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -720,6 +720,14 @@ test_expect_success SYMLINKS 'difftool --dir-diff handles modified symlinks' '
 	test_cmp expect actual
 '
 
+test_expect_success 'add -N and difftool -d' '
+	test_when_finished git reset --hard &&
+
+	test_write_lines A B C >intent-to-add &&
+	git add -N intent-to-add &&
+	git difftool --dir-diff --extcmd ls
+'
+
 test_expect_success 'outside worktree' '
 	echo 1 >1 &&
 	echo 2 >2 &&
-- 
gitgitgadget
