Return-Path: <SRS0=tECa=DD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5729C4741F
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 21:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84F2B2371F
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 21:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPdYf/wV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgIZVdE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Sep 2020 17:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727848AbgIZVdB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Sep 2020 17:33:01 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9E4C0613DA
        for <git@vger.kernel.org>; Sat, 26 Sep 2020 14:32:59 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id s13so2652917wmh.4
        for <git@vger.kernel.org>; Sat, 26 Sep 2020 14:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fLx/oqN4eboVCzSUB4omppsZm0evzi7MY+4v/FyZl7s=;
        b=WPdYf/wV3oOuRjxWPwqednQBenzRdkPcx55KHJvkWAchkhUs6xQKz+oiv4BnOBFW0b
         oXTyAGypX2oLDv8skdZXaiQh3duEGdFwAaF9UhWjP4tBqt2WWRy9+ppjU7Uy+R93lKvj
         iJRYHN3VFtK9PCxSx4f9pC6nJba2yKQHakPkaRmrBjwygFvpBnp+y/DxagJAtqeNqywy
         Mbq+39qLmza9Yl0IPDM1Z/dn7XEN7nXms13KcdMaACoMiFqziypfqzZufXwGthj4J4jf
         UJjWwvzcDYs5t/SMynoTTnqgElodL1aa0MObXRlbvzmpeqAmMEZzSaD3F4uOrjMOvpIs
         Spiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fLx/oqN4eboVCzSUB4omppsZm0evzi7MY+4v/FyZl7s=;
        b=tNztxExh0h9ILXJWnTl9hYHVTz3M6Oxv/euV7nhqgMvje/2QjAS7BtmnCa3mcDt0V+
         m562AyyHwmb3p0YUMVUkJugRsaMG3P7/dBoQfWFL4181Hsjt1Ow8xkgLKxXwWqEc0mEi
         K/4Ho3/FzCeMxvXmwE1rUv43T2sJVMe3tTnJ/x9S6560Azv6k1suIHNdy391Dwvpruqs
         aSCZLDox9tGRGX6MjtB++hcm1yqgxNU6AMO+op4tNWCGWyC1/cKpXGelJJEF+ULRTIuW
         dJdoXa91IilpvMrl3hBUTC7O95LVK1QKm+tGhJIYG+LLCdjJ1p2E6n8AnV6+ZaNM8cjC
         Syvw==
X-Gm-Message-State: AOAM532IbuTUVUVlpvcncjQZGeqc+Miu0qF/f8IN4WRdgM6Ns4mQ0dD/
        1t5gMUDK1ZyWnxFcVExZWHA39zsoxSE=
X-Google-Smtp-Source: ABdhPJxIkDYaW/9Vw5LrmotWTk9HvCOQYM9/+pKYNF4P0Pl19aX3Mzwa5PZLp4U3nHomZcv9MHSXmw==
X-Received: by 2002:a1c:480a:: with SMTP id v10mr3902564wma.141.1601155978165;
        Sat, 26 Sep 2020 14:32:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a81sm4067053wmf.32.2020.09.26.14.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 14:32:57 -0700 (PDT)
Message-Id: <152705bbc6a105411d0be0f76b18757c8ab0f893.1601155970.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.738.v2.git.1601155970.gitgitgadget@gmail.com>
References: <pull.738.git.1601044118.gitgitgadget@gmail.com>
        <pull.738.v2.git.1601155970.gitgitgadget@gmail.com>
From:   "Junio C Hamano via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 26 Sep 2020 21:32:49 +0000
Subject: [PATCH v2 10/10] hashmap_for_each_entry(): workaround MSVC's runtime
 check failure #3
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng?= Danh 
        <congdanhqx@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

The OFFSETOF_VAR(var, member) macro is implemented in terms of
offsetof(typeof(*var), member) with compilers that know typeof(),
but its fallback implemenation compares &(var->member) and (var) and
count the distance in bytes, i.e.

    ((uintptr_t)&(var)->member - (uintptr_t)(var))

MSVC's runtime check, when fed an uninitialized 'var', flags this as
a use of an uninitialized variable (and that is legit---uninitialized
contents of 'var' is subtracted) in a debug build.

After auditing all 6 uses of OFFSETOF_VAR(), 1 of them does feed a
potentially uninitialized 'var' to the macro in the beginning of the
for() loop:

    #define hashmap_for_each_entry(map, iter, var, member) \
            for (var = hashmap_iter_first_entry_offset(map, iter, \
                                                    OFFSETOF_VAR(var, member)); \
                    var; \
                    var = hashmap_iter_next_entry_offset(iter, \
                                                    OFFSETOF_VAR(var, member)))

We can work around this by making sure that var has _some_ value
when OFFSETOF_VAR() is called.  Strictly speaking, it invites
undefined behaviour to use NULL here if we end up with pointer
comparison, but MSVC runtime seems to be happy with it, and most
other systems have typeof() and don't even need pointer comparison
fallback code.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 hashmap.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hashmap.h b/hashmap.h
index ef220de4c6..b011b394fe 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -449,7 +449,8 @@ static inline struct hashmap_entry *hashmap_iter_first(struct hashmap *map,
  * containing a @member which is a "struct hashmap_entry"
  */
 #define hashmap_for_each_entry(map, iter, var, member) \
-	for (var = hashmap_iter_first_entry_offset(map, iter, \
+	for (var = NULL, /* for systems without typeof */ \
+	     var = hashmap_iter_first_entry_offset(map, iter, \
 						OFFSETOF_VAR(var, member)); \
 		var; \
 		var = hashmap_iter_next_entry_offset(iter, \
-- 
gitgitgadget
