Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B21C433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 22:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF003223BE
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 22:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="nAeSGyy0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729818AbgFSWwE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 18:52:04 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39834 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729798AbgFSWwD (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 18:52:03 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 85FFF60A5C;
        Fri, 19 Jun 2020 22:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592607091;
        bh=CKXqyLpVG2H0LquA9U6HCRvE2fzakReJAFg20+nBFT0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=nAeSGyy0wF5ndjgBj3PqRxWWJZ9bi933gQMUs8oIDtay77cIeMiMNU3UpxoOQIJSA
         FkuRG6DaRHetbsuO3vJBG0mhftatbc1qCs2HUfYFzRgsDZ8UvtCSGZj/h3A9oiK/uC
         0xjohkE1Mu0ODcmG6xMninNms4GnyyCj+v6+0n2Y70KbxigQZ/MgoADxky62k7tAw4
         3O0gt4MM6hlHHqNcJWB+QcMB/TJvyinhbc20o22vsjvmQ4rWCMAS2KtGa27k/asywq
         LZO5iG/xd6KmK9M7Cu7fg+91kmKI6mYkf9wC9/yGahSBxAAnLXxsGQAGnC0W/POb0N
         234dd0fX6NaM2egkdJuWyALjpiLOxluyVCdJlSYplrVD7QzaBDzFGoFKZTZfCxgMAD
         oBx6P8PI8I/4bsBjXLKp19Qp4nu89MPt2UC3D43dto0xGOySN4H01qmTKHx8+2i0oe
         UXov13Z5mUEA7TxKd3yzz2dHC+XuIICwf8ZuAv9y6u5GhF215f8
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Matthew DeVore <matvore@google.com>, Eric Wong <e@80x24.org>,
        Matthieu Moy <git@matthieu-moy.fr>
Subject: [PATCH 02/14] t9168: make test hash independent
Date:   Fri, 19 Jun 2020 22:39:35 +0000
Message-Id: <20200619223947.947067-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9
In-Reply-To: <20200619223947.947067-1-sandals@crustytoothpaste.net>
References: <20200619223947.947067-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of stripping off the first 41 characters of git log output,
let's just strip off the first space-separated component, which will
work for any size hash.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t9168-git-svn-partially-globbed-names.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t9168-git-svn-partially-globbed-names.sh b/t/t9168-git-svn-partially-globbed-names.sh
index bdf6e84999..854b3419b2 100755
--- a/t/t9168-git-svn-partially-globbed-names.sh
+++ b/t/t9168-git-svn-partially-globbed-names.sh
@@ -49,7 +49,7 @@ test_expect_success 'test refspec prefixed globbing' '
 			 "tags/t_*/src/a:refs/remotes/tags/t_*" &&
 	git svn multi-fetch &&
 	git log --pretty=oneline refs/remotes/tags/t_end >actual &&
-	sed -e "s/^.\{41\}//" actual >output.end &&
+	cut -d" " -f2- actual >output.end &&
 	test_cmp expect.end output.end &&
 	test "$(git rev-parse refs/remotes/tags/t_end~1)" = \
 		"$(git rev-parse refs/remotes/branches/b_start)" &&
@@ -87,7 +87,7 @@ test_expect_success 'test left-hand-side only prefixed globbing' '
 	test $(git rev-parse refs/remotes/two/tags/t_end~3) = \
 	     $(git rev-parse refs/remotes/two/branches/b_start) &&
 	git log --pretty=oneline refs/remotes/two/tags/t_end >actual &&
-	sed -e "s/^.\{41\}//" actual >output.two &&
+	cut -d" " -f2- actual >output.two &&
 	test_cmp expect.two output.two
 	'
 
@@ -129,7 +129,7 @@ test_expect_success 'test prefixed globs match just prefix' '
 	test $(git rev-parse refs/remotes/three/tags/t_~1) = \
 	     $(git rev-parse refs/remotes/three/branches/b_) &&
 	git log --pretty=oneline refs/remotes/three/tags/t_ >actual &&
-	sed -e "s/^.\{41\}//" actual >output.three &&
+	cut -d" " -f2- actual >output.three &&
 	test_cmp expect.three output.three
 	'
 
@@ -199,7 +199,7 @@ test_expect_success 'test globbing in the middle of the word' '
 	test $(git rev-parse refs/remotes/five/tags/fghij~1) = \
 	     $(git rev-parse refs/remotes/five/branches/abcde) &&
 	git log --pretty=oneline refs/remotes/five/tags/fghij >actual &&
-	sed -e "s/^.\{41\}//" actual >output.five &&
+	cut -d" " -f2- actual >output.five &&
 	test_cmp expect.five output.five
 	'
 
