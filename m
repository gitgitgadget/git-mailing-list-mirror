Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717E0C433F5
	for <git@archiver.kernel.org>; Tue, 31 May 2022 17:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346641AbiEaRqY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 May 2022 13:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345621AbiEaRqT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 May 2022 13:46:19 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED13E2AC7C
        for <git@vger.kernel.org>; Tue, 31 May 2022 10:46:15 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id k19so11493962wrd.8
        for <git@vger.kernel.org>; Tue, 31 May 2022 10:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L1gDy6BT3mRSIv8neCnRVmBuRVPHWPiOX4dyXD1RAL8=;
        b=Rj1nfBnx0eDzj7rCxY1vMMgDYMFY3ahR9A6WoN9uLzkvLzAOsSv7PGuV42nP7+pDIq
         nM7O5PGpy8u5D5E/r+lj1GMjQy5ffaXb0QACZmHDnNcEJTUVn8fP3JOr5BRiMDEZEE2A
         00ddeKzVXXg6Ib6k5GR8HC7hlUB30sbY8GnGFJ9soJ7X69y+yOhgUlKKU9hBUz0wDTRc
         kK8iGlXhVWyObU6w79CIh+iJZYER2zTKbeqnNz5lBNk2N0oLRsmu8Ti3xCvxnlYQ0uWp
         GTOzDlslzBM8TKJda9cuaYY7PdRz0tcbOuMAOfs6Aka7777sz6zssKIt0n9fQZ2XQH3x
         6akw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L1gDy6BT3mRSIv8neCnRVmBuRVPHWPiOX4dyXD1RAL8=;
        b=phwRkn9GlCuSaATwAZAEJWcXeZl2xl6vpyvCGwdCLXCEN3zqOtXGAKy5tkQ+aImasv
         EKMg4KwC8qEOQzu9dn0bA1Yor94+gyZEtnezSB+kpg7JJPqUBxMV6IkGzgjJ0D7kCaW0
         W/dp1kU9UIycJgxS5UXxNEX0T6gD9/kRPGTlB17nSCT5MnG9GFckhcw1tGqONpTI84Re
         t4I6orbiE5lMh8gzRDyXDm0yYNdkKZLJa2tbmppDyTgCf2HeGX7yUQZN9ncW7HwEkWtQ
         pMuP/SgtkO2cLutDnUgHWYdDa5AtIVJn+rn3kla9uUGxgXDNjPDkemaIVP0POKYzVGll
         ydmQ==
X-Gm-Message-State: AOAM533Msa/7A47E8tJeKcohDwjXb0FRASSPTwTfizofKlq8hLzgIyDO
        gLazny1SL00NuCw6V6wMVhs1g3YpLr1tqA==
X-Google-Smtp-Source: ABdhPJz3r7qHUK+UzloZP0WAnlofm8lhV92a3h/tG+6ABSmXXKTiZTfn21KPTLv2zUvZDCYp1YhRYQ==
X-Received: by 2002:a5d:4c86:0:b0:210:2e6e:3a93 with SMTP id z6-20020a5d4c86000000b002102e6e3a93mr11709545wrs.185.1654019174227;
        Tue, 31 May 2022 10:46:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j26-20020a05600c1c1a00b003973e27b789sm3826656wms.27.2022.05.31.10.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 10:46:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/7] gitweb: fix "make" not including "gitweb" without NOOP run slowdowns
Date:   Tue, 31 May 2022 19:45:53 +0200
Message-Id: <cover-v2-0.7-00000000000-20220531T173805Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1103.g036c05811b0
In-Reply-To: <220527.861qwf489s.gmgdl@evledraar.gmail.com>
References: <220527.861qwf489s.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The $subject is a proposed re-roll of SZEDER's
https://lore.kernel.org/git/20220525205651.825669-1-szeder.dev@gmail.com;
As noted downthread of that fix having the Makefile invoke "make -C
gitweb" again would slow us down on NOOP runs by quite a bit.

This series fixes the same regression with an amended 7/7 version of
SZEDER's fix, but starts out by having the top-level Makefile include
the gitweb/Makefile.

This series is smaller than it looks, most of the commits preceding
5-6/7 are there to make that diff smaller and easier to read, by
splitting up earlier changes into non-functional changes.

For this re-roll the equivalent of the "git hyperfine" command I
posted in [2] will return;

	Summary
	  'make NO_TCLTK=Y' in 'origin/master' ran
	    1.00 ± 0.11 times faster than 'make NO_TCLTK=Y' in 'HEAD~0'
	    2.64 ± 0.26 times faster than 'make NO_TCLTK=' in 'origin/master'
	    2.64 ± 0.24 times faster than 'make NO_TCLTK=' in 'HEAD~0'

I.e. we are no slower or faster than before, but now "make && sudo
make install-gitweb" will only copy already-generated files from the
"make" command in the "sudo" step, as intended.

1. https://lore.kernel.org/git/20220525205651.825669-1-szeder.dev@gmail.com
2. https://lore.kernel.org/git/220526.86k0a96sv2.gmgdl@evledraar.gmail.com/

SZEDER Gábor (1):
  Makefile: build 'gitweb' in the default target

Ævar Arnfjörð Bjarmason (6):
  gitweb/Makefile: define all .PHONY prerequisites inline
  gitweb/Makefile: add a $(GITWEB_ALL) variable
  gitweb/Makefile: clear up and de-duplicate the gitweb.{css,js} vars
  gitweb/Makefile: prepare to merge into top-level Makefile
  gitweb: remove "test" and "test-installed" targets
  gitweb/Makefile: include in top-level Makefile

 Makefile        |  24 ++++----
 gitweb/Makefile | 143 +++++++++++++++---------------------------------
 t/Makefile      |   4 --
 3 files changed, 59 insertions(+), 112 deletions(-)

Range-diff against v1:
1:  1bbffa8a2b6 < -:  ----------- Makefile: build 'gitweb' in the default target
-:  ----------- > 1:  14361617ca6 gitweb/Makefile: define all .PHONY prerequisites inline
-:  ----------- > 2:  7d920a13518 gitweb/Makefile: add a $(GITWEB_ALL) variable
-:  ----------- > 3:  e14a5b73061 gitweb/Makefile: clear up and de-duplicate the gitweb.{css,js} vars
-:  ----------- > 4:  02e26ca8ce2 gitweb/Makefile: prepare to merge into top-level Makefile
-:  ----------- > 5:  caf376f3dd9 gitweb: remove "test" and "test-installed" targets
-:  ----------- > 6:  b423cd58f6b gitweb/Makefile: include in top-level Makefile
-:  ----------- > 7:  69428540886 Makefile: build 'gitweb' in the default target
-- 
2.36.1.1103.g036c05811b0

