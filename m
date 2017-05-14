Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 049B320188
	for <e@80x24.org>; Sun, 14 May 2017 04:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751334AbdENEB1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 May 2017 00:01:27 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:34192 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751283AbdENEB0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2017 00:01:26 -0400
Received: by mail-pg0-f47.google.com with SMTP id u28so45917294pgn.1
        for <git@vger.kernel.org>; Sat, 13 May 2017 21:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0Z3MBT0TneIedzQkQ1QMtHP31wuFdaKjoaadnIuoXuI=;
        b=RiBZ1XcXq5QmN8Ww1eHP3aXEb0ZpfJXULuVay6o+USsZzMnCJGHCmcRRMEnYKBA8K4
         AAIrsUliAfAT68UxO0tQNz94qALF2Z1M4+uRzhFIJJgKPkEafKiXa7EU0KbtD9c/tkgF
         1nBedxl5yQtJ+ihFkOIGxoLHawa03yjwlPchlNgYL8W4rQ+0gq13iPI3OoMdjsWkRbRL
         y5WGV1+ALtgpj7b3OiULBtmyjPllREumz0zsGCAWyjcY0+Rua8UM92w5l3Kepyco8Um6
         hP0hvc+FFSkp2KlA6uveNb1DPxEgVvYGFYaG7PI4LYiS9hg4ff9Jfr015UF1CAShoeoq
         kbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0Z3MBT0TneIedzQkQ1QMtHP31wuFdaKjoaadnIuoXuI=;
        b=NIt5QhSFJRG7xaSjClvnbQOSsEgqvM/UpyAvJAg2Asv8/kWWBB+4PJ862++/PDez2K
         tAqMFIXoEOyyWVa4WI0Siqb/JKnD2BRodhtgYUrjLDOpXUkrOvv4cch24r9fGyQFByn6
         XLDRCJ6+bfFDGanGm/kX/wOqVarl1u1CVMAEw6wgBYpDSr/x8mBrpvOjxlak9SVGKlM1
         tLKfiinTPSFiHhpKr8h/+hqraC2aype94ge3bS2RcjNrEKSuczJUcpVUwgDQnJX0RHHc
         RSc9w5hhitmLEncsLbwGQWODQK/B331WUOSyt+ofpoKlr6E+9Bw21jSmRX2Av/jNiyra
         Wv0Q==
X-Gm-Message-State: AODbwcAtVFre4WO4vG37kpLjem9ahP8jx6++sbr1rwfL3b+mVhJTLOPf
        nddfYvs0V88waKfE
X-Received: by 10.84.213.2 with SMTP id f2mr16085638pli.22.1494734485849;
        Sat, 13 May 2017 21:01:25 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:19fd:7796:6ff9:70d4])
        by smtp.gmail.com with ESMTPSA id s83sm12739242pfa.128.2017.05.13.21.01.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 13 May 2017 21:01:24 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, peff@peff.net, gitster@pobox.com,
        mhagger@alum.mit.edu, jrnieder@gmail.com, bmwill@google.com,
        Stefan Beller <sbeller@google.com>
Subject: [RFC PATCH 00/19] Diff machine: highlight moved lines. 
Date:   Sat, 13 May 2017 21:00:58 -0700
Message-Id: <20170514040117.25865-1-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g183880de0a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For details on *why* see the commit message of the last commit.

The first five patches are slight refactorings to get into good
shape, the next patches are funneling all output through emit_line_*.

The second last patch introduces an option to buffer up all output
before printing, and then the last patch can color up moved lines
of code.

Any feedback welcome.

Thanks,
Stefan 


Stefan Beller (19):
  diff: readability fix
  diff: move line ending check into emit_hunk_header
  diff.c: drop 'nofirst' from emit_line_0
  diff.c: factor out diff_flush_patch_all_file_pairs
  diff.c: emit_line_0 can handle no color setting
  diff: add emit_line_fmt
  diff.c: convert fn_out_consume to use emit_line_*
  diff.c: convert builtin_diff to use emit_line_*
  diff.c: convert emit_rewrite_diff to use emit_line_*
  diff.c: convert emit_rewrite_lines to use emit_line_*
  submodule.c: convert show_submodule_summary to use emit_line_fmt
  diff.c: convert emit_binary_diff_body to use emit_line_*
  diff.c: convert show_stats to use emit_line_*
  diff.c: convert word diffing to use emit_line_*
  diff.c: convert diff_flush to use emit_line_*
  diff.c: convert diff_summary to use emit_line_*
  diff.c: factor out emit_line_ws for coloring whitespaces
  diff: buffer all output if asked to
  diff.c: color moved lines differently

 Documentation/config.txt   |  12 +-
 diff.c                     | 815 ++++++++++++++++++++++++++++++++++-----------
 diff.h                     |  69 +++-
 submodule.c                |  78 ++---
 submodule.h                |   9 +-
 t/t4015-diff-whitespace.sh | 229 +++++++++++++
 6 files changed, 960 insertions(+), 252 deletions(-)

-- 
2.13.0.18.g183880de0a

