Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FA2C433ED
	for <git@archiver.kernel.org>; Mon, 10 May 2021 15:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC4EC6023E
	for <git@archiver.kernel.org>; Mon, 10 May 2021 15:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238960AbhEJPQK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 11:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237168AbhEJPNp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 11:13:45 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79960C0515F2
        for <git@vger.kernel.org>; Mon, 10 May 2021 07:32:22 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id d11so16860574wrw.8
        for <git@vger.kernel.org>; Mon, 10 May 2021 07:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vZ9j2HMAlkK/ozz6GxmWQCVvqykhdX9aa9eqTJjKE6Q=;
        b=O9WsCC+1JVs8maZjKYTONBS4titB3C1nfdQW7EWWgmeDwLDM92qlbHcBB9lTmJWg8L
         UDR723HSDZwWWikRBcFRH6ZdXP/Jl9dGA0fU9+BeENEQaOOBXU6V1/nBTUlJf37Kkflx
         c9KsRhhs7szgezWRbB/fm6iMvANrr9cQxCYThMiBd9xRAXL5pOVwv3ZZUYhA2YdTJIwK
         eqXQFsi9WSccccyrUY9K1gukaeXPISYO2Lcnz3bfsS+TcSNwmretdwPxR4M3JJsLG7Ik
         4kdLRvTfW48ZLSG9Rrn8W3y1rNi9FOHw9l9k6Wt3t5PaeA9DREIYYCGN41VympzbiUT2
         qStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vZ9j2HMAlkK/ozz6GxmWQCVvqykhdX9aa9eqTJjKE6Q=;
        b=seLfJdnYYCmoixUD3PPI0IL8EduP/8MOJhSgNEphC5sBLHygRZxFD0NSOvJ1CoC80K
         GG91HkKCpzUHjcixr6hF3Vb78A/cmzzRv946wQyNQ4yEhKfMYK1nENFy56mdQF9++j0+
         QPdTdcXQdXJJ6/futq986ebdEez++NnKZvXT8CNQF2+HmWP6YCQ6hS93wY9sSSpdnC+p
         hJtpIKJkhykqnn1FDYl7ojPwQ8PraQ6Vmyq6n1gmddDa2fxAkbNQARFep1W4yMSSBYO4
         ocWmQGzoGRdvLazbKTZ12HM5ERwBtezAAHTqdSwVfPd7L4t2wmWjqkh6TWjyGTNO5F1G
         66Gg==
X-Gm-Message-State: AOAM532+EL8B8nXpcFTfpenEKVfj8JUuVPVXDerdkTG5qxbyuLg30mN9
        tDoNSwqqo4+rgzwnhy4ae0ema0zvHSJAHQ==
X-Google-Smtp-Source: ABdhPJxsRO+ykUTDHKC76fmAc/b8SYcLoQbl53cSPkivzk1S8zNB3b61lkx2N/U4PQMneDXvnrQC2Q==
X-Received: by 2002:a5d:64aa:: with SMTP id m10mr31525708wrp.291.1620657141059;
        Mon, 10 May 2021 07:32:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q10sm22421839wre.92.2021.05.10.07.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 07:32:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 08/11] submodule tests: use symbolic-ref --short to discover branch name
Date:   Mon, 10 May 2021 16:19:07 +0200
Message-Id: <patch-08.11-0b31b1ffeff-20210510T141055Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.838.g924d365b763
In-Reply-To: <cover-00.11-00000000000-20210510T141055Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20210423T072006Z-avarab@gmail.com> <cover-00.11-00000000000-20210510T141055Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a use of $GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME added in
704fed9ea22 (tests: start moving to a different default main branch
name, 2020-10-23) to simply discover the initial branch name of a
repository set up in this function with "symbolic-ref --short".

That's something done in another test in 704fed9ea22, so doing it like
this seems like an omission, or rather an overly eager
search/replacement instead of fixing the test logic.

There are only three uses of the GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
variable in the test suite, this gets rid of one of those.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/lib-submodule-update.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 4b714e93083..f7c7df0ca42 100644
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -63,6 +63,7 @@ create_lib_submodule_repo () {
 	git init submodule_update_repo &&
 	(
 		cd submodule_update_repo &&
+		branch=$(git symbolic-ref --short HEAD) &&
 		echo "expect" >>.gitignore &&
 		echo "actual" >>.gitignore &&
 		echo "x" >file1 &&
@@ -144,7 +145,7 @@ create_lib_submodule_repo () {
 		git checkout -b valid_sub1 &&
 		git revert HEAD &&
 
-		git checkout "${GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME-master}"
+		git checkout "$branch"
 	)
 }
 
-- 
2.31.1.838.g924d365b763

