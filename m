Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862D4C4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 18:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234739AbiKHSS0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 13:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234470AbiKHSSN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 13:18:13 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C675F22BC9
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 10:18:02 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id f27so40819331eje.1
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 10:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+vwNtSbMRMLYTfgYAoNqjxm9O/jfqzRIsWrlqVi4Ws=;
        b=IQNcD1vjdlfUz1SqLctwzcK969UE0lPqArA/jzRvgn7uNb+yDSiKgj7OCZBie3Kddw
         cP6dRKEBFdaJ5iveYFvjFTPysW7As6n/vwo8hBkRvI8hs/BGwT8tMQ51I9EFZBa75fEI
         9SLmXbiqYSb+85So1qVGXbvvYs0Uu10qcPqjn6AZjyVpVILz5nr62XbgxHwWkarf4kSm
         /hCIAUIBFMi5O33GRC3Uf5ArNNLJ1r4HqPdPlKpN1zM2avCZxy7UdS8Q76ZNe/4luUTX
         mg1wJoVQ2xop8wuN4iNNLyYpUAoyiHXT0ab2scg7WLCHDM44cmqR8EdPe7nlY0/M1YrP
         AKGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8+vwNtSbMRMLYTfgYAoNqjxm9O/jfqzRIsWrlqVi4Ws=;
        b=4KQ+nzb0jtasMKbJh9X6x1ov8BhG+Z4V+oAbCVdaTPV0yeZ3K4rM3vNZKJA5laRR99
         HpCpfQ07+6osYxpntuYKzcINF7rcbvRGzaIxRx5WWaNc6+zyhhGIjcUWZa3jiYeie4ri
         gFTTci/YtPzOig6XaWvMzhCV8JLMSn/BNu0w/jCe/2SDxCYcKk4KHCFeKDJ9MMXvd34o
         yfV2bW9coHDf6lFZKgq+5JuvOseCW+9hwB1kEo6y24Cay8+njlk1+a8INP9f7kOuwrF5
         MNNwCUTqv8KI6cAPOVpNepME6KMQdPnoazpaI3FEimcCT/po7tOI25rFysjpS8Oo7z3h
         +FjQ==
X-Gm-Message-State: ACrzQf3p87c1m5roGOXSsV2LC5gLamkQeZ1dWicJPVtC7RHxppUra3P7
        itsU3DNPrd7Uo/2QdR7L5MSDrNBPRTCRew==
X-Google-Smtp-Source: AMsMyM49WaIqDTOE73FXUG6Nf0I8zxPsLQh4FNsJ1iZ/R4zgwFLdubOsanLR2HRFivNS1kJQZ5LjTw==
X-Received: by 2002:a17:906:5a5b:b0:7a6:cbc7:4ca1 with SMTP id my27-20020a1709065a5b00b007a6cbc74ca1mr54449119ejc.544.1667931480985;
        Tue, 08 Nov 2022 10:18:00 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t18-20020a1709063e5200b007a62215eb4esm4994131eji.16.2022.11.08.10.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 10:18:00 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 09/15] ls-files: fix a --with-tree memory leak
Date:   Tue,  8 Nov 2022 19:17:45 +0100
Message-Id: <patch-v2-09.15-46809d9be80-20221108T172650Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1467.g709fbdff1a9
In-Reply-To: <cover-v2-00.15-00000000000-20221108T172650Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com> <cover-v2-00.15-00000000000-20221108T172650Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak in overlay_tree_on_index(), we need to
clear_pathspec() at some point, which might as well be after the last
time we use it in the function.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/ls-files.c            | 1 +
 t/t3060-ls-files-with-tree.sh | 2 ++
 t/t9148-git-svn-propset.sh    | 1 -
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 4cf8a236483..a03b559ecaa 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -613,6 +613,7 @@ void overlay_tree_on_index(struct index_state *istate,
 	if (!fn)
 		fn = read_one_entry_quick;
 	err = read_tree(the_repository, tree, &pathspec, fn, istate);
+	clear_pathspec(&pathspec);
 	if (err)
 		die("unable to read tree entries %s", tree_name);
 
diff --git a/t/t3060-ls-files-with-tree.sh b/t/t3060-ls-files-with-tree.sh
index 52f76f7b57f..c4a72ae4462 100755
--- a/t/t3060-ls-files-with-tree.sh
+++ b/t/t3060-ls-files-with-tree.sh
@@ -8,6 +8,8 @@ test_description='git ls-files test (--with-tree).
 This test runs git ls-files --with-tree and in particular in
 a scenario known to trigger a crash with some versions of git.
 '
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t9148-git-svn-propset.sh b/t/t9148-git-svn-propset.sh
index 6cc76a07b39..aebb28995e5 100755
--- a/t/t9148-git-svn-propset.sh
+++ b/t/t9148-git-svn-propset.sh
@@ -5,7 +5,6 @@
 
 test_description='git svn propset tests'
 
-TEST_FAILS_SANITIZE_LEAK=true
 . ./lib-git-svn.sh
 
 test_expect_success 'setup propset via import' '
-- 
2.38.0.1467.g709fbdff1a9

