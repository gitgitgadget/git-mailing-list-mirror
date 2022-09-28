Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B977DC04A95
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 08:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbiI1ImJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 04:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbiI1IkO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 04:40:14 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D65A407F
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:40:10 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id s14so18714270wro.0
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=5SRmslHy2wprv4kLuHbQFIp6EEnfQY4wokviAS9ZVTw=;
        b=oXXe78v2Al3w2Jb6+ZCwc8aXmdxuNQayg/FaPXXiDsl7XsEUFQBDl4KWTS5Gq7v/Up
         BbAHURo00/A+Ty18f7l8zDrw5ScGIcjtMT9encagy+5OQkqSwT9fWYIP4qAHipVvfj+p
         gbpHmwBGNmy3nkHDqF1gB8LP5wI3+4uLeA0I7gzMlXwx9QSF9qf5s1eseVK262DG7s4H
         NDd+uOfOwIJGzrTjhyFer5G8RxPu3BL/zDspYmufq06td2VVbChmqtPV2doBH+LSaubQ
         WScB5CXw2fz4H4Pia+Q8grQg3jBOLkwNcAvL0g7mVAiB7YU0mMCvgMKR3d74qgpbpB15
         vOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=5SRmslHy2wprv4kLuHbQFIp6EEnfQY4wokviAS9ZVTw=;
        b=WKgvy20At1/Wkz14k12qIBShFwxmMvfsS1lslewwSq6pmtbGLBXOfdwsCluFkxxSsA
         XuwzQm3uhHUj0TvJaaBWwVevgetPXXEYyeFjEMk2vNDKfRMI1EglopKVTjHitQbs3XBM
         InZEB3kub7DAl/aSkwV5xzzzhBhj7D9b9h+4nnlcwtTmJMMStgwPFErY4uPvYt9xqoD7
         iAJOnUO31AAKTPjuHYygNUUbSKGLTUhKlVNA4LddU3Ah/TiXG7F8ekYNwfmKdHrQFvMo
         V/DrZao0lNvBgh3GTaKI43g1pysVpIzI5GI1nz0LEYsFu6z97NxveDbRkVZKbIgD15D3
         Up9A==
X-Gm-Message-State: ACrzQf32I94MIbvffhAXQZLh7P1Bme6k5Z6b4oR607hDsdgxMZsd+8JT
        rZdh0r+lptLpBpZ77d3/BrMlf8dx4wZJ+A==
X-Google-Smtp-Source: AMsMyM6c+NSotQ2SWbQB+JkcDRem9mGjL+9Ap2l1lrqsAFZLkBoFNDKaddud8qY0GOfQOctcEiyUZw==
X-Received: by 2002:adf:cd10:0:b0:22c:a109:f51d with SMTP id w16-20020adfcd10000000b0022ca109f51dmr10591899wrm.238.1664354409285;
        Wed, 28 Sep 2022 01:40:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c229a00b003b31fc77407sm1075026wmf.30.2022.09.28.01.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 01:40:08 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 31/35] reflog doc: list real subcommands up-front
Date:   Wed, 28 Sep 2022 10:39:26 +0200
Message-Id: <patch-v2-31.35-61a3c002690-20220928T082458Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.925.gb61c5ccd7da
In-Reply-To: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com> <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
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
2.38.0.rc1.925.gb61c5ccd7da

