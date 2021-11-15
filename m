Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8D7C433F5
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 11:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 568E663214
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 11:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhKOLrs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 06:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbhKOLrO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 06:47:14 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95EE1C061767
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 03:44:18 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id r130so14816157pfc.1
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 03:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EfAki//qcZQGMx9fEivF9L0yERT9N7mhGKH/cJDCHTg=;
        b=PDuHqAtwpdzGXSlUGgLk5e0NVnCI9qitxHtt/NXnjTe6GIJ9MCDUjrDN2gIT+kgdDG
         MaEaAmGxvhCKKJzhyLJUKApn4JAF1M9A7gH8DXvaOxnrSOLDbCb4pvMg558VRcrSaDq2
         PovsGz/sG869/0oHzN8t1Pk5t8aHSPXnPngvDNsl8uRHxtIpW8D+OxRKgoamMtQ8Lf/Y
         Sl69BmuwQJ2bVKixQgiuwuFWCDoyDbK44TvX+l0ECcvicam+yw0WG9i7X/g2htW0wQic
         lpocLY9pgQNNBEGhcpHiF3MeFFQ1/iBrlA8m1OILeYSVz0q7UFUxR04G9UPNuluosKKf
         blbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EfAki//qcZQGMx9fEivF9L0yERT9N7mhGKH/cJDCHTg=;
        b=UbTefNaeVq0L6FNZSNOJIAotMMnRKK5FtkO2EzY9bSV/mRlrofCfFkJmCmMwoQbIld
         DwwAfsEmXV/JQnHg0b9EWpgtBjPRmT1cEScq01KU/bklwzmnjW3R7HlR3N5Gp5HxOyR9
         NlM48lhT7cpi+hlejm/sl7/97Vo9CA0EnRPQy4AJaLeiiDYWwiAADsvpmo2syw/7EZzv
         ZZPtrGbZNcjBCT/kKwCQfqIv+xSdrpx1H4CkQEab+69h4HRSFdIv+mA1B3ZCEis0W+Ph
         eKE+I2pDKRh68w379n4UaotdZb2ahKgfwYJuwQrPy1vw+Vt1Ze2Wfg8Oi9QAMjGRfQpG
         gCTQ==
X-Gm-Message-State: AOAM532Y0hNgTGII6B1YGfnLMjTFvPrLRcpYFLj4p0to9+4H+SNZj37H
        DD0xI1KGCgoDlBt2Rd+et3whevA0BV+lFQ==
X-Google-Smtp-Source: ABdhPJysuY+Gbr346gcujA+BJNKUpbDXzglj6bHh7cEJfoOzRsFTk8WlJhVAf88Jhbj0i+BkjSBEOA==
X-Received: by 2002:a05:6a00:8c6:b0:4a2:d762:8b42 with SMTP id s6-20020a056a0008c600b004a2d7628b42mr984205pfu.28.1636976657659;
        Mon, 15 Nov 2021 03:44:17 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.98])
        by smtp.gmail.com with ESMTPSA id h3sm18325313pjz.43.2021.11.15.03.44.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Nov 2021 03:44:17 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Teng Long <dyroneteng@gmail.com>
Subject: [PATCH 0/3] support `--oid-only` in `ls-tree`
Date:   Mon, 15 Nov 2021 19:44:00 +0800
Message-Id: <20211115114403.47877-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.33.1.9.g5fbd2fc599.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sometimes, we only want to get the objects from output of `ls-tree`
and commands like `sed` or `cut` is usually used to intercept the
origin output to achieve this purpose in practical.

The patch contains three commits

    1. Implementation of the option.
    2. Add new tests in "t3104".
    3. Documentation modifications.

I'm appreciate if someone help to review the patch.

Thanks.

Teng Long (3):
  ls-tree.c: support `--oid-only` option for "git-ls-tree"
  t3104: add related tests for `--oid-only` option
  git-ls-tree.txt: description of the 'oid-only' option

 Documentation/git-ls-tree.txt |  8 +++--
 builtin/ls-tree.c             | 11 +++++++
 t/t3104-ls-tree-oid.sh        | 55 +++++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+), 2 deletions(-)
 create mode 100755 t/t3104-ls-tree-oid.sh

-- 
2.33.1.9.g5fbd2fc599.dirty

