Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50550C433F5
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 09:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D9AC60E96
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 09:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244131AbhJPJnI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Oct 2021 05:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244018AbhJPJlx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Oct 2021 05:41:53 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6A1C061570
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 02:39:43 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id v17so30652245wrv.9
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 02:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FqZCLL3ZgQsdqVj3WYAePTaxfuMPqit5hVwiHuepOTA=;
        b=dFC/+fR3jZoqZegSE6pScvUlJKxRCg8THqC9gKr2yK1LokAZ2xLb4OuGily8Mmo7tW
         13SLs5h7l4CDBIXulr0xAHJlWaOFkIHgYvGa9NbdZlIrwMG85I16vGgnfKBtiUxLeyO6
         xjTAH3mQRyVNmQ0Sj0ZY3ml7jrTMGV1Wuxr5ii23Og3MObWayZNfrqjHE9JRrlwPk+iF
         +Zx2gfVA2YWY4A4h4ZQ7989ojqfXwYGfmg43PZvNol0ME1J1Zq00y2yORTG+OofpTaIt
         ag2Jt4PE58Szi9FaFs6KphZbA9useleUXT1GicgUyP6pMjbaaooCtvjH1NCkwIXsMowr
         gWtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FqZCLL3ZgQsdqVj3WYAePTaxfuMPqit5hVwiHuepOTA=;
        b=K+kfsr/oET7YzVVuTEw8IwBAhrEndU6MPY34lcVGJ/orP9mcnqoo2CIE0e+ZhINDoW
         bTVV/VyzP92xWnDjuUPSsFjEUYeZuMxg1YBtvK3CYaXpzwTCOTGdTrUveRl1JSplePht
         B30umLJl/UAdvXgizA7zjxX+B0Qkr22qhNVtkMddrKTlKfi1zd6rvy+iQQ6GUn4KRqye
         FMMrBPsH1Da3KOu1gdMOWDyGG/1OMpWfb2WCED6+ibtQ6Ct4ACX3ehSRCDrlqEqZZpBH
         sNmXE/ZtVCcig/+d+2YBBzJYGpIk3p8ams/Vh9xYvCSohdSozqHtWNL7tks06hxAA+F/
         fGRA==
X-Gm-Message-State: AOAM531DJ6t5/Wsb7V/K/1+sPIX/etvJKYGoD/0Ff0//pKdjHoxDMOJH
        NCZAbppM2zbSQnsYiRzwC6HKBf9S+quHGA==
X-Google-Smtp-Source: ABdhPJwryagies1Eu0Rx65vokFl1Mnf5pAqX4og/3fHPpX2PWjmRpwnfpYdTIAwKrr8wrQSu0xbnYA==
X-Received: by 2002:a5d:47ac:: with SMTP id 12mr19812069wrb.352.1634377181936;
        Sat, 16 Oct 2021 02:39:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k22sm6993492wrd.59.2021.10.16.02.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 02:39:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 16/21] refs API: make refs_ref_exists() not set errno
Date:   Sat, 16 Oct 2021 11:39:22 +0200
Message-Id: <patch-v2-16.21-c4e87181121-20211016T093845Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-v2-00.21-00000000000-20211016T093845Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com> <cover-v2-00.21-00000000000-20211016T093845Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move refs_ref_exists from the legacy refs_resolve_ref_unsafe() to the
new refs_werrres_ref_unsafe(). I have read its callers and determined
that they don't care about errno being set, in particular:

    git grep -W -w -e refs_ref_exists -e ref_exists

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 09452b5e413..8d5a76fbf29 100644
--- a/refs.c
+++ b/refs.c
@@ -309,7 +309,9 @@ int read_ref(const char *refname, struct object_id *oid)
 
 int refs_ref_exists(struct ref_store *refs, const char *refname)
 {
-	return !!refs_resolve_ref_unsafe(refs, refname, RESOLVE_REF_READING, NULL, NULL);
+	int ignore_errno;
+	return !!refs_werrres_ref_unsafe(refs, refname, RESOLVE_REF_READING,
+					 NULL, NULL, &ignore_errno);
 }
 
 int ref_exists(const char *refname)
-- 
2.33.1.1338.g20da966911a

