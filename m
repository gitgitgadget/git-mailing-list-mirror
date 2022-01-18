Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02196C433FE
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 15:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346068AbiARPzd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 10:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235165AbiARPzc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 10:55:32 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E09C061574
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 07:55:31 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id c66so28664272wma.5
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 07:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=htWFYEwkxqxb9Qkmb+ym08W7UtCr6ApdcJvQbF/gtI8=;
        b=KitXeAV7Fk/azh6FlwJsj7nKVZH2NOyWrSicy2xdjgIV4OeONXeK7Zz9zqlluuQ6gC
         ffSAxI7sxyhhteug7LUDqNjsTZM9QGwtxJ+6jCDzYdiVn6Dc9zCbYbtyysZpOspy8DxV
         ZZSOVUP9ZpBeIWw5yntCbb2v/GTM9aIvle9zrbvOJj8ABbF60GsFgrUaa7HREpxJv42E
         vIZ0AEM6Aa6u3Kai/zRxwsc9fYaIZ3JNySQFQI0tpJn2sbOIu1700BaH5jK7vH2m6Jdz
         8NDgtaSOB07xEOu6b8l+xxIIuI/jDTJNUkMqAkpHcUQEADCzzJAobwqJm4YW+Zzo4gyC
         X56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=htWFYEwkxqxb9Qkmb+ym08W7UtCr6ApdcJvQbF/gtI8=;
        b=PSJJwtt6YL66czk9MHz0akGfXvrAZh7wX8t/hyS130vEkuX2xP1xCquUGm7SjssAr5
         NPMdu4jnhz05OyUECajrb0M2qkJfvI/eOmPBczakeOfy7d2EnpdIYTM5HLglAsBKdCWw
         aR46Ve/SN5rHts725JNl4LoQ1XSX52pOpCDaadLAqp/I/0zXCInBOJcERsdr1cD+3nj1
         wRLC79PpYxcolTnt2aHXuYbGTdkdbA2m/19VgtccgT2DoVb8IFStjaKaebazUbEQKHVN
         +tXQv2+iLOj+U+2grDHwz+3ntwv+9Qi/DPuy+ijDqqTJFwaKtf4Cst9Vdv3Q5QNGlGTT
         lEkw==
X-Gm-Message-State: AOAM531U2YpKwd9qMWfhjDtYEL0UaW5f/gFURZ+TEbToteMM81IcMT8b
        lUCjGLAFG6m07Cp+stN5sB1VPZmWYOr+0Q==
X-Google-Smtp-Source: ABdhPJw0atZVq0fer4sJ53fsHbLF5JGndlyBk/UUFKEOW5qeF3L3MOQQ1+YQb+hH/VVw5GC/LaJYNA==
X-Received: by 2002:a05:6000:178b:: with SMTP id e11mr22133264wrg.126.1642521330181;
        Tue, 18 Jan 2022 07:55:30 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f15sm1220522wrd.45.2022.01.18.07.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 07:55:29 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 01/10] grep.h: remove unused "regex_t regexp" from grep_opt
Date:   Tue, 18 Jan 2022 16:55:13 +0100
Message-Id: <patch-v8-01.10-010a2066656-20220118T155211Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.rc1.864.g57621b115b6
In-Reply-To: <cover-v8-00.10-00000000000-20220118T155211Z-avarab@gmail.com>
References: <cover-v7-00.10-00000000000-20211228T004707Z-avarab@gmail.com> <cover-v8-00.10-00000000000-20220118T155211Z-avarab@gmail.com>
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
index 6a1f0ab0172..400172676a1 100644
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
2.35.0.rc1.864.g57621b115b6

