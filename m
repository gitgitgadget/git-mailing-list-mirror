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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A9CC4320A
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 02:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F70A61039
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 02:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239412AbhHaC1q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 22:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239416AbhHaC1l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 22:27:41 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0E1C061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 19:26:46 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id g138so10041835wmg.4
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 19:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1KZlym63hsEmgZKhgF68sGOhw4+6yJaaNBmMEKsLv5I=;
        b=pF1N86GXOkmd8SEN2rslN5p6fPEcQGZuPPCM3gA7wygxHEBcLnr9KojiOJSff1EcQh
         J6QBYKUDRS9GWBR1WOIGPwvJ5j8cERHCS6Udr8bl6PDR+pXaeiuJwGs5ne7YSOn7j43w
         pqzddG1OMEuNvH5oxz+LkaLIYSm2BjAA7qlJm6Vst4wBhztdo2Ghv/Xl/5CHu3z+ff99
         1OOHwygUvzK18oBMiPWz08lS5M8o4E0ls2jvoHv2Agqe/GbmhNmVl1bf3dG7WkLaKhOf
         7c7/0Bry1f1gQF5pqLVzCNgM3VxKAPsnGjpTt6gHOrk0gBK65gZMPrEirsOwzN44Zjju
         cAcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1KZlym63hsEmgZKhgF68sGOhw4+6yJaaNBmMEKsLv5I=;
        b=QLEB8xO0CH9uxNqhLgCs9NaRxQJ7oHxBvR1Yr4SYJixLODTHKy+xL/H6YsswgbgKRs
         g9PLtKjFCpLeN2ghzhi/g9xwYDPvCxDmobKPTklO+1hUm/gEapi+g/yZh1mEMstjZ8DJ
         NISvz9/5k8vezu5NzIoQcnZqKhfxCeaBuxs+uYKulswhqzVMrcouiQ/8fx2+dMp8FNtw
         i92k2CWkFzp6KCmjAiyPZvpWnkvSbdLZ+2JBB1jly8uwM2xl1jWI52h2w0nOwDOoa1CG
         7wxdLzBSi9E8b9/Mc8nNvfTvoTFr02UPNg3inR3bhAqyw7ANjqJB9y2xV824T5EyGTfa
         zvDg==
X-Gm-Message-State: AOAM533aa7OskMXeACmp66hI6eCL1XovZsFKA+4xVLKgr9SIe8iBmIxX
        P2IGUTgFsaVzY8w5LeJGUMh/8WPJP84=
X-Google-Smtp-Source: ABdhPJy/9PiOnR7bjxgxMs0/4dAvM8XeDcBfq0YHctugHo3gnvBxmJiwTxGdryx70WQsl2CRbbCt/Q==
X-Received: by 2002:a1c:f414:: with SMTP id z20mr1738378wma.94.1630376805555;
        Mon, 30 Aug 2021 19:26:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n5sm1048192wmd.29.2021.08.30.19.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 19:26:45 -0700 (PDT)
Message-Id: <ac58cb9aeb587a08754e47815d28e2ce91370e66.1630376800.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 31 Aug 2021 02:26:40 +0000
Subject: [PATCH 7/7] doc/diff-options: explain the new --remerge-diff option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/diff-options.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index c89d530d3d1..b05f1c9f1c9 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -64,6 +64,14 @@ ifdef::git-log[]
 	each of the parents. Separate log entry and diff is generated
 	for each parent.
 +
+--diff-merges=remerge:::
+--diff-merges=r:::
+--remerge-diff:::
+	With this option, two-parent merge commits are remerged to
+	create a temporary tree object -- potentially containing files
+	with conflict markers and such.  A diff is then shown between
+	that temporary tree and the actual merge commit.
++
 --diff-merges=combined:::
 --diff-merges=c:::
 -c:::
-- 
gitgitgadget
