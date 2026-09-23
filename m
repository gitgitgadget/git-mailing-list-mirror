Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D806535FC8
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 16:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790182766; cv=none; b=TX6ogtoBBGnE/vI7dlG7Neng9RjVH19QPz3r+l6TvhyGsqsTDz/PYzzZ5gS7Cv2gKypGk0NpSoJBS9eUlNSko05CFtgt7bFilHWDLVitGVpMLwLqU6Tb5U9f7y//VVKVlscz3HX51f5yDAB31afNXXQDIWFITD55nbl96K8bDXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790182766; c=relaxed/simple;
	bh=FwNh/yw+DM0gYNpC65wmR7+I9OIdwlo656y17rGtm68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWGM47RO56fR+5PoUAcUFG/yMzBDDDUVlLPB3cLrMck5TWN4Zq8Ju14hi333iENaut9PhUp2p+/kNOvPgBS3vgpLckpviONksnwlhSEzzCgrlfIhLDtXpfS3dX++6BfoIEL+R0OmJmcMWKOrExT1mYpy9s74jxdw6/B9kz9s93k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=EwsEWcun; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="EwsEWcun"
Received: (qmail 35114 invoked by uid 106); 23 Sep 2026 16:59:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=FwNh/yw+DM0gYNpC65wmR7+I9OIdwlo656y17rGtm68=; b=EwsEWcunm2Nbcnl72bwrHFhhTy9ZQPph/TJjTLKhV9J0NFSS59DPCf/Unpf9U/CL1LcUEGz/eKo1IQfFXsRbW9NQbuvW5m8rbqA40xSHI+5AJfldqJfgEqj5ERBJvFdQq7y6+NkNwaU+ornTb0rcGq4oT6NlZBMonneaH2mZ5DO3xFcLpqTN63MKHkC0JPcyRzgsmJzIUGCOzsjDPtox3Pe3r7xzVNZcF7cLk+u9am38KrlJzI5676Y8Tm33Wb6pqG37hcP98VbFwGMcRCvQV0dZwzVJWe/6ong2jFb39syKLju60Wv+H1iTcZTwsRVJN3122hInfVkygo6MKl6nFA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 23 Sep 2026 16:59:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 181581 invoked by uid 111); 23 Sep 2026 16:59:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 23 Sep 2026 12:59:22 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 23 Sep 2026 12:59:22 -0400
From: Jeff King <peff@peff.net>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci: work around Debian 12's HTTP/2 authentication
 failures
Message-ID: <20260923165922.GB29229@coredump.intra.peff.net>
References: <pull.2236.git.1790118373340.gitgitgadget@gmail.com>
 <20260923164700.GA28538@coredump.intra.peff.net>
 <20260923165348.GA29229@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260923165348.GA29229@coredump.intra.peff.net>

On Wed, Sep 23, 2026 at 12:53:48PM -0400, Jeff King wrote:

> I guess our robot overlords^Whelpers could help with that. I passed your
> patch and my email to Astra, which came up with this:
>
> [...]
>
> Not too bad. I had envisioned checking the range of versions, since you
> found the fix (but we'd have to either use 7.88.1 as the start, or find
> the actual bug introduction). But this covers at least as much as the
> CI debian-12 specifier would.

OK, last email, I promise, since you could probably be feeding this to
Astra just as easily as I am (and you did the actual interesting work on
the patch of figuring out the problem, so I'll leave it to you decide
which approach you like). The range version is something like this:

diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 805bec025c..3d18f98c9d 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -17,6 +17,21 @@ fi
 test "$HTTP_PROTO" = "HTTP/2" && enable_http2
 start_httpd
 
+# Curl 7.88.1 can fail to retry authentication after an early HTTP/2
+# response. This was fixed in curl 8.3.0; see
+# https://github.com/curl/curl/pull/11756. The first affected version is
+# unknown, so conservatively assume that versions from 7.88.1 up to (but
+# not including) 8.3.0 are broken.
+test_lazy_prereq HAVE_CURL_HTTP2_BUG '
+	test_have_prereq HTTP2 &&
+	build_option libcurl |
+	awk -F. '\''
+		($1 == 7 && ($2 > 88 || ($2 == 88 && $3 >= 1))) ||
+		($1 == 8 && $2 < 3) { broken = 1 }
+		END { exit !broken }
+	'\''
+'
+
 test_expect_success HTTP2 'enable client-side http/2' '
 	git config --global http.version HTTP/2
 '

which is not _too_ ugly.

-Peff
