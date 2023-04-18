Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8B4C77B75
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 17:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbjDRRuw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 13:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbjDRRuo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 13:50:44 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67985B762
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 10:50:43 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2a8c30ac7e3so17122541fa.1
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 10:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681840241; x=1684432241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EUCLlPwd9WKNAu5sxSBSc3IBiXwMfJmYSm85JRQuIlQ=;
        b=IgPTrtNNSEzyR7vMKX2Eys63TyLI/R9RhK+L/4chS7hImUDgOefieBFH4GOVi3I8dE
         JrJa6WSc1zRGBo9Hds8LGHIWYYrdYTEflZFOSLUcG3JPKhH6N+T/j2R0CqS0QOCyJVST
         Dahbn1k423MSERZy2KY6DbQzSMxyO1TRaINoOk/MZ9oyjsVDqIJOV8CFSfCztqsz4mvD
         smj140s5NQd5RD3pKiHwEWVqFn+SddxLVKIWRTi1Qzj4UzwcnVATokV2uBC/FIxoP5V+
         xTfFGqtJaHFxOJ32IOvlY92q6rPa+1XgEIcf0u+D94c6yvKdK2lsOF8w1vPCIIqcYciv
         Ahvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681840241; x=1684432241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EUCLlPwd9WKNAu5sxSBSc3IBiXwMfJmYSm85JRQuIlQ=;
        b=H7RmDous4d8JAALlHBZdADdF4TMHiEPBEQYAZh36uBkbOMmzGJepIU3TYlW9St5720
         nALBA6YqKHgY7sBqnOyAEGXQQ7QvhbeMMFkQsoVYF38dFRPak1ZjPN75mSeVw29NC5Eu
         6S1kGq4D1YZdq6Z0axzZ63ZmitL81zlTDcEO5wK81IXUNZtWMH973t7mzgNKEzkpVjmH
         Kq3eefx0ac4C5KNd5sqHTGHlCZFCqWPxJRb7TSspOLBxh1kM05eGiXneZnNfre2uGNVF
         4HVLBa1OQE+IXiQJTYmaLeB85wDS1Vxo1M/+cBzKWZX3+JOYJ5NVPdMHT/8KZNYRU0Ea
         kmEw==
X-Gm-Message-State: AAQBX9dT1+tsC7I/jB8eGHhvFilyIG0rYQZ4wS3acSZHIXTgAQuePAJP
        tYyCscySeB23oEnWZHEqIpTsYpYCS3UpDisy
X-Google-Smtp-Source: AKy350blzuTXnZv20UqYbt8RAxfTTuKAMLgdwDzlN79PCOOtgQCZUcS6Lde1kz23QvZcckTTcHxTnQ==
X-Received: by 2002:a05:6512:38c7:b0:4ec:8cad:3c38 with SMTP id p7-20020a05651238c700b004ec8cad3c38mr2919086lft.50.1681840241304;
        Tue, 18 Apr 2023 10:50:41 -0700 (PDT)
Received: from titov.fritz.box ([195.246.120.47])
        by smtp.gmail.com with ESMTPSA id l20-20020a19c214000000b004ed149acc08sm2294998lfc.93.2023.04.18.10.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 10:50:40 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH v2 3/3] t1300: add tests for missing keys
Date:   Tue, 18 Apr 2023 19:50:34 +0200
Message-Id: <20230418175034.982433-4-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230418175034.982433-1-rybak.a.v@gmail.com>
References: <20230414081352.810296-1-rybak.a.v@gmail.com>
 <20230418175034.982433-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There several tests in t1300-config.sh that validate failing invocations
of "git config".  However, there are no tests that check what happens
when "git config" is asked to retrieve a value for a missing key.

Add tests that check this for various combinations of "<section>.<key>".
---

The patch is marked as RFC, because I'm not sure if such a test is useful or
not.  Even if it is not useful as a test, maybe it would be useful as
documentation of behavior for people reading "t1300-config.sh"?

Having multiple tests for different kinds of keys might also be overkill, and
just one test for a single key is enough.  Conversely, there aren't enough
tests -- tests for keys with subsections are missing.

 t/t1300-config.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 20a15ede5c..a646ddd231 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -98,6 +98,20 @@ test_expect_success 'subsections are not canonicalized by git-config' '
 	test_cmp_config two section.SubSection.key
 '
 
+test_missing_key () {
+	local key=$1
+	local title=$2
+	test_expect_success "value for $title is not printed" "
+		test_must_fail git config $key >out 2>err &&
+		test_must_be_empty out &&
+		test_must_be_empty err
+	"
+}
+
+test_missing_key 'missingsection.missingkey' 'missing section and missing key'
+test_missing_key 'missingsection.penguin' 'missing section and existing key'
+test_missing_key 'section.missingkey' 'existing section and missing key'
+
 cat > .git/config <<\EOF
 [alpha]
 bar = foo
-- 
2.40.0

