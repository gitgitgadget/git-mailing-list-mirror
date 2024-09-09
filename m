Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB461CF9A
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 15:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725896788; cv=none; b=LWShhOSxxgSUN4k7Txi/stxY1nLrKXN4/WTaJwN+fwkFd55xPfM0paYEYdatZuMjWktuoM7/VwWtXhRy/VW7k0/UXHnHb7NvQx9fYuRJ4N8uRsdPD4x32nAlR4H4Tf0WfV5iLAm5r8VHDga7nx1txzzo4VC3mkKHsUnmbRyWMJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725896788; c=relaxed/simple;
	bh=q1ExOR+swWKc69kPxI6hCAsGRPNQLkkf1g+7ucYGs6k=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=lAusVwQ/Icw4HziL9eQ7XCxFyD9ei+5XFDT3GhA65qfmjZFQC1ijXFBpQeMqY7FSBEMDLvUwYYMlq23sXx5M2tUYAtfdvNV6Sg+oI8Mv+WzqB7kwJysvMIpzMIc0pjoTn2W2jg3rIQbrAH703AbxRZ1cAFqXscXwYknG/THIw8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 489FbpWM2667794
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Sep 2024 15:37:52 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Okke Timm'" <okke@timm.sh>, <git@vger.kernel.org>
References: <2886189B-4BB5-4230-B7AF-94F97A13D72F@timm.sh>
In-Reply-To: <2886189B-4BB5-4230-B7AF-94F97A13D72F@timm.sh>
Subject: RE: [bug?] git diff --cached in a non-git directory
Date: Mon, 9 Sep 2024 11:37:46 -0400
Organization: Nexbridge Inc.
Message-ID: <05b501db02ce$3bd49e30$b37dda90$@nexbridge.com>
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
Thread-Index: AQECtl5qQJJXZVv1FQUxSbqG32FkJrQALwBA

On September 9, 2024 10:26 AM, Okke Timm wrote:
>What did you do before the bug happened? (Steps to reproduce your issue) I
>changed into a non-git directory.
>Then I called git with 'git diff --cached', which produced this error:
>
>error: unknown option `cached'
>usage: git diff --no-index [<options>] <path> <path> [...]
>
>What did you expect to happen? (Expected behavior) A helfpul error message.
>
>What happened instead? (Actual behavior) An unhelpful error message saying
that
>cached is an unknown option.
>
>What's different between what you expected and what actually happened?
>Me being confused why git suddenly forgot that `git diff --cached` is an
allowed
>option.
>
>Anything else you want to add:
>Please fix and thank you for this great tool!
>
>Please review the rest of the bug report below.
>You can delete any lines you don't wish to share.
>
>
>[System Info]
>git version:
>git version 2.46.0
>cpu: arm64
>no commit associated with this build
>sizeof-long: 8
>sizeof-size_t: 8
>shell-path: /bin/sh
>feature: fsmonitor--daemon
>libcurl: 8.4.0
>zlib: 1.2.12
>uname: Darwin 23.6.0 Darwin Kernel Version 23.6.0: Mon Jul 29 21:14:21 PDT
>2024; root:xnu-10063.141.2~1/RELEASE_ARM64_T8103 arm64 compiler info:
>clang: 15.0.0 (clang-1500.3.9.4) libc info: no libc information available
$SHELL
>(typically, interactive shell): /opt/homebrew/bin/bash
>
>
>[Enabled Hooks]
>not run from a git repository - no hooks to show

Because you are not in a git repository clone, the --cached option has no
meaning. It refers to the staging area only, so when not in a clone, git
does not consider --cached as supported because there is no connection
between an external directory and an internal. If you want to perform a diff
from cached vs. external, run the git diff from inside the clone referencing
the internal and external file after --.

