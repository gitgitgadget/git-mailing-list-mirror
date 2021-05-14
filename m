Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2C2C433ED
	for <git@archiver.kernel.org>; Fri, 14 May 2021 12:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E6F661460
	for <git@archiver.kernel.org>; Fri, 14 May 2021 12:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbhENMP5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 08:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbhENMPx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 08:15:53 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD99EC061574
        for <git@vger.kernel.org>; Fri, 14 May 2021 05:14:40 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id o202-20020a4a2cd30000b02901fcaada0306so6298641ooo.7
        for <git@vger.kernel.org>; Fri, 14 May 2021 05:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qZrtjJEPOYxI0V6zwApFtoCcpSCr4zUBrY8JWBelif0=;
        b=urcaCefx5VvBmgnv4vG+gepjixMg61/9owqfGwU7vMRB+eEbvNz2v7J/wyShjETpmJ
         3aJl6n6L+io5G9WNL5RgH3aXTeePi0R9sD78N4Ct2XcQpPmNX7tLSeMqmu3i84XQrjcO
         A+QWKZzjFG4k5ZjJ1gmLtQVbTbTggao88Kd/NYd+vlU2zaJhymRtjvGEcCqhDl7k5bNx
         1Oh/5jFhVKaY2HkqNDqNPXLtU6slISir/bc0GQ8pfPZhsYPavaXWHNRE4JyooX1BUCUK
         s0PHMRVdTwcJjgcqXV/Zk9S/lmxUfTxLHuPiP0P43XYXTBFOdw1CWXe1pNUT3SMLqcph
         dduQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qZrtjJEPOYxI0V6zwApFtoCcpSCr4zUBrY8JWBelif0=;
        b=rqxzgmpLCPasCirBOofXovo+BfSV8uFRpGuqbkrpiA0lXgO3LUOS7UwurojJf/3ScE
         Eu0Nu/P4kjCKEbanXoZ91BoA7XEgw/x9ccT2Ilv91dSHcHdEV19zeAaShMekj8O4hrYB
         YeoIu8ZhVC4UNJJWkSmOjcj7PLyGJpmNbuRu0g6e3FCKhhtMJZMjwSnkEdsFR+ZhnWeQ
         uKLWfJXkpITWLnOLywddvu62eTkrxNB0gq9Z7BPD2dh9ORlrz4al7Op1ZUskOXA9IZ2f
         xDe+U1fk5enNU71gCd666mwcB0p0kW85si3D28Umg0/HjtNuYfQjmP2IKqGKp/PVMkIh
         MvNA==
X-Gm-Message-State: AOAM531IqAjNrPoYryIc2DyqIdgSh8WPzCIoHzk7/ndy8fS7//Hn5szd
        mcn8CLrzrY8xhHKX7tLmcFZMErH9InKWyg==
X-Google-Smtp-Source: ABdhPJzB+G9tnQdNBpDMA/BmaINGBkV+1wBoeCHHpfNRhJyAUK9bfAZIKhyMsS9jkv7A8r6P3JHFFQ==
X-Received: by 2002:a4a:3516:: with SMTP id l22mr5181406ooa.65.1620994480111;
        Fri, 14 May 2021 05:14:40 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id s3sm1107816oie.35.2021.05.14.05.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 05:14:39 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 02/11] doc: doc-diff: allow more than one flag
Date:   Fri, 14 May 2021 07:14:26 -0500
Message-Id: <20210514121435.504423-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210514121435.504423-1-felipe.contreras@gmail.com>
References: <20210514121435.504423-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/doc-diff | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/doc-diff b/Documentation/doc-diff
index 1694300e50..ecd88b0524 100755
--- a/Documentation/doc-diff
+++ b/Documentation/doc-diff
@@ -146,7 +146,7 @@ render_tree () {
 	# through.
 	oid=$1 &&
 	dname=$2 &&
-	makemanflags=$3 &&
+	makemanflags="$3" &&
 	if ! test -d "$tmp/installed/$dname"
 	then
 		git -C "$tmp/worktree" checkout --detach "$oid" &&
@@ -181,6 +181,6 @@ render_tree () {
 	fi
 }
 
-render_tree $from_oid $from_dir $from_makemanflags &&
-render_tree $to_oid $to_dir $to_makemanflags &&
+render_tree $from_oid $from_dir "$from_makemanflags" &&
+render_tree $to_oid $to_dir "$to_makemanflags" &&
 git -C $tmp/rendered diff --no-index "$@" $from_dir $to_dir
-- 
2.31.1

