Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B9138A285
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 23:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775604604; cv=none; b=OKz8ndYMsZx1R93MU5ZQfuvmZ3aWU2Re+J1nEMgUPqzrx2gN9QCQDK4Uj63rnvTOqL02DTZQoFdTOPcAnuyNJxr09b4By+qj80AxyojcVBaeuz/m4KldFo2FVWKx7G8wOWVtd17kwSfYpkJl7VplgFL5ogiOBemdr/Lzy6Dxgm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775604604; c=relaxed/simple;
	bh=wOhiag/SmRSew53eC5AT4GPoD6dHn4kJkoAY6tbX73c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oQ/uuGaRkkVerKYAaPmzrrLVEvo6hCYYtvkiOS2PludM/wyt4vuR0qAT0RRbHIr+Ssx3CarUYmv0YIPX/YtFCgNrPN1UgbHavrwI+ZYhUsvWs9AXaHvhrFCLqzFD0RhUnQqmrf4mv53qCXp6RPY9AFXkvNstNmYZXLDjisxYUOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 637NTtub3032576
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Tue, 7 Apr 2026 23:29:56 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: <git@vger.kernel.org>
Subject: Git 2.54.0-rc1, subtests of t5310, t5326, t5327
Date: Tue, 7 Apr 2026 19:29:50 -0400
Organization: Nexbridge Inc.
Message-ID: <00f401dcc6e6$7183c0f0$548b42d0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AdzG5QQA+jZLRRFIQTe/WTyMe5NKig==
X-Antivirus: Norton (VPS 260407-8, 4/7/2026), Outbound message
X-Antivirus-Status: Clean

I can getting numerous issues in t5310, t5326, t2527 relating to the
following use of --git-dir:

In t5310:
fatal: not a git repository: 'clone.git'
not ok 55 - fetch (full bitmap)
#
#                       git --git-dir=clone.git fetch origin second:second
&&
#                       git rev-parse HEAD >expect &&
#                       git --git-dir=clone.git rev-parse HEAD >actual &&
#                       test_cmp expect actual
#

In t5326 and t5327:
fatal: writev error: Invalid function argument
fetch-pack: unexpected disconnect while reading sideband packet
fatal: early EOF
fatal: fetch-pack: invalid index-pack output
not ok 24 - clone from bitmapped repository
#
#                       rm -fr clone.git &&
#                       git clone --no-local --bare . clone.git &&
#                       git rev-parse HEAD >expect &&
#                       git --git-dir=clone.git rev-parse HEAD >actual &&
#                       test_cmp expect actual
#


It appears that the --git-dir argument is not working properly in this
release. Any opinions?

I would have expected HOME or .gitconfig to have been set or redirected
elsewhere in the test.

--Randall


--
Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)
NonStop(211288444200000000)
-- In real life, I talk too much.


