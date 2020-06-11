Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE511C433DF
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 12:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B834620747
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 12:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGUXZ60s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgFKMjE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 08:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbgFKMjE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 08:39:04 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0880C08C5C2
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 05:39:03 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id c3so5964102wru.12
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 05:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=cQm3yJy48tmW/vLjSrBDZ96RfHvGILnQb1b4FGqtp9Q=;
        b=eGUXZ60sbep91VXN1vo68XZxO4xfgWwskdCPf8vn6Oh4MAEgrWQ6zCZq/DB3VbIrjs
         cJaoDb8zAjCWvjaKjE+DScBqbldl+ctgwtmFM4SR5+lV0oYmm+KkoeP9njdcZ8Z8tWiT
         OaPCxkz/QkM0nfrAfn68pygGsPtnh+BPw9r5NeJFiRag+8up4hOXErSFVXG/CzVlOvor
         yR+Xu4zbSx9jtcS2gGpo1OCnKvisHu4Tl9rgzIIUxtNZK75a+hyYc+qbaJyRPFfXr56t
         78I8QJ8HIEKELlFa621uG6LW5VCeoc3w9rT4xv85Zbdc1hGOpq7bCy1Wzqtmx9grWSsq
         X2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cQm3yJy48tmW/vLjSrBDZ96RfHvGILnQb1b4FGqtp9Q=;
        b=NRLDRUgC0JU9g+CpGjMDlkS5e9UBqVVvnUsyI92uIjy6Ij+xG6E2ZNC2eZIW2hlIVg
         pLCR5xg3WJ8A0FH2zxG3NyoDFbKqGVZcXTzDDNrisrv/1KVkS4RSfifY5cofkTRjTN7M
         ZIEbr3qFN45RbM+b0WawovGg1SozT32g+XADNmO5nZHVV6DMTTTevg4tsjWnuZpT6uqE
         0Uf5BkqwVvSMnYRFLNfqy03Er/UcQR3joqgMXNvAcpzUKkQ03d9ihFb2A6GY3byCMlr2
         wcmQ8RkXM56CXPKa6+dGwbv/oDjLP1HGYPclkvogeIUr0mzWvIEu83MvAZVm0PKKdTvo
         Blrw==
X-Gm-Message-State: AOAM533nFtVLMa3egu1UGFWAA84wetcejqzKMrIi5HVx631y8wIczNxZ
        2wRX6FhE0lnNNLXhoCHlLBNAM6qD
X-Google-Smtp-Source: ABdhPJy+quPC7aTiJJjyDS6Rg9t9FVSgp2hCF6GOMGlJJIk6kh0V2A+Aj07180/TRzR/oqsJAHdmYQ==
X-Received: by 2002:a05:6000:d:: with SMTP id h13mr9118987wrx.17.1591879140953;
        Thu, 11 Jun 2020 05:39:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r4sm4564185wro.32.2020.06.11.05.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 05:39:00 -0700 (PDT)
Message-Id: <pull.654.git.1591879139.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 11 Jun 2020 12:38:56 +0000
Subject: [PATCH 0/3] Fix difftool problem with intent-to-add files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This problem was reported in 
https://github.com/git-for-windows/git/issues/2677, but the problem actually
lies with git diff --raw, and it seems that the bug has been with us ever
since--intent-to-add was introduced.

Johannes Schindelin (3):
  diff-files: fix incorrect usage of an empty tree
  diff-files --raw: handle intent-to-add files correctly
  difftool -d: ensure that intent-to-add files are handled correctly

 diff-lib.c             | 16 +++++++++++++++-
 t/t4000-diff-format.sh | 10 ++++++++++
 t/t7800-difftool.sh    |  8 ++++++++
 3 files changed, 33 insertions(+), 1 deletion(-)


base-commit: b3d7a52fac39193503a0b6728771d1bf6a161464
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-654%2Fdscho%2Fdifftool-ita-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-654/dscho/difftool-ita-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/654
-- 
gitgitgadget
