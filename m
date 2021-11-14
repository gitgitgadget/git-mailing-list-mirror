Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77639C433F5
	for <git@archiver.kernel.org>; Sun, 14 Nov 2021 21:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55C1761056
	for <git@archiver.kernel.org>; Sun, 14 Nov 2021 21:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236385AbhKNV3s (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Nov 2021 16:29:48 -0500
Received: from ring.crustytoothpaste.net ([172.105.110.227]:42790 "EHLO
        ring.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236402AbhKNV3l (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Nov 2021 16:29:41 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 2119B5B482
        for <git@vger.kernel.org>; Sun, 14 Nov 2021 21:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1636925203;
        bh=Ni/ge1DWzKjZuSqrN98AmBN+T0vCmA4KSxkUeqP0zp8=;
        h=From:To:Subject:Date:From:Reply-To:Subject:Date:To:CC:Resent-Date:
         Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=arl+c/fNETwvOa70kYA5aMcsn5NR8jePRoqzGxo9O0oTwvbo2qqchydxdUDMVl7/2
         MqqehlwppuTdleF16VavPMeEn3arqwaE+gTInFNGbN0LAHV3trnWaL3ry4A1qkaRaT
         mMpt0Lr6csCezllmbZPg10zlr02GWTTeqYJxNuuGBsK42Vn3lUWLFJ+c9L+rf12jZY
         83AL7PhmD4lT/nTi/BQmM0QU+4Y0mp4+1Dd1A2k+iLlPvugTQAhqdpUT0bq+NtAmMZ
         svcZOtQShKgavL27vWcSY07P4oR4ezOySkBYqPppnfOQMiu5PmBa40CjhwW12vZB0b
         6Oe86pgzBv+IllxfJHTfjAhf98g+bH7H8O1Wk21QQV5CYGx1ZUS9tXV8rpYQoX7W/p
         A2AetBP5Zv45e2xOZxxn1U7R2hTjrtAZ0ziSniIyrj40lI/yfryUGzBgjJo8OttHv1
         lD2Uon4spwa4uqmNhAW2laHrx1ybadnqCuntC1gCbSOt3hd4AdT
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [PATCH 0/1] Add a test balloon for C99
Date:   Sun, 14 Nov 2021 21:24:36 +0000
Message-Id: <20211114212437.1466695-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The C99 standard, more formally known as ISO/IEC 9899:1999, was, as its
name suggests, was ratified in 1999, more than 20 years ago[0].  It has
a variety of nice features, including loop variable initialization, that
are available to most modern programmers.

In fact, POSIX 1003.1-2001 and the Single Unix Specification version 3,
made its use mandatory through the c99 command.  As a practical matter,
all known Unix systems which receive security support have support for
these standards or their successors, POSIX 1003.1-2018 and the Single
Unix Specification version 4, and as such, we can safely assume support
for C99 there.

Unfortunately, Microsoft for many years refused[1] to support C99 in
MSVC, and still does not officially do so.  However, they recently added
support for C11 and C17, which are sufficient for modern programming.
These require a newer version of MSVC, including an updated SDK.  The
SDK update is available for download free of charge, and most public CI
systems have support for both the updated MSVC and the SDK update.

Even for users who would like to target an older version of Windows,
such as the no longer supported Windows 7, GCC and Clang are available.
The LLVM suite, including Clang, is available pre-compiled for download
free of charge.  Using a different compiler is specifically proposed by
Microsoft staff[1] as a solution for users who wish to build modern
programs for MSVC versions which do not support modern C.

As such, we can assume that Git can be safely compiled with C99 or C11
support on all operating systems which receive security support, and
even some which do not.  Our CI confirms that this series passes all
tests.  Let's introduce a test balloon which checks for this support and
fails with an error message if it is absent.

[0] The reader will note that there are people working professionally in
this industry who were not yet born at the time C99 was ratified.  Thus,
this occurred quite a long time ago indeed.
[1] https://herbsutter.com/2012/05/03/reader-qa-what-about-vc-and-c99/

brian m. carlson (1):
  git-compat-util: add a test balloon for C99 support

 Makefile                            |  4 ++--
 contrib/buildsystems/CMakeLists.txt |  3 +--
 git-compat-util.h                   | 12 ++++++++++++
 3 files changed, 15 insertions(+), 4 deletions(-)

