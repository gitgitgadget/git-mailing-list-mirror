Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA5CC35243
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 23:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA3162071A
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 23:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Lo02GsM2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbgAYXAy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jan 2020 18:00:54 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:46838 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728890AbgAYXAt (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Jan 2020 18:00:49 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6E1556146E;
        Sat, 25 Jan 2020 23:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1579993248;
        bh=8FU4zHKprYpeY3ERg5TngHjUqssaMsZOwf9nyGbqoW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Lo02GsM27zG8IxjFyGDplOuWAwx+HxUDKFSj0JsQbnXBkbBWTIvxLqo+mKTVROFHK
         O5Vy7e8wdt6dn8VQ5o/z7D2vdl4J8Zqb1ovhEt2jViXYWrw6eYwnNRm9rdA0Q+bMyh
         sOGEPypJNlPrfYDQwzgLUuMCWd8+pA9OVBpCTR72qJQbgfRV7vt02ywa98zgueRFZU
         OkjC0CsDpNqDQhjVt8MkZCwFGGQvCebRiSVvvRhSzdfiADa/h3Qe0HhD1+Ktv5UKpd
         QgXY8/peVk3K12drWR6uGRxm0VtxUmJm+Z3avLrNraLZo3HQUjs/s3KvOF73ZJK1sH
         WSC6Z2bkzEOfHnPpAYqnv5KY8SYLhBq2lMeqO9AGVlo+cALFPLwosuIGZ/fUopQzpa
         e64x8K3XGyhJndhw3lM84Y/KyA7DQerjIiDOD8lddXBu2v1l0G/tH+r9PNg7JNjkSs
         A3haIHuaH849A981MSITnzwBGOGZywoVfCQqFTO7SEEWxsfh0zZ
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 17/22] t5607: make hash size independent
Date:   Sat, 25 Jan 2020 23:00:23 +0000
Message-Id: <20200125230035.136348-18-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.24.g3f081b084b0
In-Reply-To: <20200125230035.136348-1-sandals@crustytoothpaste.net>
References: <20200125230035.136348-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use $OID_REGEX instead of a hard-coded regular expression.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t5607-clone-bundle.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5607-clone-bundle.sh b/t/t5607-clone-bundle.sh
index b7a3fdf02d..9108ff6fbd 100755
--- a/t/t5607-clone-bundle.sh
+++ b/t/t5607-clone-bundle.sh
@@ -64,7 +64,7 @@ test_expect_success 'ridiculously long subject in boundary' '
 	test -s heads &&
 	git fetch long-subject-bundle.bdl &&
 	sed -n "/^-/{p;q;}" long-subject-bundle.bdl >boundary &&
-	grep "^-[0-9a-f]\\{40\\} " boundary
+	grep "^-$OID_REGEX " boundary
 '
 
 test_expect_success 'prerequisites with an empty commit message' '
