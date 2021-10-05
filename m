Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9BDC433F5
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 17:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B98E061381
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 17:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236203AbhJERDV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 13:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235045AbhJERDU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 13:03:20 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AEFC061749
        for <git@vger.kernel.org>; Tue,  5 Oct 2021 10:01:29 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id a11-20020a7bc1cb000000b0030d6aae48b5so85447wmj.4
        for <git@vger.kernel.org>; Tue, 05 Oct 2021 10:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e7oZQz1gE+5D5+/H2rSES2XpGYXGSvhuPXo9No/d2G0=;
        b=dI7TRkgbcU+49mRCboM9c1/AyihoRKWgUZ1vtnLMNZ7Bzyv1Jc3MXLpzMpmNIoth+B
         zwqSEfM1skoMKGo0Xdi8ZAiy0KXSpoaAFfhl0vvpzM8MyVK4AUxUxYlrADcHUYs3Y9wy
         aZk0F/DGOMF6BsYOGdIFAQoDCaPwIEb1FMZPt/yt3lol8JbaOHtrv57OTu6ytCTvbl4m
         fGZKtBo9NSbayqC1KDTCYDkok/L0zsrt7WXKCpIOmIITOPtWcaC4XmYEZLq1GPlUMmb7
         ZdMsuP0SQhs4WSaN4ceDzkX8+6TtVpR85E+JWcRRP4VBHAhRHjpRPE7ozHtPFhe5FN8a
         0p8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e7oZQz1gE+5D5+/H2rSES2XpGYXGSvhuPXo9No/d2G0=;
        b=yqaGlx8YMza38pD2QYfrmQAeUVLN7yuS5FuqbuaXBfH+wpk5BzVh1RHupVeJhDvdAv
         pxC7RCdmeFfGgTwtmlritdUDh69m7EwMnZYSXERQA1MWEZPSfGDMvppAVAbDK8BzQP80
         DDHGzBV9kr98hWtDZDVM8p6FIdqsa/gxcWrijs3PjFKqi9zl6eg88SgrIqJA1T3/tIoi
         7PIJ4TlcXHevLGfene+b5gvqmOa1ncHE1mY+hXdI/T3XQZ9L9RY7IcxZPWePH2utKUBL
         xsIF4KpnRGn5mtg1+uESDZ5m+COyk6v9Khm7g9dtg6VpeDoFU9xoQMhjmduGG25ttbUg
         HsZQ==
X-Gm-Message-State: AOAM530gnj+ypIRW09ST0DtFqBIsMlQ5oKpMoWDGJlxvNMNRDl7xGT//
        737yUD93ZOnhuz/vDlyynngecdyxZ0A=
X-Google-Smtp-Source: ABdhPJwlYt7GoSUKVR6jKfTm6JXq+Wth9o92v908QK54sq2oumQQLjSA/X5gHlAd20+O5VdrPTDo3w==
X-Received: by 2002:a05:600c:4a06:: with SMTP id c6mr3457595wmp.82.1633453288123;
        Tue, 05 Oct 2021 10:01:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z79sm2551261wmc.17.2021.10.05.10.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 10:01:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/5] COPYING: modernize, steal boilerplate from linux.git
Date:   Tue,  5 Oct 2021 19:01:12 +0200
Message-Id: <cover-v2-0.5-00000000000-20211005T170031Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1441.gbbcdb4c3c66
In-Reply-To: <cover-0.5-00000000000-20211002T091212Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20211002T091212Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This updates our COPYING file to be in line with linux.git's to
clarify how the licenses of embedded sub-projects are handled. This
doesn't change Git's license in any way (still GPL v2).

See the v1 for a longer summary:
https://lore.kernel.org/git/cover-0.5-00000000000-20211002T091212Z-avarab@gmail.com/

This v2 fixes typos in 3/5, and clarifies why we need to use the
specific "COPYING" data in the lib-diff.sh tests.

Ævar Arnfjörð Bjarmason (5):
  "lib-diff" tests: make "README" and "COPYING" test data smaller
  tests: stop using top-level "README" and "COPYING" files
  COPYING: remove mention of GPLv3, clarify sub-project COPYING
  COPYING: move GPL text to a "GPL-2.0" file
  GPL-2.0: update to byte-for-byte match the FSF's version

 COPYING                           | 377 ++----------------------------
 t/lib-diff/COPYING => GPL-2.0     |  60 ++---
 t/.gitattributes                  |   1 -
 t/lib-diff-data.sh                |  22 ++
 t/lib-diff.sh                     |   2 +
 t/lib-diff/README                 |  46 ----
 t/t4003-diff-rename-1.sh          |   4 +-
 t/t4005-diff-rename-2.sh          |   4 +-
 t/t4007-rename-3.sh               |   5 +-
 t/t4008-diff-break-rewrite.sh     |   4 +-
 t/t4009-diff-rename-4.sh          |   4 +-
 t/t4022-diff-rewrite.sh           |   6 +-
 t/t4023-diff-rename-typechange.sh |  11 +-
 t/t7001-mv.sh                     |   5 +-
 t/t7101-reset-empty-subdirs.sh    |  11 +-
 15 files changed, 89 insertions(+), 473 deletions(-)
 rename t/lib-diff/COPYING => GPL-2.0 (92%)
 create mode 100644 t/lib-diff-data.sh
 delete mode 100644 t/lib-diff/README

Range-diff against v1:
1:  8a4ca06bce0 ! 1:  f834cf74873 "lib-diff" tests: make "README" and "COPYING" test data smaller
    @@ Commit message
         "COPYING" as test data, or mock data that's dissimilar. Let's provide
         that with a "COPYING_test_data" function instead.
     
    +    We're not replacing this with some other generic test
    +    data (e.g. "lorum ipsum") because these tests require test file header
    +    to be the old "COPYING" file. See e.g. "t4003-diff-rename-1.sh" which
    +    changes the file, and then does full "test_cmp" comparisons on the
    +    resulting "git diff" output.
    +
         This change only changes tests that used the "lib-diff.sh" library,
         but splits up what they need into a new "lib-diff-data.sh". A
         subsequent commit will change related tests that were missed in
2:  f07025682e1 = 2:  f7cd2f31ccb tests: stop using top-level "README" and "COPYING" files
3:  e91f8ce6984 ! 3:  44375bece46 COPYING: remove mention of GPLv3, clarify sub-project COPYING
    @@ Commit message
     
         The COPYING file added in [1] is a product of its era, at the time
         discussions around the GPLv3 were quite active. Since then we have had
    -    almost on "GPL v2 or later" notices anywhere.
    +    almost no "GPL v2 or later" notices anywhere.
     
         Since then[2][3] linux.git has replaced its version of almost the
         identical wording with something that's a bit more formal, and which
    -    isn't mostly addressing a hypothetical future GPL v3 migratin. Let's
    +    isn't mostly addressing a hypothetical future GPL v3 migration. Let's
         do the same. Now we:
     
         A. Let it suffice to say that things are licensed under GPL v2 unless
4:  7804709f585 = 4:  ccb26274cc6 COPYING: move GPL text to a "GPL-2.0" file
5:  0545fd06cac = 5:  6fe2e601b13 GPL-2.0: update to byte-for-byte match the FSF's version
-- 
2.33.0.1441.gbbcdb4c3c66

