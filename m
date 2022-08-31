Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA747ECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 23:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbiHaXTJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbiHaXSd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 19:18:33 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563F1CE308
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:32 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id c7so13469848wrp.11
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=5rBLF7ic0qPgJOx9n9+R2A4Zr2m8hd5+1zZb6OaE3K0=;
        b=SsZne7sX48ptq5jQjunGLd8y9Tj0n/2otcFDXPXWJ+BAW+WzjtXq8bXtfWquA4muyY
         iD6IiwPkV1mnsI5EjvBxwI5u2QBS7iK7gQEkRRO3ZuQmiDZs6VtwsaZqhTkeRLJ7kZE0
         WbBb8NUCnXMRi6U/1wcATNkRoFCPv+mEAhvEKH1Cn0IBjziktfOrILJuOT9WVz5NQIT+
         /byk0fnGld+e7IkGgP1L2s3T5px0cZHoQ+fHuIjZpJF2g+IxCcYrvK1cT6ADpK+90MWw
         Fus7/MDT7c5V2VjWHJol80K6zcvX+K9NVJTQPqbnhLEnkDW+kF3LB+tF91IOHnRhx4AV
         5u3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=5rBLF7ic0qPgJOx9n9+R2A4Zr2m8hd5+1zZb6OaE3K0=;
        b=yKFZyDi7yKehVoC5zbeRDO2MMoJsoLzWEjkX/ej1xAznHfz1vL4xb9NkOu5lhC+9BX
         Nu5QYkW9hbqDpnI5RGvNxXKia/4wC3XnWALE8NsT6cXQ5UBvTGWsqFQ5Jq8yTFXtxgst
         /EhkmQOoX+/aKx6WHtP60E+QmwKAe38v22nw5fwYfpYKPfFkh0Zj5iyKHBMytkHkhNZQ
         ub/PdRawveEIloxC/DSYEHr7gQDo/3BFcKIePqdv/e8TTXR6NwXZ+6sgUvVD83mKsarL
         Hp5lfHIweghmKnn0osGqayGuicEdE+zQGEB2okBzlBs9zlCB9bW5HTpQSlT8xTBCqgTn
         1wpQ==
X-Gm-Message-State: ACgBeo1PaZEsApaQTcHt+nTNUxZupeakHWFUEedYiAJq7fBQK4fNs6VX
        YUePwClQLj1Zms3fGQjl4tim9f70MQGmmw==
X-Google-Smtp-Source: AA6agR5Su476lHbYjl/6NbDcDhvbYgNKFo/BZETP0Ihw0522I3AhJHC2+dB/BnAGWs/K/Eh5NMRf6g==
X-Received: by 2002:adf:d1c5:0:b0:222:cbe8:f9fa with SMTP id b5-20020adfd1c5000000b00222cbe8f9famr12818343wrd.383.1661987910783;
        Wed, 31 Aug 2022 16:18:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u18-20020a05600c19d200b003a5a5069107sm3317903wmq.24.2022.08.31.16.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 16:18:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 13/33] submodule--helper: move "sb" in clone_submodule() to its own scope
Date:   Thu,  1 Sep 2022 01:17:55 +0200
Message-Id: <patch-v4-13.33-474d1a9e13e-20220831T230519Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
References: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com> <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the only remaining use of a "struct strbuf sb" in
clone_submodule() to live in its own scope. This makes the code
clearer by limiting its lifetime.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c7833bae81e..2f1f0e1bf34 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1560,16 +1560,24 @@ static void prepare_possible_alternates(const char *sm_name,
 	free(error_strategy);
 }
 
-static int clone_submodule(struct module_clone_data *clone_data)
+static char *clone_submodule_sm_gitdir(const char *name)
 {
-	char *p, *sm_gitdir;
-	char *sm_alternate = NULL, *error_strategy = NULL;
 	struct strbuf sb = STRBUF_INIT;
-	struct child_process cp = CHILD_PROCESS_INIT;
+	char *sm_gitdir;
 
-	submodule_name_to_gitdir(&sb, the_repository, clone_data->name);
+	submodule_name_to_gitdir(&sb, the_repository, name);
 	sm_gitdir = absolute_pathdup(sb.buf);
-	strbuf_reset(&sb);
+	strbuf_release(&sb);
+
+	return sm_gitdir;
+}
+
+static int clone_submodule(struct module_clone_data *clone_data)
+{
+	char *p;
+	char *sm_gitdir = clone_submodule_sm_gitdir(clone_data->name);
+	char *sm_alternate = NULL, *error_strategy = NULL;
+	struct child_process cp = CHILD_PROCESS_INIT;
 
 	if (!is_absolute_path(clone_data->path))
 		clone_data->path = xstrfmt("%s/%s", get_git_work_tree(),
@@ -1658,7 +1666,6 @@ static int clone_submodule(struct module_clone_data *clone_data)
 	free(sm_alternate);
 	free(error_strategy);
 
-	strbuf_release(&sb);
 	free(sm_gitdir);
 	free(p);
 	return 0;
-- 
2.37.3.1420.g76f8a3d556c

