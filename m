Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9216C43603
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 07:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7701D20637
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 07:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLzouHg7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfLDHrz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 02:47:55 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42365 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfLDHry (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 02:47:54 -0500
Received: by mail-pl1-f196.google.com with SMTP id x13so2803582plr.9
        for <git@vger.kernel.org>; Tue, 03 Dec 2019 23:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LZjBfy1fxChr+CvrWi2FuH41XlOVip8CW43YiSem9cM=;
        b=eLzouHg7AM4l7N7NrNaszYeCKYMpStSUIior6NCtj/1L285C7ghsJh+5mo2eYg9YSi
         YT28keLnDEi/3EoS0XZSLXkjCWJfP0Lg0TA0GfVCGeyL8OJiMCc7WUALUa7a/XuDHAEA
         EByDMPYBbsZ/DIlQHSvkUn5nG012DJ3zEFS1RtU3zqIrxXj3+IaxPYdtTeNcRCmc7PlH
         LxLOYs75OgeT+VhLp5V4aPGH7AFit4YxnHPBvz0f7MMtuYsfPSfsFgfSxqy0/7qpVQ/o
         sxGXH4v9vQ75WXQ4jhZ6gobhi7Zaq11GytOgk0r0yPcMkJlaf9h91P4WCvVgsQ7DCRqo
         x1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LZjBfy1fxChr+CvrWi2FuH41XlOVip8CW43YiSem9cM=;
        b=k2MFezvmca71+0clnSUVafYss0jSbKjuLbCwZjG5KLWO0q6kLkhgBi6P+7YvfxyCJP
         K9EhvhGN95ocqGlvA3QRSbuoHI25V2zZwRcOPD8xhpDxHxMf/EfDVpQV8jloPBKTHkDQ
         CHrHSAX4m/ZS5IEjcDylqo4AHibkKdPHtgRcH/uI5DCm1u2x0ooCUcSEc2j6OtbP0TgC
         mfimNbZG6NpIHAYP+sjG5MWevl1M+W1wJvgFkg14NxN5FPfdakKdIz8rtpTGAGQqKgq2
         GYyGBPpGcOmlszGo4DVe2GSWftjcfQ/QtJC0QoB3SD+fMdevvKg0Xd3c1nM3+5zepKXQ
         lU6Q==
X-Gm-Message-State: APjAAAXZCgYYRIaVVfxonIcvUogW0DKyOKnArTkMwFiTqVSS+GxMHMZY
        jJ6DkYUavqszKSkPkfXjc1OBiTN1
X-Google-Smtp-Source: APXvYqxCRwOXujwJzYB9kTtpx2rkVJdLBsCuTdfXPocZ6aJi/T/3viOaqWp+qw3aB7T8vz8krc14ag==
X-Received: by 2002:a17:902:b691:: with SMTP id c17mr2007737pls.252.1575445673533;
        Tue, 03 Dec 2019 23:47:53 -0800 (PST)
Received: from generichostname ([2601:646:280:1b30:b0bc:639f:d5c8:2bcf])
        by smtp.gmail.com with ESMTPSA id 186sm6667713pfe.141.2019.12.03.23.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 23:47:53 -0800 (PST)
Date:   Tue, 3 Dec 2019 23:47:51 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Christian Biesinger <cbiesinger@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/5] t3400: demonstrate failure with format.useAutoBase
Message-ID: <8d67bbe5bfb7b09dff9687a06acb92fbf8202699.1575445583.git.liu.denton@gmail.com>
References: <cover.1574878089.git.liu.denton@gmail.com>
 <cover.1575445582.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1575445582.git.liu.denton@gmail.com>
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
2.24.0.578.g4820254054

