Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E83921F859
	for <e@80x24.org>; Sat, 10 Sep 2016 15:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754513AbcIJPFQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Sep 2016 11:05:16 -0400
Received: from mail2.tiolive.com ([94.23.229.207]:58010 "EHLO
        mail2.tiolive.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754237AbcIJPFQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Sep 2016 11:05:16 -0400
Received: from teco.navytux.spb.ru (unknown [178.70.98.236])
        by mail2.tiolive.com (Postfix) with ESMTPSA id 4647CBF0319;
        Sat, 10 Sep 2016 17:05:14 +0200 (CEST)
Received: from kirr by teco.navytux.spb.ru with local (Exim 4.87)
        (envelope-from <kirr@teco.navytux.spb.ru>)
        id 1bijqD-00055I-Id; Sat, 10 Sep 2016 18:05:13 +0300
From:   Kirill Smelkov <kirr@nexedi.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Vicent Marti <tanoku@gmail.com>,
        =?UTF-8?q?J=C3=A9rome=20Perrin?= <jerome@nexedi.com>,
        Isabelle Vallet <isabelle.vallet@nexedi.com>,
        Kazuhiko Shiozaki <kazuhiko@nexedi.com>,
        Julien Muchembled <jm@nexedi.com>, git@vger.kernel.org,
        Kirill Smelkov <kirr@nexedi.com>
Subject: [PATCH] t/perf/run: Don't forget to copy config.mak.autogen & friends to build area
Date:   Sat, 10 Sep 2016 18:05:12 +0300
Message-Id: <20160910150512.19473-1-kirr@nexedi.com>
X-Mailer: git-send-email 2.9.2.701.gf965a18.dirty
In-Reply-To: <20160910145738.x6ihp2gqzpk7dbi3@teco.navytux.spb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Otherwise for people who use autotools-based configure in main worktree,
the performance testing results will be inconsistent as work and build
trees could be using e.g. different optimization levels.

See e.g.

	http://public-inbox.org/git/20160818175222.bmm3ivjheokf2qzl@sigill.intra.peff.net/

for example.

NOTE config.status has to be copied because otherwise without it the build
would want to run reconfigure this way loosing just copied config.mak.autogen.

Signed-off-by: Kirill Smelkov <kirr@nexedi.com>
---
 ( Resending as separate patch-mail, just in case )

 t/perf/run | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/perf/run b/t/perf/run
index cfd7012..aa383c2 100755
--- a/t/perf/run
+++ b/t/perf/run
@@ -30,7 +30,7 @@ unpack_git_rev () {
 }
 build_git_rev () {
 	rev=$1
-	cp ../../config.mak build/$rev/config.mak
+	cp -t build/$rev ../../{config.mak,config.mak.autogen,config.status}
 	(cd build/$rev && make $GIT_PERF_MAKE_OPTS) ||
 	die "failed to build revision '$mydir'"
 }
-- 
2.9.2.701.gf965a18.dirty
