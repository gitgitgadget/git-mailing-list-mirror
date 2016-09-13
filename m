Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0B9F20996
	for <e@80x24.org>; Tue, 13 Sep 2016 00:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751438AbcIMAZ6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 20:25:58 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:55802 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750975AbcIMAZ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 20:25:58 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 3DFF4207DF;
        Tue, 13 Sep 2016 00:25:57 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     Yaroslav Halchenko <yoh@onerussian.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: [RFC 0/3] http: avoid repeatedly adding curl easy to curlm
Date:   Tue, 13 Sep 2016 00:25:54 +0000
Message-Id: <20160913002557.10671-1-e@80x24.org>
In-Reply-To: <20160909221942.GS9830@onerussian.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(I have some hours online today, so I decided to work on this)

The key patch here is 3/3 which seems like an obvious fix to
adding the problem of adding a curl easy handle to a curl multi
handle repeatedly.

What is unclear to me is how only Yaroslav's repository seems to
trigger this bug after all these years...

However, I am fairly sure this fixes the bug Yaroslav
encountered.  This patch series is also needed for 2.9.3 and
perhaps older maintenance tracks for distros.

In PATCH 2/3, I originally had error checking, but removed it
after noticing it was causing failures on wheezy.

I will investigate those failures in a week or two when I regain
regular computer access.

These patches are needed for 2.9.x (and probably earlier), too.

The following changes since commit cda1bbd474805e653dda8a71d4ea3790e2a66cbb:

  Sync with maint (2016-09-08 22:00:53 -0700)

are available in the git repository at:

  git://bogomips.org/git-svn.git dumb-http-release

for you to fetch changes up to 3f561d0f0f78fd841708b5e81122e9d825919fd3:

  http: always remove curl easy from curlm session on release (2016-09-12 23:59:35 +0000)

----------------------------------------------------------------
Eric Wong (3):
  http: warn on curl_multi_add_handle failures
  http: consolidate #ifdefs for curl_multi_remove_handle
  http: always remove curl easy from curlm session on release

 http.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

-- 
EW
