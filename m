Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EB4405C49
	for <git@vger.kernel.org>; Mon, 18 May 2026 02:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779072041; cv=none; b=P6r2xVbZ0RVOrOv8YeXPVr6tD/pSLCgRzqPIgfxIPe9yhVMr40R928/iDsp3bBEX+Mj5ko/TDdJDBBc6Kz6leetaC/kim1s57Hs/84OjWY7t+vx8lhPkWx9D8QC2QeoGo7w33h4ISgKhfdhqX0klRM494wHXPKHWukF/8JBnEgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779072041; c=relaxed/simple;
	bh=UyjbL7kMJ1oZLYyJtAqEcg6we0MPuoWnYLMw/qKWYho=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hpEPcSrCp+Qrd1cvQPmLHch32ws23JKWOP7L/BhDmjLdLIT/0ymGbmo768KysO7UWobOgnrm50QB5LkyNnDQS5HqMHOTi18D6vZeg5ePdi8L5GnYIW/8Qps1r86x9wY/2TZzpqNHx6GuTJwGP1k+IJN5QrM9oXynaomAKa+u5wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=OWJyboqo; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="OWJyboqo"
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 64I2eLLh010410-64I2eLLj010410
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 18 May 2026 05:40:22 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1wOnu1-00DOMP-Nh;
	Mon, 18 May 2026 05:40:21 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 18 May
 2026 05:40:21 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 04213b27;
	Mon, 18 May 2026 02:40:21 +0000 (UTC)
From: Tuomas Ahola <taahol@utu.fi>
To: <git@vger.kernel.org>
CC: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, Tuomas
 Ahola <taahol@utu.fi>
Subject: [PATCH] fixup! approxidate: use deferred mday adjustments for "specials"
Date: Mon, 18 May 2026 05:40:07 +0300
Message-ID: <20260518024007.18689-1-taahol@utu.fi>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260516151540.9611-5-taahol@utu.fi>
References: <20260516151540.9611-5-taahol@utu.fi>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ex19-12.utu.fi (130.232.247.52) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWUhZXkguLT4lWFxYWFhYWFBeUVxfSFlbSBwJCQAHBCgdHB1GDgFIWUhZX0gPARwbHA0aKBgHCgcQRgsHBUhYSFpIWVxIWVtYRlpbWkZaWF9GXF9IUEhYSFhIW0hYSFhIWEhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIWV9IDwEcGxwNGigYBwoHEEYLBwVIWEhZW0gYDQ4OKBgNDg5GBg0cSFg=
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:references:mime-version:content-type;
 bh=a7kLaEcSlF1/AoHVWUeVvib1IWXskpLMzZPt/KwpO34=;
 b=OWJyboqoWR1FMsgNNcvZuODiQqs0zM2jH9il9rKyp8WD7h27MzUs8xBMV9y713RbxDFaMr3KiYoz
	CeKfJMuf/5h2ITHDl7tT9otkU/TvpqQRX07zaGskkLvoJMgdrITDEU+/5XKvVc33+I86TE8wYRWG
	GqqnfULHCaw9x5ZLeeHhgSIOVIPQc0oMjSbDBcXbNSDjS2NHy4lOhxzj+S01icpJ31znjtLyQMzt
	SY/YvGwKvxavE+TCoiWq6hER010KJRHdKupTgsJoIYkxnRjtOG06KMf3e9kuScowfor3SVQw0vdg
	A+WEfTaej6FoO53wykzusJ0iAt8UXthMAkt4Lw==

Oops, let's reorder these lines.

Signed-off-by: Tuomas Ahola <taahol@utu.fi>
---
 t/t0006-date.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index b187b1bfc4..63e5628e05 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -212,9 +212,9 @@ check_approxidate 'noon today' '2009-08-30 12:00:00'
 check_approxidate 'today at noon' '2009-08-30 12:00:00' '-12 hours'
 check_approxidate 'noon today' '2009-09-01 12:00:00' '+36 hours'
 check_approxidate 'noon yesterday' '2009-08-29 12:00:00'
+check_approxidate 'noon yesterday' '2009-08-29 12:00:00' '-12 hours'
 check_approxidate 'last Friday at noon' '2009-08-28 12:00:00'
 check_approxidate 'last Friday at noon' '2009-08-28 12:00:00' '-12 hours'
-check_approxidate 'noon yesterday' '2009-08-29 12:00:00' '-12 hours'
 check_approxidate 'tea last saturday' '2009-08-29 17:00:00'
 check_approxidate 'tea last saturday' '2009-08-29 17:00:00' '-12 hours'
 check_approxidate 'January 5th noon pm' '2009-01-05 12:00:00'

base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
prerequisite-patch-id: 699b43ba1ff3235d54fa068f4c9b5ab5aa58eacc
prerequisite-patch-id: 2ab5ce03bce8b2953b418fe884f45fbd4a629337
prerequisite-patch-id: 52e3b766b9c6f148f09682b898bf5244b22ae0ba
prerequisite-patch-id: 1cd0e7498368f7c3b1833f12d56fefe732dd0413
-- 
2.30.2

