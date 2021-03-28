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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F12C433E1
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 02:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F33D86199F
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 02:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbhC1COw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 22:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbhC1COH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 22:14:07 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B7CC0613B2
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 19:14:06 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id f22-20020a7bc8d60000b029010c024a1407so6788287wml.2
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 19:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wyxCuhglJk/ObCT4IvZTKgKMLxR4HZhB/xFhm6PmDxE=;
        b=SBJ6HtRdCM6TxNMQsfwd+dcnJtMa+8rw3jHx6nESHenuBJPGt+JIlCtpR36RTbgHaX
         v2UqkvoeEkmnZRnI0evsURcola1qyo1clAyM4drumFvkSXm/zG3CtoqkhsuTNkWnr3RC
         i27VyByR8Wx5fl6rWhOujCbCaFttPXLXLyIpKBgeKuXilUJvYasgyuloBnvzO1q9XTW8
         fU7p3QhxasWh3GnOMuhPwfDnwRrfeGIi1awvVSZYIM59eHQPjI3Q4sv6PXJeUsPVAn3y
         Hi9oUaXlpmro3zoVmLpuErE8PRiQBBJrRHiBhYPXanI/zGJgzlWauKDSPO8GwsiKjy7v
         L4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wyxCuhglJk/ObCT4IvZTKgKMLxR4HZhB/xFhm6PmDxE=;
        b=kAx+mEx/YI74lgBjDQznxX++AnQxMLcqgpYC2l58LWjslqiic2TYigPsj83ajzu6Oe
         FUYTmpEb4CHktJrfnVilVKO/HjtTHDcLtMZ1xx+tBtn2Ir87H7V5MCwCe+zcoTmS/PJa
         U0B8g/4kOMBPQcuR5QWMt3EpiXdRm2Xxr/ZhNgmaBEZBpbOm8xqvYllcXsLZt0ey/1W+
         rPvLsrJWuPJrKPI4g1pgP3yxTBg7HEsqNVbYYl5UZ3/V670afU5peDTxSgz06tw7XwCx
         Dtsjb7yIm2ng90vZ142/8E8nlZLb40B6gLJX542cSrS8aaIiM7bnuHo2/THn9VW8c/Np
         oEVA==
X-Gm-Message-State: AOAM5301P+ylybnRgQt/RY+7Ta/KltJIA/+feGvL4v81SsNREXtUGoj3
        NKscc4UkeZ/oJmY1KMGIVhabvd5od/6wyA==
X-Google-Smtp-Source: ABdhPJzdOqMtH85dIJaI3Azi9Yq0ir9nvVNq/rilVDITC0cWuC0ONRHdEe/XGG0Z3fdKhxzPS624rQ==
X-Received: by 2002:a05:600c:214d:: with SMTP id v13mr19241929wml.162.1616897645325;
        Sat, 27 Mar 2021 19:14:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c2sm11291524wrt.47.2021.03.27.19.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 19:14:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 01/10] object.c: stop supporting len == -1 in type_from_string_gently()
Date:   Sun, 28 Mar 2021 04:13:31 +0200
Message-Id: <patch-01.11-e51c860a65d-20210328T021238Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.442.g6c06c9fe35c
In-Reply-To: <cover-00.11-00000000000-20210328T021238Z-avarab@gmail.com>
References: <20210308200426.21824-1-avarab@gmail.com> <cover-00.11-00000000000-20210328T021238Z-avarab@gmail.com>
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
index 78343781ae7..65446172172 100644
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
index 59daadce214..3ab3eb193d3 100644
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
2.31.1.442.g6c06c9fe35c

