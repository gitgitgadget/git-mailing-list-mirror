Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6654C77B73
	for <git@archiver.kernel.org>; Thu, 18 May 2023 20:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjERUDz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 16:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjERUDj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 16:03:39 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A4410C9
        for <git@vger.kernel.org>; Thu, 18 May 2023 13:03:34 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f41dceb9d1so24071745e9.1
        for <git@vger.kernel.org>; Thu, 18 May 2023 13:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684440213; x=1687032213;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rIemZQrqkiAekcGselSdCFkdbrE5wLOYbYelkvM9jus=;
        b=E35qpPGluIfQb9xnvHgRWJko5HTW5tSRnfVXAY49p8IcmNep+UL5FIXS5hF5nstbJw
         UTUy5dFgG5/fA6iRlSfBI7puM4MNZGgvhAtsVbkXgMdqySjwjNmJt/2D74ZDIFd2EgWe
         bDAxKMjzxiD2EY3VS6oAgcjFg70zHm8xftov0FGmYzl68GJomEGDLfVSlPGsIHrTJ8rl
         GG+xz0649uuef6wDFEe3FcXtc80tnf7r1awr07yk+vaML8gxSxjIub1oB4kQaSkfRpnz
         TdLAvdMar+MhaEJOkF2Mqug9AYFrINnpXEra1CJT/tOEUqlxGrvdAC6OevwypvHi4f9p
         JBIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684440213; x=1687032213;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rIemZQrqkiAekcGselSdCFkdbrE5wLOYbYelkvM9jus=;
        b=LYn0P/ZoiexNounElWLcSgwAYcFCwoOFQOGQxTnn/LhAawTrcVqVInk9ZEftqoYQ9O
         CwpdBSbn3ghQd7S1W92qBdBsu3o1Z4wLbKKVWBexxkmDGe4mTIJDsazxq2gVNnHeu7U5
         RyA2J6LXIKK1fl+bQ/ZISdmytICn8dn3j2rwDpkTQWDTczAVhhBs82lwaBTqoOViUm9E
         4G4kpAzlsagUR+M77tSlNHS+MLZeKEMf4orNOJkPCSkfri5bK006fZsXzcD9CbMuyhq1
         DGetqf45EPtTDaiv2A9kW31Ytg20F21cH9mghe5iMLtlRoTEeJHHaUrJ7rRIQsReIAYI
         /nkg==
X-Gm-Message-State: AC+VfDzt+yd8W57Q8N/WTUVYiOR0ECVGLEs+SE8WjiddZKqezU3N9vfs
        L0OxKBmh5VsxCaG79Nt7YXdvhZd3+Ss=
X-Google-Smtp-Source: ACHHUZ5kivwIg+uqCfRV1WC2r/KzYp8glbRW40g5J9InyoCqn75dcIiFaRHX0GnubNfvr0F9QQ/Eug==
X-Received: by 2002:a1c:f30a:0:b0:3f4:23a4:7a93 with SMTP id q10-20020a1cf30a000000b003f423a47a93mr2933296wmq.25.1684440212955;
        Thu, 18 May 2023 13:03:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 25-20020a05600c021900b003f4f8cc4285sm225844wmi.17.2023.05.18.13.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 13:03:32 -0700 (PDT)
Message-Id: <456c73c880182e61af3c6dd5e42796e65d413996.1684440205.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1513.git.git.1684440205.gitgitgadget@gmail.com>
References: <pull.1513.git.git.1684440205.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 May 2023 20:03:14 +0000
Subject: [PATCH 09/20] t3903-stash: modernize test format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

Some tests still use the old format with four spaces indentation.
Standardize the tests to the new format with tab indentation.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 t/t3903-stash.sh | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 376cc8f4ab8..0b3dfeaea20 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1211,19 +1211,19 @@ test_expect_success 'stash with file including $IFS character' '
 '
 
 test_expect_success 'stash with pathspec matching multiple paths' '
-       echo original >file &&
-       echo original >other-file &&
-       git commit -m "two" file other-file &&
-       echo modified >file &&
-       echo modified >other-file &&
-       git stash push -- "*file" &&
-       echo original >expect &&
-       test_cmp expect file &&
-       test_cmp expect other-file &&
-       git stash pop &&
-       echo modified >expect &&
-       test_cmp expect file &&
-       test_cmp expect other-file
+	echo original >file &&
+	echo original >other-file &&
+	git commit -m "two" file other-file &&
+	echo modified >file &&
+	echo modified >other-file &&
+	git stash push -- "*file" &&
+	echo original >expect &&
+	test_cmp expect file &&
+	test_cmp expect other-file &&
+	git stash pop &&
+	echo modified >expect &&
+	test_cmp expect file &&
+	test_cmp expect other-file
 '
 
 test_expect_success 'stash push -p with pathspec shows no changes only once' '
-- 
gitgitgadget

