Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC04C433FE
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 18:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbiI3SMP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 14:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbiI3SLN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 14:11:13 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5995A66138
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:09:59 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id b7so387848wrq.9
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=eP+nJP+tJd2xv8J0rYfnLMDNiZkg2VWyZtcxsq+Enl4=;
        b=B+d1ZztLTyNVlXiMkQ6Us/yOv5pWj5UxJ8KaOEBSfnFTex3Tjlt/7fyiIb0lYyx5c8
         UL7bj2/5Ibe7GG2dVxNGDokrpZC6mjRIwsgqAz2nKAWRA+9F2j3JGJUJZNxvF+6cBHWr
         rghmCrF2C69OQrxGHsNoVxK1pRo4PGZFxIukVI+rpbwGnFLHM3fXtyjFsaMZxWFSF9Hm
         7gL1EKHo7uNLlg3FSK07YzgUcz/jLShUwCP2ro/FpksWV2JoxAB/G9ROqcORcrWlv+U0
         Z66HeMdPL7mi+eZdLjCtgHwMk0mNvtreOuKqNJkY3jfkcpebzMU5ZaQvzWQpe1npYNlh
         pe0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=eP+nJP+tJd2xv8J0rYfnLMDNiZkg2VWyZtcxsq+Enl4=;
        b=CyMUfOM5BRRvwUkwiAJTLcnSNTIvl5YPSdW3Z/R/mRmbloZQYKQjeOYJuSp0L12tdO
         T9uXS4IVfaIM8IHfcbjtVspOQGe1+lB2SnLbdppMaXyNSKcv+YXlxo44yWi5bHGdRL9c
         BYGRwQW9jysIh5M8GKGCJwwS56FkOTBy73BiC0zY6a/AG3By/ovC6czYBfwK12CYPOVk
         scPcrPQR6rUErAETvaN1PGCkyswV8nTrpERnL/po98qC9V52gVEK/pE6cwcAZ1F9yhk6
         GbWnkS2RolInYJR1Pi6+kOogQtxOBzlnhOMh/QiRSyAw2k/CNyiotefDB7ihUcOEY6Gv
         VnIw==
X-Gm-Message-State: ACrzQf2G+TK5zzU1MRn1nT4MTkTmt/trxYWxXXrHPePtUj184BY9pd6P
        hL0bWQEav8jSCWxVapECqMX3Ziv3XLZSTg==
X-Google-Smtp-Source: AMsMyM6U4Ygz6IE5OHzUkaieeteiQUBXC0hCIoqSfWLlZpKDf7w0cC/Gknbnq22aAUI7/WvD46eydA==
X-Received: by 2002:a05:6000:1d83:b0:22c:aa0a:12 with SMTP id bk3-20020a0560001d8300b0022caa0a0012mr6517182wrb.471.1664561397507;
        Fri, 30 Sep 2022 11:09:57 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h9-20020a1c2109000000b003b4fac020c8sm7102703wmh.16.2022.09.30.11.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 11:09:53 -0700 (PDT)
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
Subject: [PATCH v3 32/36] reflog doc: list real subcommands up-front
Date:   Fri, 30 Sep 2022 20:07:55 +0200
Message-Id: <patch-v3-32.36-81024d1c3cd-20220930T180415Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com> <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
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
2.38.0.rc2.935.g6b421ae1592

