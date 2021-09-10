Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2501C433EF
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 10:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4F9E61100
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 10:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbhIJKce (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 06:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232360AbhIJKcb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 06:32:31 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F219C061756
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 03:31:20 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id c8-20020a7bc008000000b002e6e462e95fso1084848wmb.2
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 03:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3rh0R0pn+Z1sG9tBC3jFGwNSFE8XWOMkSfXv5FaXno0=;
        b=kJHkvT7W7pWafDdD+IZ7Gpw3IEBbjBwzg37nFyKkJXferIHaGNk7gbryvbrCs6yIcL
         CSAb7vRd6S4SDqAPS2ElqqvffzbZLriRze95m6TADD/hUXRP5eVQEmZffv9cwlnD+M1m
         dy5eakZRyv6ko0o6zFkf1E8OwXiDUH9dIJe8om3042RERIAFloN3kDvb3QY8t86S26kA
         krozljVz4tSx/jiGP4b+mVpjG4PvRf/T/S97oDBAHk916HvDlNxl44KeVeJKrUM/LqNM
         ofUTTy63vfawC8M0M8JYyuU53KLnJfaN9azWfZ56g07C0hkGyYSAoct/Rzucfx8xmIVY
         QVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3rh0R0pn+Z1sG9tBC3jFGwNSFE8XWOMkSfXv5FaXno0=;
        b=C+2rUcLsfONxxV1u991U/WLUBoX5oM4d5GPRVLT2a1VQH7rmdAM9XxtqVNDtXX47KL
         w1mFF3rdLM5sAAzcJiHSfhgFjupojgIP+Q6Bftfmh/kVkdlFPB2sqaQ8+2pckDLArnwU
         QwLOeZrfzbQlbpLa7DQ2qotbmmYSi91HhkWk6Bg4KmcPDp7ZMNf6rW0H8pdL9Gh92dMd
         CHbzHL83cjImC0+UJEiQj6YSLFedHH5RhVxjuhrucNWTqRHdd9+xJd8ppqRWogCHJFlw
         FWOTHx/7F4ClFttwSs5okCFqd9JvE4zQ5VC++JkcGlbFs7csW0HlaiGXJ1gNJnUa1IoN
         BHsA==
X-Gm-Message-State: AOAM530flErmf7QeeSv3QPFEuh3rFqxNRQyMEUTBzNn0Ij+kXbWG6XPV
        /I/omrswlVx+ALe7fYb8NiD7ej2fDhs=
X-Google-Smtp-Source: ABdhPJzYnZTp8mSjQev017XS+MfHxtgTzEDbeh0ATDOusSwy7Mjrhb/hnfuGNHA7mVydHjH8xnHJHw==
X-Received: by 2002:a1c:2684:: with SMTP id m126mr7716198wmm.65.1631269879182;
        Fri, 10 Sep 2021 03:31:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s7sm4278786wra.75.2021.09.10.03.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 03:31:18 -0700 (PDT)
Message-Id: <a46f5c79fbf40be98d4e679ff14197f995bd804a.1631269876.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1087.v2.git.git.1631269876.gitgitgadget@gmail.com>
References: <pull.1087.git.git.1631067429.gitgitgadget@gmail.com>
        <pull.1087.v2.git.git.1631269876.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Sep 2021 10:31:16 +0000
Subject: [PATCH v2 3/3] am: fix incorrect exit status on am fail to abort
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/am.c        | 3 ++-
 t/t4151-am-abort.sh | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 0c2ad96b70e..c79e0167e98 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2106,7 +2106,8 @@ static void am_abort(struct am_state *state)
 	if (!has_orig_head)
 		oidcpy(&orig_head, the_hash_algo->empty_tree);
 
-	clean_index(&curr_head, &orig_head);
+	if (clean_index(&curr_head, &orig_head))
+		die(_("failed to clean index"));
 
 	if (has_orig_head)
 		update_ref("am --abort", "HEAD", &orig_head,
diff --git a/t/t4151-am-abort.sh b/t/t4151-am-abort.sh
index 15f2f92cd76..2374151662b 100755
--- a/t/t4151-am-abort.sh
+++ b/t/t4151-am-abort.sh
@@ -197,7 +197,7 @@ test_expect_success 'am --abort leaves index stat info alone' '
 	git diff-files --exit-code --quiet
 '
 
-test_expect_failure 'git am --abort return failed exit status when it fails' '
+test_expect_success 'git am --abort return failed exit status when it fails' '
 	test_when_finished "rm -rf file-2/ && git reset --hard && git am --abort" &&
 	git checkout changes &&
 	git format-patch -1 --stdout conflicting >changes.mbox &&
-- 
gitgitgadget
