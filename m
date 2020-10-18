Return-Path: <SRS0=h2Q9=DZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB93EC433DF
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 00:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A86920EDD
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 00:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WaiUobnS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440064AbgJRAze (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Oct 2020 20:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440061AbgJRAze (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Oct 2020 20:55:34 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07DBC061755
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 17:55:33 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id p9so6886247ilr.1
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 17:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5iMdmR3MfF2Fr6SBCt9SyUOYE1S9YR3uGk3wuVF8BX4=;
        b=WaiUobnSYuIY65IfVMqbTppIZl4SdfRgJILYyTio6q4GnHz5PrCh7UJQ8TGyp2hFt4
         cMLF801ThjaiyCeW4SrteA/cziuha1KiUWcclVVUPQjZq/NG8AE9dAcIRnfi2370KJjo
         30DNSN2lfCm4VqfOHaBu6NrdA79CLLaptRvc6Dy8emWcR7gaKiLGnm7ksVgzAAIjWPY6
         nF1yHZzHElAUqBNfprTF+sFylJq1YwwiRvLw2U+83ZyxD10adubmovp1M6yfdWQaMlvW
         1Xw2HWy49BD9rO/o2lZ3zGoQZ8OB3Kf1ppJZRoo3m5Fu0iccuHjYjPXvpefs7NXT5SB4
         o6kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5iMdmR3MfF2Fr6SBCt9SyUOYE1S9YR3uGk3wuVF8BX4=;
        b=uGwud18O3ExBFW4h5zuFYO4256h3ZRRiltzqb6vRJQEhv4WQh/gwpJM2164bUOTv5Z
         ETSUeLQYv1Bifqqjjyo1LUqNPRH3XinQCfsDmazJm89egrCBd/+hBLnfN3iC1Reuz4Cl
         /F08lkeS/Rtj1dOdxBlxlOkQs/uCqIWb0buBLIM4ASA0FKcbxhg7/eKW1aOJWBe46zc3
         ZTnKulun+Wdi23KD9K8HIn/1/JBFFXIIg9raCHS/JR+NmOFgQQMYGRvMUdfaUxEuSU/r
         FboOfPzG0N29OANpeWhssBSnKrNJyVKxzExlBd56mqyhGqojg376eL12ZD/m9r4oX5WX
         dFNg==
X-Gm-Message-State: AOAM532PFbC53oSrTpUFMMWrtakWYCYcVnjPdat+YlNXn2VIFm7JVZGy
        wINRFirJxmqE8rLo57nUznGB88OeNCzFCg==
X-Google-Smtp-Source: ABdhPJyTl6kD+x/dNZ0wqqQ9FKk7eC954+gd7aQ8FdK7Z/swQeoUBpYlIt63XAAh/Z+ZkBUYyCgHLw==
X-Received: by 2002:a92:3408:: with SMTP id b8mr7248870ila.231.1602982533038;
        Sat, 17 Oct 2020 17:55:33 -0700 (PDT)
Received: from localhost.localdomain ([45.56.140.65])
        by smtp.gmail.com with ESMTPSA id p4sm6352642ilg.79.2020.10.17.17.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2020 17:55:32 -0700 (PDT)
From:   Caleb Tillman <caleb.tillman@gmail.com>
To:     git@vger.kernel.org
Cc:     Caleb Tillman <caleb.tillman@gmail.com>
Subject: [Outreachy-Microproject][PATCH 1/1] t0000: replace an instant of test -f with test_path_is_file functions.
Date:   Sun, 18 Oct 2020 00:55:22 +0000
Message-Id: <20201018005522.217397-1-caleb.tillman@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test_path_is* functions provide debug-friendly messages upon failure.

Signed-off-by: Caleb Tillman <caleb.tillman@gmail.com>
--- Outrachy Microproject, revised submission
 t/t0000-basic.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 923281af93..eb99892a87 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -1191,7 +1191,7 @@ test_expect_success 'writing this tree with --missing-ok' '
 test_expect_success 'git read-tree followed by write-tree should be idempotent' '
 	rm -f .git/index &&
 	git read-tree $tree &&
-	test -f .git/index &&
+	test_path_is_file .git/index &&
 	newtree=$(git write-tree) &&
 	test "$newtree" = "$tree"
 '
-- 
2.25.1

