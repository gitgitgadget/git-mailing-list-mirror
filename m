Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EF1C43461
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 04:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE9AE221E7
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 04:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBlYg3Iz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725765AbgIKEgz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 00:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgIKEgv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 00:36:51 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700A3C061573
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 21:36:50 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id v196so6434672pfc.1
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 21:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=gCHjWm8Ewv+07FDsQ5A4qQUcOrWqYNei+hhJCzbtqps=;
        b=IBlYg3IzdJ1eYf1DGCGVOwkfviAyq6B04wbeXX7roymis63tSQs5C5uY6m+gW28Tvz
         VfErrGcwD2AxcOB+RSib/ACnT3ukuX2XJFrWnOPV0fTCN+st6yyjS7bIodYmQLiK6EcH
         1PpI3kHlVNM8bVzpC6ALeHQWEj/YuCe9EDaMfY/yT/w6u+LTpxCps6FlRjkLnB0zM3zs
         uBVFgbJ7mdbY7V+8wTKq8XhldHg8y/khHnMRxRlBh2TekFi3Qg44aQHjw8uJlWbOu/OY
         Fi03WSfMZfsmUzVO7nmtV1GKKhm2ZXl1qH5FXdLlx/sxJ9We08DxGGtiOnDOTkZGvrxQ
         fbRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gCHjWm8Ewv+07FDsQ5A4qQUcOrWqYNei+hhJCzbtqps=;
        b=BVhybORODS96CqTZzblXQjYKxPG7lulvlJ4pANnTfmq5cj1XnG8id2C9HZNG5vRLCI
         025qufHHu8RSI0VwsSF7W4rNUUszFIEWctYbjQdrJX3yK3ToNfFhLtXG6n2tnxHK+zva
         czVNjdjHC8X1j1/rVqomQtDzwIpCNX30g6BcvLnvXdPhxVQ/7Uy3Pf2/WcBLJd6pK7RS
         ARWcrqUBH5sRRH9dKH0/RzfhUQ0JxzAotJGSztmKY2Fc8Wofhdj/+aZw66XW+ro7uT5p
         Nv26ShvXqtdDqTT5TTTxKX1XnnuDs+KzKI757u/zhkI86AouIDwiLmZtjLS4bxj2zuIB
         heiQ==
X-Gm-Message-State: AOAM532fXtWodfOmbiKPBro1fG0Ky8YSJ/RwIQpR85YcnlmeB7tpxsP3
        FtgHMsI3Rgl5k359aOsiPEJ/oHU4SOo=
X-Google-Smtp-Source: ABdhPJy5i9IuZ4YumxZ7zglMN8UAKstr1VF+mAE/zl7BcbaSTeHpDMWknKisu4eIpHI0qhVnYq8jvQ==
X-Received: by 2002:a63:4f26:: with SMTP id d38mr376728pgb.72.1599799008315;
        Thu, 10 Sep 2020 21:36:48 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:5900:d670::1ab5])
        by smtp.gmail.com with ESMTPSA id x25sm527804pgk.26.2020.09.10.21.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 21:36:47 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH v2 0/2] gitk: fix mix of tabs and spaces in indentation
Date:   Thu, 10 Sep 2020 21:36:32 -0700
Message-Id: <cover.1599798976.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7
In-Reply-To: <cover.1599726439.git.liu.denton@gmail.com>
References: <cover.1599726439.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The source code of gitk has some funny indentation. It uses four spaces
per level indent but uses tabs every other level (eight spaces).
Reindent gitk to just use spaces instead.

This series should be empty with `--ignore-all-space`.

Changes since v1:

* Instead of using tabs, just use spaces

Denton Liu (2):
  gitk: replace tabs with spaces
  gitk: replace commented tab with space

 gitk | 10570 ++++++++++++++++++++++++++++-----------------------------
 1 file changed, 5285 insertions(+), 5285 deletions(-)

-- 
2.28.0.618.gf4bc123cb7

