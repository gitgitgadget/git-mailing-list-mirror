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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECEDC433E6
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 09:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FB3E217A0
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 09:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbhAGJw7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 04:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbhAGJw5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 04:52:57 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895A8C0612F8
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 01:52:16 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id y23so4982872wmi.1
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 01:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D5BfmR7M4st3lbVYq1hpgZDbZkoR6DMSo1uAL0MHqgc=;
        b=eRyZ7fpSs8jOcTj4eMsWgUwegqoFOHfHF3gprRb9m8J+XtNAbjguq2jGH7ra4JxMEc
         E41E+XTpY0lrpmSBoO5OIPdYtFUQvksUX6pMQQgBtR+IXkmoSYyiiRbYuOWpvfNoMfja
         fMPMNf8WnhfdtRtrMZiW7+COVKEmbXp/FpyL7V6UO1D0PP0UtQvL/aX01yKUHEsK5IAt
         Ly5t471rqjie4JaVtcH4oLFtGA6KfOCNVQ3QA/mz7VX5vGnhqPL+HFE/5Bi6uX7b3lWQ
         3j1Gd+YtU8l08414RwgHogwwM4IxW5/7+pamcxZt9p7wKQ/GhFN6+wdq4b/Mvn9SuXPd
         sPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D5BfmR7M4st3lbVYq1hpgZDbZkoR6DMSo1uAL0MHqgc=;
        b=lBkNjIUQQBFKDCjlhJhuzqnflui48TXzDmLVcV8YuStvqukj1zOtOSxrBxBPCtni7n
         Q2SrLBx9fZtubG26EvFuQe396BN36tIUuPmGy2sE5+ymQoLme6cgoeDHpRAYwTpXRa8q
         X1qojNiHh7BjUGTTjIfxb+NGnNmUXknc1zVAwbVDoNAKtiBDI66r5oRhYNwFROitwF7M
         UciOtCkiFn3A0j9ZNHcYVHKXN5Bhq5vfDA8yts9ehmw0tBdZZ76KEnPG04RhD7zUKjrW
         kJvLllgEBnu2R48Er0CQvxrxD8H+ZjZ5BF5aTyYbipbnS8S5fJTiX6aAU5ckFGRwzWyR
         X1zQ==
X-Gm-Message-State: AOAM530j5pUkC1ZvXt5MA0URK19veVHPTKCFKA5T3QpDvRRysnF5XT2o
        hUCmgbGIMEe5mvCphbgwXuD7Z+i4aX+E2g==
X-Google-Smtp-Source: ABdhPJxC+gVkGqb4rTptDvGDrkAcHiUNZOES4fs4304IW29B92aOlcme0Wyd7gNa5c1B0z4aNCL7ZQ==
X-Received: by 2002:a1c:a706:: with SMTP id q6mr7265508wme.7.1610013135035;
        Thu, 07 Jan 2021 01:52:15 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k10sm6806535wrq.38.2021.01.07.01.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 01:52:14 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthew DeVore <matvore@google.com>, git@matthieu-moy.fr,
        olyatelezhnaya@gmail.com, samuel.maftoul@gmail.com,
        Johannes.Schindelin@gmx.de, karthik.188@gmail.com,
        pclouds@gmail.com, sunshine@sunshineco.com,
        emilyshaffer@google.com, jrnieder@gmail.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/7] ref-filter: add braces to if/else if/else chain
Date:   Thu,  7 Jan 2021 10:51:49 +0100
Message-Id: <20210107095153.4753-4-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20210106100139.14651-1-avarab@gmail.com>
References: <20210106100139.14651-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Per the CodingGuidelines add braces to an if/else if/else chain where
only the "else" had braces. This is in preparation for a subsequent
change where the "else if" will have lines added to it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ref-filter.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index aa260bfd099..e4c162a8c34 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2364,11 +2364,11 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
 		die("%s", err.buf);
 	strbuf_release(&err);
 	cmp_fn = s->ignore_case ? strcasecmp : strcmp;
-	if (s->version)
+	if (s->version) {
 		cmp = versioncmp(va->s, vb->s);
-	else if (cmp_type == FIELD_STR)
+	} else if (cmp_type == FIELD_STR) {
 		cmp = cmp_fn(va->s, vb->s);
-	else {
+	} else {
 		if (va->value < vb->value)
 			cmp = -1;
 		else if (va->value == vb->value)
-- 
2.29.2.222.g5d2a92d10f8

