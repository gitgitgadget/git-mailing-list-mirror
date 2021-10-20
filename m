Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13448C433F5
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 01:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E73A660F9E
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 01:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhJTBJQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 21:09:16 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37026 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229686AbhJTBJQ (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 19 Oct 2021 21:09:16 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 160A860769;
        Wed, 20 Oct 2021 01:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1634691992;
        bh=UbTsTPMWAQw2Tf/DkJ6XCCL0SzZU0+a9mb1YEiyyEBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=mGcrLMYa/YlEW5QHZ+LHSvZ9YXn+Us1CjtUeUxGiE6k+xecysVWNpX099ae1vqSjB
         DxDGZ2wdCHNkp9QCb72G0AExQFLwKmY97Q4qfAK1h3ywBZA0wAPhJaP6B5jRwQ77Jl
         Qqlwnprs8GK9IzYEY+U/yMqN1Fus6oFjoniLKoP3fcTPwPTwR5lysOcLvJCQMwKdLa
         W74e6hA9qKsQobByinp2Ir+Axyar6t5bdN/GqRn9nb97ep0g/ruFEtOxG7T1BH+lZ7
         TUx5IBWDitzLGq1RT5hc7vS0XpXgPZ4Ff//gO/fL/pYEQ/GCsAQQ8H5fKV78K/FDAV
         96U2ikbbEYVi2NWor+jbrKhw+36GA+W6L1ngXiedGKd4PEGxftBiNYQUXTBHWVcimq
         4r76G9ow9x1hsI5uR0ggksc5UAP1b/LIl9aRhVo3f1M95mkM3HWJ5LPTPgLrecpTUZ
         MVlCWBQpIJnXk3nIqSr4d73jblvtL0E/PDdVe89bg1/g9CWzegM
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 1/4] gitfaq: add advice on monorepos
Date:   Wed, 20 Oct 2021 01:06:20 +0000
Message-Id: <20211020010624.675562-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2
In-Reply-To: <20211020010624.675562-1-sandals@crustytoothpaste.net>
References: <20211020010624.675562-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Many projects around the world have chosen monorepos, and active
development on Git is ongoing to support them better.  However, as
projects using monorepos grow, they often find various performance
and scalability problems that are unpleasant to deal with.

Add a FAQ entry to note that while Git is attempting improvements in
this area, it is not uncommon to see performance problems that
necessitate the use of partial or shallow clone, sparse checkout, or the
like, and that if users wish to avoid these problems, avoiding a
monorepo may be best.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/gitfaq.txt | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
index 8c1f2d5675..946691c153 100644
--- a/Documentation/gitfaq.txt
+++ b/Documentation/gitfaq.txt
@@ -241,6 +241,32 @@ How do I know if I want to do a fetch or a pull?::
 	ignore the upstream changes.  A pull consists of a fetch followed
 	immediately by either a merge or rebase.  See linkgit:git-pull[1].
 
+Design
+------
+
+[[monorepos]]
+Should we use a monorepo or many individual repos?::
+	This is a decision that is typically made based on an organization's needs and
+	desires for their projects.  Git has several features, such as shallow clone,
+	partial clone, and sparse checkout to make working with large repositories
+	easier, and there is active development on making the monorepo experience
+	better.
++
+However, at a certain size, the performance of a monorepo will likely become
+unacceptable _unless_ you use these features.  If you choose to start with a
+monorepo and continue to grow, you may end up unhappy with the performance
+characteristics at a point where making a change is difficult.  The performance
+of using many smaller repositories will almost always be much better and will
+generally not necessitate the use of these more advanced features.  If you are
+concerned about future performance of your repository and related tools, you may
+wish to avoid a monorepo.
++
+Ultimately, you should make a decision fully informed about the potential
+benefits and downsides, including the capabilities, performance, and future
+requirements for your repository and related tools, including your hosting
+platform, build tools, and other programs you typically use as part of your
+workflow.
+
 Merging and Rebasing
 --------------------
 
