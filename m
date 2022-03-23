Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294F2C433FE
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 20:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbiCWUeE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 16:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344689AbiCWUeA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 16:34:00 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09858C7FB
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:32:29 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id u16so3787505wru.4
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y/ce6YCTGL3GLaaeAGlQViqeZzY9a/Dk590eiWxKNkw=;
        b=XH3hv5kV9bt9HE454GWLZVebc0+j9fvsJfFA+nO9+Vb4mhXDrGHyVvpx1lsyFEZuvj
         afSUm8vqAN9PKTrQfBo3raNnkRT60OJ2t6/THP4kD2eaOFpxk2/KkvnflY8StA5njnrQ
         zKHyZ+VXKnmF+20H+KilfFOBfTO+4WndH/ObXM1a9WJOSr/Z79WeQVQA/M+8vPFnxCsl
         04wM8hp0CZa2rugiRQm/20a8TU2EWNznQZ6sDV1JQWn3SoJ3RL280nJ3GWCzsNLSgNmj
         sfQ+vfeOzI2KvV0CdRFFDoZczjFhB4RXg80KtGa6rQmBE4d7Nv9Du3O4jSSbAzhk23Fs
         eQ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y/ce6YCTGL3GLaaeAGlQViqeZzY9a/Dk590eiWxKNkw=;
        b=oVd7sE4D0iG6fY4p57U3Rvjo0NRGoWUEBq0/IsjBxMM5pywEL7KNkTmB9X3WP2Xv/h
         A35Ggf56WpJCqAutErjcOjkCyNa+hGG9czfXciYW6rrW6DZhtau1W6YVwuYpVtPHEnj4
         d2BP7iYCtwltBBaI2SFZS1gv/jQ8BDoCXbh6x8vghgjsWuhmiIAyUu1gNCt9fos3+lP3
         TE89uEwTdLdSXlL5hL+RwQLjhM7qCqXTjECncB77Ymuo27xyWn1L4oBb37UB9MmbX6Fw
         KZiRyWGgIUPcdbvR1X8uExPoZdW+heU1+mMhPvDcvmKVODvoH6nRk2pdHKBOaQ0sM7tn
         MKhA==
X-Gm-Message-State: AOAM532ED9MSNcDzHu24ScARIaRk9RRJTiixhmlSyO8VrjGK1HDqp9RP
        4jlTrrhPPumG0SEo87OpXZaIRDuEXdrdSg==
X-Google-Smtp-Source: ABdhPJz4uyQCNJmNiRtNJt1w1aZsayzWiGhgI2kMxo1lv3F/srK24dt0tthS57vtj7vNQwWydqVPHQ==
X-Received: by 2002:a5d:6542:0:b0:203:da90:969f with SMTP id z2-20020a5d6542000000b00203da90969fmr1542449wrv.479.1648067548362;
        Wed, 23 Mar 2022 13:32:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u12-20020a5d6dac000000b00204119d37d0sm849843wrs.26.2022.03.23.13.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 13:32:27 -0700 (PDT)
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
Subject: [PATCH v2 02/27] blame: use "goto cleanup" for cleanup_scoreboard()
Date:   Wed, 23 Mar 2022 21:31:52 +0100
Message-Id: <patch-v2-02.27-77e7c2c321e-20220323T203149Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1452.ga7cfc89151f
In-Reply-To: <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com> <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend a freeing pattern added in 0906ac2b54b (blame: use changed-path
Bloom filters, 2020-04-16) to use a "goto cleanup", so that we can be
sure that we call cleanup_scoreboard().

This change is needed so that a subsequent addition of a
release_revisions() doesn't solve this unrelated issue while it's at
it.

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
2.35.1.1452.ga7cfc89151f

