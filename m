Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF92C433E0
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 16:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9700665279
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 16:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbhCIQCs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 11:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbhCIQCf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 11:02:35 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2972CC06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 08:02:35 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id w11so16656312wrr.10
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 08:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ph0NilpACD3zCe5Zy7GHWAlD/Zf3mMOaHSF10YLJ+4A=;
        b=kj7YEZTmGViTBxIC3zaZRFsd+/zupQvV68SKXNULhuzXuVeD1fun0PL+EMHjKg0vfC
         7DWuvz8ZZpQH2y6vxoQ7iYZ0O1bj4LTjDurmXlwyLLV0NfETJvok8kvULtawK7mrI4va
         FdOxsPC2/9FHRGUhWk3/33UGaCK3YyepZ5G2K/TumLF/oa5TmwAH3TR4sJnfPFZ6YyrU
         Dxdb5h1EnMwA4TO5/2lGc+P21tmemR49ukcJ6qE4b3RTD84U7LfF4DSNQPTsVn5lSgex
         8aJTtvAaAt7Hsls9oVvhd/owSg/wtpdn/FlaupG3pDguKP7YziZdRAg3wLJEE5TgNzCz
         lTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ph0NilpACD3zCe5Zy7GHWAlD/Zf3mMOaHSF10YLJ+4A=;
        b=U7ZPgIw8Dk+REBYeIoI34SsVa85k6a9tdiCigXi3IOS54bQwgRAkTaFMnTck1ESJqB
         SP8HcMqEUb+iNjzTYzOZTF08oVrqxMgoIg4/1XC7/EVatutpPfMyFTY1dWTk0ZJs6q4O
         ojIMypl2j/iJ89PEEJF3n8VvVqFhRuP34nbPsqEl174AeebFSRytmgANbhtW+do/ebhk
         1EMJm8IkQe0/WA6WTDOZgjFKiYRzVpJ1S6B4Hi8F6NHQVZ1zDrwoGn3ZnNDtWmYYuZ/v
         0Dr0aOHyJRoEKZ5Rj06g8QUG9Ze+zcomWFfWTYCbZZw87rrvXCEHnthjEiJpVcj+UAhH
         WW5Q==
X-Gm-Message-State: AOAM531RDZLK9InpciE2v4IFGwLHyLkJF8kfeHiQaqtlGxVleLkQwO9z
        oab2cjLwZ3RPfQvVzJBz2+gHR2OqUQntxw==
X-Google-Smtp-Source: ABdhPJw8DeNTCH5N8NPj7JftAOjLWv0M5JZAh+Z4HbE2OmQoQxlT1LNvCm1DauRyTRdWE7WVCRLR0Q==
X-Received: by 2002:adf:fb91:: with SMTP id a17mr28760099wrr.93.1615305751654;
        Tue, 09 Mar 2021 08:02:31 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n6sm5089223wmd.27.2021.03.09.08.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 08:02:30 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/6 + 1] test-lib: make --verbose output valid TAP
Date:   Tue,  9 Mar 2021 17:02:12 +0100
Message-Id: <20210309160219.13779-1-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc1.210.g0f8085a843c
In-Reply-To: <87r1kzj7xi.fsf@evledraar.gmail.com>
References: <87r1kzj7xi.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes the --verbose valid TAP.

This is a non-RFC version of an RFC patch I sent in
https://lore.kernel.org/git/87tupwj5y5.fsf@evledraar.gmail.com/

There's a 7/7 patch that's an RFC at the end. It works for me, but
since I haven't used the JUnit output it's likely subtly broken in
some way (e.g. the new output doesn't include a timestamp attribute),
but it shows how easy it is to add new output targets.

The eventual goal not included in this series is to have multiple
output targets, and e.g. convert ci/print-test-failures.sh to use a
TAP parser.

Machine-readable "TAP --verbose -x" output can bring us a lot of nice
things down the line, I have some local WIP code that's a smarter
version of ci/print-test-failures.sh that knows how to spew out only
the output relevant to the failing test(s).

Future improvements based on that could be showing what specific line
in a &&-chain failed, as well as e.g. running a debug version of a
failing "grep" if we detect that the failing line line was 'grep <pat>
<filename>'.

Ævar Arnfjörð Bjarmason (7):
  test-lib: remove test_external
  test-lib: add say_color_tap helper to emit TAP format
  test-lib: color "ok" TAP directives green under --verbose (or -x)
  test-lib: add tee with TAP support to test-tool
  test-lib: indent and format GIT_TEST_TEE_OUTPUT_FILE code
  test-lib: make --verbose output valid TAP
  test-lib: generate JUnit output via TAP

 Makefile                                      |   2 +-
 .../netrc/t-git-credential-netrc.sh           |   7 +-
 t/README                                      |  35 +--
 t/helper/test-date.c                          |  12 -
 t/helper/test-path-utils.c                    |  21 --
 t/helper/test-tee.c                           |  85 +++++++
 t/helper/test-tool.c                          |   2 +-
 t/helper/test-tool.h                          |   2 +-
 t/helper/test-xml-encode.c                    |  80 -------
 t/t0000-basic.sh                              |   8 +
 t/t0202-gettext-perl.sh                       |  10 +-
 t/t9700-perl-git.sh                           |  10 +-
 t/test-lib-functions.sh                       |  89 +------
 t/test-lib.sh                                 | 226 +++++-------------
 14 files changed, 177 insertions(+), 412 deletions(-)
 create mode 100644 t/helper/test-tee.c
 delete mode 100644 t/helper/test-xml-encode.c

-- 
2.31.0.rc1.210.g0f8085a843c

