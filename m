Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1350C433FE
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 17:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243794AbiD0RKa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 13:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243806AbiD0RK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 13:10:26 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BCE12AA8
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 10:07:13 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id a21so2709872edb.1
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 10:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HzLlNQRZqdl5/+Rl6rcO5VgO5HbPi+stSewnt84CjUw=;
        b=aLtxPxhVvNfuhkpTfxrHfNiVtH/scFtycwbQtAcbEpYkh8MHlbd1ePi7QEqkZpQyDL
         kd+oq10x+OA1NrgVKnfXkW7KBHjOr7DRxdEjEI6algcbmAxIBNnhaG9cb9mzia6DatjQ
         4bDKtDwtypqiRii2h5NxlB7tq9/k1QkMXJgRQWZBlZIQCk2zLVwyIV7o1MLmoVdbIdLS
         G+ApQSRfnL8Y3uQOuxCI+Sqd4O9bODdGQD/Y5pzl1eWAZakH67KPza+D92Wl9xweOp/8
         vSr4y2Y0V0G/7I9QML35n9fve+7YLMRA/wgirEpvaO0Y+pfKezfNpHfcFYSdqEyq8tiA
         Kt+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HzLlNQRZqdl5/+Rl6rcO5VgO5HbPi+stSewnt84CjUw=;
        b=yGSSfib2O++Z4DVbV+heFV4cecls3KQzvNqPYuFww51i4PwHiAS5PM0k06ZIQEK9yV
         /3Cvc+CRlyMWeT3fKV1RN2BxCZECBUSHXVP3i3Ewf632Mtl0JR7qKupUeBTUx2hOLu3L
         V9Jz8XBWCnBLdvK+1M4sro+I2SjzAr1pYOo6fPtB8/1kKOYcScYuUENxshFE5BqUCmyL
         /0reDneLovMGTvkGZd/FzUMrRjD0G0vnRMqYYb8ADHcrWeSQHjygcfQO5G6pWSR/0aRF
         IJ6VUT+4P27yswpMXezGqOEMMd527L+w/y5bUmcYYmNTa/+ZTNBIj1VytIrMc2upC2tE
         ZDLw==
X-Gm-Message-State: AOAM530zEg45l8xfP1DJT5n7wpcVkeKuVLlc41rrwFxe7Ue9u65WD+WO
        tUdWCRp+0Idg0S6HnagLJ4aams0Adzr2eQ==
X-Google-Smtp-Source: ABdhPJxYkpo3T3uc4JwWAg31a8wahxvr+OUNTHGq6i6QFqRIObX//mOc6jWNC5zK53WTk7fcTcGgHA==
X-Received: by 2002:a05:6402:1e88:b0:412:fc6b:f271 with SMTP id f8-20020a0564021e8800b00412fc6bf271mr32034594edf.345.1651079232549;
        Wed, 27 Apr 2022 10:07:12 -0700 (PDT)
Received: from buzz.local (62-165-236-195.pool.digikabel.hu. [62.165.236.195])
        by smtp.gmail.com with ESMTPSA id jl5-20020a17090775c500b006f3b76a87ffsm2748849ejc.51.2022.04.27.10.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 10:07:12 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 1/3] t0033-safe-directory: check the error message without matching the trash dir
Date:   Wed, 27 Apr 2022 19:06:47 +0200
Message-Id: <20220427170649.4949-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.36.0.676.gf39b21ed98
In-Reply-To: <20220427170649.4949-1-szeder.dev@gmail.com>
References: <pull.1215.git.1649863951.gitgitgadget@gmail.com>
 <20220427170649.4949-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 8959555cee (setup_git_directory(): add an owner check for the
top-level directory, 2022-03-02) when git finds itself in a repository
owned by someone else, it aborts with a "fatal: unsafe repository
(<repo path>)" error message and an advice about how to set the
'safe.directory' config variable to mark that repository as safe.
't0033-safe-directory.sh' contains tests that check that this feature
and handling said config work as intended.  To ensure that git dies
for the right reason, several of those tests check that its standard
error contains the name of that config variable, but:

  - it only appears in the advice part, not in the actual error
    message.

  - it is interpreted as a regexp by 'grep', so, because of the dot,
    it matches the name of the test script and the path of the trash
    directory as well.  Consequently, these tests could be fooled by
    any error message that would happen to include the path of the
    test repository.

Tighten these checks to look for "unsafe repository" instead.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t0033-safe-directory.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0033-safe-directory.sh b/t/t0033-safe-directory.sh
index 239d93f4d2..6f9680e8b0 100755
--- a/t/t0033-safe-directory.sh
+++ b/t/t0033-safe-directory.sh
@@ -9,7 +9,7 @@ export GIT_TEST_ASSUME_DIFFERENT_OWNER
 
 expect_rejected_dir () {
 	test_must_fail git status 2>err &&
-	grep "safe.directory" err
+	grep "unsafe repository" err
 }
 
 test_expect_success 'safe.directory is not set' '
-- 
2.36.0.676.gf39b21ed98

