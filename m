Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED75C4332F
	for <git@archiver.kernel.org>; Fri, 30 Dec 2022 07:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234681AbiL3H2x (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Dec 2022 02:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234590AbiL3H2a (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Dec 2022 02:28:30 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1932618E02
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 23:28:29 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id m26-20020a05600c3b1a00b003d9811fcaafso8145809wms.5
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 23:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wvpFhOtK/oOS3AYoU8929IQ/iLt93v8v3gPlzGMwoY=;
        b=oUj15YMdgxBPbmWHMumizaRPbJH7mLffYsVdwdVCNMJH0LoiuzaLMAdNKeq01aYeBA
         Z1RIZK4gGgh3ziUzgZAO/nBMFfJnv3oAkcUzqyz8qy/jIZwMoVKCT8uQZtt+AMMdZCSc
         nsFgRhTyPBda1I1moK3Zy2r4/haseCfqGdEP80/vflBiq9a+fskFT7wofzx7pk1bcBC9
         Ci9BjfNAsuRj7tw2Q82S14VZdEBaxibVAvEdBF7K6O1OKAK4jP1/V48C75gTfaZhNkKM
         V2P+781VjCWefS3bWtDdmdYYG4ectgYihV6wHmsuMHNmUP+xEJUPupCsFjBo1no/+Yf0
         SoNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4wvpFhOtK/oOS3AYoU8929IQ/iLt93v8v3gPlzGMwoY=;
        b=05BKv/YEN9L7bEPaQjiV6WsP+xDZoArrU4PIC1yTVbQSid1MaFwEU34moks/wehskd
         2PM5hAYFBN5N2Rp/ukq3ojTIKezKtWVCOmWr0iknkpOgBbnfSXdG61/XK0AfoS1VZG5G
         GYcop62xrqy5IzQrVleI+yr0X2EO8QVra6oMJnwcmspyWCHh2wPt8Ay9fBZX7I8FIBJ3
         culPiDcuAnen/SzCipBf2qIykv3jpRzw6LewsCovXxAffvXZJSKfpQc6LSfqS5rA2KbK
         ZM/cQz7mfIBdgX/pr5tm1biQ49LfqwbgNDX/EOBX53NsxIgXMTBWusEiRU/EJHrM/eCK
         bUQQ==
X-Gm-Message-State: AFqh2krA0zTJggu8D0i7SiKy0FrCFPpryl8xeqM7a4f6Uzo+U7LTCFre
        yZk1nM8+ylhs9rlk1fEtzIqMZcsNqjOBjQ==
X-Google-Smtp-Source: AMrXdXu8bpJl98bSGj8b4IthWW4/kygQKiYj4gV9nlgLglsTbmUSxmfTrvwC7R1WqWrjUJWfIOUIOQ==
X-Received: by 2002:a05:600c:c07:b0:3d9:73fe:96f8 with SMTP id fm7-20020a05600c0c0700b003d973fe96f8mr14213308wmb.32.1672385308352;
        Thu, 29 Dec 2022 23:28:28 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v13-20020a05600c444d00b003d998412db6sm6526449wmn.28.2022.12.29.23.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 23:28:27 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 10/10] commit.c: free() revs.commit in get_fork_point()
Date:   Fri, 30 Dec 2022 08:28:15 +0100
Message-Id: <patch-10.10-eb3678b4667-20221230T071741Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1153.g589e4efe9dc
In-Reply-To: <cover-00.10-00000000000-20221230T071741Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221230T071741Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak that's been with us since d96855ff517 (merge-base:
teach "--fork-point" mode, 2013-10-23).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 commit.c                       | 1 +
 t/t3431-rebase-fork-point.sh   | 1 +
 t/t3432-rebase-fast-forward.sh | 1 +
 3 files changed, 3 insertions(+)

diff --git a/commit.c b/commit.c
index d00780bee5f..8174c927383 100644
--- a/commit.c
+++ b/commit.c
@@ -1022,6 +1022,7 @@ struct commit *get_fork_point(const char *refname, struct commit *commit)
 	ret = bases->item;
 
 cleanup_return:
+	free(revs.commit);
 	free_commit_list(bases);
 	free(full_refname);
 	return ret;
diff --git a/t/t3431-rebase-fork-point.sh b/t/t3431-rebase-fork-point.sh
index 70e81363569..4bfc779bb87 100755
--- a/t/t3431-rebase-fork-point.sh
+++ b/t/t3431-rebase-fork-point.sh
@@ -8,6 +8,7 @@ test_description='git rebase --fork-point test'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # A---B---D---E    (main)
diff --git a/t/t3432-rebase-fast-forward.sh b/t/t3432-rebase-fast-forward.sh
index 5086e14c022..7f1a5dd3deb 100755
--- a/t/t3432-rebase-fast-forward.sh
+++ b/t/t3432-rebase-fast-forward.sh
@@ -8,6 +8,7 @@ test_description='ensure rebase fast-forwards commits when possible'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
-- 
2.39.0.1153.g589e4efe9dc

