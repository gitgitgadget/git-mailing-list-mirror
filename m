Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37CA33BBD1
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 06:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776319262; cv=none; b=APEOYpf3CKFAXyrLBayGfW0XoDJnrKAadK8cwbzuHl6AVeL5v3pB2QdV5HAcLbB1L43tJ64PAQ//XTKnioHo2DEl8pHLEZRPLfZwC04+788TKQEjsxlwEPcNXSsRr/i5gnOJ9Cpjdh4a7RPLcgdU2T73FhSRqHFIXj+qx4cLu0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776319262; c=relaxed/simple;
	bh=vi9o41/Sm0SavoBz47lml9ATFmxT6uQaRCFBXG8fQU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPSCWqSyhDFhyNP21x2yqEM9g/ibFKN/3G092LXZd6oYTurWr72uVsY7I2fRI4584/TrEPTxUTj88DfgHTA1IPItdAsljuUaDVCKvmIgrsbbIZDKBq1U9nbKc4SzxjuO8epMxLC01l29F/a+IHTybDLhmj2va+3mpPAlDNywWfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=bLNFnTDw; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="bLNFnTDw"
Received: (qmail 366080 invoked by uid 106); 16 Apr 2026 06:01:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=vi9o41/Sm0SavoBz47lml9ATFmxT6uQaRCFBXG8fQU4=; b=bLNFnTDwFzxdHWm/ETnllut72mw12evHn8tgo70sodtod2ldfnvEcRd/g3Ac156WSoX+bcdAUDcWFJ9Fvl8ZCF9PBybsRRWsenRB6eybQdscwu2z67cyFFsOhMLs7TO4TEhe5ul2K0Y0zZ1nxetipO/MFsN1oi3nq+DidEcSBlym/a3v9wbEiAY4cZMqCaZa6YvEr94bZpGg10t2OUM48TQpZsceziv3UrYq0dcuSYFY0gCgy9rUTwsXDYLLnyxsP/Sk093m441uxRH071Cgq9Du3sqWFMzgnDA8Rwabx2aI+w052HpLHxyWYB9GqNTBwV6wU583m4iLH9kL4BVxzQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Apr 2026 06:01:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 611393 invoked by uid 111); 16 Apr 2026 06:00:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Apr 2026 02:00:59 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 16 Apr 2026 02:00:59 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 12/12] t: detect errors outside of test cases
Message-ID: <20260416060059.GC646814@coredump.intra.peff.net>
References: <20260415-b4-pks-tests-with-set-e-v2-0-4e4904a96f15@pks.im>
 <20260415-b4-pks-tests-with-set-e-v2-12-4e4904a96f15@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260415-b4-pks-tests-with-set-e-v2-12-4e4904a96f15@pks.im>

On Wed, Apr 15, 2026 at 03:06:45PM +0200, Patrick Steinhardt wrote:

> Improve the status quo by enabling the errexit option so that any such
> unchecked failures will cause us to abort immediately.
> 
> Note that for now, we only enable this option for Bash 5 and newer. This
> is because other shells have wildly different behaviour, and older
> versions of Bash (especially on macOS) are buggy. The list of enabled
> shells may be extended going forward.

OK, we know that this does not cause false positives because all of the
tests should pass. It would be nice if we could verify that it catches
bugs, too. Doing this:

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index e4d32bb4d2..5521f21e64 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -980,4 +980,6 @@ test_expect_success 're-init reads matching includeIf.onbranch' '
 	test_cmp expect err
 '
 
+test_expect_foobar 'baz'
+
 test_done

will fail for me, but only if I specially ask to use bash, either
manually or by setting TEST_SHELL_PATH (since /bin/sh is dash on
Debian). Is there something in both GitHub and GitLab CI that will
reliably use an acceptable version of bash?

I guess perhaps Windows, though I don't know what version is used there.
But should we maybe set TEST_SHELL_PATH in at least one of the linux
builds?

-Peff
