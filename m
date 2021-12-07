Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9266FC43217
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 17:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240195AbhLGRtG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 12:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240175AbhLGRtD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 12:49:03 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909CAC061748
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 09:45:32 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id u1so31049543wru.13
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 09:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rJ3GDWKJ0GCH/2sQjyhi9Wp9eandivSrWcGSEkqQkNE=;
        b=lBlDuLugrAMpyMH0oRDVn82Kaz+ObDJxNnCVFH2cyAHirsGfWwjJwwBPimNPZG2B23
         /Wp4tILzoasQ3mtzWSws0IoEgoq4qnNu3Nx/zoGWkMlifeGDRpIPsHVzkN1yoe8Q7jK1
         yzSQo+U4mpXR+AUHlwLOSL63cF1Vx6ZkHRakOwJkPWc/rjnkEttAgja/meq5I8YwnUH+
         TrquB2rwECiqJo2ItkCunz3pIiXyQba0+LXgY9c0KLROc333vPqlH4C5INHGhdoKWXue
         DqtWS5eA6jJhi3kNn3jEAuPU5cBbtMvRGSNrN24EjEt1MfNoov84qmQD4DbupqzUvXpr
         2YWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rJ3GDWKJ0GCH/2sQjyhi9Wp9eandivSrWcGSEkqQkNE=;
        b=05LRqGs3WvRIRqvY9HL0DJIlIqjfNWxr+0aDnZOmSAytc4oTlxImFNuRAK+nA+H3Yg
         x+wyv2QeJBuW8cpk4wPZug804H6KCH0Ehs+nXMCUy+K/TGDkBr4gqLwz59MmoIfXrM0u
         /rQhpta9nH/7sdXBizw4ph6PIXAE7HK9d0AS3F1h0Z4SeEyqxlwJzIcn8r5OEEHF3b9Y
         BSbGUsT+Cilz/CZTD7jmmmb2vqv3wXk7R+geqhiTozU7X8+9Jj6l0V+0SBRz73+qDlUj
         S1YlsROP35AsjSVeQut7nXQgwJWzuO11BdOtMTT3M0iqc9ZhiBL7Ro+rsYd+VBYAvCrn
         gt5Q==
X-Gm-Message-State: AOAM533iICZOuIKKK4dKOzcXlC+nfXBsg0ikkdTtSJMS23jWp+y1VEv3
        gLE2WUVb7Ym1N37Ilj/DLQBMeftA/VE=
X-Google-Smtp-Source: ABdhPJwAnAzxOGrXnJJ77v/nbX7YJhYyTBaTs3AGE3LjRDO8i2P1sr5brGQrFjabhPywmDvENagJ3A==
X-Received: by 2002:a5d:4575:: with SMTP id a21mr54398410wrc.193.1638899130996;
        Tue, 07 Dec 2021 09:45:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e18sm369293wrs.48.2021.12.07.09.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 09:45:30 -0800 (PST)
Message-Id: <47fef87eb4a614fb53d703152079cdd64b623814.1638899124.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
References: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Dec 2021 17:45:21 +0000
Subject: [PATCH 07/10] reftable: fix NULL derefs in error paths
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

Spotted by Coverity.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/reader.c | 3 ++-
 reftable/stack.c  | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/reftable/reader.c b/reftable/reader.c
index 006709a645a..8d308d858f8 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -796,6 +796,7 @@ int reftable_reader_print_file(const char *tablename)
 	reftable_table_from_reader(&tab, r);
 	err = reftable_table_print(&tab);
 done:
-	reftable_reader_free(r);
+	if (r)
+		reftable_reader_free(r);
 	return err;
 }
diff --git a/reftable/stack.c b/reftable/stack.c
index 10dfd370e8e..eb03b6c74f6 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -707,7 +707,8 @@ done:
 	strbuf_release(&temp_tab_file_name);
 	strbuf_release(&tab_file_name);
 	strbuf_release(&next_name);
-	reftable_writer_free(wr);
+	if (wr)
+		reftable_writer_free(wr);
 	return err;
 }
 
-- 
gitgitgadget

