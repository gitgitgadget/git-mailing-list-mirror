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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2772C4321E
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 11:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9870361205
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 11:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235708AbhIKLTU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 07:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbhIKLTL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 07:19:11 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C03C061756
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 04:17:58 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id u19-20020a7bc053000000b002f8d045b2caso3109489wmc.1
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 04:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=meH3fOctP5lD+lsanoQbp3wU+fwial9KgNCgjfdnCUE=;
        b=eqNoTQL+VTPAUBsgHXhsyI7yBr0zw44jHRNdhzserCGt1CqgR59aAPxnslXGRghh8c
         qpuZM8o999ah26NDT3YhXk650aw3uvtCpwohdzHov/q9r+K6J4oe6KkDiYY54uOao/WO
         DriCiTj5VyDfbiUnRj8++f1ceM32TV0yT6ZknCAbIV6Z2mfSvynt8O1EDvha9EYDN6Vt
         A/xQ71qIgK19qc+oMDjN/xFT2cm3nFF453/IDqraFcMWJm1BbnDgdH/SCjp0Y0oD/UuK
         yjAAI3b9dBQrZcGUsXfsu9HSxm93YSjxORS6h2Eyq8tjU/JtsIdPd+/M5YshvhuT4H+D
         z+sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=meH3fOctP5lD+lsanoQbp3wU+fwial9KgNCgjfdnCUE=;
        b=FY+3mIsJpRtPYCIOF3TPNGwl/9FppUXzvSt0m9B3oxiWQ8ZxjRpXNMIaiOc+EHp6YV
         DozD00imNdObl2nXAzlfa0NKCRRJpiKehzlFfRKhZ6JtHQW5+XSM6bwzCzMMW56UBfkp
         bBGKOAjBA8452LX9CKHYWRxb13dRe8TqfR7JF8JEoQq5QDOPk27By9imrIZs8mAXOL6p
         BJz9OwoXCiQ3gfO0wtDNF+6cCENKZUSVa6mpw4tj9Sq4fYRjyyxrYfeFk12oqqv7SXp/
         vIQkT59ry94lTd0pdbwojpPZwyieNLaYPoiaoZX/vu+Zvk9rz4JlHT3K3u9/iYk/+DeJ
         0c+A==
X-Gm-Message-State: AOAM53012+HTqjt4RgCZD6VQjdAh4LVV8O3vHPeeXFipLTrrerQPKmMs
        cIbtsBqGhhZ87Ko9Sk7yv2zdZCa2I6F2Yg==
X-Google-Smtp-Source: ABdhPJz5eFNRTkMFwph8Js7q+wgoE7KqPEN3YS52uC/EnOER8JAPLL1FN3uOWxNvUjmmG3BsgW2yDw==
X-Received: by 2002:a1c:43c5:: with SMTP id q188mr2229221wma.175.1631359076884;
        Sat, 11 Sep 2021 04:17:56 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p5sm1549731wrd.25.2021.09.11.04.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 04:17:56 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Wong <e@80x24.org>, Prathamesh Chavan <pc44800@gmail.com>,
        Peter Baumann <peter.baumann@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 4/4] test-lib: remove unused $_x40 and $_z40 variables
Date:   Sat, 11 Sep 2021 13:17:51 +0200
Message-Id: <patch-v3-4.4-206519c2d34-20210911T111435Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.984.gea2c3555113
In-Reply-To: <cover-v3-0.4-00000000000-20210911T111435Z-avarab@gmail.com>
References: <cover-v2-0.7-00000000000-20210906T070201Z-avarab@gmail.com> <cover-v3-0.4-00000000000-20210911T111435Z-avarab@gmail.com>
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
index fc1e5215198..a0b944e8feb 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -534,7 +534,7 @@ SQ=\'
 # when case-folding filenames
 u200c=$(printf '\342\200\214')
 
-export _x05 _x35 _x40 _z40 LF u200c EMPTY_TREE EMPTY_BLOB ZERO_OID OID_REGEX
+export _x05 _x35 LF u200c EMPTY_TREE EMPTY_BLOB ZERO_OID OID_REGEX
 
 # Each test should start with something like this, after copyright notices:
 #
@@ -1423,10 +1423,9 @@ then
 fi
 
 # Convenience
-# A regexp to match 5, 35 and 40 hexdigits
+# A regexp to match 5 and 35 hexdigits
 _x05='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
 _x35="$_x05$_x05$_x05$_x05$_x05$_x05$_x05"
-_x40="$_x35$_x05"
 
 test_oid_init
 
@@ -1435,7 +1434,6 @@ OID_REGEX=$(echo $ZERO_OID | sed -e 's/0/[0-9a-f]/g')
 OIDPATH_REGEX=$(test_oid_to_path $ZERO_OID | sed -e 's/0/[0-9a-f]/g')
 EMPTY_TREE=$(test_oid empty_tree)
 EMPTY_BLOB=$(test_oid empty_blob)
-_z40=$ZERO_OID
 
 # Provide an implementation of the 'yes' utility; the upper bound
 # limit is there to help Windows that cannot stop this loop from
-- 
2.33.0.984.gea2c3555113

