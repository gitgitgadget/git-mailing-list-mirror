Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EFE3ADB97
	for <git@vger.kernel.org>; Tue, 12 May 2026 15:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778598591; cv=none; b=YINu9yit1U0o4ZDJjtX3kVYxsfoOhcURBtOp6+OrXg907O3CUjBqt4jyxaBHF3fhCC+1G3PlcptUjpkEthaXJQPL/xDUuZZO9bKcMvlxS0wYpjLALXlkGP/tnvly3Ls5mWe9BxKRTAxXpg0sW5cpa5mweGLo/6VajDnWksDms1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778598591; c=relaxed/simple;
	bh=Jy7Yf3MOynrmO9nA5M+GRAcoEB/DSmLhsJ1KLhxkDQI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cCe5JeJ3vDrVjVjIRw3Imd1uN9eaUy5zOemR4XxxKR51EvbVbCN4En2LClGY8VuPEayYYVhlcO2/Pul7KJJVeZYlWnej9vyzMKNKd1dS+8R0td7GSc42wWPJSaL4610GA2uHMX6YtBVUZdY3c0f6Qu2ge0ORTIWhmL79/JF1C5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=Ijt11v7A; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="Ijt11v7A"
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 64CEsW27022943-64CEsW29022943
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 12 May 2026 17:54:32 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1wMoVE-003hXa-LX;
	Tue, 12 May 2026 17:54:32 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 12 May
 2026 17:54:32 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 7e610857;
	Tue, 12 May 2026 14:54:31 +0000 (UTC)
From: Tuomas Ahola <taahol@utu.fi>
To: <git@vger.kernel.org>
CC: Jeff King <peff@peff.net>, Tuomas Ahola <taahol@utu.fi>
Subject: [PATCH v2 2/3] approxidate: make "specials" respect fixed day-of-month
Date: Tue, 12 May 2026 17:54:29 +0300
Message-ID: <20260512145430.13212-3-taahol@utu.fi>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260512145430.13212-1-taahol@utu.fi>
References: <20250318180201.3653-1-taahol@utu.fi>
 <20260512145430.13212-1-taahol@utu.fi>
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
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWUhZXkguLT4lWFxYWFhYWFBeUVxfSFlbSBwJCQAHBCgdHB1GDgFIWUhZW0gYDQ4OKBgNDg5GBg0cSFhIWkhZXEhZW1hGWltaRlpYX0ZcX0hQSFhIWEhaSFhIWEhYSFlRSA8BHCgeDw0aRgMNGgYNBEYHGg9IWEhZW0gYDQ4OKBgNDg5GBg0cSFg=
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:references:mime-version:content-type;
 bh=piW2V8rywzjBdQWyQ00h5oKQkQIBCFoOwVJvLIjfXyE=;
 b=Ijt11v7AlPTh7kKecASkqgC6S79sYyAboDQLucpiD3quPP4hlsa3JPP5F01O7lPB3/n4jLK7oBUa
	s2qWZDrRgPcE7kxkVCwfMuRWu18+O3822HRRYPxM/BPXVebmWw2/YHnlN5ANvplNUB1IsO15A8sv
	xBZ2ea9C7O1Lz60/O/huy3venIf3dRtKSJtkiDcTYPuAYC6/PIFCfyG4IiuaxRKl1cvirGMTWna0
	duHJSkWwY1k+IMd7ckesTUswGuvua6y5xAAdYjXYhdjxkiozc0hcZWX9IubCpD9ZQJGTY0UtFd43
	Gb3t1Q3nYDIlolHNY2MJaJCZ4OMCzlwh1hAhfA==

The special approxidate time formats, "noon" and "tea", wrap
to the previous day if the current time is before 12 or 5 pm,
respectively.  That holds even when an actual date is supplied;
therefore, "10 May at tea" and "last Friday at noon" can cause
the date to be set to a seemingly wrong day:

	now -> 2026-05-12 11:00:00 +0000
	10 May at tea -> 2026-05-09 17:00:00 +0000
	last Friday at noon -> 2026-05-07 12:00:00 +0000
	One year ago yesterday at tea-time -> 2025-05-10 17:00:00 +0000

The last example is from Linus Torvalds who remarked in 2006
that the answer was "just silly and not even correct." [1]

As "last Friday at noon" is mentioned in the documentation
(date-formats.adoc) it would be nice if it worked correctly.
Let's fix the glitch with a simple patch.

Check whether we already have a specified (non-negative) mday
and make date_time() stick to it.  Add a suitable time offset
to the relevant test.

While we are at it, add "today" as an alias of "now", so that
"today at noon" will do the right thing, too, and assert that
with a new test.

Links:
  1. https://lore.kernel.org/git/Pine.LNX.4.64.0610101102560.3952@g5.osdl.org/

Signed-off-by: Tuomas Ahola <taahol@utu.fi>
---
 date.c          | 8 +++++++-
 t/t0006-date.sh | 4 ++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/date.c b/date.c
index 17a95077cf..e48cc2a4d7 100644
--- a/date.c
+++ b/date.c
@@ -1132,7 +1132,12 @@ static void date_yesterday(struct tm *tm, struct tm *now, int *num)
 
 static void date_time(struct tm *tm, struct tm *now, int hour)
 {
-	if (tm->tm_hour < hour)
+	/*
+	 * By default, "tea" and "noon" refer to last such time in the
+	 * past, be it today or yesterday.  With a specified mday,
+	 * that logic is overridden.
+	 */
+	if (tm->tm_mday < 0 && tm->tm_hour < hour)
 		update_tm(tm, now, 24*60*60);
 	tm->tm_hour = hour;
 	tm->tm_min = 0;
@@ -1204,6 +1209,7 @@ static const struct special {
 	{ "AM", date_am },
 	{ "never", date_never },
 	{ "now", date_now },
+	{ "today", date_now },
 	{ NULL }
 };
 
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index 5d66267672..e01d093514 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -186,8 +186,12 @@ check_approxidate '6pm yesterday' '2009-08-29 18:00:00'
 check_approxidate '3:00' '2009-08-30 03:00:00'
 check_approxidate '15:00' '2009-08-30 15:00:00'
 check_approxidate 'noon today' '2009-08-30 12:00:00'
+check_approxidate 'today at noon' '2009-08-30 12:00:00' success -12
 check_approxidate 'noon yesterday' '2009-08-29 12:00:00'
+check_approxidate 'last Friday at noon' '2009-08-28 12:00:00'
+check_approxidate 'last Friday at noon' '2009-08-28 12:00:00' success -12
 check_approxidate 'January 5th noon pm' '2009-01-05 12:00:00'
+check_approxidate 'January 5th noon pm' '2009-01-05 12:00:00' success -12
 check_approxidate '10am noon' '2009-08-29 12:00:00'
 check_approxidate 'January 5th yesterday' '2009-01-29 19:20:00'
 check_approxidate 'January 5th yesterday' '2008-12-31 19:20:00' success +48
-- 
2.30.2

