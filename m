Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23BDC35242
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 23:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9FEB2075E
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 23:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="bXSVHKda"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbgAYXBK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jan 2020 18:01:10 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:46846 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727817AbgAYXAv (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Jan 2020 18:00:51 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5634A61484;
        Sat, 25 Jan 2020 23:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1579993250;
        bh=qiXeR3I6MrYypMX7KdxsNEvxvHHwLgtN8R0bzFpPt/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=bXSVHKdawVabm0jwj3G9hNl7Vw8CaqKhLnNSu+31a3cFFDjyQnNiOx4/sib1yrXki
         H74jqjLTSs2D+JNvaOO9fcVs8mYg9itJpWGuKNugYj7t7LrCtfiQeQlFgNJsDI6JNn
         ZVj575MXPfjLTfYyQb7yg2m4UsK/NQ9qMLA9aqYpmk48EJlWWic9Eb/RrdjE2+QKD/
         hTlPgKPIttznAFNZUUKNPznWWIIsl+rO+cz8LEynBaujTXeYCj9jDdcR1PY10RNVTF
         n9AGnQXrhq8SXgV0e6L4CVRmwAVM4U0W4v5aZjKng8B297qQLwoLaJ+u4ivmzwsGI7
         6IMxMnCaxwaV5GOQxLzrq0cjTHtT+lADGlMscJkmkBse9OR2Hsq2s4w7s55sbAHiIF
         zkOaxKxcguIHsO8Qent73bptn3WufndCiGHyoHnzQQ2+8yc1fDtsmmp3pFSiwhUgDR
         6PFYs3l8qw5Ho28Wr38IROjjJWqkN3WEe0kAzZVi1Ju03JaWDt4
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 19/23] t5703: make test work with SHA-256
Date:   Sat, 25 Jan 2020 23:00:27 +0000
Message-Id: <20200125230035.136348-22-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.24.g3f081b084b0
In-Reply-To: <20200125230035.136348-1-sandals@crustytoothpaste.net>
References: <20200125230035.136348-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test used an object ID which was 40 hex characters in length,
causing the test not only not to pass, but to hang, when run with
SHA-256 as the hash.  Change this value to a fixed dummy object ID using
test_oid_init and test_oid.

Furthermore, ensure we extract an object ID of the appropriate length
using cut with fields instead of a fixed length.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t5703-upload-pack-ref-in-want.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
index 1424fabd4a..5511cdcec2 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -19,7 +19,7 @@ get_actual_commits () {
 		}' <out | test-tool pkt-line unpack-sideband >o.pack &&
 	git index-pack o.pack &&
 	git verify-pack -v o.idx >objs &&
-	grep commit objs | cut -c-40 | sort >actual_commits
+	grep commit objs | cut -d" " -f1 | sort >actual_commits
 }
 
 check_output () {
