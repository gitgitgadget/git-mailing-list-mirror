Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3206DC48BE8
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 20:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AD3861078
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 20:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235069AbhFNUWY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 16:22:24 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:43715 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235142AbhFNUWR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 16:22:17 -0400
Received: by mail-wr1-f46.google.com with SMTP id r9so15834158wrz.10
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 13:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=gW9WhRAKP6zKVCYCXI7jijT/kSfbkgWg5l39A/JvZNE=;
        b=GT9cPxVVip9Cg5YLNOYBF4cA7yy8pMN6+XNnxuke6QYACXZJIJSbpGdF30V/CYJ2St
         G89cbIcVTJpbfM9Qn3vQL8dbxMnX+NKwhIi5HIQ2iZR6oLXqlkGD+8gsD3scNWlEKsqG
         DIC63ESbSIwmZTJ7GdLe3WVsfls6nD4qgHQcZgp4fIuDCAyHb67ulL2IjyBnrZHrKn3T
         B6DMkhdZ6RReiinroKJlrUPt1cOSHhiZ4izgQMVI9FdCHScmcElgjVdhvHPSr5ZtvTnu
         q4WhGvVTPo0HTlmtEgoKdPXsmIggTry7J3agVMG4AkMr+FLFhkvuTMnuNiQfyT1wXKVp
         DkVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gW9WhRAKP6zKVCYCXI7jijT/kSfbkgWg5l39A/JvZNE=;
        b=tYITo9OLYQccxKvoIpY0sWvVvWY1uc9LBIigOWXU34E5LRvfT6RsvoJ1CNVKC6rEBw
         9rob394B34kfHUnsfxg4cOn5Vg5FisZJ7bgJyyNOK6wy2HvAp6+0vXy7Hhw/ZNMV53UV
         2Oo+TYcA0WIxzT7OJ0AGEMNL8EsYiXshRR5GwwpmcLVQqlgz2fvDK54O+nG5j0AdsIRD
         O9mfmAUzX+e0/Vyv8TazSWyhBU5RMQorq0IFEiTvMJuVzY25Z8mXSyRJURqrcMSRrTCP
         PwTrToXCBg+QBt7FVaQS8P0bfg4i/4ZNv4HjMXgevRSYSy8mAGwamrHggHLFtc+xVQRS
         lNrA==
X-Gm-Message-State: AOAM533woO37K+6RDGENbMYX8jP6nBzouRxOeWm2s8j+Yy96M7jl7429
        z/gMJ8S79HyARPdMFp63XdxDYF/BkY4=
X-Google-Smtp-Source: ABdhPJwQQPum53Y4/9iss4DUGxDSVBl6DFa8Qgi7lKoUmUzJbP668wlgWqywykRNuNyBDqfddnUjOQ==
X-Received: by 2002:a5d:5683:: with SMTP id f3mr20668974wrv.61.1623701953727;
        Mon, 14 Jun 2021 13:19:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e17sm18580442wre.79.2021.06.14.13.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 13:19:13 -0700 (PDT)
Message-Id: <pull.982.git.1623701952823.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 14 Jun 2021 20:19:12 +0000
Subject: [PATCH] pager: do not unnecessarily set COLUMNS on Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Since https://github.com/gwsw/less/commit/bb0ee4e76c2, `less` prefers
the `COLUMNS` variable over asking ncurses itself.

This is typically not a problem because we ask `TIOCGWINSZ` in Git, to
determine the correct value for `COLUMNS`.

However, on Windows it _is_ a problem because Git for Windows' Bash (and
`less.exe`) uses the MSYS2 runtime while `git.exe` does _not_, and
therefore we never get the correct value in Git, but `less.exe` has no
problem obtaining it.

Let's not override `COLUMNS` in that case.

This fixes https://github.com/git-for-windows/git/issues/3235

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    pager: do not unnecessarily set COLUMNS on Windows
    
    A recent upgrade of the "less" package in Git for Windows causes
    problems. Here is a work-around.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-982%2Fdscho%2Ffix-duplicated-lines-when-moving-in-pager-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-982/dscho/fix-duplicated-lines-when-moving-in-pager-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/982

 pager.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/pager.c b/pager.c
index 3d37dd7adaa2..b84668eddca2 100644
--- a/pager.c
+++ b/pager.c
@@ -111,11 +111,13 @@ void setup_pager(void)
 	 * to get the terminal size. Let's grab it now, and then set $COLUMNS
 	 * to communicate it to any sub-processes.
 	 */
+#if !defined(WIN32) || defined(TIOCGWINSZ)
 	{
 		char buf[64];
 		xsnprintf(buf, sizeof(buf), "%d", term_columns());
 		setenv("COLUMNS", buf, 0);
 	}
+#endif
 
 	setenv("GIT_PAGER_IN_USE", "true", 1);
 

base-commit: ebf3c04b262aa27fbb97f8a0156c2347fecafafb
-- 
gitgitgadget
