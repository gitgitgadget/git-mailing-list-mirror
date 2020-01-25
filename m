Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB06C35242
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 23:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAC8D2071A
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 23:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Mt5WdfPL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbgAYXA6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jan 2020 18:00:58 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:46848 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728921AbgAYXAv (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Jan 2020 18:00:51 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DF4F661480;
        Sat, 25 Jan 2020 23:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1579993250;
        bh=qiXeR3I6MrYypMX7KdxsNEvxvHHwLgtN8R0bzFpPt/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Mt5WdfPLyWKfeQoBbramsso66zj6P7JNvLRaY1Z5MEma0s2I+qteDxsxw+On/fq0P
         rZwyyAnAwPnSjl9DnuGCsQ3bfMpjzwZNcuNX5BtgzIeNb0DFTom6NaxTtK77yniBkn
         Kk3q2UwNz4cb2AY2VgUTve6KXGLogK85EsSWHB86fR6UXXQZxE4ShnlNqfQuSLE69h
         L7Y3VuZlf2v2kOpVplsJop3hg3RbOndYpt1vi8q4R1L0NXG1oS7i7sYyIKIj0fo7sF
         rggvDMgvq3aCkozmlBRlSBLsmBThw93MmlsuIoNIA6lgmWlDgOHHY+Olxr0hdf99I8
         WO6rN0CC6n1hwlsgj3E+ZjIAQX2nG9/X0JBjKVRQx1YzodJfZ9XGlHgVAB9V1Kv5Xa
         X06Bz5+a4lpZ3A0ZgP4EjHqVCF5Wc6piNist349wDpa/E9IYauZgvYFx3JEsxWFyQT
         a+wup7TXY0pH88n3DyFRQlwpw7RkYtCwpS6yU3RDz9F4N89Qwkz
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 18/22] t5703: make test work with SHA-256
Date:   Sat, 25 Jan 2020 23:00:26 +0000
Message-Id: <20200125230035.136348-21-sandals@crustytoothpaste.net>
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
