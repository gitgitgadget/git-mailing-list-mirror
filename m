Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDB43546E5
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 05:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788931518; cv=none; b=MQYryewihet5Lo18xSRtyfwOs/5A5ZU1uASGxPwioJTDAr7eFgdVPqFM/aqh0wb5sd59ONWB0zDybPe6hg90n2u/nuksPIOwWV/qlj48POfhK+FzpkI4M5fTkYjSFb7s3htirbOnXEJIrik+okeOXmFfoMSqMAd2qP3mHaLwFjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788931518; c=relaxed/simple;
	bh=ikPMqO5dlyfF/VtusHpGgnuH/Fvgml1975WIircNYEs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=COUcTrhZ76v56NN9b6FOvgnKI5YoWPQwGz84eeawPjFiuzOEndzlqA3rvZ600kvjZQwwjeW4OyLbf2VTIn9WZQHXHqkL/un/o28/oqnZYhdLz6gcWUtqQVlBopUujv8ElmIR46810eDr5Z7jOZgqz5VKPISlu5zxwRd1rtDtJ0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=WJcQQQRA; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="WJcQQQRA"
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 6895P7mS022861-6895P7mU022861
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 9 Sep 2026 08:25:07 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1x4Anz-00BSH1-0b
	for git@vger.kernel.org;
	Wed, 09 Sep 2026 08:25:07 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 9 Sep
 2026 08:25:06 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id ccd3787f;
	Wed, 9 Sep 2026 05:25:06 +0000 (UTC)
From: Tuomas Ahola <taahol@utu.fi>
To: <git@vger.kernel.org>
CC: Tuomas Ahola <taahol@utu.fi>
Subject: [PATCH 1/2] command-list: add gitformat-loose(5) and gitpacking(7)
Date: Wed, 9 Sep 2026 08:25:00 +0300
Message-ID: <20260909052501.8448-2-taahol@utu.fi>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260909052501.8448-1-taahol@utu.fi>
References: <20260909052501.8448-1-taahol@utu.fi>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ex19-16.utu.fi (130.232.247.56) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZUUgPARwoHg8NGkYDDRoGDQRG
 BxoPSFhIWkhZXEhZW1hGWltaRlpYX0ZcX0hQSFhIWEhZSFhIWEhYSFlRSA8BHCgeDw0aRgMNGgYNBEYHGg9IWA==
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:references:mime-version:content-type;
 bh=aZznzLpDaoD8fSXkjxkpAwHGToL6I5Y/mcJKcfCqY90=;
 b=WJcQQQRAD12Qdt3PPphZQrNUY8nHQYt1speHy2Cs8k1BnM+mOmUZRkU38f8TZEvWYYcmHeNESQv4
	1E1BZE2/atKaecJNBZ9qUxM42P69i1LhX06glL1b/Eaer42k3klUbA1qAtr9OCTKsUanPouvUg7+
	kodGwEVYDxRhguIT4GeWRCly/YQBmhTiPrN6IhDIOyuKd6dat++MkZtcEmhTDvcf+u1vGUwmJvbZ
	NQU5Kkmj+u6vdiU6lWIBJt6B9gy/E+rXCY1V72EUPfBHeO/VKai3/dKA5oj0hal2cnhU7rZdM+Z2
	x1qsiWXPYTrX2ZxMbW+sU8pThoQ7Er5nfvFjJA==

Three manpages from sections 5 and 7 are not featured in
command-list.txt as concept guides or interface manuals.

As easy fixes, add gitformat-loose(5) to 'developerinterfaces'
and make gitpacking(7) a 'guide'.

That leaves only gitweb.conf(5) which could be added to
'userinterfaces'.  However, the manual would then appear
as "web.conf" in `git help -a` which is just confusing.
So, perhaps we are better off by leaving it out.

Signed-off-by: Tuomas Ahola <taahol@utu.fi>
---
 command-list.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/command-list.txt b/command-list.txt
index 63ae2a67c9..955eec6e7e 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -225,6 +225,7 @@ gitformat-bundle                        developerinterfaces
 gitformat-chunk                         developerinterfaces
 gitformat-commit-graph                  developerinterfaces
 gitformat-index                         developerinterfaces
+gitformat-loose                         developerinterfaces
 gitformat-pack                          developerinterfaces
 gitformat-signature                     developerinterfaces
 gitglossary                             guide
@@ -234,6 +235,7 @@ gitk                                    mainporcelain
 gitmailmap                              userinterfaces
 gitmodules                              userinterfaces
 gitnamespaces                           guide
+gitpacking                              guide
 gitprotocol-capabilities                developerinterfaces
 gitprotocol-common                      developerinterfaces
 gitprotocol-http                        developerinterfaces
-- 
ta/command-list-guides-sync-lint

