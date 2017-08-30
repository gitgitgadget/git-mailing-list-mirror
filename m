Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57D4220285
	for <e@80x24.org>; Wed, 30 Aug 2017 18:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750802AbdH3S7r (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 14:59:47 -0400
Received: from siwi.pair.com ([209.68.5.199]:38930 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750756AbdH3S7r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 14:59:47 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 45FC284575;
        Wed, 30 Aug 2017 14:59:46 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id B9FB88456B;
        Wed, 30 Aug 2017 14:59:45 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     martin.agren@gmail.com
Cc:     git@vger.kernel.org, jeffhost@microsoft.com, gitster@pobox.com,
        peff@peff.net
Subject: [PATCH] hashmap: address ThreadSanitizer concerns
Date:   Wed, 30 Aug 2017 18:59:21 +0000
Message-Id: <20170830185922.10107-1-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <adb37b70139fd1e2bac18bfd22c8b96683ae18eb.1502780344.git.martin.agren@gmail.com>
References: <adb37b70139fd1e2bac18bfd22c8b96683ae18eb.1502780344.git.martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

This is to address concerns raised by ThreadSanitizer on the
mailing list about threaded unprotected R/W access to map.size with my previous
"disallow rehash" change (0607e10009ee4e37cb49b4cec8d28a9dda1656a4).

See:
https://public-inbox.org/git/adb37b70139fd1e2bac18bfd22c8b96683ae18eb.1502780344.git.martin.agren@gmail.com/

TODO  This version contains methods to disable item counting and automatic
rehashing independently.  Since the latter is implicit with the former, we
could get by with just the one, but I thought we could discuss it since it
does provide a little extra clarity of intent.


Jeff Hostetler (1):
  hashmap: add API to disable item counting when threaded

 attr.c                  | 14 ++++---
 builtin/describe.c      |  2 +-
 hashmap.c               | 31 +++++++++++-----
 hashmap.h               | 98 ++++++++++++++++++++++++++++++++++++++-----------
 name-hash.c             |  6 ++-
 t/helper/test-hashmap.c |  2 +-
 6 files changed, 113 insertions(+), 40 deletions(-)

-- 
2.9.3

