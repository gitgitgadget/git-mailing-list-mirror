Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C585C47428
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 15:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 184A020789
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 15:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abu6wBr4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730892AbgI3P0h (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 11:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730835AbgI3P0f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 11:26:35 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9351BC061755
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 08:26:35 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id x23so2148452wmi.3
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 08:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fLx/oqN4eboVCzSUB4omppsZm0evzi7MY+4v/FyZl7s=;
        b=abu6wBr4vCrp09W5xsENwfpvv8MiK6jIE3W/pkj90L/g+i5kNFKo0X7uz7ufMaeH/b
         euaAbV0eYr9e36sqCQ062Kza3jpfD/5TGlrofjVhR8uZSQIvRp4adxEsiDV0cCXGMI5l
         XtiCCJWxCKX0cUnn0d61igv+XRaWzfChxsQdoio3tdi3b0CSA/KNlzpqj4+neXzdOy05
         0FWWRUDjzc8rJxz3eMmtFukV5CC1T8sMmY+HVGTsidfVCnEbyKUrdGcdLrUJCq+dYqOI
         zvYIzT0jGj71MGy/RWJBTj1jQ6x6yUZI4LvstJ+OmXw5vriJSAZdHsIZ2triz+FRrsfU
         nFCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fLx/oqN4eboVCzSUB4omppsZm0evzi7MY+4v/FyZl7s=;
        b=RQesZodPrFIGOTM1Q4xDI6kF2hl/m/AT5R2SJI1kSMtI+N2GY/tZuQUjmXj0EaCncL
         qr5YTXhQYQmYkh0cHWELI/sXSV5aDZNQs8xr0xAVmIPxu0G03yxvZuGSFXrr6C+wrUyp
         rS4OpKim1QPNNlV5tnjHMykK+OMOHpFi0UeJ4OtoiaFu3btp7u+bK0vHouXnwSw9WhBQ
         8m/pY8aMizrhv7YqrDMclDJvpUWGfOmEbkQxxzlwqynJ9N0MUtoP7oN285MUg9MXlydl
         Z95St32XUOqkS7xWEMI8QDWSp9UX62rTmluPBymXfpGSgue7vDwwQVRj2sX5lJi0HVJk
         OrFg==
X-Gm-Message-State: AOAM532vO189USJTl94PPUj0WyPk5xH6j9/puQRqRjL7YBG04HEfScKe
        mgsAUMCRiz1b/a7TQWW65IFER/b2/NI=
X-Google-Smtp-Source: ABdhPJyaXBRMWRDqhxqocDB/yDgtvtpQTUZixx1iwYzYgQ5ULGg37SN2Qoj66HtjEw2ntZ8M2/cCPA==
X-Received: by 2002:a1c:4e02:: with SMTP id g2mr3475751wmh.3.1601479594070;
        Wed, 30 Sep 2020 08:26:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i9sm3316416wma.47.2020.09.30.08.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 08:26:33 -0700 (PDT)
Message-Id: <7643a766b7dedb32bbe46689b01a9009e16277f9.1601479585.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.738.v4.git.1601479585.gitgitgadget@gmail.com>
References: <pull.738.v3.git.1601327357.gitgitgadget@gmail.com>
        <pull.738.v4.git.1601479585.gitgitgadget@gmail.com>
From:   "Junio C Hamano via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 30 Sep 2020 15:26:24 +0000
Subject: [PATCH v4 10/10] hashmap_for_each_entry(): workaround MSVC's runtime
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
        =?UTF-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
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
