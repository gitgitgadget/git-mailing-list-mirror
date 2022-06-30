Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186CBC43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 10:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbiF3KTB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 06:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbiF3KS4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 06:18:56 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D48186DC
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 03:18:54 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id l68so5993032wml.3
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 03:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=65g55JGJlItMZ4JUxwGzOCdQwx35PnzTVHlJnhA4YTI=;
        b=nfYdNQu7NkxR/SpF969jsqCxBi3IdzMga5WeJY9zpSZs1k16wYQK4tHr2I5f3qdRBW
         N/gOS8Y7mEtmRHlX406b2HbwMhQlW33JxmKPDsvwI/PFqTuZRsVzx6Dhgi3qQZ22Gu5Z
         xaEIoF2NdLJpxnViuRDZtGFjueJ1bUDqu6tJR95WKa9pI+H+v1bwY5BHHBCQ82udgtCQ
         fHyjie1cPUXpdzvBvaD9hZF/vRyXp/pCC441h3wX8wBWOyxS9tAyFZ/A7RNJWVh9qOic
         7gjAIFnZwrBxTrerqWfB5PicU8PeltcpvqQjYIFL5D1ZTjOVRXNUqRtZG6vYlkj5jAD1
         BpbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=65g55JGJlItMZ4JUxwGzOCdQwx35PnzTVHlJnhA4YTI=;
        b=oE5Y8HE4NVJ2H3ziZDOEPNEjhQj+SvUXo9iAeMsrlRfx8ZayGkWpfWHTZX1DnVNdJS
         oSyHl5uGpcxEWStNuPvUTcJZk43LZxw6yMjWSUIVOj3Dta70+zFUpPgxoqHe87123cT3
         YJMMJkMrZEH+aOrbjRXPXUVyJlLmUaqtItdMztvv+gq0K7Iv6Uf9YOGfDM1oH5pDc8fk
         AY1DF8DGdi34Gd/Z+H5zwghweECsZoR7ZKvqZS92w893PhLi8buZTCkQiMupvyyfmdkO
         loSIpl09S1F3r+dB8rNyg2rj3moFPE6G9aRpv/XdX8wHcTyIhLRHV5Li2DgYC/RJV2vH
         BvqA==
X-Gm-Message-State: AJIora+3n8TGgS7ngQRM1id0eoXhuH1OxYVvLwb4xMCTy+eoO9CeCxD3
        mofwSf+8YqXatJsH1DQNdU3B5rf581423w==
X-Google-Smtp-Source: AGRyM1tT5LEDIknf9lm2Y/RbMbREvk1J4oESAvilhnFxCXAcP9DBZSRVt2v119dSa00ArW3yKOCE/A==
X-Received: by 2002:a05:600c:58e:b0:3a0:48dc:defc with SMTP id o14-20020a05600c058e00b003a048dcdefcmr11111738wmd.54.1656584332737;
        Thu, 30 Jun 2022 03:18:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m1-20020a7bcb81000000b003a05621dc53sm5978427wmi.29.2022.06.30.03.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 03:18:52 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        rsbecker@nexbridge.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/3] tests: fix tests broken if a " " is in the checkout dir's path
Date:   Thu, 30 Jun 2022 12:18:33 +0200
Message-Id: <cover-v2-0.3-00000000000-20220630T101646Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.880.gf07d56b18ba
In-Reply-To: <cover-0.3-00000000000-20220621T221928Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20220621T221928Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A re-roll of
https://lore.kernel.org/git/cover-0.3-00000000000-20220621T221928Z-avarab@gmail.com/;
Changes since v1:

 - Clarified IFS splitting issues in 1/3, as requested by Junio
 - Fixed $HOME quoting issue in 3/3, and also added the missing cleanup
   for $HOME/.gitconfig to that test.

Ævar Arnfjörð Bjarmason (3):
  tests: add missing double quotes to included library paths
  test-lib.sh: fix prepend_var() quoting issue
  config tests: fix harmless but broken "rm -r" cleanup

 t/t1300-config.sh         | 5 +++--
 t/t3700-add.sh            | 2 +-
 t/t3903-stash.sh          | 2 +-
 t/t7609-mergetool--lib.sh | 2 +-
 t/test-lib.sh             | 4 ++--
 5 files changed, 8 insertions(+), 7 deletions(-)

Range-diff against v1:
1:  05ba5e7f837 ! 1:  f4ef137d076 tests: add missing double quotes to included library paths
    @@ Metadata
      ## Commit message ##
         tests: add missing double quotes to included library paths
     
    -    Fix two inclusions added in d42bab442d7 (core.fsyncmethod: tests for
    -    batch mode, 2022-04-04) that needed to be quoted, and the same sort of
    -    issue in a242c150ebb (vimdiff: integrate layout tests in the unit
    -    tests framework ('t' folder), 2022-03-30). Both were first released
    -    with v2.37.0-rc0.
    +    Fix inclusion errors which would occur if the $TEST_DIRECTORY had $IFS
    +    whitespace in it.
    +
    +    See d42bab442d7 (core.fsyncmethod: tests for batch mode, 2022-04-04)
    +    and a242c150ebb (vimdiff: integrate layout tests in the unit tests
    +    framework ('t' folder), 2022-03-30) for the two relevant commits. Both
    +    were first released with v2.37.0-rc0 (and were also part of v2.37.0).
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
2:  e06bf0cdfbe = 2:  b56ededf1b8 test-lib.sh: fix prepend_var() quoting issue
3:  f787b19f8c2 ! 3:  d3f65326701 config tests: fix harmless but broken "rm -r" cleanup
    @@ Commit message
         fail to remove an existing directory, but in practice that probably
         never happened.
     
    +    Let's fix both the quoting issue, and the other issue cleanup issue in
    +    4179b4897f2, which is that we were attempting to clean up
    +    ~/.config/git, but weren't cleaing up ~/.gitconfig.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## t/t1300-config.sh ##
    @@ t/t1300-config.sh: test_expect_success '--show-scope with --show-origin' '
      
      test_expect_success 'override global and system config' '
     -	test_when_finished rm -f "$HOME"/.config/git &&
    -+	test_when_finished "rm -rf \"$HOME\"/.config/git" &&
    - 
    +-
    ++	test_when_finished rm -f \"\$HOME\"/.gitconfig &&
      	cat >"$HOME"/.gitconfig <<-EOF &&
      	[home]
    + 		config = true
    + 	EOF
    ++
    ++	test_when_finished rm -rf \"\$HOME\"/.config/git &&
    + 	mkdir -p "$HOME"/.config/git &&
    + 	cat >"$HOME"/.config/git/config <<-EOF &&
    + 	[xdg]
-- 
2.37.0.880.gf07d56b18ba

