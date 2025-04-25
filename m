Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A9A29B0
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 00:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745540452; cv=none; b=Rv6grYzvCHfu/YnSs8qEE1iTH76V7rOlYqtx81ul4VfYdXqPs6H2opHJ92MvTq11jKkqVDHpKvURxLrT6mL8jT8wdP6d9vEB0tXwLHyU/UX6h6pJzVHOgJdmPlWT+I1j2ZWhdrrptxBH/4NJpy7gT5+UbHQi0IMb1hrzIal2lW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745540452; c=relaxed/simple;
	bh=L+DG/cwKT6ug05L8xgCrGfrst1VD2pjszTsKCYWbKpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lk7/W/X1jYhJRT2uyojW0wr/7grKKoyIZQbRhUHD8GmhyzNdMJ6tEiJx9Hk2brnrNfil25BV5wqP1aFMk0F81JAgvMJEmqjzZoXHktesbfOSccUWsqKqWEm7KlAdYRLDG/Yh9APPROmfsSLfLqQzga46OlgBWtToocBVen1jFCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from acleverhostname.lan (unknown [IPv6:2603:6011:3f0:6f00::12ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: eschwartz@gentoo.org)
	by smtp.gentoo.org (Postfix) with ESMTPSA id E18A4342FB5;
	Fri, 25 Apr 2025 00:20:49 +0000 (UTC)
From: Eli Schwartz <eschwartz@gentoo.org>
To: git@vger.kernel.org
Cc: Sam James <sam@gentoo.org>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/6] meson: miscellaneous system detection fixes
Date: Thu, 24 Apr 2025 20:13:29 -0400
Message-ID: <20250425002017.246985-1-eschwartz@gentoo.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250421175247.240971-1-eschwartz@gentoo.org>
References: <20250421175247.240971-1-eschwartz@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Principally motivated to handle an issue where these were failing to
detect the system properly, on Solaris.

Eli Schwartz (6):
  meson: simplify and parameterize various standard function checks
  meson: check for getpagesize before using it
  meson: do a full usage-based compile check for sysinfo
  meson: add a couple missing networking dependencies
  meson: fix typo in function check that prevented checking for
    hstrerror
  meson: only check for missing networking syms on non-Windows; add
    compat impls

 meson.build | 105 ++++++++++++++++++++++++----------------------------
 1 file changed, 49 insertions(+), 56 deletions(-)

Range-diff against v1:
1:  e137afaff2 = 1:  e137afaff2 meson: simplify and parameterize various standard function checks
2:  df82ee7872 ! 2:  3c4918a7b3 meson: check for getpagesize before using it
    @@ Commit message
         config.mak.uname defines this automatically, though only for QNX.
     
      ## meson.build ##
    -@@ meson.build: checkfuncs = [
    -   'mkdtemp',
    -   # no compat
    -   'initgroups',
    -+  # no compat
    -+  'getpagesize',
    - ]
    +@@ meson.build: else
    +     'mmap',
    +     # unsetenv is provided by compat/mingw.c.
    +     'unsetenv',
    ++    # no compat, is provided by compat/mingw.c
    ++    'getpagesize',
    +   ]
    + endif
      
    - if host_machine.system() == 'windows'
3:  2ec759d7be = 3:  2c19f04f3e meson: do a full usage-based compile check for sysinfo
4:  61f2addd47 = 4:  e62057094f meson: add a couple missing networking dependencies
5:  c67d10a337 = 5:  a6a7bdacd1 meson: fix typo in function check that prevented checking for hstrerror
6:  c5b8b89dd4 = 6:  15f48b8991 meson: only check for missing networking syms on non-Windows; add compat impls
-- 
2.49.0

