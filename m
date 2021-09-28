Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222A0C433FE
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 13:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03F84610E5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 13:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240825AbhI1NEL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 09:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240300AbhI1NEK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 09:04:10 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F1BC061575
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 06:02:31 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id s21so17882512wra.7
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 06:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2wzkCQwZvltoIh2pP13gzYyfVYPtzBX9F5VsC4ZKUYY=;
        b=QIEL7N80w5dH2+xOFlaSKS+vKHst/LqikjBmqUAtv8VyZvhuGDSZ47NuU9VaCqGCfN
         MdMPAsJUOj5ACP+PFUUXtZQ7DTbWyjfL5aQHCv8lrSkPy7KY/Qq32q4IHsOJG67m7ka+
         WtyYrm9BI9i/PYRXcJHGjFKzyk9rlLjmkxNnukwKNQ8NN9o3NoILPolfe4flPcFGGeRl
         qaxtlYDIFPNLOI4qdQZBaaUPYJgW3luo3QRtkiVQEHbq4oBrz+9mgtND8KSiortTpZfe
         3275aGD3Xjoae4nkUYXunkid5C8h+SmVzSFRLYg/hJs2aUyGLPVM6akpoudaHWRs6VDk
         WJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2wzkCQwZvltoIh2pP13gzYyfVYPtzBX9F5VsC4ZKUYY=;
        b=CRYAoKVpG5WQVH/0hUVWrYGc0GN/gOgwct6Ar7EwfeQCDUURwDDHzw3h6FKTTDl9mE
         5Oow/inCE4Rofla6VBpsMiY//AOZk0MwygIjBzhkBvcGGZmr22EacrGOHyyrytt/hlYc
         0GH00QYtWuvywyH/minkcVUqamGNIe6UlAxNeez+VhTbfWIe22b86RgcW12bsmthn0WC
         55/cPOM97emYcjDY66hvHe37v5/pyR3f6N065Cq9eVel4GLuLp3NsHMyPjjcSmrK9FI/
         8XDB69LT78artPU/ot8ItKi9izv0EaLGYCKe2OOnR5kAZIdgptJtM8lT3JDjD4LTyQqZ
         L9Tg==
X-Gm-Message-State: AOAM533PYlI4B8Kly3d0wM4GqG9H9p8rPHlLn/49TgI+lhntbG7GGRUt
        ma3w7Iz6JzaCu5SmruKPmL4oMABwjGOReg==
X-Google-Smtp-Source: ABdhPJwXUvTeJetDRDwlFVGoZ09id09Cw6WGbLGUVOy3aLXFTEwEOpeQ1PGommIKRb0BxW1zQH9OMw==
X-Received: by 2002:a5d:64ee:: with SMTP id g14mr6262293wri.80.1632834149416;
        Tue, 28 Sep 2021 06:02:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d5sm20180669wra.38.2021.09.28.06.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 06:02:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/5] refs.[ch]: remove unused ref_storage_backend_exists()
Date:   Tue, 28 Sep 2021 15:02:20 +0200
Message-Id: <patch-1.5-7a252061b51-20210928T130032Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1340.ge9f77250f2b
In-Reply-To: <cover-0.5-00000000000-20210928T130032Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210928T130032Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function was added in 3dce444f178 (refs: add a backend method
structure, 2016-09-04), but has never been used by anything. The only
caller that might care uses find_ref_storage_backend() directly.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs.c | 5 -----
 refs.h | 2 --
 2 files changed, 7 deletions(-)

diff --git a/refs.c b/refs.c
index 8b9f7c3a80a..32349a5585f 100644
--- a/refs.c
+++ b/refs.c
@@ -33,11 +33,6 @@ static struct ref_storage_be *find_ref_storage_backend(const char *name)
 	return NULL;
 }
 
-int ref_storage_backend_exists(const char *name)
-{
-	return find_ref_storage_backend(name) != NULL;
-}
-
 /*
  * How to handle various characters in refnames:
  * 0: An acceptable character for refs
diff --git a/refs.h b/refs.h
index 48970dfc7e0..573b69863d3 100644
--- a/refs.h
+++ b/refs.h
@@ -836,8 +836,6 @@ int reflog_expire(const char *refname, const struct object_id *oid,
 		  reflog_expiry_cleanup_fn cleanup_fn,
 		  void *policy_cb_data);
 
-int ref_storage_backend_exists(const char *name);
-
 struct ref_store *get_main_ref_store(struct repository *r);
 
 /**
-- 
2.33.0.1340.ge9f77250f2b

