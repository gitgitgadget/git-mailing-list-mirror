Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD0D1CD0C
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 03:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756179878; cv=none; b=oZUoJwnSS+2Hx81nfWoHhJxrfTP6S5N+jXLstanV1JDHdQCeDVPAaDf1gByooh7dCvIJOPHmOZHjg+OH2cZi8/5hD2oUNI1JfbEKCIhQhfJGFrcBKbsWqJlPwNiENZwdi04BHCJZit89CYAkWeGKpdO7WYy2/pLX6lK3KC6wxA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756179878; c=relaxed/simple;
	bh=UpPemDRDzd3IRC+nRTNrCNLbJ47+WFlhhdv56jpsv8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8AHIxkelCevWelqZoRHWmf3wbd63PhPWbUBJQ2R89H/7kzKVIa51xVolfwzpGallcuA7PQX/vaH94gfWOE0OnDYoFgrXMG03Ai1TuIQP9l2zorJiCUtVbr1+Vc9SkgsulVS44KRUELSqH6essx3mFITPNov+ruRa7Tc/3TcvLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=QOSjfXnl; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="QOSjfXnl"
Received: (qmail 114131 invoked by uid 109); 26 Aug 2025 03:44:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=UpPemDRDzd3IRC+nRTNrCNLbJ47+WFlhhdv56jpsv8Q=; b=QOSjfXnlFeQytl7lQtnyN4xpkF1eKXE8ik/Hds6/CkVObcHO6OaTIat6VhcWkAj6rmcIu8M4P82ABZMNoTBf00ToK5Yh7+5SUwcFEAcsJmZ4PejB7TeqcFp6IYhMrhBhzCzB66sb7YVfuD1AFWGuKkmmHDPoVE7FFKBkoOAQKKhn1kwWV4t3KK0m9aPJR7kHX4YrvJf9DLLZNKt9x5ocHBGQHygvyKC7pVd4DCWKAbdY5tvq3kfE4OjtGu11xw78R94RZ87R4oRR9+XEswHzKcZs75j0u54i8Xx7NBbPfNK+VwCRsrh+3xweKRQY8xn65CsV1u8E4USmZBZv6O73jQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 26 Aug 2025 03:44:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 166118 invoked by uid 111); 26 Aug 2025 03:44:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 25 Aug 2025 23:44:34 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 25 Aug 2025 23:44:34 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 3/4] t5510: prefer "git -C" to subshell for
 followRemoteHEAD tests
Message-ID: <20250826034434.GB388997@coredump.intra.peff.net>
References: <20250819192004.GA1058857@coredump.intra.peff.net>
 <20250819192716.GC1059295@coredump.intra.peff.net>
 <aKtq47vmCrUZCUCF@szeder.dev>
 <xmqqfrdftnet.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfrdftnet.fsf@gitster.g>

On Mon, Aug 25, 2025 at 08:46:02AM -0700, Junio C Hamano wrote:

> > I for one think that the original is much more readable.
> >
> > With the subshell it's quite clear, even at a cursory glance, which
> > commands are executed in a subdirectory, but when using '-C dir' all
> > over we have to look closely.  Furthermore, when there is a command
> > outside of the subshell, we can be fairly sure that it's intentional,
> > but when a command without '-C dir' lurks among many others using '-C
> > dir', then we can't be so sure, but have to investigate whether that
> > was intentional or oversight.
> 
> Unfortunately I tend to agree.  A few downsides I find a bit
> problematic in the subshell solution are
> [...]

OK, I am happy to drop that patch (3/4). The resulting change to the
final patch to match style would be:

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 6e8b741491..bac464a9ec 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -269,12 +269,16 @@ test_expect_success 'followRemoteHEAD does not kick in with refspecs' '
 '
 
 test_expect_success 'followRemoteHEAD create does not overwrite dangling symref' '
-	git -C two remote add -m does-not-exist custom-head ../one &&
-	test_config -C two remote.custom-head.followRemoteHEAD create &&
-	git -C two fetch custom-head &&
-	echo refs/remotes/custom-head/does-not-exist >expect &&
-	git -C two symbolic-ref refs/remotes/custom-head/HEAD >actual &&
-	test_cmp expect actual
+	test_when_finished "git -C two config unset remote.custom-head.followRemoteHEAD" &&
+	(
+		cd two &&
+		git remote add -m does-not-exist custom-head ../one &&
+		git config remote.custom-head.followRemoteHEAD create &&
+		git fetch custom-head &&
+		echo refs/remotes/custom-head/does-not-exist >expect &&
+		git symbolic-ref refs/remotes/custom-head/HEAD >actual &&
+		test_cmp expect actual
+	)
 '
 
 test_expect_success 'fetch --prune on its own works as expected' '


But both patches are already in 'next'. How do you want to proceed? I
can prepare a patch on top converting back to sub-shells. Or if we are
going to do the post-release rewind of next, that is an opportunity to
fix things cleanly. Or we could leave it as-is if it is not worth the
bother at this point.

-Peff
