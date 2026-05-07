Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BD433B6F9;
	Thu,  7 May 2026 07:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778139462; cv=none; b=LU62lqHLulh5qWa5FNh1VHHReyiXavcV5ITUPLxa4CPMxZqzbj6iUw9zIlkP/Lr9NypssCw2nHGjQPiCi5Vd1iivH5HtRuGPzlcOXaSNvR0Mbde010Rd84nF1q/eNh4G6GxrnXfb7eZ77emyRnETUWSmmAHwJOb4MYwYP4rvqZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778139462; c=relaxed/simple;
	bh=gFo43xAM8TKoASH48wztLTGwf751dYSaheY7ISz2jfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=szSeIZ0xWe4CsiOM4iSPKG0vz5aU6x3WSqDbjjC+n+1Q/88QY6r1xl/lQ879fwONz2yywglHY9VNkMgWicFZMcn/clOG2V9TjFoKSzZOwQQ20AqdvKMguzrmOmsH+YOb/18SaT2itpxnfywN3FMJpinmzj9qwfoVrVoWDkM9DLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=GzWSo2cY; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="GzWSo2cY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=dwMhwOK8oJURIO5qw3L35xC86cY0d6QW7NA9X8zr4NU=; 
	b=GzWSo2cYbUM88NmbI4t+XEQH6TdoednU+ySeeqxPSgPAPl5fSx6iGwNRBNVXY1lWXt80+Di9K0t
	7GH+hScETZjOuugCdCf0bGe6o/U5a8YRPhUWRi2BtfbLaLp68770IhtcwWNShQAr9oflDMtUzZ7bQ
	0cspDf8RCMy35rZ2Nkib4QCi0AC3dKSeTMw+SxhKQlmGaBVTqnpO1w0ALCZJe0Nggl9PU4E0dnxh5
	WyzVpAT9RZHGgQYcwuRdTYkf0PhzO+DW/pn8YWhOuav97DsINgDa7eItAEicLzAJVspGckRV+HPw/
	WUQ5QwMbfYOqy8lt5ShDRy693x5719ZPd5LA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wKtIW-00C0NL-1n;
	Thu, 07 May 2026 15:37:29 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 07 May 2026 15:37:28 +0800
Date: Thu, 7 May 2026 15:37:28 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	DASH Mailing List <dash@vger.kernel.org>
Subject: Re: [PATCH] parser: Fix multi-byte output in here-doc with quoted
 delimiter
Message-ID: <afxBOHhvXC7VxG3G@gondor.apana.org.au>
References: <20260402-pks-tests-with-dash-v2-0-cd7ab11dabc0@pks.im>
 <20260402-pks-tests-with-dash-v2-1-cd7ab11dabc0@pks.im>
 <afwpyiK9mh23c-JV@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afwpyiK9mh23c-JV@gondor.apana.org.au>

On Thu, May 07, 2026 at 01:57:30PM +0800, Herbert Xu wrote:
> On Thu, Apr 02, 2026 at 08:51:18AM +0200, Patrick Steinhardt wrote:
> > When executing our test suite with Dash v0.5.13.2 one can observe
> > several test failures that all have the same symptoms: we have a quoted
> > heredoc that contains multibyte characters, but the final data does not
> > match what we actually wanted to write. One such example is in t0300,
> > where we see the diffs like the following:
> > 
> >   --- expect-stdout	2026-04-01 07:25:45.249919440 +0000
> >   +++ stdout	2026-04-01 07:25:45.254919509 +0000
> >   @@ -1,5 +1,5 @@
> >    protocol=https
> >    host=example.com
> >   -path=perú.git
> >   +path=perú.git
> >    username=foo
> >    password=bar
> 
> Thanks for the report.
> 
> This patch should fix the problem.  Please let me know if there are
> any more oustanding issues.

Oops, I forgot to cc the mailing list.  Sorry for the resend.

---8<---
For a here-document with a quoted delimiter, multi-byte characters
should be written out as is with no escaping.  Fix this by checking
for syntax == SQSYNTAX (the only time readtoken1 gets called with
SQSYNTAX is for such a here-document) before calling getmbc in
readtoken1.

Reported-by: Patrick Steinhardt <ps@pks.im>
Fixes: b12f136cc704 ("builtin: Process multi-byte characters in read(1)")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/parser.c b/src/parser.c
index bea4148..412e876 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -998,9 +998,13 @@ static char *dollarsq_escape(char *out)
 STATIC int
 readtoken1(int firstc, char const *syntax, char *eofmark, int striptabs)
 {
-	struct synstack synbase = { .syntax = syntax };
+	struct synstack synbase = {
+		.dblquote = syntax == DQSYNTAX,
+		.syntax = syntax,
+	};
 	int chkeofmark = checkkwd & CHKEOFMARK;
 	struct synstack *synstack = &synbase;
+	bool sqheredoc = syntax == SQSYNTAX;
 	struct nodelist *bqlist = NULL;
 	int dollarsq = 0;
 	int c = firstc;
@@ -1009,9 +1013,6 @@ readtoken1(int firstc, char const *syntax, char *eofmark, int striptabs)
 	size_t len;
 	char *out;
 
-	if (syntax == DQSYNTAX)
-		synstack->dblquote = 1;
-
 	STARTSTACKSTR(out);
 	loop: {	/* for each line, until end of word */
 #if ATTY
@@ -1035,7 +1036,8 @@ readtoken1(int firstc, char const *syntax, char *eofmark, int striptabs)
 				      out);
 			fieldsplitting = synstack->syntax == BASESYNTAX &&
 					 !synstack->varnest ? 4 : 0;
-			ml = getmbc(c, out, fieldsplitting);
+			ml = getmbc(c, out, fieldsplitting |
+					    (sqheredoc ? 2 : 0));
 			if (ml == 1) {
 				if (out == stackblock())
 					return TBLANK;
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
