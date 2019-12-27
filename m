Return-Path: <SRS0=DNff=2R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF0EC2D0C6
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 13:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 818AB21582
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 13:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcJ9XzFT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfL0Nrm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Dec 2019 08:47:42 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46444 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbfL0Nrl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Dec 2019 08:47:41 -0500
Received: by mail-qk1-f195.google.com with SMTP id r14so21504489qke.13
        for <git@vger.kernel.org>; Fri, 27 Dec 2019 05:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=XiHQuyipC06U7f1JdrTdwdShkKFIbWAMKbxCMzYKevE=;
        b=NcJ9XzFTWa1y33Ogys0VTIwKyyxdeF95BW2qp5lJLRZy2G7Le8RdE4G/QPmsUZvGX4
         vqPZIVx1RaD8/J1YO8BL/7p/xJ+B6b0+ii2Jgd9K+SdINplzBduO1E1oNoVH5NcNSn2N
         wJm9WTG+babClKBGqfOCc9bWD+aiwvH8bCTGt1QWlXPBgTFz90wY5tXxOncHkNeFvbtv
         jFdIthIcaMntd3FMdz2y4sXLJxf2NZsFp4aWVoDI93Cj9WsuCt/lc8wusVrh3PfbyzEJ
         RhmO7S59nPGMbG/EubEkL3PZGwPm7oXgGzKjdmkqnM6GQzr8Dh5xFMsVvnWLt8Qe263s
         O90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XiHQuyipC06U7f1JdrTdwdShkKFIbWAMKbxCMzYKevE=;
        b=pFmPgzAXNeuR1qfMdOufhQYhV2Y3x9jn4dOxlWaGz5hR7QF8jL4GrO83issKRvPI4c
         1cg5JGVrI1q6WK9Nct+thaWz5wLsA7Iy1HqPhoMLpH6VWAM6lDGWAeqaEaKo7sZImfD/
         dtIeOHn7w9R2nKqAKPJHU7C4nE57ZYw3GClEC60OuZ8BogJA6btXLnzGear7aKNR5NDa
         q3ZW4t+qlbJFg3hOTpjfsvKFDOFm8x6kNfj111cQ3LoQhJVx/xbmmcsMK4JLzCvc9m6S
         FdE/jUhKMdynwXehrHcPktFH7VHhTi1/noV9qpJml/wf6jDW7xnh6fcLmIfYNs193cpF
         z6+g==
X-Gm-Message-State: APjAAAV3qCBfFnvCItHebYjsVWfA7Whttd1MPzi0vfBJzrdGx/vWpNGb
        q2nV1e6dssgbl3+vWgBV2wxqyb0b
X-Google-Smtp-Source: APXvYqxQ21WGtb2OTKAlCrPXDHFAPAVPQCvq22DTa3WJl8QPFkdO/WWRHcpSLiY9t7n6/Co7illDSw==
X-Received: by 2002:a37:4b56:: with SMTP id y83mr43509914qka.42.1577454460030;
        Fri, 27 Dec 2019 05:47:40 -0800 (PST)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id d9sm10510184qth.34.2019.12.27.05.47.39
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2019 05:47:39 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 05/16] t2018: don't lose return code of git commands
Date:   Fri, 27 Dec 2019 08:47:14 -0500
Message-Id: <4fe247c09df89ebe908f366ee7c2a4ec1c209d86.1577454401.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.810.g65a2f617f4
In-Reply-To: <cover.1577454401.git.liu.denton@gmail.com>
References: <cover.1577454401.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We had some git commands wrapped in non-assignment command substitutions
which would result in their return codes to be lost. Rewrite these
instances so that their return codes are now checked.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t2018-checkout-branch.sh | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index 43551332ed..69758041f4 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -23,7 +23,8 @@ do_checkout () {
 	exp_ref="refs/heads/$exp_branch" &&
 
 	# if <sha> is not specified, use HEAD.
-	exp_sha=${2:-$(git rev-parse --verify HEAD)} &&
+	head=$(git rev-parse --verify HEAD) &&
+	exp_sha=${2:-$head} &&
 
 	# default options for git checkout: -b
 	if [ -z "$3" ]; then
@@ -36,8 +37,12 @@ do_checkout () {
 
 	if test -z "$should_fail"
 	then
-		test $exp_ref = $(git rev-parse --symbolic-full-name HEAD) &&
-		test $exp_sha = $(git rev-parse --verify HEAD)
+		echo "$exp_ref" >ref.expect &&
+		git rev-parse --symbolic-full-name HEAD >ref.actual &&
+		test_cmp ref.expect ref.actual &&
+		echo "$exp_sha" >sha.expect &&
+		git rev-parse --verify HEAD >sha.actual &&
+		test_cmp sha.expect sha.actual
 	fi
 }
 
@@ -159,7 +164,8 @@ test_expect_success 'checkout -B to a merge base' '
 '
 
 test_expect_success 'checkout -B to an existing branch from detached HEAD resets branch to HEAD' '
-	git checkout $(git rev-parse --verify HEAD) &&
+	head=$(git rev-parse --verify HEAD) &&
+	git checkout "$head" &&
 
 	do_checkout branch2 "" -B
 '
-- 
2.24.1.810.g65a2f617f4

