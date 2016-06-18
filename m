Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1327A2018C
	for <e@80x24.org>; Sat, 18 Jun 2016 22:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbcFRWOe (ORCPT <rfc822;e@80x24.org>);
	Sat, 18 Jun 2016 18:14:34 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:37412 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751119AbcFRWOQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jun 2016 18:14:16 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [72.20.141.51])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 07A9C280A0;
	Sat, 18 Jun 2016 22:14:12 +0000 (UTC)
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1466288053;
	bh=VsiwXyDdB+tELNNjEmVWjOK/JBmf7fIn5dIFDp6rH0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cI125OZ+5JFBYBPghT7D7/J8FABxFb7WpOJLHp00PSjNdVidkSmYD56+2svSa9jdo
	 gMyircNutit+KH4oevS0yBXxLTziK2NIVJskSHmZpxH/2QoPnlmIq3L4Uv17l+wo7S
	 iwwprPwutdefYcE+4tOXsL2nAgEcZujLPHJl8u/wtp9odrMPykrxQ6P6uu2WDSaaog
	 Q2+WQc5ciMtWqVk3zJtu/2S2gtoPBSJYrwuMsd7bo9uXgCc3aAlRGaaOD/rHyL49P0
	 Iq8ebgwOGiUEUalZK9SfHNf2Okf+LAjWF1dFNx4mr5o7YF1Oo325f/hrerPAACgRZD
	 kX50iJnL1uFxAEYmmyHhheUL/HCQUBXQa0LDXYuCmAOaL9ge1baXb8nrCaOdsnC9d/
	 oNsHE9Wqoxqkdtfo4WAqFG2040yngeOFBx81tFcEwyRaH28QD4iR4Ryc5QAld9fGdG
	 wTZ67YQoU0CxC6V2upBbrpfCt2M9v4tHi47yIbAQxrL5jCJGrhz
From:	"brian m. carlson" <sandals@crustytoothpaste.net>
To:	git@vger.kernel.org
Cc:	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 1/8] Add basic Coccinelle transforms.
Date:	Sat, 18 Jun 2016 22:14:00 +0000
Message-Id: <20160618221407.1046188-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160618221407.1046188-1-sandals@crustytoothpaste.net>
References: <20160618221407.1046188-1-sandals@crustytoothpaste.net>
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Coccinelle (http://coccinelle.lip6.fr/) is a program which performs
mechanical transformations on C programs using semantic patches.  These
semantic patches can be used to implement automatic refactoring and
maintenance tasks.

Add a set of basic semantic patches to convert common patterns related
to the struct object_id transformation, as well as a README.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 contrib/examples/coccinelle/README          |  2 +
 contrib/examples/coccinelle/object_id.cocci | 83 +++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)
 create mode 100644 contrib/examples/coccinelle/README
 create mode 100644 contrib/examples/coccinelle/object_id.cocci

diff --git a/contrib/examples/coccinelle/README b/contrib/examples/coccinelle/README
new file mode 100644
index 00000000..9c2f8879
--- /dev/null
+++ b/contrib/examples/coccinelle/README
@@ -0,0 +1,2 @@
+This directory provides examples of Coccinelle (http://coccinelle.lip6.fr/)
+semantic patches that might be useful to developers.
diff --git a/contrib/examples/coccinelle/object_id.cocci b/contrib/examples/coccinelle/object_id.cocci
new file mode 100644
index 00000000..0f068252
--- /dev/null
+++ b/contrib/examples/coccinelle/object_id.cocci
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
