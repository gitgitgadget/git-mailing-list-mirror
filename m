Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81E5A1F609
	for <e@80x24.org>; Sun,  9 Jun 2019 22:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbfFIWoN (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jun 2019 18:44:13 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37544 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729692AbfFIWoN (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 9 Jun 2019 18:44:13 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1504:7263:609b:f73f])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 94EAF61B2F;
        Sun,  9 Jun 2019 22:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1560120252;
        bh=THkXpYsWQaFWlRkTvkgkbl/qnwONG7PXumiGdx2GvBM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=kRpsaqMfuMod161AkEXa/hykEeh3e1PdVQ8CYi0B8r5JoxiZVRbbJ7l/I1c5jYxu/
         5S7JvP/r9llGHjYONOyMzmCurdLzi19oH2D7M5RznFHQ3fxV6gEXEqWS0n28jzO88r
         P27Oej/QO4NlvOxiDYgloFyJf4QJsut+2O1RgAvtjeaLNlZzYMHhh6st42vaiNuFOl
         PBFHT53G26fckI2Ch6m/WQYoC6Rr6EwHm2uLYpx/JmTi6Nu4JDrbfAG8ycb/MUPdpm
         AFiF7QDrZ9iFnTYsPBb6Drita4lr3lM42DFzj3qrVPVpuOtULc0rE1gMMfYq/1+EwW
         GePULiAKe+l40MDKyoJVRnWHpQCHOA6d+1L5X4A4egzdutvnQWyAfcENBCseQ74m6y
         yNqLVOIYJbePc2y5uDj+WAtPZSe5JgDQ2cutDm6okyCgJ0bIbeidfU31ju9rCUUCEH
         VjXO0DkJo62zZHr/07ZdR8mR+5Ripf3QxtCP9ktO33wGCS7tEFe
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 01/10] t: add helper to convert object IDs to paths
Date:   Sun,  9 Jun 2019 22:43:51 +0000
Message-Id: <20190609224400.41557-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2
In-Reply-To: <20190609224400.41557-1-sandals@crustytoothpaste.net>
References: <20190609224400.41557-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are several places in our testsuite where we want to insert a
slash after an object ID to make it into a path we can reference under
.git/objects, and we have various ways of doing so.  Add a helper to
provide a standard way of doing this that works for all size hashes.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/test-lib-functions.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 8270de74be..11a6abca2e 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1314,6 +1314,12 @@ test_oid () {
 	eval "printf '%s' \"\${$var}\""
 }
 
+# Insert a slash into an object ID so it can be used to reference a location
+# under ".git/objects".  For example, "deadbeef..." becomes "de/adbeef..".
+test_oid_to_path () {
+	echo "$1" | sed -e 's!^..!&/!'
+}
+
 # Choose a port number based on the test script's number and store it in
 # the given variable name, unless that variable already contains a number.
 test_set_port () {
