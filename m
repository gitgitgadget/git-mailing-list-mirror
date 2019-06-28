Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66EAE1F461
	for <e@80x24.org>; Fri, 28 Jun 2019 22:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbfF1W75 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 18:59:57 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:56404 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726962AbfF1W7y (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 28 Jun 2019 18:59:54 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:f01a:2fd6:a95e:5f84])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7377461021;
        Fri, 28 Jun 2019 22:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1561762792;
        bh=xjTSe1NU0gagAs6yAUNobAN1oT6R968FF3aG7B68HmU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=sR1DKOONdQTbudn8VFwjtYM/M1p1k1hSTNCx7F6GSdSnH/s5ZYBzD4FqXuneFFj91
         pWmyiMFiPB4tRolNSkpM1ZADD+nrjkJAtpTd9uI8Gip93dYGx3agZ7WvPzoi7x8zoG
         L0L+vw/p6ealjEzy6pQwDDWjXP672BqoFrnXKY5M/dzL7hc2mK8JPeKiPVho4JEm1g
         TuBeHz6r9SV7zbc0nhW21/N1YTJzzXyMy0jUSVl8ogtTGg2uI0Awk9AStSRbv3rqYR
         zv2e3HIOLem4pYuASaxxC6/3b/hN7QrczO0j8Lf61HV+vCJOuClGwWM7Nl3q9m4JER
         GveySIh6AtEQExNSdWFf2zb+H/qrI+kT+CgsYXwiKWhsMM6SZqg6w+tpiG4aFJjIlU
         OMURvMMpxolNfP+hsIRcavwc6edp19JrWZhcmocqebY7bRsFE3t6kCUuYp/XeA5Cwe
         IKdRWmfkEt+XXi1GUiSW+TcijvZVunDsh+gi5KWQAaypeos3Q7U
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 10/10] t2203: avoid hard-coded object ID values
Date:   Fri, 28 Jun 2019 22:59:28 +0000
Message-Id: <20190628225928.622372-11-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.22.0.455.g172b71a6c5
In-Reply-To: <20190628225928.622372-1-sandals@crustytoothpaste.net>
References: <20190628225928.622372-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to make this test work with multiple hash algorithms, compute
the object ID used in this test instead of hard-coding it.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t2203-add-intent.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 68e54d5c44..5bbe8dcce4 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -247,12 +247,14 @@ test_expect_success 'diff-files/diff-cached shows ita as new/not-new files' '
 test_expect_success '"diff HEAD" includes ita as new files' '
 	git reset --hard &&
 	echo new >new-ita &&
+	oid=$(git hash-object new-ita) &&
+	oid=$(git rev-parse --short $oid) &&
 	git add -N new-ita &&
 	git diff HEAD >actual &&
-	cat >expected <<-\EOF &&
+	cat >expected <<-EOF &&
 	diff --git a/new-ita b/new-ita
 	new file mode 100644
-	index 0000000..3e75765
+	index 0000000..$oid
 	--- /dev/null
 	+++ b/new-ita
 	@@ -0,0 +1 @@
