Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5FD420984
	for <e@80x24.org>; Sun, 11 Sep 2016 05:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755384AbcIKFmd (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 01:42:33 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34443 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755371AbcIKFmc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 01:42:32 -0400
Received: by mail-pf0-f193.google.com with SMTP id g202so6283025pfb.1
        for <git@vger.kernel.org>; Sat, 10 Sep 2016 22:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=sdCGs1PERpos0bp0fHN5crhkiS2ZedD7sRPQY8CDRJk=;
        b=inCMkYRgbgLBdOt0umSJQ9Mjr86ffncdRn4QcRfcXdqXIZ9jneUXCPWH6ouloUVQS5
         eQPLR/854DlFsoFDxDKATash8CenIm5UX/kSuvXspgLH+CszZ1aD+0awjfiXDARwK4Wm
         4r/Y9Qd7hDSIPbMgNVh3GzFVnu+Gh1cV4UwjuXOdFO7B3n1fbmA2SStM0Xgnxm+dQ3ht
         qNRLzX/zA9V89Qd11Lwv8QRCXiaapkfbasojjnOScdX+DUP3nlOqhb8Hp/2lcVwvgYU2
         vlCqTgi9BwTWibj/isAmpEqPIRGHEzqY4+cZ1Brt8Vol6GQ8pY/QdhQJggRvWvIGRRGB
         AXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sdCGs1PERpos0bp0fHN5crhkiS2ZedD7sRPQY8CDRJk=;
        b=GCinC/Dk4WnouNcuFn8hhwtCuam8Av9lx8935ClmF4ddGajHwvAKuaRbiQPpDixsVe
         AXcC9M2WSY1PSD3TT9DCkI99uhSwOJ1GJxpVnVbbX2ruaZlplTOGkYHBK/CAro4Wy1p8
         QGKNXDC6eTw+8yx2R6gtN3btpFZHylOoqLglSGr1daB+rBsGQKlxHceXLeSz9E5FOdjy
         Yf89Z+qkQkSIA6ptcAlcSSyMh/YerY+nFQYhoteA4wARcmYE9crRC+ZMPb5CWUbs1/wc
         zSK5n6qS9KZjqb4PXoSqq8VND9K8MhaltE9b6YtEOFi+rgaSbjyeXC4uH9mwmVhzIBWb
         0BKw==
X-Gm-Message-State: AE9vXwNqKt2zhoeJVy639VdphulAF+XITBw49Rz2HOudnk0MwlcLooHq24r0zMjHViwfeA==
X-Received: by 10.98.58.19 with SMTP id h19mr21351393pfa.125.1473572551465;
        Sat, 10 Sep 2016 22:42:31 -0700 (PDT)
Received: from localhost (c-67-188-214-183.hsd1.ca.comcast.net. [67.188.214.183])
        by smtp.gmail.com with ESMTPSA id s89sm15447302pfi.83.2016.09.10.22.42.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Sep 2016 22:42:30 -0700 (PDT)
From:   Stefan Beller <stefanbeller@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 00/10] Another preparatory series for rename detection
Date:   Sat, 10 Sep 2016 22:42:00 -0700
Message-Id: <1473572530-25764-1-git-send-email-stefanbeller@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

This applies on top of sb/diff-cleanup.

The long term strategy is to get the rename detection done, is to run
any output through emit_line as there we can either write it to the
output file or buffer it internally across file pairs and work on the
buffered output.

As I got stuck with the word diff as well as the correct implementation
of builtin_diff, I am sending this out as an intermediate state.
As the diff code is central to Git, I'd rather send these cleanups
early so I do not run into merge conflicts with other people down
the road.

Thanks,
Stefan

Stefan Beller (10):
  diff: move line ending check into emit_hunk_header
  diff: emit_{add, del, context}_line to increase {pre,post}image line
    count
  diff.c: drop tautologous condition in emit_line_0
  diff.c: rename diff_flush_patch to diff_flush_patch_filepair
  diff.c: reintroduce diff_flush_patch for all files
  diff.c: emit_line_0 can handle no color
  diff.c: convert fn_out_consume to use emit_line_*
  diff.c: convert emit_rewrite_diff to use emit_line_*
  diff.c: convert emit_rewrite_lines to use emit_line_0
  submodule.c: convert show_submodule_summary to use emit_line_fmt

 diff.c      | 114 ++++++++++++++++++++++++++++++++++++------------------------
 diff.h      |   3 ++
 submodule.c |  42 +++++++++-------------
 submodule.h |   3 +-
 4 files changed, 89 insertions(+), 73 deletions(-)

-- 
2.7.4

