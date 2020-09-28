Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079D0C2D0A8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 21:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C475208FE
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 21:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csU+b3sh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgI1VJf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 17:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgI1VJc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 17:09:32 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC9AC0613D3
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 14:09:31 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id s13so2470195wmh.4
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 14:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fLx/oqN4eboVCzSUB4omppsZm0evzi7MY+4v/FyZl7s=;
        b=csU+b3shPAck+pZl3KnHTdI76KDuZnl4fpulOZPm2jS38hMi4qjYDqUo5nQ8HKfA+u
         /4tYmETG/PrakUiKZTRc53SRc6A+NW0F0u3PsiDA2Li+p3ALueA+RIZj6/RWm6/99NFT
         UiXhRVaK8f7096LgiTpvfgsorQYptMQezt0n5KXK3Jzgv+F9E9xAdyzvfAY/pqRiV4hF
         Hkrd6jvRGyWKHzwUow7hIbmcAi4DGyZ0MZp/e+nHxODI8V5ydpZAuxXGL1nP8PIYs56I
         OW/bE4yKa9UbJCiNPk3VNQYmM//Qur2MvKmqRcSDBz6mHO2JxE4h9irHjq9deDM7v7V6
         PNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fLx/oqN4eboVCzSUB4omppsZm0evzi7MY+4v/FyZl7s=;
        b=MIkYOf/NffKeBXU+n9/Hp2N9TV33eKKTZYcmj7VVJkCWQ0EcuPkSeeZkQha9yRUbSb
         SzXaGAbePxaYi7p11LUOiozY7Lda//+MdniIwDl4d4wpFAR7uWNG53G2eqB+DlNykTgU
         w7Sd8VOaxfUkogEc8/Ayu9K9FiHDlA1vKSX9FhZZZhx4a0zPz4Xdq4O0KtOxD4GeuEgF
         KywmB+PW5V38AflmgyGPNh8RJHvhLyy+BhdqAk3NsxXHsmCgBhFAfTPSStRf8tlaL7Z7
         MmzPMVWrmIbesKECpSNC5cmC24k2cv3cyWMcIqe4+6y+/qpma4GISPfrtHpyqjfuwZ2v
         xMhw==
X-Gm-Message-State: AOAM5323oF+11PlaSRrAyVd46lKrqpJDHgkJdHNfUzMxBdjgxQUJ7IpE
        bWqWm6jocAnAMgJozfBbZ2Mk8n/UPyE=
X-Google-Smtp-Source: ABdhPJzntRj1RURHNBG+w5bh5QNuz+K2lAxjTmaqNkqpzdDbiLk0pJ1kpT/TgL5x8BEQ+LSlE6XByQ==
X-Received: by 2002:a1c:63c1:: with SMTP id x184mr1039555wmb.138.1601327370370;
        Mon, 28 Sep 2020 14:09:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z15sm2999732wrv.94.2020.09.28.14.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 14:09:29 -0700 (PDT)
Message-Id: <38cef4deb509e5b0c218abcc385232f98ef27863.1601327357.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.738.v3.git.1601327357.gitgitgadget@gmail.com>
References: <pull.738.v2.git.1601155970.gitgitgadget@gmail.com>
        <pull.738.v3.git.1601327357.gitgitgadget@gmail.com>
From:   "Junio C Hamano via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Sep 2020 21:09:15 +0000
Subject: [PATCH v3 10/11] hashmap_for_each_entry(): workaround MSVC's runtime
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

