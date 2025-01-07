Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BD41DE8A0
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 07:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736233716; cv=none; b=cdLMjX04nilrpNwb6JtW730R0/nJsujMycJVSHmTzDJJJ9OyNG+XPTQ+ysCvptfTxgpM23fbofrQqnIAqoFOdG/jZOnmIXZSCbqwzZQrTwYK1aG7UzDRciBmNimmrAsc3lbc6NG/gh8W104oadjlWBrJCKG80vAELhdSB7gDc+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736233716; c=relaxed/simple;
	bh=Si4839AkEGty6cKC+BE+sP3DqvKT3S8sjN85asVmDEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DwKvjxr20UFI6U9x+OrZskNEV7yYqWvDL39J1eCqJUk/TKm0e4se0IV3NyZ3Hl3DDqXho6RywsqyOs6Uu4uXE+Ou89JI8hfaevqSn/xRvXO3zjeeDEye6YNut6ZUedM6s2TOIl+pt13ejfQzU+ykW3P3TUnPcs8FIt9LQIAoy7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=FbWnkAXt; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="FbWnkAXt"
Received: (qmail 29050 invoked by uid 109); 7 Jan 2025 07:08:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Si4839AkEGty6cKC+BE+sP3DqvKT3S8sjN85asVmDEM=; b=FbWnkAXtpPeHnSF6oUe15oixN3kYPblJr7HsXroTaeCNjK+xxTJpO8arNOwuG94OvLroLzhughLK8Pturm24Tke1+IgB842sQN+PHd7fRDjGz9OraPcCCWtP8cwo27RRCSlbAw7K05KH4JM1qs9Xd5lXl5o4PBSROEt7GPPOGKCuKdhJZPh0gvGrIN4it9y0nmSOuuAUl0Cse0JgtbbD3COEH7lO3p1FiwV1cc/9bC4IC9PbVt3+ITwunjhbkBsr+8QHu9oytJlmNUAX2ASmPjXYnIrzVyOOMOsO007urb4bRiNsnx2GReiRisI5nMXonuebbZmMOap7c38pXFz5yw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Jan 2025 07:08:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21879 invoked by uid 111); 7 Jan 2025 07:08:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Jan 2025 02:08:31 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 7 Jan 2025 02:08:31 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: [PATCH 3/3] test-lib: add a few comments to LSan log checking
Message-ID: <20250107070831.GC584668@coredump.intra.peff.net>
References: <20250107070409.GA584456@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250107070409.GA584456@coredump.intra.peff.net>

Commit b119a687d4 (test-lib: ignore leaks in the sanitizer's thread
code, 2025-01-01) added code to suppress a false positive in the leak
checker. But if you're just reading the code, the obscure grep call is a
bit of a head-scratcher. Let's add a brief comment explaining what's
going on (and anybody digging further can find this commit or that one
for all the details).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/test-lib.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 898c2267b8..9f27a49995 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1172,6 +1172,11 @@ test_atexit_handler () {
 check_test_results_san_file_has_entries_ () {
 	test -z "$TEST_RESULTS_SAN_FILE" && return 1
 
+	# Lines marked with DEDUP_TOKEN show unique leaks. We only care that we
+	# found at least one.
+	#
+	# But also suppress any false positives caused by bugs or races in the
+	# sanitizer itself.
 	grep -s ^DEDUP_TOKEN "$TEST_RESULTS_SAN_FILE".* |
 	grep -qv sanitizer::GetThreadStackTopAndBottom
 }
-- 
2.48.0.rc2.377.g0507c08f68
