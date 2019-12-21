Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF70C2D0C3
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 19:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F4D5206B7
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 19:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Tdne4emt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfLUTuL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 14:50:11 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41988 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727358AbfLUTuJ (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 21 Dec 2019 14:50:09 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 04EA660787;
        Sat, 21 Dec 2019 19:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1576957809;
        bh=a6HCmWXgmSxqY8mSmrSRfWUuJ7fKEpDN9ih76ul8/ew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Tdne4emtxTF3lNYOdNW3IVwBIdXsj72cdvEXaoIdRzYSZqWqgvpP00FBXutmLT6Yi
         iDU25CcGR+VKVhJ+jK6n8XzDcWAdKBI7WhJWBFdf8Wf236eglxAwpmfaxQhCp1TxFz
         4/cJH6wzsBZ8bbHG7G0cL7cbuvwoLXcoFbzecSR558M02SSmcFtA9vzFBYeQMnA+RZ
         iBw1OGX50FIWbA4d+MIIwXpuHMsPXDEmm6gM3U4GAVkuMC9xp2vp9cO3Fs4IkN2RKQ
         g44/Eb7y1T/SSkKLxgqZQis4i7EBWpnVDbHGrXh0YMqOG5KDxgO4lkW0Np6EOlfBz8
         3R0Y5Op0KHeY5v4ZKjHwcS8P3e8pSGKXAXZwyJdIBzcjoqk1VXwsoudFLBVUnd+pxc
         Rfv4lRYJaLtzhldI+ycfb+hQvenbUiUUruELfK+MvNa2b69wCnA4AQGBB/okbPmTiF
         DlIZmkIrMwWQvXVwJs4Mr3MaGk1bPV91iiuXN7dLC8FdLEURH+a
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 08/20] t5318: update for SHA-256
Date:   Sat, 21 Dec 2019 19:49:24 +0000
Message-Id: <20191221194936.1346664-9-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.24.1.658.g99f4b37f93
In-Reply-To: <20191221194936.1346664-1-sandals@crustytoothpaste.net>
References: <20191221194936.1346664-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When running with SHA-256 as the hash algorithm, the hash version octet
is 2 instead of 1.  Pick the right value depending on the hash algorithm
and use it where we look for the existing value.  To ensure the test
checking for invalid data passes, use 3 as the test value for an invalid
hash version.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t5318-commit-graph.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 3f03de6018..81cf118cb6 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -481,7 +481,7 @@ test_expect_success 'detect bad version' '
 '
 
 test_expect_success 'detect bad hash version' '
-	corrupt_graph_and_verify $GRAPH_BYTE_HASH "\02" \
+	corrupt_graph_and_verify $GRAPH_BYTE_HASH "\03" \
 		"hash version"
 '
 
