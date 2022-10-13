Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C24C433FE
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 15:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbiJMPlo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 11:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiJMPk7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 11:40:59 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C836D54A
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:40:12 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id bp11so3430386wrb.9
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9N0JeXkkrz81RbDLsCzycBV5k/ABXQC2wthCCQxf7X8=;
        b=UJfoUoTDyKroqT0/GeuV/nR/IVgdat0HPk/MZ426A+9tNUrvgagrbylItX474oETdO
         N9TzC8eafvE5365gVFN7BzroY1aJkqcCHLUzsVerUD3hlTmbVeyjWxlZLgdZQE5LWU4V
         hwl2lxVYAiB2fc8SkvCR63JamdchDvBGrUQm41QqNAtit7Egh1yB8IUunOysDFl8on4D
         I6VyIykyORp5cf1x2KBsTQjapFvgGhm/qqBvFZg4TWqDqze93KjOVrLGpvcsPDW2NrVk
         gT//XyKso2h/S/L/VAQdtovjTCtEZXD+DF/VtAI1PtyM7OOD1fzh36b9L+JRGvlQAsWS
         fJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9N0JeXkkrz81RbDLsCzycBV5k/ABXQC2wthCCQxf7X8=;
        b=o1L4vJhu3J4UC7WSyPESM1SJ1XaLKKGDuMFdhXg9/OJyAZ67mohETn9mAA7rVNRUWd
         VuUku0qW+dPfqqkdbYlHtMB6W3U5oJwp0MlHM/oBBRCqRgA3FZ97MGSJZ0img1sbeV6x
         GgFPzWxvmrjnMSwqsDtcw85LtT0AIuz2W+Gc1lm4fTAzXHYURHRH2FfNflvI5Yx16YRO
         ZL8VIsK5VxxYZyAVkVYRC2MKpYhaSVgXmRtkjZuhmPvgd9UP78WKlZd1iz4PLOD8kpw/
         /EMh2hYI1rqhSkJ+TzSUY21fl+y2KymNPistXrZpOgAPqHsrdu9xEZ1k1kcpb8zxztf5
         Hmew==
X-Gm-Message-State: ACrzQf0R2euhXgSlHwKhxQ0E6s+RTKzEm2M6CYBP/MrBM6xNlywEmsba
        UcydtTuT6lNEX0fjzW8pHU0nFrY4BYtUYw==
X-Google-Smtp-Source: AMsMyM7KXsNzVu1IwZFo5gY3tUynBcF8BlktzUqia4vHWWQtVdXhV3NxKYZfs6YbJf6UiGyTFnXNCA==
X-Received: by 2002:a5d:588f:0:b0:231:c661:5cee with SMTP id n15-20020a5d588f000000b00231c6615ceemr441999wrf.18.1665675607186;
        Thu, 13 Oct 2022 08:40:07 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id da12-20020a056000408c00b0022a3a887ceasm2258130wrb.49.2022.10.13.08.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 08:40:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 30/34] reflog doc: list real subcommands up-front
Date:   Thu, 13 Oct 2022 17:39:24 +0200
Message-Id: <patch-v5-30.34-f8f716e6ff5-20221013T153626Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1085.gb7e61c3016c
In-Reply-To: <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
References: <cover-v3-00.34-00000000000-20221004T131009Z-avarab@gmail.com> <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "git reflog" documentation to exhaustively list the
subcommands it accepts in the SYNOPSIS, as opposed to leaving that for
a "[verse]" in the DESCRIPTION section. This documentation style was
added in cf39f54efc6 (git reflog show, 2007-02-08), but isn't how
other commands which take subcommands are documented.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-reflog.txt | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index 0537d4645be..ec64cbff4c6 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -8,14 +8,6 @@ git-reflog - Manage reflog information
 
 SYNOPSIS
 --------
-[verse]
-'git reflog' <subcommand> <options>
-
-DESCRIPTION
------------
-The command takes various subcommands, and different options
-depending on the subcommand:
-
 [verse]
 'git reflog' [show] [<log-options>] [<ref>]
 'git reflog expire' [--expire=<time>] [--expire-unreachable=<time>]
@@ -25,6 +17,10 @@ depending on the subcommand:
 	[--dry-run | -n] [--verbose] <ref>@{<specifier>}...
 'git reflog exists' <ref>
 
+DESCRIPTION
+-----------
+This command manages the information recorded in the reflogs.
+
 Reference logs, or "reflogs", record when the tips of branches and
 other references were updated in the local repository. Reflogs are
 useful in various Git commands, to specify the old value of a
@@ -33,7 +29,8 @@ moves ago", `master@{one.week.ago}` means "where master used to point
 to one week ago in this local repository", and so on. See
 linkgit:gitrevisions[7] for more details.
 
-This command manages the information recorded in the reflogs.
+The command takes various subcommands, and different options
+depending on the subcommand:
 
 The "show" subcommand (which is also the default, in the absence of
 any subcommands) shows the log of the reference provided in the
-- 
2.38.0.1085.gb7e61c3016c

