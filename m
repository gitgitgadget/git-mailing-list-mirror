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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3376BC433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 06:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FBC660D07
	for <git@archiver.kernel.org>; Thu, 20 May 2021 06:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbhETGLN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 02:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbhETGLH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 02:11:07 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B9BC06175F
        for <git@vger.kernel.org>; Wed, 19 May 2021 23:09:46 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id z17so16274179wrq.7
        for <git@vger.kernel.org>; Wed, 19 May 2021 23:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xXgdDHvUd75yXjM8blIM7wuwHKtZQ9KdEC4eYenxuok=;
        b=Ez74KwLrXulikXysLQNVkTpz91mii5mUvAoPSjeFaZGzNCLiu1Aubkn4DxIf0h4UtT
         Zx0rI802YNA5pJyLxtfthFHjQyONBB3t0TtIkW5fRHogiKuPtHbzZ6FCrVO/+E/gq6E4
         kUSCqoOQBx2nAVUTIke+x/rIG5YTzd86Zg/rN1bIoUyVTADY8J7+i87nwNZWeUt4lqEh
         T9CIJCjIQ+q4lMdyYxAL2wTSJtEvTsrfCdduF2oYldCMZyAvQ8ycmqk8GYKbjkrXF78K
         XN8hYZyb5OciCUn2cwn7n3McyrpdGUoU9DC2FZXYlEJ/qcd2SXA8MkWh3kO8Kits1+WE
         guoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xXgdDHvUd75yXjM8blIM7wuwHKtZQ9KdEC4eYenxuok=;
        b=czrq82bYb45ooYbuK620KFlHDAdo2BFgy8QZoslvKNYgLN5uu/pXayyxKmPCiNPiQw
         xh37p0k3w536dlFjEeYfRQojsqgSpjIqi4SX2s13gDHdV2tSt0jH55O8dVVrICRm1bXr
         W6gGERG1djnFEKmtbstCKyG3VqwtylMA6FDpyhJkk374rzS11JE0pMEUIQZDKEnHYS+J
         aqx/5lx/CXoGB5XwmLtvW2i2OB7t0BHl3WDEraBBdFOmFyY2+AY36gXmPG0aFND//aRv
         /boBQ1re0hnWIRkiNwa0RTyjBFg8DlQnXYzflZTsAUygOpTyb385d3F2n/1WrybQanu2
         A6YA==
X-Gm-Message-State: AOAM532zaTHpy1jSxNpa3rARGC2RkcV2FyALUpIBKUriSHkFaJCdm9Rl
        konlkRnknUTo+F3iwIAJoYsPGexa4sk=
X-Google-Smtp-Source: ABdhPJzyS2F/P0QJthyYYB21pVBtlXtzdHeWC2wEUNwAt+xADBJEuxidR8AepGGCf3uthZZsx2FExA==
X-Received: by 2002:a5d:6d04:: with SMTP id e4mr1451598wrq.344.1621490985532;
        Wed, 19 May 2021 23:09:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p14sm1676717wrm.70.2021.05.19.23.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 23:09:45 -0700 (PDT)
Message-Id: <22b121ae1143eed7ae4fce8a40dbbe583db64a69.1621490982.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.859.v3.git.1621490982.gitgitgadget@gmail.com>
References: <pull.859.v2.git.1620094339.gitgitgadget@gmail.com>
        <pull.859.v3.git.1621490982.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 May 2021 06:09:31 +0000
Subject: [PATCH v3 03/13] fast-rebase: change assert() to BUG()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

assert() can succinctly document expectations for the code, and do so in
a way that may be useful to future folks trying to refactor the code and
change basic assumptions; it allows them to more quickly find some
places where their violations of previous assumptions trips things up.

Unfortunately, assert() can surround a function call with important
side-effects, which is a huge mistake since some users will compile with
assertions disabled.  I've had to debug such mistakes before in other
codebases, so I should know better.  Luckily, this was only in test
code, but it's still very embarrassing.  Change an assert() to an if
(...) BUG (...).

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/helper/test-fast-rebase.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/helper/test-fast-rebase.c b/t/helper/test-fast-rebase.c
index 373212256a66..39fb7f41e8c1 100644
--- a/t/helper/test-fast-rebase.c
+++ b/t/helper/test-fast-rebase.c
@@ -124,7 +124,8 @@ int cmd__fast_rebase(int argc, const char **argv)
 	assert(oideq(&onto->object.oid, &head));
 
 	hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
-	assert(repo_read_index(the_repository) >= 0);
+	if (repo_read_index(the_repository) < 0)
+		BUG("Could not read index");
 
 	repo_init_revisions(the_repository, &revs, NULL);
 	revs.verbose_header = 1;
-- 
gitgitgadget

