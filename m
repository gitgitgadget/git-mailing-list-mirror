Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C423C2777
	for <git@vger.kernel.org>; Thu, 14 May 2026 11:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778759841; cv=none; b=ccV3LGoKlgp7GUTbqPfRnS/j9oS1qvsePZUgRmYboNvCyu3chJ/aovoY003AqTck2YbIK78AXkDr0RkY5y9oxPYZ5LMgkPSw7v2otSfCIXHGFXGjGkNoHt4tViNstinvjKAZq/GhR+3rj+mAqsXvktduJ2qskwZVAoGiRiW00po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778759841; c=relaxed/simple;
	bh=K3wzLpTQ9EQAnV2AdUiyjzL9fBjQdSanoSxdUHL25v4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JxPr2PZY5jIBsCjrc8xucsOtn5KhOeXkA4vKz52X9DK1J/sdzX6eiNwp8nystRfuUo2bwLZrkf/6splJIrCWqqu+e+tRSsVng7ffHXSUuP5mgmmLh3AI9Osg/rHhbfdrbKGyv+DA+D4Pu3ZA2QChSdtKVdd+zO6phLofz0JCAbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=JTAuN199; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="JTAuN199"
Received: from smtp-03.utu.fi (smtp-03.utu.fi [130.232.207.30])
	by fortymile.utu.fi  with ESMTPS id 64EBv2gB011562-64EBv2gD011562
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 14 May 2026 14:57:02 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-03.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1wNUgY-007H3E-Pe;
	Thu, 14 May 2026 14:57:02 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 14 May
 2026 14:57:02 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 22619f18;
	Thu, 14 May 2026 11:57:01 +0000 (UTC)
From: Tuomas Ahola <taahol@utu.fi>
To: <git@vger.kernel.org>
CC: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, Tuomas
 Ahola <taahol@utu.fi>
Subject: [PATCH v3 3/4] approxidate: make "specials" respect fixed day-of-month
Date: Thu, 14 May 2026 14:55:19 +0300
Message-ID: <20260514115520.6660-4-taahol@utu.fi>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260514115520.6660-1-taahol@utu.fi>
References: <20260512145430.13212-1-taahol@utu.fi>
 <20260514115520.6660-1-taahol@utu.fi>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ex19-14.utu.fi (130.232.247.54) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWUhZXkguLT4lWFxYWFhYWFBeUVxfSFlbSBwJCQAHBCgdHB1GDgFIWUhZX0gPARwbHA0aKBgHCgcQRgsHBUhYSFpIWVxIWVtYRlpbWkZaWF9GW1hIUEhYSFhIW0hYSFhIWEhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIWV9IDwEcGxwNGigYBwoHEEYLBwVIWEhZW0gYDQ4OKBgNDg5GBg0cSFg=
X-FEAS-Client-IP: 130.232.207.30
X-FE-Last-Public-Client-IP: 130.232.207.30
X-FE-Policy-ID: 3:5:2:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:references:mime-version:content-type;
 bh=9tBIChYbTm+tYWwTVoey7QjjRsnAPQgFXZqKx94+dLM=;
 b=JTAuN199iE5mGEIPQai38/aJhPVTTMLHmb1u7LqKpxAubiGm7JUdyqBkQ+TvMwyt7dDAzv6YhSuR
	OJKfzmF1w4G+3O2VxOtNq69JB8lQgv5oGLrGVhQ0536RWEfv6i7Mj5sHEvtaf/fQGPnBtzwLC9Nd
	TCDfqKX+/IfJe8kfSkE3steFcPAPBil4bXkPpL+Z01XWh29TTWV1RHvW7eZvKga0Lu2J8eobqeYF
	aeEpps+NhuVDPxp3vyDzpi3CCNJFQc0x/Dm/Qia3lG6QvSaaCt9q9hNNkXzDpEgLdjvURXe8XFNu
	QNWaTIhlb7h20c0c6Qp9gsP7ZYpy6xsOpAcrKQ==

The special approxidate time formats, "noon" and "tea" differ from
"12pm" and "5pm" by having the feature of wrapping to the previous day
if the current time is before those hours:

	now  -> 2026-05-13 11:00:00 +0000

	12pm -> 2026-05-13 12:00:00 +0000
	5pm  -> 2026-05-13 17:00:00 +0000

	noon -> 2026-05-12 12:00:00 +0000
	tea  -> 2026-05-12 17:00:00 +0000

However, that logic carries too far.  Even when the date is specified,
the behavior of the "specials" depends on the current time.  Assuming
the same time as above, we get:

	today at noon -> 2026-05-12 12:00:00 +0000 (should be 13 May)
	13 May at tea -> 2026-05-12 17:00:00 +0000

or, using an example mentioned in date-formats.adoc:

	last Friday at noon -> 2026-05-07 12:00:00 +0000 (should be 8 May)

The quirk seems to be rather old.  Already in 2006, Linus Torvalds
remarked that the date yielded by "one year ago yesterday at tea-time"
was "just silly and not even correct".  Indeed, even today it gives:

	One year ago yesterday at tea-time -> 2025-05-11 17:00:00 +0000
	  (should be 12 May)

Let's fix all of those with a simple patch.  Check whether we already
have a specified day-of-month in `tm->tm_mday` and make `date_time()`
stick to it.  Ensure the correct behavior with relevant tests.

Links:
  1. https://lore.kernel.org/git/Pine.LNX.4.64.0610101102560.3952@g5.osdl.org/

Signed-off-by: Tuomas Ahola <taahol@utu.fi>
---

Notes:
    > Again, this may be just me, but I happen to find the version of
    > comment in Peff's review on the earlier iteration of this series
    > much easier to understand.
    >
    
    Thanks, applied.

 date.c          | 6 +++++-
 t/t0006-date.sh | 4 ++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/date.c b/date.c
index 412aca6dc4..73879d202c 100644
--- a/date.c
+++ b/date.c
@@ -1132,7 +1132,11 @@ static void date_yesterday(struct tm *tm, struct tm *now, int *num)
 
 static void date_time(struct tm *tm, struct tm *now, int hour)
 {
-	if (tm->tm_hour < hour)
+	/*
+	 * If we do not yet have a specified day, we'll use the most recent
+	 * version of "hour" relative to now.  But that may be yesterday.
+	 */
+	if (tm->tm_mday < 0 && tm->tm_hour < hour)
 		update_tm(tm, now, 24*60*60);
 	tm->tm_hour = hour;
 	tm->tm_min = 0;
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index c7667bade2..d800cb30fe 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -208,8 +208,12 @@ check_approxidate '6pm yesterday' '2009-08-29 18:00:00'
 check_approxidate '3:00' '2009-08-30 03:00:00'
 check_approxidate '15:00' '2009-08-30 15:00:00'
 check_approxidate 'noon today' '2009-08-30 12:00:00'
+check_approxidate 'today at noon' '2009-08-30 12:00:00' '-12 hours'
 check_approxidate 'noon yesterday' '2009-08-29 12:00:00'
+check_approxidate 'last Friday at noon' '2009-08-28 12:00:00'
+check_approxidate 'last Friday at noon' '2009-08-28 12:00:00' '-12 hours'
 check_approxidate 'January 5th noon pm' '2009-01-05 12:00:00'
+check_approxidate 'January 5th noon pm' '2009-01-05 12:00:00' '-12 hours'
 check_approxidate '10am noon' '2009-08-29 12:00:00'
 check_approxidate 'January 5th yesterday' '2009-01-29 19:20:00'
 check_approxidate 'January 5th yesterday' '2008-12-31 19:20:00' '+2 days'
-- 
2.30.2

