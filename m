Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F2F110A
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 00:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723593923; cv=none; b=XLOobTqw0yyEL3hNslrkzCXF/21mzSGPI6JyRq0ho+j0z3DgT3NksYxjwdSsFQKAQj1Gmiud/v7dD5w4tf5Rq1odkqillkUboPzD4jlgV1jjGTE/gG5dT6kCN9bkg1MmpPnwcsCptUHYIypq7ocKAXsHmMMZ8iNm5Ob3b9Q+DhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723593923; c=relaxed/simple;
	bh=UkUhnwb6kIIXsbTGOZ4h9sUVrhNI7SzCxIBlbb7A+iI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vEf5WVQn6+x3b3oaCrp8c4ybXEq3PTVicCRURiTgdE5xgCLkGV0QIYcMUJKJ/UZFgX/+EUMBGmzNPW7xAhtRRNmv5l1w3W0KjmHCIhDRwg1N9eIUC9U3fc1ibNlUCZ2BGEFHlnY2vkeUtHnDFFgf1cV378TMHGRA2jULOu6Br+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ft1HA1MH; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ft1HA1MH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723593921; x=1755129921;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=UkUhnwb6kIIXsbTGOZ4h9sUVrhNI7SzCxIBlbb7A+iI=;
  b=Ft1HA1MHDWkv0sRVjigE2HdbsCa+M/rmC4ZCWJHkHrmPkiGa/5KO5OLn
   XrN0wdcjwdDPM1iYk1tL3pELtIM6E4Baq44VXskkFwJKf3+G1Eqmw3nQP
   0Nad8gCJ8mWs1XeBFxfzS98JH1bnGy8vNeCxv2N4nS01vAAnl8eerMzKO
   GkPuuLfPHFQUxcGum8F79+jUrD0hwrRkTAzMMQlwEZkFLMxupVSUE7ZjV
   3ICtAwWKcg3tUzF/LHeqHlNfrYkCvr7hAHni/ePFGW0hKcZ7BZzYBikVy
   OeTUdDsUTs4TI9JE7PUNya4Cu+AXhEOO9+NJQz5eg+DOWoSiihHLbaPm/
   A==;
X-CSE-ConnectionGUID: QxFrcFTyShWbVHnophdxtA==
X-CSE-MsgGUID: YuDVhj0rQIWOQMSt69mXyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="32933062"
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="32933062"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 17:05:18 -0700
X-CSE-ConnectionGUID: qWPxCPAiTn635rP13ZUZWw==
X-CSE-MsgGUID: MjtJwfoLRFuEbiW1YwVCjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="63767464"
Received: from jekeller-desk.amr.corp.intel.com (HELO localhost.localdomain) ([10.166.241.1])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 17:05:18 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 13 Aug 2024 17:05:09 -0700
Subject: [PATCH v2 1/3] t90001-send-email.sh: fix quoting for mailrc
 --dump-aliases test
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-jk-translate-alias-send-email-v2-1-912db4eb6846@gmail.com>
References: <20240813-jk-translate-alias-send-email-v2-0-912db4eb6846@gmail.com>
In-Reply-To: <20240813-jk-translate-alias-send-email-v2-0-912db4eb6846@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
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

