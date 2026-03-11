Received: from mail-gateway-shared02.cyon.net (mail-gateway-shared02.cyon.net [194.126.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAF53612DD
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 22:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773267048; cv=none; b=QzzWDHMT9HA15ppfKugJQ1uqv7y/xADeM9t/LiYJXEU0169LNv61uqdx3ok0OyTwSFne9KSO1NZK/rGOF4wzu3PqnXitOUobz+K/ujbULzXUX+9hGArWh/4VyNv+yoJPfYppYHMWsc4OTReg8lfqIq14FhI1GYOfApDAGpThK9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773267048; c=relaxed/simple;
	bh=4EFbM1lPD1w8gOqipmN9xkqbI3Gw0/FFzZlDWYJvRYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BgLkT61LTjV/wDuaSKI1/yauocK/1avSkRf77Nkvw80ZGlJtTy1YCHU3m4d/UDYNy1DFhiNiFj0rQwSxLM2lJHkSd/3DCO6xJ4l2844d/Hq+omWUXzTgHs9pDMZKUECtsdFcNxlUI3da4eZjn1dPe6R6tYCFr3VQHDcPsPWD2f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared02.cyon.net with esmtpsa (TLS1.2:ECDHE_SECP256R1__RSA_SHA512__AES_256_GCM:256)
	(Exim)
	(envelope-from <ig@drbeat.li>)
	id 1w0RlL-00AgPh-1w
	for git@vger.kernel.org;
	Wed, 11 Mar 2026 23:10:45 +0100
Received: from [10.20.10.51] (port=46288 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.98.1)
	(envelope-from <ig@drbeat.li>)
	id 1w0RlG-0000000FgMY-1fc2
	for git@vger.kernel.org;
	Wed, 11 Mar 2026 23:10:38 +0100
Received: from eap.internal (eap.internal [192.168.11.6])
	by oh4.internal (Postfix) with ESMTP id 1305F402AD
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 23:10:38 +0100 (CET)
Received: from bb (uid 1000)
	(envelope-from bb@eap.internal)
	id 5402e5
	by eap.internal (DragonFly Mail Agent v0.14 on eap);
	Wed, 11 Mar 2026 23:10:38 +0100
From: Beat Bolli <dev+git@drbeat.li>
To: git@vger.kernel.org
Cc: Beat Bolli <dev+git@drbeat.li>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: [PATCH v2 0/3] imap-send: modernize the OpenSSL API
Date: Wed, 11 Mar 2026 23:10:24 +0100
Message-ID: <20260311221027.1404476-1-dev+git@drbeat.li>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260311121107.1122387-1-dev+git@drbeat.li>
References: <20260311121107.1122387-1-dev+git@drbeat.li>
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

Cc-ing Oswald as the original author of the affected code.

[1] https://github.com/openssl/openssl/tree/openssl-4.0.0-alpha1
[2] https://openssl-library.org/source/old/1.1.0/index.html

Beat Bolli (3):
  imap-send: use the OpenSSL API to access the subject alternative names
  imap-send: use the OpenSSL API to access the subject common name
  imap-send: move common code into function host_matches()

 imap-send.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

---
Changes vs v1:
- keep the check for embedded NUL characters

-- 
2.51.0

