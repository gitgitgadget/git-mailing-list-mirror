Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F268C433EF
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 00:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C663361164
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 00:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhJNAI4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 20:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbhJNAIr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 20:08:47 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A165C061749
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 17:06:43 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id i12so13777010wrb.7
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 17:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bxgX/gVIYLs66RMlG4oKqiflJASBIdu+81T4D7md82U=;
        b=QJNgNSENrTeY4KKZrKM0JHVdfbkq8jczW0bf55KnLkAJ6MqkXqcHuTG57mj7Dve1is
         vljweWgjlYURIhTxnO8zdl/XFqz9QfuOQ5uAK7/PAE7G2t+og6z71/bVkohbenqcwXbs
         ZptvqKwca0+1qwS0hVATOgLdKsX+++Bxq4lN8t6zT+YV14MzDjpRXX+LHD1C7rYQWN04
         h5AbbgK8TTS2dj8cebuanvC6LNy+WBB4N7fkIhTn13H+ASh/zoG8cOeWwOlvNOOD13Z+
         z5IENFW7Uhk+tNLD6dhn0mcIAWyCZ1H9KOuEtJ8oNSU3j8tXOaIYXyKOmCcoumAG/7bt
         OtbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bxgX/gVIYLs66RMlG4oKqiflJASBIdu+81T4D7md82U=;
        b=tAXrFA36Y25mXhgJ3H4kC//5cOy9cND1+T20+l2Hf2Ut3ior6QgvYOuFX5w9SwSmKr
         C0EIygq3QKapu3as/oFU9fr0meYVgE5G9jzP5acFlVKfUdMG1hJ18ncaauGiV0CVgEZj
         ZuFP/OHuWD5Gu/chF+FMmGq0DwoTm97716bJA3+IioCHHo65uVCpBOvYBonT33PPmTln
         7iVzioquLgQJ1uMytavpqzyW1fAc1n/eboBaUqRSiXsFvVZkqFHfRU2U2/hnybn6ixOu
         r0ejey3NA0NINz6CXi4bEQJ0YUmjE2gBT/RN3oZGLKewVFX0fPMwRYbHBhEyCu3FzkjY
         A6Fg==
X-Gm-Message-State: AOAM532BdfCymuV0uxuKEiPrMLYFNfFAl3tEcvDf4QeEg4F00Jt+3HP3
        NS6jpAI7wAT3TAs+HqL/JxuhjnnUUJ6n9g==
X-Google-Smtp-Source: ABdhPJwvC2siMZEPUzCYKirUE4UbLb1uqR5Schasz9N5/qNUVRdtsGq2unNw0DDCNCEg3TOVeMmjjw==
X-Received: by 2002:a1c:2b85:: with SMTP id r127mr16022432wmr.134.1634170001578;
        Wed, 13 Oct 2021 17:06:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y8sm670711wmi.43.2021.10.13.17.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 17:06:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 09/20] refs API: make loose_fill_ref_dir() not set errno
Date:   Thu, 14 Oct 2021 02:06:21 +0200
Message-Id: <patch-09.20-4be84c9bf53-20211013T235900Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1346.g48288c3c089
In-Reply-To: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the refs_resolve_ref_unsafe() invoked in loose_fill_ref_dir()
to a form that ignores errno. The only eventual caller of this
function is create_ref_cache(), whose callers in turn don't have their
failure depend on any errno set here.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs/files-backend.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index be27823d099..1d27f915638 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -280,10 +280,11 @@ static void loose_fill_ref_dir(struct ref_store *ref_store,
 					 create_dir_entry(dir->cache, refname.buf,
 							  refname.len));
 		} else {
-			if (!refs_resolve_ref_unsafe(&refs->base,
+			int ignore_errno;
+			if (!refs_werrres_ref_unsafe(&refs->base,
 						     refname.buf,
 						     RESOLVE_REF_READING,
-						     &oid, &flag)) {
+						     &oid, &flag, &ignore_errno)) {
 				oidclr(&oid);
 				flag |= REF_ISBROKEN;
 			} else if (is_null_oid(&oid)) {
-- 
2.33.1.1346.g48288c3c089

