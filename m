Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4E1720756
	for <e@80x24.org>; Tue, 17 Jan 2017 21:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751288AbdAQVT2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 16:19:28 -0500
Received: from mout.gmx.net ([212.227.15.18]:49926 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750929AbdAQVT0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 16:19:26 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MBWTO-1cJBZZ1RJe-00AVFG; Tue, 17
 Jan 2017 22:19:19 +0100
Date:   Tue, 17 Jan 2017 22:19:04 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Andrew Arnott <Andrew.Arnott@microsoft.com>
Subject: [PATCH 1/2] remote rename: demonstrate a bogus "remote exists" bug
In-Reply-To: <cover.1484687919.git.johannes.schindelin@gmx.de>
Message-ID: <5b981b6f4746c7073091d432871d2abdc74d55d3.1484687919.git.johannes.schindelin@gmx.de>
References: <cover.1484687919.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:zvQqXRTlb/Ddf4Q3nQTyGTZlcea/8bgbVxOEBgwiScJkg1zdEcK
 rfv/tgwDMOVBad0eG98ARzMzz1fgZPKy7/4lnYlIdCG3Bg7fUkYKyYZEbUmXzt7O8ftPSjN
 7abhSyFZnYxlyCSz1KN2l+Fl8wNQQrmDMjKMIIy4NztLx5JtuzcPXTtVZ5O43yE3e+ccqSg
 qfFj/BGZ2Sozfl5kPCXlw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lgFN7QYkD7E=:A03OacNzNxhb89i+e6cqWu
 0I/CNKgEroUOkBmi1K1YY20hmOSJ/gcMAdvPpwCLzcKXBBD62MoqEcvPFgk/ZMGNbPAZ3LpWU
 yz34Ka/w1gCPlBwf92YDrgtaYAStEj1wTE5vPoJnWTURtIcj1fICfppjPlSL2fNfnGL+nopVb
 lfG2uVkn19jNGu6kd31tuvbEsi8GMCJRfZCntE9fLoLFKPZVUao0MZ2Yx0yb1F6/mRD5ycvp1
 /IOWU8gV6/w+EoeNKasQP3MaiwzX53b4L9hQTEsiUpYPh0eYNawXQGoF9bL+O5DETGPUAiBHH
 a2ELt0jfc8WLG7arGI0IMoC3nWsM4v9w1UuVxvgKAuQ8LJx1t9Wv5N8iX3S9+bWWHN1RgDHVZ
 NlfaAFr/X8LFsmmwGxOAWgpbENDQXVwhFt6jFozZfbFK32okrt2GPbim7QsburUJrx5n0vfus
 EpN66vStUU1PprswUh6Ru3EqdKFV1T0COFa0BIAmg5TAsFSKLSz0glAA69M/OmKLRTm2e5eUB
 yNxJZiTbKG/suoRF6eqz378VIXAhZkc0ayV39PyOMXSll5LlE31hpHeBYAN2c3wkWYtcyNtzM
 R6ikxJ13I0xfJGKhBNXOaII//omhud8isXK/ZATl+ohAkk0uLnWrB6w64X9KXkZTEoCP8ikLf
 Md8rMdI7Hln5sOxk5QpqI1P5kT25R9p9KB492S4uqTgj7g4l/lfnaM2Fg3/8SlG2loDvA4CZz
 7JTLtTFduNrUrjeieM3PltvcAS/xLhuZiIdK0eEz7E8vcZBkmu2d4bIokARTE0Wx+l3F4ky4a
 h1RVUNi
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some users like to set `remote.origin.prune = true` in their ~/.gitconfig
so that all of their repositories use that default.

However, our code is ill-prepared for this, mistaking that single entry to
mean that there is already a remote of the name "origin", even if there is
not.

This patch adds a test case demonstrating this issue.

Reported by Andrew Arnott.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5505-remote.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 8198d8eb05..d7e41e9230 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -764,6 +764,15 @@ test_expect_success 'rename a remote with name prefix of other remote' '
 	)
 '
 
+test_expect_failure 'rename succeeds with existing remote.<target>.prune' '
+	git clone one four.four &&
+	(
+		cd four.four &&
+		git config remote.upstream.prune true &&
+		git remote rename origin upstream
+	)
+'
+
 cat >remotes_origin <<EOF
 URL: $(pwd)/one
 Push: refs/heads/master:refs/heads/upstream
-- 
2.11.0.windows.3


