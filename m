From: =?UTF-8?q?Johannes=20L=C3=B6thberg?= <johannes@kyriasis.com>
Subject: [PATCH v2 2/2] t: Add test for cloning from ref namespace
Date: Fri,  5 Jun 2015 16:12:11 +0200
Message-ID: <1433513531-13423-3-git-send-email-johannes@kyriasis.com>
References: <1433193883-11577-1-git-send-email-johannes@kyriasis.com>
 <1433513531-13423-1-git-send-email-johannes@kyriasis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Johannes=20L=C3=B6thberg?= <johannes@kyriasis.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 05 16:13:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0sMK-0005NM-0H
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 16:12:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423114AbbFEOM0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Jun 2015 10:12:26 -0400
Received: from theos.kyriasis.com ([212.71.254.33]:52532 "EHLO
	theos.kyriasis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423112AbbFEOMX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 10:12:23 -0400
Received: from theos.kyriasis.com (localhost [127.0.0.1]);
	by theos.kyriasis.com (OpenSMTPD) with ESMTP id ce211791;
	for <git@vger.kernel.org>;
	Fri, 5 Jun 2015 14:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyriasis.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-type:content-transfer-encoding; s=theos; bh=5eFwBEkwbSC
	D3jeFojnNB30XQyQ=; b=dW0HJg2XRY48fwK+ccpmt1hECXM7n/SGzmAZRi8t/fn
	WOvkSR67tVhfetInI9f4ysfQJCnaMyI2+CP7SJ1dpGC3LOn+yeDLOcqJaMlcr6NS
	NlVhmxkXf2wnIBX4xx5WThysvX2+a8Qor0KyUet7i9inVL//QXdLZ2Ti07q0innU
	=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kyriasis.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-type:content-transfer-encoding; q=dns; s=theos; b=b7tx2
	MrfxQjS8HOPx7eAKNgbCrvnLWrQKHboVDGllFtM+wb1wjd/n84+6tpCtprsjzYOP
	lMcCBNq92W0tn/ffqLd/JvnjFI2gcHxlAHeQxe/Se7njK75/h0jE71HAsmyxays6
	xD+A9KqNQozolL15F4vK/NWKwPZlTSzpJj7w50=
Received: from leeloo.kyriasis.com (m77-218-250-201.cust.tele2.se [77.218.250.201]);
	by theos.kyriasis.com (OpenSMTPD) with ESMTPSA id 270f356c;
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO;
	Fri, 5 Jun 2015 14:12:20 +0000 (UTC)
X-Mailer: git-send-email 2.4.2
In-Reply-To: <1433513531-13423-1-git-send-email-johannes@kyriasis.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270837>

Test that the master ref is set up properly when cloning from a ref
namespace

Signed-off-by: Johannes L=C3=B6thberg <johannes@kyriasis.com>
---
 t/t9904-clone-from-ref-namespace.sh | 33 +++++++++++++++++++++++++++++=
++++
 1 file changed, 33 insertions(+)
 create mode 100755 t/t9904-clone-from-ref-namespace.sh

diff --git a/t/t9904-clone-from-ref-namespace.sh b/t/t9904-clone-from-r=
ef-namespace.sh
new file mode 100755
index 0000000..60977f8
--- /dev/null
+++ b/t/t9904-clone-from-ref-namespace.sh
@@ -0,0 +1,33 @@
+#!/bin/sh
+#
+
+test_description=3D'git clone from ref namespace
+
+This test checks that cloning from a ref namespace works'
+
+. ./test-lib.sh
+
+test_expect_success 'clone from ref namespace' '
+	rm -rf initial bare clone &&
+	git init initial &&
+	git init --bare bare &&
+	(
+		cd initial &&
+		echo "commit one" >> file &&
+		git add file &&
+		git commit -m "commit one" &&
+		git push ../bare master &&
+
+		echo "commit two" >> file &&
+		git add file &&
+		git commit -m "commit two"
+		GIT_NAMESPACE=3Dnew_namespace git push ../bare master
+	) &&
+	GIT_NAMESPACE=3Dnew_namespace git clone bare clone &&
+	(
+		cd clone &&
+		git show
+	)
+'
+
+test_done
--=20
2.4.2
