Return-Path: <SRS0=S8Id=BG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F4FC433DF
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 16:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D1782074F
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 16:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hv9+AQRG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbgG0QZv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jul 2020 12:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728398AbgG0QZu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jul 2020 12:25:50 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4105AC061794
        for <git@vger.kernel.org>; Mon, 27 Jul 2020 09:25:50 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k20so7724164wmi.5
        for <git@vger.kernel.org>; Mon, 27 Jul 2020 09:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fcG1uxJSj1b5X/sPchbdBLlultLpzdEeuOC1+K790wU=;
        b=Hv9+AQRGIC/0aRf7mPORGyuCKZ0Pnm1kFPK2Ax143mAC/E7bjAq7034h1LCwYw36cS
         VXR1mHkXGc7J+NxKONcHywKAp6CevepypQqW7ogDKVWRa/7l1ZyywwZuas649aYWYLh2
         Z1X3VMTZZOBfvsc/vHYIdNWWIaV37YdfaEBMBBux/9MJWhXzg9jcEildR/j4pMRt2FYK
         Sk/vjnAv+HBexq86ngbtRmCCulivN7ubEz6RdsozVMwJp2Ts1FRQCfu4dIIhvoGcAqHT
         bC2gvEhL8Ixuhtji3Pkq36XN8e+O+6TrWu0wcoSTC9q+/e2/4opYopc3RVdxTV9eLuKC
         Idzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fcG1uxJSj1b5X/sPchbdBLlultLpzdEeuOC1+K790wU=;
        b=pVY93IFg5CePX+6QjMrlR2BXfDmJi4d0mr8kQMVH79cA+H6i2PruXL8bVFL5473P/x
         /WKCcsnvJX/U7nPIn752WlmwajrfEj+H4IsnlpK6AcZ2+0RBYas65cKB02x/uDXXvWky
         shBxTP+O0+DECP6bGoStAngG4EzbEyFts77ImMqJ/6z1sWD+UrFqzTsNIEZl1J9oIW5h
         5Egvrco1ZiZbmqE5K9MwIp0QaJpb/z2zCcMfQww25Jdx/9KYkfiT/nOxZdIDIi+YBrv3
         2HWPmjgY7ZZLACvuACbid4a55HLYum+JpYz9BEjvA0KzqZz7wRHhYIUS8FLoqFQlwpyz
         XW5g==
X-Gm-Message-State: AOAM532ELpPlHUefF4TlydS3zdsqbglp5cOiT0Z4/CRS25RS5V0SHsYq
        /VDl812d2twHsJ/ew3GWjeUN1TAY
X-Google-Smtp-Source: ABdhPJxeHUb7WeTNQbjOAJjqYvQhBhn4z25L0VXM//JXyZCfEC+lgTk2R0v8wT1CDouNXUBB5a9+sA==
X-Received: by 2002:a1c:1bc4:: with SMTP id b187mr58891wmb.175.1595867148865;
        Mon, 27 Jul 2020 09:25:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m4sm94492wmi.48.2020.07.27.09.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 09:25:48 -0700 (PDT)
Message-Id: <pull.673.v4.git.1595867147.gitgitgadget@gmail.com>
In-Reply-To: <pull.673.v3.git.1594925141.gitgitgadget@gmail.com>
References: <pull.673.v3.git.1594925141.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Jul 2020 16:25:44 +0000
Subject: [PATCH v4 0/3] Remove special casing for PSEUDOREF updates
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This gets rid of the special casing code for pseudorefs in refs.c

This is in preparation for reftable.

v4

 * Address problems on case-insensitive file systems reported by Dscho.

Han-Wen Nienhuys (3):
  t1400: use git rev-parse for testing PSEUDOREF existence
  Modify pseudo refs through ref backend storage
  Make HEAD a PSEUDOREF rather than PER_WORKTREE.

 Documentation/git-update-ref.txt |  13 ++--
 refs.c                           | 127 +++----------------------------
 t/t1400-update-ref.sh            |  30 ++++----
 t/t1405-main-ref-store.sh        |   5 +-
 4 files changed, 36 insertions(+), 139 deletions(-)


base-commit: 5c06d60fc55d2213c089f63c282468080f812686
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-673%2Fhanwen%2Fpseudoref-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-673/hanwen/pseudoref-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/673

Range-diff vs v3:

 1:  28bd3534d0 = 1:  b5274d9053 t1400: use git rev-parse for testing PSEUDOREF existence
 2:  79cd5dd480 ! 2:  ba5f1b4d26 Modify pseudo refs through ref backend storage
     @@ t/t1405-main-ref-store.sh: test_expect_success 'create_symref(FOO, refs/heads/ma
       test_expect_success 'delete_refs(FOO, refs/tags/new-tag)' '
       	git rev-parse FOO -- &&
       	git rev-parse refs/tags/new-tag -- &&
     +-	$RUN delete-refs 0 nothing FOO refs/tags/new-tag &&
      +	m=$(git rev-parse master) &&
     - 	$RUN delete-refs 0 nothing FOO refs/tags/new-tag &&
     ++	REF_NO_DEREF=1 &&
     ++	$RUN delete-refs $REF_NO_DEREF nothing FOO refs/tags/new-tag &&
     ++	test_must_fail git rev-parse --symbolic-full-name FOO &&
       	test_must_fail git rev-parse FOO -- &&
     --	test_must_fail git rev-parse refs/tags/new-tag --
     -+	test_must_fail git rev-parse refs/tags/new-tag --&&
     -+	test_must_fail git rev-parse master -- &&
     -+	git update-ref refs/heads/master $m
     + 	test_must_fail git rev-parse refs/tags/new-tag --
       '
     - 
     - test_expect_success 'rename_refs(master, new-master)' '
 3:  3ab9f2f04e = 3:  358d34df07 Make HEAD a PSEUDOREF rather than PER_WORKTREE.

-- 
gitgitgadget
