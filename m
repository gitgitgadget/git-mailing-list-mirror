Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1D6C433E0
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 08:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2791522E00
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 08:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405618AbhALIs1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 03:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389517AbhALIs0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 03:48:26 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F91C061575
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 00:47:46 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id g8so1157078wme.1
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 00:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=cvPaEz7m8LZtCqrBB0HPjF9Q96k7Jpq9qmBkg/3HRWY=;
        b=XGpggasVIQo2QOUSj9aCmTbF9vDIvrik7wWSCESd3PbJ2G+f2FE1Kkk07oatEkGHxT
         UJ0PdmkpzDsEeB3OzTaVe3TKpTjaVbvLBy5BoXQuJ/503UiPCpG6u6aqXfBm/LfdKOZ5
         oANNQRY3B6pCrlA+voP4YmXOaFV0a1bn3BSoejgmDgN2CUkBSLnh7IgVFVd/hPQ9g4xD
         hrx1T/EnCNpuk1cAnKx+uRcyzc6O+Nx1GSNGId4xUnMBMYLiiQUJeu6PgB2RKfD8xmJA
         xnG49LZcrfs2jfLzdIeNMASUbWHbA7W+OGxjca8yPnCLg4OYkU8FPjk9jCu1HDN8ul+4
         8Vpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cvPaEz7m8LZtCqrBB0HPjF9Q96k7Jpq9qmBkg/3HRWY=;
        b=d6v5sjKleF3/Ky2Wdif8rwjeuTtFw+GDKhnz0BVC7NqRD4GHpgCyloPWvC1E1pQsXI
         fhC34ixE/S1pXc4Bicpl10KFpS+LFWvEQh4zmoYLm0mcoVKnR+cuABghPa2oKwrPnTbv
         hR3EcgKIHeXNSRQbHI5mD2a1ZYJORuN9nCU1dSui0LC0+I5oVuhMhLjRZm7v1LmKaozA
         aJDyqf2oiaVjiXpBT3Hpy1CZ0w8AAjzrzXNQeUepUlwB6J3hCGyCfXh2ERnPGUaC67s9
         TkvLwQc2yiUQ9LRgqZ+8gtsMqN0jHOU0WlsD+pSvOvhlsvfKPqg+qE0loSo5Ixnsro7P
         A4Hg==
X-Gm-Message-State: AOAM533oxKYwNgBqqNX3Df1CaMMKBonXASwh4G0JBiDgnRA2/BYvfuKX
        VGsoo8k8fv/blIRLEvNWGqgKyzepaZ4=
X-Google-Smtp-Source: ABdhPJw5OWLU2THVcQYWVXx3RJl+JJ9ebf0eB9IwRTwzNu2pK9oGvYQ2yljL1ReLwTtqdyXrNg3iMg==
X-Received: by 2002:a7b:cd90:: with SMTP id y16mr2499550wmj.115.1610441264740;
        Tue, 12 Jan 2021 00:47:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a130sm3011239wmf.4.2021.01.12.00.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 00:47:43 -0800 (PST)
Message-Id: <pull.836.git.1610441262.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 12 Jan 2021 08:47:31 +0000
Subject: [PATCH 00/11] [RFH] Introduce support for GETTEXT_POISON=rot13
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
        <pclouds@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series is incomplete because I lack the time to finish it, and I
hope that there are interested developers who can help with it.

In https://lore.kernel.org/git/20181022153633.31757-1-pclouds@gmail.com/,
Duy proposed introducing a fake language they called "Ook" to be able to
test translations better. "Ook" would "translate" messages without any
printf format specifiers to "Eek", otherwise convert all upper-case letters
to "Ook" and lower-case letters to "ook".

Gábor replied with a different proposal that has the advantage of being
bijective, i.e. it is possible to reconstruct the untranslated message from
the translated one.

Ævar suggested recently
[https://lore.kernel.org/git/xmqqim836v6m.fsf@gitster.c.googlers.com/T/#m6fdc43d4f1eb3f20f841096c59e985b69c84875e]
that this whole GETTEXT_POISON business is totally useless.

I do not believe that it is useless. To back up my belief with something
tangible, I implemented a GETTEXT_POISON=rot13 mode and ran the test suite
to see whether we erroneously expect translated messages where they aren't,
and related problems.

And the experiment delivered. It is just a demonstration (I only addressed a
handful of the test suite failures, 124 test scripts still need to be
inspected to find out why they fail), of course. Yet I think that finding
e.g. the missing translations of sha1dc-cb and parse-options show that it
would be very useful to complete this patch series and then use the rot13
mode in our CI jobs (instead of the current GETTEXT_POISON=true mode, which
really is less useful).

Note: in its current form, this patch series fails t0013 and t9902 in the
GETTEXT_POISON job
[https://github.com/gitgitgadget/git/pull/836/checks?check_run_id=1686715225#step:4:1590],
therefore it cannot be integrated into Git as-is, even if it does not switch
the GETTEXT_POISON job to use the rot13 mode yet.

Sadly, even though I want to see this patch series go further, I am
operating under serious time constraints and therefore had to admit to
myself, grudgingly, that I can't. So again, I hope that somebody else can
push this effort further.

Johannes Schindelin (11):
  tests: remove unnecessary GIT_TEST_GETTEXT_POISON=false constructs
  Support GIT_TEST_GETTEXT_POISON=rot13
  parse-options: add forgotten translations
  sha1dc: mark forgotten message for translation
  t0006: use `test_i18ncmp` only for C locales
  t0041: stop using `test_i18ngrep` on untranslated output
  t0027: mark a function as requiring the C locale
  t6301: do not expect the output of `for-each-ref` to be translated
  GETTEXT_POISON=rot13: do compare the output in `test_i18ncmp`
  GETTEXT_POISON=rot13: perform actual checks in `test_i18ngrep`
  test-tool i18n: do not complain about empty messages

 Makefile                       |   1 +
 gettext.c                      |  65 ++++++++++++++++-
 gettext.h                      |   5 +-
 parse-options-cb.c             |   4 +-
 sha1dc_git.c                   |   2 +-
 t/helper/test-i18n.c           | 129 +++++++++++++++++++++++++++++++++
 t/helper/test-tool.c           |   1 +
 t/helper/test-tool.h           |   1 +
 t/t0006-date.sh                |   4 +-
 t/t0017-env-helper.sh          |   6 +-
 t/t0027-auto-crlf.sh           |   3 +
 t/t0041-usage.sh               |   2 +-
 t/t1305-config-include.sh      |   6 +-
 t/t6301-for-each-ref-errors.sh |   2 +-
 t/t7201-co.sh                  |   4 +-
 t/t9902-completion.sh          |   1 -
 t/test-lib-functions.sh        |  14 +++-
 t/test-lib.sh                  |   1 +
 18 files changed, 228 insertions(+), 23 deletions(-)
 create mode 100644 t/helper/test-i18n.c


base-commit: 72c4083ddf91b489b7b7b812df67ee8842177d98
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-836%2Fdscho%2Fgettext-poison-should-rot13-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-836/dscho/gettext-poison-should-rot13-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/836
-- 
gitgitgadget
