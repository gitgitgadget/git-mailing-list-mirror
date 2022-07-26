Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A2DC00140
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 14:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239216AbiGZOEQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jul 2022 10:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239205AbiGZOEO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jul 2022 10:04:14 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE0C13F1C
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 07:04:13 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id h8so20289345wrw.1
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 07:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=7CIRRtMmddNd7Bj1l0Klyz5AhfG7Bq7WKgk+46UUkUE=;
        b=XpHokj9iRytrlU5fV0+/bAcSZH4/WMZJM0bV/lJP4idyKAqFfmQ0kvxGhv9Uodr/rQ
         wp1yxpd49Yb0bzK70rjgxI570huTaSYcCYcDvXcmIa/1l9qL0SBqjE0Q5Ha/eL3ni6p9
         4Ht5vXiHKBQI2eyUNwZgyYMkVYDrVAm6z7zHkMYvHNtCnMlEv4+haeNb6IwECWp1i8BP
         O50Y9rvZ5ZsZtm+RXGPC2VAt0IIWLDtzsKnrH7Igrk3P1bnc3JQ/ogKKfGrvHus8Vat5
         J1uX3gDqVlaq49ppQTSCYnGLOQyE+m5h7sEt2yzjEYFzBaTGovrp0oCz8rj+3LpFWvlX
         E22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7CIRRtMmddNd7Bj1l0Klyz5AhfG7Bq7WKgk+46UUkUE=;
        b=bIe3ZBX21RVxTWGuEfl3aXBYESpWER67KhmceiByITLfglWh8oVVOah7IhFg7fyK/3
         hc7PAu7kXDPbRLYLxxYYoUmlXu8uXb+77S5FvFXgvaZxFGlQvQSVkMy5TC9jkV13zHZD
         OD1AMksL90qWn3u0I5kC489eRP8hXA3dHawSJW7yMB8otR2pgOeUPS5ROoXu8G+Bf2ai
         +/vyVtoXYcDkgUy0taYCy17uaDK7Knwpj2oBp2AxqnPckdZ2kIkw0ncwgCFSBHgVTeWy
         izNw1eFCXBdLOYWOFgpEb7CNyGcE1kF87jklxi1X0UPcYk33qUdCHwl+SZncE03cfB28
         uxvQ==
X-Gm-Message-State: AJIora/dHR24z03wBE/VaReSST4T0JhOl49DE/EZQXonguQcumCwrZ5/
        OVUVCiuE5oAndIN6Bd8CT/OJmWIx7WM=
X-Google-Smtp-Source: AGRyM1ua9Ntjpso9I5z0rKWWnDyHCdmEPD3LOA4UuenbqeVN5chzvMDXU1LxvrP8hTiTcfpTDmSEWA==
X-Received: by 2002:a5d:4b84:0:b0:21e:b987:8837 with SMTP id b4-20020a5d4b84000000b0021eb9878837mr729402wrt.595.1658844252105;
        Tue, 26 Jul 2022 07:04:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r8-20020adfdc88000000b0021e13efa17esm14442883wrj.70.2022.07.26.07.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 07:04:11 -0700 (PDT)
Message-Id: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 26 Jul 2022 14:04:07 +0000
Subject: [PATCH 0/3] log: create tighter default decoration filter
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        steadmon@google.com, Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When running 'git log', the default is to report any refs within refs/* as
decorations. This series reduces the default set to be more specific to a
set of known-useful namespaces.

This was previously reduced by adding the log.excludeDecoration config
option and modifying that config in git maintenance's prefetch task (to hide
refs/prefetch/*). I then followed that pattern again for the bundle URI
feature [1], but this caught some reviewers by surprise as an unfortunate
side-effect. This series is a way to roll back the previous decision to use
log.excludeDecoration and instead use tighter filters by default.

[1]
https://lore.kernel.org/git/a217e9a0640b45d21ef971d6e91cee3f1993f383.1656535245.git.gitgitgadget@gmail.com/

As noted in the last patch, the current design ignores the new filters if
there are any previously-specified filters. This includes the
log.excludeDecorations=refs/prefetch/ set by the git maintenance command.
This means that users who ran that command in their repo will not get the
benefits of the more strict filters. While we stop writing
log.excludeDecorations, we don't remove existing instances of it.

I'm interested if anyone has another way around this issue, or if we
consider adding the default filter as long as no --decorate=refs options are
specified.

Thanks, -Stolee

Derrick Stolee (3):
  refs: allow "HEAD" as decoration filter
  log: add default decoration filter
  maintenance: stop writing log.excludeDecoration

 Documentation/git-log.txt |  7 ++++--
 builtin/gc.c              |  6 -----
 builtin/log.c             | 53 +++++++++++++++++++++++++++++----------
 refs.c                    |  4 +--
 t/t4202-log.sh            | 29 +++++++++++++++++++++
 t/t7900-maintenance.sh    | 21 ----------------
 6 files changed, 76 insertions(+), 44 deletions(-)


base-commit: 6a475b71f8c4ce708d69fdc9317aefbde3769e25
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1301%2Fderrickstolee%2Fdecorations-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1301/derrickstolee/decorations-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1301
-- 
gitgitgadget
