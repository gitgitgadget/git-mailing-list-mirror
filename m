Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D813C3432
	for <git@vger.kernel.org>; Thu, 14 May 2026 11:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778759841; cv=none; b=NdvIljg48WtK2czbH/budmut1jk31JUJfJdRd2GlH4SnhVDyO8GYQgy5/sheTPuuJJ1LTKAS7ko/S+V1VUeA0Fh7fdVJR9tcPXbRG3W9efENbFDrNuG4qvdi/yE6L6QkTrzvPjpRgFDDrbIRixQsdfckcmp1ufU67Dd7TgiQp7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778759841; c=relaxed/simple;
	bh=nI9v1g51Hidzdgnd1v82G9sT6Z1jvvrltBdWJibw4wY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EpMGy56T8/87yOHMCEx2Qq8Ur0I/LZnzJEQDnnqCkZvbWAVipnadf2+cqTGu2L+Af/JVI/03LpHN2uTeNVTkJ2tyAWQdJCFhUoSm0E7/XZXKOF10MyrVYwKZLp2FGyFUVRgeis07smxFahgaWSxvytBvbSRTZ8qSN2+IKMM440o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=kGGdkhe4; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="kGGdkhe4"
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 64EBv2er011549-64EBv2et011549
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 14 May 2026 14:57:02 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1wNUgY-007WOZ-Dz;
	Thu, 14 May 2026 14:57:02 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 14 May
 2026 14:57:02 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 09a4e3ec;
	Thu, 14 May 2026 11:57:01 +0000 (UTC)
From: Tuomas Ahola <taahol@utu.fi>
To: <git@vger.kernel.org>
CC: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, Tuomas
 Ahola <taahol@utu.fi>
Subject: [PATCH v3 1/4] t0006: add support for approxidate test date adjustment
Date: Thu, 14 May 2026 14:55:17 +0300
Message-ID: <20260514115520.6660-2-taahol@utu.fi>
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
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWUhZXkguLT4lWFxYWFhYWFBeUVxfSFlbSBwJCQAHBCgdHB1GDgFIWUhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIWkhZXEhZW1hGWltaRlpYX0ZcX0hQSFhIWEhbSFhIWEhYSFlRSA8BHCgeDw0aRgMNGgYNBEYHGg9IWEhZX0gPARwbHA0aKBgHCgcQRgsHBUhYSFlbSBgNDg4oGA0ODkYGDRxIWA==
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:references:mime-version:content-type;
 bh=Wzu43tmZIH36q6n0RQXwY80d20tgnTRDM2QAekFlIWQ=;
 b=kGGdkhe4VLjR5rem8IIkz8cBSodWrW+ti0brK2bChq8byBDFkEk1y5MDfu7P3p78znTRWH+4VeHm
	waLBO90/yX9W08+WoG6EYt1ilBUiyOuLWsy7QdtRjZpgB0KIgwDhy5b4A7aUq4kIXOCHZsERpkH5
	4zRr+5nBy3cr508Rb/arHAQzCyBSclH2awIusnqbN2pRrCBLiUUxIN5cOPr0WH1IqxlotknLL3nl
	vESVJ/g71lfR4Ljm1PGHQVs6HiqBMZADDyOD/he67+tWdz1RlwC5808DhZ/JaUNaLAdOOfZt15Bv
	JEyhZUylgfxzWtOt2gqVoznOCsSGAy5h/mbhiw==

t0006 uses a hard-coded test date and provides no convenient
way to override it temporarily.  Add an optional parameter to
check_approxidate to adjust the time as needed, and demonstrate
the feature with a new test.

Signed-off-by: Tuomas Ahola <taahol@utu.fi>
---

Notes:
    > As you are not doing the test-date-now adjustment when $4 is not
    > given, wouldn't it be a lot easier to read if you did something like
    >
    > 	old_date=$GIT_TEST_DATE_NOW
    > 	if test -n "$4"
    > 	then
    > 		# the convention for $4 is a bit weird in that it
    > 		# comes with its own +/- operator in front.
    > 		GIT_TEST_DATE_NOW=$(( $old_date $4 * 60 * 60 ))
    > 		caption="$1; offset $4h"
    > 	else
    >         	caption=$1
    > 	fi
    >
    > instead?  Other two minor points are
    >
    >  - Documentation/SubmittingPatches prefers an explicit "test" over
    >    "[ ... ]", and have "then", "else", etc. on their own lines.
    >
    >  - As you never "unset" GIT_TEST_DATE_NOW, you do not have to keep
    >    exporting it.  It is not like there are two variables (one for
    >    shell, the other for environment) and every time you set the
    >    shell one you need to export to reflect the value to the
    >    environment one.  Rather, a single "export" marks a shell
    >    variable and every time it changes value, it is updated in the
    >    environment as well.
    >
    
    Thanks, applied.
    
    > One, it sucks to have to say "success" here, but is awkward because now
    > we have two optional arguments. There's nobody passing "failure" right
    > now, so we could just drop support, though that might be annoying later
    > when somebody wants to add a failing test. But we could perhaps switch
    > to allowing:
    >
    
    Ok, now it works without "success" in between, and "failure" works without
    an offset, too.
    
    	check_approxidate <test-string> <expected-result> [<test-time-offset>] [failure]
    
    > The second thing is that "+48" is pretty opaque. It's a relative offset
    > to some arbitrary point. To some degree the script already suffers from
    > that (all of the tests are using some arbitrary point), but I think the
    > offset (without units!) adds a layer of indirection that makes it even
    > more confusing.
    >
    
    Good catch.  Now it is at least marginally better with the added units.

 t/t0006-date.sh | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index 53ced36df4..c7667bade2 100755
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
@@ -182,6 +211,8 @@ check_approxidate 'noon today' '2009-08-30 12:00:00'
 check_approxidate 'noon yesterday' '2009-08-29 12:00:00'
 check_approxidate 'January 5th noon pm' '2009-01-05 12:00:00'
 check_approxidate '10am noon' '2009-08-29 12:00:00'
+check_approxidate 'January 5th yesterday' '2009-01-29 19:20:00'
+check_approxidate 'January 5th yesterday' '2008-12-31 19:20:00' '+2 days'
 
 check_approxidate 'last tuesday' '2009-08-25 19:20:00'
 check_approxidate 'July 5th' '2009-07-05 19:20:00'
-- 
2.30.2

