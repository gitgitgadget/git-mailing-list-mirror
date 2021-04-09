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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B79C433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 08:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C25C611AB
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 08:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbhDIIdS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 04:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbhDIIdS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 04:33:18 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75347C061762
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 01:33:05 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id e14so7328048ejz.11
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 01:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=REpQGk/RQAA3bulKN7rD6jRLAn/4uTxMntaQZRWhbaY=;
        b=n0eB2w3O4z8loykBlOLx+G/7PlGl6gYIcjMJdU4pe1Fel/jVz8figFy1OKT3K5t4NO
         mdVKMYf+Tf9ThmiBr9a3MJ342hVZrjZQoYyDiGFvAXYO/B/oXYe/INEwiWdTr+x2WJ+m
         cS8V4Bfb+eodGLef6XRVTStBUX3eHNlUr5OYvuipB+lrek5054k/vWSyZN33xVMa58ob
         O2OXSyJP+2/mEPlrAcDqn5HYBHGM+W74ydhqDqm4+0CltzU51BLOEjUSI5r2OmFTxyrT
         YBYgLL/AELd7P/fOUQQzS2KtKts/TjWBb9VIRQIQ6WA08XPBLKOuEAThgO9V0P7v9y9f
         KYqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=REpQGk/RQAA3bulKN7rD6jRLAn/4uTxMntaQZRWhbaY=;
        b=DndUH3lw4HE5D0G6I2pe189RgPf0DuRMDUyFHKYocib5gkbz3cbqgneAtie6izD2R/
         jhdGZuUQLgQSBEzqVlXe/z/WWr6vxwSqbUbjk/yR8q0GTzAbO0eDjPH4qGkpOr2FTa3D
         swDq5/jV5UEb9AmTqixU/rS7AqTBTd9RAnVzZXx8V6mThH+q8bsdR0FkyZx2aJ1NLAoC
         Wn4bmugeKS5qiQakiHaulC+ARzdm5pU9UbjT/RfkqDy0i4bBvKVwZLNU2l7i6rutr1Fy
         sffJsV7woyNpKrkwt78SZW2RE+cF3+zGITJU7yPXv8+NTqUeOysC8jot02nz5XimR5AN
         SEfg==
X-Gm-Message-State: AOAM531NYbhWU8CQj0mDw+aTsHYZ/0P2Q908RD7BZ01QRSRA57kJNbeK
        D1blOfqdPGTqOBJ2DLguoYHVLisxNQ71qQ==
X-Google-Smtp-Source: ABdhPJxxm9+V6kMHaRNsfHU9K8VXiiw5vY9touz80oi1H5acSWBxODk7yBastlZaiywTMmctMD9ceQ==
X-Received: by 2002:a17:907:3ac1:: with SMTP id fi1mr772169ejc.139.1617957184001;
        Fri, 09 Apr 2021 01:33:04 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n17sm1016707edq.32.2021.04.09.01.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 01:33:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/6] object.c: stop supporting len == -1 in type_from_string_gently()
Date:   Fri,  9 Apr 2021 10:32:49 +0200
Message-Id: <patch-1.6-820f3aed21-20210409T082935Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.592.gdf54ba9003
In-Reply-To: <cover-0.6-0000000000-20210409T082935Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210409T080534Z-avarab@gmail.com> <cover-0.6-0000000000-20210409T082935Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the type_from_string() macro into a function and drop the
support for passing len < 0.

Support for len < 0 was added in fe8e3b71805 (Refactor
type_from_string() to allow continuing after detecting an error,
2014-09-10), but no callers use that form. Let's drop it to simplify
this, and in preparation for simplifying these even further.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object.c | 10 +++++++---
 object.h |  2 +-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/object.c b/object.c
index 7fdca3ed1e..88de01e5ac 100644
--- a/object.c
+++ b/object.c
@@ -39,9 +39,6 @@ int type_from_string_gently(const char *str, ssize_t len, int gentle)
 {
 	int i;
 
-	if (len < 0)
-		len = strlen(str);
-
 	for (i = 1; i < ARRAY_SIZE(object_type_strings); i++)
 		if (!strncmp(str, object_type_strings[i], len) &&
 		    object_type_strings[i][len] == '\0')
@@ -53,6 +50,13 @@ int type_from_string_gently(const char *str, ssize_t len, int gentle)
 	die(_("invalid object type \"%s\""), str);
 }
 
+int type_from_string(const char *str)
+{
+	size_t len = strlen(str);
+	int ret = type_from_string_gently(str, len, 0);
+	return ret;
+}
+
 /*
  * Return a numerical hash value between 0 and n-1 for the object with
  * the specified sha1.  n must be a power of 2.  Please note that the
diff --git a/object.h b/object.h
index 59daadce21..3ab3eb193d 100644
--- a/object.h
+++ b/object.h
@@ -94,7 +94,7 @@ struct object {
 
 const char *type_name(unsigned int type);
 int type_from_string_gently(const char *str, ssize_t, int gentle);
-#define type_from_string(str) type_from_string_gently(str, -1, 0)
+int type_from_string(const char *str);
 
 /*
  * Return the current number of buckets in the object hashmap.
-- 
2.31.1.592.gdf54ba9003

