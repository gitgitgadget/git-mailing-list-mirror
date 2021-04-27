Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF007C433B4
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 10:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AC4761168
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 10:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238325AbhD0KkT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 06:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238536AbhD0KjU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 06:39:20 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB00C061574
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 03:38:37 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id b19-20020a05600c06d3b029014258a636e8so2415989wmn.2
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 03:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XvRbhqFtpXvnwa48FbQUtw9R76XN3pC3c0d/dQlyi08=;
        b=LoRAM3oYFVEVLHdKvpCUkV6jJWTIrXoCvpZ2swriDPvKEPNG7vt+tejXBn8+8DB35i
         VecFWbSCfS3bfgNC16QiLJLuNoxuOEf0IQO4bNoZyQ0TxCcnUHl9NV8eAt3ECkKBOyzD
         NZulJsLviA9WpHZj023saFygIV1qanJEefozXcL0cJNXyA5IKxz4E5JnZC6hFf66TBAn
         2xXgvbdPZsoCpaTGH5m140Me+bj9Q46R1ZQT/0hTBiDpgm2mgiut9AGFLE3iwfh+cEfv
         VQB+nRfNHY+oUKzn9NXw32HYsXkKIzJJ0BTfCX4MqufuAtSx1PUHqBm1BA4yKNWzYnS9
         ItXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XvRbhqFtpXvnwa48FbQUtw9R76XN3pC3c0d/dQlyi08=;
        b=aACoICHNMPECYlzmW4c8M+97fUIOPmJPmG4l+Uvfra3+zFoHIJl+XwnoAioncCPs20
         ukB3fLEarL5xf3ooL33dWUffJQNYuzzBfp/4Ba6AMfBJrfjJK+lkCT4rfkKgD9YKbNoc
         YdOUA8en72ObOlMF2vuiLkCeBJIlYSpIAgB7UZXGJbh/ndNy9H7xn/W54n0mlmRL7od5
         5/Ev6sGnr8ncp/HXaUk1E1X+wlM6tmvnKH3NDg528ng9VjnfXDC+deUejHx51eAxh7Kw
         LeGHR5YyFWdbUEtfAZ9hCs9wyqyDEuTTTtLon4RSStOQOKxPJ4xgy7yRg6x1plkzC7eC
         Q7Fw==
X-Gm-Message-State: AOAM533uK73FohmJsfB4AoPGszL2U8p/+ff6ORzXmAQHbsu+fnNKN887
        MSslthnWYNhzaauIdMakSrDYAkDVGqg=
X-Google-Smtp-Source: ABdhPJye0Eliut05EcdWUOl5cDPrLlN2myZ+ypJ21uU/vNM3C+QE34/onF5fz06n4HmOWzHijwNaIw==
X-Received: by 2002:a7b:c4cf:: with SMTP id g15mr844409wmk.163.1619519915864;
        Tue, 27 Apr 2021 03:38:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g6sm4086192wrr.63.2021.04.27.03.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 03:38:35 -0700 (PDT)
Message-Id: <d7e5de8dba465098afa421d162df5ca7b0fb1a33.1619519903.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
        <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Apr 2021 10:38:22 +0000
Subject: [PATCH v2 21/21] t1415: set REFFILES for test specific to storage
 format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Packing refs (and therefore checking that certain refs are not packed) is a
property of the packed/loose ref storage. Add a comment to explain what the test
checks.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t1415-worktree-refs.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/t1415-worktree-refs.sh b/t/t1415-worktree-refs.sh
index 7ab91241ab7c..d6e6e523bbba 100755
--- a/t/t1415-worktree-refs.sh
+++ b/t/t1415-worktree-refs.sh
@@ -16,7 +16,10 @@ test_expect_success 'setup' '
 	git -C wt2 update-ref refs/worktree/foo HEAD
 '
 
-test_expect_success 'refs/worktree must not be packed' '
+# The 'packed-refs' files is stored directly in .git/. This means it is global
+# to the repository, and can only contain refs that are shared across all
+# worktrees.
+test_expect_success REFFILES 'refs/worktree must not be packed' '
 	git pack-refs --all &&
 	test_path_is_missing .git/refs/tags/wt1 &&
 	test_path_is_file .git/refs/worktree/foo &&
-- 
gitgitgadget
