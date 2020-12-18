Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FCFC4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 21:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C151B23B8C
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 21:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgLRVLu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 16:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgLRVLt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 16:11:49 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389F4C0617A7
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 13:10:45 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id p126so4297664oif.7
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 13:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jy8+czBJC1KsHub/3/U21d5o/JdFjS/drfS0NNOEsUU=;
        b=kfRPHhAp4vEBONim3AFb3xAlP3dNyvI/4DhcVyXYHJe5SO8FoqtKlEeW1Baz+jY/x8
         Kahlx6z0mmmatwHZZ/5+6NU3vefXQCIWSp3EFgkjN9p1dLRIiVUdMttLiXQto4RerzAG
         1chxw4DmV2Y7y5h1DJgUYYHayb2TKTYsLCYQeHDYNGu/Zg8maBaV6lVuC4VKyYeRbumi
         pAISihLSVYe2fneRLP4JEo6iFEPSk8uOdUEmrFtbN0eR+vRBbDAZc68fHFzKWIJgRRpv
         kooNZAxOP0ioATxvXZFn6lmSCcLyLGv3V8Xht1ZOmR/+10te9nk723VL/GavkAZLJl5S
         kmoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jy8+czBJC1KsHub/3/U21d5o/JdFjS/drfS0NNOEsUU=;
        b=SJvkiO0M6/0Zivkb3hfzkNihz+H9mV4bvMdCdnXMOr0PvL/scJWworOZ21YmtOb/UA
         BZxFblzz81dEavIwWt+0iU5z69CfGEb0qz3ZVBhc0AO3xYWE4yzeuOwd9WHNjZUJIJCb
         pM8GEOojtTQDS7rSxfalGQWqkOcoKREO0xkbTNFXEfd3L5BV7Nk7nabbFcLIN/sKwPME
         E+llsDHiaO4LmO8dFZwkx0fZR9E9upBTklA9SYYde8/nh2p96Y8EtSR7TEa/OoCMx1o1
         EEVO7H6SMthURQlJlW0/9lbtfXw01qvVDLRfVVdj6Wlc76ct9HNH3nzlSU3f2/RQwY58
         DxUQ==
X-Gm-Message-State: AOAM530hwnR3sLdHrNjwI+BMD0L0CzzVdbnbgqPYb6rDAoS3Vp7l0Y3h
        pEiI73hJRedh3y1RkfAmF6Q8iw0ojXh0vg==
X-Google-Smtp-Source: ABdhPJwlH9PArtrMbhzCJE2YNhhMhlPHdeUTOChr/htqrZdAAEjffqUeQLiK7QhzahXg5z5RgTVI/g==
X-Received: by 2002:a05:6808:6c2:: with SMTP id m2mr4065521oih.123.1608325844436;
        Fri, 18 Dec 2020 13:10:44 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id o49sm2120564ota.51.2020.12.18.13.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 13:10:43 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 09/13] pull: show warning with --ff options
Date:   Fri, 18 Dec 2020 15:10:22 -0600
Message-Id: <20201218211026.1937168-10-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0.rc0
In-Reply-To: <20201218211026.1937168-1-felipe.contreras@gmail.com>
References: <20201218211026.1937168-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We want the user to specify either --merge or --rebase, if she doesn't
we throw a warning.

Using --ff, --no-ff, or --ff-only does not make the merge explicit.

For example, if the user has the following configuration:

  git config pull.rebase true
  git pull --no-ff

A merge is not implied.

We should be consistent and either imply a merge; in which case a
previous "pull.rebase=true" configuration is overridden, or don't; in
which case the warning should be thrown.

Cc: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c               |  2 +-
 t/t7601-merge-pull-config.sh | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 2fd5e44e03..f1a03ccd14 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -1044,7 +1044,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	can_ff = get_can_ff(&orig_head, &merge_heads.oid[0]);
 
-	if (!opt_rebase && !opt_ff && !can_ff) {
+	if (!opt_rebase && !can_ff) {
 		if (opt_verbosity >= 0)
 			show_advice_pull_non_ff();
 	}
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index 6d03e0b9fe..7c4607191a 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -96,21 +96,21 @@ test_expect_success 'pull.rebase not set and pull.ff=true (not-fast-forward)' '
 	git reset --hard c2 &&
 	test_config pull.ff true &&
 	git pull . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and pull.ff=false (not-fast-forward)' '
 	git reset --hard c2 &&
 	test_config pull.ff false &&
 	git pull . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and pull.ff=only (not-fast-forward)' '
 	git reset --hard c2 &&
 	test_config pull.ff only &&
 	test_must_fail git pull . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and --rebase given (not-fast-forward)' '
@@ -128,19 +128,19 @@ test_expect_success 'pull.rebase not set and --merge given (not-fast-forward)' '
 test_expect_success 'pull.rebase not set and --ff given (not-fast-forward)' '
 	git reset --hard c2 &&
 	git pull --ff . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and --no-ff given (not-fast-forward)' '
 	git reset --hard c2 &&
 	git pull --no-ff . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and --ff-only given (not-fast-forward)' '
 	git reset --hard c2 &&
 	test_must_fail git pull --ff-only . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'merge c1 with c2' '
-- 
2.30.0.rc0

