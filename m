Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 773F81FC96
	for <e@80x24.org>; Sat, 26 Nov 2016 12:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751244AbcKZMsW (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Nov 2016 07:48:22 -0500
Received: from mout.gmx.net ([212.227.15.18]:60572 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751075AbcKZMsU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Nov 2016 07:48:20 -0500
Received: from virtualbox ([37.24.142.44]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lmb2Z-1cjxLc3Vfn-00aBmN; Sat, 26
 Nov 2016 13:48:03 +0100
Date:   Sat, 26 Nov 2016 13:48:02 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Markus Klein <markus.klein@reelworx.at>
Subject: [PATCH v2 1/2] cherry-pick: demonstrate a segmentation fault
In-Reply-To: <cover.1480164459.git.johannes.schindelin@gmx.de>
Message-ID: <f1a1fbf148e1f0106f47ea0153c4eb0dfa3bd21b.1480164459.git.johannes.schindelin@gmx.de>
References: <cover.1480091758.git.johannes.schindelin@gmx.de> <cover.1480164459.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:H+nJOssTsMzejyoACh0PlUB0G7HM0VmjlZKk/D+EtaeeWYsAcRg
 XKjme5Mq35Mmf2NVU8+zUNsCf192CGDn3Du2XlloeC6RYXpc/cuqduaIFzscPWH2rYvUFN8
 ZoavURNzoBuCW3Pmk13tuxmu8IjY9ByPq7GVFcKQdfk4gQKuqbkZfvGa6Iq47xcJ1bhipPY
 gCLz9y2Y8gkS9032iyvQQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+zy2sI+5R2k=:FfgL0Aba3luF7KE5xbf6h9
 sz2JFUUm+GILAhwBO6XSTIyw48/zEX3K0jNRA9kR9POSf8p1Sx1QJFK1bmKgD5nMQAQI2O7qB
 VHPCQviLVSg44/EbKc2BRelbwYwdL1wI+2R+Zu2locgyIIAPO1hk158gldgJD8st++V/ohRAJ
 YBSkpso14WUhJLYWBPtZdp8sbbGyrNzmG/3516qY2cRPtK2vqQALgheKrdga7r2sfc8Hdc0f5
 wdjc4f0bytRqoX1L8wn/mxvCrx6755wOevlvDAiwUPju9ie+gPx2pheQZvYPKbXWLfnXar9se
 /2fHqSY3gizrx9adn9kcwyQ/9s6Ynb1R8JtDsJxQfUSA62TLmf38KLjOMEX5MG+YaH0qY1mSx
 2w6TzXJHvOnvLWtIRbPy05c9lg8DBlhvSYryxqTh0GMJpZLZKGk6gapUVbD/IjqLxDEjIDc4T
 jZt3RJ/kOOAf9g+EHU1pFzXHyTzM+miOInoB6Db4wJzj7yGfY5J8B2K98Ws8U4pGG485LJfbW
 mSyTLa3C2+ZkQ6IEo5l4eBaAL3tTfLM4q4CxUG9TuguuUrPdX0pcrt0HIyf8U4Ol7ZucJSt5Q
 hnE15xD+UioaUPCgAKnzeOqSesVD5UOVTHxuV5777MvtTYRfwq/WuBnpEC8vBB7I9BRzwzTjS
 73A38Sk0aJXAC0TA0ItdjaMHArTSnFsd4l91ybj8/3OHnxyo8xA1imQ/XRRGli1JRFD8ucrix
 eyTJokf1YPiYzRY5b3OXvnE6rgoTPlvUyeD0/D5/SzxB1FWh1NCwWgE14gvbHj0958LmUA+m+
 z1UrQyU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In https://github.com/git-for-windows/git/issues/952, a complicated
scenario was described that leads to a segmentation fault in
cherry-pick.

It boils down to a certain code path involving a renamed file that is
dirty, for which `refresh_cache_entry()` returns `NULL`, and that
`NULL` not being handled properly.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3501-revert-cherry-pick.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index 394f0005a1..d7b4251234 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -141,4 +141,16 @@ test_expect_success 'cherry-pick "-" works with arguments' '
 	test_cmp expect actual
 '
 
+test_expect_failure 'cherry-pick works with dirty renamed file' '
+	test_commit to-rename &&
+	git checkout -b unrelated &&
+	test_commit unrelated &&
+	git checkout @{-1} &&
+	git mv to-rename.t renamed &&
+	test_tick &&
+	git commit -m renamed &&
+	echo modified >renamed &&
+	git cherry-pick refs/heads/unrelated
+'
+
 test_done
-- 
2.11.0.rc3.windows.1


