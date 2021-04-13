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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B5CC43460
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 11:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EB9D6109D
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 11:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244849AbhDMLmK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 07:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbhDMLmI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 07:42:08 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE666C061574
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 04:41:48 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id u20so18951264lja.13
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 04:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MLGnBNGf04bZq0wSny6Kni8QGvJ/bcqWXp8uOi/a9Lc=;
        b=Qw48NyOIk1aG8jz9jWutu+712ZNf4cL1A7NgTiArXgKSXayOJQ/AJxhgKMXMiAc4Gv
         11hpDHkU5g5qLZOpOIaL58eNHF3F2P3QNAgLy4WwpUPap1WCUBUKmJ0htLNQtI9dLdrY
         XVkX2nvNwwXWvXKdK0DYlRMGlsf4aWno/Z93brf508cM/yAjwQcPvk/yLk8EOTymFE3J
         NsT4mJgcAGLZ291thR5OYxQNtdEFSQIyX1zpvn+pqMwiHQ8mOWHHg5H9Hly4uIL3Hr7M
         3n1g5NeOsLAB9oDjWy9dULGz0x5J6q52d4laBSlDNP1YPlcqu5ShcuUa13PcYTwqNGAN
         wN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MLGnBNGf04bZq0wSny6Kni8QGvJ/bcqWXp8uOi/a9Lc=;
        b=b3ZYgVnA0ry+sAIj5eMqLrkcuFQ8X5exLsmzdfUhL17Vr5vCCD2HCtODXO61igi5Fn
         WjLwCZ4jWMfcREVl0EumPjetzDhjtM6ZUKhuxUyInrLKVSgmp04UQTsClgtZGASuifAB
         I3uQ/l9cN9GMyT56+o0dFjk+jDPc9fHK9GZtA7wca8u2agYM3CZsyn3i6J/Lb4NXpWOR
         wvw+UxDk2ZLGgWdaJeqwNO99+qEXP1i1mg06kvE27pDsZlxPfajUna6FC6h8cYnGt7gW
         c6UvO2D96tEP0Bi5z7iA0A5dgFD6NUnVN9HSNepkyknW06K+kmKbkHmAnrmn1RW3Uteq
         5ykw==
X-Gm-Message-State: AOAM531Q+YXiHNdpjixqVoD51fM5FPIl8qBgFUJ+wN90x/zr/OvJxv+j
        BxtE65c2YCSM82DS/seeTcI=
X-Google-Smtp-Source: ABdhPJzTYHm8seQBT291FPhrqVafA6DEzRm6RCD0Ev1PnIMdbW16rk9wmX6eZEpeU/BkHBZ9nseXUA==
X-Received: by 2002:a2e:8e37:: with SMTP id r23mr21018135ljk.269.1618314107319;
        Tue, 13 Apr 2021 04:41:47 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id b11sm663339lfi.292.2021.04.13.04.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 04:41:46 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v2 1/5] diff-merges: introduce --diff-merges=on
Date:   Tue, 13 Apr 2021 14:41:14 +0300
Message-Id: <20210413114118.25693-2-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210413114118.25693-1-sorganov@gmail.com>
References: <20210407225608.14611-1-sorganov@gmail.com>
 <20210413114118.25693-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce the notion of default diff format for merges, and the option
"on" to select it. The default format is "separate" and can't yet
be changed, so effectively "on" is just a synonym for "separate"
for now. Add corresponding test to t4013.

This is in preparation for introducing log.diffMerges configuration
option that will let --diff-merges=on to be configured to any
supported format.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 diff-merges.c           | 7 +++++++
 t/t4013-diff-various.sh | 8 ++++++++
 2 files changed, 15 insertions(+)

diff --git a/diff-merges.c b/diff-merges.c
index 146bb50316a6..ff227368bd46 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -2,6 +2,11 @@
 
 #include "revision.h"
 
+typedef void (*diff_merges_setup_func_t)(struct rev_info *);
+static void set_separate(struct rev_info *revs);
+
+static diff_merges_setup_func_t set_to_default = set_separate;
+
 static void suppress(struct rev_info *revs)
 {
 	revs->separate_merges = 0;
@@ -66,6 +71,8 @@ static void set_diff_merges(struct rev_info *revs, const char *optarg)
 		set_combined(revs);
 	else if (!strcmp(optarg, "cc") || !strcmp(optarg, "dense-combined"))
 		set_dense_combined(revs);
+	else if (!strcmp(optarg, "on"))
+		set_to_default(revs);
 	else
 		die(_("unknown value for --diff-merges: %s"), optarg);
 
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 6cca8b84a6bf..26a7b4d19d4d 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -452,6 +452,14 @@ diff-tree --stat --compact-summary initial mode
 diff-tree -R --stat --compact-summary initial mode
 EOF
 
+test_expect_success 'log --diff-merges=on matches --diff-merges=separate' '
+	git log -p --diff-merges=separate master >result &&
+	process_diffs result >expected &&
+	git log -p --diff-merges=on master >result &&
+	process_diffs result >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'log -S requires an argument' '
 	test_must_fail git log -S
 '
-- 
2.25.1

