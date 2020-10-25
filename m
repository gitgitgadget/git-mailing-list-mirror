Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FBBC5517A
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 22:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66563222EC
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 22:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1420327AbgJYWmQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Oct 2020 18:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1420323AbgJYWmP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Oct 2020 18:42:15 -0400
Received: from 0x63.nu (0x63.nu [IPv6:2a02:750:9::199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA44C061755
        for <git@vger.kernel.org>; Sun, 25 Oct 2020 15:42:15 -0700 (PDT)
Received: from ip6-localhost ([::1] helo=localhost.localdomain)
        by 0x63.nu with esmtp (Exim 4.90_1)
        (envelope-from <anders@0x63.nu>)
        id 1kWnXl-0007u5-3G; Sun, 25 Oct 2020 22:27:13 +0100
From:   Anders Waldenborg <anders@0x63.nu>
To:     git@vger.kernel.org
Cc:     Anders Waldenborg <anders@0x63.nu>, christian.couder@gmail.com,
        peff@peff.net, jonathantanmy@google.com
Subject: [PATCH 00/21] trailer fixes
Date:   Sun, 25 Oct 2020 22:26:31 +0100
Message-Id: <20201025212652.3003036-1-anders@0x63.nu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: ::1
X-SA-Exim-Mail-From: anders@0x63.nu
X-SA-Exim-Scanned: No (on 0x63.nu); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


This patch series contains a bunch fo trailer related changes. Sparked
from this thread:
  https://public-inbox.org/git/87blk0rjob.fsf@0x63.nu/T/#r3dc3e4fa67b6fba95e4b2ea2c1cf1672af55a9ee

Most commits are refactors preparing for the others, the actual user
visible changes are:
 * Allow using aliases in pretty formatting '%(trailer:key=foo)`
 * Fixes related to matching prefix rather than full trailer
 * Tighten up "canonicalization" of trailers
 * Add --(no-)canonicalize

Anders Waldenborg (21):
  trailer: change token_{from,matches}_item into taking conf_info
  trailer: don't use 'struct arg_item' for storing config
  doc: mention canonicalization in git i-t manual
  pretty: allow using aliases in %(trailer:key=xyz)
  trailer: rename 'free_all' to 'free_all_trailer_items'
  t4205: add test for trailer in log with nonstandard separator
  trailer: simplify 'arg_item' lifetime
  trailer: keep track of conf in trailer_item
  trailer: refactor print_tok_val into taking item
  trailer: move trailer token canonicalization print time
  trailer: remember separator used in input
  trailer: handle configured nondefault separators explicitly
  trailer: add option to make canonicalization optional
  trailer: move skipping of blank lines to own loop when finding trailer
  trailer: factor out classify_trailer_line
  t7513: add failing test for configured trailing line classification
  trailer: don't treat line with prefix of known trailer as known
  trailer: factor out config lookup to separate function
  trailer: move config lookup out of parse_trailer
  trailer: add failing tests for matching trailers against input
  trailer: only do prefix matching for configured trailers on
    commandline

 Documentation/git-interpret-trailers.txt |  10 +-
 Documentation/pretty-formats.txt         |   4 +-
 builtin/interpret-trailers.c             |   3 +
 pretty.c                                 |   5 +-
 t/t4205-log-pretty-formats.sh            |  18 ++
 t/t7513-interpret-trailers.sh            | 120 ++++++++
 trailer.c                                | 374 ++++++++++++++---------
 trailer.h                                |   3 +-
 8 files changed, 386 insertions(+), 151 deletions(-)

-- 
2.25.1

