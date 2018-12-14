Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.5 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_96_XX,DKIM_ADSP_CUSTOM_MED,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 050CE211B4
	for <e@80x24.org>; Sun,  6 Jan 2019 15:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfAFPtu (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Jan 2019 10:49:50 -0500
Received: from mail.javad.com ([54.86.164.124]:60124 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbfAFPtt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Jan 2019 10:49:49 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 14CFA3F5AD;
        Sun,  6 Jan 2019 15:49:49 +0000 (UTC)
Authentication-Results: ip-172-31-2-110;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=sorganov@gmail.com smtp.helo=osv
Received-SPF: pass (ip-172-31-2-110: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <sorganov@gmail.com>)
        id 1ggAgN-0005rR-LY; Sun, 06 Jan 2019 18:49:47 +0300
Message-Id: <cover.1546789223.git.sorganov@gmail.com>
In-Reply-To: <xmqq5zvwesvz.fsf@gitster-ct.c.googlers.com>
References: <xmqq5zvwesvz.fsf@gitster-ct.c.googlers.com>
From:   Sergey Organov <sorganov@gmail.com>
Date:   Fri, 14 Dec 2018 07:39:03 +0300
Subject: [PATCH v3 0/4] Allow 'cherry-pick -m 1' for non-merge commits
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change from v2: t/t3502: disambiguation added to prevent failing on
case-insensitive file systems.

When cherry-picking multiple commits, it's impossible to have both
merge- and non-merge commits on the same command-line. Not specifying
'-m 1' results in cherry-pick refusing to handle merge commits, while
specifying '-m 1' fails on non-merge commits.

This patch series allow '-m 1' for non-merge commits as well as fixes
relevant tests in accordance.

It also opens the way to making '-m 1' the default, that would be
inline with the trends to assume first parent to be the mainline in
most workflows.

Sergey Organov (4):
  t3510: stop using '-m 1' to force failure mid-sequence of cherry-picks
  cherry-pick: do not error on non-merge commits when '-m 1' is
    specified
  t3502: validate '-m 1' argument is now accepted for non-merge commits
  t3506: validate '-m 1 -ff' is now accepted for non-merge commits

 sequencer.c                     | 10 +++++++---
 t/t3502-cherry-pick-merge.sh    | 12 ++++++------
 t/t3506-cherry-pick-ff.sh       |  6 +++---
 t/t3510-cherry-pick-sequence.sh |  8 ++++++--
 4 files changed, 22 insertions(+), 14 deletions(-)

-- 
2.10.0.1.g57b01a3

