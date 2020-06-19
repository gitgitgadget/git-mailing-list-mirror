Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20267C433DF
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F41C020776
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="SU3Nrll5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394116AbgFSR46 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:56:58 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39508 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404586AbgFSR4i (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 13:56:38 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2B8EC60A74;
        Fri, 19 Jun 2020 17:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592589393;
        bh=POwUn8s/1JQRZ58gbQ+WBHHk/Mx/QgCRkJQxxE8tgNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=SU3Nrll5ux/q92tWrFGJKNvAjny+l4p49Vw6Jnfi//EJY4c2dZQzik3FpD11utYxi
         0ZRbz5fBlfi2pCfsS+NnUMlI1Coq52qfovBr9a2W9sfFUDD8welHUdcBF+1KIPGlgA
         jPhdNUzCJzL7dL8dCt0wwuhE2jX0SMngQ46zjvmja8upEwPbLmlT1urUsmRI37PoK/
         81Hj+ZqTEh0pfIQ04uwCTt+WF1Joyr4djm9c75mqVoeCXwY+66hXDevRCKDExAU6PO
         TYpUmXw031RTsYcWG4I4JYZGl9UFO1kePGVaot/R+egdh0ZIonixDvOJksrz528FOv
         ImYy5dnlFMI1Pf4eHrDuYrGD9GGelWbMs5ci/aPNK04ZRF0pNLw4m5sGnheRjFWSpU
         Nj8BFOx6rd/e3CRuUPN0PPMWjoGs12fN+SdXhMetpxtZvfAJJPGwc37XxS+ZD1QTIJ
         F9PkqV2FTEwVE3KgqgsnOQHFZEWYCBE9Mg4vrY/zzdh2ojXMJVj
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v3 39/44] t5702: offer an object-format capability in the test
Date:   Fri, 19 Jun 2020 17:55:56 +0000
Message-Id: <20200619175601.569856-40-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9
In-Reply-To: <20200619175601.569856-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
 <20200619175601.569856-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to make this test work with SHA-256, offer an object-format
capability so that both sides use the same algorithm.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t5702-protocol-v2.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 8da65e60de..63f425bbad 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -13,6 +13,7 @@ start_git_daemon --export-all --enable=receive-pack
 daemon_parent=$GIT_DAEMON_DOCUMENT_ROOT_PATH/parent
 
 test_expect_success 'create repo to be served by git-daemon' '
+	test_oid_init &&
 	git init "$daemon_parent" &&
 	test_commit -C "$daemon_parent" one
 '
@@ -394,6 +395,7 @@ test_expect_success 'even with handcrafted request, filter does not work if not
 	# Custom request that tries to filter even though it is not advertised.
 	test-tool pkt-line pack >in <<-EOF &&
 	command=fetch
+	object-format=$(test_oid algo)
 	0001
 	want $(git -C server rev-parse master)
 	filter blob:none
