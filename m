Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F9E3B1018
	for <git@vger.kernel.org>; Tue, 12 May 2026 15:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778598590; cv=none; b=LlDR7WIXY/+XI8XDNl3hs/JO1syKGsSfUIOrTlqMnZeCVdumfGOGoBn8Z2qMsrVGvWD5lA8tXyVxUCrwJbr+DR4puneB3am/qX27SPARI9N+2wtXnjO+t78QXCQ4LcvmMNR4S+gcKAHQiUhMarXrGozYZHeZYu744UD6Y4wirAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778598590; c=relaxed/simple;
	bh=+/JAKNbHs9RsNgbZ8E2WoYIMbc8tW0R3TIqi5ZxKtWw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YysjGHureSCMFOJ129auv+RD1CPn3VIenHcr903K8iw9VO2GR7TbY/ap4k6fYI+UTyTto00dGoshJYmDovYQmN0Tkk5rdRBtsYwAZZ3AsoiPlbYzzKIJ39MTmgqlHAk1/7bzy1EKwImlUStL5OHtiWO+9By4xfJ9x9NJFNldMCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=iwnHSgZS; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="iwnHSgZS"
Received: from smtp-03.utu.fi (smtp-03.utu.fi [130.232.207.30])
	by fortymile.utu.fi  with ESMTPS id 64CEsWKD022939-64CEsWKF022939
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 12 May 2026 17:54:32 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-03.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1wMoVE-003YFf-FF;
	Tue, 12 May 2026 17:54:32 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 12 May
 2026 17:54:32 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id cded0791;
	Tue, 12 May 2026 14:54:31 +0000 (UTC)
From: Tuomas Ahola <taahol@utu.fi>
To: <git@vger.kernel.org>
CC: Jeff King <peff@peff.net>, Tuomas Ahola <taahol@utu.fi>
Subject: [PATCH v2 1/3] t0006: add support for approxidate test date adjustment
Date: Tue, 12 May 2026 17:54:28 +0300
Message-ID: <20260512145430.13212-2-taahol@utu.fi>
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
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWUhZXkguLT4lWFxYWFhYWFBeUVxfSFlbSBwJCQAHBCgdHB1GDgFIWUhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIWkhZXEhZW1hGWltaRlpYX0ZbWEhQSFhIWEhaSFhIWEhYSFlRSA8BHCgeDw0aRgMNGgYNBEYHGg9IWEhZW0gYDQ4OKBgNDg5GBg0cSFg=
X-FEAS-Client-IP: 130.232.207.30
X-FE-Last-Public-Client-IP: 130.232.207.30
X-FE-Policy-ID: 3:5:2:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:references:mime-version:content-type;
 bh=z3THb1+rWHcz5ZxjlkYpR0LZi3926UEtNcA60mEsbxE=;
 b=iwnHSgZSDHyxtiYG3fuw0C+VYXXQLxT2BjSZkMmFpWzhF/vzBmEa7TjEPrmvGXp0F7zE5jhDkGeT
	Ptq7thWAZCCYV4VsHP8APVZD3Zmbl+sZ7uFLI2TVmjDPwh7KIgl4Pt7Y2TJAmU9wBg07GSOAVCZ4
	PNN3A05tu4zRErAf+JhCXPW9bef62ErEw7achzCe1/ilqdgyNFCLAfjtJJFh2o6O8Yfj7+uKYUxk
	I+MWStUef1u5tSbXwZaQjnCcmOUVLR1dRGdLo9JearXE2tsdQl5iRv21eI1UMvo9EUrSni9kIHhO
	fXw3BZl8zbFb4m9jWczfUHI9q9zCUXVhJc6cVQ==

t0006 uses a hard-coded test date and provides no convenient
way to override it temporarily.  Add an optional parameter to
check_approxidate to adjust the time as needed, and demonstrate
the feature with a new test.

Signed-off-by: Tuomas Ahola <taahol@utu.fi>
---
 t/t0006-date.sh | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index 53ced36df4..5d66267672 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -156,11 +156,18 @@ check_parse '2100-00-00 00:00:00 +11' bad
 REQUIRE_64BIT_TIME=
 
 check_approxidate() {
+	old_date=$GIT_TEST_DATE_NOW
+	GIT_TEST_DATE_NOW=$(($old_date${4:-+0}*60*60)); export GIT_TEST_DATE_NOW
+	caption=$1
+	if [ ! -z $4 ]; then
+		caption="$caption; offset $4h"
+	fi
 	echo "$1 -> $2 +0000" >expect
-	test_expect_${3:-success} "parse approxidate ($1)" "
+	test_expect_${3:-success} "parse approxidate ($caption)" "
 	test-tool date approxidate '$1' >actual &&
 	test_cmp expect actual
 	"
+	GIT_TEST_DATE_NOW=$old_date; export GIT_TEST_DATE_NOW
 }
 
 check_approxidate now '2009-08-30 19:20:00'
@@ -182,6 +189,8 @@ check_approxidate 'noon today' '2009-08-30 12:00:00'
 check_approxidate 'noon yesterday' '2009-08-29 12:00:00'
 check_approxidate 'January 5th noon pm' '2009-01-05 12:00:00'
 check_approxidate '10am noon' '2009-08-29 12:00:00'
+check_approxidate 'January 5th yesterday' '2009-01-29 19:20:00'
+check_approxidate 'January 5th yesterday' '2008-12-31 19:20:00' success +48
 
 check_approxidate 'last tuesday' '2009-08-25 19:20:00'
 check_approxidate 'July 5th' '2009-07-05 19:20:00'
-- 
2.30.2

