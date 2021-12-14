Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2F5C433FE
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 11:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbhLNLsR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Dec 2021 06:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233707AbhLNLsD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Dec 2021 06:48:03 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC9CC061751
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 03:48:03 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id y196so14020118wmc.3
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 03:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=J9jVqwMPaNdDSNjujdVEAD8serufDJ5UG7qKldS2NTo=;
        b=Lm9CEm1FvyDP16mfEwyD0C8AEtR9ap79TeU0pnqU32SW0k+r22c7f9R+JyITW3nFYZ
         +btK8/gHadkYHuMbwLx8+C7E5C7GfKYcWiLppTnJGyLyd48YV2+9UxfYvMSM/ZHahIGU
         d5+9m4Fm+6YcUX0C7Wgklu9xPZYW/xAVC6XGOQt0aF+DNa0/P/LPq8Z4RZ0mM5MamX6O
         nyiQ5tiwzHxqDNR+ekUVnaTo/lpggsy18B2MyB933XrX1BK7gt9pFW4kzQ0RwDVCNTGi
         U0k23JRLnS3DS2HOnGb38KR/l5srxZCJ9Sg3cyu9V/VVoFcAaxRcpGOG1m/epeR5QwtX
         dFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=J9jVqwMPaNdDSNjujdVEAD8serufDJ5UG7qKldS2NTo=;
        b=zXMvRE38L3e2SS6u3fWqoBSDClncQjYSvl5coVSdHHLTWhq94Xfq/K2W0cwEWo68L7
         qCJ3yZQLCW4mxEXu4y/SL7etyBwuuADm7KfA1wHKb+uBUsOzARnPX+Tt6wY7w6cgwfkD
         lGcPW+zl30Hvun3/JnKgapO+ZlZ1XdYAB+y3q3gWiBZhXdpaKjL4qfbjQLxmjH+6TH9k
         BXUXasgu3yU0iKxi1uumpXMFvMw0M1YiroNgr05ZyxT9ve+0Hlj7dSOxdWyVTzSacJDD
         nIXmRAeuCk18jszjUHvVZps/V4NOgN6/Qhorduycw/HuKE6R2GBSWWXg9caCzVTuyZL5
         MGZw==
X-Gm-Message-State: AOAM53202JWC+nzrwruu9qBZpkayxZCigmlqQ2BPkN8bPVtxjm28MrQD
        5doJDIb7j5zvQC/AxtUk5lyzV/YvSvU=
X-Google-Smtp-Source: ABdhPJwMzsVaISmyYImb06h+m44qOx4059OpI+aKJBEgnDQiOQVDqOAQ8CKBOsB/JI/z9bCXfEUUEQ==
X-Received: by 2002:a1c:4e04:: with SMTP id g4mr45286136wmh.15.1639482481629;
        Tue, 14 Dec 2021 03:48:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t127sm2132768wma.9.2021.12.14.03.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 03:48:01 -0800 (PST)
Message-Id: <43989afcb5a533c892739cf3d95f18b6d447e0e3.1639482477.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
References: <pull.1152.v3.git.git.1639411309.gitgitgadget@gmail.com>
        <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Dec 2021 11:47:50 +0000
Subject: [PATCH v4 05/11] reftable: ignore remove() return value in
 stack_test.c
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

If the cleanup fails, there is nothing we can do.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/stack_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index d628420e63a..4b7292945c3 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -89,7 +89,7 @@ static void test_read_file(void)
 		EXPECT(0 == strcmp(want[i], names[i]));
 	}
 	free_names(names);
-	remove(fn);
+	(void) remove(fn);
 }
 
 static void test_parse_names(void)
-- 
gitgitgadget

