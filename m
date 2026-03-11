Received: from mail-gateway-shared02.cyon.net (mail-gateway-shared02.cyon.net [194.126.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDFC3D667B
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 12:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773232022; cv=none; b=MPo5qgbFEivTiiPPPji2goBUAK4y06pLRCRDpQZBE+tQjep+ysNRsllB+ApfrPpcJ2CmwnfvQhHkBx5IdIA2M0Qidr0BBVnQZxcyRhCs5yCVHnAI9nrQWutlhtLLhQGOvGPhcoyKydmK5izAvb6E8nsB7jCRCwFbYTcquLasquM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773232022; c=relaxed/simple;
	bh=EeIrd1KJNjLv21y1roASEfUa4Bnwzyhizeobpm6g43Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UAgnbV6IGltaoahAKseEz8Xcv2alTOq2FfDsnnSi5IFfCVZAnIm9Uy1eaEmfEs0n8fo3F/Nu3BMUA16o+Xbs5RWfeapRZtob4EnPOlyirjsovm64tgggE4tyf+v10BLQqMTbB12EkI6WuvXd3lYYRcyDgr04N/iVwnymegVPrA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared02.cyon.net with esmtpsa (TLS1.2:ECDHE_SECP256R1__RSA_SHA512__AES_256_GCM:256)
	(Exim)
	(envelope-from <ig@drbeat.li>)
	id 1w0IPW-008JrC-0a
	for git@vger.kernel.org;
	Wed, 11 Mar 2026 13:11:36 +0100
Received: from [10.20.10.53] (port=50506 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.98.1)
	(envelope-from <ig@drbeat.li>)
	id 1w0IPR-0000000BEoL-0E7a
	for git@vger.kernel.org;
	Wed, 11 Mar 2026 13:11:29 +0100
Received: from eap.internal (eap.internal [192.168.11.6])
	by oh4.internal (Postfix) with ESMTP id AFB4D3FEA9
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 13:11:28 +0100 (CET)
Received: from bb (uid 1000)
	(envelope-from bb@eap.internal)
	id 5402e5
	by eap.internal (DragonFly Mail Agent v0.14 on eap);
	Wed, 11 Mar 2026 13:11:28 +0100
From: Beat Bolli <dev+git@drbeat.li>
To: git@vger.kernel.org
Cc: Beat Bolli <dev+git@drbeat.li>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: [PATCH 0/4] imap-send: modernize the OpenSSL API
Date: Wed, 11 Mar 2026 13:11:03 +0100
Message-ID: <20260311121107.1122387-1-dev+git@drbeat.li>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li

OpenSSL recently released version 4.0.0-alpha1 [1]. Compiling with this
version revealed some erroneous and deprecated code.

This series aims to update this code to use the documented OpenSSL APIs.
All of the newly used APIs have existed since OpenSSL 1.1.0, the latest
version of which was released in September 2019 [2]. IMHO there is no
need to support even older OpenSSL versions.

- The first two commits are needed to make imap-send.c compile against
  OpenSSL 4.0 (and older!).

- The remaining two are follow-up cleanups that are not strictly
  necessary.

Cc-ing Oswald as the original author of the affected code.

[1] https://github.com/openssl/openssl/tree/openssl-4.0.0-alpha1
[2] https://openssl-library.org/source/old/1.1.0/index.html

Beat Bolli (4):
  imap-send: use the OpenSSL API to access the subject alternative names
  imap-send: use the OpenSSL API to access the subject common name
  imap-send: remove two string length checks
  imap-send: refactor function host_matches()

 imap-send.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

-- 
2.51.0

