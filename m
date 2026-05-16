Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E21222538F
	for <git@vger.kernel.org>; Sat, 16 May 2026 15:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778944552; cv=none; b=BCasgFL+vKghXoTCkr7Jpe3HmUh9vXodL0KADPXUpH+Mr5X793D1OIGEFyUvXU5Db4amx0EJP9a300wMOFZVSnITUrgy5kQ+vIoQYs8vniCTBjaULPvgZ5uS/2sXKOt0yXoVrA2afSMR89rEdI2MiByG6UFqmDxDZ3tDVS9EfD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778944552; c=relaxed/simple;
	bh=zoYwPY/X8/AdjNfx1H4ffo1mxoSpxItx/GbdNcoTvHw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mU2O7DgMIHlxfJz5Nhu73GNJBuYoB7yqYvuGMx5joEMa8pKTqbaeZL4g0wBRCnM6S4bJp891rSBorWdl4E3ZCm/mICTsKfzJ8g+GjRoP9uvJrAKsf+M3hsAnqpfW7kQjtya+5b+8xL82rbv6BpX3tmVs39DvNEC4bvMR5HrLZdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=R23omojq; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="R23omojq"
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 64GFFhEa019482-64GFFhEc019482
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sat, 16 May 2026 18:15:43 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1wOGjv-00BJrG-51;
	Sat, 16 May 2026 18:15:43 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Sat, 16 May
 2026 18:15:42 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id d1b37a48;
	Sat, 16 May 2026 15:15:42 +0000 (UTC)
From: Tuomas Ahola <taahol@utu.fi>
To: <git@vger.kernel.org>
CC: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, Tuomas
 Ahola <taahol@utu.fi>
Subject: [PATCH v4 3/4] approxidate: make "specials" respect fixed day-of-month
Date: Sat, 16 May 2026 18:15:39 +0300
Message-ID: <20260516151540.9611-4-taahol@utu.fi>
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
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWUhZXkguLT4lWFxYWFhYWFBeUVxfSFlbSBwJCQAHBCgdHB1GDgFIWUhZX0gPARwbHA0aKBgHCgcQRgsHBUhYSFpIWVxIWVtYRlpbWkZaWF9GXF9IUEhYSFhIW0hYSFhIWEhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIWV9IDwEcGxwNGigYBwoHEEYLBwVIWEhZW0gYDQ4OKBgNDg5GBg0cSFg=
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:references:mime-version:content-type;
 bh=AjZY3GR8RNc/khp4Df8aq1Ld/C0MGXGN5waMtwN4xVQ=;
 b=R23omojqjWTgCVZitBNszPDCYBVmymbAMMP19lWAl0K3wjdRpaAOeUJuNYSpn/0tMVaQylunqe1h
	S1XxM/RWeYiO3utL7RQ9iOCXro+ThcE5WXz24qqGjWO6VNP8uAn8V+PoTXamVU4ezjy7jP5vyDgw
	dYHXoimkBWfwirI6fKFtzB8go784CF04hVM6ff8L618z5glyudAdF57qyR7U17gZNwkvaHx5PLfn
	Gwu9Cw7gMQIAUk8cpUICPkTLfNip3mOzgwkgu10p++UtDXdc8fsc0woEx4KnnHKWo9CAndyZy96j
	kxYqmCpMOZ+P1FCWorVzJI8oqLKSJ8IFEWRXzg==

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
 date.c          | 6 +++++-
 t/t0006-date.sh | 4 ++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/date.c b/date.c
index 343d6aab6f..7a458f3cac 100644
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
index 15fbc12861..7358903046 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -209,8 +209,12 @@ check_approxidate '6pm yesterday' '2009-08-29 18:00:00'
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

