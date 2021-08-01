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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A13C4338F
	for <git@archiver.kernel.org>; Sun,  1 Aug 2021 08:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEFFC603E9
	for <git@archiver.kernel.org>; Sun,  1 Aug 2021 08:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbhHAI0D (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Aug 2021 04:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbhHAI0D (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Aug 2021 04:26:03 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F47C06175F
        for <git@vger.kernel.org>; Sun,  1 Aug 2021 01:25:54 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id l17so19782584ljn.2
        for <git@vger.kernel.org>; Sun, 01 Aug 2021 01:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rtTfk9JZOc1MMNaC+4uRvLmWHuLtBLSaI0HZz1rL6Qg=;
        b=lw0Yabhh9hRnU+UqLt+RNxGEDXLsZ6xUJk2b3sSs+j/3nxSyQ6/NISlOIOt6Qiowdc
         cdjKa1MaT+BE1cZ485a36FMrudBks+i2z6XY54AbrVXcRhV1NmPQo+o6PsyteAHVg/Yc
         CkLzYrEuc5BrbX783ueDM/ono7nyPmxI//L6tawvX7WnTqDC2XqCDAwYaiBvz9pUttjZ
         0ftjF/uqKLeJ9aiblFd0sHX2g5WtO1nR1TKFtsCw0WSVPAMGC7RbFhW9wv3HB66J1JLv
         JTf2GfwcvnmVxGDko/V8Jw0R4Jj9fRaUZ60nw5TvqkE+hU9Ow7Z6gjN4vt37Nljp27jq
         uASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rtTfk9JZOc1MMNaC+4uRvLmWHuLtBLSaI0HZz1rL6Qg=;
        b=Hh6JmZG2z2C1wnN1AFawxWEXFgBCAOR36SuwczdS+OmRj5AroG+uEm8UpmMOBCwbgu
         suCiRFJa+JIpppff9qJqpTsONF83f877ujbZDTl7qI6DgJToh5b4Pg63OvOda2KdKg8C
         13vnfDGhM2NVAPWOxf6CE+ntuKza7M7GpzIMdlr1TW8I4xpG3RJKdBLlbEZWwBzajkeW
         OgqIoSGzbyV5PT3cAIShngj194KFg8GFoDq+NNFEzJ7E04t3C9/uWW6DCJeL9wNR3Nlk
         2fvMsllch+iN/Qnq3AwvQTj3JoCYQbR8cRZFlV3+OHCq2sTLP7mdV1gD9g2V1dQYgVkZ
         b6Fg==
X-Gm-Message-State: AOAM5301Q9CIT0h6YRHJ8g5yAvc278yxrTZscA7F1ZRew8pLYqBXT4tf
        Ds5AxGB/3FmaV2kaV1UdclxaOirkl/zXtg==
X-Google-Smtp-Source: ABdhPJw4cQVxm6MKZYA1mmgrQJuT3iIVW6UnF3wnfJ5WcO0Blb+ULeCYLw1vRAoZ6Tx3sm+qA9X+zQ==
X-Received: by 2002:a2e:a909:: with SMTP id j9mr7625172ljq.145.1627806352602;
        Sun, 01 Aug 2021 01:25:52 -0700 (PDT)
Received: from paasan.lan (150.37-191-137.fiber.lynet.no. [37.191.137.150])
        by smtp.gmail.com with ESMTPSA id bp34sm613032lfb.295.2021.08.01.01.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 01:25:52 -0700 (PDT)
From:   =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
Subject: [PATCH] clone: Remove constraint on --bare and --origin
Date:   Sun,  1 Aug 2021 10:25:46 +0200
Message-Id: <20210801082546.18543-1-oystwa@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test has been present since long before clone was ported to C. Now
there is no need for it, and since df61c88979 (clone: also configure url
for bare clones, 2010-03-29) it's especially useful to allow both
options.

Signed-off-by: Øystein Walle <oystwa@gmail.com>
---

A question on this constraint popped up on #git the other day. I
investigated a bit and found no particular reason for its existence. All
tests still pass (except the one removed here) and the behavior is as
expected. I realize it might have gone under the radar for 11 years but
it's still worth the noise to remove it, in my opinion.

I wanted to include a bit on the reasoning for the original check in the
commit message but I couldn't find it. 

 builtin/clone.c          | 3 ---
 t/t5606-clone-options.sh | 8 --------
 2 files changed, 11 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 66fe66679c..70ec72ea85 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1014,9 +1014,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		option_bare = 1;
 
 	if (option_bare) {
-		if (option_origin)
-			die(_("--bare and --origin %s options are incompatible."),
-			    option_origin);
 		if (real_git_dir)
 			die(_("--bare and --separate-git-dir are incompatible."));
 		option_no_checkout = 1;
diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
index 3a595c0f82..4a8a2ca6f7 100755
--- a/t/t5606-clone-options.sh
+++ b/t/t5606-clone-options.sh
@@ -30,14 +30,6 @@ test_expect_success 'rejects invalid -o/--origin' '
 
 '
 
-test_expect_success 'disallows --bare with --origin' '
-
-	test_must_fail git clone -o foo --bare parent clone-bare-o 2>err &&
-	test_debug "cat err" &&
-	test_i18ngrep -e "--bare and --origin foo options are incompatible" err
-
-'
-
 test_expect_success 'disallows --bare with --separate-git-dir' '
 
 	test_must_fail git clone --bare --separate-git-dir dot-git-destiation parent clone-bare-sgd 2>err &&
-- 
2.27.0

