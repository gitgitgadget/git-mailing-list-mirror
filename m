Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4ABC433FE
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 01:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352242AbiCaBN7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 21:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiCaBNy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 21:13:54 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4975B66222
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:12:08 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id w21so26980827wra.2
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XkcPvDWUxsykEX2LOIa6nQp5/zm9nf0SZV3Q7UbyxXo=;
        b=HX+/oJ8XUWBPehQFChl+Zd5oQ6vEVzRYRwiSMkl2quQuXL2e+y9X5ba2Lw4eAuYdw6
         pWYzUYye6uGoocRwBVgOoh9jJXvFGe+ETM1onsvJsLeyiQS4eXfUoSZ/J18lmGYx61gL
         Rkc38HyLfUydtbs2XkgMIm1XBnHUzHW2RwA/WrZV5vTAOqoKTB8w3RdW5v6dTxvczqRZ
         d2KXKF6zilu6yQS+UcgYjD+6QA8hQocQM9omdVHIAOTp933dNE9rtdDnJhBd2mC10qDq
         NAUu9Xyv6o2l0T9Dd9VmTB+X27VG7vRlkrsxeFQU1eC3SgDh3uVYvikl0fZP0Zxekx43
         gqog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XkcPvDWUxsykEX2LOIa6nQp5/zm9nf0SZV3Q7UbyxXo=;
        b=vjIx3nwnR0fPDFi8K7WG0Tt9PBShg2Hk5TSzK9d3LfpANsmFqCviIC328Z/hR4aN0l
         VCm4yccL2eL8NkJ/KaRnMIdF45prWrjj2JQBD6eoHedZ7ntT+dj8J53R8A/3kYQXpyJ2
         Q7QGdb3kDWHNh2+U6gfLL+uOoVeCzSjCvjB3AXSon4t6OQOSrFCXpIJlTGIYvJG2wBl1
         u/GVW+5nHuRjT0ckWBtWPMsMrTMay8w5P0RykAuzQECPMdWlFHX97nQ0KMPI1ifSo/UF
         xisQ7zofsXm69eJ46ETqUQm7e/c5qOEcoulZe7vj3uocYD0PQu61eSLOzm7ArtYdMuqr
         hdBg==
X-Gm-Message-State: AOAM531r9ieK2JIySNQexdoEV3ab0pzOzP+yuq2jW36LiFOm2OR9LTlH
        7875Spvv5Qc5YxKJomjlhQscly9KLbSxaw==
X-Google-Smtp-Source: ABdhPJyx2cs/d1ZfKC/EPalo7Z1EzB2jC2LJeQxsqJg0tjw7uS4I74c02Z4vKMTVLJY2KoHrpIWo4Q==
X-Received: by 2002:a5d:47cf:0:b0:203:edf6:480a with SMTP id o15-20020a5d47cf000000b00203edf6480amr1987390wrc.415.1648689126691;
        Wed, 30 Mar 2022 18:12:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c26cb00b0037ff53511f2sm5789218wmv.31.2022.03.30.18.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 18:12:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 01/27] t/helper/test-fast-rebase.c: don't leak "struct strbuf"
Date:   Thu, 31 Mar 2022 03:11:06 +0200
Message-Id: <patch-v4-01.27-b99a07f98ee-20220331T005325Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1557.g4e3e9cdb5e0
In-Reply-To: <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
References: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com> <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak that's been with us since f9500261e0a (fast-rebase:
write conflict state to working tree, index, and HEAD, 2021-05-20)
changed this code to move these strbuf_release() into an if/else
block.

We'll also add to "reflog_msg" in the "else" arm of the "if" block
being modified here, and we'll append to "branch_msg" in both
cases. But after f9500261e0a only the "if" block would free these two
"struct strbuf".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-fast-rebase.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/helper/test-fast-rebase.c b/t/helper/test-fast-rebase.c
index fc2d4609043..993b90eaedd 100644
--- a/t/helper/test-fast-rebase.c
+++ b/t/helper/test-fast-rebase.c
@@ -201,8 +201,6 @@ int cmd__fast_rebase(int argc, const char **argv)
 		}
 		if (create_symref("HEAD", branch_name.buf, reflog_msg.buf) < 0)
 			die(_("unable to update HEAD"));
-		strbuf_release(&reflog_msg);
-		strbuf_release(&branch_name);
 
 		prime_cache_tree(the_repository, the_repository->index,
 				 result.tree);
@@ -221,5 +219,8 @@ int cmd__fast_rebase(int argc, const char **argv)
 	if (write_locked_index(&the_index, &lock,
 			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 		die(_("unable to write %s"), get_index_file());
+
+	strbuf_release(&reflog_msg);
+	strbuf_release(&branch_name);
 	return (result.clean == 0);
 }
-- 
2.35.1.1557.g4e3e9cdb5e0

