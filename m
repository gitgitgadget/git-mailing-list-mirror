Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311CAC19425
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 20:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1E6323C43
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 20:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387952AbgLIUCm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 15:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388060AbgLIUCj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 15:02:39 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25DFC061793
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 12:01:58 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id r7so3087279wrc.5
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 12:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TE/H6ocKosx2Jp2qItIeJhggW3gbgKvO2QtcAZMksw0=;
        b=fs968EATjmnF0Df/PjinjtHqCpZMuS2AuihA8sex99G4UOt/8JmXX4WBBE4vkMcAEU
         7/rfcrg2jCOXDVoU195qKCbAr4AHER9CNsq9BMSpKV3d4f+L8aRN5IZn9L7KinCFB5CJ
         h2U0ntr9gSeACVSj/pIsZWfmRl81HVC6584lrUMCp/dx7EtcTkb1krq6PcnB/Wsx0PAe
         aEppmZ6sPQIa84IWYiH5Diy9ZVdqFff/I5aKq2IpLYPOwJv68iEKwcg19NIPiT8OXK8q
         dz9hfs2/ZN+3tJvCSG/ifu7OsgOmF0zi9Mam5fZ5iRPirzkkU0foyfEwIGBtwclhb9iK
         /ECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TE/H6ocKosx2Jp2qItIeJhggW3gbgKvO2QtcAZMksw0=;
        b=L18Xw98jf0b+4ywY8cgvsytyxjsfTqbp5BfjQghwj4S/N2Sw7+yS0A9Ga9ETrCJdqw
         SvIPWXCzg98dFQsL5FNwnrxmG0LAXGhI37Lvzjkly0j0l/E6m51l1235nVqtulSL4dZd
         NQ/GRIS5ImLgQ0zdkcd3i4Tiy1wM0YBvWWajnLzfNHNMXe5AOC29JfAdE0WZGqRx3s+Y
         9DvoFZTmeiIeqXsfuEimpXnJ51ytc4IgxU00c3g8BQhi1afv1FbztddP38Tvj018on6r
         O9cE91f9gGgtP5RQY33PLj2OXE7QHhp5gF4LI/fLEsIB9x0oUh4YpejMtVmuyaEDCVyk
         Nc9A==
X-Gm-Message-State: AOAM531t9wyCYq1iPvHsE9DVYjpKI/GvWydIoB/ysrajxnSw0kDuE2Ak
        L9rMuYVoUd7kuUyw81bJbwl0exUtzPeXgQ==
X-Google-Smtp-Source: ABdhPJz1gQ5LJBO9h74uweUbszBaOWGBXW8oX/6qWEpD68TI8FJPm0k1kx/ZkGCm+EbhHWmWziYAxA==
X-Received: by 2002:adf:c40e:: with SMTP id v14mr4469948wrf.163.1607544117568;
        Wed, 09 Dec 2020 12:01:57 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 34sm5762128wrh.78.2020.12.09.12.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 12:01:56 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 01/10] mktag doc: say <hash> not <sha1>
Date:   Wed,  9 Dec 2020 21:01:31 +0100
Message-Id: <20201209200140.29425-2-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201126222257.5629-1-avarab@gmail.com>
References: <20201126222257.5629-1-avarab@gmail.com>
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
index fa6a7561236..a158428eb9f 100644
--- a/Documentation/git-mktag.txt
+++ b/Documentation/git-mktag.txt
@@ -23,7 +23,7 @@ Tag Format
 A tag signature file, to be fed to this command's standard input,
 has a very simple fixed format: four lines of
 
-  object <sha1>
+  object <hash>
   type <typename>
   tag <tagname>
   tagger <tagger>
-- 
2.29.2.222.g5d2a92d10f8

