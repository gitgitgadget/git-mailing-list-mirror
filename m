Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E46C43457
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 19:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7975222C3
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 19:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388517AbgJITPc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 15:15:32 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:46852 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726118AbgJITP2 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 9 Oct 2020 15:15:28 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8AED76042C;
        Fri,  9 Oct 2020 19:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1602270926;
        bh=Q4MzRBfj+h9ERaz3jGcbVXce04TLgbr+18Jd9WHkmnU=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=JP5Ush1U7t0TqfM5qFg+hupalcTJ8RN28BKzhlMLPdynfewhCvV0nHFhnDVO8LqcF
         8Jbt7CLpBpOESUEdUKbKhXDoSHYKq/7s26pTFW3hey9AdTflDeqarmru1M2KVkvHv4
         R+fr75dsH365QZlwE9UWzOlfRiJ2XaTu0Yem9utzA5/Te2Yn1v5lqD6FtOVVaY8voy
         Qdm3eJAnpHrM8zA2fvTEnxXihOpx7v8JIxj59ZWYAeIATwzu1sm3YeN+88t8CvJuLH
         Te7RfSVsUozlaKicqisUCwA+aqFoLUU1G1Qto7Cd7Hmbz5lJ6xdt88Ydh2BYbHISZN
         X8I0+CpOqqFiB2wdXlH5qVYbXFYfOdvYs3GNLu6cflvFRmLS2XT/HdAP++yrKchaUp
         63OMsCicl/WQiK83lytRwt65PYLjE8pilwL2UscBEQOvpgQkV/sbuG2eUI4rxMmouK
         8v5TCVX87OFofuAWce7Zhwb2yAXCYCtELMuNMfgibPfKOKEEb9T
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 0/2] rev-parse options for absolute or relative paths
Date:   Fri,  9 Oct 2020 19:15:09 +0000
Message-Id: <20201009191511.267461-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are a bunch of different situations in which one would like to
have an absolute and canonical or a relative path from Git.  In many of
these cases, these values are already available from git rev-parse, but
some values only come in one form or another.

Many operating systems, such as macOS, lack a built-in realpath command
that can canonicalize paths properly, and additionally some programming
languages, like Go, currently do as well.  It's therefore helpful for us
to provide a generic way to request that a path is fully canonicalized
before using it.  Since users may wish for a relative path, we can
provide one of those as well.

Changes from v1:

* Add a function to handle missing trailing components when
  canonicalizing paths and use it.
* Improve commit messages.
* Fix broken && chain.
* Fix situation where relative paths are not relative.

brian m. carlson (2):
  abspath: add a function to resolve paths with missing components
  rev-parse: add option for absolute or relative path formatting

 Documentation/git-rev-parse.txt |  71 ++++++++++++---------
 abspath.c                       |  50 +++++++++++++--
 builtin/rev-parse.c             | 105 ++++++++++++++++++++++++++++----
 cache.h                         |   1 +
 t/t1500-rev-parse.sh            |  57 ++++++++++++++++-
 5 files changed, 237 insertions(+), 47 deletions(-)

