Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87447416875
	for <git@vger.kernel.org>; Sat, 29 Aug 2026 18:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788028632; cv=none; b=ObjTChyaEfc9WL7BVdQHvjSqYM9oTPJO5r5X9kDauNYRbmbYvvTMVOR209pVtwXkZpG33TLX8iK4N+JmK/6bD6/eENVTQAsWDWSa+M1j+v1m72NLt22LDjOw9ZUp2yvnz5Pe2a7RSXCd1yLEEQdcgYHg9GJz3cmBlPCUvfr+Dx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788028632; c=relaxed/simple;
	bh=gZmIwuYIz/RTspGfKC6n/IS678IGHzS2RTe9ONCtE0U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tBiDPQqKhvN9PN5EeP8hg7o1hUlUFQUQYbcYvS5Du7q5q7ltrzbVzzYY3juDTBCgv2Mt8mCToxIlwnncnSzQshmragJw469vANvMjBscJpl74omcXyeURJRCaDwx29K3XwccsEqh/j1GEHP9H1BxS79DwZGrQMEGnbBO70IHdAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.eu; spf=pass smtp.mailfrom=posteo.eu; dkim=pass (2048-bit key) header.d=posteo.eu header.i=@posteo.eu header.b=E+Ai1bBi; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.eu header.i=@posteo.eu header.b="E+Ai1bBi"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 11801240027
	for <git@vger.kernel.org>; Sat, 29 Aug 2026 20:37:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.eu;
	s=1984.8680eb; t=1788028625;
	bh=hzcHZLu/WCvODE/+BMrQAuWCpRa6PfyjIKxLYy2FK1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=E+Ai1bBiDfsV+jVzMoYD6iIlOjB7r1Kf9W+gI6EFvPUIgn4x8amb23QdBH1kRk8vP
	 5qpr6ZrmWeq8ElFlAnpg4RutqE7oeohhkDzFkR37C6VCUVhDuDgaLCkT2A2ayb563s
	 V1aE+QsdT6bZcJJqRhP8bN+R0O7DScq9wWOod0l44URyG85ZlW6qPfVg9RHmGzQIC3
	 biAZwi/9o2NhjRulnNBlwJt327pDBWpTRYmn/kYFwguxDL7S+UrJKMMHuTHaIvg9c5
	 bga5uEfnIMmUgyoJ2p7Qnwq9/o1heNnSIX02k1MffDH4/YECnil3nqXf+XngDU8XbM
	 o4JjUYvTn6kuQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hXP9r4pwCz9rxD;
	Sat, 29 Aug 2026 20:37:04 +0200 (CEST)
From: Lorenz Leutgeb <lorenz.leutgeb@posteo.eu>
To: git@vger.kernel.org
Cc: Lorenz Leutgeb <lorenz.leutgeb@posteo.eu>
Subject: [PATCH] doc: remote-helpers: option pushcert if-asked
Date: Sat, 29 Aug 2026 18:37:04 +0000
Message-ID: <20260829183659.29947-1-lorenz.leutgeb@posteo.eu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The documentation mentions that the value for the option "pushcert" is
"true" or "false". This is incomplete, as can be seen by analyzing
transport-helper.c:1009-1018 (added in commit 30261094b1f7fdcba3b7a1)
which also implements setting the option to the value "if-asked".

Add the third value to the documentation (added in commit b9299a2bb1).

Signed-off-by: Lorenz Leutgeb <lorenz.leutgeb@posteo.eu>
---
 Documentation/gitremote-helpers.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitremote-helpers.adoc b/Documentation/gitremote-helpers.adoc
index 39cdece16e..10921e91b9 100644
--- a/Documentation/gitremote-helpers.adoc
+++ b/Documentation/gitremote-helpers.adoc
@@ -523,7 +523,7 @@ set by Git if the remote helper has the 'option' capability.
 'option update-shallow' {'true'|'false'}::
 	Allow to extend .git/shallow if the new refs require it.
 
-'option pushcert' {'true'|'false'}::
+'option pushcert' {'true'|'false'|'if-asked'}::
 	GPG sign pushes.
 
 'option push-option' <string>::
-- 
2.55.0

