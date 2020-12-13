Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C05C433FE
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 00:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A8FB224DE
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 00:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439947AbgLMA1Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Dec 2020 19:27:24 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:59286 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726267AbgLMA1E (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 12 Dec 2020 19:27:04 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 32B9660769;
        Sun, 13 Dec 2020 00:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1607819151;
        bh=AHxtBVZPZxtmi2WhE9DpDBC+M5GWgtvzN95vvntvXzU=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=oYSTlLTSAZTBEUchK/GjzyuP/8rOAKvkfrhWopz/Ylx8VEyg13xuaow0js16evsPX
         hs+wi20yUxxWqQCTYDP6ZvC+3ZmtVrKusvOFeqD8uznnOuNrMs/rTmfhlUB88esKkr
         2BwXBDarseiTeVEh65bsoYzkPJu7RTy4JOLRYlVlxdvi0IK0qjv9FdpPsT3zTIsjfc
         Lhj5kh0dJTMRRTJOLSreKIiRmC/NLMxx9iDg/X5d+CNzB8/e37pBzET5F6sJL1jaII
         Y8xytmIfqlQq0Ja3FJHg/YmPlGMEssEHzgAYJqHHN5toBqQ//ODYnXLkyxriguTU4h
         RTBLt481BEzmSSGV/ro+AuLxvVUBJgwui5Pcg/1NpUBwHtm/pnHs81ppk+3gg02sij
         uENJXi6THtw7+vYnyVCWV5j4SSEYfY00HMvzye7LZ7Zpy+XhBs90UISN+TBhris17R
         J2QZrgh3TypqDlpRe66jjB/JyWlQm1Wiule3oMvQCEygu3zBSBL
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v5 0/2] rev-parse options for absolute or relative paths
Date:   Sun, 13 Dec 2020 00:25:27 +0000
Message-Id: <20201213002529.542928-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are a bunch of different situations in which one would like to
have an absolute and canonical or a relative path from Git.  In many of
these cases, these values are already available from git rev-parse, but
some values only come in one form or another.

Changes from v4:

* Wrap an internal function.
* Use bitflags.
* Fix memory leaks.
* Explain that --path-format can be specified multiple times and its
  effects if that is done.
* Expand commit message.

Changes from v3:

* Switch to a binary option instead of a number of missing path
  components to skip.

Changes from v2:

* Incorporate multiple missing segment support into the strbuf_realpath
  code.
* Switch some invocations to use DEFAULT_UNMODIFIED, which should not
  result in a change in behavior.
* Rebase, resolving some conflicts.

Changes from v1:

* Add a function to handle missing trailing components when
  canonicalizing paths and use it.
* Improve commit messages.
* Fix broken && chain.
* Fix situation where relative paths are not relative.

brian m. carlson (2):
  abspath: add a function to resolve paths with missing components
  rev-parse: add option for absolute or relative path formatting

 Documentation/git-rev-parse.txt |  74 +++++++++++++---------
 abspath.c                       |  64 +++++++++++++------
 builtin/rev-parse.c             | 106 ++++++++++++++++++++++++++++----
 cache.h                         |   2 +
 t/t1500-rev-parse.sh            |  57 ++++++++++++++++-
 5 files changed, 242 insertions(+), 61 deletions(-)

