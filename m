Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE87C3F68F
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7604220866
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lV6pX9M3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfLTSyA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 13:54:00 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35764 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbfLTSyA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 13:54:00 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so10287089wmb.0
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 10:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3K+wouIc8/kTuhmIZRnOUmgpXaymPRCS0LswuFOt9CM=;
        b=lV6pX9M3zG2PXFdnjvmdY5gQRAnrkDV3c2VvsaYsmH5qFrxOq+zGFAMPGlPzrc7GB9
         jfZN2CG4xf1x1JrpIH0rl1eLdljj7EhvN2vHYjj8RDVWOqQ6eGJ3dU7zqvk0yIyLA/Uc
         TBF6ti+mPefviLvnNd6M17qRL8PvbDWHipVx0eikYZhCdPyLyQbS4DHmHYDvdoWAmFyA
         RNI+nik6heRJUm51zFC15xM6SgpjTtRNNKLzN7yNw56QkM+swtzXLQYl8ALG/KonERsR
         YBdG4bXeyFhrEj87GsGZtSfbJF2Se2IZKyZOkLcXhQobt4Ka1ncoFYJfBYh5Vv5Gy5+t
         iYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3K+wouIc8/kTuhmIZRnOUmgpXaymPRCS0LswuFOt9CM=;
        b=jGR/fw/O7NA/ykYmxaYfnephumLoNAoQEDo8MZhUHavEHUdeeuMA/ZVOLcZOXH/mhq
         tk2Ym//HHwicmGrSDBCNxsPOl0LwB4k9QsHEzqzpyp4R6HetWSWBxd8qDiLjItLBnOAW
         WnPtflIr8nHby2sBqAuDh+RIfFkD4q0rIn2hOcFT8YG6dwlHa84gVzvymkdtduskJudn
         AQtoodUg/MnkFn8CiWiWdY1aKhHxCqjwIevV1ZjwcttI4ZkU4JIcEq3eSGmkIeBdQMSY
         RdT3mzQ9zwm6UHP51FkuWFYU2Ah+Px+pJNQWyofcaZT1IYW58jZcj2Rw2K6YIk4Drh05
         07xQ==
X-Gm-Message-State: APjAAAUxUaUs4tU3wIADeaH0Q/Yho+i4nQnR7caHvzuNSjIVlQiGPmq2
        W2g3WdECv+Yj1QV6OFbzWbuWBkB5
X-Google-Smtp-Source: APXvYqzk4p78wSeZHo593JvlzgMQybHT1ig7gDHEI8l9ABI3WUGicYHpKJCvAfQIKmyZlFn5XTyqZw==
X-Received: by 2002:a7b:cb0a:: with SMTP id u10mr17705771wmj.165.1576868038061;
        Fri, 20 Dec 2019 10:53:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t125sm7523791wmf.17.2019.12.20.10.53.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 10:53:57 -0800 (PST)
Message-Id: <e1870f3fee8be6ebbecdd618ae1803afb878e67e.1576868036.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.680.git.git.1576868036.gitgitgadget@gmail.com>
References: <pull.680.git.git.1576868036.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 Dec 2019 18:53:55 +0000
Subject: [PATCH 1/2] am: pay attention to user-defined context size
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, plroskin@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

am previously only checked gpg-related config options and the default
config options while ignoring any diff-related options.  This meant that
when users tried to set diff.context to something larger than the
default value of 3, it was ignored.  Pay attention to the diff settings
too.

In combination with commit 09ac67a1839e ("format-patch: move
git_config() before repo_init_revisions()", 2019-12-09), which is part
of the dl/format-patch-notes-config-fixup topic, this fixes
   git -c diff.context=5 rebase
to actually use five lines of context.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/am.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/am.c b/builtin/am.c
index 8181c2aef3..d4d131b7ee 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2136,7 +2136,7 @@ static int git_am_config(const char *k, const char *v, void *cb)
 	if (status)
 		return status;
 
-	return git_default_config(k, v, NULL);
+	return git_diff_ui_config(k, v, NULL);
 }
 
 int cmd_am(int argc, const char **argv, const char *prefix)
-- 
gitgitgadget

