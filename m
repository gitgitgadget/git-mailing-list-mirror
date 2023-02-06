Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537B9C05027
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 19:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjBFTJO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 14:09:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjBFTJF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 14:09:05 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2CC2CC7C
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 11:08:54 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id bg26so9431249wmb.0
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 11:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ck9bc+uHj9NGRA8qszXQ7UP5VhmZcGVCNviift5n4BY=;
        b=Res16T5yIgmzpwuKzxa6P5vHxtfu4cdsm/jKyglGBnkw4I3WGE0aQGdZg7uahoquPj
         Hdzc8DUuAjllv7zJsNDg8Vld2mZ5Ty9EykwVXH3p6jq9Odtt7+j1g1/XzqQ7Wyo+gm5/
         Wcjh1NBACY++kIIDeRZ4EqKiukkGnWgtUo5pVf/k7x0Wbm5EDnfS3hDmP7nrOYDCYZxL
         06+5QQ4sf0HNYFrIjOd9/nyAUDt1j/sF3Td6RqxGoVBnTlBX2tzI0Qql77bKRPKhSRvI
         IDJk6MDIDPV33nCVzud6NGl3RUb/jjolbsABHtSwZHD4Slg74x2wkXZePQ5xzS6GslPn
         RkMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ck9bc+uHj9NGRA8qszXQ7UP5VhmZcGVCNviift5n4BY=;
        b=2R2R6zP1YoNxpQOm4oYLoS6d++2OMRIqqTBiSEZyE8xJ7OJ4beRQWipq3tyZgEbMd8
         R2A0gWzAYeUsCp9Il+LPHIZseHz0GlYF2Qqa7Vd54PHemy7s72Dmz/fkPHFuzmQncPki
         6LakcWuHP9rh8cZr9iVAQB4UaEeAHJe+VFYSwz9k6Uh2laiB6mK8ACuSI5gP3ZBfsAis
         lY03FH3xUGWMtlu6PVXBfEAKSxsHv1NtskZgbPZ2w3Yccc9C+Sb9lhGR8b4x6l2tKkK9
         FCcJ37eJRp0198i1IPdSXJf4mlvgJzW/jQJbqczx3YdfdKdb/xuU31Q4aqz98yaZ/Adv
         4euQ==
X-Gm-Message-State: AO0yUKXwWvJJEyW7mdJZGWEKFiUn7eYJTY+fAFcFekuQ/CwWABoUJaT/
        Z6pzg+rOBZfOpNCSY4c7ZYAuifZmQG5VGAts
X-Google-Smtp-Source: AK7set+ZIzc/MRGEcHMQwBbAbYhRIKR9oBFc691v8ay8I/l+gwCEuLzXj2i8RREK/hpW+kFE3sJjmA==
X-Received: by 2002:a05:600c:4da4:b0:3df:ea09:fcc9 with SMTP id v36-20020a05600c4da400b003dfea09fcc9mr449106wmp.7.1675710532844;
        Mon, 06 Feb 2023 11:08:52 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p2-20020a05600c358200b003dc4ecfc4d7sm12538595wmq.29.2023.02.06.11.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 11:08:52 -0800 (PST)
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
Subject: [PATCH v4 8/8] commit.c: free() revs.commit in get_fork_point()
Date:   Mon,  6 Feb 2023 20:08:13 +0100
Message-Id: <patch-v4-8.8-6ab2edcc135-20230206T190346Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1425.ge02fe682bd8
In-Reply-To: <cover-v4-0.8-00000000000-20230206T190346Z-avarab@gmail.com>
References: <patch-v3-7.8-ee8262ab22a-20230118T160600Z-avarab@gmail.com> <cover-v4-0.8-00000000000-20230206T190346Z-avarab@gmail.com>
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
index 14538a811ae..e433c33bb01 100644
--- a/commit.c
+++ b/commit.c
@@ -1033,6 +1033,7 @@ struct commit *get_fork_point(const char *refname, struct commit *commit)
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
2.39.1.1425.ge02fe682bd8

