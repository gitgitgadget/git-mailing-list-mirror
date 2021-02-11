Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE97C433E0
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 01:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8306464DBD
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 01:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhBKB6f (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 20:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhBKBzF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 20:55:05 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFC4C061786
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 17:54:09 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id t142so3562947wmt.1
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 17:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sRMx9XTdBrmo/nZFlts+8tVq/hlYoTvczMF3w4Ws9ao=;
        b=MlPydzK89MIhRtnKnb6dRpDtAlyEl1ElVHG9kkf3WaTJoAy+WvE/dUzeLeW4MPg5Ui
         SGd+TWnna+/AHWPmGgTQyLemQ1zxm/VmPQPy50rKul1CUfwdHwkAFeWRKFPC8zy1hjRl
         CWBwUZYSai4HE4SvGuoDYXZxWb+rJB9iegpuC+9sodKIJwgxy0x9rrIBKtrpT5/RKdVf
         nDvOtX8XdqjW3X6dIzMnkOXyTNdcb0pHkYpVWQWRW+G5ls6onGKIELgm0IYglu/WmZxP
         n7vg06ULezlepeS7WIKtzyU1PdBwGD9g3LXo295K8WGe9Z6ScsdmbSeNE88PrG9qWOGt
         O6MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sRMx9XTdBrmo/nZFlts+8tVq/hlYoTvczMF3w4Ws9ao=;
        b=NrBqtKcpKjSA2RAh3VfYQm4oYosStt09Z9UJ7DTtZ//80hvWWSeWVl9ZJTRdCtJNGi
         +yzwLr3KVzBoQxxcbUFf+AGkGqMLJI9I0ARcztLV6EvBhPr7p4bNdNbyCqBBqAJuQ5if
         H+rzOTakCeTGpqCmR4bvv29CQ4NLEucwAHvT3Qby5VikDDPojnh+MO6FgK/DegMqCPT9
         JJc2nGphIdJlERcjxnUMz8IozWn5UEfKdFe1U2PJbla3Hg464+d7xbmFU0KTn7lsld+e
         jPmdZbjQK5IxYAF8UoucJF2nZ5q0uLX5bGyh41jk9LPXkfFnXH8VhE4sOWpkZ9XvjE/Q
         31pA==
X-Gm-Message-State: AOAM531auymUgcLEnAHKaso1qYmvCQt6LZwD2BebV3r/Ot1r0qWqkVvD
        10wDWcfa4hlFOd3YB+smaO2Nk/iZJQdKSg==
X-Google-Smtp-Source: ABdhPJxgT9MiwRzN7k/QS6m38KXw1fQDqY36K3hb+m+SNNaKnAHZmsH2DhbhKEy8oFmjNLZE5Ou/nw==
X-Received: by 2002:a1c:bcc3:: with SMTP id m186mr2130468wmf.165.1613008448099;
        Wed, 10 Feb 2021 17:54:08 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m2sm5362486wml.34.2021.02.10.17.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 17:54:07 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/4] tests: remove last uses of GIT_TEST_GETTEXT_POISON=false
Date:   Thu, 11 Feb 2021 02:53:50 +0100
Message-Id: <20210211015353.28680-2-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210120182759.31102-1-avarab@gmail.com>
References: <20210120182759.31102-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Follow-up my 73c01d25fe2 (tests: remove uses of
GIT_TEST_GETTEXT_POISON=false, 2021-01-20) by removing the last uses
of GIT_TEST_GETTEXT_POISON=*.

These assignments were part of branch that was in-flight at the time
of the gettext poison removal. See 466f94ec45e (Merge branch
'ab/detox-gettext-tests', 2021-02-10) and c7d6d419b0d (Merge branch
'ab/mktag', 2021-01-25) for the merging of the two branches.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3800-mktag.sh | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index 86bfeb271ec..60a666da595 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -13,13 +13,11 @@ test_description='git mktag: tag object verify test'
 
 check_verify_failure () {
 	test_expect_success "$1" "
-		test_must_fail env GIT_TEST_GETTEXT_POISON=false \
-			git mktag <tag.sig 2>message &&
+		test_must_fail git mktag <tag.sig 2>message &&
 		grep '$2' message &&
 		if test '$3' != '--no-strict'
 		then
-			test_must_fail env GIT_TEST_GETTEXT_POISON=false \
-				git mktag --no-strict <tag.sig 2>message.no-strict &&
+			test_must_fail git mktag --no-strict <tag.sig 2>message.no-strict &&xb
 			grep '$2' message.no-strict
 		fi
 	"
@@ -443,11 +441,9 @@ test_expect_success 'invalid header entry config & fsck' '
 	git -c fsck.extraHeaderEntry=ignore mktag --no-strict <tag.sig &&
 
 	git fsck &&
-	env GIT_TEST_GETTEXT_POISON=false \
-		git -c fsck.extraHeaderEntry=warn fsck 2>err &&
+	git -c fsck.extraHeaderEntry=warn fsck 2>err &&
 	grep "warning .*extraHeaderEntry:" err &&
-	test_must_fail env GIT_TEST_GETTEXT_POISON=false \
-		git -c fsck.extraHeaderEntry=error 2>err fsck &&
+	test_must_fail git -c fsck.extraHeaderEntry=error 2>err fsck &&
 	grep "error .* extraHeaderEntry:" err
 '
 
-- 
2.30.0.284.gd98b1dd5eaa7

