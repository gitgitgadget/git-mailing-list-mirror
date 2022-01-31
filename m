Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DA5C433F5
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 17:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381120AbiAaRu0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 12:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377817AbiAaRuY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 12:50:24 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C75C061714
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 09:50:23 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id e8so27035786wrc.0
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 09:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=q3CjFNDis9kqpZX++fMcdB4cW0iE2eypUt2qAg30AU4=;
        b=nW77tueZTDfFSuiOg/XcPVf6sAUUJugRZmRbmCNIAbDgimGyXn+xRNWe7m8gCVay+s
         lWzbi7x830DJIwjtzl1jrM6LY2dQYPM5GuhHhh2qYRIeWm/G78M/zMXa5N4ZFT+nfAhL
         c3jTava8WzXW91dDXw6sNa4E01s1J/vUdRCry1+Fu1VtX7mYnkrt7AbmaE2EyL13a4v9
         A/2Y0+WhkbyZT2qyRZ2Y+R/uHs4Wv4Jd5GdklYegjBJX0eKXNm31+sn+OuKfEFTzgr3s
         i9g5rS4JXSf1JJlqAHDHn/Uzv/PaeDOrneIzyJ/aytvlk4ZLaMTme/yKLrqy7TsuU9+x
         PTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=q3CjFNDis9kqpZX++fMcdB4cW0iE2eypUt2qAg30AU4=;
        b=xymlhDSBOSyF9P5VM9lRh+qiWggleP6BmrcGyM+wcw6NVcY6jYA3PdN8ZFHrPZ2+Gr
         F08HyNS2hGvYLeAownb/P/1f7WuNrVRAZzkaONBmtSEaFu+6SY9rbLg5TN2vZBfxL2aO
         m0xORZaIi0y2vfAEP9pcyb9tgxGn3bQpENagjcY+adoL+kr43JZa3uNQAiFxW33nmXjm
         7y/bDqP4Uq+IpWkBETDEUvG1NK6HdW+oiYr364o6OgP0zo7ebHDKOnDFbha0r/OtgJcs
         ePSdKJwH/bexfPAzA14hrCxmy5a+PZbAZjceLchM0PPB1kwN7G4z79yRUQ0xrgokRFsL
         aqtQ==
X-Gm-Message-State: AOAM5331cgT7k0OdgaWwMkyDD8i0zN42MqwaANRTULr5KIPXqY97gdk+
        bRC1D8nudLMgqyRXWVmNAcBU9DNOhS4=
X-Google-Smtp-Source: ABdhPJwPdlIKBX8wzotMxWD8GPEEI4rnX/CBb2cb6+bO1SILEP58GFAopX5akB4YvpVWHk6YjcVFbw==
X-Received: by 2002:adf:e2c5:: with SMTP id d5mr18919248wrj.32.1643651422240;
        Mon, 31 Jan 2022 09:50:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i9sm14825272wry.32.2022.01.31.09.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 09:50:21 -0800 (PST)
Message-Id: <299451d317f83b908ee4ba750405302238209103.1643651420.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1209.git.git.1643651420.gitgitgadget@gmail.com>
References: <pull.1209.git.git.1643651420.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 31 Jan 2022 17:50:18 +0000
Subject: [PATCH 1/3] t1405: explictly delete reflogs for reftable
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Deleting a ref in reftable just records a (ObjectID => ZeroID)
transaction in the reflog. To ensure 'for_each_reflog()' test below
works, explictly delete reflogs for deleted refs.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t1405-main-ref-store.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
index 1a3ee8845d6..62e5e9d1b0a 100755
--- a/t/t1405-main-ref-store.sh
+++ b/t/t1405-main-ref-store.sh
@@ -40,6 +40,12 @@ test_expect_success 'delete_refs(FOO, refs/tags/new-tag)' '
 	test_must_fail git rev-parse refs/tags/new-tag --
 '
 
+# In reftable, we keep the reflogs around for deleted refs.
+test_expect_success !REFFILES 'delete-reflog(FOO, refs/tags/new-tag)' '
+	$RUN delete-reflog FOO &&
+	$RUN delete-reflog refs/tags/new-tag
+'
+
 test_expect_success 'rename_refs(main, new-main)' '
 	git rev-parse main >expected &&
 	$RUN rename-ref refs/heads/main refs/heads/new-main &&
-- 
gitgitgadget

