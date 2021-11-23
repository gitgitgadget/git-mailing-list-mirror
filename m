Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E07C433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 11:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236521AbhKWLtz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 06:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236534AbhKWLto (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 06:49:44 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850C5C06175A
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 03:46:36 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id c4so38413050wrd.9
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 03:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cgYsfXyu6U8RcbkdkCohvcCf7L5WdZbG1HX4E8qFul0=;
        b=ONTAWqDNX85GsUmNwiC04UPLSKCj3FcjtIekB2rForGTErewZ1vnah3ItYJbKphKQt
         DZQPLuvK+kX8IeRUxKSd7U4cHZgoz1ZhyvVYNiGn2cG0utNlhiM3JnpbnjxqKJkV9Ts8
         0YW/4tvxfHAaLZjH7rVFYkAF6DMAK+MPyY73XYNvGFCsrUfp2VtG4xsjGbjHvpjgAwxL
         dKjrqp1MooBrWbc/oomFAqJDuUywkSN4rCvpwllTqoc3slbHRyZxG5HTRJQ+aWRZL/aC
         yoEqvpYN66eKKCYkGh0FbLOeNkHOtxOH00pm7iZQy8rP+ioceYvo3Jx7Af3XV114du1T
         OGRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cgYsfXyu6U8RcbkdkCohvcCf7L5WdZbG1HX4E8qFul0=;
        b=dJY0ZEz6Iup2Y9nz164d1NamRlCMURpgVDs1TvzIM+llQCXoi4U8hBTPealewro7nk
         OGdURMUF9dPTrW/et7PM5Iy1UKnsTQQSGDq7s6kZbWz0NT0my68xSc+iLiBlKyXTuimi
         bna2e+FP+AXaqkqrkVtOnEV+PiErrE+r+iG41quN+Rzcg4cF+D9NyX3UXnG2xdjmcMdR
         YNcH1nNPnbL6Bm2nZpUPc5zZeHSbp89lqX+V0qkxh8ci+lRpRb/Q6kfbTiUjvKrMXHXu
         HontpxzEGkwoDZJwiHXp/66bpRst5YkrspJSBRJNxcHyTLnwAbnV2hloqVPZsOEPkPH6
         4hNA==
X-Gm-Message-State: AOAM532SiNz7J/DFw4lZSsInvrANB6jw5tlu8c5oI03qU5UvockH8vW2
        kNkgM+ZYATOZFZ8YGeB3etjFaJgDPK8ptA==
X-Google-Smtp-Source: ABdhPJyvBgIOB+LmCzvWlrucZ9ceg672Il0pbTYxH2ZvF0dOkM48ALwFW5oc6/fPMG3Kb3gjFsMr5g==
X-Received: by 2002:adf:ce0e:: with SMTP id p14mr6282663wrn.423.1637667994872;
        Tue, 23 Nov 2021 03:46:34 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c11sm1723145wmq.27.2021.11.23.03.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 03:46:34 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 16/17] receive-pack: convert push-to-checkout hook to hook.h
Date:   Tue, 23 Nov 2021 12:46:15 +0100
Message-Id: <patch-v5-16.17-b201ea46f4b-20211123T114206Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.831.gd33babec0d1
In-Reply-To: <cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com>
References: <cover-v4-00.17-00000000000-20211101T184938Z-avarab@gmail.com> <cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Move the push-to-checkout hook away from run-command.h to and over to
the new hook.h library.

This removes the last direct user of run_hook_le(), so we could remove
that function now, but let's leave that to a follow-up cleanup commit.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/receive-pack.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 49b846d9605..5d6d8dd9a26 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1439,9 +1439,12 @@ static const char *push_to_checkout(unsigned char *hash,
 				    struct strvec *env,
 				    const char *work_tree)
 {
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+
 	strvec_pushf(env, "GIT_WORK_TREE=%s", absolute_path(work_tree));
-	if (run_hook_le(env->v, push_to_checkout_hook,
-			hash_to_hex(hash), NULL))
+	strvec_pushv(&opt.env, env->v);
+	strvec_push(&opt.args, hash_to_hex(hash));
+	if (run_hooks_opt(push_to_checkout_hook, &opt))
 		return "push-to-checkout hook declined";
 	else
 		return NULL;
-- 
2.34.0.831.gd33babec0d1

