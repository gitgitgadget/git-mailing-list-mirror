Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0423C433FE
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 10:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbiCQKOp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 06:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbiCQKOo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 06:14:44 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB926D3AE9
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 03:13:27 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id q7-20020a7bce87000000b00382255f4ca9so4664151wmj.2
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 03:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sKiRvy61Kw9DVH8tNA4aGIw1QxZOBIVsq9jZxdQovfw=;
        b=G9QLxA3n+0PooNaxY1QTkWSls6JwEUUYIYAk9DnUa9ySZiBN65u/IJT4zoxKHiLtvI
         LonrQSALxqxmS2pZhbYvrnNvc/umC1aCUPldXcAZmxlXl+Pd+3f7WPM1pBo8x6dW2Ov9
         4ocDvOLJ+Rewd0jvk4NKnx4bH0n/djEP4vlvp44eCNtVUtyUe6bbJsz7hU8FSb58LER3
         m1/1Ov2I4qiESew6oA1jT19FD1w78FEvasqZooaoeXudAaT8j+fidokUv2veNo3ZsBtl
         v/FhDNSv1MFoRb2SxlgddTYKxafphM9/CR9fizzAeBV4tYBcynV9ugiFlI/2BoLODh7M
         zyNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sKiRvy61Kw9DVH8tNA4aGIw1QxZOBIVsq9jZxdQovfw=;
        b=cHXHFxf6cK7HISN6RSrwYd4Hk9n8UmGWGwHZl/h6Vt+y7Ok3tydgnqn0GZq8lplDnc
         8sh0vGpTLVaqRfKfy/2Cm42RC1q/iE8HSxr34eOULDR3zrAjmX3cxHhUyCNFawc+2dwu
         i3TwbSoEJSlr4CK1nROUCn4mpE4H9w53zGXa/DUR07Jfzz/hTFRenXubsESybb3+ycF2
         y4XjpwuSC6/FKwI7ciqMwPEeY+EhsCpNkIhhLX29T5sY+oX0FzcHtSGj/H/pi450sICX
         G1h7oWWdgQ6xzQra80Rk1UPBiq7tt09jle/VcGxIgTxyvGBDc2zcun/BVoxhqmWMMpEU
         vFHA==
X-Gm-Message-State: AOAM530g19PePOUUkePHjjJVgUjZuWy3nB5vHiQTIK3g+dUk0M0uf18I
        VrHe8Ymw0X495+19x9NhNXwcpb59kVs=
X-Google-Smtp-Source: ABdhPJzRxkNzW/ILEL5Z+Zi6zM1tQjuDOhUYNOLAN5ArToS/FFI2HrZ2Ew0y/ZDT1H4KQHiLauCmXQ==
X-Received: by 2002:a05:600c:4f43:b0:38a:88d:ae18 with SMTP id m3-20020a05600c4f4300b0038a088dae18mr11386182wmq.53.1647512006074;
        Thu, 17 Mar 2022 03:13:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i206-20020a1c3bd7000000b0038bfc3ab76csm3903236wma.48.2022.03.17.03.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 03:13:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 03/13] http tests: don't rely on "hook/post-update.sample"
Date:   Thu, 17 Mar 2022 11:13:08 +0100
Message-Id: <patch-v3-03.13-8451c31911d-20220317T100820Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1384.g7d2906948a1
In-Reply-To: <cover-v3-00.13-00000000000-20220317T100820Z-avarab@gmail.com>
References: <cover-v2-00.10-00000000000-20220307T123909Z-avarab@gmail.com> <cover-v3-00.13-00000000000-20220317T100820Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change code added in a87679339c0 (test: rename http fetch and push
test files, 2014-02-06) to stop relying on the "exec git
update-server-info" in "templates/hooks--post-update.sample", let's
instead inline the expected hook in the test itself.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5540-http-push-webdav.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t5540-http-push-webdav.sh b/t/t5540-http-push-webdav.sh
index b0dbacf0b9b..37db3dec0c5 100755
--- a/t/t5540-http-push-webdav.sh
+++ b/t/t5540-http-push-webdav.sh
@@ -42,7 +42,9 @@ test_expect_success 'setup remote repository' '
 	git clone --bare test_repo test_repo.git &&
 	cd test_repo.git &&
 	git --bare update-server-info &&
-	mv hooks/post-update.sample hooks/post-update &&
+	test_hook --setup post-update <<-\EOF &&
+	exec git update-server-info
+	EOF
 	ORIG_HEAD=$(git rev-parse --verify HEAD) &&
 	cd - &&
 	mv test_repo.git "$HTTPD_DOCUMENT_ROOT_PATH"
-- 
2.35.1.1384.g7d2906948a1

