Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4835C432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 18:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A77DC2070B
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 18:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgJKd67y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfK0SNm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 13:13:42 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:47084 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfK0SNm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 13:13:42 -0500
Received: by mail-pj1-f68.google.com with SMTP id a16so10362540pjs.13
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 10:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I6Kso95AXyCk2GNDiPAC3kfGna2SOXjNCHBQZmZiwKQ=;
        b=TgJKd67ycRzDTQVSN9D3j4tAyuDfyvxxA7oh072iOKuYQw1MJq+favcc6snwxzSoOb
         OB+jpJltc4XN8NrBYM8cH2jK4FJ/LfZ/dWxNwd1pNPhHYQgwRrR9R8/Ipg++DXlM+vzO
         szPdrOnqyVG1u4kpggl8kzJyR/8aUhWfbxV7SFmNeWEHLyxguf/PCLGAjRA/zhs9xM2M
         vXvtX2FTwBr91UqSB2INrAz7qnf3rG42a5wh3V3IE/KZRF7aEmdjNBzfG1w1NWpZB9t1
         4nKLYDsSxaTwIXL0jMCEJwn9AL8U7zCETZb/PrkyIbXcm1VlR3+skUzWHrOONFDA381m
         M3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I6Kso95AXyCk2GNDiPAC3kfGna2SOXjNCHBQZmZiwKQ=;
        b=Jfly5J+4ndYEGgg+Kz51FwJ1GE/jbuts+7ACKIZJpXb3cQ3DUOLyUWtXXqmGk59znq
         SxYl7JfRtt0BaBf8yaGZfTnlCR/BiO1m8EodSgRoG7OtwCmwuxBl9YkEdLxVKotoW/Q1
         Nxnte66ly6O5TLo/dZu631BAWIixA/Yj5AWXB+nBUlArDbukDxBqSuMHchyRLcO1SplC
         msbtS9CJ2R5U9CN4vyUQJUPHQ6jHT/qupA0pDzmYiHadFNk53bKUM52XywSK9PvUsRL7
         CfhgPnzX0pIlt8UTZQll2G7Ftbt10AC8ZEfUpc343sSmpfiYr0okBBqfnmMLR1e2rJ0C
         EoxA==
X-Gm-Message-State: APjAAAVNgMgntju0XMzvfrRj9ka/OgMn6TNUA6yLKM5xhARNI62bqpcQ
        Qo6M5SL+pCd5eVrRhuiiRHbM3s+m
X-Google-Smtp-Source: APXvYqyNxXomeLEmJtb49TPwZcoh3E7gi1VTg4fsNdCXorTnvXWl7CyF88/7U/y2TLNsUCxF+3xrnA==
X-Received: by 2002:a17:902:4a:: with SMTP id 68mr5634893pla.158.1574878421616;
        Wed, 27 Nov 2019 10:13:41 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id 136sm17710110pfb.49.2019.11.27.10.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 10:13:41 -0800 (PST)
Date:   Wed, 27 Nov 2019 10:13:39 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Christian Biesinger <cbiesinger@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 1/5] t3400: demonstrate failure with format.useAutoBase
Message-ID: <4089e51041a9cbd15e62882c370ed254d8e63cfd.1574878089.git.liu.denton@gmail.com>
References: <cover.1574820308.git.liu.denton@gmail.com>
 <cover.1574878089.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574878089.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ever since bb52995f3e (format-patch: introduce format.useAutoBase
configuration, 2016-04-26), `git rebase` has been broken when
`format.useAutoBase = true`. It fails when rebasing a branch that
doesn't have an upstream set:

	fatal: failed to get upstream, if you want to record base commit automatically,
	please use git branch --set-upstream-to to track a remote branch.
	Or you could specify base commit by --base=<base-commit-id> manually
	error:
	git encountered an error while preparing the patches to replay
	these revisions:

	    ede2467cdedc63784887b587a61c36b7850ebfac..d8f581194799ae29bf5fa72a98cbae98a1198b12

	As a result, git cannot rebase them.

Demonstrate that failure here.

Reported-by: Christian Biesinger <cbiesinger@google.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3400-rebase.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index ab18ac5f28..ca99e8c6c4 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -159,6 +159,12 @@ test_expect_success 'fail when upstream arg is missing and not configured' '
 	test_must_fail git rebase
 '
 
+test_expect_failure 'rebase works with format.useAutoBase' '
+	test_config format.useAutoBase true &&
+	git checkout topic &&
+	git rebase master
+'
+
 test_expect_success 'default to common base in @{upstream}s reflog if no upstream arg' '
 	git checkout -b default-base master &&
 	git checkout -b default topic &&
-- 
2.24.0.504.g3cd56eb17d

