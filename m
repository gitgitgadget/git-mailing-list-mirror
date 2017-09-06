Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A6DF1F4DD
	for <e@80x24.org>; Wed,  6 Sep 2017 15:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753933AbdIFPoD (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Sep 2017 11:44:03 -0400
Received: from siwi.pair.com ([209.68.5.199]:55633 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753900AbdIFPoC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2017 11:44:02 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 8F7F6845A9;
        Wed,  6 Sep 2017 11:44:01 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id E796E845A6;
        Wed,  6 Sep 2017 11:44:00 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@jeffhostetler.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jeffhost@microsoft.com,
        martin.agren@gmail.com, peff@peff.net
Subject: [PATCH v2] hashmap: address ThreadSanitizer concerns
Date:   Wed,  6 Sep 2017 15:43:47 +0000
Message-Id: <20170906154348.14287-1-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170830185922.10107-1-git@jeffhostetler.com>
References: <20170830185922.10107-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Version 2 addresses the comments and suggestions on version 1.
It removes the explicit disable/enable rehash and just relies
on the state of hashmap counting.
It changes the declaration of the hashmap_get_size() to be
static to avoid issues seen on some compilers.
It uses BUG() rather than die() for an error condition.
It adds a comment describing why lazy-init needs to disable
couting.
It fixes line length problems.
It add details from TSan in the commit message.

Jeff Hostetler (1):
  hashmap: add API to disable item counting when threaded

 attr.c                  | 15 ++++++-----
 builtin/describe.c      |  2 +-
 hashmap.c               | 26 +++++++++++-------
 hashmap.h               | 72 ++++++++++++++++++++++++++++++++++---------------
 name-hash.c             | 10 +++++--
 t/helper/test-hashmap.c |  3 ++-
 6 files changed, 88 insertions(+), 40 deletions(-)

-- 
2.9.3

