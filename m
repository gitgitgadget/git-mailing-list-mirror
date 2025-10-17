Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE9F29D279
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 08:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760690698; cv=none; b=dINwof5ThOiAj5/NekwC5e5NooJLBsQ0BO+3aNfBhTutPbZ21RJPXzJ8oHxpCtfUDTmUMp/wINNgFyvF0EUbNClk1SibOut6jib1nK2OlHbs1fxA3FH1OH6UqTP173mNfKI5+VdLvrwjkaEjwTFCw+BzHVM/Nz7a3s0uqjYa2gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760690698; c=relaxed/simple;
	bh=yvvCH0gz4R5teIQAm2+ECBRjlgV+0VYyu6GXkH78iJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGYJHHGylcehSt4Ghld7jTVrShGDarstrM9NH1NvBMfyYcFb1z+CYuot+mC22aT8hoGKsP3fhkxDDn+VuspvvBbuEPnSurtlSQX+wS7SXSQH5dFcOmuh63kKuEsmVCTR/iRbEGXAVfJD3eNIcsMKORk+ynOJ/M+XMNHVzauyBPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=AltgaiFI; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="AltgaiFI"
Received: (qmail 252280 invoked by uid 109); 17 Oct 2025 08:44:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=yvvCH0gz4R5teIQAm2+ECBRjlgV+0VYyu6GXkH78iJE=; b=AltgaiFINf0F7NaeYOr9zE3wWXDK0cU8C1SiIuEUPwxipMfVyYytUhfR/iQmxjJPa23MDVqW73qKf8O3QPGkCVjf9p6oSH/5exelD8FGgn3BfuV0KAPfZWYL9rD/L3GRgvFt7X2VUoWbmDsk5Qi8RIPTuLf2nI0ALGM5HAADEKGpI0wzUB6JEaFp5UTGjVftfM3ScA/wEdxaNRqObpkWSs4rphlJEX3CazZHnR1Wbj2aNSPktY4E2uKnEsoqHnciYNUAkvgfosYJz57d1jg8uYGDgbrzyXfbCfduF+6QhWKb16mZhtBZqcRc+opNggIVAl9vXfPV2zhPmkdI3Ky1Ew==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 17 Oct 2025 08:44:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 393797 invoked by uid 111); 17 Oct 2025 08:44:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 17 Oct 2025 04:44:55 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 17 Oct 2025 04:44:55 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Langbart <Langbart@protonmail.com>
Subject: [PATCH resend] status: make coloring of "-z --short" consistent
Message-ID: <20251017084455.GA4096702@coredump.intra.peff.net>
References: <XCDlwEkTlgoZIyIf_8BfOGl1C3C63Ioxeib4BRNJ9Jm_CtYWKT3qu-pDaeXVtS1Ifq6E4pT9G0yDbIS_nSwN-uiBuBNAlMyrOv0R1RyM7oc=@protonmail.com>
 <20251007082920.GA3349249@coredump.intra.peff.net>
 <20251007203406.GA4028057@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251007203406.GA4028057@coredump.intra.peff.net>

When running "git status -z --short", the marker on modified index
entries (e.g., "M") is colorized, but the "??" marker for untracked
entries is not. Let's fix the "??" entries to show color here.

At first glance you might think that neither should be colorized, as
usually one would use "-z" to get machine-readable output. But this is a
tricky and unusual case. We have two output formats, "--short" and
"--porcelain" which are substantially similar, but differ in that
"--short" is for humans who want something short and "--porcelain" is
for machines. And "-z" by itself, without any other output option, does
default to "--porcelain", so "git status -z" will not colorize anything.

But if you explicitly ask for "-z" and "--short" together, then that is
asking for the human-readable output, but separated by NULs. This is
unlikely to be useful directly, but could for example be used if the
output will be shown to a human outside of the terminal. At any rate,
the current behavior is clearly wrong (since we colorize some things but
not others), and I think colorizing everything is the least-surprising
thing we can do here.

Reported-by: Langbart <Langbart@protonmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
Re-sending unmodified, as the original from 10 days ago did not generate
any discussion, and doesn't seem to have been picked up for 'seen'.

 t/t7508-status.sh | 11 +++++++++++
 wt-status.c       |  4 ++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index cdc1d6fcc7..abad229e9d 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -717,6 +717,17 @@ test_expect_success TTY 'status -s with color.status' '
 
 '
 
+test_expect_success TTY 'status -s keeps colors with -z' '
+	test_when_finished "rm -f output.*" &&
+	test_terminal git status -s -z >output.raw &&
+	# convert back to newlines to avoid portability issues with
+	# test_decode_color and test_cmp, and to let us use the same expected
+	# output as earlier tests
+	tr "\0" "\n" <output.raw >output.nl &&
+	test_decode_color <output.nl >output &&
+	test_cmp expect output
+'
+
 cat >expect <<\EOF
 ## <YELLOW>main<RESET>...<CYAN>upstream<RESET> [ahead <YELLOW>1<RESET>, behind <CYAN>2<RESET>]
  <RED>M<RESET> dir1/modified
diff --git a/wt-status.c b/wt-status.c
index 8ffe6d3988..e12adb26b9 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -2042,13 +2042,13 @@ static void wt_shortstatus_status(struct string_list_item *it,
 static void wt_shortstatus_other(struct string_list_item *it,
 				 struct wt_status *s, const char *sign)
 {
+	color_fprintf(s->fp, color(WT_STATUS_UNTRACKED, s), "%s", sign);
 	if (s->null_termination) {
-		fprintf(s->fp, "%s %s%c", sign, it->string, 0);
+		fprintf(s->fp, " %s%c", it->string, 0);
 	} else {
 		struct strbuf onebuf = STRBUF_INIT;
 		const char *one;
 		one = quote_path(it->string, s->prefix, &onebuf, QUOTE_PATH_QUOTE_SP);
-		color_fprintf(s->fp, color(WT_STATUS_UNTRACKED, s), "%s", sign);
 		fprintf(s->fp, " %s\n", one);
 		strbuf_release(&onebuf);
 	}
-- 
2.51.1.685.g6bf3278fbc

