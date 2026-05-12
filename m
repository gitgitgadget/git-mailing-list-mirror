Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A902C3B1ECC
	for <git@vger.kernel.org>; Tue, 12 May 2026 15:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778598591; cv=none; b=tg/tVx1j8pwsMmfQezsmdwZOPPEN2+Ro8JiHVnIoX7eF6m2bcY2XkSiJIdL54uqxW3GAuWsF7SAm+Z7XW5NVSYPpLZw4jfH/rmbP50fXfLUTA3+1fVZ4pG9fpm5TYonNz8NiQVy8kjXj6W481d6Z71FkJ6Ss+xeZect55lwlr3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778598591; c=relaxed/simple;
	bh=Uqkv0y3WP9EGXwHJ0bkQWChNnsjSCg0oBTTNGSyNbEM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DrF7cjhE7nb+/QxHSU+vR8Ke7MLhpaV5k70znfFCeSDxzqH2ddDaNyvW5ghXzWRC7i7hzFuCaoS9owuomFbJ0boG7qRn3REBL1i0pip+/XUQ+xHoQSbB+wVa3bclbCi2iY8gMJrQqqQQ3PDPOSbxNTVPnbOCP3/Fj5jGx9RqUjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=oLPzd796; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="oLPzd796"
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 64CEsWHd022934-64CEsWHf022934
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 12 May 2026 17:54:32 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1wMoVE-003hXX-9z;
	Tue, 12 May 2026 17:54:32 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 12 May
 2026 17:54:32 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 6f19b728;
	Tue, 12 May 2026 14:54:31 +0000 (UTC)
From: Tuomas Ahola <taahol@utu.fi>
To: <git@vger.kernel.org>
CC: Jeff King <peff@peff.net>, Tuomas Ahola <taahol@utu.fi>
Subject: [PATCH v2 0/3] approxidate: tweak special date formats
Date: Tue, 12 May 2026 17:54:27 +0300
Message-ID: <20260512145430.13212-1-taahol@utu.fi>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250318180201.3653-1-taahol@utu.fi>
References: <20250318180201.3653-1-taahol@utu.fi>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ex19-05.utu.fi (130.232.247.45) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWUhZXkguLT4lWFxYWFhYWFBeUVxfSFlbSBwJCQAHBCgdHB1GDgFIWUhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIWkhZXEhZW1hGWltaRlpYX0ZcX0hQSFhIWEhaSFhIWEhYSFlRSA8BHCgeDw0aRgMNGgYNBEYHGg9IWEhZW0gYDQ4OKBgNDg5GBg0cSFg=
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:references:mime-version:content-type;
 bh=Iguoe+wewnku9MzPYe2S51d5edlCBy6L/INtQYT54UI=;
 b=oLPzd796uPCrxjsd8vF+ugCAT0cOYkzvZ3WWh6hbyIXukA79uo1hMLcekT/CJqLEaICKXXggFyGy
	nyCh+dnvi5tJ1DmrS0OdiqIs43r2GuEJTs4Qmh4UQPI9ZAmDkFqdp+JKOo0uXFBi1ygmaPvC6kIy
	WhNbBF2PjkaBLb1c5GGcjImd+7fc+c0jQ0XjBIXSWcpvFHNDKgaNk1NwQgRLVM/LpZ7cpzktrhXB
	ZZ+08s4EJIkLZLQsR1VeRGrBAJUyrzrSgTJXD3P9RxS/z7PWS/OvJo3ngyTTUiKy98/ZHW2FGJZK
	LZUecFjU+sFoM71kcSGSA4cxp89pQeZg2AzHEA==

The approxidate system is an endless source of absurdities.  Let's make the
usual "eh, that's crazy, let's do better with this input" type of fix[1], and
tweak some sharp edge cases, including one noticed by Linus back in 2006[2].

After this series, "tea" and "noon" will work predictably with all kinds of
date formats (today, yesterday, last Friday, January 5th, one year ago
yesterday...) regardless of the current time of day.

Links:
  1. https://lore.kernel.org/git/20181115144854.GB16450@sigill.intra.peff.net/
  2. https://lore.kernel.org/git/Pine.LNX.4.64.0610101102560.3952@g5.osdl.org/

Tuomas Ahola (3):
  t0006: add support for approxidate test date adjustment
  approxidate: make "specials" respect fixed day-of-month
  approxidate: use deferred mday adjustments for "specials"

 date.c          | 37 +++++++++++++++++++++++++++----------
 t/t0006-date.sh | 19 ++++++++++++++++++-
 2 files changed, 45 insertions(+), 11 deletions(-)

Intervall-diff mot v1:
1:  9bfff739fd < -:  ---------- approxidate: make "specials" respect fixed day-of-month
2:  1a4398e5a1 < -:  ---------- approxidate: overwrite tm_mday for `now` and `yesterday`
-:  ---------- > 1:  118f1825ac t0006: add support for approxidate test date adjustment
-:  ---------- > 2:  21c4858c47 approxidate: make "specials" respect fixed day-of-month
-:  ---------- > 3:  cf72403102 approxidate: use deferred mday adjustments for "specials"

base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
-- 
2.30.2

