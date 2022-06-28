Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A487FC433EF
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 10:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344498AbiF1KQL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 06:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245559AbiF1KQJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 06:16:09 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4532FE60
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 03:16:07 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id e28so11779499wra.0
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 03:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NQ7NVKZCW05rGcWXJxbiqrWTRUWbpKul3wdoa4Knn0s=;
        b=Tb4wKJ7CnK+GQsxEfW1wvZ3jhk5PUVdSFzSEy7GNvP/BLWcp2/rh6VfOLtC8032jq3
         vliE3PPzynWGsqAlppdTd8SdUT0GfhZ7n2KhihcwxvmA77mdsMYsNsqj8M4m3k5kAYI/
         VglCqVOT4M59pZS71UzikBF1OUKNtSLx3yAeTrQ1fqjBtMFa8weWSiC+hiz4xxaj51M4
         qs/wm/kEGaQBR3HHDMjZRzqUmd4WTj96+BtDusyI88LZJwkX4aCOxv8P1oEh4fX9ohHD
         Zv+pLVFO6b6TEoo636zDB6BgUIHmrAaFYqaHOsS32DaDoSukS7vwU0fsnB03rfypT33n
         vOSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NQ7NVKZCW05rGcWXJxbiqrWTRUWbpKul3wdoa4Knn0s=;
        b=NSIgurcm/bAkgauAt1keZXesw79J6DaORokimG97QAzNWIxUjyxyoFo95egmgsb2ew
         RJsjt5LWKOhBscxNLNVLgKMlzTFdDikGbSWVxxJ+d/p3VfdjNTpmhx2lJKKTRC1a1c10
         tqFdAMymuqjQRBEmWug5g7FWpq/PpjlIs6ChdH8pFF4buUYVPLX7yWSbf53arMWgwW2f
         HscaGlNPZ0RCxULe6PMZGX5NzlOrJN+mnuhDydVGsWu4iV4Jl2q5Z2cr3aSA7qjXBOfl
         MLa8DIaUp1FhTDAgw0Ec3D8DuZglUcg4T7s/tp3pLSCbYtxTCwcTB2ZT7aeh1+O0jv3G
         z7xw==
X-Gm-Message-State: AJIora+SqyQhTeg6AAAY6H1QcMrE5HMu9N9/A3x2HrDH6XwvpqDczRZ5
        SjNKJPueivU10xEQD1Fo+NteN7TOOPwWRw==
X-Google-Smtp-Source: AGRyM1t2AjMW7CZEkz6AX260BFKjS6q4mrTafsjCNGJrSfyhoQZkAyYeV7m9bi1OgyskNYdIj3BZqg==
X-Received: by 2002:a5d:4304:0:b0:21b:9b2c:be34 with SMTP id h4-20020a5d4304000000b0021b9b2cbe34mr17794734wrq.577.1656411366006;
        Tue, 28 Jun 2022 03:16:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r1-20020a05600c2f0100b0039c54bb28f2sm552595wmn.36.2022.06.28.03.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 03:16:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/8] gitweb: fix "make" not including "gitweb" without NOOP run slowdowns
Date:   Tue, 28 Jun 2022 12:15:54 +0200
Message-Id: <cover-v3-0.8-00000000000-20220628T100936Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.880.gf07d56b18ba
In-Reply-To: <cover-v2-0.7-00000000000-20220531T173805Z-avarab@gmail.com>
References: <cover-v2-0.7-00000000000-20220531T173805Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The $subject is a mostly trivial re-roll of
https://lore.kernel.org/git/cover-v2-0.7-00000000000-20220531T173805Z-avarab@gmail.com/.

Changes since v3:

 * Correct the commit message of 7/8 to account for SZEDER's commit
   being included in this (that part was also incorrect in v2).

 * As noted in
   https://lore.kernel.org/git/220624.86bkuikidi.gmgdl@evledraar.gmail.com/
   I went over various git packages in the wild to see if my changes
   here would break things

   I did find that not having a wrapper gitweb/Makefile would break
   OpenBSD's package, but it's a one-line fix.

   But to make up for it I saw that a semi-common pattern was to
   manually munge our Makefile to get rid of "gitweb" or
   "gitweb-install" targets. All of {Free,Net,Dragonfly}BSD were doing
   that. They'll now happily be able to use a NO_GITWEB=Y flag
   instead, so hopefully the small amount of disruption here makes up
   for itself.

SZEDER Gábor (1):
  Makefile: build 'gitweb' in the default target

Ævar Arnfjörð Bjarmason (7):
  gitweb/Makefile: define all .PHONY prerequisites inline
  gitweb/Makefile: add a $(GITWEB_ALL) variable
  gitweb/Makefile: clear up and de-duplicate the gitweb.{css,js} vars
  gitweb/Makefile: prepare to merge into top-level Makefile
  gitweb: remove "test" and "test-installed" targets
  gitweb/Makefile: include in top-level Makefile
  gitweb/Makefile: add a "NO_GITWEB" parameter

 Makefile        |  31 +++++++----
 gitweb/Makefile | 145 ++++++++++++++++--------------------------------
 t/Makefile      |   4 --
 3 files changed, 68 insertions(+), 112 deletions(-)

Range-diff against v2:
1:  14361617ca6 = 1:  8e85151cf3d gitweb/Makefile: define all .PHONY prerequisites inline
2:  7d920a13518 = 2:  5c9895949aa gitweb/Makefile: add a $(GITWEB_ALL) variable
3:  e14a5b73061 = 3:  2f4db54923d gitweb/Makefile: clear up and de-duplicate the gitweb.{css,js} vars
4:  02e26ca8ce2 = 4:  d38b553a2e6 gitweb/Makefile: prepare to merge into top-level Makefile
5:  caf376f3dd9 = 5:  6c2d7b30524 gitweb: remove "test" and "test-installed" targets
6:  b423cd58f6b = 6:  5640587b9ae gitweb/Makefile: include in top-level Makefile
7:  69428540886 ! 7:  571c9c10319 Makefile: build 'gitweb' in the default target
    @@ Commit message
         Since then a simple 'make' doesn't build 'gitweb'.
     
         Luckily, installing 'gitweb' is not broken: although 'make install'
    -    doesn't depend on the 'gitweb' target, it runs 'make -C gitweb
    -    install' unconditionally, which does generate all the necessary files
    +    doesn't depend on the 'gitweb' target, it has a dependency on the
    +    'install-gitweb' target, which does generate all the necessary files
         for 'gitweb' and installs them.  However, if someone runs 'make &&
         sudo make install', then those files in the 'gitweb' directory will be
         generated and owned by root, which is not nice.
-:  ----------- > 8:  0c8f26ee876 gitweb/Makefile: add a "NO_GITWEB" parameter
-- 
2.37.0.880.gf07d56b18ba

