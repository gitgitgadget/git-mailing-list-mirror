Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D69C2D0DB
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 18:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF3FE21739
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 18:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgA0S7p convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 27 Jan 2020 13:59:45 -0500
Received: from bonobo.elm.relay.mailchannels.net ([23.83.212.22]:7266 "EHLO
        bonobo.elm.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725845AbgA0S7p (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Jan 2020 13:59:45 -0500
X-Sender-Id: dreamhost|x-authsender|novalis@novalis.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id BF64B5E2C00;
        Mon, 27 Jan 2020 18:59:43 +0000 (UTC)
Received: from pdx1-sub0-mail-a83.g.dreamhost.com (100-96-8-110.trex.outbound.svc.cluster.local [100.96.8.110])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 002A15E27F8;
        Mon, 27 Jan 2020 18:59:42 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|novalis@novalis.org
Received: from pdx1-sub0-mail-a83.g.dreamhost.com ([TEMPUNAVAIL].
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.18.5);
        Mon, 27 Jan 2020 18:59:43 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|novalis@novalis.org
X-MailChannels-Auth-Id: dreamhost
X-Slimy-Coil: 0d11349262fa83d8_1580151583410_2156726127
X-MC-Loop-Signature: 1580151583410:213464788
X-MC-Ingress-Time: 1580151583410
Received: from pdx1-sub0-mail-a83.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a83.g.dreamhost.com (Postfix) with ESMTP id 9094F82D5D;
        Mon, 27 Jan 2020 10:59:37 -0800 (PST)
Received: from localhost.localdomain (unknown [172.98.67.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by pdx1-sub0-mail-a83.g.dreamhost.com (Postfix) with ESMTPSA id 7265E82D46;
        Mon, 27 Jan 2020 10:59:36 -0800 (PST)
X-DH-BACKEND: pdx1-sub0-mail-a83
From:   David Turner <dturner@twosigma.com>
To:     git@vger.kernel.org
Cc:     David Turner <dturner@twosigma.com>
Subject: [PATCH] Make git rm submodule succeed if .gitmodules index stat info is zero
Date:   Mon, 27 Jan 2020 13:58:56 -0500
Message-Id: <20200127185856.2619317-1-dturner@twosigma.com>
X-Mailer: git-send-email 2.11.GIT
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-VR-OUT-STATUS: OK
X-VR-OUT-SCORE: 0
X-VR-OUT-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrfedvgdduudejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuggftfghnshhusghstghrihgsvgdpffftgfetoffjqffuvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeffrghvihguucfvuhhrnhgvrhcuoeguthhurhhnvghrsehtfihoshhighhmrgdrtghomheqnecuffhomhgrihhnpehpuhgslhhitgdqihhnsghogidrohhrghenucfkphepudejvddrleekrdeijedrleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhppdhhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpedujedvrdelkedrieejrdelfedprhgvthhurhhnqdhprghthhepffgrvhhiugcuvfhurhhnvghruceoughtuhhrnhgvrhesthifohhsihhgmhgrrdgtohhmqedpmhgrihhlfhhrohhmpeguthhurhhnvghrsehtfihoshhighhmrgdrtghomhdpnhhrtghpthhtohepughtuhhrnhgvrhesthifohhsihhgmhgrrdgtohhm
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The bug was that ie_match_stat was used to compare if the stat info
for the file was compatible with the stat info in the index, rather
using ie_modified to check if the file was in fact different from the
version in the index.

A version of this (with deinit instead of rm) was reported here:
https://public-inbox.org/git/CAPOqYV+C-P9M2zcUBBkD2LALPm4K3sxSut+BjAkZ9T1AKLEr+A@mail.gmail.com/

It seems that in that case, the user's clone command left the index
with empty stat info.  The mailing list was unable to reproduce this.
But we (Two Sigma) hit the bug while using some plumbing commands, so
I'm fixing it.  I manually confirmed that the fix also repairs deinit
in this scenario.

Signed-off-by: David Turner <dturner@twosigma.com>
Reported-by: Thomas Bétous <th.betous@gmail.com>
---
 submodule.c   | 2 +-
 t/t3600-rm.sh | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/submodule.c b/submodule.c
index 9da7181321..86e46d3dce 100644
--- a/submodule.c
+++ b/submodule.c
@@ -82,7 +82,7 @@ int is_staging_gitmodules_ok(struct index_state *istate)
 	if ((pos >= 0) && (pos < istate->cache_nr)) {
 		struct stat st;
 		if (lstat(GITMODULES_FILE, &st) == 0 &&
-		    ie_match_stat(istate, istate->cache[pos], &st, 0) & DATA_CHANGED)
+		    ie_modified(istate, istate->cache[pos], &st, 0) & DATA_CHANGED)
 			return 0;
 	}
 
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 0ea858d652..f2c0168941 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -425,6 +425,13 @@ test_expect_success 'rm will error out on a modified .gitmodules file unless sta
 	git status -s -uno >actual &&
 	test_cmp expect actual
 '
+test_expect_success 'rm will not error out on .gitmodules file with zero stat data' '
+	git reset --hard &&
+	git submodule update &&
+	git read-tree HEAD &&
+	git rm submod &&
+	test_path_is_missing submod
+'
 
 test_expect_success 'rm issues a warning when section is not found in .gitmodules' '
 	git reset --hard &&
-- 
2.11.GIT

