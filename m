Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C493BC433DB
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 20:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AF4F23AAC
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 20:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbhAHUE2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 15:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729057AbhAHUEW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 15:04:22 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A25C0612A4
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 12:03:08 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id v14so8728818wml.1
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 12:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ErszZlGN3ltMcK2sPORBKYvHBVvmshBvJvPsKViGnLY=;
        b=cGc52n5VMTpYMGiifyWv4LCnXcHfFCHJMKDUqNr7aLOOrtLRSceHSHsFHiWLf0fkVB
         NMPzGZ9ubpV0SvaJwuVIPemwieQXJFcseKM4BfHPZCN6q5WEDr694niK/EkflFofQvxy
         QbNNn6+G6pSWXcWDI/WwxN2eGup1HjGRAz0cPy0s/sJO9WCosMZUrvufXh6b6riqjQlR
         otp6eMf2eFDbxcHq9VeNmS5OAHhhGnfJP7FYPF67nPycBiQbWmDZ8jQ++1fb6KYQ8HFa
         4GDwnKB6hCPNOVaLqM6pvO3aI1gSzRUgsJFI98zsdF1l+n4BXeCdl0p0D7huT1x6HAPm
         GGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ErszZlGN3ltMcK2sPORBKYvHBVvmshBvJvPsKViGnLY=;
        b=lmhMthJ0LlB9zo5srMBZus8yLwUWMQhCuaWFnrDNdySUOTc6ACEVDBiLnOY9ezHXbJ
         luWGsgEgcnYWliNx22Mi03NZFRerTGUk+lwTL/T7i1J56uat7SRkT7DrhJylCJr8Bjc0
         1s2ukeyxYy07gDC55EB1iePKdSxufoAaDA5SWvzQVHQ9gVVdwgfVt9siYqtnaQfFQyfI
         YE3QJ6sHt7GiO03y01uU4WmhJzO2EChxGUemO2x1ZD/FDqScccKgHNeM3zEYFONImmQj
         YHkPBeguGyNmOXve50BcAH4JjGdHStfHi5V0aZuVD6nNeDRN6WZLvmSF7MgffaRNRTKh
         2LsA==
X-Gm-Message-State: AOAM5316h5ueXyTbYmEUm8QVdo7nLg/bbSpzwH/o6Py8N+uiZJqYdQ4S
        v9kwNmLUr5BrRI2RW0Xlz6E178f9wrw=
X-Google-Smtp-Source: ABdhPJwQFso1xXj6XhUO1/6bOR7flp8SrRRb3crtLZZAsi4hW8yf23EK994zY9vZ4jvblTgQEyTk8Q==
X-Received: by 2002:a1c:8f:: with SMTP id 137mr4593241wma.4.1610136186694;
        Fri, 08 Jan 2021 12:03:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 189sm13654743wma.22.2021.01.08.12.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 12:03:06 -0800 (PST)
Message-Id: <2eead833fbafdc3cb408532cdcb7e7bd0909d03a.1610136177.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.830.v3.git.1610136177.gitgitgadget@gmail.com>
References: <pull.830.v2.git.1609821783.gitgitgadget@gmail.com>
        <pull.830.v3.git.1610136177.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 08 Jan 2021 20:02:51 +0000
Subject: [PATCH v3 08/14] update-index: use remove_file_from_index()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

This is a mechanical replacement of remove_file_from_cache().

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/update-index.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index a24b1fc90e4..87fbc580032 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -251,7 +251,7 @@ static int remove_one_path(const char *path)
 {
 	if (!allow_remove)
 		return error("%s: does not exist and --remove not passed", path);
-	if (remove_file_from_cache(path))
+	if (remove_file_from_index(istate, path))
 		return error("%s: cannot remove from the index", path);
 	return 0;
 }
@@ -385,7 +385,7 @@ static int process_path(const char *path, struct stat *st, int stat_errno)
 		 * On the other hand, removing it from index should work
 		 */
 		if (!ignore_skip_worktree_entries && allow_remove &&
-		    remove_file_from_cache(path))
+		    remove_file_from_index(istate, path))
 			return error("%s: cannot remove from the index", path);
 		return 0;
 	}
@@ -472,7 +472,7 @@ static void update_one(const char *path)
 	}
 
 	if (force_remove) {
-		if (remove_file_from_cache(path))
+		if (remove_file_from_index(istate, path))
 			die("git update-index: unable to remove %s", path);
 		report("remove '%s'", path);
 		return;
@@ -555,7 +555,7 @@ static void read_index_info(int nul_term_line)
 
 		if (!mode) {
 			/* mode == 0 means there is no such path -- remove */
-			if (remove_file_from_cache(path_name))
+			if (remove_file_from_index(istate, path_name))
 				die("git update-index: unable to remove %s",
 				    ptr);
 		}
@@ -671,7 +671,7 @@ static int unresolve_one(const char *path)
 		goto free_return;
 	}
 
-	remove_file_from_cache(path);
+	remove_file_from_index(repo->index, path);
 	if (add_cache_entry(ce_2, ADD_CACHE_OK_TO_ADD)) {
 		error("%s: cannot add our version to the index.", path);
 		ret = -1;
-- 
gitgitgadget

