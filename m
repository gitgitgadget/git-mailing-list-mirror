Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8017D211489
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 18:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742321872; cv=none; b=ZtqKjS3C7XgP/a48u8Ox7VLKeAQAngFX5HOFrIBnOqYnyj6zeJfl4C0qoGlaqLgkMCbx+gJSHAVKXDsZqnPJxCm4nq3gWpkPuI9RIUbvvd0sLmvC4E6qym8/s9Jm4hpVPP68UWs8iZ08Uzfzh1H9cnW28YmZKSH8olRdntlTse4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742321872; c=relaxed/simple;
	bh=flHodGp7LXujd6v9EMxE2RBRo2GEy/2xy5F6GCaULmc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vfn5DGwEUyOWMwU9D0GvsNDXY01Zqrf1FXKWlJ47TvfHqwPPyrpFFVyoH4gvc+9YNQIlxoUyZ7g6th9Rmeahmf4F+P8OT/2nPHKf7QxV6J3rlcnh3fRY6KY7qCKR3EwdaEpJoYHuGM8INM7LQMyDedc5EVbmGs1h6RToJG5Qjxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=QbBhEftK; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="QbBhEftK"
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 52II2X6B021412-52II2X6D021412
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 20:02:33 +0200
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <taahol@utu.fi>)
	id 1tubGq-000DYz-Hp
	for git@vger.kernel.org; Tue, 18 Mar 2025 20:02:33 +0200
Received: from localhost (194.111.69.129) by ex19-06.utu.fi (130.232.247.46)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.39; Tue, 18 Mar
 2025 20:02:32 +0200
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id c081398c;
	Tue, 18 Mar 2025 18:02:31 +0000 (UTC)
From: Tuomas Ahola <taahol@utu.fi>
To: <git@vger.kernel.org>
CC: Tuomas Ahola <taahol@utu.fi>
Subject: [PATCH 1/2] approxidate: make "specials" respect fixed day-of-month
Date: Tue, 18 Mar 2025 20:02:00 +0200
Message-ID: <20250318180201.3653-2-taahol@utu.fi>
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
 bh=m9H+UPRQZPH5hgfT84JZ96uvMK5pS1xvbS72Cm1UbSA=;
 b=QbBhEftKtxlrv6dJgV/9ego8IvzwOCJS5vSex0q762TvSqB3Vx0/cx3htueSHpDx/PXFvqijuN4U
	2vweCR+KdmRGtLcl3U7SpFJspQwZQWEdMcHVLVBGiXPhp0/AiVHBBlk4Ti0eFEq2QM4ec1SFGtfg
	cJ7VJkBX6M8AtBp/z+WhYbQ3jJhtv7/GNe4AuOamAkdwl0YLLiavORFkICO9BO10/jUnJ0GqCrOW
	fyYL/gPIwGVHt6wm2xdewOEiCRDcASUC8EXY2L2y5eCZYyRIV9nF0zFc1b7Wjp1OogZH6PGbsOTU
	6U1HCv9BCsXll5eR2NfPrIYNaTqdUemiymlVPA==

The behaviour of noon and tea depends on the current time even when
the date is given.  In other words, "last Friday tea" is dated to
Thursday if the command is run before 17 pm.

This can be fixed by checking whether tm->tm_mday already holds a
determined value and tested by setting current time before 12 or 17 pm
for noon and tea respectively.

Signed-off-by: Tuomas Ahola <taahol@utu.fi>
---
 date.c          | 2 +-
 t/t0006-date.sh | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/date.c b/date.c
index 17a95077cf..482a2f8c99 100644
--- a/date.c
+++ b/date.c
@@ -1133,7 +1133,7 @@ static void date_yesterday(struct tm *tm, struct tm *now, int *num)
 static void date_time(struct tm *tm, struct tm *now, int hour)
 {
 	if (tm->tm_hour < hour)
-		update_tm(tm, now, 24*60*60);
+		update_tm(tm, now, tm->tm_mday < 0 ? 24*60*60 : 0);
 	tm->tm_hour = hour;
 	tm->tm_min = 0;
 	tm->tm_sec = 0;
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index 53ced36df4..5db4b23e0b 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -180,7 +180,10 @@ check_approxidate '3:00' '2009-08-30 03:00:00'
 check_approxidate '15:00' '2009-08-30 15:00:00'
 check_approxidate 'noon today' '2009-08-30 12:00:00'
 check_approxidate 'noon yesterday' '2009-08-29 12:00:00'
-check_approxidate 'January 5th noon pm' '2009-01-05 12:00:00'
+(
+	GIT_TEST_DATE_NOW=$(($GIT_TEST_DATE_NOW-12*60*60)); export GIT_TEST_DATE_NOW
+	check_approxidate 'January 5th noon pm' '2009-01-05 12:00:00'
+)
 check_approxidate '10am noon' '2009-08-29 12:00:00'
 
 check_approxidate 'last tuesday' '2009-08-25 19:20:00'
-- 
2.30.2

