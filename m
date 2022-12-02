Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D2CC4321E
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 11:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbiLBLyT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 06:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbiLBLxp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 06:53:45 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C0FD9B21
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 03:53:14 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id e13so6124465edj.7
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 03:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XfbtzD8BT1K9zuz35n8QiIE4xf1kJm8lA2E3lAkToe0=;
        b=KjmeYsIiRbguFdpGsLKlnc5UtJ/qTeJyHkud1xvp8cWIk93r0ZdrhvWjkWruypAdQ3
         y/lYvRRPTf1ljwElcyQaIggaOXd9gxSwbQli7DGeB7zPZbxxUpkKHufuZhRGMsaLkZ2L
         pKVICIASIQQ96kB4ErGX+mzuIdY0C1aYErUXoCFtQvzB3Ol7BrygUY5QXMN9US/6dXeO
         m8+hnrQAyDEh/us+uDEY2T8JC0bVtv0rJVl3Oe10rcKxm8CoyWsRUqMyNaoGA8V2MCdL
         TqHqEdlQ48Xc+0vwy0NahmjYXi+Ga85zQnTuShPGYEuNFCHYN1heavsea0HRsY1ilLQP
         EpNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XfbtzD8BT1K9zuz35n8QiIE4xf1kJm8lA2E3lAkToe0=;
        b=WGexHz/4a5IQGt5aKpwAqsPJngCmoSNQuJKl2ygUDOCsMII+HXoaLSaP4J1UB6Gq5E
         GD46GC08pt6EYXYcJ6/I4cuEnOd57ChZVAic1890NZj5h8Nfsm26IZvFrfeMOc+lxo2r
         iwqtXaZuUj716kILzgO1w4QmRp3N82KBMYwtElTWA4ULN1HTzeTQh8iT3OOphhdveKDe
         KLHzZHhTShZlOhCguBKycXPHglvolgyknRsKoj6MskHs+Pn3OVVMquQoNZHjaFYnFYnP
         ENDio+gYnr7KXMSnOMTjzF++1j4ylGX0GZrPId1w+8qVeVaO6DFSQeqof/ey9qLiOsf4
         xdTw==
X-Gm-Message-State: ANoB5pnwUR9P2v42obJnEez9FytgQnB/WdiRn4GPU43y5sENZVxUpr/h
        tgvIUhZyHOqGITzxl++Di2kP1p/WbZXJOQ==
X-Google-Smtp-Source: AA0mqf6nag/Sjslmk0aQYblAKPmgimxbu+rkA/E9Puei6msuPuXqqiBgNJftq/9oUIIGZ6VNNmtMvA==
X-Received: by 2002:a05:6402:143:b0:463:f8aa:d2bf with SMTP id s3-20020a056402014300b00463f8aad2bfmr64460796edu.358.1669981992474;
        Fri, 02 Dec 2022 03:53:12 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q20-20020aa7da94000000b00458947539desm2833754eds.78.2022.12.02.03.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 03:53:11 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 7/8] tests: don't lose "git" exit codes in "! ( git ... | grep )"
Date:   Fri,  2 Dec 2022 12:52:40 +0100
Message-Id: <patch-v3-7.8-307f25db831-20221202T114733Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc1.981.gf846af54b4b
In-Reply-To: <cover-v3-0.8-00000000000-20221202T114733Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20221202T000227Z-avarab@gmail.com> <cover-v3-0.8-00000000000-20221202T114733Z-avarab@gmail.com>
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

- For "t3700-add.sh" use "sed -n" to print the expected "bad" part,
  and use "test_must_be_empty" to assert that it's not there.

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
2.39.0.rc1.981.gf846af54b4b

