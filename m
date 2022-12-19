Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B448C4332F
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 10:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbiLSKTz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 05:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbiLSKTl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 05:19:41 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79E5BC00
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 02:19:40 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id a17so6949994wrt.11
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 02:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANgPaUMRe735haqO6cM+CxJEg253kNdWsC7lWQHb05c=;
        b=e3k8onJ9Nwm3FCARJdWe3601pwIrW9ktVEX2K0n9+uEx0yWPrwkkDXnwBfn0K1RcFE
         gLqGVsNrMD7tf5qzck0BcKCFKFFPViPEFgvgFc9OTjUMqW0S2oiPX/DhY2Ev78Bt6L5f
         ra9CPKdJp4JNDEFNicAPXWDKucIqKCvR848snvT9Sf97HMBlCR8aOh2BwHCZbpjT/gVi
         ReQ1yoOsKg7pPxejptBPh7Pmczh1CUOe4o6UpYO7aGuVJQxdgCe3VHFzwtAGWExAPu5/
         3RQwTOIZBV4xJQcxf7c98sfkokS5tUi0WYF9GEmLOe0+gKJNC0Ah3flV9nJ2SW0SPzR8
         pIFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ANgPaUMRe735haqO6cM+CxJEg253kNdWsC7lWQHb05c=;
        b=zI7I470kljILw1NJkq7ZEKchYxmur2jxR9NBGnuCQVmU5zGUrFCD9svoZflAJpeycR
         q46zUVUW7323uaq30GV2tJqAA/qGa6yCvqVWJZVGhXgL6hwYXyFHZoYDsXgYUwkJjs7R
         n8PcHfiE6ATqe8UEwuMyWy8qpAmat+R6LWUjn90Zc5JUzirdJ6ZSmkAGA7hVPDntPdJ3
         /uyGt+W+nn/hRG452/gYHeqZlGPuANJgNGYBfjXWnJsRgQyEeUKHwg4pDIFaU2V/dXYQ
         D+DtAChjx8Pg392dwzksEX75TSbCpigorGNVYmHcdPTxVKHcuh4UT0cB+oAd79E5lcds
         5Kng==
X-Gm-Message-State: ANoB5pnOheCtIwUs+PmoN98unL5sRLkAcfyNF+4xUqInGzNkREMwUzw7
        AKGRFA1P1iIseHkqAFAnplau2EQmCXPOAA==
X-Google-Smtp-Source: AA0mqf7op8FW0OpScpe2j3QgxOlrSp++Srjk+YrpVrbN6N6xUAX/q9iUoTRgMGlp49XNLIY/tyeBAA==
X-Received: by 2002:a5d:61cd:0:b0:241:fc02:f8fd with SMTP id q13-20020a5d61cd000000b00241fc02f8fdmr26123470wrv.71.1671445178966;
        Mon, 19 Dec 2022 02:19:38 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bx25-20020a5d5b19000000b00225307f43fbsm9632672wrb.44.2022.12.19.02.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 02:19:38 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 5/6] tests: don't lose "git" exit codes in "! ( git ... | grep )"
Date:   Mon, 19 Dec 2022 11:19:28 +0100
Message-Id: <patch-v4-5.6-9596702978e-20221219T101240Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1071.g97ce8966538
In-Reply-To: <cover-v4-0.6-00000000000-20221219T101240Z-avarab@gmail.com>
References: <cover-v3-0.8-00000000000-20221202T114733Z-avarab@gmail.com> <cover-v4-0.6-00000000000-20221219T101240Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change tests that would lose the "git" exit code via a negation
pattern to:

- In the case of "t0055-beyond-symlinks.sh" compare against the
  expected output instead.

  We could use the same pattern as in the "t3700-add.sh" below, doing
  so would have the advantage that if we added an earlier test we
  wouldn't need to adjust the "expect" output.

  But as "t0055-beyond-symlinks.sh" is a small and focused test (less
  than 40 lines in total) let's use "test_cmp" instead.

- For "t3700-add.sh" use "sed -n" to print the expected "bad" part,
  and use "test_must_be_empty" to assert that it's not there. If we used
  "grep" we'd get a non-zero exit code.

  We could use "test_expect_code 1 grep", but this is more consistent
  with existing patterns in the test suite.

  We can also remove a repeated invocation of "git ls-files" for the
  last test that's being modified in that file, and search the
  existing "files" output instead.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0055-beyond-symlinks.sh | 14 ++++++++++++--
 t/t3700-add.sh             | 18 +++++++++++++-----
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/t/t0055-beyond-symlinks.sh b/t/t0055-beyond-symlinks.sh
index 6bada370225..c3eb1158ef9 100755
--- a/t/t0055-beyond-symlinks.sh
+++ b/t/t0055-beyond-symlinks.sh
@@ -15,12 +15,22 @@ test_expect_success SYMLINKS setup '
 
 test_expect_success SYMLINKS 'update-index --add beyond symlinks' '
 	test_must_fail git update-index --add c/d &&
-	! ( git ls-files | grep c/d )
+	cat >expect <<-\EOF &&
+	a
+	b/d
+	EOF
+	git ls-files >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success SYMLINKS 'add beyond symlinks' '
 	test_must_fail git add c/d &&
-	! ( git ls-files | grep c/d )
+	cat >expect <<-\EOF &&
+	a
+	b/d
+	EOF
+	git ls-files >actual &&
+	test_cmp expect actual
 '
 
 test_done
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 51afbd7b24a..82dd768944f 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -106,24 +106,32 @@ test_expect_success '.gitignore test setup' '
 
 test_expect_success '.gitignore is honored' '
 	git add . &&
-	! (git ls-files | grep "\\.ig")
+	git ls-files >files &&
+	sed -n "/\\.ig/p" <files >actual &&
+	test_must_be_empty actual
 '
 
 test_expect_success 'error out when attempting to add ignored ones without -f' '
 	test_must_fail git add a.?? &&
-	! (git ls-files | grep "\\.ig")
+	git ls-files >files &&
+	sed -n "/\\.ig/p" <files >actual &&
+	test_must_be_empty actual
 '
 
 test_expect_success 'error out when attempting to add ignored ones without -f' '
 	test_must_fail git add d.?? &&
-	! (git ls-files | grep "\\.ig")
+	git ls-files >files &&
+	sed -n "/\\.ig/p" <files >actual &&
+	test_must_be_empty actual
 '
 
 test_expect_success 'error out when attempting to add ignored ones but add others' '
 	touch a.if &&
 	test_must_fail git add a.?? &&
-	! (git ls-files | grep "\\.ig") &&
-	(git ls-files | grep a.if)
+	git ls-files >files &&
+	sed -n "/\\.ig/p" <files >actual &&
+	test_must_be_empty actual &&
+	grep a.if files
 '
 
 test_expect_success 'add ignored ones with -f' '
-- 
2.39.0.1071.g97ce8966538

