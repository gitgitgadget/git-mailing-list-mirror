Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30244C433EF
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 18:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12AC460F24
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 18:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbhKATBx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 15:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbhKAS7f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 14:59:35 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAF6C06120B
        for <git@vger.kernel.org>; Mon,  1 Nov 2021 11:56:32 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id y84-20020a1c7d57000000b00330cb84834fso143589wmc.2
        for <git@vger.kernel.org>; Mon, 01 Nov 2021 11:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WhYCuOzxe+sxxCv5UAv2vnffVkwFvvfgsstQUsGX5xM=;
        b=TjfQPrXdnw8ZcnVeJLFt/L0JQY5+/kUVF3fWgncQIpwvLQjNk9yWDVieT8Pf6m8FDa
         7U08d+iGQoQBZFp9PGYAjhVW4MNN70zU/ah3/UjRjHOAKMYNk7rXr/dE1Ul5CtTRiYD3
         ltfCBFc1wbtTsw6SkAZsmrFULluTnTZa/4sW0yywSbR+EiwIaiZS9S5FTQIhEXrkYQJO
         UvvIbm5BQB2os38zhVzDnAHPAFnYQKejq2u9ymz7ZfEPazdBVwaC6DmfEa4cHtRn6ulT
         JoWZQMYNM89DNAudsCms1Blu3ydvoqdOSrid4/FdrAl0JxnWaPdcn1IH9wpOCsE/xaxN
         utHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WhYCuOzxe+sxxCv5UAv2vnffVkwFvvfgsstQUsGX5xM=;
        b=CtF9QwXDIZtDh6SvY+6KPoKM3kGxzdw7eQSAV/MhV1/PlrY5Zrnccs8dbD5iMZHHAX
         fwEy0tDStSXB4PUsBMEmS9M6LrzhOhNIgxzLFmtg/scmfmzsSKj1QfQEAJZBVVK0Z6zp
         H7qenq12I7XgOcmkeK+da3U3QZ4ZQh+W010KNwe5V4XhReYTh8uJDgme7ns64O5yv0UP
         7TDBfNDEBjvazWLL02jZ696DIxfYUP8hdrAlaWoqynqgFmtYSVnrgd5nwnUQu1JpsK42
         m45E7duc9lozadXCGG8lUgSECTsDwX5KigSaO5Xj1c3pXa7gkQgZ6R4f7cy38St12kNr
         1eOA==
X-Gm-Message-State: AOAM530teQP7/yPRaGiGYo97VVeW3gop13ty6r8vt3myNq53I219BofV
        cZiqFol9iwZOtHlOpKwU54DFjYL8ilvrmCqt
X-Google-Smtp-Source: ABdhPJx3U5ucV+1UQTuX7CusYaxmtQKpTyFyS7Rx6nBY+YooXQ/7hUaeTUzkkE7W2KdDeZeKRogcNQ==
X-Received: by 2002:a1c:7515:: with SMTP id o21mr853305wmc.99.1635792991239;
        Mon, 01 Nov 2021 11:56:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q14sm314185wmq.4.2021.11.01.11.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 11:56:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 08/17] merge: convert post-merge to use hook.h
Date:   Mon,  1 Nov 2021 19:56:13 +0100
Message-Id: <patch-v4-08.17-2c23e8645ec-20211101T184938Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1570.g069344fdd45
In-Reply-To: <cover-v4-00.17-00000000000-20211101T184938Z-avarab@gmail.com>
References: <cover-v3-00.13-00000000000-20211019T231647Z-avarab@gmail.com> <cover-v4-00.17-00000000000-20211101T184938Z-avarab@gmail.com>
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
 builtin/merge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index ea3112e0c0b..e6facd1c95d 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -488,7 +488,7 @@ static void finish(struct commit *head_commit,
 	}
 
 	/* Run a post-merge hook */
-	run_hook_le(NULL, "post-merge", squash ? "1" : "0", NULL);
+	run_hooks_l("post-merge", squash ? "1" : "0", NULL);
 
 	apply_autostash(git_path_merge_autostash(the_repository));
 	strbuf_release(&reflog_message);
-- 
2.33.1.1570.g069344fdd45

