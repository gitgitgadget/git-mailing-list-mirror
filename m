Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65503C433FE
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 02:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241997AbhLVC7F (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 21:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbhLVC7E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 21:59:04 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E1DC061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 18:59:04 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id d9so1934422wrb.0
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 18:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AML3ZjL347kzJSZXZgXNllQTMcZSbqh/GAX7r+JSXm8=;
        b=KPEMNLglXgyZ65E+OJUPAn5jLqfeLY4Oi09cFphTfzFIyd+uHIlwAkoUBZngCzeuWX
         NGL6YMVDjuaFL1k14qrEaBss4B39XTn7dO0QPlbsqRp69goSWmhozA/jfCHJEWa6MowC
         H76zCDUkbLmX1W25Ep6F42vh1NAbEgEDRG94uPU3kWlPI3pFyMF6X1N5AnvEBAfSVrp8
         uE2C2bfTAls8PfggCdOaRi6E9X+D560XsVAVbu45E6uYyt6mKtJ80MCjkEdqcAcesj8L
         X2VvXgKwgC3BMAMld23GcA8KGi4b9c6ZUK9ginyAMu2gGow++ubwYDsQXhcVpVQC4Yum
         YfvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AML3ZjL347kzJSZXZgXNllQTMcZSbqh/GAX7r+JSXm8=;
        b=tc35lIMJjiV6+VulIucvgrskRDuGXXF0Z7OHwQiwM5j6gbyTUtHSTLRC1JEjkp+E2y
         WvjuXR+FwXnUXXoEr+Or1Xr88Sg274Qucw+LRAJUCS1RU9tROgNrTTZFKHKyuSdx/8sb
         Bfar98pTN0QI+EhliSlNPlzXExENoiL5Gygjlrb87ApgTRSdcepd5Eo/py1x1qBOKyHw
         Xx8VMIWbewWOGonpaKQRs+nS0+L8DZ6kOqoWElIcsezowc7gWEGEOERrnkgpBMwIHdOi
         H1K0go/43K/9qPuO618RjBaZXi2u+ApgNc9WTil9R76JrPlOws9am2oGNOU7wPSuEPx+
         WUnA==
X-Gm-Message-State: AOAM533IGbuXuWN1FDBd9UeknZFkBdap7mbB4egEYKFwk4YRp3edy4Ux
        hjY6A9U20SboH3O9WWHjLwhhLrll9A8oWw==
X-Google-Smtp-Source: ABdhPJwQ4jxMpjbI1XQmQaHdUHUgvH1dffAYC0vitbzV6WB4iPmTlmKUIxU9ood6TNeDGLGkpHRM+w==
X-Received: by 2002:a5d:5988:: with SMTP id n8mr608184wri.309.1640141941759;
        Tue, 21 Dec 2021 18:59:01 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n15sm611577wru.66.2021.12.21.18.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 18:59:01 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 1/7] grep.h: remove unused "regex_t regexp" from grep_opt
Date:   Wed, 22 Dec 2021 03:58:51 +0100
Message-Id: <patch-v5-1.7-b6a3e0e2e08-20211222T025214Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1146.gb52885e7c44
In-Reply-To: <cover-v5-0.7-00000000000-20211222T025214Z-avarab@gmail.com>
References: <cover-v4-0.7-00000000000-20211203T101348Z-avarab@gmail.com> <cover-v5-0.7-00000000000-20211222T025214Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This "regex_t" in grep_opt has not been used since
f9b9faf6f8a (builtin-grep: allow more than one patterns., 2006-05-02),
we still use a "regex_t" for compiling regexes, but that's in the
"grep_pat" struct".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/grep.h b/grep.h
index 3e8815c347b..95cccb670f9 100644
--- a/grep.h
+++ b/grep.h
@@ -136,7 +136,6 @@ struct grep_opt {
 
 	const char *prefix;
 	int prefix_length;
-	regex_t regexp;
 	int linenum;
 	int columnnum;
 	int invert;
-- 
2.34.1.1146.gb52885e7c44

