Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D63351F404
	for <e@80x24.org>; Fri, 20 Apr 2018 12:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754792AbeDTMSO (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 08:18:14 -0400
Received: from mout.gmx.net ([212.227.17.20]:52131 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754726AbeDTMSO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 08:18:14 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mhdex-1engkk1dqd-00Mvwq; Fri, 20
 Apr 2018 14:18:09 +0200
Date:   Fri, 20 Apr 2018 14:17:53 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 1/3] rebase -i: demonstrate bug with fixup!/squash! commit
 messages
In-Reply-To: <cover.1524226637.git.johannes.schindelin@gmx.de>
Message-ID: <ad2a1b2c60341d692e94b1cb997df05dd7cded88.1524226637.git.johannes.schindelin@gmx.de>
References: <cover.1524226637.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:z0eOnGHdMkFNGJowGgUXAlnOMQ3QlYb6Pj382BR+BNG3XvLMWpQ
 CjpBL4vaHkxt6NzRIxBbmf4urAwrpucgk8Apy5MP05nptVGnGNe6mPP/kgSWZAfAD2ID/9c
 6GSPl9WQf7wVb8HJcOEt57zKGODm4UoVbmBfuJNWAa/lyPn/gk/1hDy48bRmvP1/MIjQL8b
 /aRJ5ypPakPbL4ns0LBxg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9aGaRbhULUk=:vvWluzSpWlZl44bkFUnJTC
 CLeQwzbSH/EWiy/X8N9gX6L2ZSJKDFVtFX8w3TV23oq6N4Si9G0DETEsVdJ/jIOfwvzaV6fVq
 9e564WyTEfQOQzwxhG0AW0zm8Lu4O11RfnoYC3uJq/M/QWsUC48F32/42TVZkEXGPyXtzAPb/
 5RO19GCYZrHvsJPh3wTY4QKU3AJiNSmwxYkVwxVmqbBNh+GRTVJTtHriYfT3quhV3CrVG2Q8q
 z5XgVmgSl2SkahnrhnjTlwQKvWHN1ftCwzZ6SLZuVHDbqBu/wUxKE0xinW/l4rAVVCy0aLCvy
 uXOq2CInciDmX4o/puV4wtnJU3CcE9UtG6kH8x3Q1z1b+YjHAw+Ju/zWvNM7ZCEa6x1D5Q1jO
 xflAWDQxzcs3mOW3JC4jsfD8Wqu8ZbujWFrCNNVFBy/98gPSBvOSC6GaYiuvV409Vv88ngLZe
 8PrMx5hSBUi2x8yQcpz1AfrAZWQQRS+PYQ1uwgBvnzYmNlulNzunf6yWjuNul0kXJOAeoD3IZ
 bmGkM18lYT7WG+KMc5jQoBnS0X2ve+jpS0qM+P+y1ia6Ypu8H4ehxOt8WpAesEY6nCNOJJncZ
 lWGPOjMrDyVPqOYh7AimR/UlARZau3UhDYUdR9OgckO95amDe1g9kWSZVko+Ddqj5noj08aXF
 RwJeDD41dBP45h1R+gkFuR6IsVnTh7dpfiZHgdXF13RpUMtkTByAhkO0ivRAXhc72Hnykfz2V
 rRNYaSfzaRb7m6xEdqsPYhxMvfpXxKHz5L9ei8WbD83eI9E4uBit1MnO9+XFvAbNX+i3D754w
 /COxV5nXW/Vmk3HN1w2FR35f8kBHF7siVfzL3nvpTojk9m2hpk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When multiple fixup/squash commands are processed and the last one
causes merge conflicts and is skipped, we leave the "This is a
combination of ..." comments in the commit message.

Noticed by Eric Sunshine.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3418-rebase-continue.sh | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 9214d0bb511..b177baee322 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -88,6 +88,27 @@ test_expect_success 'rebase passes merge strategy options correctly' '
 	git rebase --continue
 '
 
+test_expect_failure '--continue after failed fixup cleans commit message' '
+	git checkout -b with-conflicting-fixup &&
+	test_commit wants-fixup &&
+	test_commit "fixup! wants-fixup" wants-fixup.t 1 wants-fixup-1 &&
+	test_commit "fixup! wants-fixup" wants-fixup.t 2 wants-fixup-2 &&
+	test_commit "fixup! wants-fixup" wants-fixup.t 3 wants-fixup-3 &&
+	test_must_fail env FAKE_LINES="1 fixup 2 fixup 4" \
+		git rebase -i HEAD~4 &&
+
+	: now there is a conflict, and comments in the commit message &&
+	git show HEAD >out &&
+	grep "This is a combination of" out &&
+
+	: skip and continue &&
+	git rebase --skip &&
+
+	: now the comments in the commit message should have been cleaned up &&
+	git show HEAD >out &&
+	! grep "This is a combination of" out
+'
+
 test_expect_success 'setup rerere database' '
 	rm -fr .git/rebase-* &&
 	git reset --hard commit-new-file-F3-on-topic-branch &&
-- 
2.17.0.windows.1.15.gaa56ade3205


