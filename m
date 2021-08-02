Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13B1C432BE
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 16:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9955F610FF
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 16:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbhHBQyD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 12:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbhHBQxy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 12:53:54 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6E6C06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 09:53:44 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id m12so17457258wru.12
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 09:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=seSpVRnyF3qCO7FBgEfjVHC57Fx6Tbn3cxCgWT3vZUg=;
        b=niJ/9cW1BXgEIJov646R6sO3MlIfYRnifE/F8YqfJsl6si4ZeCvtcVVYbBSMl/1Cp1
         ZQL1N3IjlfZxaVPv15ONheownAeBq0KS34mfuMNRBrepyNqEvGxSnbXf51sRWKgqcxvh
         dMwKVWfUU6VNPQaCmmeYieXh1z134AmR7qRaaWZgtO1/yiOFIs6LSYf0QDo4YJQut85p
         lkEOm055jCnOLGdZa+t5IPyuEzgWZi70eoSwyObn7MXS23GsLoVV0S94vNhoDT6pidv/
         soTE75ah79jSN6yKDUXqvK2NiVxQd8AIqEQt+E531rsfTIyDMS3XFWaQcVhF/eF+9jy0
         C3Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=seSpVRnyF3qCO7FBgEfjVHC57Fx6Tbn3cxCgWT3vZUg=;
        b=loOLAjVO7oTJNab2nnpRXl48NlGBi6pMBaqE6Eyu/NxRNCpnAAi+d93+NQ/BTKTP9F
         jPn6LX6L237eRdFx+PmIx0Tin/spJLO5PcrlqwWymGRkKEQoMKJf9LkmC1TTltQAQqxy
         qa35ZWpMg6SchPwyqCeEudI+4qodrT7/Kxa/zuJzojQIXt5As/v51ofsJ6sZS7Vuhgtu
         yI+lJeCGThqQKsVpUU7unmALpO/ILhWam1Kew+9bFispwB2JRnIOR2/WkyPxfalDYljh
         2kBmCiboocBlt8/r/ByOa00L4lKM+DTDHEYouRYYOZvWpT7xJLN1+b5x/V4JJTE0NZCT
         ytBw==
X-Gm-Message-State: AOAM5308RookavKcDtAkFWfgcgzw8SRYT3+E6QfztXGiD7QNqjVGKBIJ
        Zg1wsf6Dsxw5eFVfeMTKF3Yq2WbqU7U=
X-Google-Smtp-Source: ABdhPJwiu0tPBQLzLaeTA+ZB7JRpRzvG7G2V7cNXDNtUmtljWqFUOqf9OHV5m02KrxvIHwb8Tt3qew==
X-Received: by 2002:adf:fd90:: with SMTP id d16mr19673525wrr.105.1627923222981;
        Mon, 02 Aug 2021 09:53:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e3sm12498687wrv.65.2021.08.02.09.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 09:53:42 -0700 (PDT)
Message-Id: <45bc0772c64ee09a69122d3721271f827a21f909.1627923216.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1052.v3.git.git.1627923216.gitgitgadget@gmail.com>
References: <pull.1052.v2.git.git.1626989327.gitgitgadget@gmail.com>
        <pull.1052.v3.git.git.1627923216.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 02 Aug 2021 16:53:33 +0000
Subject: [PATCH v3 08/11] t1410: mark test as REFFILES
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This test takes a lock on the target of a symref, and then verifies that it is
possible to expire the symref's reflog. In reftable, one can only take a global
lock (which would prevent the symref reflog from being expired altogether.)

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t1410-reflog.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 27b9080251a..d42f067ff8c 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -374,7 +374,9 @@ test_expect_failure 'reflog with non-commit entries displays all entries' '
 	test_line_count = 3 actual
 '
 
-test_expect_success 'reflog expire operates on symref not referrent' '
+# This test takes a lock on an individual ref; this is not supported in
+# reftable.
+test_expect_success REFFILES 'reflog expire operates on symref not referrent' '
 	git branch --create-reflog the_symref &&
 	git branch --create-reflog referrent &&
 	git update-ref referrent HEAD &&
-- 
gitgitgadget

