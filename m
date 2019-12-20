Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4B2C43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 02:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07C96206CB
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 02:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfLTCLw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 21:11:52 -0500
Received: from mx2.freebsd.org ([96.47.72.81]:15960 "EHLO mx2.freebsd.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727016AbfLTCLw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 21:11:52 -0500
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mx1.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx2.freebsd.org (Postfix) with ESMTPS id 1355891090;
        Fri, 20 Dec 2019 02:11:51 +0000 (UTC)
        (envelope-from emaste@freebsd.org)
Received: from freefall.freebsd.org (freefall.freebsd.org [IPv6:2610:1c1:1:6074::16:84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "freefall.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx1.freebsd.org (Postfix) with ESMTPS id 47fC1261JQz4Lg7;
        Fri, 20 Dec 2019 02:11:50 +0000 (UTC)
        (envelope-from emaste@freebsd.org)
Received: by freefall.freebsd.org (Postfix, from userid 1079)
        id C65A7A17A; Fri, 20 Dec 2019 02:11:50 +0000 (UTC)
From:   Ed Maste <emaste@FreeBSD.org>
To:     git mailing list <git@vger.kernel.org>
Cc:     "brian m . carlson" <sandals@crustytoothpaste.net>,
        Ed Maste <emaste@FreeBSD.org>
Subject: [PATCH v2] CI: add FreeBSD CI support via Cirrus-CI
Date:   Fri, 20 Dec 2019 02:11:45 +0000
Message-Id: <20191220021145.47235-1-emaste@FreeBSD.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20191125203740.72249-1-emaste@freefall.freebsd.org>
References: <20191125203740.72249-1-emaste@freefall.freebsd.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently testing on FreeBSD 12.1.

Signed-off-by: Ed Maste <emaste@FreeBSD.org>
---
Since v1, create an unprivileged user and build/test using that user.
CI run with this change: https://cirrus-ci.com/task/6565294088126464

 .cirrus.yml | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 .cirrus.yml

diff --git a/.cirrus.yml b/.cirrus.yml
new file mode 100644
index 0000000000..c2f5fe385a
--- /dev/null
+++ b/.cirrus.yml
@@ -0,0 +1,15 @@
+env:
+  CIRRUS_CLONE_DEPTH: 1
+
+freebsd_12_task:
+  freebsd_instance:
+    image: freebsd-12-1-release-amd64
+  install_script:
+    pkg install -y gettext gmake perl5
+  create_user_script:
+    - pw useradd git
+    - chown -R git:git .
+  build_script:
+    - su git -c gmake
+  test_script:
+    - su git -c 'gmake test'
-- 
2.24.0

