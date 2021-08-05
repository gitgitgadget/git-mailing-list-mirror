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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA204C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 15:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E99A60EE5
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 15:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241887AbhHEPIL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 11:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241407AbhHEPIB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 11:08:01 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F183EC0613D5
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 08:07:45 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id m19so3609726wms.0
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 08:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XSF1JyToATJTm5Rj3t3fcHTUneW/f9TA9iR5ymx0ULU=;
        b=Nj7BPFrpnKw3IjelHuI+bKvkMiO0BuPYrYzcEMy6lJiNcUnKj9/yST/U8zISVKhEVl
         SKH+0vfRsNzlaJQDyZ+D8VX6ARl9SxaFo8SemGYXkov66CT/iK1PzJCzw5/c5NPOJ09/
         FrzK4osfEpZnodMcMYCziff68erZqPv5izMsGXy7IkSeQepQ2xxw/PbY8mq/HLcQuCfb
         WsPlJWtG2ELePVNKeGP7uQbdHHQ8Ih+sj99Y21K+AIKUvEY6gKFkMu6TBYVb9kfJgomj
         g65j3jaLl+iX4AQYldWmI34Zy8nmgZFzG4QD/AvUHYe0sg7nMEusWIDdxgkrI0wTGV7D
         dzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XSF1JyToATJTm5Rj3t3fcHTUneW/f9TA9iR5ymx0ULU=;
        b=ISrdDwomQn5vX7hlsLxbloixYLh/yShEbA0xdgrKFdbtiOJBfyEbXdlvng/dUDLizT
         AG5woearpFC8uqMeCMHPqpRKfBhcHQhKa82N8+E+Kx4K/Rxqcrauxfcc+AX4/63gRXB/
         4Jy3GK03kTcu4xLOdUvHv7vL5CsSfTkfJX7IhkFFR0oXSCkPHXFeIKR5BzOkPChNWOuJ
         Rmk2GJk6rc5WrZZgob85aWNnkpnqcc3i6o5/OXq6qeXSmEQcXI+xuyQsnJtuWl+dHWtl
         LA1UWYzV/wOjspUsRA3+GKplYCc8KFDGU2+i5sZoMf4QMXembGJcuN53yWdIx5+0T/Q+
         gbAw==
X-Gm-Message-State: AOAM53328AZK0Bc9oUa+C1c0wiwx/6kS3mp7Jg7KyV1GdPYCUKd2/Jit
        RRv2fVe96IcKu5pKt6PNCHWhe0FqXb2Mxw==
X-Google-Smtp-Source: ABdhPJyhCJqbv/zqZpSVgJNNtpGWuK295QSJYoySEoVagAmi41rZDV6jph8O8Z8nR0ZSnUUezLfj4w==
X-Received: by 2002:a1c:153:: with SMTP id 80mr15343490wmb.53.1628176064374;
        Thu, 05 Aug 2021 08:07:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w4sm6856340wrm.24.2021.08.05.08.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 08:07:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 10/13] fetch-pack: move --keep=* option filling to a function
Date:   Thu,  5 Aug 2021 17:07:26 +0200
Message-Id: <RFC-patch-10.13-f04cf22da4-20210805T150534Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.646.g585563e77f
In-Reply-To: <RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com>
References: <RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the populating of the --keep=* option argument to "index-pack" to
a static function, a subsequent commit will make use of it in another
function.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fetch-pack.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index b0b21cc969..ef07b45072 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -826,6 +826,16 @@ static void parse_gitmodules_oids(int fd, struct oidset *gitmodules_oids)
 	} while (1);
 }
 
+static void add_index_pack_keep_option(struct strvec *args)
+{
+	char hostname[HOST_NAME_MAX + 1];
+
+	if (xgethostname(hostname, sizeof(hostname)))
+		xsnprintf(hostname, sizeof(hostname), "localhost");
+	strvec_pushf(args, "--keep=fetch-pack %"PRIuMAX " on %s",
+		     (uintmax_t)getpid(), hostname);
+}
+
 /*
  * If packfile URIs were provided, pass a non-NULL pointer to index_pack_args.
  * The strings to pass as the --index-pack-arg arguments to http-fetch will be
@@ -895,14 +905,8 @@ static int get_pack(struct fetch_pack_args *args,
 			strvec_push(&cmd.args, "-v");
 		if (args->use_thin_pack)
 			strvec_push(&cmd.args, "--fix-thin");
-		if ((do_keep || index_pack_args) && (args->lock_pack || unpack_limit)) {
-			char hostname[HOST_NAME_MAX + 1];
-			if (xgethostname(hostname, sizeof(hostname)))
-				xsnprintf(hostname, sizeof(hostname), "localhost");
-			strvec_pushf(&cmd.args,
-				     "--keep=fetch-pack %"PRIuMAX " on %s",
-				     (uintmax_t)getpid(), hostname);
-		}
+		if ((do_keep || index_pack_args) && (args->lock_pack || unpack_limit))
+			add_index_pack_keep_option(&cmd.args);
 		if (!index_pack_args && args->check_self_contained_and_connected)
 			strvec_push(&cmd.args, "--check-self-contained-and-connected");
 		else
-- 
2.33.0.rc0.646.g585563e77f

