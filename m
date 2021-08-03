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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF6AC432BE
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 917816103C
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240226AbhHCTju (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 15:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240180AbhHCTjh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 15:39:37 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B92C06179E
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 12:39:25 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id d8so26474302wrm.4
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 12:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J2qZX9ADydzDCwCeYMmoGobk6vdlg8qx8oCXrBvhH2c=;
        b=gy3HVAKopL2v2YEV7kl+HeNbTMos58Jz4dd6W5ScLbUX/jEWet7WxJ38LVt7hmEyWu
         21nbm8juVJEBIPMSVChK3ppDAenuRuYS7PYnkOb38uZQuC5df8UTtz5Yrg2nTf347YNd
         bAcSP4gmhdN/ArCiI8/Whhslvuzd/IL/6iF+re9Yxaex+UcDrzSMm0Lw/PIUbV3sfHyf
         IEuFV9v4S0EBw7ck+ZOG5vAVevmIm82t9XCxfgD6Hk/vSVJxlXE+oeRnpt3dyH73N086
         T+xv/GwSF9rFDhfaKgTw5naeiUc2znp2k9EhuFuYMV0kqCsiASbJmZbVCVEWM+ubD7ci
         Qz2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J2qZX9ADydzDCwCeYMmoGobk6vdlg8qx8oCXrBvhH2c=;
        b=B4gG7rT+ZocTjAL4lQJ9E1CLCon81Kp7tmd2L9HRzXzbIdoRUv8k1iiOTid1xRxxzZ
         GBofaq9ZW5KIPM6LNI5C3uwSRt8VLYH2jg0CEOZ4CMShQhgA2VnHEui0OSU4nbtbrVkE
         H8wQELoc5V+47SUWfvSMfZAPkR8E3WSGdSmpGQwItSLW1OUJ/xkv/hzkL2Ho9S9iF/QJ
         /VmDBI0hgIsWl9GzKAtuPJ0ZrQ5G3upuw8APARumy6uXcNjgs4gMLwGMua3V8itSTbSJ
         oFxTjigMgzLEd9pvoZ1P4meWWAedRx++BHVqIJn5DIBBuE4suq3CnyuG7Qu5pqpilH6W
         Z7MA==
X-Gm-Message-State: AOAM533VM1n+wdopmWw1aiZEQJDAtmz3v4hrJN4bOHNfLFjhBK+PgMoT
        B5sV/XOPbrN3VuyrtLzjZeSDcl1C2F0SMw==
X-Google-Smtp-Source: ABdhPJyaG0ptEs+vtFpDsParytTvJvxaM1Hw5OtDDkBGd7RK8xSxcGeXV9aBsySXFvZNit0ZjKrejw==
X-Received: by 2002:adf:f852:: with SMTP id d18mr24613748wrq.201.1628019563679;
        Tue, 03 Aug 2021 12:39:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n8sm15333562wrx.46.2021.08.03.12.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 12:39:23 -0700 (PDT)
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
Subject: [PATCH v4 13/36] merge: convert post-merge to use hook.h
Date:   Tue,  3 Aug 2021 21:38:39 +0200
Message-Id: <patch-v4-13.36-69763bc2255-20210803T191505Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.593.g54be4d223c3
In-Reply-To: <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
References: <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com> <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
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
index 03f244dd5a0..4965df2ac29 100644
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
2.33.0.rc0.595.ge31e012651d

