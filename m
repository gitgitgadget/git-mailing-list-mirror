Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1D5C433E1
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 21:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D010207CD
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 21:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tk/tjUpD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgGAVTO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 17:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbgGAVTN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 17:19:13 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77823C08C5C1
        for <git@vger.kernel.org>; Wed,  1 Jul 2020 14:19:12 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id z15so14322524wrl.8
        for <git@vger.kernel.org>; Wed, 01 Jul 2020 14:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Wip/BOAPjBQuilhDL536V1VaSJh22i2Ta+Tt/pVsoFM=;
        b=tk/tjUpDodJhAqJqd3vQ1ETupGyT8Cj6Y/sX3yl3QHF+42OmiPocIve3fJMUyWifQn
         jmqbsU5T3vnATG7gwuzbcG3Rke2JIqyd7HuEVH8mEEHxgqc2U+tOnBLkije1NwSPx/DJ
         aEkPJ/xt2/k5DHntOIzAeh/p8zRNC97xW1I20UIHwCb/MqvQjAVIfqlH1bDrtIsxWdGN
         uoOI5imxZlg8y1WznW7rWpRgPtvs6VQwotD4ntDYYbwYZNR9UrCTnebkXeUJ0brFO+7G
         9cueKnKVDdmP+X70YtsCoz3XDQu4Sq6zvnvUEUznw7pE5/5MoLVYNYXV5B7cVdvLFVVG
         SUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Wip/BOAPjBQuilhDL536V1VaSJh22i2Ta+Tt/pVsoFM=;
        b=PbcnVhDfpcJurMhfB+0S9e5+2I3NqRm9ZYedGozrhseeIlTm7jHPu1m3cyfcdxeqEW
         WN59/+aQD1SEDEvVx9UOavv452HLd5F4tET27VN4+uPSc2Rp/fiF8lZ2umwQxqWHhk1O
         L+y78z6djRzb5fwgACEzDfz2qeuN38j05WFS7K8nzyB8+dOowf77rmmTNSUvZSVHdGKb
         W0Yrukgw/JF6coTGj42w/T9GEGVULsyg5JOip71aiUDgiawfn3YMvf6E44pwbVKw9cKB
         ow3SdXLIM66tD+yXIGEiOZogtF9l0PPD/e3TD5+6X6Rv1p7NCBcBrlOZ/1LwVA4/5V9P
         Mb6Q==
X-Gm-Message-State: AOAM5314yWTyxy9itk6vkHknLVxES8ZrCim8ZxL3damt7qhlgBhvJNRq
        PnxI+9ucDXr5pWO60YPEB++oyqAc
X-Google-Smtp-Source: ABdhPJxOy7oAnYhQE8MB9aY36ZLQrtw+QA5AFiReyCfakxgyZ65ulw3Q/eqOaX6vsw4eWBOQSCAOAQ==
X-Received: by 2002:a05:6000:1283:: with SMTP id f3mr28762842wrx.106.1593638350942;
        Wed, 01 Jul 2020 14:19:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c20sm11094262wrb.65.2020.07.01.14.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 14:19:10 -0700 (PDT)
Message-Id: <5f933e852a525d4721b6f3e38ec12abf9c0d1aea.1593638347.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.654.v5.git.1593638347.gitgitgadget@gmail.com>
References: <pull.654.v4.git.1593107621.gitgitgadget@gmail.com>
        <pull.654.v5.git.1593638347.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Jul 2020 21:19:07 +0000
Subject: [PATCH v5 2/2] difftool -d: ensure that intent-to-add files are
 handled correctly
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In https://github.com/git-for-windows/git/issues/2677, a `git difftool
-d` problem was reported. The underlying cause was a bug in `git
diff-files --raw` that we just fixed: it reported intent-to-add files
with the empty _tree_ as the post-image OID, when we need to show
an all-zero (or, "null") OID instead, to indicate to the caller that
they have to look at the worktree file.

The symptom of that problem shown by `git difftool` was this:

	error: unable to read sha1 file of <path> (<empty-tree-OID>)
	error: could not write '<filename>'

Make sure that the reported `difftool` problem stays fixed.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t7800-difftool.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 29b92907e2..524f30f7dc 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -720,6 +720,14 @@ test_expect_success SYMLINKS 'difftool --dir-diff handles modified symlinks' '
 	test_cmp expect actual
 '
 
+test_expect_success 'add -N and difftool -d' '
+	test_when_finished git reset --hard &&
+
+	test_write_lines A B C >intent-to-add &&
+	git add -N intent-to-add &&
+	git difftool --dir-diff --extcmd ls
+'
+
 test_expect_success 'outside worktree' '
 	echo 1 >1 &&
 	echo 2 >2 &&
-- 
gitgitgadget
