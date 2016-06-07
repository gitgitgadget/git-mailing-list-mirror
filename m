From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 1/8] Add basic Coccinelle transforms.
Date: Tue,  7 Jun 2016 00:57:09 +0000
Message-ID: <20160607005716.69222-2-sandals@crustytoothpaste.net>
Cc: Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 02:57:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bA5Kl-000360-He
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 02:57:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752149AbcFGA50 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 20:57:26 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:40720 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751044AbcFGA5Z (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2016 20:57:25 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 4B4CA282A8;
	Tue,  7 Jun 2016 00:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1465261043;
	bh=FAjDLCxFS/GLuiCo43jFM1MrWqNg1hj+tT809C6xAFg=;
	h=From:To:Cc:Subject:Date:From;
	b=RQrKvlifiB1MibPTQsvpM4bitm4O5e4zx5sTrvNiGS5+3jQIXseic1f9m5vZaCIeC
	 QyjcqdWThLLRl//IIn3T+TqFY19Mx9jg95FZWBVdAxAHBOIfPp1jVSAdz3IsWOURMF
	 2Ti9oWIoSGrhafAfbXG92Oo1TuAeOMKqFYQG8HZqLZbI6C/z4X6XFP4QTzZlaK7jmx
	 YMe9DiFImy9gbmlzwqQtIqEggR3f7A8Khof5T/8fwDEGVzH23sL+49y/EoUwDbWgeY
	 32dFZe4tOxeA5hqLSg9ESHwc7of89SI9yAo/2OopPAu0h6+5VauX0nIBE7Vz4A7W99
	 uNoBNiG/yiiwmo6lhvad2p1kc0ki0fzCDGnR/rHBL1KZFYRqKNLvHH915uGDx3tvMd
	 yFNTcvxwQSCPXUjZfXyWKuIh3gj2cdOSAFbMDWbbRyxMQW8Q3+NM3q/0TGUGBmiM2u
	 albd8SprrLqVPNcfj6ysLpyLe70/XpK+toLbGWEylHtfnpOExUg
X-Mailer: git-send-email 2.8.1.369.geae769a
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296582>

Coccinelle (http://coccinelle.lip6.fr/) is a program which performs
mechanical transformations on C programs using semantic patches.  These
semantic patches can be used to implement automatic refactoring and
maintenance tasks.

Add a set of basic semantic patches to convert common patterns related
to the struct object_id transformation.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
I realize the name and location of this file might be suboptimal.
Suggestions on better locations and filenames would be appreciated.

 standard.cocci | 83 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 standard.cocci

diff --git a/standard.cocci b/standard.cocci
new file mode 100644
index 00000000..0f068252
--- /dev/null
+++ b/standard.cocci
@@ -0,0 +1,83 @@
+@@
+expression E1;
+@@
+- is_null_sha1(E1.hash)
++ is_null_oid(&E1)
+
+@@
+expression E1;
+@@
+- is_null_sha1(E1->hash)
++ is_null_oid(E1)
+
+@@
+expression E1;
+@@
+- sha1_to_hex(E1.hash)
++ oid_to_hex(&E1)
+
+@@
+expression E1;
+@@
+- sha1_to_hex(E1->hash)
++ oid_to_hex(E1)
+
+@@
+expression E1;
+@@
+- hashclr(E1.hash)
++ oidclr(&E1)
+
+@@
+expression E1;
+@@
+- hashclr(E1->hash)
++ oidclr(E1)
+
+@@
+expression E1, E2;
+@@
+- hashcmp(E1.hash, E2.hash)
++ oidcmp(&E1, &E2)
+
+@@
+expression E1, E2;
+@@
+- hashcmp(E1->hash, E2->hash)
++ oidcmp(E1, E2)
+
+@@
+expression E1, E2;
+@@
+- hashcmp(E1->hash, E2.hash)
++ oidcmp(E1, &E2)
+
+@@
+expression E1, E2;
+@@
+- hashcmp(E1.hash, E2->hash)
++ oidcmp(&E1, E2)
+
+@@
+expression E1, E2;
+@@
+- hashcpy(E1.hash, E2.hash)
++ oidcpy(&E1, &E2)
+
+@@
+expression E1, E2;
+@@
+- hashcpy(E1->hash, E2->hash)
++ oidcpy(E1, E2)
+
+@@
+expression E1, E2;
+@@
+- hashcpy(E1->hash, E2.hash)
++ oidcpy(E1, &E2)
+
+@@
+expression E1, E2;
+@@
+- hashcpy(E1.hash, E2->hash)
++ oidcpy(&E1, E2)
