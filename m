Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECF7C433E0
	for <git@archiver.kernel.org>; Sat, 27 Feb 2021 19:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F73564E46
	for <git@archiver.kernel.org>; Sat, 27 Feb 2021 19:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhB0TWD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Feb 2021 14:22:03 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58964 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230335AbhB0TU6 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 27 Feb 2021 14:20:58 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2659560DF4;
        Sat, 27 Feb 2021 19:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1614453573;
        bh=u0hSAMaAawt+ck4OscplryMv2VIafnCmwxyFnjUgbEc=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=XeNeduAWPEZG1yWwmiNlejGA5fgO7sHVXyKOK2as2xLCkxULw9MQhGZm6jDd7Ab9o
         UkDo1z1PSjlhjmyiNRKG9sua5pyfVEqVXvRndzGvAuSL0cTdWYGI4ssST4ecDWHFX3
         zLpANY6n8NbQVHQ0e+tPK8dJCu9SIC9tzdXNgfwxXHhzkVcLv9mMPgNQdCZKXkPeMo
         xWifXyJU7ZbKGElP/YqlANroJcvUkGUA3KHWFu1a4BZJkFcFYRij0y8Tr4iQZ6hoH5
         OO6CbNxtY3XGk87ydk6Sv3mJyIS4TkoKk7CyBL7t45MygKXHxO9Bt8ydqrhDqGA//n
         XAAJhlPcZpWd0vUdh5jp1x2YHFp4R1mXS8HPT6r2wle5DydOSRUv5Fa942gXUWnuwb
         c+G9yMJ67k+VazPlrzzt19cFL6FcGQAiie1zk4Qw/yNZOYJIvEMIApPdQ0ViWDcold
         nE+RrKQJD95m47oIEw8s+Bz8NqYLAK90kMtvA/xG9T3Vo0pGZHP
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 0/4] Documentation updates to FAQ and git-archive
Date:   Sat, 27 Feb 2021 19:18:09 +0000
Message-Id: <20210227191813.96148-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.30.1.721.g45526154a5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series introduces several new FAQ items and an update to the
git-archive documentation.

The first three patches introduce FAQ entries for questions I've seen
extremely frequently on Stack Overflow.  Since clearly users are seeing
these problems, we should update our documentation to address them and
help users find clear and accurate solutions.

I realize that suggesting people share a working tree across systems is
controversial, but people are doing it, so let's tell them how to do it
safely.  Users frequently use things like Dropbox, OneDrive, iCloud, and
similar cloud syncing services to do this and then wonder why things are
broken or their repository is corrupted.  We tell them that
POSIX-compliant file systems should be used and give examples of what we
know does and doesn't work, and we tell them about the security pitfalls
of untrusted working trees.

The third patch addresses several common situations with HTTP pushes and
fetches.  The majority of these problems are going to be with TLS MITM
devices, intercepting and filtering proxies of various sorts, and
non-default antivirus and firewalls, all of which security experts
steadfastly recommend against.  We don't do so here (yet), but we do
explicitly call them out as potential sources of problems and we
encourage users to report these problems to vendors and network
administrators so that they can be addressed.

The fourth patch states a fact which we've been explicit about on the
list but have never documented: that the output of git archive is not
stable.  I do recall that I sent a patch breaking kernel.org's
infrastructure in the past due to a change in archive output and I'd
like to avoid other folks relying on bit-for-bit identical output.

brian m. carlson (4):
  docs: add a question on syncing repositories to the FAQ
  docs: add line ending configuration article to FAQ
  docs: add a FAQ section on push and fetch problems
  docs: note that archives are not stable

 Documentation/git-archive.txt |   3 +
 Documentation/gitfaq.txt      | 176 +++++++++++++++++++++++++++++++++-
 2 files changed, 178 insertions(+), 1 deletion(-)

