Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E35025B087
	for <git@vger.kernel.org>; Sat, 16 May 2026 15:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778944552; cv=none; b=OI/gpXz+kDm9mgw9K7z9vDgrLB5ciM6Ai20TlWNIMSB1ohG6wafWBioYByi1EepjjskwQPyuQXBgYZQjwj+eL4Sd+EZooMqE9y43WDLJGVHUT5nzp7NH3gZfjTbUBoOeeAn7w36De6ei6XbuTH5gGkgGRguRX/hdPR/Osw/pq9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778944552; c=relaxed/simple;
	bh=OviZ6z9D+reg2coiRLFTNlGZjjk568zk0nucShJ3qUo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hl3OKoBuKvl6q0Wj/XVR2y+SrzQQLVMtR2Rw4iGzTh05eBrzHfQmjrnmUSCL4+Ezst8xFsdv1UxyUxmn3kyg98V0IXggVM+f3MppMWm/Jwak6Ood39SiNgceTob8+IyML2jWKqmARizU5D01xcUsW9bqRpJfIhdgQCGkRxpNvGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=JT2dQ3Tc; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="JT2dQ3Tc"
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 64GFFh1L019470-64GFFh1N019470
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sat, 16 May 2026 18:15:43 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1wOGju-00BJrB-UB;
	Sat, 16 May 2026 18:15:42 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Sat, 16 May
 2026 18:15:42 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 019d8158;
	Sat, 16 May 2026 15:15:42 +0000 (UTC)
From: Tuomas Ahola <taahol@utu.fi>
To: <git@vger.kernel.org>
CC: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, Tuomas
 Ahola <taahol@utu.fi>
Subject: [PATCH v4 2/4] t0006: add support for approxidate test date adjustment
Date: Sat, 16 May 2026 18:15:38 +0300
Message-ID: <20260516151540.9611-3-taahol@utu.fi>
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
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWUhZXkguLT4lWFxYWFhYWFBeUVxfSFlbSBwJCQAHBCgdHB1GDgFIWUhZW0gYDQ4OKBgNDg5GBg0cSFhIWkhZXEhZW1hGWltaRlpYX0ZcX0hQSFhIWEhbSFhIWEhYSFlRSA8BHCgeDw0aRgMNGgYNBEYHGg9IWEhZX0gPARwbHA0aKBgHCgcQRgsHBUhYSFlbSBgNDg4oGA0ODkYGDRxIWA==
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:references:mime-version:content-type;
 bh=n1VZF1cS1Z6yrJZlpFMDz1cLsxpGixgQaqhY5U8aAuI=;
 b=JT2dQ3TcFlmF3xFIlsq+uS0xCCnm7x+/ipT+lkoS7O5m3vsD223xT0dUj0Alq5I5eNqJnBCOCOBz
	KPksArnUz94SmfCLllJsuzZnbcbiCrChEzUOmx5xzk3OcSsWVEQGEgV0UXcqW0bw7bRNzQKuAXwi
	NWWP6BiZpdgiwgRvuKXIlKTWyZg3P8erG0Dpt3fG4TwKXrvH8s7hJk2DHWDGdZwd8mLgHJTzRTMf
	zF+K4M7SNjAyy2r7GJX36oNVrPbjnlLlzppUZj5p8eo7hsBL9RagabZkzt5juOqsgpoWcyjluhzh
	CjpQY341BzoUbZOwLaxRNhsftRBNlbtmDSCKlg==

t0006 uses a hard-coded test date and provides no convenient
way to override it temporarily.  Add an optional parameter to
check_approxidate to adjust the time as needed, and demonstrate
the feature with a new test.

Signed-off-by: Tuomas Ahola <taahol@utu.fi>
---
 t/t0006-date.sh | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index 07bf6115ab..15fbc12861 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -155,12 +155,41 @@ check_parse '2100-00-00 00:00:00 -11' bad
 check_parse '2100-00-00 00:00:00 +11' bad
 REQUIRE_64BIT_TIME=
 
+add_time_offset() {
+	case "$3" in
+	hours)
+		unit=$(( 60*60 ))
+		;;
+	days)
+		unit=$(( 24*60*60 ))
+		;;
+	esac
+	offset=$(( $2 * unit ))
+	echo $(( $1 + offset ))
+}
+
 check_approxidate() {
+	old_date=$GIT_TEST_DATE_NOW
+	if test "$3" = "failure"
+	then
+		expection="$3"
+	else
+		expection=${4:-success}
+		offset="$3"
+	fi
+	if test -n "$offset"
+	then
+		GIT_TEST_DATE_NOW=$(add_time_offset $old_date $offset)
+		caption="$1; offset $offset"
+	else
+		caption=$1
+	fi
 	echo "$1 -> $2 +0000" >expect
-	test_expect_${3:-success} "parse approxidate ($1)" "
+	test_expect_$expection "parse approxidate ($caption)" "
 	test-tool date approxidate '$1' >actual &&
 	test_cmp expect actual
 	"
+	GIT_TEST_DATE_NOW=$old_date
 }
 
 check_approxidate now '2009-08-30 19:20:00'
@@ -183,6 +212,8 @@ check_approxidate 'noon today' '2009-08-30 12:00:00'
 check_approxidate 'noon yesterday' '2009-08-29 12:00:00'
 check_approxidate 'January 5th noon pm' '2009-01-05 12:00:00'
 check_approxidate '10am noon' '2009-08-29 12:00:00'
+check_approxidate 'January 5th yesterday' '2009-01-29 19:20:00'
+check_approxidate 'January 5th yesterday' '2008-12-31 19:20:00' '+2 days'
 
 check_approxidate 'last tuesday' '2009-08-25 19:20:00'
 check_approxidate 'July 5th' '2009-07-05 19:20:00'
-- 
2.30.2

