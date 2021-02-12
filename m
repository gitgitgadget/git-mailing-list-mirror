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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2D0C433E9
	for <git@archiver.kernel.org>; Fri, 12 Feb 2021 13:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96EE464E70
	for <git@archiver.kernel.org>; Fri, 12 Feb 2021 13:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhBLNcH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Feb 2021 08:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbhBLNbV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Feb 2021 08:31:21 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECA2C0617A9
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 05:30:03 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id v1so4321720wrd.6
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 05:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eTUrbus+7fU6b/FgX/xfOphNnsBKjv+9IP91do+BagU=;
        b=F/P/8YDw8QotO3kWXwvRXl2VS2qVcd7MbVTbdATEPXMMdyHEX1QdJIUZ0VMkKyLR9A
         3VOBFDE3OBnXtkULnWnga4yjRhsjVnoOKYiTNQDNtCMRd96I3SlKE2VxXfUWz8/Drmsa
         PVfc2w29QVbYaXN60OcnHHW1FwRFBf9h1PPCnep/AvYachOy1oKiqFnqb+nzHkHBLgwq
         53rVOZZbN6y2VpJ3ky+bkYAOuDPCc+gPeakLMPHyw4j8RL2e5B4lYPqHRYGwA0+WuqkF
         qBzbLl57ecyP9DiQOjWSA6xNiZW144X5jwVjDdS9+dWfO/kKOp41CbK7UatpWncNOBZD
         1e3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eTUrbus+7fU6b/FgX/xfOphNnsBKjv+9IP91do+BagU=;
        b=DIXW+MiM5h02Pf4hZariv1Tzy35gz6lmgN7r/F7mP0pA7BMMBnPVx9Dy+tPWBW+jLx
         aN+rH0i2nDRbh5a+sWFWtsxbwp2W7uab6aGs1J4plSY9FU47gbZ3HmvzltnfIqGQSRqW
         NnvPyYNR+7NZJNAGznQY3IcTU+TKFmjEZ8YnHQyzHraFqiFPmr8mc6Ns758w6rGzftvv
         znRWdg/HiwVc3Wu38vpzMlWgQOz600/m6iJl7YvnTTrvfJcGD92+oXe41eMI5zZ5aYO8
         rtqfT/IAaOXkM4xe1A4hzRjiu6qFd1cinLSSKicj5sYsIj9dj1c3ifbKGBUDY17aTC5V
         HuqQ==
X-Gm-Message-State: AOAM532KL0ZwecI0ZKpqNynapHyP+fDRm7mEtPd8m0ew7ldVHD05zELi
        hFDpyTHF3tkSlFouRCSPU8UxeBsotRlx7Q==
X-Google-Smtp-Source: ABdhPJwmDZDask7337tmflAqwgGRpuk1huc8VvqXK5TlNiis5KhLv2GyCKB1cT51m/dMFdQOJ3nk/w==
X-Received: by 2002:a5d:654d:: with SMTP id z13mr3679802wrv.62.1613136601909;
        Fri, 12 Feb 2021 05:30:01 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 13sm14060682wmj.11.2021.02.12.05.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 05:30:01 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 08/11] t/.gitattributes: sort lines
Date:   Fri, 12 Feb 2021 14:29:39 +0100
Message-Id: <20210212132942.17325-9-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210209214159.22815-1-avarab@gmail.com>
References: <20210209214159.22815-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sort the lines starting with "/", the only out-of-place line was added
along with most of the file in 614f4f0f350 (Fix the remaining tests
that failed with core.autocrlf=true, 2017-05-09).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/.gitattributes | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/.gitattributes b/t/.gitattributes
index df05434d32c..d778bfad052 100644
--- a/t/.gitattributes
+++ b/t/.gitattributes
@@ -5,9 +5,9 @@ t[0-9][0-9][0-9][0-9]/* -whitespace
 /t3206/* eol=lf
 /t3900/*.txt eol=lf
 /t3901/*.txt eol=lf
-/t4034/*/* eol=lf
 /t4013/* eol=lf
 /t4018/* eol=lf
+/t4034/*/* eol=lf
 /t4051/* eol=lf
 /t4100/* eol=lf
 /t4101/* eol=lf
-- 
2.30.0.284.gd98b1dd5eaa7

