Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88321C11D07
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 14:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D7D7222C4
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 14:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkKoiBZF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgBTOPY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 09:15:24 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40832 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727761AbgBTOPY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 09:15:24 -0500
Received: by mail-wm1-f68.google.com with SMTP id t14so2206145wmi.5
        for <git@vger.kernel.org>; Thu, 20 Feb 2020 06:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tgoy/WLgDxROyooPg/AC7n8Kq2RA8Dm/TKofQYqWtdg=;
        b=TkKoiBZF9Dv3dAoMIKPX5SX/OWQXgLp+5HbrRboY72xnXOfji5Ol1umzpWeZlt+z6i
         wbD6+rlKCsc47vRPloUy7chrwy9HkJJuyTHp2MPgSXf6TX9UwCBVVTwo2srs6twTwzK1
         CDFYZ+4wzKgkViqlMLQ0pfYZ9YVYd2HaHnv/ScXqYhxrOmq14QBQnYG1zIV+C3wUF8EP
         h1S0uV5BYKfvLIcNJnwHd3Mk/sjF7pQBzRYQVOZV0gNMWoopRM3CXYzl9nRnBgtjIbq9
         MDYAucnx9CZfrRczCr4Rn8O+vnsbqvmDA2bk079GjQ147iKZUwbiIT/IOU9rTEnNglWc
         ZC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=tgoy/WLgDxROyooPg/AC7n8Kq2RA8Dm/TKofQYqWtdg=;
        b=gRPUz8J4pBwYEOShx1cTJV5EH9QOMvJdY12QN+nzivfQ3ZkDA7h5NXuWpJybQLtfB0
         Ae/S2JPjbkMHvbWhekJqb42Ju9M6Z2fL+wZDGQgl/9rX/kzK0E6yuILJ9y0eVIzMCgNB
         5rnEuptx+uFKaBQro9AZFP3zCs4FHbnvmQtSyI/1wykTRzn66/4q+mqM4qu1fV0DD6V5
         biBRHJHIISt7FDN57xaxcohPkjjgcuGVEn3HJ8vPEPJrS0X3ejYAomO1WLEdrfpvlIaj
         h2VRtj1h2AhDbr56EhcZkb7zWrQnGS5FRa5fkx8rApjCV/VY6Ub7vjwqngox7k//T0xQ
         z+Nw==
X-Gm-Message-State: APjAAAWZuz972qKRy83WeflMvZlIdWVanmP/iATp+23rXxi7QeqOjyFn
        KqbxNTBoEuVVlJ9TkXItAtvpXkab
X-Google-Smtp-Source: APXvYqxisqVAF25XT2cCGbDb+C6P09XdOtkDwE3fcnM7RnMv0ppL701kcsoWTCLQW79UPaSdAdjvTw==
X-Received: by 2002:a7b:c242:: with SMTP id b2mr4681687wmj.19.1582208122262;
        Thu, 20 Feb 2020 06:15:22 -0800 (PST)
Received: from donizetti.redhat.com (nat-pool-mxp-u.redhat.com. [149.6.153.187])
        by smtp.gmail.com with ESMTPSA id v15sm4933614wrf.7.2020.02.20.06.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 06:15:21 -0800 (PST)
From:   pbonzini@redhat.com
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com
Subject: [PATCH v2 1/5] parse-options: add testcases for OPT_CMDMODE()
Date:   Thu, 20 Feb 2020 15:15:15 +0100
Message-Id: <20200220141519.28315-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200220141519.28315-1-pbonzini@redhat.com>
References: <20200220141519.28315-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

Before modifying the implementation, ensure that general operation of
OPT_CMDMODE() and detection of incompatible options are covered.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
v1->v2: - split testcases to a separate patch [Junio]
	- use test_i18ngrep [Eric]

 t/helper/test-parse-options.c |  2 ++
 t/t0040-parse-options.sh      | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index af82db06ac..2051ce57db 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -121,6 +121,8 @@ int cmd__parse_options(int argc, const char **argv)
 		OPT_INTEGER('j', NULL, &integer, "get a integer, too"),
 		OPT_MAGNITUDE('m', "magnitude", &magnitude, "get a magnitude"),
 		OPT_SET_INT(0, "set23", &integer, "set integer to 23", 23),
+		OPT_CMDMODE(0, "mode1", &integer, "set integer to 1 (cmdmode option)", 1),
+		OPT_CMDMODE(0, "mode2", &integer, "set integer to 2 (cmdmode option)", 2),
 		OPT_CALLBACK('L', "length", &integer, "str",
 			"get length of <str>", length_callback),
 		OPT_FILENAME('F', "file", &file, "set file to <file>"),
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 9d7c7fdaa2..3483b72db4 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -23,6 +23,8 @@ usage: test-tool parse-options <options>
     -j <n>                get a integer, too
     -m, --magnitude <n>   get a magnitude
     --set23               set integer to 23
+    --mode1               set integer to 1 (cmdmode option)
+    --mode2               set integer to 2 (cmdmode option)
     -L, --length <str>    get length of <str>
     -F, --file <file>     set file to <file>
 
@@ -324,6 +326,22 @@ test_expect_success 'OPT_NEGBIT() works' '
 	test-tool parse-options --expect="boolean: 6" -bb --no-neg-or4
 '
 
+test_expect_success 'OPT_CMDMODE() works' '
+	test-tool parse-options --expect="integer: 1" --mode1
+'
+
+test_expect_success 'OPT_CMDMODE() detects incompatibility' '
+	test_must_fail test-tool parse-options --mode1 --mode2 >output 2>output.err &&
+	test_must_be_empty output &&
+	test_i18ngrep "incompatible with --mode" output.err
+'
+
+test_expect_success 'OPT_CMDMODE() detects incompatibility with something else' '
+	test_must_fail test-tool parse-options --set23 --mode2 >output 2>output.err &&
+	test_must_be_empty output &&
+	test_i18ngrep "incompatible with something else" output.err
+'
+
 test_expect_success 'OPT_COUNTUP() with PARSE_OPT_NODASH works' '
 	test-tool parse-options --expect="boolean: 6" + + + + + +
 '
-- 
2.21.1


