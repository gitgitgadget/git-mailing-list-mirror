Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2067D3B1EC8
	for <git@vger.kernel.org>; Thu, 21 May 2026 10:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779360883; cv=none; b=YAa+Oh0NNcuAFhPfXvjegqLFp93DdqTD65GDR+w0EWd6yntVB1HwydwxmECoLV+e2l4YwiGNJE6e/aw/9/s7jEJdnTSerA5094sUeByuLHk6y5W1sgaIQMi8vBr/XWjPK3Qc2hQxHT1W792Z32fre98ijRSEwdX3cHj2PZxS6ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779360883; c=relaxed/simple;
	bh=m29v+oXt78LqyPpPqaU4EoqxeWe6tu5WJkQjnfmrvpE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fvaMgeypuHbEhYPWOZhLnGnu8UU/vWjP0TUtOtX6h1qgQUMjQWGWEB/kTGbzww7mDHfcuF2bUIBocod4ZWU7I6FG7MlJZL+gk9e0iqNamL8wW4NZMV0VDtJiU0pV95T6cy3c6E1zJsFcv2KmyeAoGlsaCS0KAXKWX6vUKQSy59g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=by6jMjur; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="by6jMjur"
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 64LAsJlE003516-64LAsJlG003516
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 21 May 2026 13:54:19 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1wQ12h-003Rd7-Iy;
	Thu, 21 May 2026 13:54:19 +0300
Received: from localhost (130.232.143.226) by ex19-06.utu.fi (130.232.247.46)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 21 May
 2026 13:54:19 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 60c51b2d;
	Thu, 21 May 2026 10:54:19 +0000 (UTC)
From: Tuomas Ahola <taahol@utu.fi>
To: <git@vger.kernel.org>
CC: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, Tuomas
 Ahola <taahol@utu.fi>
Subject: [PATCH v5 0/4] approxidate: tweak special date formats
Date: Thu, 21 May 2026 13:54:04 +0300
Message-ID: <20260521105408.8222-1-taahol@utu.fi>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260516151540.9611-1-taahol@utu.fi>
References: <20260516151540.9611-1-taahol@utu.fi>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ex19-11.utu.fi (130.232.247.51) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWUhZXkguLT4lWFxYWFhYWFBeUVxfSFlbSBwJCQAHBCgdHB1GDgFIWUhZW0gYDQ4OKBgNDg5GBg0cSFhIWkhZXEhZW1hGWltaRlpYX0ZcX0hQSFhIWEhbSFhIWEhYSFlRSA8BHCgeDw0aRgMNGgYNBEYHGg9IWEhZX0gPARwbHA0aKBgHCgcQRgsHBUhYSFlbSBgNDg4oGA0ODkYGDRxIWA==
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:references:mime-version:content-type;
 bh=Rgbfsbfm5jmEP/CTFhcGzMfbfDzQRDWmyJL9sJxT+Zw=;
 b=by6jMjur+oTFYTjXHo2fAkQsG8+xGzY08axWKyh5Evw932AiOkGJv5UeuGufQS5cM9e88/3hZs27
	QDZVBUyvR8kTlL5GjIXKI/hdgnYhVSPLRqWP/2bbEb0sCXjRzIhi3dVK6fnkX03LWg0IVZx6HH2U
	Hu34Wm2EJtqWgxLycyVWuvNl4+X2jGsO7Fu6N/FIUtbWw3cYH1l4ZrpUeCOv4d13gZ+U7hmiDAVR
	iGtSVHqVtKIVIfRiG8YUbrf5bV7B91HvYZH98Hk11Xu+LLjboIIzz7kmmzgCP+9Y7kM0ioNV2sZS
	guPvaxfXRV4//yg02wYXBLT5MBqzvw59zYLlJw==

> "Friday noon" asked in the morning on Sunday was parsed to be one
> day before the specified time, which has been corrected.

Should we add something about the new semantics of "today"?

Tuomas Ahola (4):
  approxidate: make "today" wrap to midnight
  t0006: add support for approxidate test date adjustment
  approxidate: make "specials" respect fixed day-of-month
  approxidate: use deferred mday adjustments for "specials"

 Documentation/rev-list-options.adoc |  3 +-
 date.c                              | 46 ++++++++++++++++++++++-------
 t/t0006-date.sh                     | 44 ++++++++++++++++++++++++++-
 3 files changed, 81 insertions(+), 12 deletions(-)

Interdiff mot v4:
diff --git a/date.c b/date.c
index 6e7cf907da..05b78d852f 100644
--- a/date.c
+++ b/date.c
@@ -1206,12 +1206,13 @@ static void date_never(struct tm *tm, struct tm *now UNUSED, int *num)
 	*num = 0;
 }
 
-static void date_today(struct tm *tm, struct tm *now, int *num UNUSED)
+static void date_today(struct tm *tm, struct tm *now, int *num)
 {
 	if (tm->tm_hour == now->tm_hour &&
 	    tm->tm_min == now->tm_min &&
 	    tm->tm_sec == now->tm_sec)
 		date_time(tm, 0);
+	*num = 0;
 	tm->tm_mday = -1;
 	update_tm(tm, now, 0);
 }
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index b187b1bfc4..9a76b84ed9 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -212,13 +212,14 @@ check_approxidate 'noon today' '2009-08-30 12:00:00'
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
 check_approxidate 'January 5th noon pm' '2009-01-05 12:00:00' '-12 hours'
+check_approxidate 'January 5th today pm' '2009-01-30 12:00:00'
 check_approxidate '10am noon' '2009-08-29 12:00:00'
 check_approxidate 'January 5th yesterday' '2009-01-29 19:20:00'
 check_approxidate 'January 5th yesterday' '2008-12-31 19:20:00' '+2 days'

base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
-- 
2.30.2

