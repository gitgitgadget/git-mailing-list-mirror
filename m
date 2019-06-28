Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D054F1F461
	for <e@80x24.org>; Fri, 28 Jun 2019 22:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfF1W7i (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 18:59:38 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:56292 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726863AbfF1W7h (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 28 Jun 2019 18:59:37 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:f01a:2fd6:a95e:5f84])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 11D39609C5;
        Fri, 28 Jun 2019 22:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1561762776;
        bh=u7JaaqB0a0zD6+4CoHGB2AgaV2yPYitcdG7sWCFWZqs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=OmdSm51QAWz+OwXJlTcowmZwBRRva3c9hNNa2P6VrU8P0Yw1YVPgOmnIlAqAPi/H1
         6tv0Rh1PIJE8tITADMDmQPZBstptTnHKTFldmmCEHJpSJBMU6QQwoP8xCvHz4k4EMS
         4jKI63RKloreLvFA/u91qCPb9ZADKqGl38af7xsT4iYLill21UFATBlKHfCq8qexn3
         6OFOKtpHOl/vsE/jRpuvDe9EnDf6eFQg9rzk0cM85yVQz0sZtgxxeRgHisGu4Ja+Qs
         I2Vi81m4mtrM6WCM+MulsG/XO7zs1ZgfAR3qZfBnaE9aQtSNHgj1ldZ4L8gdcCEbus
         i5EQqYd/ejIwjdpF2eS0q8YlBT6IhJwox2W3JTZKdWhd22tUG22ZV6Talz1VzWmHMZ
         Unxmm+5msq0Wh6NG+zG5FpsBhWSQjyhzJXD3EnVXXxhL/n9jzFOcdqVvwRziR47zTr
         tyayaXa/xuHS3RnSq6CcLaJ2NNZJPi6EpgFdeQg6vlCRcbw+ng3
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 01/10] t: add helper to convert object IDs to paths
Date:   Fri, 28 Jun 2019 22:59:19 +0000
Message-Id: <20190628225928.622372-2-sandals@crustytoothpaste.net>
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

There are several places in our testsuite where we want to insert a
slash after an object ID to make it into a path we can reference under
.git/objects, and we have various ways of doing so.  Add a helper to
provide a standard way of doing this that works for all size hashes.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/test-lib-functions.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 0367cec5fd..7860491660 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1334,6 +1334,12 @@ test_oid () {
 	eval "printf '%s' \"\${$var}\""
 }
 
+# Insert a slash into an object ID so it can be used to reference a location
+# under ".git/objects".  For example, "deadbeef..." becomes "de/adbeef..".
+test_oid_to_path () {
+	echo "${1%${1#??}}/${1#??}"
+}
+
 # Choose a port number based on the test script's number and store it in
 # the given variable name, unless that variable already contains a number.
 test_set_port () {
