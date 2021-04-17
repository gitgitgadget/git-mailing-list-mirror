Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F333BC43460
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 12:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD03D611AC
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 12:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236531AbhDQMyJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Apr 2021 08:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236495AbhDQMyG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Apr 2021 08:54:06 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF5EC061756
        for <git@vger.kernel.org>; Sat, 17 Apr 2021 05:53:38 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n4-20020a05600c4f84b029013151278decso4353153wmq.4
        for <git@vger.kernel.org>; Sat, 17 Apr 2021 05:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cL+Yf735B8BILcHwKCNszDz+Do2V7ma+Y3G5U/IY+ns=;
        b=dtxiJRJdyrACRx9agOQnstl35wbB6MIzMTmkZLWIESUVCay6EusgVtXrX/N/Gy0ObP
         bMbbxX6r4tAeAKprCxphQgJN/xslHLR+irSuWtAyC7Z6BpLpVrK2yzKISEjvelIZOKem
         a9S3FO5WnNomU4Z3yBkzgm4r13eT475BV4AWLWR5CFkZiKLaBsEiOQM5iMtpdossZeFJ
         NormOtOvYgJrspBOMXSjRHWB5sJIdNcpV/Cr0BWu/ehwHkUDtxc73pqtkmTzTEb1YuZq
         4nNAu7ZQIBBiMcZec10zAGnJmcTmihVbG8QdoHNlMssyX7G1UvUoI/Jv+fQFJmPjiP02
         QPiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cL+Yf735B8BILcHwKCNszDz+Do2V7ma+Y3G5U/IY+ns=;
        b=NO+v8nCTY2I+korg50xFSGw0Zllxp0kzN7zi0cqs1qnn3B0L89EfY1Mlq8p/rSrOAL
         MuaK7/al6X7hC1vHW6bHc/gRzV+9cAlmQRi5fiMZhQ22l/2PfGt1VYjPJCTxQQlda/Xt
         tpSphk8FdWOAlIW3gdkjuSeRs4Nr/LUHYqYyamsRn4d/vRZybUIvjcchNtLQURnjvfrs
         rPmmM6PGhvZ6eVWqAEcbA7ozhHED1zzr3q78HPJ8+Cal3exDB8FJShAadb4ECGftsj4E
         UAXB0Chst7/eMf42GcOtaUSgJCv+jvSC884ZuLQyvQ1GkWQ7BCsNBHc4rP8Z7+eLmoyo
         AJxA==
X-Gm-Message-State: AOAM532DWnF8HqcMcX5rhLSQM7epKNj0WaBLbPY7fqroE6N83eTrJpnz
        9fsuFr0mbG39sqAKtYmthtEIvb4wIWAZZg==
X-Google-Smtp-Source: ABdhPJxKr4rchWOkXKp13DVrGH9a2ZMFOKJWMeS2bG7RqQMGjSlatbLCke3kEI0YCcqB7dniEOds/Q==
X-Received: by 2002:a05:600c:d4:: with SMTP id u20mr12576654wmm.164.1618664016764;
        Sat, 17 Apr 2021 05:53:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v4sm11594529wme.14.2021.04.17.05.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Apr 2021 05:53:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 01/12] check-non-portable-shell: check for "test <cond> -a/-o <cond>"
Date:   Sat, 17 Apr 2021 14:52:34 +0200
Message-Id: <patch-01.12-a8b483bc771-20210417T124424Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.722.g788886f50a2
In-Reply-To: <cover-00.12-00000000000-20210417T124424Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com> <cover-00.12-00000000000-20210417T124424Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a check for -a/-o in "test", as a follow-up to the
CodingGuidelines having recommended against their use since
897f964c0dc (CodingGuidelines: avoid "test <cond> -a/-o <cond>",
2014-05-20).

These constructs are considered obsolescent by POSIX[1]. GNU has
likewise warned against them[2] for a few decades.

These will only match the simplistic forms of `test -X blah` (where
"-X" is some single letter option), but will miss expressions such as
`test "$foo" = bar`. We stop at "&" or "|" to try not to overmatch
things like:

    test whatever && ls -a foo
    test whatever && foo -o outfile

1. https://pubs.opengroup.org/onlinepubs/9699919799/utilities/test.html#tag_20_128_16
2. https://www.gnu.org/savannah-checkouts/gnu/autoconf/manual/autoconf-2.70/html_node/Limitations-of-Builtins.html

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/check-non-portable-shell.pl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.pl
index fd3303552be..894aa0a4f92 100755
--- a/t/check-non-portable-shell.pl
+++ b/t/check-non-portable-shell.pl
@@ -41,6 +41,8 @@ sub err {
 	/^\s*declare\s+/ and err 'arrays/declare not portable';
 	/^\s*[^#]\s*which\s/ and err 'which is not portable (use type)';
 	/\btest\s+[^=]*==/ and err '"test a == b" is not portable (use =)';
+	/\btest\s+-[a-z]\s+[^&|]+\s+-a\s+/ and err '"test A && test B" preferred to "test A -a B"';
+	/\btest\s+-[a-z]\s+[^&|]+\s+-o\s+/ and err '"test A || test B" preferred to "test A -o B"';
 	/\bwc -l.*"\s*=/ and err '`"$(wc -l)"` is not portable (use test_line_count)';
 	/\bhead\s+-c\b/ and err 'head -c is not portable (use test_copy_bytes BYTES <file >out)';
 	/(?:\$\(seq|^\s*seq\b)/ and err 'seq is not portable (use test_seq)';
-- 
2.31.1.722.g788886f50a2

