Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467C8C433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 20:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240276AbiGSUsD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 16:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240153AbiGSUrq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 16:47:46 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B779A53D11
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 13:47:43 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id j29-20020a05600c1c1d00b003a2fdafdefbso72787wms.2
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 13:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IjQzrCWOS09WApscpMSNnn9G7eKgtIMtCQP6Gee9d1c=;
        b=VVQKL+pNtk5lQ7G6BHczwE1+Nj3txriWmW0lacl1vk2jiJ/ljy6q8l7/yaXskUFQam
         UomsPfSiU6dEENoOgZfLrOxqTnFSABD7xZRMbp91kKrTMUzXp4qfpIsEPGEzCb83AzDt
         2WopcKqFAZ6Qb4TYzq4YHzmCWmo9ySEqJMvoe+THG+o4jF105G37LnYYYhGHMpdlKSbx
         WXnNTgb39hxt2XatJLFDRTI/c/levIA7cTJINZyCZ8ci87JiP8CzacDuxNh0JACpSGS7
         9KSHNUtzZOoCeTCp4aWFK0tOKIfzryhecaI9k78qPowK2JMp8tayQErs9DfcwCRPKc/u
         LwbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IjQzrCWOS09WApscpMSNnn9G7eKgtIMtCQP6Gee9d1c=;
        b=o/yFJB60DrYni3n41JZbzfwWedgoN7QSl4H9NV7T7PVWddzcVvUqpAvWL6T+U4n3si
         IGTtwF4KhvEQJd8JmRzBkLt+rjSiH9MwsM77O0hiLwLmdJOS8Zk7zeTc0HR2+sVkMZBc
         M25Dlm60YQtR6pa+nGE/tSC3asFTT54IPK5DtETSiZdNFYgEIBJALv+UVUemJqWRMx72
         SrljSuOGs7yhZWM+mbogCvGwIAYfL4A3JWZEvzU0lSLtH3dl9kI8HfuTOARvrf4suhew
         ptMRK5ZhYG2OVCw6Cm3klU2Hef1KrdXIqoXyGWR3XGj1S2J5BDZ0m2YKRkDyYFVtRGsZ
         dtWg==
X-Gm-Message-State: AJIora8hWGq02HGaS+Oi8vg9PEqR7iQo6oNeJMT4DnpG7IhmXVKQir1q
        0zECopwfk7EA97Y87I47+Y6Q9U2wA/1eJg==
X-Google-Smtp-Source: AGRyM1vUgpQzHKP0mudvxgyiOOQ6TjPfjJjvMIKEh9XhCxbZ6XHvH5KpuHzVJ0Xgq82UzN5FkYx2Yw==
X-Received: by 2002:a05:600c:4ec9:b0:3a2:e9bd:fcd9 with SMTP id g9-20020a05600c4ec900b003a2e9bdfcd9mr914401wmq.154.1658263661959;
        Tue, 19 Jul 2022 13:47:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c1d1200b003a04d19dab3sm4711348wms.3.2022.07.19.13.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 13:47:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 17/24] submodule--helper: fix a memory leak in print_status()
Date:   Tue, 19 Jul 2022 22:47:08 +0200
Message-Id: <patch-v2-17.24-12b8a945486-20220719T204458Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1062.g385eac7fccf
In-Reply-To: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com> <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a leak in print_status(), the compute_rev_name() function
implemented in this file will return a strbuf_detach()'d value, or
NULL.

This leak has existed since this code was added in
a9f8a37584a (submodule: port submodule subcommand 'status' from shell
to C, 2017-10-06), but in 0b5e2ea7cf3 (submodule--helper: don't print
null in 'submodule status', 2018-04-18) we added a "const"
intermediate variable for the return value, that "const" should be
removed.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 642595cc3f4..75e842af5ca 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -643,10 +643,11 @@ static void print_status(unsigned int flags, char state, const char *path,
 	printf("%c%s %s", state, oid_to_hex(oid), displaypath);
 
 	if (state == ' ' || state == '+') {
-		const char *name = compute_rev_name(path, oid_to_hex(oid));
+		char *name = compute_rev_name(path, oid_to_hex(oid));
 
 		if (name)
 			printf(" (%s)", name);
+		free(name);
 	}
 
 	printf("\n");
-- 
2.37.1.1062.g385eac7fccf

