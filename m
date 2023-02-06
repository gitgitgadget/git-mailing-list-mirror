Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AECC61DA4
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 22:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjBFWpA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 17:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjBFWox (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 17:44:53 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A198302BE
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 14:44:49 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso10106506wms.4
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 14:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFLfWnX9dsqTbrEnSYFHTkRMb4BunN7zlSe75M7JAo0=;
        b=Fct1H+NCB+lbCZNnXeWj2Hs3QdBenvK9BEEmri+30H7zHY9TpIcEXZJ8iIdU7t3NNe
         sImNouygF5iurIj4rxLoJcXlejp7qPFiGEvv2NQkroW5nauYDNUxbRlecweMKiKgw12n
         RaYAYDOtvLVj1o43C7OReHjf1U8PmukUL0fN/4EPNzlW5PY7mnQ+DMJ4IPbnX2gUNph8
         Iwv0uZF8Lf/ibWYeiZZ9a6eEHWg3aUYgVoBzcn/oUop/piul+7yFC5/BwZGSLCB+MIRZ
         S/SxKdKJ5bvBps00IxYugexKUqZu70fG6mkqDebDe4eLXPRpVuNweHOlnGkGb5IBrImO
         88tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BFLfWnX9dsqTbrEnSYFHTkRMb4BunN7zlSe75M7JAo0=;
        b=eM6hvvlcMGZJH5F8skOTni5yurIwk3F1E0naWImVmR3XC/kyeBBge6puuN+OAAhQGG
         1p2MSHlX+hiDOqqiaKj0jH25RnulzAN+UNTQI91KjFZUwlDhMhhIJzx+CS7ASjtpKjxx
         8rOVFa/BE+CkPaT4PsXrwA7a+OWzSQDR3fmH7im9d8Dz/NaZ6CzMgUUNH/U0j5eiE5Q1
         m6RY9Oe8uGfJ+u7FqCkPvqy5pn2mQBn9pF/oDv1V2DmxaoSN45MYUouL9yKxeE9008EU
         biGlaTMjYtRhBqYkztBeZtntJkcFoF8h8Kf9/II9ZlsxSaosieX6x5N2ziq6RxqZw9Cv
         DpdA==
X-Gm-Message-State: AO0yUKWmOsPZW0g0o1NijVF9n7F9F7g24dJ8MqFYRFX5xALWkPgvoXJD
        8uQbAgMzs0rvwnknzs8fOJ7SHqLP6QzlkkIL
X-Google-Smtp-Source: AK7set82Jl1rZF8mQgVROx1mUn5PZjVUORSnGIrfx4bhtHCV+8fl3qieq2NSTk5eejpqYWEX/JGT/A==
X-Received: by 2002:a05:600c:a294:b0:3e0:10d:f1c with SMTP id hu20-20020a05600ca29400b003e0010d0f1cmr1150713wmb.37.1675723487833;
        Mon, 06 Feb 2023 14:44:47 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f7-20020a056000128700b002c3df9279f5sm6657643wrx.48.2023.02.06.14.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 14:44:47 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 5/6] tests: don't lose "git" exit codes in "! ( git ... | grep )"
Date:   Mon,  6 Feb 2023 23:44:32 +0100
Message-Id: <patch-v5-5.6-55abdbef49f-20230206T224200Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1425.gac85d95d48c
In-Reply-To: <cover-v5-0.6-00000000000-20230206T224200Z-avarab@gmail.com>
References: <cover-v4-0.6-00000000000-20221219T101240Z-avarab@gmail.com> <cover-v5-0.6-00000000000-20230206T224200Z-avarab@gmail.com>
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
2.39.1.1425.gac85d95d48c

