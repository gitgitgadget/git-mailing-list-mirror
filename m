Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800BF849C
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 18:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742321868; cv=none; b=aG2Qv/kMbzokpzeBr58xZj700fxaqzZBU011vxfxSh7JNXPs0D8ivdXOMI5j469bvbIvJnzvYvDeAsdZaIoeQ6XqqKKOU/27OCMgpRvP3eZCawNnZucw7buDs9aAzkiuvOSrIKWXKF1QjnT51pajWf+2Kbx3GPswR1bmL6DRO+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742321868; c=relaxed/simple;
	bh=DSeQuNzFE1R0aCZP6vSB4oPK1oLTNrwKLHTqXaxKLMg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Clza7u6uWyUz5hRTy8Q/8V1vPSObkXOwTAYtDyeVOUrezmSpC1dVRqm6gbmoS1FA9g1MVx6eLpLxDkOguuN522T+9P3T4m1ugTm4fqSDhi/C56umu1GjLQI8hOtE8Mk8i2hafrBli4aLseeStqSAJ5ZsMCCv6LAaBLlicjrNWlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=QzMXXT53; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="QzMXXT53"
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 52II2XaT021418-52II2XaV021418
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 20:02:33 +0200
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <taahol@utu.fi>)
	id 1tubGr-000DZ3-5N
	for git@vger.kernel.org; Tue, 18 Mar 2025 20:02:33 +0200
Received: from localhost (194.111.69.129) by ex19-06.utu.fi (130.232.247.46)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.39; Tue, 18 Mar
 2025 20:02:32 +0200
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 209c7ddd;
	Tue, 18 Mar 2025 18:02:31 +0000 (UTC)
From: Tuomas Ahola <taahol@utu.fi>
To: <git@vger.kernel.org>
CC: Tuomas Ahola <taahol@utu.fi>
Subject: [PATCH 2/2] approxidate: overwrite tm_mday for `now` and `yesterday`
Date: Tue, 18 Mar 2025 20:02:01 +0200
Message-ID: <20250318180201.3653-3-taahol@utu.fi>
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
X-ClientProxiedBy: ex19-13.utu.fi (130.232.247.53) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWUhZXkguLT4lWFxYWFhYWFBeUVxfSFlbSBwJCQAHBCgdHB1GDgFIWUhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIWkhZXEhZW1hGWltaRlpYX0ZcX0hQSFhIWEhZSFhIWEhYSFlRSA8BHCgeDw0aRgMNGgYNBEYHGg9IWA==
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:references:mime-version:content-type;
 bh=SbWUSV4kHD2wuv+xHh77eDjgLLKdLONNPEPwc0TXdaM=;
 b=QzMXXT53HHYYo7Fmt2Am6aHjYuFXVNy+W7PrpZ4gcSSDRH64hVU8vpiVc5Kn+AR8iSTrfLm+JJHh
	yRyhiBPFM/hkC1RI3mAlcPnxuedO/D2arq+3pciv+5aJoTjPNSMkr9ZhIdlsXr8EalRy6fC5aDAZ
	086oHXudEmi4LHSogAiFWC+znY99vqm0R7Ftlt0/Mo3E7ws4veYtEBcuhX9ola2T7u/ZnixdVI1V
	l7ba+cbocQFkuk40MK4gcFdY/doaM6yrsjUvSRrj401J8ICVM6y2XiWzzHDLHTbXB7LVLN28KV2/
	sjM3VExQO8D3jOD6AZYcgyUXOqlrELHQsMSVpA==

Date specifications now (or today) and yesterday should refer to
actual current or previous day.  Especially "noon today" or "noon
yesterday" should override the usual logic of using the first previous
noon depending on the current time.

Signed-off-by: Tuomas Ahola <taahol@utu.fi>
---
 date.c          | 3 +++
 t/t0006-date.sh | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/date.c b/date.c
index 482a2f8c99..2a8a942d64 100644
--- a/date.c
+++ b/date.c
@@ -1121,12 +1121,14 @@ static void pending_number(struct tm *tm, int *num)
 static void date_now(struct tm *tm, struct tm *now, int *num)
 {
 	*num = 0;
+	tm->tm_mday = -1;
 	update_tm(tm, now, 0);
 }
 
 static void date_yesterday(struct tm *tm, struct tm *now, int *num)
 {
 	*num = 0;
+	tm->tm_mday = -1;
 	update_tm(tm, now, 24*60*60);
 }
 
@@ -1204,6 +1206,7 @@ static const struct special {
 	{ "AM", date_am },
 	{ "never", date_never },
 	{ "now", date_now },
+	{ "today", date_now },
 	{ NULL }
 };
 
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index 5db4b23e0b..6ad931dfb3 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -178,10 +178,10 @@ check_approxidate '6am yesterday' '2009-08-29 06:00:00'
 check_approxidate '6pm yesterday' '2009-08-29 18:00:00'
 check_approxidate '3:00' '2009-08-30 03:00:00'
 check_approxidate '15:00' '2009-08-30 15:00:00'
-check_approxidate 'noon today' '2009-08-30 12:00:00'
-check_approxidate 'noon yesterday' '2009-08-29 12:00:00'
 (
 	GIT_TEST_DATE_NOW=$(($GIT_TEST_DATE_NOW-12*60*60)); export GIT_TEST_DATE_NOW
+	check_approxidate 'noon today' '2009-08-30 12:00:00'
+	check_approxidate 'noon yesterday' '2009-08-29 12:00:00'
 	check_approxidate 'January 5th noon pm' '2009-01-05 12:00:00'
 )
 check_approxidate '10am noon' '2009-08-29 12:00:00'
-- 
2.30.2

