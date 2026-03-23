Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CB02AD03
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 06:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774245736; cv=none; b=ch80vkLWm4H+JZUtlvKOOEjHgJxiDFgceFy+2wygyFdE83bGMPjqDYZoGkt935NjDeX4OA5w+7/4/qlEqBvrWnsSU9KTNMRRiiScBx4BH8Wd2+zRnAe1TiI/YbDmr6eP+KtYNkv8r6ZtIK8QSYG2LOlbphwsE6MxHMXHjNTWCtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774245736; c=relaxed/simple;
	bh=v9y0HEgfdSiRAtugilB+iGfDIHEsC65gp1KnyVhwZqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXm5BdsRBsHNCVSeTXa9JS1NUijlRyZ357kD7IMdZH08+yTPc1KVKiptAuckst9Uj5eZvwKdZ0BODYQoNB/zD/kEGeG/SajmOqBjMtdDPylQHfFIYVUDmzaX6ClaUIwrw+y4YFJBmnpGj362dK6IbG2EdlAxtDTgupJUFEmbz9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=g2EJ1HCE; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="g2EJ1HCE"
Received: (qmail 110207 invoked by uid 106); 23 Mar 2026 06:02:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=v9y0HEgfdSiRAtugilB+iGfDIHEsC65gp1KnyVhwZqY=; b=g2EJ1HCEoMfFvnO0or54xNJxWUiR4whN9PAcx0BysLLaa2IC2oSrurwvXdneA+blmbiJS13qK/NywsUUWTBaLvZRCDUq8W6hJWSbmJthjeXB6rCwbri5MNjwkTD0TOYRBnEGO1OTRo/RiR+oVMVuYyX9cpWVeEK8BOmyGOY2c9H3O7OXKWO6oE5gtX6LmQ4wfQIHel8vnIysqNgGZBpIJpBLdixxHJghgDFWMPRPI/06b+aqBNJQcgO7Rz1LfXMEPOGwDmBimNpKHsaIegOYvGPIQZBKFwPQjhQ/kKAO01KtjzQQGKcTvAmWPxL7vBz5dCKvBEUaU6udlF+H1oCegw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 23 Mar 2026 06:02:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 147005 invoked by uid 111); 23 Mar 2026 06:02:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Mar 2026 02:02:13 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 23 Mar 2026 02:02:13 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Tian Yuchen <a3205153416@gmail.com>, Scott Baker <scott@perturb.org>
Subject: [PATCH v2 6/8] diff-highlight: test color config
Message-ID: <20260323060213.GF10482@coredump.intra.peff.net>
References: <20260323060139.GA10215@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260323060139.GA10215@coredump.intra.peff.net>

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
index 4f3d55a26e..b38fe2196a 100755
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
2.53.0.1051.ga14e96f895

