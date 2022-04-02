Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B502C433EF
	for <git@archiver.kernel.org>; Sat,  2 Apr 2022 10:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354473AbiDBKvm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Apr 2022 06:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344887AbiDBKvk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Apr 2022 06:51:40 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC9F1403E9
        for <git@vger.kernel.org>; Sat,  2 Apr 2022 03:49:48 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id dr20so10660904ejc.6
        for <git@vger.kernel.org>; Sat, 02 Apr 2022 03:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5hNgQZWH9j4sG11nOp+vgPhVeF0EuynGEMt/Kv8z4JA=;
        b=ixfT9p3uhfdHAH7dltROKJqHD8eUqr6Cun+AZYuiYyNfLVHKyd/5pNjA+vs9lkiie+
         81rG32fu/0Y8rnNR3y8e8FIw7wjleQf+4ZkVE7M1S0zVh80+MK8Gu7qdBPwSk6B/NqZt
         BO+MVl4YUnUF5rPbMQuiXL5A8knQU5nDAMcoXNRhKDGo2oQzz99AvagpEWZizAGr+Wll
         777fWCUsHWgLSS+h5zVKXAocqlklS8Rt9bKWHACfTXitAphHMXl0SwdV5+pBZyjZuoiy
         2Gafy8ytwGkQoucZXI2YpuIo1MPCk7fMC3xO+7WwIffMaMfxuMvAsadICHpFwPzqhiFh
         by0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5hNgQZWH9j4sG11nOp+vgPhVeF0EuynGEMt/Kv8z4JA=;
        b=dGMMz0jz/bM3Jee8srStDUHY8iNOFRe9xdTS+9HHXjvyTmmA5c42SDqA6HAYipBmIy
         5ElUbeSv+inw4oJJVvXiuyfHGL1SCO2D7swVRS1fqz/pdluHuw2XRSYCEjFFIFza0mRy
         3uMmRzSqrubO5kU3IB6Jd3inlrMggxW9QPDsyMTuXN4TwY6OHII+wjyX6SoPTodWNfmE
         u5/prWeFs/W12OFKOc8yHs7gVGA2quuYSVrt3eIUiKiKFRLwyjxTOmJPhywdzAoJvx14
         noMXvyZEpZaOCEvFiw7FzD4mUHPwGPTjnLgJnktr5KFryakB/PKZb3xrNiNdlJXReXs0
         YKzg==
X-Gm-Message-State: AOAM530VwAgE/KBfnQlmA3MdZxoP4Z1VQUPkfqNx7DzpSQN73kCLf727
        mcfLNgun02IEoXj7NBJqbhq84g7X+YaWAQ==
X-Google-Smtp-Source: ABdhPJydnXqYZ0YxtAA1uWttFLlQNYn3dbKUfpZdNNUE4YpW904grA/u7O8qcEV3Jfo9RXV4y2+q7Q==
X-Received: by 2002:a17:907:3f03:b0:6df:b04b:8712 with SMTP id hq3-20020a1709073f0300b006dfb04b8712mr3474609ejc.290.1648896587016;
        Sat, 02 Apr 2022 03:49:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r23-20020a056402235700b00419171bc571sm2366137eda.59.2022.04.02.03.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 03:49:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 02/27] blame: use "goto cleanup" for cleanup_scoreboard()
Date:   Sat,  2 Apr 2022 12:49:16 +0200
Message-Id: <patch-v5-02.27-de2e08a14e6-20220402T102002Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1584.g2aeb20a6519
In-Reply-To: <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
References: <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com> <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend a freeing pattern added in 0906ac2b54b (blame: use changed-path
Bloom filters, 2020-04-16) to use a "goto cleanup", so that we can be
sure that we call cleanup_scoreboard().

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/blame.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 8d15b68afc9..885b381ab83 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1167,7 +1167,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	if (!incremental)
 		setup_pager();
 	else
-		return 0;
+		goto cleanup;
 
 	blame_sort_final(&sb);
 
@@ -1201,6 +1201,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		printf("num commits: %d\n", sb.num_commits);
 	}
 
+cleanup:
 	cleanup_scoreboard(&sb);
 	return 0;
 }
-- 
2.35.1.1585.gd85f8dcb745

