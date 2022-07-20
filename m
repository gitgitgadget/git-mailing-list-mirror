Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01A1C43334
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 21:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbiGTVXD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 17:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbiGTVWc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 17:22:32 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643F75FACF
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 14:22:25 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id d16so27838740wrv.10
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 14:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4hEB3FOkLUbhW9Cw6NCE4gIBdSUd92SP/2BOF7FodlE=;
        b=lRwmg8QSP/YUC4OWl40p4TLb8iTOD8xd9LoTg3dhb9HdclsIrAl+PTDinf8UJ+pWGs
         P2cY2VSpJ97zrhXL/C5W0bP1WvWiWzjIydP8n+fioAqBMwzO2aJFrxvsl2BGjudQlyBt
         ArA2WwSu60bsDF+Xk51mAYOPL6ZZhVfY+Ro91LYxE7WoCYF80Emqw1aKFEyZE6PaFROv
         dIxhldAAeYtKEmT4iE1qS7aNEh+JjOsf0nN+sAm7l/b9Hua6PzQ5mGYEN7BYSo0whffm
         vgsF3p3hSSFHTvykqdU9ytOp8AIRQsoF5VpYwh84LcbmKAZbjEpLhk6ccEVtlX4UizKK
         T9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4hEB3FOkLUbhW9Cw6NCE4gIBdSUd92SP/2BOF7FodlE=;
        b=YICeahO65TDEleRVE7F3uPM/zzeSR1dePOfq5CweyBIZtDJoWHXj/NtX+/bcgm65ZN
         L/pFdwVmTob4Ph0Gq4FG8wAfJUAZ1AApGUHmd/DIitpCW7gh6FObkxWU3u+lppaC6dbC
         fASVq8tbAbBGfXcmm3Dqh6oo2SeemHrQ8qMi3d3QsHjKvcNyErlslF8OY/PjIkfB3Axc
         aqWDzDgSTO8fS8FS9rBc9bysw8WO5lrYVW1sVz3yIfHzyukBTD6k71RmG6mGNRZKjZ9J
         mezaT24Ctjanus1b1i8G9eqYcSWsSOsBujIpWLPorLmyB5xNLmARh6iDB/BW0TsJ/iUZ
         0oBQ==
X-Gm-Message-State: AJIora+H5ZatBbksNF9Clla3X2mHnBIE3pUTLTQ8PWnsTzZ4j+vDtSuW
        AzM1BbSNgwosUv+GBMsndnvCUoFqyTWH2A==
X-Google-Smtp-Source: AGRyM1uQF0V/laWjwrmbNvE32jQ5voZTz1a0Ls39hcV/8bCkAd0nHHExF9ECLwKFMGZifeZQIHadZA==
X-Received: by 2002:adf:ef49:0:b0:21e:4688:5c66 with SMTP id c9-20020adfef49000000b0021e46885c66mr5173254wrp.145.1658352143640;
        Wed, 20 Jul 2022 14:22:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c024800b003a0375c4f73sm3605441wmj.44.2022.07.20.14.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 14:22:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 13/14] upload-pack: fix a memory leak in create_pack_file()
Date:   Wed, 20 Jul 2022 23:21:51 +0200
Message-Id: <patch-v2-13.14-07b6572aea9-20220720T211221Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1064.gc96144cf387
In-Reply-To: <cover-v2-00.14-00000000000-20220720T211221Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220719T205710Z-avarab@gmail.com> <cover-v2-00.14-00000000000-20220720T211221Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak that's been reported by some versions of "gcc" since
"output_state" became malloc'd in 55a9651d26a (upload-pack.c: increase
output buffer size, 2021-12-14).

In e75d2f7f734 (revisions API: have release_revisions() release
"filter", 2022-04-13) it was correctly marked as leak-free, the only
path through this function that doesn't reach the free(output_state)
is if we "goto fail", and that will invoke "die()".

Such leaks are not included with SANITIZE=leak (but e.g. valgrind will
still report them), but under some gcc optimization (I have not been
able to reproduce it with "clang") we'll report a leak here
anyway. E.g. gcc v12 with "-O2" and above will trigger it, but not
clang v13 with any "-On".

The GitHub CI would also run into this leak if the "linux-leaks" job
was made to run with "GIT_TEST_SANITIZE_LEAK_LOG=true".

See [1] for a past case where gcc had similar trouble analyzing leaks
involving a die() invocation in the function.

1. https://lore.kernel.org/git/patch-v3-5.6-9a44204c4c9-20211022T175227Z-avarab@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1060-object-corruption.sh | 1 +
 upload-pack.c                | 1 +
 2 files changed, 2 insertions(+)

diff --git a/t/t1060-object-corruption.sh b/t/t1060-object-corruption.sh
index e8a58b15897..5b8e47e346c 100755
--- a/t/t1060-object-corruption.sh
+++ b/t/t1060-object-corruption.sh
@@ -2,6 +2,7 @@
 
 test_description='see how we handle various forms of corruption'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # convert "1234abcd" to ".git/objects/12/34abcd"
diff --git a/upload-pack.c b/upload-pack.c
index 3a851b36066..b3884d3f4de 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -455,6 +455,7 @@ static void create_pack_file(struct upload_pack_data *pack_data,
 	return;
 
  fail:
+	free(output_state);
 	send_client_data(3, abort_msg, sizeof(abort_msg),
 			 pack_data->use_sideband);
 	die("git upload-pack: %s", abort_msg);
-- 
2.37.1.1064.gc96144cf387

