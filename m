Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_06_12,DKIM_ADSP_CUSTOM_MED,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF3C020A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 13:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729797AbeLNNF4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 08:05:56 -0500
Received: from mail.javad.com ([54.86.164.124]:53912 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbeLNNF4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 08:05:56 -0500
X-Greylist: delayed 575 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Dec 2018 08:05:55 EST
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id EA9913FBE9;
        Fri, 14 Dec 2018 12:56:19 +0000 (UTC)
Authentication-Results: ip-172-31-2-110;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=sorganov@gmail.com smtp.helo=osv
Received-SPF: pass (ip-172-31-2-110: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <sorganov@gmail.com>)
        id 1gXn0s-00039z-GB; Fri, 14 Dec 2018 15:56:18 +0300
Message-Id: <cover.1544762343.git.sorganov@gmail.com>
In-Reply-To: <xmqq5zvwesvz.fsf@gitster-ct.c.googlers.com>
References: <xmqq5zvwesvz.fsf@gitster-ct.c.googlers.com>
From:   Sergey Organov <sorganov@gmail.com>
Date:   Fri, 14 Dec 2018 07:39:03 +0300
Subject: [PATCH v2 0/4] Allow 'cherry-pick -m 1' for non-merge commits
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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

