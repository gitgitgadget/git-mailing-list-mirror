From: Phil Hord <hordp@cisco.com>
Subject: [PATCHv3 5/5] Add test showing git-fetch groks gitfiles
Date: Wed, 05 Oct 2011 09:35:45 -0400
Message-ID: <4E8C5D31.2000406@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>,
	Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 05 15:37:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBRej-0000zm-5k
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 15:37:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934768Ab1JENgv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 09:36:51 -0400
Received: from rcdn-iport-6.cisco.com ([173.37.86.77]:34311 "EHLO
	rcdn-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934753Ab1JENgr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 09:36:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=864; q=dns/txt;
  s=iport; t=1317821807; x=1319031407;
  h=message-id:date:from:mime-version:to:cc:subject:
   content-transfer-encoding;
  bh=JBAZ8Y4sYnpMhGvC6D5oOO01CQrFyBcUMipbC9HwZw0=;
  b=XpCYR9PULIt4oaEQQryvv3uF/l4i7b9TsxF0FUP8ffDvsMjtaoEIt1qV
   p7+P2EN6rHh9ydVjNIi6AONdIUUTWYcanJ57R798hkS/6KxhED9U9r0/N
   nb86RuaMhYflCUimOfVw3diAXffyZUjNw7SCCv97r8+sMiZZHM85NT5Rl
   c=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EAPBcjE6tJV2Z/2dsb2JhbABCqBGBBYFsAWUBPBYYAwIBAgFLAQwBBQIBAR6gOgGeDIcpBJNthSeMOQ
X-IronPort-AV: E=Sophos;i="4.68,491,1312156800"; 
   d="scan'208";a="26205581"
Received: from rcdn-core-2.cisco.com ([173.37.93.153])
  by rcdn-iport-6.cisco.com with ESMTP; 05 Oct 2011 13:36:47 +0000
Received: from [64.100.104.107] (dhcp-64-100-104-107.cisco.com [64.100.104.107])
	by rcdn-core-2.cisco.com (8.14.3/8.14.3) with ESMTP id p95Dakxb005902;
	Wed, 5 Oct 2011 13:36:46 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110812 Thunderbird/6.0
X-Enigmail-Version: 1.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182845>

Add a test for two subtly different cases: 'git fetch path/.git'
and 'git fetch path' to confirm that transport recognizes both
paths as git repositories when using the gitfile mechanism.

Signed-off-by: Phil Hord <hordp@cisco.com>

diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index e810314..87ee016 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -206,6 +206,20 @@ test_expect_success 'clone from .git file' '
 	git clone dst/.git dst2
 '
 
+test_expect_success 'fetch from .git gitfile' '
+	(
+		cd dst2 &&
+		git fetch ../dst/.git
+	)
+'
+
+test_expect_success 'fetch from gitfile parent' '
+	(
+		cd dst2 &&
+		git fetch ../dst
+	)
+'
+
 test_expect_success 'clone separate gitdir where target already exists' '
 	rm -rf dst &&
 	test_must_fail git clone --separate-git-dir realgitdir src dst
-- 
1.7.7.505.ga09f6
