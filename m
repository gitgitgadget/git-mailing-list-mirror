Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCEE10FA
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 00:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723593921; cv=none; b=BokojRmo+xsSk/60fsyfBJ1UUJY12MMjmWEtrCcEUx0rTpSh8AacFwNwgLWHLM6rTyUt5FLGYuAJ+KZu6RwGIX3hK5W1KqE1aXhcFtAhp5oJxXldVHWeG8bzzycAG2q/5/jClMCLwQ4SVWUbwUAygGs6z0tGHOTSE7XV+9NyfqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723593921; c=relaxed/simple;
	bh=cqp2yi5HfyWzdaWgFgMKGUI03W8DMlds2ixOB9FBRdU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SbUKxtDGgH7DBkVXC6K2N6gas5YS7uNJiYqdNbUzWIUiig7q05pye/T6B+4bHglO6iB/LE/q+V4oJ9s1PdqaK3xuKqbXRrKMpIEhAyntUicAgtQ25NqJzQUAwuw1kiNPC5m02rUaCf14luwtNTBNtESPH+iCJMh5hmHjCBhYRRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ub4s+PTo; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ub4s+PTo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723593919; x=1755129919;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=cqp2yi5HfyWzdaWgFgMKGUI03W8DMlds2ixOB9FBRdU=;
  b=Ub4s+PToULBWGGdnFn/Zj9hI6yulFVDezMEF+WCOXj9pxkYG87CIsJFz
   Jk2dZx+SwRbN0rS1fQN37e48FFKh8ywHHPP+msFT4F0QCKP6x19IjKOyO
   lrDsfElzogKT4vLzzZ0QsdPMAllWGkgumG8IwNsWSQBYZlopgwaOrGYVS
   lJHxCqbG7RA9Z2bhnHtQlkuRAxARB4EHNqsbZifhA7pjXz53ZNO+eIs8Y
   jW5jMVCi9vjXXrZoXJcC6O1PST4G4k0zzryquuOy7E5pFSY/qY+WcJusW
   Q6gDBv4CDjLvapTRcPoT7dHFOrErihSbOs+vlg/farfFDpvrnhU9GcU5x
   w==;
X-CSE-ConnectionGUID: Ifsk3O2+RHSYV2PGuOgbyw==
X-CSE-MsgGUID: CT9sgtA6SGSGJ7QBVemxmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="32933058"
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="32933058"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 17:05:18 -0700
X-CSE-ConnectionGUID: bl9PMf8ZShimOwdQNamWgQ==
X-CSE-MsgGUID: 1a/h2TxxTjO54vwSb/T/3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="63767463"
Received: from jekeller-desk.amr.corp.intel.com (HELO localhost.localdomain) ([10.166.241.1])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 17:05:18 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v2 0/3] send-email: teach git send-email mode to translate
 aliases
Date: Tue, 13 Aug 2024 17:05:08 -0700
Message-Id: <20240813-jk-translate-alias-send-email-v2-0-912db4eb6846@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALT0u2YC/42NQQ6CMBAAv0L27JotICGe/IfhUOgKq9CaLiEaw
 t8tvMDjzGFmBeUorHDNVoi8iErwCfJTBt1gfc8oLjHklJdUU43PF87Reh3tzGhHsYrK3iFPVkY
 0HVNZV2XBFwep8Y78kM/RvzeJB9E5xO+xW8xu/y0vBgkNWSrawlUtVbd+9+cuTNBs2/YDll6CC
 soAAAA=
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Cc: Jacob Keller <jacob.keller@gmail.com>, 
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>
X-Mailer: b4 0.14.0

The b4 program has its own "b4 send" utility for sending a patch series. It
is similar in many respects to git send-email. Currently, it lacks support
for processing aliases, which makes switching between git send-email and b4
send somewhat annoying.

It would be convenient if b4 (or other programs interacting with git) could
make use of git send-email's alias file support.

Teach git send-email a new --translate-aliases option, which enables a new
mode for git send-email. When executed with this option, git send-email
will read standard input and convert each input according to the configured
alias file. The resulting address will be output to standard out.

I also considered implementing a new "full" format for --dump-aliases which
would dump the entire alias file along with its configured email addresses.
I ended up dropping that change as I felt that it would be less usable than
the translation feature.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
Changes in v2:
- Use standard input instead of command line arguments
- Link to v1: https://lore.kernel.org/r/20240808-jk-translate-alias-send-email-v1-0-10a03b3d6b06@gmail.com

---
Jacob Keller (3):
      t90001-send-email.sh: fix quoting for mailrc --dump-aliases test
      t9001-send-email.sh: update alias list used for pine test
      send-email: teach git send-email option to translate aliases

 Documentation/git-send-email.txt |   7 +++
 git-send-email.perl              |  21 ++++++-
 t/t9001-send-email.sh            | 118 +++++++++++++++++++++++++++++++++++++--
 3 files changed, 139 insertions(+), 7 deletions(-)
---
base-commit: 406f326d271e0bacecdb00425422c5fa3f314930
change-id: 20240808-jk-translate-alias-send-email-1ce048643e5d

Best regards,
-- 
Jacob Keller <jacob.keller@gmail.com>

