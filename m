Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A76517B505
	for <git@vger.kernel.org>; Sat, 16 May 2026 15:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778944553; cv=none; b=Ca7+xL9IA0LhzM2cXr1tBUFDz06pJMhhpAo6bFrXUjahAwssjGU8fTW+j6vqb63uuGPNtirIboQ7ksoEVR+MhStQP9jldt4W2+bJQr7tGtVD59/sOssgAWzCyKFRZ4GHyrjxkdPwRayV5pr1UnGaqKuHOBQN8vmDTXZpmSGTKEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778944553; c=relaxed/simple;
	bh=XxZrXw1umIzjaCnXmUFbXYdE0OSfqB9OJ4QLxElkKpU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O72P0JATiYKvbisKGeXUMRAedekUtLPdEacGfJANLLy4Y1Ys4m2430yuuE4RXc/9/u6ffZdUvNPsHPeGx0xPYNQRLao3xA3Scl3dtW6vUeJuq6X4GiydhuIi6dwioQL2k0os2DQEMnl/RkQqyNdREFSixVcywT4c9lVJQpaSb8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=lcXCJ9fC; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="lcXCJ9fC"
Received: from smtp-03.utu.fi (smtp-03.utu.fi [130.232.207.30])
	by fortymile.utu.fi  with ESMTPS id 64GFFhVc019490-64GFFhVe019490
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sat, 16 May 2026 18:15:43 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-03.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1wOGjv-00B0Pq-AE;
	Sat, 16 May 2026 18:15:43 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Sat, 16 May
 2026 18:15:43 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id fb1b5b3d;
	Sat, 16 May 2026 15:15:42 +0000 (UTC)
From: Tuomas Ahola <taahol@utu.fi>
To: <git@vger.kernel.org>
CC: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, Tuomas
 Ahola <taahol@utu.fi>
Subject: [PATCH v4 4/4] approxidate: use deferred mday adjustments for "specials"
Date: Sat, 16 May 2026 18:15:40 +0300
Message-ID: <20260516151540.9611-5-taahol@utu.fi>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260516151540.9611-1-taahol@utu.fi>
References: <20260514115520.6660-1-taahol@utu.fi>
 <20260516151540.9611-1-taahol@utu.fi>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ex19-08.utu.fi (130.232.247.48) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWUhZXkguLT4lWFxYWFhYWFBeUVxfSFlbSBwJCQAHBCgdHB1GDgFIWUhZX0gPARwbHA0aKBgHCgcQRgsHBUhYSFpIWVxIWVtYRlpbWkZaWF9GW1hIUEhYSFhIW0hYSFhIWEhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIWV9IDwEcGxwNGigYBwoHEEYLBwVIWEhZW0gYDQ4OKBgNDg5GBg0cSFg=
X-FEAS-Client-IP: 130.232.207.30
X-FE-Last-Public-Client-IP: 130.232.207.30
X-FE-Policy-ID: 3:5:2:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:references:mime-version:content-type;
 bh=4Ch/BW/nQ1bRcrvuHeAXJvFg/34ks3GxavHqlh/rDSA=;
 b=lcXCJ9fCyiKo6RIO3U4UfscBTkcXMFk5EJT1T2xSUXAFuOjarUDhbwo+CMGPMojdwSZp/GM3s5lA
	hgmQBCQTV7obTj6K53ziK6SZkaHcFSa3vFjdVk3qIqECPLQq9fBHIEcEbWhK4q1Bi9zcpxx0UHAw
	3TzzhTrif8tfQyNK3jNcvKsKb1dq/krxOODyiTNufc26T1hbWrPEkPIO/ewm8H/ANahrjlTr3v2f
	OlAJAQl3e5fN2ucmoOYttEdVHXnfEo4UDwoXCI4PmQY5Tc3lRNuKlRjLJslJth6579Q3SGV9rSVV
	xkEdkW5H1Us3y+I0SbEO0Mr2Jw+HNTKs3osRCA==

There are cases where the "wrap-to-yesterday" behavior of "tea" and
"noon" should be reverted later on down the line, so that "today tea"
and "tea today" won't yield different results.  However, the logic of
approxidate doesn't seem to lend itself particularly well to
such cases.

Start tackling the issue by reusing negative values of `tm->tm_mday`
field for deferred date adjustments which can be easily reverted, so
that the default logic of the special formats only applies if we don't
get any explicit date (mday) specification.  In particular, overwrite
the field with -1 in "today" and "yesterday", so that those formats will
be relative to the current date.  That makes specifications like "tea
yesterday" behave more sensibly: instead of going backwards to the
last tea-time and then a day back, Git will now understand that as the
tea-time of yesterday.

Replace the call of `update_tm()` in `date_time()` with the assignment
`tm->tm_mday = -2`.  Add the corresponding code to handle that in
`update_tm()`, wrapping to the previous day if the field still holds
such assignment, meaning that we haven't seen any better specification
for the day-of-month.  On the other hand, `mday=-3` would mean going
two days back and so on.  Even though such functionality isn't
actually needed by this patch, it won't add much complexity in the
code and is rather natural way to handle such values.

As `date_time()` won't no longer need the `now` struct, mark the
associated function parameters as unused.  The parameters themselves
have to stay, however, as those functions are called through pointers
in `approxidate_alpha`.  Add relevant tests to cover the changes.

Signed-off-by: Tuomas Ahola <taahol@utu.fi>
---
 date.c          | 31 +++++++++++++++++++++----------
 t/t0006-date.sh |  4 ++++
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/date.c b/date.c
index 7a458f3cac..6e7cf907da 100644
--- a/date.c
+++ b/date.c
@@ -1071,13 +1071,22 @@ void datestamp(struct strbuf *out)
 /*
  * Relative time update (eg "2 days ago").  If we haven't set the time
  * yet, we need to set it from current time.
+ *
+ * The tm->tm_mday field has an additional logic of using negative values
+ * for date adjustments: -2 means yesterday and -3 the day before that,
+ * and so on.  The idea is to deref such adjustments until we are sure
+ * there's no explicit mday specification in the approxidate string.
  */
 static time_t update_tm(struct tm *tm, struct tm *now, time_t sec)
 {
 	time_t n;
 
-	if (tm->tm_mday < 0)
+	if (tm->tm_mday < 0) {
+		int offset = tm->tm_mday + 1;
+		if (sec == 0 && offset < 0)
+			sec = -offset * 24*60*60;
 		tm->tm_mday = now->tm_mday;
+	}
 	if (tm->tm_mon < 0)
 		tm->tm_mon = now->tm_mon;
 	if (tm->tm_year < 0) {
@@ -1127,38 +1136,39 @@ static void date_now(struct tm *tm, struct tm *now, int *num)
 static void date_yesterday(struct tm *tm, struct tm *now, int *num)
 {
 	*num = 0;
+	tm->tm_mday = -1;
 	update_tm(tm, now, 24*60*60);
 }
 
-static void date_time(struct tm *tm, struct tm *now, int hour)
+static void date_time(struct tm *tm, int hour)
 {
 	/*
 	 * If we do not yet have a specified day, we'll use the most recent
 	 * version of "hour" relative to now.  But that may be yesterday.
 	 */
 	if (tm->tm_mday < 0 && tm->tm_hour < hour)
-		update_tm(tm, now, 24*60*60);
+		tm->tm_mday = -2; /* eventually handled by update_tm() */
 	tm->tm_hour = hour;
 	tm->tm_min = 0;
 	tm->tm_sec = 0;
 }
 
-static void date_midnight(struct tm *tm, struct tm *now, int *num)
+static void date_midnight(struct tm *tm, struct tm *now UNUSED, int *num)
 {
 	pending_number(tm, num);
-	date_time(tm, now, 0);
+	date_time(tm, 0);
 }
 
-static void date_noon(struct tm *tm, struct tm *now, int *num)
+static void date_noon(struct tm *tm, struct tm *now UNUSED, int *num)
 {
 	pending_number(tm, num);
-	date_time(tm, now, 12);
+	date_time(tm, 12);
 }
 
-static void date_tea(struct tm *tm, struct tm *now, int *num)
+static void date_tea(struct tm *tm, struct tm *now UNUSED, int *num)
 {
 	pending_number(tm, num);
-	date_time(tm, now, 17);
+	date_time(tm, 17);
 }
 
 static void date_pm(struct tm *tm, struct tm *now UNUSED, int *num)
@@ -1201,7 +1211,8 @@ static void date_today(struct tm *tm, struct tm *now, int *num UNUSED)
 	if (tm->tm_hour == now->tm_hour &&
 	    tm->tm_min == now->tm_min &&
 	    tm->tm_sec == now->tm_sec)
-		date_time(tm, now, 0);
+		date_time(tm, 0);
+	tm->tm_mday = -1;
 	update_tm(tm, now, 0);
 }
 
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index 7358903046..b187b1bfc4 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -210,9 +210,13 @@ check_approxidate '3:00' '2009-08-30 03:00:00'
 check_approxidate '15:00' '2009-08-30 15:00:00'
 check_approxidate 'noon today' '2009-08-30 12:00:00'
 check_approxidate 'today at noon' '2009-08-30 12:00:00' '-12 hours'
+check_approxidate 'noon today' '2009-09-01 12:00:00' '+36 hours'
 check_approxidate 'noon yesterday' '2009-08-29 12:00:00'
 check_approxidate 'last Friday at noon' '2009-08-28 12:00:00'
 check_approxidate 'last Friday at noon' '2009-08-28 12:00:00' '-12 hours'
+check_approxidate 'noon yesterday' '2009-08-29 12:00:00' '-12 hours'
+check_approxidate 'tea last saturday' '2009-08-29 17:00:00'
+check_approxidate 'tea last saturday' '2009-08-29 17:00:00' '-12 hours'
 check_approxidate 'January 5th noon pm' '2009-01-05 12:00:00'
 check_approxidate 'January 5th noon pm' '2009-01-05 12:00:00' '-12 hours'
 check_approxidate '10am noon' '2009-08-29 12:00:00'
-- 
2.30.2

