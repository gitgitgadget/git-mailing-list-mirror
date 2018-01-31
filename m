Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 537E41F404
	for <e@80x24.org>; Wed, 31 Jan 2018 21:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753292AbeAaVnZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 16:43:25 -0500
Received: from mail-ua0-f177.google.com ([209.85.217.177]:43527 "EHLO
        mail-ua0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752098AbeAaVnX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 16:43:23 -0500
Received: by mail-ua0-f177.google.com with SMTP id i5so10448834uai.10
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 13:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=V2cfL4mHvxu1G0rUwcJzkxXpzczHMj36svnWkNXbz/o=;
        b=CirQfPDD/uobD995j1lOVSmWSbX5fGZwNj091GuqPAmg9XTp6DB9WtxgUOntHQRsB9
         9VFQjHhG0txvN7KQQznn1cZRlDCTlwtOtwhj3CZYWHF/dXRKFjesnkSyDZwEiJQFZYmx
         1oOrew9eTc6mDenSIY7MTxE4iUEkGfLNNh9lUJEW7D+IdvHoQT3bPM08lz8D+CVBpjOX
         yfTT40djI/mgnpEmpv0U3It62JLZSLCp5bbu/DBxihuNufvS2/LUfPVoSzIXxXlNolqr
         ZCP2ybsQMcBJseDznDyaSri0JvjctSDToYf5CPQ6Gi+6S9R72GJgvYR9IDn7qcnncIhh
         B/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=V2cfL4mHvxu1G0rUwcJzkxXpzczHMj36svnWkNXbz/o=;
        b=CTSyZgwIjq6T0LSeJLEqYEf6j9HSZjZXnZjpKSdDabQONje2qhgTmq8mjm15Mgtu+d
         l6vrl1PlGddgLBYzTP4/XoMeV7O6HEg2zBmn15Lavbqvv0wswF36wgJz7/QKhmb0sDio
         rR1rK5LpOI1yKBbhwF/e8zeacCbYMv9H37rKBvNNkee+1jzZ4En7ff+6EZ/NMtrBsrK2
         p1iXixyS5KOd5JQNiWUb/o6sO5xvBeVa+2p7L1M1yrT05CL2oIW5KVsdfPb5U7mhHlv4
         shJgYT61EG0nm995ZxSbn7K+l2a77/Mzz5XhdED5cfWg/f3bgaTVKxWfqyUXxKX19ALt
         X2tw==
X-Gm-Message-State: AKwxytdHlt+MGNy3awutAZ4XNxROb8AiwW0BhUGmSC1ODNHK6m848WsG
        VC7Y5WAdgb5q3Cv8yTWFu+sy24HMjiJj5dXKBpcyCQ==
X-Google-Smtp-Source: AH8x227r0ISTEohwBn513gRsrBx75vrTKrGdYkHH1ROBh64DNb+R14YTRkuIaRzQK5nyWHhMxP+3dTqMPdAKl5xRWjg=
X-Received: by 10.176.25.230 with SMTP id r38mr27387112uai.2.1517435002821;
 Wed, 31 Jan 2018 13:43:22 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.80.148 with HTTP; Wed, 31 Jan 2018 13:43:02 -0800 (PST)
From:   Ayke van Laethem <aykevanlaethem@gmail.com>
Date:   Wed, 31 Jan 2018 22:43:02 +0100
Message-ID: <CAHZoaj41k0AU-S1cPH3p6gU6EzXfYiMasN7=Cv9SRd2xp=1ThA@mail.gmail.com>
Subject: Segmentation fault in git cherry-pick
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I've found a segmentation fault in git.

Here, fabsf is a branch that I'm trying to get the topmost commit from.
After the failed cherry-pick, the change is added to the local working
tree, but the commit isn't applied and .git/index.lock still exists.

Version: 2.11.0 (Debian stretch)

~/src/micropython/ports/nrf$ valgrind git cherry-pick fabsf
==23286== Memcheck, a memory error detector
==23286== Copyright (C) 2002-2015, and GNU GPL'd, by Julian Seward et al.
==23286== Using Valgrind-3.12.0.SVN and LibVEX; rerun with -h for copyright info
==23286== Command: git cherry-pick fabsf
==23286==
==23286== Invalid read of size 4
==23286==    at 0x21A348: add_index_entry_with_check (read-cache.c:1012)
==23286==    by 0x21A348: add_index_entry (read-cache.c:1061)
==23286==    by 0x1FAE85: merge_content (merge-recursive.c:1727)
==23286==    by 0x1FBAAC: process_entry (merge-recursive.c:1885)
==23286==    by 0x1FBAAC: merge_trees (merge-recursive.c:1948)
==23286==    by 0x23E2F7: do_recursive_merge (sequencer.c:389)
==23286==    by 0x23E2F7: do_pick_commit (sequencer.c:757)
==23286==    by 0x23FB52: single_pick (sequencer.c:1329)
==23286==    by 0x23FB52: sequencer_pick_revisions (sequencer.c:1378)
==23286==    by 0x1874CE: run_sequencer (revert.c:178)
==23286==    by 0x187927: cmd_cherry_pick (revert.c:203)
==23286==    by 0x11A204: run_builtin (git.c:373)
==23286==    by 0x11A204: handle_builtin (git.c:572)
==23286==    by 0x11A5A1: run_argv (git.c:630)
==23286==    by 0x11A5A1: cmd_main (git.c:707)
==23286==    by 0x1195D1: main (common-main.c:40)
==23286==  Address 0x38 is not stack'd, malloc'd or (recently) free'd
==23286==
==23286==
==23286== Process terminating with default action of signal 11 (SIGSEGV)
==23286==  Access not within mapped region at address 0x38
==23286==    at 0x21A348: add_index_entry_with_check (read-cache.c:1012)
==23286==    by 0x21A348: add_index_entry (read-cache.c:1061)
==23286==    by 0x1FAE85: merge_content (merge-recursive.c:1727)
==23286==    by 0x1FBAAC: process_entry (merge-recursive.c:1885)
==23286==    by 0x1FBAAC: merge_trees (merge-recursive.c:1948)
==23286==    by 0x23E2F7: do_recursive_merge (sequencer.c:389)
==23286==    by 0x23E2F7: do_pick_commit (sequencer.c:757)
==23286==    by 0x23FB52: single_pick (sequencer.c:1329)
==23286==    by 0x23FB52: sequencer_pick_revisions (sequencer.c:1378)
==23286==    by 0x1874CE: run_sequencer (revert.c:178)
==23286==    by 0x187927: cmd_cherry_pick (revert.c:203)
==23286==    by 0x11A204: run_builtin (git.c:373)
==23286==    by 0x11A204: handle_builtin (git.c:572)
==23286==    by 0x11A5A1: run_argv (git.c:630)
==23286==    by 0x11A5A1: cmd_main (git.c:707)
==23286==    by 0x1195D1: main (common-main.c:40)

Note: I'm not subscribed to this mailing list.

--
Ayke
