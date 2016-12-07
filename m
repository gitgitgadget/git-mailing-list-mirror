Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB35A1FF7F
	for <e@80x24.org>; Wed,  7 Dec 2016 21:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932987AbcLGVwK (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 16:52:10 -0500
Received: from mout.gmx.net ([212.227.17.22]:53448 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933148AbcLGVwC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 16:52:02 -0500
Received: from fermat.fritz.box ([92.76.239.239]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LorB9-1cqrEE1HxL-00gluT; Wed, 07
 Dec 2016 22:51:57 +0100
From:   Stephan Beyer <s-beyer@gmx.net>
To:     git@vger.kernel.org
Cc:     Stephan Beyer <s-beyer@gmx.net>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 3/5] Add test that cherry-pick --abort does not unsafely change HEAD
Date:   Wed,  7 Dec 2016 22:51:31 +0100
Message-Id: <20161207215133.13433-3-s-beyer@gmx.net>
X-Mailer: git-send-email 2.11.0.27.g4eed97c
In-Reply-To: <20161207215133.13433-1-s-beyer@gmx.net>
References: <20161207215133.13433-1-s-beyer@gmx.net>
In-Reply-To: <xmqqlgvs28bh.fsf@gitster.mtv.corp.google.com>
References: <xmqqlgvs28bh.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:WKiPYQu3e0vXfjFODA7TFhILAItpuuF/YzbBN3GsAiO3FyeV16O
 epbqPZkbTNVvr54tFpTWHu7LihpdJFo5OjvqExqfYoIPuZ33a7ljhMqisAriNbMIh2tgSeB
 3JQew63Xv7YkTzCrGQt25pm+k3B+TbVYrh8vqTm6BvUIgE/5dKbcpdxkdJXuPFvttnokwLF
 jnrpDIFwj8Txmx85NzcKg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qPWHmVh21pY=:6pYgmLyzpgNBHynNsmAlTg
 Qxrw35lgEbvBOc9Qcac/b8IAkN4iXiX9p94C9H+J0HGMRsqzRHV3bYn/xlCgLVNBb1E0IjJ4f
 fDRCH+KtfYRGZX3HIWqxQKs092hOqrUENbqQmlE2H9D/3YIauikKpDSzPZE5AyxNpjhTuJdSv
 oszrf85guVYRKt+0vhTxrroecigKY5ipYXQBGHSr843DibzL565cOnwZrW0wZ76Ph1ok5r++n
 MmTBp+tls7hnMMIC3OfJALlbgT8c3LH61oLbbzZmMcxRJApidSnHVwqw/2JR0MdqSA+tux6Qn
 398iZLGUFTLjkDIMrLKCeOcgohMOTIDiOkKlanXH/9UkJWX+xrX82MnAZanCCAkfZnYSc5LA4
 pdzoNyHczD4m6I558I7LKCcRdAXASs25w9cRViH55bq7X0ZoixwZqkmV3R4ckh1FsiuldtNdr
 oLkXQW1gCGzwqt5VvoglWVQuyzhe8H/RneswLmcFK9bWoDTwyMNqMYujuOBTov0sytLp6ZV1e
 +cLLbTZQptWyBUQ3sWC3R4OpwdmYHfEv59m7kOTpCLtmTMEG3cb2SmE1iSGYGqPcXKMPZVGwu
 p2j+rhHbe31SZLZn3X0Ni7usgxgD6YPiRNSAkMcQ0VGcTGRxUYnu61WEIvfDD7SUSj1B4bogG
 /dLy4d0Q01Uizqx98NWujMPsBm2Z2YkyRTSTjxhiQif4A/Zv0hSXIAe1Z+Gzjb8I8MRgi55iD
 aR4CpSClJl/N71B7sZU5VubFI2zMi3pFrYZiiENBtsgT5LryE8Sl3fm4PqM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 t/t3510-cherry-pick-sequence.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 7b7a89dbd..372307c21 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -147,6 +147,16 @@ test_expect_success '--abort to cancel single cherry-pick' '
 	git diff-index --exit-code HEAD
 '
 
+test_expect_success '--abort does not unsafely change HEAD' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick picked anotherpick &&
+	git reset --hard base &&
+	test_must_fail git cherry-pick picked anotherpick &&
+	git cherry-pick --abort 2>actual &&
+	test_i18ngrep "You seem to have moved HEAD" actual &&
+	test_cmp_rev base HEAD
+'
+
 test_expect_success 'cherry-pick --abort to cancel multiple revert' '
 	pristine_detach anotherpick &&
 	test_expect_code 1 git revert base..picked &&
-- 
2.11.0.27.g4eed97c

