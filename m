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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AF6C433E0
	for <git@archiver.kernel.org>; Fri, 12 Feb 2021 13:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B92364DDF
	for <git@archiver.kernel.org>; Fri, 12 Feb 2021 13:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbhBLNbk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Feb 2021 08:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbhBLNbR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Feb 2021 08:31:17 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE9AC06178B
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 05:29:59 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id v1so4321441wrd.6
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 05:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8WDGCsdZLIAv5ibQ1T5pqunSjtx5MDpQQN0c+sZ+EyQ=;
        b=AP3ftRqcR5P2ZPEbiyX+mhvugOKq8jFRiC0MKnQdNrUQnS1UUygQT0YOm2Tld9EArh
         RskuyQKck3DNtbdx5fDBVe0Ueoromu6ht+cubG5/zAkQxTPSjtC3BXVro08dO1MOjSaR
         w5UWlM18gkGxlQ6cgd6JgQ0Y7JfQ3+qKHDS6cjYofZrvUZzIZz3cPjejwB/RLPEahNwD
         LwUSC8c2dP3A8LUiKysC5hfcBTDiAGnz9ovEtbIMq8Nkuwiy/p9qH9hsiUdv5STtEhkn
         vQjpDz6C1KG98WVnwjKUeCciYqsGcv+FlCBGfb3Y1mDv9mr2lxd0jh2TM6fNqDh+T1oj
         ZUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8WDGCsdZLIAv5ibQ1T5pqunSjtx5MDpQQN0c+sZ+EyQ=;
        b=t2vpJ619MHO1Cc85R7X3H1icI4ONtpIMnIDKN5DrwDOF7OIej99UaUcy6ZRwQyEnEJ
         VPhkNYd0IR1wa7fx17USop6TtSCGZ08rwcsEOLC+1meMDcHZh3nhz11dkdoOHcgtAEa6
         Lswdod/Im86m7N++G5oYBpJ+AUz1RLp0QNCEXncT0eVAYWcZYBbg44ei5NLBIY+cCS/p
         8WbTBJwdUkbOos+Kfuwe6LptuKcS5ZZMlmZogI4Oa53swgiJxTL+hCh4HUAc0/6Dk5yd
         wmrDAY+21DrY8W1lgKoYFLDE1ENLQ9FnYYBpWhD4s99tJ/tT85mnY51VJp7MgjXMqlny
         /yYA==
X-Gm-Message-State: AOAM531+ueMh45hauo5ltKu/yv3dnxBQ00uNuZMnecGw2ngHr/3jRP+p
        mvu6Bb9PXiSqWoG6j2f8HZn04NNNY4fcUA==
X-Google-Smtp-Source: ABdhPJy5Iahil1yNQj4AXIUatZt9NxDVajaCZmspwTqpcTgM5b7F2A3m9uFQTm/Q3Gqfbvc2aoRavw==
X-Received: by 2002:a5d:5047:: with SMTP id h7mr2186834wrt.67.1613136598311;
        Fri, 12 Feb 2021 05:29:58 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 13sm14060682wmj.11.2021.02.12.05.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 05:29:57 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 04/11] test-lib-functions: remove generate_zero_bytes() wrapper
Date:   Fri, 12 Feb 2021 14:29:35 +0100
Message-Id: <20210212132942.17325-5-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210209214159.22815-1-avarab@gmail.com>
References: <20210209214159.22815-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since d5cfd142ec1 (tests: teach the test-tool to generate NUL bytes
and use it, 2019-02-14) the generate_zero_bytes() functions has been a
thin wrapper for "test-tool genzeros". Let's have its only user call
that directly instead.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5318-commit-graph.sh | 2 +-
 t/test-lib-functions.sh | 7 -------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 2ed0c1544da..368d1cfb448 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -529,7 +529,7 @@ corrupt_graph_and_verify() {
 	zero_pos=${4:-${orig_size}} &&
 	printf "$data" | dd of="$objdir/info/commit-graph" bs=1 seek="$pos" conv=notrunc &&
 	dd of="$objdir/info/commit-graph" bs=1 seek="$zero_pos" if=/dev/null &&
-	generate_zero_bytes $(($orig_size - $zero_pos)) >>"$objdir/info/commit-graph" &&
+	test-tool genzeros $(($orig_size - $zero_pos)) >>"$objdir/info/commit-graph" &&
 	corrupt_graph_verify "$grepstr"
 
 }
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 82ad0b91743..71d4e806f6d 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -111,13 +111,6 @@ remove_cr () {
 	tr '\015' Q | sed -e 's/Q$//'
 }
 
-# Generate an output of $1 bytes of all zeroes (NULs, not ASCII zeroes).
-# If $1 is 'infinity', output forever or until the receiving pipe stops reading,
-# whichever comes first.
-generate_zero_bytes () {
-	test-tool genzeros "$@"
-}
-
 # In some bourne shell implementations, the "unset" builtin returns
 # nonzero status when a variable to be unset was not set in the first
 # place.
-- 
2.30.0.284.gd98b1dd5eaa7

