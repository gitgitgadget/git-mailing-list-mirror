Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F16FC64E90
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 01:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F4662168B
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 01:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Myc5vPSu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731775AbgKZB3O (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 20:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731750AbgKZB3N (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 20:29:13 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C3EC061A52
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 17:29:13 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id 1so555072wme.3
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 17:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7XlGbzA/7iMWtkvJ+Vve3dlMVUtJbKtMllv5EkntCis=;
        b=Myc5vPSuaTAj6MkS3lXrShboFtCQ2YpIZ5R1nKdHxG1fl8IxbcE5ghfcV+8lghml7V
         SfOB8aFz6Qv/wSz3OtB6/LtOgaH4RoiE5zYM2lYWOZ6HRDl+CYKnBmYW7ptJIlfdtqCE
         +cdw/umGzUcxB64P0HMbhw19bM6PCixMmJjrldq4l3fCkvC71Xswtt9Rq7zw8nnU3a0L
         8CX6e1B96ElOU5oLZ72pzZuiCoZmasF6o8WgT4+Xe7Olli0MFC0xFZVaX81od2ygs7w/
         Sp6cTE17SWj1f8HLg1WslDHD3zvD9KF13vTlRXNLLQbLMR/N01XZT5ExsUePX/EmoLon
         BP5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7XlGbzA/7iMWtkvJ+Vve3dlMVUtJbKtMllv5EkntCis=;
        b=YR4olRvkVpFmzwYJTv4h3YvM0v6mrsExkmO/WbkWXhDBsFqT5o65CCLQBN8sL5Aggl
         x2Y9Do+yYAGYZstzh0elsQUEd+PNjRonREICJcx1u20idcwp12NNuoofwZhU6MvF46f0
         Su11sHFgAF1K2D6xhZRzQ/uAeF55loOW/4IF02djS7RDKDcPQ9AeiR6+GMSryxZQq2CF
         /v+kpnkiOV4ltL2cQ+eXjc9r4Tp+8zqmw4mkt3veO90J6PsJA6CMBrtht9OR6UfT3DyP
         T+aJmqjMbRrRVeEXdOCX3k93xRWe+EHHXixkUHWEo/GV64/hesSUxRrZQ00JotF8C1yY
         6cbw==
X-Gm-Message-State: AOAM531NiEMTlfQYV/kFDTd2m/sFVRIvHyeaUAzJh3l8jKgvzZfb9tWU
        DH5hy45l1wdcDZAcXmte2TbjmTaEV2LUFg==
X-Google-Smtp-Source: ABdhPJwddrdIk/cyrDNBvY2jIp34ooBGkMFlVnX8+lmnUlAoaDPIGulZ/HcSPJPUDXEA2+ucZHc9Cw==
X-Received: by 2002:a1c:f20d:: with SMTP id s13mr476854wmc.156.1606354152017;
        Wed, 25 Nov 2020 17:29:12 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q12sm6402523wmc.45.2020.11.25.17.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 17:29:11 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC/PATCH 11/12] mktag docs: say <hash> not <sha1>
Date:   Thu, 26 Nov 2020 02:28:53 +0100
Message-Id: <20201126012854.399-12-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <X7wq3ba3QoxjyyrQ@coredump.intra.peff.net>
References: <X7wq3ba3QoxjyyrQ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "mktag" documentation to refer to the input hash as just
"hash", not "sha1". This command has supported SHA-256 for a while
now.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-mktag.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-mktag.txt b/Documentation/git-mktag.txt
index 11ce8e4bb4..3ba15072df 100644
--- a/Documentation/git-mktag.txt
+++ b/Documentation/git-mktag.txt
@@ -33,7 +33,7 @@ Tag Format
 A tag signature file, to be fed to this command's standard input,
 has a very simple fixed format: four lines of
 
-  object <sha1>
+  object <hash>
   type <typename>
   tag <tagname>
   tagger <tagger>
-- 
2.29.2.222.g5d2a92d10f8

