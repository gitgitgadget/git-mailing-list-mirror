Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CDC01FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 12:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753599AbdBHMSX (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 07:18:23 -0500
Received: from mout.gmx.net ([212.227.15.18]:56562 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753221AbdBHMSR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 07:18:17 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MLfLH-1cacFQ1yjr-000srW; Wed, 08
 Feb 2017 13:17:59 +0100
Date:   Wed, 8 Feb 2017 13:17:58 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 1/2] worktree: demonstrate data lost to auto-gc
In-Reply-To: <cover.1486556262.git.johannes.schindelin@gmx.de>
Message-ID: <674c16ee94c7609d82d14cac498ba62e5df65ab1.1486556262.git.johannes.schindelin@gmx.de>
References: <cover.1486556262.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:xw1pDyrxRAVFlaDGAHGEClhV//CXREpAueeSJMFvbFqfcsHloTh
 WdiYgexDfCoPS9L7c1oMYOcD6UBvP7jwva+w8ubL1sOC0Wzi/OKiXayHhLRMikDywtWugAp
 4pYBrsWsQJ7AXYuP0fVR2U0t1DsrvzlAO/Zfq54Jws6wHkfRKJK9+EPYiCNPbtYj89oJtLS
 6t+3p7DD2+HjIFISAqN+Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bvUH8VvXbY8=:2e0qAqa5GLzaF++TDj3y+w
 egGe6aE3GNPmm/sD3b8jDxEBi2B6NRskStPEwQVQ2697NE58V7jNF9M64MzwDP+3NHaoCRLja
 xem8LojJiXMIXeFYeNxXwhvizzi8vqE85Pie56kmYwGPQuidghZAaoSBcCs3kRV9GTR7dvXV8
 GMWIj/C90c+T78WrthvZ9+uCSYLnluLQP+kbf3esClcj0pUiexcrrwCiQUiqYhHsgXGLIzDxm
 GAgpM1sQQIAwMb3npnoMAJdQIVcc+BYGGihXP/Q8nLsyD+8aeEIlIS43jV54PWlEYRtL7R1xS
 fxQ2Z/WUnPZLYMgpJHwg8jowXD01sTjPOd022O7P7CP1pxR4HpuvELuoj4olOl/z2/wxQbbJy
 J0Rrg6tc6MzEY3QRzEWpwKq8l/YFHcU1C087RaFTCD2ewnxQHgtaLH8vOL6Ui/3mtamvYBpcO
 0McfSEGyy2CP5aV32qiZy7+Hsk4EZMS/Cr7z6ldG0eh+uL30olhlg+RFjNbtkPp8Tvsfasjud
 xw1N/jP9gJ+1scotQUlMBRP33Lki7VnE7TR6GErg21Rc3tNYTMcbWxHeZeb9tIVRoXfsaPL47
 ng3VSE/g+KfpdxYYUfXJbKYOROOKKW3QgWIbt2YCdUsh8xQGHSwMbqNPf6q8qAuehCk7ZLgiz
 fymVSv9/PAqxaCoCb0phyB+2/pcUsEj4ci8ebg3/z0YirVu6h59eCygKMbyriCSJgkdaHpkMy
 2rLLDBlFMaT2yd6en193hIjSszEvu7inQ49XTb7lJDEtIS6IfkEPSu9U+SRQ2g3hiSRHKWRmV
 ykOKtUv
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When gc --auto is called in the presence of worktrees, it fails to take
*all* reflogs into account when trying to retain reachable objects, and as
a consequence data integrity goes pretty much to hell.

This patch provides a test case in the hopes that this bug gets fixed,
after an initial attempt has stalled for eight months already.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t6500-gc.sh | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 1762dfa6a3..e24a4fb611 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -67,5 +67,44 @@ test_expect_success 'auto gc with too many loose objects does not attempt to cre
 	test_line_count = 2 new # There is one new pack and its .idx
 '
 
+trigger_auto_gc () {
+	# This is unfortunately very, very ugly
+	gdir="$(git rev-parse --git-common-dir)" &&
+	mkdir -p "$gdir"/objects/17 &&
+	touch "$gdir"/objects/17/17171717171717171717171717171717171717 &&
+	touch "$gdir"/objects/17/17171717171717171717171717171717171718 &&
+	git -c gc.auto=1 -c gc.pruneexpire=now -c gc.autodetach=0 gc --auto
+}
+
+test_expect_failure 'gc respects refs/reflogs in all worktrees' '
+	test_commit something &&
+	git worktree add worktree &&
+	(
+		cd worktree &&
+		git checkout --detach &&
+		# avoid implicit tagging of test_commit
+		echo 1 >something.t &&
+		test_tick &&
+		git commit -m worktree-reflog something.t &&
+		git rev-parse --verify HEAD >../commit-reflog &&
+		echo 2 >something.t &&
+		test_tick &&
+		git commit -m worktree-ref something.t &&
+		git rev-parse --verify HEAD >../commit-ref
+	) &&
+	trigger_auto_gc &&
+	git rev-parse --verify $(cat commit-ref)^{commit} &&
+	git rev-parse --verify $(cat commit-reflog)^{commit} &&
+
+	# Now, add a reflog in the top-level dir and verify that `git gc` in
+	# the worktree does not purge that
+	git checkout --detach &&
+	echo 3 >something.t &&
+	test_tick &&
+	git commit -m commondir-reflog something.t &&
+	git rev-parse --verify HEAD >commondir-reflog &&
+	(cd worktree && trigger_auto_gc) &&
+	git rev-parse --verify $(cat commondir-reflog)^{commit}
+'
 
 test_done
-- 
2.11.1.windows.1


