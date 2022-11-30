Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3919AC4321E
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 08:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235014AbiK3I0L (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 03:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235006AbiK3IZU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 03:25:20 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9B06F361
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 00:24:14 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id l11so23015548edb.4
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 00:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ps8CllkXhPnv5i2uSGSHlQeYH+Ni80579M0j1HnlZTU=;
        b=ar7LN+rCGYawc2shYtaYYPI4h745j/p/XkmESbW8FzFI9idrjT1onv9nMU7Ls/Dgay
         wBlXCQbK6Ygo+aH2dQH5GPjVypGGdQQ8zSWYEgezB+HBLiBlRYLr+YSWCr3h432eRmBa
         hCe2ofTiXHeuci/BI3Jhleg790d+pGTpwE0eb1I/Q2wCNmyzUVhc1r2vFInEl/KuJruC
         NCsRS2CbRRyaHgb2voir2mUI43VPCbt+6RobghbvR1fXc6YsvYoRVrQRy6Z47DZiggCp
         DUsg9xGl/e6IVbEHD8W/wHovQ+fzleYWpxbVDFB4SDuJ+DxoZZtbu2OzVfHhbRiBqnpH
         qo9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ps8CllkXhPnv5i2uSGSHlQeYH+Ni80579M0j1HnlZTU=;
        b=pvOBbkZC5uvIKI0mBWlMl2B/mP6eww4izIPI58pkdX8JbGl7M6V07xCaMnKPviuxgJ
         o915nW3drXRCtlJU8x5jORLrTOHPLP6KY7IDOWAFLBa5n1TTtHEDikJrd1jAuDruUuZ0
         qRYFZ2/AtkIIdHHpLr0316G7wKFB1krbGmaZE2MWd/ABCTeFhQVQAhpLEeA212kDMVzb
         ySYjzh35I3bYs6rkF+4vXBi4B26AETT6MDT9ETzpey7h+zWpmdFR2FuOVjT1J9CtDI+B
         uvKv1cnWLVRQ3AK0jTeQRKfSQwAw15eLJQD34hJZuwiaNMsPtAIGQVfO5h04OgAGMzat
         hIEg==
X-Gm-Message-State: ANoB5pmWnBlMOOSTnsJRLolyzgUizwLXNr6gAzsm7gZrzcE/i2h2hxAI
        vYmadRdmyqlmqEywXwTggkbxS9NpT6IjYA==
X-Google-Smtp-Source: AA0mqf7BD6ZbSXPIm/nglj8EA3u3ZqPFfGs2MVfS3PvQg8cKFs/nTm3OVSmWxgnw9zD8RzjNzpTf+A==
X-Received: by 2002:aa7:cc08:0:b0:461:8a43:e93 with SMTP id q8-20020aa7cc08000000b004618a430e93mr52827243edt.275.1669796649852;
        Wed, 30 Nov 2022 00:24:09 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l18-20020a1709060cd200b007adf2e4c6f7sm352064ejh.195.2022.11.30.00.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 00:24:09 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Paul Smith <psmith@gnu.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/1] Makefiles: change search through $(MAKEFLAGS) for GNU make 4.4
Date:   Wed, 30 Nov 2022 09:23:49 +0100
Message-Id: <patch-v3-1.1-432518b2dd7-20221130T081835Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc0.1028.gb88f24da998
In-Reply-To: <cover-v3-0.1-00000000000-20221130T081835Z-avarab@gmail.com>
References: <cover-v2-0.4-00000000000-20221129T140159Z-avarab@gmail.com> <cover-v3-0.1-00000000000-20221130T081835Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since GNU make 4.4 the semantics of the $(MAKEFLAGS) variable has
changed in a backward-incompatible way, as its "NEWS" file notes:

  Previously only simple (one-letter) options were added to the MAKEFLAGS
  variable that was visible while parsing makefiles.  Now, all options are
  available in MAKEFLAGS.  If you want to check MAKEFLAGS for a one-letter
  option, expanding "$(firstword -$(MAKEFLAGS))" is a reliable way to return
  the set of one-letter options which can be examined via findstring, etc.

This upstream change meant that e.g.:

	make man

Would become very noisy, because in shared.mak we rely on extracting
"s" from the $(MAKEFLAGS), which now contains long options like
"--jobserver-auth=fifo:<path>", which we'll conflate with the "-s"
option.

So, let's change this idiom we've been carrying since [1], [2] and [3]
as the "NEWS" suggests.

Note that the "-" in "-$(MAKEFLAGS)" is critical here, as the variable
will always contain leading whitespace if there are no short options,
but long options are present. Without it e.g. "make --debug=all" would
yield "--debug=all" as the first word, but with it we'll get "-" as
intended. Then "-s" for "-s", "-Bs" for "-s -B" etc.

1. 0c3b4aac8ec (git-gui: Support of "make -s" in: do not output
   anything of the build itself, 2007-03-07)
2. b777434383b (Support of "make -s": do not output anything of the
   build itself, 2007-03-07)
3. bb2300976ba (Documentation/Makefile: make most operations "quiet",
   2009-03-27)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-gui/Makefile | 2 +-
 shared.mak       | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-gui/Makefile b/git-gui/Makefile
index 56c85a85c1e..a0d5a4b28e1 100644
--- a/git-gui/Makefile
+++ b/git-gui/Makefile
@@ -116,7 +116,7 @@ ifeq ($(uname_S),Darwin)
 	TKEXECUTABLE = $(shell basename "$(TKFRAMEWORK)" .app)
 endif
 
-ifeq ($(findstring $(MAKEFLAGS),s),s)
+ifeq ($(findstring $(firstword -$(MAKEFLAGS)),s),s)
 QUIET_GEN =
 endif
 
diff --git a/shared.mak b/shared.mak
index be1f30ff206..aeb80fc4d5a 100644
--- a/shared.mak
+++ b/shared.mak
@@ -37,13 +37,13 @@ space := $(empty) $(empty)
 QUIET_SUBDIR0  = +$(MAKE) -C # space to separate -C and subdir
 QUIET_SUBDIR1  =
 
-ifneq ($(findstring w,$(MAKEFLAGS)),w)
+ifneq ($(findstring w,$(firstword -$(MAKEFLAGS))),w)
 PRINT_DIR = --no-print-directory
 else # "make -w"
 NO_SUBDIR = :
 endif
 
-ifneq ($(findstring s,$(MAKEFLAGS)),s)
+ifneq ($(findstring s,$(firstword -$(MAKEFLAGS))),s)
 ifndef V
 ## common
 	QUIET_SUBDIR0  = +@subdir=
-- 
2.39.0.rc0.1028.gb88f24da998

