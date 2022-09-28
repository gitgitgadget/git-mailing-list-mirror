Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6F8C04A95
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 08:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbiI1Im3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 04:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbiI1IkS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 04:40:18 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A8AA4B05
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:40:09 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id h7so6227992wru.10
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=BbKZBYlgiToDKYzatxetFwmTXt7W5QphZuuJXBGs5EE=;
        b=UxT7UcVB/LISJ+oycacb6TCR834tppjgxgsPdvz0z/LmWmPMhMBOEu/vlx5m62EgKB
         pH/L91VthEGuFjpvB/SVSOHMgp1QdcDb7OXNzfYC1akVMKGLO8GSRxDG+6isCEI7PbLJ
         0YEXeprt+KaCnRD37ZUIrvj7IJuxAnCBENIW08s1/Ppyr1U5VKGlRBpx4xFKQwHSafK2
         /htd7n59K12CWSDIyDoez/caFR9+GPH61ADnkc090wfoS23v2XBAdVJ9V8KHPGbJTpHn
         DS+PIytcgPjhKiSt0dfnOR3HTBdmdEEyM+vAO49KHRGYuQyaQX8NguUGoaX2+U+ZZtc1
         vFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=BbKZBYlgiToDKYzatxetFwmTXt7W5QphZuuJXBGs5EE=;
        b=L8jH36Yc/8eK82aeo+ZPukPKWg6l1o3TVYEvmY0ltFg60JHt685bpgNK/BFCfZcb6j
         +ZRd8l1kJ4A+ImbhNu+n5qECJy6tsKtIiRGYNaghO+SgM5H3bALuQEubMv8M6yqO7iJK
         qfNxyuqjL0mjRRSTEXTyvXC2I/g5Pcrj/sUVBT3VtYYEtm+zgcIN+gGSZO0KVrCkejE3
         xLJdL4MHukRqJHaNXq0RuwexnZTQfl+s89bM34ZTlYnTMfFCfMYpvRN13ekkjw0emSwf
         pCDyE5mqK6k3B+j36F7VUJvntfP2LNa/cOlvWbvyIhqqzxMzU0vVsLRsgw/ipXfmgLA2
         XnHg==
X-Gm-Message-State: ACrzQf3IsoWoficW6i/vPoldEFlaezqLwKSnORoUKxR8AzUirxGw+AW1
        k3WBx/6OP4qRddvEcmm8gViVSUGl0dx9rA==
X-Google-Smtp-Source: AMsMyM63UlZVTVr6iTc2aLjwuk9KphHs11REI0HUXWmLeqRvG0jgtZ/nRdBrUH/Si489kh0eAY1c7g==
X-Received: by 2002:adf:9cd0:0:b0:22a:7cea:d3c3 with SMTP id h16-20020adf9cd0000000b0022a7cead3c3mr20811381wre.196.1664354407265;
        Wed, 28 Sep 2022 01:40:07 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c229a00b003b31fc77407sm1075026wmf.30.2022.09.28.01.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 01:40:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 29/35] doc txt & -h consistency: make "diff-tree" consistent
Date:   Wed, 28 Sep 2022 10:39:24 +0200
Message-Id: <patch-v2-29.35-a57b00648dc-20220928T082458Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.925.gb61c5ccd7da
In-Reply-To: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com> <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the "diff-tree -h" output consistent with the *.txt version.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/diff-tree.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 23f58702fa0..85e8c81e594 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -83,8 +83,9 @@ static int diff_tree_stdin(char *line)
 }
 
 static const char diff_tree_usage[] =
-"git diff-tree [--stdin] [-m] [-c | --cc] [-s] [-v] [--pretty] [-t] [-r] [--root] "
-"[<common-diff-options>] <tree-ish> [<tree-ish>] [<path>...]\n"
+"git diff-tree [--stdin] [-m] [-s] [-v] [--no-commit-id] [--pretty]\n"
+"              [-t] [-r] [-c | --cc] [--combined-all-paths] [--root] [--merge-base]\n"
+"              [<common-diff-options>] <tree-ish> [<tree-ish>] [<path>...]\n"
 "\n"
 "  -r            diff recursively\n"
 "  -c            show combined diff for merge commits\n"
-- 
2.38.0.rc1.925.gb61c5ccd7da

