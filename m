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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FAFC43214
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C0FF6108E
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345066AbhIBNNO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 09:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345098AbhIBNM6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 09:12:58 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533E6C0612E7
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 06:11:57 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id q11so2847100wrr.9
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 06:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/862uM2Rfvv2d2PwcMBW3WgabjsMKg8Eef8rLg40Tnw=;
        b=gDobLURoX1Eauxvcs7ERpe2oJFXADlXUetHxXnReo3BRH0PbvVAc4pQdlMuLQ/kl+g
         t6nitciG0WJhE6y1oIL6yYRFl/EYi9NLKpxiaySO3MgpqfmawqtpKrR1+JTo2TKggEET
         C0PY/oGSkGlJRvO+s/hvGIBnqPGh3tjUZ7WLqBF2n5oXs2XAm347M77MouhDAA1gEKjx
         sB++9n/qgaPYBLRwgVFn0rczH6sHPeixFVEZ4qphcVfMhXDVLnAazJbppDhK8NS1WFRM
         v1nxlJ9ALOLVMFqeIZbcS7OWsm/dkuZ6fbgj2ioN79WiYE8cDT3xtazljaIsCq2qbQbc
         0GQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/862uM2Rfvv2d2PwcMBW3WgabjsMKg8Eef8rLg40Tnw=;
        b=mewTYdDY5S8sd6zxtwsGbCB0fibruN/aXCrP/Vuo0Z6frXBLqEjgrqyQbu5vuTwAyR
         bXKiEpXpiUJrAQ1bU1yZVvnI32m8ffUIlDSxzcmi9+IKNrr/Vm8KAXm7xhFRvqWzl298
         rq/q8pVvoHqSoErhsQ4/NnUgdlfRg0nekLsiv+pZSi0ZVhS8JxxwS5fQhSaq2yZ5W6Re
         MuwW157VHIO8tMQhjMpper3XI4Fvt9gknULz5eER3t+sbfZegGMC/hQOpsI8aNJbISUy
         rKr6nWVjpWkM+mAq2ad9G6abOSup2buA932btu4e/SCbnwy9McK2D2P12+9zcWSMymMN
         mr2A==
X-Gm-Message-State: AOAM532QvLNMgzKPJ0L93xiy0mlcO5OlLMKHt/n8sWtcAC6Ky1WaGwXW
        5OOhfOgyW/zI9xG+Jt7gULAmTcwH5y0adQ==
X-Google-Smtp-Source: ABdhPJzHShn4K8aTqrTMJVgT/g6/GnQsYHgB9ORNUoJqYwxDXr7QwZtZfxLYHe0HSp9wIIS0/2vbxw==
X-Received: by 2002:adf:b748:: with SMTP id n8mr3656033wre.133.1630588315728;
        Thu, 02 Sep 2021 06:11:55 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o7sm1479635wmq.36.2021.09.02.06.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 06:11:55 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 13/36] merge: convert post-merge to use hook.h
Date:   Thu,  2 Sep 2021 15:11:13 +0200
Message-Id: <patch-v5-13.36-53d8721a0e3-20210902T125110Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.816.g1ba32acadee
In-Reply-To: <cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com>
References: <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com> <cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com>
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
index d75a438298b..ca9b3ba4827 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -448,6 +448,7 @@ static void finish(struct commit *head_commit,
 		   const struct object_id *new_head, const char *msg)
 {
 	struct strbuf reflog_message = STRBUF_INIT;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
 	const struct object_id *head = &head_commit->object.oid;
 
 	if (!msg)
@@ -489,7 +490,8 @@ static void finish(struct commit *head_commit,
 	}
 
 	/* Run a post-merge hook */
-	run_hook_le(NULL, "post-merge", squash ? "1" : "0", NULL);
+	strvec_push(&opt.args, squash ? "1" : "0");
+	run_hooks_oneshot("post-merge", &opt);
 
 	apply_autostash(git_path_merge_autostash(the_repository));
 	strbuf_release(&reflog_message);
-- 
2.33.0.816.g1ba32acadee

