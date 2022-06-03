Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C37C43334
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 18:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243941AbiFCSjS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 14:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345588AbiFCSjA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 14:39:00 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85B813EAA
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 11:38:03 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id h5so11495907wrb.0
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 11:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a09JlpZT0ogRdnez4hhbLajAYxgnZVENMSQ3BEgDdRQ=;
        b=W7MMOfhQrI9BrhJr8d9/7ATVOrubU6snYcFdzcV3fs3F/V0+PJ3txN0YvSGNxRHrBU
         +aXPA0iEN/9zVO/PqL0/DNZ/7bmyQkPJgE85FSf6MbsFEvLbgq3EyVF8ol8GxjUMVpGb
         qKHj6pFvmCA9FwY2FB0Kcbpy0QWGnXcMKrWnSLmhJ5Du2cbxn6Ul5Ar9xP2/eRGzCEtG
         wo+wJYXbms5dk6EwLP9jrAoYY2PMnKPgVwkGIMgVqSmG8WlcIJB7t3bnibjXsROOltWN
         vCqfKSD0PWBpjbPz4orttto5xHJwUOoMA92kJzHqauy+LFj9oM5gbLzT+EjCAb1Fy0GV
         6KjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a09JlpZT0ogRdnez4hhbLajAYxgnZVENMSQ3BEgDdRQ=;
        b=DlxNpVI2akingtMIMkOfCpPrMW0kEGZ9l0l2sI6ZDBgXtVHe8tHXhYSg3pQRPn21VO
         7R2IFlPvPA5nLOE2m0LiQYWpIaBZXnhixIl+apkcQPtX/HjsJxHirRkKQtCRsP0Qcvnt
         Hk7tm6XWGkai3FIRId1qJ6uUQaF4+GSWAadjAzba4s3mZGQqppbjB08tj+kwbqICziSE
         XJdz2MGj0OcmoSI3UeUgvIxkpHgcuoxRMf3z5DSdWVXYLPUzBZKLYpPal9ZOLeLx1Pgh
         Wf0Kitka21AeRK1PP+1rtXVrHNCFc2VfcJNFJBKAWAh5RX+OqkZGvPxRACx4GlEMjT3g
         V0Hw==
X-Gm-Message-State: AOAM532PdWr8XnjVWxPpO35Wt7llsCyi/5VPHoILLrK1UsVI3RVnKan0
        64ff7IReYLUjO7cERUiHBTuhzWCmwNDp0w==
X-Google-Smtp-Source: ABdhPJwSNy6n2ZvbJvK3yzVcyIIhHDVEB2Yx/w+3ywkID3nwzAIi/JhFh/e6wFA+G7tpeLsAE5jhKA==
X-Received: by 2002:adf:e6d0:0:b0:20f:ca28:2849 with SMTP id y16-20020adfe6d0000000b0020fca282849mr9639994wrm.381.1654281481447;
        Fri, 03 Jun 2022 11:38:01 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y5-20020adff6c5000000b0020c5253d926sm8232636wrp.114.2022.06.03.11.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 11:38:00 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jinoh Kang <luke1337@theori.io>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Glen Choo <chooglen@google.com>, Paul Tan <pyokagan@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 01/15] remote.c: don't dereference NULL in freeing loop
Date:   Fri,  3 Jun 2022 20:37:38 +0200
Message-Id: <RFC-patch-01.15-b3a678d934a-20220603T183608Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1124.g577fa9c2ebd
In-Reply-To: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
References: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a bug in fd3cb0501e1 (remote: move static variables into
per-repository struct, 2021-11-17) where we'd free(remote->pushurl[i])
after having NULL'd out remote->pushurl. itself.

While we're at it let's get rid of the redundant braces per the
CodingGuidelines, which also serves to show in the diff context that
we were doing a FREE_AND_NULL(remote->pushurl) afterwards too, let's
keep that one.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 remote.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/remote.c b/remote.c
index 930fdc9c2f6..61240562df1 100644
--- a/remote.c
+++ b/remote.c
@@ -144,14 +144,10 @@ static void remote_clear(struct remote *remote)
 	free((char *)remote->name);
 	free((char *)remote->foreign_vcs);
 
-	for (i = 0; i < remote->url_nr; i++) {
+	for (i = 0; i < remote->url_nr; i++)
 		free((char *)remote->url[i]);
-	}
-	FREE_AND_NULL(remote->pushurl);
-
-	for (i = 0; i < remote->pushurl_nr; i++) {
+	for (i = 0; i < remote->pushurl_nr; i++)
 		free((char *)remote->pushurl[i]);
-	}
 	FREE_AND_NULL(remote->pushurl);
 	free((char *)remote->receivepack);
 	free((char *)remote->uploadpack);
-- 
2.36.1.1124.g577fa9c2ebd

