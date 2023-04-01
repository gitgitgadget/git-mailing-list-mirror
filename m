Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED72C77B6D
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 21:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjDAV3J (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 17:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjDAV3G (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 17:29:06 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B1993CA
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 14:29:05 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id e18so25692727wra.9
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 14:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680384544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4w+HI83FU/79YXqcy302/Fl4K8tTc6dRuOqGhF+pVU=;
        b=ZtA08fsi0OYhQJAVs9uGGbWQjt5QwrLZpldMbNCo0OU0sW3aMSZ9thuHJyT5vPQWbg
         XFWdRiZbhdUWVOAd3nP7JH5BwhHN3Ihm5xj8IFLK3pwrRrOevhLf9orKReeFtrRjsBYo
         D4+gW9IVjeFoqoUq3+lO/dwn90+L0ic9hp7tkMDv1jffsWGylNNf6go8ZXSQBq2skvxq
         cv4rzHxZxOva+Mr0T8WPdjvH59lO7RpYNtT5eg9MOXW0uNjVVp+MtvVusnWFtVslP4ax
         KR9dQKaumcKDFT9UfpZgnMCe+rakGM3VRxRZcHL14KOoRWKr+1amN75EDSgSqfA52HHP
         4gXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680384544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v4w+HI83FU/79YXqcy302/Fl4K8tTc6dRuOqGhF+pVU=;
        b=js60eA8qyMx11MagvZ1ofWmVDAHQn7UrmUUfA8qpITKHCgyDTz1AEzirfxbYQp0Kbv
         +fXcxBzpryTxoP0mUCYrB/n4FToDPwXxeGMAGPNUHxRAZYTa3oL9vmc5pS5M+R1Q3MB6
         wx/IymPH0Sfx+5cwzokJt8b1ayAje0sOSU6AwqFwP+9GmKOcgJOToghOKLjMCg+qbqVe
         /0jkz428LHVhc35PymXs1DoE2yl5rgdQgEdqnorixUL1M1F+Px0bV3rP72oZ/N14H1nA
         l8UNOwFJKpxIKhIgu5IbfdRtckTl/rwV6mlMgbtKJSsy/h1r0p9fj1BHC4RcJF2pg0hT
         IC/w==
X-Gm-Message-State: AAQBX9f1TB/xLmbSbzbcDaN2n44WCNDpAi4ODoS9jmkKMSBlMzSxVdoC
        4Pk9gS3lCkjfxOdhKLrptZZXbmfChi2Hb6e0
X-Google-Smtp-Source: AKy350am9mk/0QQbIMvbAYz3HPEwhjjCRhX03UNyIBc/KoguxEzdwZ33V9ICNKNdUDbASq6zLLW09g==
X-Received: by 2002:adf:e401:0:b0:2d4:896:a204 with SMTP id g1-20020adfe401000000b002d40896a204mr21698897wrm.60.1680384544446;
        Sat, 01 Apr 2023 14:29:04 -0700 (PDT)
Received: from titov.fritz.box ([212.102.57.24])
        by smtp.gmail.com with ESMTPSA id i12-20020a5d55cc000000b002c3f81c51b6sm5738364wrw.90.2023.04.01.14.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 14:29:04 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Martin Stenberg <martin@gnutiken.se>,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v1 5/6] t1502: don't create unused files
Date:   Sat,  1 Apr 2023 23:28:57 +0200
Message-Id: <20230401212858.266508-6-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230401212858.266508-1-rybak.a.v@gmail.com>
References: <20230401212858.266508-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Three tests in file t1502-rev-parse-parseopt.sh use three redirections
with invocation of "git rev-parse --parseopt --".  All three tests
redirect standard output to file "out" and file "spec" to standard
input.  Two of the tests redirect standard output a second time to file
"actual", and the third test redirects standard error to file "err".
These tests check contents of files "actual" and "err", but don't use
the files named "out" for assertions.  The two tests that redirect to
standard output twice might also be confusing to the reader.

Don't redirect standard output of "git rev-parse" to file "out" in
t1502-rev-parse-parseopt.sh to avoid creating unnecessary files.

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 t/t1502-rev-parse-parseopt.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt.sh
index de1d48f3ba..dd811b7fb4 100755
--- a/t/t1502-rev-parse-parseopt.sh
+++ b/t/t1502-rev-parse-parseopt.sh
@@ -302,14 +302,14 @@ test_expect_success 'test --parseopt help output: "wrapped" options normal "or:"
 	|EOF
 	END_EXPECT
 
-	test_must_fail git rev-parse --parseopt -- -h >out <spec >actual &&
+	test_must_fail git rev-parse --parseopt -- -h <spec >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'test --parseopt invalid opt-spec' '
 	test_write_lines x -- "=, x" >spec &&
 	echo "fatal: missing opt-spec before option flags" >expect &&
-	test_must_fail git rev-parse --parseopt -- >out <spec 2>err &&
+	test_must_fail git rev-parse --parseopt -- <spec 2>err &&
 	test_cmp expect err
 '
 
@@ -339,7 +339,7 @@ test_expect_success 'test --parseopt help output: multi-line blurb after empty l
 	|EOF
 	END_EXPECT
 
-	test_must_fail git rev-parse --parseopt -- -h >out <spec >actual &&
+	test_must_fail git rev-parse --parseopt -- -h <spec >actual &&
 	test_cmp expect actual
 '
 
-- 
2.40.0

