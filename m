Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6365D1F424
	for <e@80x24.org>; Fri, 27 Apr 2018 20:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759269AbeD0Usc (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 16:48:32 -0400
Received: from mout.gmx.net ([212.227.17.22]:51707 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759261AbeD0Us2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 16:48:28 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0LtDpH-1eDu6p20zr-012ndA; Fri, 27 Apr 2018 22:48:20 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v4 1/4] rebase -i: demonstrate bugs with fixup!/squash! commit messages
Date:   Fri, 27 Apr 2018 22:48:16 +0200
Message-Id: <49b9f6562e3fd32f1dab706de29057d536d3d2de.1524862093.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.33.gfcbb1fa0445
MIME-Version: 1.0
In-Reply-To: <cover.1524862093.git.johannes.schindelin@gmx.de>
References: <CAPig+cRrS0_nYJJY=O6cboV630sNQHPV5QGrQdD8MW-sYzNFGQ@mail.gmail.com> <cover.1524862093.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:QbfiICyHY/aDtALvBzSIVc82NgPDI1+5oHALZb3yDq4Jx6Jdaki
 mvMrCshO+CiGgfpzT4R0pvXjltv8JiV1kFZIAkRSVkg3jxxvxdp1sR08O7ecokYUwTNiWBA
 q85mPKSdbaGn6X1dNAutdLgQ5d2aKvvlTJhbgyJbr7rdYZx1NL+yXqQ9G62x3xI9gumz1bA
 T4FnoboI1yb5QvJ+r7nXQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ceVB1Sf88TM=:PDbiJ8GiEWzRLjVWXdDsk3
 6uIMIEc18IaA2F7r6ttdgvQE527dtXxBRrUMe8gf2L98KF+8WDcLIjSF0DV1wrzz7vOigpW1C
 fnwwTaBALd8ebPNygpmqGd0jvlNX+meSQfXkY3J6evy9xX7mABltUXwanblM+B69kJAbtJ+Ho
 6UGsfQgTdDBI/ubYfd4jiTHpLLtsgoHKQOm8CSN5Vxf4wz3O1h8uOVAe8hJfo4ysHSKLKv4k6
 zvseyDRS1sppy5Uvoq8/E755CbO+ObcdLWVT4aGjgkugIsf9t+dJ7ACGNJw+AwUnEe90rt8Ls
 bv+az66488IE3UljzQMQKLsAwJq123Yifwe82oswjOMajzilveES+U8qdukaVctBnS2Z90n/o
 eQTaIDrNZ0ZvUCQdzuXf+ej5sVCJDk/R6thv7DPIkbHVb2hHuxpQ5XhKJRLsbSL5ENeAVOyhm
 zf661EL/Cd8qc3mwIAS+GcT7ut3Smt5M8N6VB0pedd4/r3d1n869MXU39coHurKZ66FWKhMuI
 BDKoFpbnLO6iRkBmDeM8Bc2n18VTggcbw25f8NwtSLMDqOKMl0cKe4NFtcBvCe+G7YlYqziWK
 FbPZD/aUHOEykuzOU3PR7Hgqu16CPR2u9N9QX0uzq110I72b3Sms/dmWqnXL4S5FoDbHOEZTq
 fBsn90yXLKadg0Lc5dbbp1OR2gr/BwxlkFUQl9lBCBiVsk1W2lycroyxXDBHtS9BfPTKb1g1d
 1Cq7YHl5SZTUb4XhmWAorUYT9eyf/5N2qDhBD6yMzuAtCchHxxS1vRREzrmBop7gI/zpeRrtY
 weN3ucC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When multiple fixup/squash commands are processed and the last one
causes merge conflicts and is skipped, we leave the "This is a
combination of ..." comments in the commit message.

Noticed by Eric Sunshine.

This regression test also demonstrates that we rely on the localized
version of

	# This is a combination of <number> commits

to contain the <number> in ASCII, which breaks under GETTEXT_POISON.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3418-rebase-continue.sh | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 9214d0bb511..3874f187246 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -88,6 +88,28 @@ test_expect_success 'rebase passes merge strategy options correctly' '
 	git rebase --continue
 '
 
+test_expect_failure '--skip after failed fixup cleans commit message' '
+	test_when_finished "test_might_fail git rebase --abort" &&
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
+	grep "fixup! wants-fixup" out &&
+
+	: skip and continue &&
+	git rebase --skip &&
+
+	: now the comments in the commit message should have been cleaned up &&
+	git show HEAD >out &&
+	! grep "fixup! wants-fixup" out
+'
+
 test_expect_success 'setup rerere database' '
 	rm -fr .git/rebase-* &&
 	git reset --hard commit-new-file-F3-on-topic-branch &&
-- 
2.17.0.windows.1.33.gfcbb1fa0445


