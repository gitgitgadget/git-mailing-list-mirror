Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5004C761AF
	for <git@archiver.kernel.org>; Mon,  3 Apr 2023 22:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbjDCWdz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 18:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbjDCWdt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 18:33:49 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F9F423E
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 15:33:45 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id y14so30909943wrq.4
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 15:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680561224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4w+HI83FU/79YXqcy302/Fl4K8tTc6dRuOqGhF+pVU=;
        b=moUDEy+e8KoodXTLzsYgYy3qS3Ggwn/7D6fZ1/lUak2+EaOIL9T1SE0h76C6YXzvYm
         oHapgYrR/Gr5B+qCQonpEEy8/tfmRVlA9lNDwdYZ+YV6NtrATerccW5aUjd8qKZmBDON
         yJaWZo6uSmvLBP8VG2cmh0qfbAK4xE7Bx82+p5Vckt7K2A/vxOQV4uxLDsAC7J5Vn8RJ
         Lp9NOCfx8AzXtDe1KcInApqzOgSIzXz+BW+VFfLNfbDPCykqJ4qYxz223ICJ6pWyPz+8
         rCdfP6Ayn6CPtnh/WmEP2eiwjV6n58qIpJzpC6+tETrmEO0on1acLxU1NvyV5NxW1DFs
         DoIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680561224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v4w+HI83FU/79YXqcy302/Fl4K8tTc6dRuOqGhF+pVU=;
        b=iN4DMz2APJ4iREc9KK5dkUnM96Bq9487NN+xsP7XZZ4UwSAkOTDbC5NcoVn7tjT8C5
         pyjghljqfjxLYfQXGH7pInka2IlWVczIjZ0FEFOGSAUN8d5Sp9kPE6Ny8eb98GygGW4j
         HGb+A52vvyvAvr9ZaB4917MplTW/eAXKJe4VK9gqL8QiRQGOrlt8gFxdKly2akvIkxDn
         rL8L+oJMEoBslM08QCucmDS4MNyOkwVQ5RsnqIIStehfI1ECvOcjTSHNBNBHHcHiNuhj
         KqTo5/piA8IXPX5RoT+DSrvPYTT+i9Alj9tgcCP23D3ZrAZHzLgvWQEecAiW32+vCCfq
         KpLw==
X-Gm-Message-State: AAQBX9eN8y72rKu72UBqDo2zx3hN7SQg3YQMNCReZxePMGWsTIRncwlf
        WyylkBa6P7wiKr0Y5IDb3D34SpgCIsQJKmbhZzI=
X-Google-Smtp-Source: AKy350bXEVHNAIieTYLalkVX0wuMS+f5XWqfvfRZ4O0oWJzyXecbioF8R25wwfEIwdmSSNeB4isGRA==
X-Received: by 2002:adf:f888:0:b0:2d8:e6ba:99e8 with SMTP id u8-20020adff888000000b002d8e6ba99e8mr69142wrp.33.1680561224174;
        Mon, 03 Apr 2023 15:33:44 -0700 (PDT)
Received: from titov.fritz.box ([212.102.57.24])
        by smtp.gmail.com with ESMTPSA id m17-20020adfe0d1000000b002d1e49cff35sm10697453wri.40.2023.04.03.15.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 15:33:43 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 5/6] t1502: don't create unused files
Date:   Tue,  4 Apr 2023 00:33:37 +0200
Message-Id: <20230403223338.468025-6-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230403223338.468025-1-rybak.a.v@gmail.com>
References: <20230401212858.266508-1-rybak.a.v@gmail.com>
 <20230403223338.468025-1-rybak.a.v@gmail.com>
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

