Return-Path: <SRS0=hy0J=4K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDA9C35666
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 20:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 030A5206ED
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 20:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="f7rvxvm+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgBVUSI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Feb 2020 15:18:08 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39084 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726845AbgBVUSI (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 22 Feb 2020 15:18:08 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5CFBE6079B
        for <git@vger.kernel.org>; Sat, 22 Feb 2020 20:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1582402686;
        bh=B7jZ7OcAT1p+IaD8zAaRDzP9f1o69d30rknV3o2Vajo=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=f7rvxvm+o5zoG0WuVxMapnsxtA83McVKvtrkrDMi3nHDehXGuksrpRpY2bJxILF8v
         RG6o0dRh9drnrUqEf2BXXecSpi+TQsDyGrKk7T13arMYSOht5J0h9OaNSIklyA0m5M
         fUXsPm1okXLNqeaSsDY5nd14UCWukU9RS9VGKlgCAONj6uL3NunjmQCgps74KVxF6C
         13t95BQZu8MD1Pm4kcIV2nunRed0eDBKwxrcXwJMxc5Xp6F2EHBaQ7VaRbHxXQ638m
         pwhfBCd0dHOB4onnPWLFIl9JNWHByFvgt+pFl5XaR0T6YPae1CXTAMX78Ml4NKXRKX
         nqDC7+N4R5mIy9jtjLCZxvVlsfSHPqd4eBu8nyzpxYYFdvJEPA0S8s7xMHh7mGKz15
         wKrl9lFBI+AqbSMD0wp1KFoJyjnGdxGzx9Jhx1BNEf78j/Ss24f9gzMUQMexKvBRry
         x043xnC+4pBjTpvSGufXWf1BMqYGDUJvND0DHS24HiAaVdePkpw
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [PATCH v2 07/24] t6300: abstract away SHA-1-specific constants
Date:   Sat, 22 Feb 2020 20:17:32 +0000
Message-Id: <20200222201749.937983-8-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801
In-Reply-To: <20200222201749.937983-1-sandals@crustytoothpaste.net>
References: <20200222201749.937983-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the test so that it computes variables for object IDs instead of
using hard-coded hashes.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t6300-for-each-ref.sh | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 9c910ce746..2406b93d35 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -20,6 +20,10 @@ setdate_and_increment () {
 }
 
 test_expect_success setup '
+	test_oid_cache <<-EOF &&
+	disklen sha1:138
+	disklen sha256:154
+	EOF
 	setdate_and_increment &&
 	echo "Using $datestamp" > one &&
 	git add one &&
@@ -50,6 +54,9 @@ test_atom() {
 	"
 }
 
+hexlen=$(test_oid hexsz)
+disklen=$(test_oid disklen)
+
 test_atom head refname refs/heads/master
 test_atom head refname: refs/heads/master
 test_atom head refname:short master
@@ -82,9 +89,9 @@ test_atom head push:rstrip=-1 refs
 test_atom head push:strip=1 remotes/myfork/master
 test_atom head push:strip=-1 master
 test_atom head objecttype commit
-test_atom head objectsize 171
-test_atom head objectsize:disk 138
-test_atom head deltabase 0000000000000000000000000000000000000000
+test_atom head objectsize $((131 + hexlen))
+test_atom head objectsize:disk $disklen
+test_atom head deltabase $ZERO_OID
 test_atom head objectname $(git rev-parse refs/heads/master)
 test_atom head objectname:short $(git rev-parse --short refs/heads/master)
 test_atom head objectname:short=1 $(git rev-parse --short=1 refs/heads/master)
@@ -125,11 +132,11 @@ test_atom tag refname:short testtag
 test_atom tag upstream ''
 test_atom tag push ''
 test_atom tag objecttype tag
-test_atom tag objectsize 154
-test_atom tag objectsize:disk 138
-test_atom tag '*objectsize:disk' 138
-test_atom tag deltabase 0000000000000000000000000000000000000000
-test_atom tag '*deltabase' 0000000000000000000000000000000000000000
+test_atom tag objectsize $((114 + hexlen))
+test_atom tag objectsize:disk $disklen
+test_atom tag '*objectsize:disk' $disklen
+test_atom tag deltabase $ZERO_OID
+test_atom tag '*deltabase' $ZERO_OID
 test_atom tag objectname $(git rev-parse refs/tags/testtag)
 test_atom tag objectname:short $(git rev-parse --short refs/tags/testtag)
 test_atom head objectname:short=1 $(git rev-parse --short=1 refs/heads/master)
@@ -139,7 +146,7 @@ test_atom tag parent ''
 test_atom tag numparent ''
 test_atom tag object $(git rev-parse refs/tags/testtag^0)
 test_atom tag type 'commit'
-test_atom tag '*objectname' 'ea122842f48be4afb2d1fc6a4b96c05885ab7463'
+test_atom tag '*objectname' $(git rev-parse refs/tags/testtag^{})
 test_atom tag '*objecttype' 'commit'
 test_atom tag author ''
 test_atom tag authorname ''
