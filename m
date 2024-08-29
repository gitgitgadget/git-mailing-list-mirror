Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1286816C86D
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 19:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724961580; cv=none; b=qCH20j6WSz4eu9NseIH+cp1dxplxDAJ+zycx+//PzG5nI+h3F9tZbDyAWfaf5ZlDZ6F/xeVwoptq7/Marzxc4FB6+Ay4RXE3SwX9HQxZK9xjj5OHuWIe1yZmJjLffWFzogLYfxskNucZUaaM+pE5YCYeheH0IpmKrQOdYdNePt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724961580; c=relaxed/simple;
	bh=smHal/aMZeDEaBnrCL0TIfhDwFKSdh/4gEyZwgM6jrQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nsw+UDVoW7zoLUpvKOtBJq02ybuESGM5rERBc/rBAcqruxK1Xcb5Dipmd0Mvxg3ctpirSaHcXI6rAOPbLogntE/rkq0FqctgUcqO4wOq+aXJt/yYd0viC9U0gS4zesoSiTrQFrLIoJYPZRm8uBtGX4B8+OiORXRD5/K8sGk+vPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=yK6NTh27; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yK6NTh27"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B14F325103;
	Thu, 29 Aug 2024 15:59:37 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=smHal/aMZeDEaBnrCL0TIfhDwFKSdh/4gEyZwg
	M6jrQ=; b=yK6NTh27kSoNPE4Hh0z5aQY9uEbvtQrIxxKZ2YChZacnr5ajcr2gn3
	CF1v+V+WQusKjCGSszyAB/qcW8TcNfP3PKHiZpHNv5ardpYxFNbVFOzHo2+J31NK
	qJbpQLwNvc/SBzTdZ0ofD8O1iY5TxS7M6nDAI9yr0pguhne5MOFD0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A873625102;
	Thu, 29 Aug 2024 15:59:37 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 17D87250FF;
	Thu, 29 Aug 2024 15:59:37 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Calvin Wan <calvinwan@google.com>
Subject: Re: [PATCH 00/21] environment: guard reliance on `the_repository`
In-Reply-To: <cover.1724923648.git.ps@pks.im> (Patrick Steinhardt's message of
	"Thu, 29 Aug 2024 11:38:19 +0200")
References: <cover.1724923648.git.ps@pks.im>
Date: Thu, 29 Aug 2024 12:59:35 -0700
Message-ID: <xmqqle0fuml4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 380E1584-6641-11EF-8D3D-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

There may be more, but I know at least of these at the moment from
https://github.com/git/git/actions/runs/10619536685/job/29437358521

Perhaps this can become [0.5/21] of the series, before globals are
hidden behind the macro.

--- >8 ---
Subject: [PATCH] win32: mark the sources that depend on the_repository

These source files still need access to the global variables like
"ignore_case" and "protect_ntfs".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 compat/mingw.c            | 2 ++
 compat/win32/path-utils.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index 29d3f09768..5c2080c04c 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "../git-compat-util.h"
 #include "win32.h"
 #include <aclapi.h>
diff --git a/compat/win32/path-utils.c b/compat/win32/path-utils.c
index b658ca3f81..966ef779b9 100644
--- a/compat/win32/path-utils.c
+++ b/compat/win32/path-utils.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "../../git-compat-util.h"
 #include "../../environment.h"
 
-- 
2.46.0-567-gbce23f156d

