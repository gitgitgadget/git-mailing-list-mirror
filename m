Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720E040DFB1
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 00:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773967522; cv=none; b=hCyd1AQoXJSrMzp8AL4fAo1MDKFJVnjdq5TH26+uxqbUQ9oMx0SAS0LQbAq201plmlyaDLNTrTb5HuT+m/VSZ7G0rOefet790m74hWadFlCzBjNN2A6Gy5bxGQjDHSPX2EYmS4EqGxNcHQH6VHoFCP9CNr31f52o/HCuQO06KJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773967522; c=relaxed/simple;
	bh=dAmbfPNhqPpTWhpDmAnymLrkqN7dQDHLzQuGjxFbUHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AK17B51/ZMyXKaYYBTVt9WJEhzO3tWqjDyN8Q0zocgRzt/WQJ+XzU6Ckkav//yDznVvPNXAHzKME3cYBPpouJysHQUU9fw1PEIscQZUqu9HF5RD+viATNLZ4DLdFs9aoQO326VIulEWgibwDlvlx8L7mCK7pAmBH7IeYzqJADr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=iBbvkMVm; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="iBbvkMVm"
Received: (qmail 62460 invoked by uid 106); 20 Mar 2026 00:45:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=dAmbfPNhqPpTWhpDmAnymLrkqN7dQDHLzQuGjxFbUHE=; b=iBbvkMVmvkDTOVCm+LHB/1gTPOG9b710unkXvU5zGbooywRip/1VH6qiynphBLABJb1DRMd/mIgk2W3fYZtVAA6rEC4iGOGQniRB3DMsLnD1JHrpAx/BBezxFZ4lsZ2qXNm+rnt5lFXZhb2rdn6KN2m1oowsrKV63N97klLacB9ctwr6gZWnLW7sLsjXDoLuaUhVfx1uwNlsOYYQ6Afg/bFbjM0nl2jjk/d2nJS3ceojmXdeMlw5AOopukOghVoZJqqLkdN5tOyYDPODEQ/jrDUtYhEdZY62L79fkik3+rbYlOjYbKW/jiSzk3INFtaMcyu50GDwqtkWMl5BKn/DBw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 20 Mar 2026 00:45:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 91703 invoked by uid 111); 20 Mar 2026 00:45:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 19 Mar 2026 20:45:20 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 19 Mar 2026 20:45:19 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Scott Baker <scott@perturb.org>
Subject: [PATCH 6/8] diff-highlight: test color config
Message-ID: <20260320004519.GF3654226@coredump.intra.peff.net>
References: <20260320004138.GA3653623@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260320004138.GA3653623@coredump.intra.peff.net>

We added configurable colors long ago in bca45fbc1f (diff-highlight:
allow configurable colors, 2014-11-20), but never actually tested it.
Since we'll be touching the color code in a moment, this is a good time
to beef up the tests.

Note that we cover both the highlight/reset style used by the default
colors, as well as the normal/highlight style added by that commit
(which was previously totally untested).

Signed-off-by: Jeff King <peff@peff.net>
---
 .../diff-highlight/t/t9400-diff-highlight.sh  | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/contrib/diff-highlight/t/t9400-diff-highlight.sh b/contrib/diff-highlight/t/t9400-diff-highlight.sh
index ba80cda7c8..828d59e9c6 100755
--- a/contrib/diff-highlight/t/t9400-diff-highlight.sh
+++ b/contrib/diff-highlight/t/t9400-diff-highlight.sh
@@ -350,4 +350,32 @@ test_expect_success 'highlight diff that removes final newline' '
 	EOF
 '
 
+test_expect_success 'configure set/reset colors' '
+	test_config color.diff-highlight.oldhighlight bold &&
+	test_config color.diff-highlight.oldreset nobold &&
+	test_config color.diff-highlight.newhighlight italic &&
+	test_config color.diff-highlight.newreset noitalic &&
+	echo "prefix a suffix" >a &&
+	echo "prefix b suffix" >b &&
+	dh_test a b <<-\EOF
+	@@ -1 +1 @@
+	-prefix <BOLD>a<NORMAL_INTENSITY> suffix
+	+prefix <ITALIC>b<NOITALIC> suffix
+	EOF
+'
+
+test_expect_success 'configure normal/highlight colors' '
+	test_config color.diff-highlight.oldnormal red &&
+	test_config color.diff-highlight.oldhighlight magenta &&
+	test_config color.diff-highlight.newnormal green &&
+	test_config color.diff-highlight.newhighlight yellow &&
+	echo "prefix a suffix" >a &&
+	echo "prefix b suffix" >b &&
+	dh_test a b <<-\EOF
+	@@ -1 +1 @@
+	<RED>-prefix <RESET><MAGENTA>a<RESET><RED> suffix<RESET>
+	<GREEN>+prefix <RESET><YELLOW>b<RESET><GREEN> suffix<RESET>
+	EOF
+'
+
 test_done
-- 
2.53.0.945.ge67b727e8d

