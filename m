Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D0AB1F404
	for <e@80x24.org>; Mon, 11 Dec 2017 14:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753033AbdLKONs (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 09:13:48 -0500
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:34764 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752938AbdLKONq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 09:13:46 -0500
Received: from lindisfarne.localdomain ([92.22.30.250])
        by smtp.talktalk.net with SMTP
        id OOpteDPs4CbAZOOq0eBivN; Mon, 11 Dec 2017 14:13:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1513001625;
        bh=FfZnXCOvCjz/Il3B66qub+f0A1njWQEtraIlvEjkBvI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=QNZ+3FoNVL2et7eG+/MYeZQF/kZuOFfk3xuHXGDpD+e1RI/sRTdyB9iMKoEReMf+W
         FIjHNWpXWivDrYifj7cnyqqgkw1W1kAPeHpQIw32VIROY6VZiaMpdbjLmPNmAjCNB2
         J91JgdyNvXbOrc2i/XOw3/O2ZMNu3WuucYuDTvN8=
X-Originating-IP: [92.22.30.250]
X-Spam: 0
X-OAuthority: v=2.2 cv=JvuBlIwC c=1 sm=1 tr=0 a=hCO86xb6nvxPok+3LE1svw==:117
 a=hCO86xb6nvxPok+3LE1svw==:17 a=evINK-nbAAAA:8 a=1hiMVKsh0mBqE-q75WoA:9
 a=AIipHDPFeSubXdBo:21 a=UsvAgxNaHALTGGpc:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v5 1/9] t3404: check intermediate squash messages
Date:   Mon, 11 Dec 2017 14:13:22 +0000
Message-Id: <20171211141330.23566-2-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20171211141330.23566-1-phillip.wood@talktalk.net>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
 <20171211141330.23566-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfJbv1Rq5qWaPg6kOw0EmXzXYGiztue1csgev2kZpU+eg2bc1NiDVh0/0mWeLp6+upOt9CZqAAtzufqNVc8WstJ8z77xeWTvgMI9Zqir9qSyjVssN6huJ
 XlDqw7uyHTz0fIXQI67QOhCkVU2QJHDNdfrP/QfLsSUbcWF3unRtbXSrM6xzbCoslzWlkiK9C47nE1v8tisgjIFkF32zVbZyqUOFDSZvP+IlYyPpLhOSCxJu
 b+SDNi6zGQlao4dnS8O289d4NIKJtqwH5RJ1zbnQ7oeobb6iDkjLNUf5wFwosajQa7j/FNfVoOWJQ3QOGASIGBw3KbTqWIGnjX6Q9AkhW4UbSUG7r+xCNW8q
 XkN3C5IN+ELfVW5K6n3rYbJQYWPtoR1lEI1kZsk0AU5KlH88m7c=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When there is more than one squash/fixup command in a row check the
intermediate messages are correct.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3404-rebase-interactive.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 6a82d1ed876dd5d1073dc63be8ba5720adbf12e3..9ed0a244e6cdf34c7caca8232f0c0a8cf4864c42 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -453,6 +453,10 @@ test_expect_success C_LOCALE_OUTPUT 'squash and fixup generate correct log messa
 		git rebase -i $base &&
 	git cat-file commit HEAD | sed -e 1,/^\$/d > actual-squash-fixup &&
 	test_cmp expect-squash-fixup actual-squash-fixup &&
+	git cat-file commit HEAD@{2} |
+		grep "^# This is a combination of 3 commits\."  &&
+	git cat-file commit HEAD@{3} |
+		grep "^# This is a combination of 2 commits\."  &&
 	git checkout to-be-rebased &&
 	git branch -D squash-fixup
 '
-- 
2.15.1

