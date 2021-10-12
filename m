Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7A6C433EF
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 13:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B056E6101D
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 13:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236773AbhJLNdV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 09:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236853AbhJLNdJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 09:33:09 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF30C061570
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 06:31:07 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id a25so65268421edx.8
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 06:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FwydAA9+XG/fWb2WQeKawbthbsDNY7R6cy2eA5hH3PE=;
        b=aw8k8cjlQEbsQJkU0GcLffqUOUMEcQm61rYIH9IQoqJDQtlazArj/9KAlFZ+KLHuV6
         lSWrnSxE1BxEDRBWl8v1GhuRA7uO8jMqtB+9fQJl51vSu5IIrRe4hflzaisjoLQO7uVY
         k7U6ASgWmhM2VpnUy1ywZCB+mavNQx1hWSxM4AJVozUbuixJ72pjmXXESP9OGziovz4F
         aGyBG5/O4RH3wD30zX2fWpMzWJZuzuuCziBZmVnJGqt6HoR1Yxg03S0VTCTkBPeKdaMn
         vNRMeYwkPVdJGKUP1BczWke6SRKKW4a6hRV29Yw+ZzhH6VixpD4kswDXOCNkh/6cYqnh
         qk+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FwydAA9+XG/fWb2WQeKawbthbsDNY7R6cy2eA5hH3PE=;
        b=ocOPg5mE8RN2ZgAZUg6m2wu6A53oKZ0IIMc7jD77Jk86NB4bbG6FI0WnHA3QBzCsMf
         3MDSVItaFrN+7HuQVEvAPx773FwMO7HYD35CxdiDuiYaZdQPokNe00TBJAnbcvJtZGrh
         1724NMsMBeKkyx6jlGUbH0UZQ1DprkU+yvN7ROAuwfglaSqC1FlhtI8L6cK087mSk7Tf
         2W6I7Ca8iWfR6uTI1kdQ1kJ+ePwh/v94f/mczTY6Z1kOHLJTCMCyzG8TXFnBm4dJ3pFv
         m46lvDbdf+cer44XfVkBsVs1v1kPjXsD8FFc6PROJl8qgcdKXepuL/i2+YdEQAIs5YrE
         sYSA==
X-Gm-Message-State: AOAM531x6hwtM6xSEMDfcIsF6xgTxIqoszc/ZYK0ZhCugoJBXz2SQyoz
        Ibwd0nTrCq5pvLy397zMqq/ItoIwy11Kzg==
X-Google-Smtp-Source: ABdhPJzD7qtu1vXg7qIfSfuBUEihzLe3lagu9cAwtPsEiayU7TK5qWdBUEg+IQ+Uic4fRt5TbDTPKA==
X-Received: by 2002:a05:6402:520b:: with SMTP id s11mr31921490edd.123.1634045462748;
        Tue, 12 Oct 2021 06:31:02 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bi23sm2016405ejb.122.2021.10.12.06.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 06:31:01 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Luke Diamand <luke@diamand.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 06/13] merge: convert post-merge to use hook.h
Date:   Tue, 12 Oct 2021 15:30:31 +0200
Message-Id: <patch-06.13-08f27f0d6be-20211012T131934Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1567.g7b23ce7ed9e
In-Reply-To: <cover-00.13-00000000000-20211012T131934Z-avarab@gmail.com>
References: <cover-00.13-00000000000-20211012T131934Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Teach post-merge to use the hook.h library instead of the
run-command.h library to run hooks.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/merge.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 956b6259f21..167d13bd737 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -448,6 +448,7 @@ static void finish(struct commit *head_commit,
 		   const struct object_id *new_head, const char *msg)
 {
 	struct strbuf reflog_message = STRBUF_INIT;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
 	const struct object_id *head = &head_commit->object.oid;
 
 	if (!msg)
@@ -488,7 +489,8 @@ static void finish(struct commit *head_commit,
 	}
 
 	/* Run a post-merge hook */
-	run_hook_le(NULL, "post-merge", squash ? "1" : "0", NULL);
+	strvec_push(&opt.args, squash ? "1" : "0");
+	run_hooks_oneshot("post-merge", &opt);
 
 	apply_autostash(git_path_merge_autostash(the_repository));
 	strbuf_release(&reflog_message);
-- 
2.33.0.1567.g7b23ce7ed9e

