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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467ECC433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 08:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E9F661182
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 08:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbhDIICD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 04:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbhDIICC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 04:02:02 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01AEC061761
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 01:01:49 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id r12so7235763ejr.5
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 01:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QsVclY8lgOEutAUG2e6Bl5AMh5ICsQza2p0sDwZbULw=;
        b=DqJ+6fujE2BHzFEONiGG72chKmhuJPuy9jUK8NaEw9JMF8aKM7BFS4u43ugpfZKlSl
         adCr6XaFeKE924eEFZSfHon8FzzxIFGj8MuRicWbFAiwOyN5LklPumTnGR1x7eJgtp0r
         VTSWXr2UQT4xJq6CiUHKpvXZQLXt10+GSEkqzT1MHvler3ahUDfzBQP8jycWxuPBNQbH
         tA+nAyAyFdVjIWTXKT03YsaLzgi4JKW1oP0KCJZLHgJJ/+CmmORvEouT9PNImYFRTL/G
         XSKgZBOs25w+quVfsAyQ+5JzCv9UpF8AFfOfcEojkTjauBiDi5NZtqVQaDofBoDMxOcT
         MpeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QsVclY8lgOEutAUG2e6Bl5AMh5ICsQza2p0sDwZbULw=;
        b=FDksWl3bliz0HrDtMZcGajZSJX+WSXfbyJkyQDdw1KHRy9oqJ+v86ugCMp/5YkSkAq
         GqqNuP54eC8jVs0yk8Cvea6nzllZwDfcjdNM/KdhKFtcSL3El1NpWeHTpOHKnYIkESAH
         n2mGJbqrTcdHqkK3YMj7LgPUzdosvxmFdXMKoZHdEf8WijtJq/XVUOnHCHoSseCRJXjX
         ud2y80ToWxDf9ykR/QmsdDsCO2gLS95RrQoYjg/7jZp0oWUx5Sk+VXFYbML1oBnCAz6a
         ZLDG+JF4lCmB3yeG8zCOmacl+auAUfsb7n+rOXJxu9Jp8EYUzQ+PiL1xpjFI3D2f6YNH
         DScg==
X-Gm-Message-State: AOAM531XMS/GEl87vVD3hM0fnAhIGRo14Jn7aMpKjAFyO+6H0Ayzqx/9
        KBF8cv2M3aiMQW0/67qM0+/VXA7hUJZj1g==
X-Google-Smtp-Source: ABdhPJxVR5ESV/6vqErBxZ27jtilIZ4vaK5+UOteBwG/CdUFNOOwBbVXoPgK95YgvnGKopVov5Ifww==
X-Received: by 2002:a17:907:9845:: with SMTP id jj5mr14792970ejc.299.1617955308200;
        Fri, 09 Apr 2021 01:01:48 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k8sm955177edr.75.2021.04.09.01.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 01:01:47 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/2] rebase tests: camel-case rebase.rescheduleFailedExec consistently
Date:   Fri,  9 Apr 2021 10:01:37 +0200
Message-Id: <patch-1.3-e0dd2cb82a-20210409T075713Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.584.gf4baedee75
In-Reply-To: <cover-0.3-0000000000-20210409T075713Z-avarab@gmail.com>
References: <cover.1616411973.git.avarab@gmail.com> <cover-0.3-0000000000-20210409T075713Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a test added in 906b63942ac (rebase --am: ignore
rebase.rescheduleFailedExec, 2019-07-01) to camel-case the
configuration variable. This doesn't change the behavior of the test,
it's merely to help its human readers.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3418-rebase-continue.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 0838f4e798..fe407e63cf 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -282,8 +282,8 @@ test_expect_success '--reschedule-failed-exec' '
 	test_i18ngrep "has been rescheduled" err
 '
 
-test_expect_success 'rebase.reschedulefailedexec only affects `rebase -i`' '
-	test_config rebase.reschedulefailedexec true &&
+test_expect_success 'rebase.rescheduleFailedExec only affects `rebase -i`' '
+	test_config rebase.rescheduleFailedExec true &&
 	test_must_fail git rebase -x false HEAD^ &&
 	grep "^exec false" .git/rebase-merge/git-rebase-todo &&
 	git rebase --abort &&
-- 
2.31.1.584.gf4baedee75

