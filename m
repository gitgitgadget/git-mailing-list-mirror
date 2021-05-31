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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1719C47080
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8030660231
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbhEaRl0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 13:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbhEaRks (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 13:40:48 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7928DC008744
        for <git@vger.kernel.org>; Mon, 31 May 2021 09:56:44 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id z17so11552873wrq.7
        for <git@vger.kernel.org>; Mon, 31 May 2021 09:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=oXDCwCoYsjtJJ4267KQX3PhWeWlR9PGSiVnfIIODzfY=;
        b=VAF4W95Z8W6N+271f9MMQ1w7jF6ZcdLBlOP/HGfTcko0PFkRyto3egoQOxdqaJW+PT
         eSZoiFJt927X28GH5J5gh6LCJH4tyb9o1mleGmfnBIcuy2x9ToX3IPknaF6zeqin2S0d
         0WogEi90vxNdhowfuyqc+JgSzvO8fGZhPhQRHKrBviUPHuoKJVEKePDeDiArySCqSKoq
         unJWiVT7WQzlOOplMPajsDRZycvafPMEmhGcvcECgMOSx9kF5Idz7MCupHrWn01ORQ15
         AMb6kTU1lGDVDAsgVaIXCZ0afpBKCe1zKIN1hJuSei+OA+0aOzZZrNp3aWI3Olv7MJi5
         aPrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=oXDCwCoYsjtJJ4267KQX3PhWeWlR9PGSiVnfIIODzfY=;
        b=Y5qddHtz3p0DPnn7s/xos6Z2xwZMb4FBlejU2yh/QbrVt8ssPUBTkKbkGq+twvErRK
         lTtXUasyZ0EmgkkAAzq8OJn1qU4Jh8CKFgK52i5MJzhTdxXM63eicn50T3s1D+l9CV8v
         Lc6iF0R+MWH43SOfXLq+oG/BULybpxTu1XTjO+DxS5p5LGAnC5o0xAZeIxuB3descIJZ
         lD1TNVsQDRQZ2dbAvtprTCDmAqjJqXCzrWH/0c1p/+Lq9bXUenpgYM8/4prdOQOJTt0o
         owvFHq8xRRoNgyDkwhDjiUES5+aM6sGYgx3BUlGuOD5uwwJ3tnPEx7XcNDcVU4pDHbUr
         13AA==
X-Gm-Message-State: AOAM533T15ruolKxGJh8b+IuJatUcRRPAinQh/nq3Q5VfI55TIJZVbqg
        Wq33yijE6F/I7CcDdhNwxTKr66MDpO4=
X-Google-Smtp-Source: ABdhPJxxcEcC+i3Fc1RsLAPQFL+q+y8eUsMkcS37g91KMOa+BrA3LXlelHfescKpqM5OAMVMOwXzyA==
X-Received: by 2002:adf:fa04:: with SMTP id m4mr4498561wrr.275.1622480203174;
        Mon, 31 May 2021 09:56:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a77sm13396047wmd.14.2021.05.31.09.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 09:56:42 -0700 (PDT)
Message-Id: <f6ab40c4e6599540da38ae5af8e574dc65909e79.1622480197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.v3.git.git.1622480197.gitgitgadget@gmail.com>
References: <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
        <pull.1008.v3.git.git.1622480197.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 31 May 2021 16:56:22 +0000
Subject: [PATCH v3 07/22] t1413: use tar to save and restore entire .git
 directory
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This makes the test independent of the particulars of the storage formats.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1413-reflog-detach.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/t/t1413-reflog-detach.sh b/t/t1413-reflog-detach.sh
index bde05208ae6a..934688a1ee82 100755
--- a/t/t1413-reflog-detach.sh
+++ b/t/t1413-reflog-detach.sh
@@ -7,8 +7,7 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . ./test-lib.sh
 
 reset_state () {
-	git checkout main &&
-	cp saved_reflog .git/logs/HEAD
+	rm -rf .git && "$TAR" xf .git-saved.tar
 }
 
 test_expect_success setup '
@@ -17,7 +16,7 @@ test_expect_success setup '
 	git branch side &&
 	test_tick &&
 	git commit --allow-empty -m second &&
-	cat .git/logs/HEAD >saved_reflog
+	"$TAR" cf .git-saved.tar .git
 '
 
 test_expect_success baseline '
-- 
gitgitgadget

