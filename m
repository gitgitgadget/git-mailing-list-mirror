Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8B5C43460
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 16:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1902A6101A
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 16:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346090AbhIBQCk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 12:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346086AbhIBQCe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 12:02:34 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7F1C0612A7
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 09:01:34 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id q14so3758307wrp.3
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 09:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tigMh5tp7IkkqTJhDpB0soyTxbfAh5894I8j/tls6CY=;
        b=O8DCIv0TSsv+czrZ1UnThTy06AiIgGkabMg810akTUktlOQR4msNSGYaQ/AYMxvSQJ
         WJSqgLy/u5SOiMX4MNHgLOjB8rMN5ifFm/q6vsTycp61bGOvKQZSDdoO0exLTUAwloCC
         qmkt6Cm5sCGn05zGKY2eENjKMYcjjXkAwLZu0zh3i5N6JkLV60T/THoT+GalZ4KyqUe+
         mtd01rGUh1Itzsi/26e7d+sqjFXQv+MaIOo2DiGPLVwCJLejTkTgvHARAMLTMclYZpXM
         kfCCyrjdsdDRh8VxaFdjb88OadhCpQ/M4CTcLWCEnutpXosrvLP2kRhjs9ygl/XPYbBo
         6taA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tigMh5tp7IkkqTJhDpB0soyTxbfAh5894I8j/tls6CY=;
        b=BiVZb05k93Lm9WdQXyHTPustRk8cf54QeEUsHenGJlpS1/tFjUDo6WZKynhfGcAOFH
         drRTcgAh6jDaScEEEOWjD24C5Zw7FRr4dmWt7O1tIPN1+rnFeFcaWq9rbAt7WU56wMqu
         Oh89FUAV7yLH2hbqgZAtAv2J4cwNz6YJeuIlb+NNlQFSWf1fVqkd5/nsH1/yky27qZ0r
         CwiB+v9HQ3Xc+udmTqrqYWcGaf3CLhR7BdOthq04Cg3sKpJuyYLtczFf6IE/RYyRwyvS
         HYPXBPTxgUjn0HtH7JXmVT14kUHhPk4RXw7L+0Xd/5dZ87jY4qXZ/ewVrQOp7Fz6JU33
         4nXg==
X-Gm-Message-State: AOAM530uqEaGf1pa+o6rJ6WFz+MvGzl//34bs272HgwfqiA4gA/BGQ3c
        IuFhlxDjwPYV4xOfnssqk/CgX74/kw67kw==
X-Google-Smtp-Source: ABdhPJxjZvFvr5w+xZP3KpaeKH+T07QHMQTRGKiJOfDG+YfxvNj4SI3o9DNNzD6BCG8++0SWPlhDKw==
X-Received: by 2002:adf:d185:: with SMTP id v5mr4534944wrc.378.1630598492621;
        Thu, 02 Sep 2021 09:01:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u26sm2403215wrd.32.2021.09.02.09.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 09:01:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Wong <e@80x24.org>, Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 9/9] test-lib: remove unused $_x40 and $_z40 variables
Date:   Thu,  2 Sep 2021 18:01:16 +0200
Message-Id: <patch-9.9-0fd1516af85-20210902T155758Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.814.gb82868f05f3
In-Reply-To: <cover-0.9-00000000000-20210902T155758Z-avarab@gmail.com>
References: <cover-0.9-00000000000-20210902T155758Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These two have fallen out of use with the SHA-256 migration.

The last use of $_x40 was removed in fc7e73d7ef (t4013: improve
diff-post-processor logic, 2020-08-21) and

The last use of $_z40 was removed in 7a868c51c2 (t5562: use $ZERO_OID,
2019-12-21), but it was then needlessly refactored to be hash-agnostic
in 192b517589 (t: use hash-specific lookup tables to define test
constants, 2020-02-22). We can just remove it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index abcfbed6d61..044a9231ae6 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -534,7 +534,7 @@ SQ=\'
 # when case-folding filenames
 u200c=$(printf '\342\200\214')
 
-export _x05 _x35 _x40 _z40 LF u200c EMPTY_TREE EMPTY_BLOB ZERO_OID OID_REGEX
+export _x05 _x35 LF u200c EMPTY_TREE EMPTY_BLOB ZERO_OID OID_REGEX
 
 # Each test should start with something like this, after copyright notices:
 #
@@ -1422,10 +1422,9 @@ then
 fi
 
 # Convenience
-# A regexp to match 5, 35 and 40 hexdigits
+# A regexp to match 5 and 35 hexdigits
 _x05='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
 _x35="$_x05$_x05$_x05$_x05$_x05$_x05$_x05"
-_x40="$_x35$_x05"
 
 test_oid_init
 
@@ -1434,7 +1433,6 @@ OID_REGEX=$(echo $ZERO_OID | sed -e 's/0/[0-9a-f]/g')
 OIDPATH_REGEX=$(test_oid_to_path $ZERO_OID | sed -e 's/0/[0-9a-f]/g')
 EMPTY_TREE=$(test_oid empty_tree)
 EMPTY_BLOB=$(test_oid empty_blob)
-_z40=$ZERO_OID
 
 # Provide an implementation of the 'yes' utility; the upper bound
 # limit is there to help Windows that cannot stop this loop from
-- 
2.33.0.814.gb82868f05f3

