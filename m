Return-Path: <SRS0=Jtyc=AD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C1AC433E1
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 18:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DD0220771
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 18:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="FRXzE6va"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbgFVSEb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Jun 2020 14:04:31 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39990 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730104AbgFVSE1 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 Jun 2020 14:04:27 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id AB5F360A5D;
        Mon, 22 Jun 2020 18:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592849066;
        bh=UNaknLfYG4icOEWxN86C3aVzA/qpOqPsBJ6F0gMuBZw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=FRXzE6vaHPWykYPFkepN91GwnsQySrxXgysGKeXV851Rv4CF7Bi/l/3oHtYfq1AKy
         g3NjW6e7KRPv15+lxC3Tru7GrpuAMzOZnaH5y38cYBM8UmZYjwx+c8JAcvn9yWYF2X
         nLxNZyBzLZVrVwRrhIozhhGHnaqSeoAx8wslobMxKKHhoBEL/r0FpTRcevbzNj51H3
         f7M9rOssIZZk3XKkLxl4P4R300rziN0aNOtua7XqInj7naOT+7Yv0zPvEq/7hke7gj
         sjYbqSOJLReH+Js75NWixk+iEOiSPA1LmTDUDDrUt0Tsylw+nIlmlma+UTFhpqHEb+
         pX/UGH/Tg73lJIvO4N4Gf4z28cWNwQRrTJRWdIjhUz/XSrE+5LPDyInwF/jQargLYj
         M66GDsmXeQjW7JVbj0PdyLwuMrRRtht2ZCkgUGyXPOTIwDCsRwfS02UNKlJXngkfdx
         I078dwoFQo6MUeC+kb9oKjINs5UHIuIUN8YTF3NyB+CVgO5O3Da
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Andreas Schwab <schwab@linux-m68k.org>, Eric Wong <e@80x24.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 03/14] t9108: make test hash independent
Date:   Mon, 22 Jun 2020 18:04:07 +0000
Message-Id: <20200622180418.2418483-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9
In-Reply-To: <20200622180418.2418483-1-sandals@crustytoothpaste.net>
References: <20200619223947.947067-1-sandals@crustytoothpaste.net>
 <20200622180418.2418483-1-sandals@crustytoothpaste.net>
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
 t/t9108-git-svn-glob.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9108-git-svn-glob.sh b/t/t9108-git-svn-glob.sh
index 6990f64364..d5939d4753 100755
--- a/t/t9108-git-svn-glob.sh
+++ b/t/t9108-git-svn-glob.sh
@@ -48,7 +48,7 @@ test_expect_success 'test refspec globbing' '
 	                 "tags/*/src/a:refs/remotes/tags/*" &&
 	git svn multi-fetch &&
 	git log --pretty=oneline refs/remotes/tags/end >actual &&
-	sed -e "s/^.\{41\}//" actual >output.end &&
+	cut -d" " -f2- actual >output.end &&
 	test_cmp expect.end output.end &&
 	test "$(git rev-parse refs/remotes/tags/end~1)" = \
 		"$(git rev-parse refs/remotes/branches/start)" &&
@@ -84,7 +84,7 @@ test_expect_success 'test left-hand-side only globbing' '
 	test $(git rev-parse refs/remotes/two/tags/end~3) = \
 	     $(git rev-parse refs/remotes/two/branches/start) &&
 	git log --pretty=oneline refs/remotes/two/tags/end >actual &&
-	sed -e "s/^.\{41\}//" actual >output.two &&
+	cut -d" " -f2- actual >output.two &&
 	test_cmp expect.two output.two
 	'
 
