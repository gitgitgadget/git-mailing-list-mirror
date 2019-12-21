Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A3BC2D0C3
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 19:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A1FE206B7
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 19:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="lBNNnOyL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbfLUTuI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 14:50:08 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41966 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727145AbfLUTuH (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 21 Dec 2019 14:50:07 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3BACC607F2;
        Sat, 21 Dec 2019 19:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1576957806;
        bh=r2tV6BQwbbIAolSCiUgyYPke9rmwMsCGcsq6XheiC7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=lBNNnOyL/FDX0T5JkV0Ax95GyzaVRYy1WelwUfsXRRNL41casrhUE1gfk/M4l8E1l
         o/kkxyFEmHitbl9OlhNcPj6udm8qPhTjaTR7CC9EQgybk3RLCPzF3rNGq9456R2QpA
         tIPWzHuq4g4a35eciB2lgOfhy4glxZ2qF3IFAq/TKiEagqHaraVfEs4PfODEDyxzFj
         O2vtcxZpA/sDMMaR9kV+eLhW4cyF+GW2P6vfZTVm0a3AttcJXU/iH9FiJNKX7PLnAY
         rlkwqjys1OZj9qlz+cW+W5YIiLpdA13OyXpLqn57GIKT+ab48Tl7o9jojigFsd7niX
         wrjJBYOGZ9eO81BY1wQjnF8YrecVb5cuZ5LBtBL/f/RE3jZ+x2wn6l79Pl1rlhdyUq
         zYtGUVBOruhlQLUe/kMz3su8ivG8iuAUjQBBvIyYuZ6eD1ojoSEKPSeqxBm/R+eeE4
         G7qN51ZLdYvIbP11V4Z/sjrPwN2+kvq96RN429uTvd61oI7QCBK
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 03/20] t4134: compute appropriate length constant
Date:   Sat, 21 Dec 2019 19:49:19 +0000
Message-Id: <20191221194936.1346664-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.24.1.658.g99f4b37f93
In-Reply-To: <20191221194936.1346664-1-sandals@crustytoothpaste.net>
References: <20191221194936.1346664-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of using a specific invalid hard-coded object ID, generate one
of the appropriate length by looking one up in the translation tables.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t4134-apply-submodule.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t4134-apply-submodule.sh b/t/t4134-apply-submodule.sh
index 0043930ca6..99ed4cc546 100755
--- a/t/t4134-apply-submodule.sh
+++ b/t/t4134-apply-submodule.sh
@@ -8,6 +8,7 @@ test_description='git apply submodule tests'
 . ./test-lib.sh
 
 test_expect_success setup '
+	test_oid_init &&
 	cat > create-sm.patch <<EOF &&
 diff --git a/dir/sm b/dir/sm
 new file mode 160000
@@ -15,7 +16,7 @@ index 0000000..0123456
 --- /dev/null
 +++ b/dir/sm
 @@ -0,0 +1 @@
-+Subproject commit 0123456789abcdef0123456789abcdef01234567
++Subproject commit $(test_oid numeric)
 EOF
 	cat > remove-sm.patch <<EOF
 diff --git a/dir/sm b/dir/sm
@@ -24,7 +25,7 @@ index 0123456..0000000
 --- a/dir/sm
 +++ /dev/null
 @@ -1 +0,0 @@
--Subproject commit 0123456789abcdef0123456789abcdef01234567
+-Subproject commit $(test_oid numeric)
 EOF
 '
 
