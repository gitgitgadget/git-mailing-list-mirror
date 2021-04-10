Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32F0C433B4
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 17:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73EF0611C9
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 17:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234839AbhDJRRi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Apr 2021 13:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234513AbhDJRRf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Apr 2021 13:17:35 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F1CC06138B
        for <git@vger.kernel.org>; Sat, 10 Apr 2021 10:17:20 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id o16so10179286ljp.3
        for <git@vger.kernel.org>; Sat, 10 Apr 2021 10:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZVP/Gc6XixM5Q2Z/soNlllHo+dq/y70Ei8l72s9Bsv4=;
        b=IEfT1eE44W63YCCTMebX38S1cEtKNCpUhGxQE5UUSGNDut9BKG+69UE+UFJTqCyKbr
         v1RxuXd/0T0hUuqTBfgGRgayv8mgqvNstt13/HlFP3+AOosxJSFdrCNTCQKeaxh5yGfX
         RaJQomgE9L+Z+BNx2+3InqhZWRxiJOAANJOjXpzlFvnPzQfm+Y8iPiKjxfO376PxgEEC
         GWqrzX7EEO5tTL1yTvoMJ4LNwulI6R/+a0No5kz2xR+ycOQd6cNrfUpwSMNhoWRqfXE7
         429GO4nIieuMg0KE9mXjZajFo2d//qAJg9F7B68OnaQ6GTq8his5HJ2D77LKj8Wf5KWO
         1zeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZVP/Gc6XixM5Q2Z/soNlllHo+dq/y70Ei8l72s9Bsv4=;
        b=SZoCoJHrwhMvbUq+ACq5stjRBrt+lKU6Ar7GgILY6I3dd4RxvIU61Am54cg5JraKBr
         Mt89IefL5Op1F1KoBRpgkALUwqGwj7ApHzvvgJw0JItsaBtCuV70wyWWOKZwX5oI7PI3
         rmzh1As36xEaWbuz781TednRdhffE4yDODuLNqnb8cOv26hsQdOvVcSeh4f3q0es2N+5
         sGRdABHDEcnbXRYUlhNj9SLVBCZqshKHj11vnI+p/PwophPgsvgV5hdB8xpvz3jv0eql
         y8PenJ708wq5xkSdYF4sbEpzyByILLkrjaofzFPc0tuaZGyjFOK1WmGfF5ALBqTzJeb+
         jUXA==
X-Gm-Message-State: AOAM532V4nvHvH1Ad8q96C/wpwKjEgiuGr6s03Nsg2zHbxaykzNUBkvb
        hV/ggYvO+5dSEP7pvqwUijo=
X-Google-Smtp-Source: ABdhPJywY3TEmORgG7a5ZBDq7jvhmnwkBwtZyjMmu60P2A474k8MU/Dqo0L9wQuMqEWupw40Jk4FxQ==
X-Received: by 2002:a2e:a177:: with SMTP id u23mr2653002ljl.329.1618075038696;
        Sat, 10 Apr 2021 10:17:18 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id z7sm1336543ljo.64.2021.04.10.10.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 10:17:18 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v1 1/5] diff-merges: introduce --diff-merges=default
Date:   Sat, 10 Apr 2021 20:16:53 +0300
Message-Id: <20210410171657.20159-2-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210410171657.20159-1-sorganov@gmail.com>
References: <20210407225608.14611-1-sorganov@gmail.com>
 <20210410171657.20159-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce the notion of default diff format for merges, and the option
"default" to select it. The default format is "separate" and can't yet
be changed, so effectively "default" is just a synonym for "separate"
for now. Add corresponding test to t4013.

This is in preparation for introducing log.diffMerges configuration
option that will let --diff-merges=default to be configured to any
supported format.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 diff-merges.c           | 7 +++++++
 t/t4013-diff-various.sh | 8 ++++++++
 2 files changed, 15 insertions(+)

diff --git a/diff-merges.c b/diff-merges.c
index 146bb50316a6..7690580d7464 100644
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
+	else if (!strcmp(optarg, "default"))
+		set_to_default(revs);
 	else
 		die(_("unknown value for --diff-merges: %s"), optarg);
 
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 6cca8b84a6bf..8acb5b866900 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -452,6 +452,14 @@ diff-tree --stat --compact-summary initial mode
 diff-tree -R --stat --compact-summary initial mode
 EOF
 
+test_expect_success 'log --diff-merges=default matches --diff-merges=separate' '
+	git log -p --diff-merges=separate master >result &&
+	process_diffs result >expected &&
+	git log -p --diff-merges=default master >result &&
+	process_diffs result >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'log -S requires an argument' '
 	test_must_fail git log -S
 '
-- 
2.25.1

