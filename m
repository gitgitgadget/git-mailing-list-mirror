Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B823B19D9
	for <git@vger.kernel.org>; Thu, 21 May 2026 10:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779360882; cv=none; b=NPDr2+bxxMRqU1sf2Dcmg9dDOBQz5Q8/xFR6241ItZh9gg+2YF9WLyzVar2wkQZcJRZl4n/FCunUn1Z8dZR97lwxx0Ed++gl9s/0gNVWfxyk5S8r0nG5X9n/nEnZs46cv6MzQ8J/AM2OWIGqPi+zBfkmOTjnYdWddMX37C8/18c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779360882; c=relaxed/simple;
	bh=fO2LfnV0A8ug/MpLRLOX19RKL1sWy1HKfe0PIMuiBUg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SRVeK3zvyczPL0qGi+xW+sBhqfYD34Y/gHhHYXfbtJqVb2AG//uhvj2RYHR9yIZYOqXg8ZbtVBA2OOy1IIi1cjXjBZOLucQfA5DJn8BO/gGkBCyA2LIqVzk8Vh/Iv/mZNqLo0wtVIKiGEbAoe/0WFdi+6bbdTNL5+Z8mSfh6UEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=FOjGZPra; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="FOjGZPra"
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 64LAsJXR003522-64LAsJXT003522
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 21 May 2026 13:54:20 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1wQ12h-003RdD-TZ;
	Thu, 21 May 2026 13:54:19 +0300
Received: from localhost (130.232.143.226) by ex19-06.utu.fi (130.232.247.46)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 21 May
 2026 13:54:19 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id a5648634;
	Thu, 21 May 2026 10:54:19 +0000 (UTC)
From: Tuomas Ahola <taahol@utu.fi>
To: <git@vger.kernel.org>
CC: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, Tuomas
 Ahola <taahol@utu.fi>
Subject: [PATCH v5 2/4] t0006: add support for approxidate test date adjustment
Date: Thu, 21 May 2026 13:54:06 +0300
Message-ID: <20260521105408.8222-3-taahol@utu.fi>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260521105408.8222-1-taahol@utu.fi>
References: <20260516151540.9611-1-taahol@utu.fi>
 <20260521105408.8222-1-taahol@utu.fi>
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
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWUhZXkguLT4lWFxYWFhYWFBeUVxfSFlbSBwJCQAHBCgdHB1GDgFIWUhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIWkhZXEhZW1hGWltaRlpYX0ZcX0hQSFhIWEhbSFhIWEhYSFlRSA8BHCgeDw0aRgMNGgYNBEYHGg9IWEhZX0gPARwbHA0aKBgHCgcQRgsHBUhYSFlbSBgNDg4oGA0ODkYGDRxIWA==
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:references:mime-version:content-type;
 bh=eBAudsCOyQaRB+T/Uvm8od2xBLKS1u1m2hVfydWycKE=;
 b=FOjGZPraApohUWVLwhd36arIRfyi3lQkhkoiWQro4NGdt8c5ouXoIoYm0FLUVDPKRcYbIwDH26NU
	wUmQUNmiAl5H+CZHxZ8on50wNw1DJhZO3+GqsmMJqNdFb7zFcJWAepZXKDC4MeU1jRHoVuZoJ6l8
	KGVr3uw+4bGPecaKgjERaHsGMW7KbAgjmfIW8Affzr+1Vp8ITCLJ0XUZtHUnvu5CsDrIf+GVkjk6
	2QVP1vMNqxfhI7aJ+ttJgE0wzc6eJceixsCGSsgtEEhb1cp8OibgnY1Z7OCnDXDSEDU/iP58P7+0
	Ht/Mgm3/vyA+4Nd2sLKMTsdFKTATOCVFVBj/ZA==

t0006 uses a hard-coded test date and provides no convenient
way to override it temporarily.  Add an optional parameter to
check_approxidate to adjust the time as needed, and demonstrate
the feature with a new test.

Signed-off-by: Tuomas Ahola <taahol@utu.fi>
---
 t/t0006-date.sh | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index d95afdda33..b9bb7a05d9 100755
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
@@ -184,6 +213,8 @@ check_approxidate 'noon yesterday' '2009-08-29 12:00:00'
 check_approxidate 'January 5th noon pm' '2009-01-05 12:00:00'
 check_approxidate 'January 5th today pm' '2009-01-30 12:00:00'
 check_approxidate '10am noon' '2009-08-29 12:00:00'
+check_approxidate 'January 5th yesterday' '2009-01-29 19:20:00'
+check_approxidate 'January 5th yesterday' '2008-12-31 19:20:00' '+2 days'
 
 check_approxidate 'last tuesday' '2009-08-25 19:20:00'
 check_approxidate 'July 5th' '2009-07-05 19:20:00'
-- 
2.30.2

