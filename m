Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EEEC761AF
	for <git@archiver.kernel.org>; Mon,  3 Apr 2023 22:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbjDCWdw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 18:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbjDCWds (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 18:33:48 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91290423A
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 15:33:45 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id t4so25642599wra.7
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 15:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680561224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kzyaut080C5Mk+YZcbpDJgzsXvOXxhqZg0mRjZEaONM=;
        b=H9y62mXlA13IBovqtRGSOpWo6vGfcMtrEZ2OPdShDN1nqApNMgMLZQl6Vuy4wCG/U3
         qgj1N5ZnwQXjrfCeX44EcsEKsDgsrpH9DRSOU2diRylHoYdLN2WgCzidyxwxIcgSfPla
         wW4vYGMNlY3N+MoM6cu8Tkluh56/HjVTXYHETnBlZJHIO2RImumfq0Z/1J5PyiTDq0c6
         Uf9xNF3daRkURnbD/ge2tABRwLwnQ/RRLVEHjSREaezSoFQfxQ4mc+2uEWL60xihdLiD
         TvgldkHFUu6hl/tHUzuHKBrdAe5FubT2qL/w8QPTDl5BAI4xMtMcSDFVtLkTKWGLiZ/M
         Hj7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680561224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kzyaut080C5Mk+YZcbpDJgzsXvOXxhqZg0mRjZEaONM=;
        b=0Z/XYmT5vKBwmxYw2u+zUrwNG27GlyIE7ynsobYQFNeNy2pwJS3C31bWK/WIQEjlcy
         HVY9D91ZMMroxZJ3eQv4cakeo25sSchkfjZz/5eimiTP+FG/jP7tsWMx5w9QPQhGzLOU
         f4JD1+IU1a+eJ4sTmyr9AGQz+J9X+UWhmFxhLZw3mORKm/1ezzLq2nvTkL5yIKDCJ/ZY
         f5uTkshi5EQTRQPStR/d4vy95z8SjVS1PbPSbdXJfb37OM8UC+94oKlGU/Y3LHnCijGg
         ueJj5BRg5qMhuomHed5cjSHBgxQeR4zb9hPc4bXunnkX/l6yUdKSAG68S4AH6e8XTl7p
         DOrg==
X-Gm-Message-State: AAQBX9epDb4AGUvvhJUzuod4KmRYiFSL2ZrmoenteeuNCNZ8u/lmkF7f
        Vc1/V2U1LT9YrtHPDU2a7YSo8pPn8qqm87vcark=
X-Google-Smtp-Source: AKy350aaL/OowHuZIbs3LmGhDSoUCMIJ5fd8pGoNvPb0aJXvcYCvG/2sJypQLsZwSZ/NY8YLXbi1aQ==
X-Received: by 2002:adf:f312:0:b0:2ce:a893:e45f with SMTP id i18-20020adff312000000b002cea893e45fmr99154wro.15.1680561223584;
        Mon, 03 Apr 2023 15:33:43 -0700 (PDT)
Received: from titov.fritz.box ([212.102.57.24])
        by smtp.gmail.com with ESMTPSA id m17-20020adfe0d1000000b002d1e49cff35sm10697453wri.40.2023.04.03.15.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 15:33:43 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/6] t1450: don't create unused files
Date:   Tue,  4 Apr 2023 00:33:36 +0200
Message-Id: <20230403223338.468025-5-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230403223338.468025-1-rybak.a.v@gmail.com>
References: <20230401212858.266508-1-rybak.a.v@gmail.com>
 <20230403223338.468025-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test 'fsck error and recovery on invalid object type' in file
t1450-fsck.sh redirects output of a failing "git fsck" invocation to
files "out" and "err" to assert presence of error messages in the output
of the command.  Commit 31deb28f5e (fsck: don't hard die on invalid
object types, 2021-10-01) changed the way assertions in this test are
performed.  The test doesn't compare the whole standard error with
prepared file "err.expect" and it doesn't assert that standard output is
empty.

Don't create unused files "err.expect" and "out" in test 'fsck error and
recovery on invalid object type'.

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 t/t1450-fsck.sh | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index bca46378b2..8c442adb1a 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -989,10 +989,7 @@ test_expect_success 'fsck error and recovery on invalid object type' '
 
 		garbage_blob=$(git hash-object --stdin -w -t garbage --literally </dev/null) &&
 
-		cat >err.expect <<-\EOF &&
-		fatal: invalid object type
-		EOF
-		test_must_fail git fsck >out 2>err &&
+		test_must_fail git fsck 2>err &&
 		grep -e "^error" -e "^fatal" err >errors &&
 		test_line_count = 1 errors &&
 		grep "$garbage_blob: object is of unknown type '"'"'garbage'"'"':" err
-- 
2.40.0

