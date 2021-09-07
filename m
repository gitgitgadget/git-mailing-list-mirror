Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8072C433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 10:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4E0E60E52
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 10:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344064AbhIGLAK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 07:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343833AbhIGK7v (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 06:59:51 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653ACC0613CF
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 03:58:44 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id m25-20020a7bcb99000000b002e751bcb5dbso1845172wmi.5
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 03:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n+lhjppXbOj7Funr9CGKj854dERQmQ2rDWls2a+sJyo=;
        b=f008ZwMobY8C90TGtznxqVvCba/heP45DPcFBEiJulufdL9eZOdUcwviqwi9QqDSUI
         +xmT1dw2x4LInMCZHopgWKRbCy9nPzt/wMiKxPtAhRUjVD8/uG0ZWNBysr2XMoF8Rv9F
         YXTHLPQ2LOKbKbuIpG4zo0pkzkJuwX35HQjuQrZMqkXwKZnKl1X+UjMyWDwtyikMkzvr
         vvCZFdoZMC1jxaAfJl1DG26ZGsCTnt7k5kdGqr2nmpQThTkmoEXFsMm8gIxU8HolUYLv
         Cy0JXpITEWi6BBXm9bMd8M/yOaw6qo0tysk6OGYpri7hTdJpd1nPARO/CbPRbfININxq
         gPXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n+lhjppXbOj7Funr9CGKj854dERQmQ2rDWls2a+sJyo=;
        b=Fmr5nV3XAdLlS8MDbqIiBPuEkh6XMP3ssboI3qAwthnxQ5XGhIYjJ4WU3mKSuEvP4h
         8chXPRJzFm9bEw6JfZHf+qTDL/c3o4pT2ZDTJSI6XUXlmO/f324BuwF80zqx73srDIjj
         k5jNDBobjJqcWZ87+iDlFvXatCjqczbncUlAe4BeFoRsJ1Rf8/JbvblJdrsGMAlL9lfP
         LdQd71i/YdKalWIyv+XXmfZQ5vhUhNnrSu9h/EtJlmVZjePSchejGus0jtqybVuYZ9W5
         DtcJuiCKKjtUYB5gnrxnPvKd3Ksfp6cPbtALihhVXAZ10n6+4zUP/Y9YE0DEltuIPgQh
         pUEg==
X-Gm-Message-State: AOAM533yg4ZeamRGEUTQKyTrTp9OPNUyMnr8iZ6ozqfVA95z+zZLETQs
        yOm0mhtTXXYjcTAUJHqw4xEDqbbp+5yshg==
X-Google-Smtp-Source: ABdhPJzYNa1O5UT89lwt5HRyO3tswYm+USH59b/78vwbI3eBQKiNq2q59IoYaeP/ye/tfU1o7NIh8A==
X-Received: by 2002:a05:600c:2f90:: with SMTP id t16mr3249635wmn.136.1631012322779;
        Tue, 07 Sep 2021 03:58:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l16sm8255602wrh.44.2021.09.07.03.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 03:58:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 20/22] object-store.h: move read_loose_object() below 'struct object_info'
Date:   Tue,  7 Sep 2021 12:58:15 +0200
Message-Id: <patch-v6-20.22-3bf3cf2299d-20210907T104559Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.815.g21c7aaf6073
In-Reply-To: <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
References: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com> <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the declaration of read_loose_object() below "struct
object_info". In the next commit we'll add a "struct object_info *"
parameter to it, moving it will avoid a forward declaration of the
struct.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-store.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/object-store.h b/object-store.h
index c268662f5ba..dc638335e7d 100644
--- a/object-store.h
+++ b/object-store.h
@@ -242,20 +242,6 @@ int pretend_object_file(void *, unsigned long, enum object_type,
 
 int force_object_loose(const struct object_id *oid, time_t mtime);
 
-/*
- * Open the loose object at path, check its hash, and return the contents,
- * type, and size. If the object is a blob, then "contents" may return NULL,
- * to allow streaming of large blobs.
- *
- * Returns 0 on success, negative on error (details may be written to stderr).
- */
-int read_loose_object(const char *path,
-		      const struct object_id *expected_oid,
-		      enum object_type *type,
-		      unsigned long *size,
-		      void **contents,
-		      unsigned int oi_flags);
-
 /* Retry packed storage after checking packed and loose storage */
 #define HAS_OBJECT_RECHECK_PACKED 1
 
@@ -396,6 +382,20 @@ int oid_object_info_extended(struct repository *r,
 			     const struct object_id *,
 			     struct object_info *, unsigned flags);
 
+/*
+ * Open the loose object at path, check its hash, and return the contents,
+ * type, and size. If the object is a blob, then "contents" may return NULL,
+ * to allow streaming of large blobs.
+ *
+ * Returns 0 on success, negative on error (details may be written to stderr).
+ */
+int read_loose_object(const char *path,
+		      const struct object_id *expected_oid,
+		      enum object_type *type,
+		      unsigned long *size,
+		      void **contents,
+		      unsigned int oi_flags);
+
 /*
  * Iterate over the files in the loose-object parts of the object
  * directory "path", triggering the following callbacks:
-- 
2.33.0.815.g21c7aaf6073

