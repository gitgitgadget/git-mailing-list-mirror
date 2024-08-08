Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73441552E0
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 21:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723151408; cv=none; b=fQOxdk8NBV8n0msi7QBaQQqREvbXO41sPCgJVjmkhnnSuHgMUbMf9Nc8WV547MWBhu4+VtdG/WVQx5dS/Nz+XPKLZV7jQ0ljSDIiOdVN5gNLt3P+1KavTPuy0Q+Ime5wZ6Ek5zWNGuL3p6ZWv6TiQuhO3LZ+3tLMc5Fs04k9n1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723151408; c=relaxed/simple;
	bh=UkUhnwb6kIIXsbTGOZ4h9sUVrhNI7SzCxIBlbb7A+iI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kk4wnBwLZ6DODX8YKBnXmqJUUXjXreLSB/0oaKKSEd9OzzDY9BaezXFWUffmEJ/KvyM2f1ymslfegurEfXNZIhCJ7RB627NW783HhwzEcKCbZHPA84r14YHaECquj/Gd41nbQBnlRLsJCGoy05bLHOBI+LC1XoAZ6VFZZKxj7lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AzrAyB8b; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AzrAyB8b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723151407; x=1754687407;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=UkUhnwb6kIIXsbTGOZ4h9sUVrhNI7SzCxIBlbb7A+iI=;
  b=AzrAyB8b172WlNApLSe0N4f/lAt+OUtkPF4qkAwsxVnkmZZX/3Asozat
   JwIvia7MaVulfxJu3rs+FX9ysAOI6O5o1VR7ZM/nN5MmX2jmgjGUQVN5M
   HVgH+5K09kDaDos1RbaghrlOPIrB0ghUBbfQos8gEKfKWYofd4Ooh9/VZ
   sxERNHPMcfSqB+B3vTKP4WbaZaB8oE+PTG4AGKE+r4Bhb3o2ABBNc9T4T
   3EubNUd/s5ARGaPiovP8BkHfhanMqLJw5ird0BbhKfc1bAvOwwYeNscxH
   ZvMPYarDobDUHzQmaLrDNW0+VXzIOs6MIwDs27vxCjqt4uB7gS+3WeV6N
   g==;
X-CSE-ConnectionGUID: 9WrJ39KkSpOqUkyUIEw6Yw==
X-CSE-MsgGUID: tWNuiPnZQ9KJNaaC3hZlHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="46712892"
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="46712892"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 14:10:04 -0700
X-CSE-ConnectionGUID: E2whcA3KTpO3pxgZ9P3DgQ==
X-CSE-MsgGUID: oXz3EroUTtWkVG6lNMcEJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="61991225"
Received: from jekeller-desk.amr.corp.intel.com (HELO localhost.localdomain) ([10.166.241.1])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 14:10:04 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 08 Aug 2024 14:09:58 -0700
Subject: [PATCH 1/3] t90001-send-email.sh: fix quoting for mailrc
 --dump-aliases test
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240808-jk-translate-alias-send-email-v1-1-10a03b3d6b06@gmail.com>
References: <20240808-jk-translate-alias-send-email-v1-0-10a03b3d6b06@gmail.com>
In-Reply-To: <20240808-jk-translate-alias-send-email-v1-0-10a03b3d6b06@gmail.com>
To: git@vger.kernel.org
Cc: Jacob Keller <jacob.keller@gmail.com>, 
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>
X-Mailer: b4 0.14.0

From: Jacob Keller <jacob.keller@gmail.com>

The .mailrc alias file format documents that multiple addresses are
separated by spaces. The alias file used in the t9001 --dump-aliases
mailrc test have addresses which include both a name and email. These
are unquoted, so git send-email will parse this as an alias that
translates to multiple independent addresses.

The existing test does not care about this, as --dump-aliases only dumps
the alias and not the address. However, it is incorrect for a future
where --dump-aliases could also dump the mail addresses.

Fix the test to quote the aliases properly, so that they translate to a
single address.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 t/t9001-send-email.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 64a4ab3736ef..aa36ace393b7 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -2084,9 +2084,9 @@ test_dump_aliases '--dump-aliases mailrc format' \
 	'bob' \
 	'chloe' \
 	'eve' <<-\EOF
-	alias alice   Alice W Land <awol@example.com>
-	alias eve     Eve <eve@example.com>
-	alias bob     Robert Bobbyton <bob@example.com>
+	alias alice   "Alice W Land <awol@example.com>"
+	alias eve     "Eve <eve@example.com>"
+	alias bob     "Robert Bobbyton <bob@example.com>"
 	alias chloe   chloe@example.com
 	EOF
 

-- 
2.46.0.124.g2dc1a81c8933

