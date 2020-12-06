Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F13C19437
	for <git@archiver.kernel.org>; Sun,  6 Dec 2020 22:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3B45230FA
	for <git@archiver.kernel.org>; Sun,  6 Dec 2020 22:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbgLFW42 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Dec 2020 17:56:28 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55178 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726046AbgLFW42 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 6 Dec 2020 17:56:28 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C784C60751;
        Sun,  6 Dec 2020 22:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1607295317;
        bh=r/rcpJBDrKa4cYwja4RHORYvtw7gwoH4MLdHySjk7eA=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=HiLHQd6MsGjYIbujS7/Vus7uVdiolRSTEvvAse7y83SUhSlVYris6N6Jb0Xq38Noy
         6Kjm/tVj+TuJUAhIPqIIKO9YD14sZF1UHnYA5utUu39KaEpdKizgGJcdOq4S99fEAl
         73/2MztaJO+SvFewHqWol5HBx1j60668Sz9b5wbI3gMI1hc5Ih9xYAx4V7An2nduEO
         7r5B2UuSBp3JRoh4SKrApXAU6wc+6W0FoqcExFetU7lMiXmkmpgcCfuhzf3J/N/tV+
         ipFquo5jfMyICqqg0gACLzMQ3b/IvMIXSo7VVfXqAcZvKAxA7IEI6IFqqe92zXgzyF
         2OIQdwtNMkY+Nl8aBvNmqePVTV0GeYN07TUSOwW+mOg/V3UHh3qFBYRwHPGZqa7fxD
         Ce2AlKb+NaiSJog83fCC9LHORFpF9A9B8AYk4M9QJEEaIxvkK2aJG5raJHOF5K0LgQ
         6wT5GseEO+RnHFb7597hH4iyrdiZEtVTZM3+F/vNtv+XdTUMHYV
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Subject: [PATCH v4 0/2] rev-parse options for absolute or relative paths
Date:   Sun,  6 Dec 2020 22:53:47 +0000
Message-Id: <20201206225349.3392790-1-sandals@crustytoothpaste.net>
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

 Documentation/git-rev-parse.txt |  71 +++++++++++++---------
 abspath.c                       |  13 +++-
 builtin/rev-parse.c             | 104 ++++++++++++++++++++++++++++----
 cache.h                         |   2 +
 t/t1500-rev-parse.sh            |  57 ++++++++++++++++-
 5 files changed, 203 insertions(+), 44 deletions(-)

