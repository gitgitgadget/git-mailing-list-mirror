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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C07C11F64
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 01:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C6B961CCE
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 01:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbhF2Byd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 21:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbhF2ByT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 21:54:19 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70909C061787
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 18:51:50 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id u11so23618395wrw.11
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 18:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9FJe++5tdMAw1p1s1FtpPZqddDVWa7mla9SPDPEisaI=;
        b=LMAJJdBd3ynb49qRlv+UUcRcGmPHyU3op1l0ZhyaxBj26X76bDwpCMuqXb2jJC3oMz
         O7kLQz825CD8mBqb01H/Ecz1+tpgDnN/sSNKAVUSlIPJyTBzipKf/wp5FajUGsRSkgbY
         oTMYhWhjhko8QlSPe9pDwfyJtOEALBMk+pCjdps+/hpPddxBRoMokaCMEB3gF11cJVF1
         NmcVfn3NSvh/sZaC1cqF/o90PPbNkxdYPQpswWRvSWdU2tKTlAlRr/EdjlaYMo/QsleE
         c86jKNNLncTGy3IYQkFCRw1MKbsF9BODYzmvs89pYYhugF/M/ANEMCYox3urBIY+9F54
         befg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9FJe++5tdMAw1p1s1FtpPZqddDVWa7mla9SPDPEisaI=;
        b=uVZukQ63vu0KDtDwa8ZuJj1lHs6auFb8t8KKjr7jeURxo4Ka23dET69CrZ0s0M/qEF
         BFIYOcP2G2ZZiG6i2Z/4Ll6AtJhIJivrbCaYzCm5qAYhyBtb6eRYN22UzHYHhictc8rS
         vkUSweks4CaPwYZOsQJPSmEcDtOH5C8mweBuQZND200oED5oDp6pJK5HJpuNbfI8BaN0
         SuVU+NQ2NEZOkoyTfPAVwIcCF6PfQqJhFGo0OhA0ugrt+2zNPjKsM07ib+12wDSaVxX7
         HhlJchXmkk/ck5Lc5VRTbVKuU7tUmhjogaZa0bXfY+FRc1yba0aWFm6jE8fg5bNnusnQ
         4zYQ==
X-Gm-Message-State: AOAM531I2NNoe2pq79Jrzyh8d0UaAnrkzfqi8HK33oL6DXt0Y5vNlea0
        tNfYC42t9BxkCmGHQjFtLjHOY6ZBAA8=
X-Google-Smtp-Source: ABdhPJwVJYD/xyEl85lsbIMdQmasP2/Dmg+SObcts5+7JaM/st0kDINusya6ml9zJeyhwOZ/fwZdmg==
X-Received: by 2002:a5d:6d87:: with SMTP id l7mr1175210wrs.222.1624931509161;
        Mon, 28 Jun 2021 18:51:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z3sm1077049wmi.29.2021.06.28.18.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 18:51:48 -0700 (PDT)
Message-Id: <d693f00d9a28fff049a3e1d469ac3024b9f99bb4.1624931502.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v6.git.1624931502.gitgitgadget@gmail.com>
References: <pull.932.v5.git.1623069252.gitgitgadget@gmail.com>
        <pull.932.v6.git.1624931502.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Jun 2021 01:51:37 +0000
Subject: [PATCH v6 09/14] dir.c: accept a directory as part of cone-mode
 patterns
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>, git@jeffhostetler.com,
        johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When we have sparse directory entries in the index, we want to compare
that directory against sparse-checkout patterns. Those pattern matching
algorithms are built expecting a file path, not a directory path. This
is especially important in the "cone mode" patterns which will match
files that exist within the "parent directories" as well as the
recursive directory matches.

If path_matches_pattern_list() is given a directory, we can add a fake
filename ("-") to the directory and get the same results as before,
assuming we are in cone mode. Since sparse index requires cone mode
patterns, this is an acceptable assumption.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 dir.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/dir.c b/dir.c
index ebe5ec046e0..2155107b1d7 100644
--- a/dir.c
+++ b/dir.c
@@ -1397,6 +1397,17 @@ enum pattern_match_result path_matches_pattern_list(
 	strbuf_addch(&parent_pathname, '/');
 	strbuf_add(&parent_pathname, pathname, pathlen);
 
+	/*
+	 * Directory entries are matched if and only if a file
+	 * contained immediately within them is matched. For the
+	 * case of a directory entry, modify the path to create
+	 * a fake filename within this directory, allowing us to
+	 * use the file-base matching logic in an equivalent way.
+	 */
+	if (parent_pathname.len > 0 &&
+	    parent_pathname.buf[parent_pathname.len - 1] == '/')
+		strbuf_add(&parent_pathname, "-", 1);
+
 	if (hashmap_contains_path(&pl->recursive_hashmap,
 				  &parent_pathname)) {
 		result = MATCHED_RECURSIVE;
-- 
gitgitgadget

