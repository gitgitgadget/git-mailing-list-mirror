Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CE8C433F5
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 16:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357751AbhLFQ3l (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 11:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352995AbhLFQ3j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 11:29:39 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CE5C0613F8
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 08:26:10 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id o29so8615122wms.2
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 08:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7oAFd+T9bgT/uBHukQ2pj4+iinrlwmq8/pya8UpAF8w=;
        b=NtMYpSLJyc62XAc1Z5CST9l65OjHIGcWYWRlsSH1JULAWiNwh53yS9kUrZu1CDJtO2
         63G70/KpG3pfJ9YtwTpl+kk+7lGNSev3UcR9VPyjFOabAtdJ30f9T9lRZe/JwObdHRfZ
         pLyJuiSqPq1Gnr8EN0Y1xHnKTvQPLOD6409cmTDCqcoepuLaYt0ZmCpHZmHa/tPZ77zb
         oy+I05yRjeEKYUORLcBJSkhSF5E3li4pypfpvwsnMDiPuIQ7rsIGa4TvT7x6qREW/R4n
         qFul1eyvGOTvSCXCEBmz5n3rrds0VKRi7tWkX6CD7cG8BzZa5vaR++v4DQFK3s6NdZV2
         JJxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7oAFd+T9bgT/uBHukQ2pj4+iinrlwmq8/pya8UpAF8w=;
        b=xfPjVf6D4fN3BNJBjm99REfXR1sGyvvssi9CsaEszmnOVC9lKxYRx9HEUPJ9aLvJED
         al3z2f3Q3pe8UBckOiRNra1U1lSKdpvbIhvPTrmJ+hBb88g5fRSD/JmJnNiDr64/F2/E
         Opb5kdIbR7mYnvRvoFxkemn6ENJKFt5aIi57gpQnzIYzssXQumZbHjaGbWzKZy+GWc0s
         +mdoxnZRdRmd5TIVXYwr7WhsQVGeM+1Qjzi+rM7HZhTZynY+KRCAyjitNzHSkbCFlfae
         ZCYgwTprDaASDA3dVIp3ewc7Pg3rZt6ZGbRLzwaG6v8R14EN0JvoQECMDGCIs0DCaJGA
         nHGQ==
X-Gm-Message-State: AOAM531IOJAnJi2ksmhi/gsx5Ub5jfvRFx/Ya9mrP9xc9ask3hyxeahW
        9RD131nnX39wfMb/BmLRcSDyRKuscTFaXQ==
X-Google-Smtp-Source: ABdhPJxRpIs00iiXSBQ0yUVNFtWl8wdc9xCB8C0Tu04LjkDp27GM4s4BpYNCbntd0FebPJDvQ+4FXQ==
X-Received: by 2002:a7b:cd0b:: with SMTP id f11mr40139198wmj.3.1638807968423;
        Mon, 06 Dec 2021 08:26:08 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q26sm11740173wrc.39.2021.12.06.08.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 08:26:07 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] pack-objects: use BUG(...) not die("BUG: ...")
Date:   Mon,  6 Dec 2021 17:25:20 +0100
Message-Id: <patch-1.2-2a17ed9f135-20211206T162442Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.898.g5a552c2e5f0
In-Reply-To: <cover-0.2-00000000000-20211206T162442Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20211206T162442Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change this code added in da93d12b004 (pack-objects: be incredibly
anal about stdio semantics, 2006-04-02) to use BUG() instead.

See 1a07e59c3e2 (Update messages in preparation for i18n, 2018-07-21)
for when the "BUG: " prefix was added, and [1] for background on the
Solaris behavior that prompted the exhaustive error checking in this
fgets() loop.

1. https://lore.kernel.org/git/824.1144007555@lotus.CS.Berkeley.EDU/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/pack-objects.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 857be7826f3..b36ed828d8d 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3397,7 +3397,7 @@ static void read_object_list_from_stdin(void)
 			if (feof(stdin))
 				break;
 			if (!ferror(stdin))
-				die("BUG: fgets returned NULL, not EOF, not error!");
+				BUG("fgets returned NULL, not EOF, not error!");
 			if (errno != EINTR)
 				die_errno("fgets");
 			clearerr(stdin);
-- 
2.34.1.898.g5a552c2e5f0

