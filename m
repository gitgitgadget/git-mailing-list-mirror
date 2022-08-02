Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA13AC19F29
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237550AbiHBPzZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237497AbiHBPzM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:55:12 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E653621E00
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:54:59 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id p10so14234219wru.8
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 08:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=gIYfotKNcmd2iLUWaGhOHgEa+QQIFLm6/+sQqP6TWl4=;
        b=CwKDX6CH+wY1v0vHnwG3UloF2GI8h5rQW5kW1sIpi+JPR8BPeVhBgyjUEJN93mkLqC
         OEl2J3b6mfONRStTmguGHTExsyakQ6Q5zOaGVjvjIjQXtcwDbTKGhEv7SI3TQkQj5fZ4
         ewBHRWgP3vcXA3pBLk7PS0bUhvATJc5j5CHJSKMdsXGOSf8bmUi5sOoM+MoeAe240v2t
         6RfqZzskCXZ5ofS54piGFggxMoVN5WaIaJrMvrwAqLpfTtxK8/ihgd5mtO07CIPH9/LL
         vuxOGGZ9IiFmE6NFBApWar9GcJxFlPJmId2Tn9nOfFl1ypJFBeKFiLfbOlYDGDe6VOr6
         /AMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=gIYfotKNcmd2iLUWaGhOHgEa+QQIFLm6/+sQqP6TWl4=;
        b=bKGwrobOueXYfFbBGNc0nNT8JxQDAasuj0KjOphAIqCcvKEnGc7GRno8g3udlVItLS
         3PzuM7EsPYDYmUVN0bdPHCOxOxeaty2P1MoaClWZjNC1RDf9hwVx+rgfIUp/mVRvWzW3
         ZgiFIb1wUKDZgO005TjcqlcF+UwEoQk6TLr3TGY7F9h9w/IwX0eofAWXofEeKtPXxlCQ
         3szkbVkQao53aCJ5CMGnDVt15CUcwUEBxEGAKgqOQK4w6XAx3z2o13J8oesghnir1eYr
         mUapLzM9/9ebZ56eaC5mX63N/rxT8O7UH7AdKZhw82xiGZJAEP61K0UX4Id2t9KOT1gx
         N4XQ==
X-Gm-Message-State: ACgBeo1FEol9+zkSz6xJk+meXhyY9XtAydQqOV+piSpVmizlwYlphvUi
        zECOjQMED0oG75BbVRD8YIPIC7VBEct9OA==
X-Google-Smtp-Source: AA6agR5WRdJWgwY/jvuauYktXrBBMbYHNVJHAf9yAtBTt/EaHwnMwGa8xbRr8ZCcoc5vynkIYuWJSg==
X-Received: by 2002:a5d:6d0b:0:b0:21d:9f54:efa2 with SMTP id e11-20020a5d6d0b000000b0021d9f54efa2mr13230807wrq.607.1659455698073;
        Tue, 02 Aug 2022 08:54:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bg3-20020a05600c3c8300b003a327b98c0asm23562286wmb.22.2022.08.02.08.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:54:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 13/17] submodule--helper: fix a leak in module_add()
Date:   Tue,  2 Aug 2022 17:54:37 +0200
Message-Id: <patch-v5-13.17-71a56c59864-20220802T155002Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.ge8b09efaedc
In-Reply-To: <cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com>
References: <cover-v4-00.17-00000000000-20220728T162442Z-avarab@gmail.com> <cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a leak in module_path(), since a6226fd772b (submodule--helper:
convert the bulk of cmd_add() to C, 2021-08-10), we've been freeing
add_data.sm_path, but in this case we clobbered it, and didn't free
the value we clobbered.

This makes test 28 of "t/t7400-submodule-basic.sh" ("submodule add in
subdirectory") pass when we're compiled with SANITIZE=leak..

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 9cc92b4da9e..2fca6d66bb5 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3305,8 +3305,12 @@ static int module_add(int argc, const char **argv, const char *prefix)
 	else
 		add_data.sm_path = xstrdup(argv[1]);
 
-	if (prefix && *prefix && !is_absolute_path(add_data.sm_path))
-		add_data.sm_path = xstrfmt("%s%s", prefix, add_data.sm_path);
+	if (prefix && *prefix && !is_absolute_path(add_data.sm_path)) {
+		char *sm_path = add_data.sm_path;
+
+		add_data.sm_path = xstrfmt("%s%s", prefix, sm_path);
+		free(sm_path);
+	}
 
 	if (starts_with_dot_dot_slash(add_data.repo) ||
 	    starts_with_dot_slash(add_data.repo)) {
-- 
2.37.1.1233.ge8b09efaedc

