Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2679B3612FA
	for <git@vger.kernel.org>; Sat, 28 Feb 2026 10:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772276332; cv=none; b=bwEuxLAWHgxoq77/dCJH1suxuV1E4UaRNDbtTIrqkHdFffZADx3P+2j4B5OfCAS8cQYZiCgawd5BZ19Nx0R8VzUJj/KiWgSN5eXcHxp6qG2GrpeiZBRYrec4w/WyYbx45W6H0GqApv4swyKK5ZfxZNZCUjox9jgMlgSUDvmrBNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772276332; c=relaxed/simple;
	bh=Vl3YfZ4rIY7EGcFmBwxxQbiXsqbVOqHIl++dyi4Nilc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f++We4ufbCYwgjcg7HYV28/Dxb2V+4jJEaMi1dc/XOZJjcPl9B0OKAlPdVWP336gPxyOk0EkowxL/r9a4a0foz7S56YEhQWQLNA+d2VUWP+Te7ldHdMbWKNF6Ezvpo7JqX52gNRsPdWyMMObAqxOlUNJlPPw55q9ccRWUdmuz7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ahnDJj9k; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ahnDJj9k"
Received: (qmail 86213 invoked by uid 109); 28 Feb 2026 10:58:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=Vl3YfZ4rIY7EGcFmBwxxQbiXsqbVOqHIl++dyi4Nilc=; b=ahnDJj9kf687ca6RfEZIPoiPHwInOJl1GnZf1Tb/Recj9qZRG1F9SVl5kTtn9Q/ZHdXow3B5QApCqNPdiRoZlgCUummTCI1HuafqxpkXP/79/cFpWea4okMbNiUt0kmAuI2JbZE4M/p0e5kW9S+yQLWhV8+l9XLSlDt5nypzlf2N2/kb7hpGMUUWkagFl7TV4TYg9LlTqUIRY9fpnUo+u7r+M7gDaqEemPiXwL3TSR219lTiWt8ja3CwoBsLmLtEPuNmMgkBCeF/Hdhjghr5ex30xNUrVlp5uMQjVjC90EIyW6uiScFglZiXiwaukB7qpeYKRWmtl6wBpgkT4gRWGQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 28 Feb 2026 10:58:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 290650 invoked by uid 111); 28 Feb 2026 10:58:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 28 Feb 2026 05:58:54 -0500
Authentication-Results: peff.net; auth=none
Date: Sat, 28 Feb 2026 05:58:49 -0500
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] parseopt: check for duplicate long names and
 numerical options
Message-ID: <20260228105849.GA3626520@coredump.intra.peff.net>
References: <xmqq5x7jujqb.fsf@gitster.g>
 <7693799a-91a2-480a-ae3e-29f8eed5b55a@web.de>
 <6b674316-9a6e-4f57-b32c-f1824869ba7e@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6b674316-9a6e-4f57-b32c-f1824869ba7e@web.de>

On Sat, Feb 28, 2026 at 10:19:16AM +0100, René Scharfe wrote:

> Perform the slightly expensive string duplicate check only when showing
> the usage to keep the cost of normal invocations low.  t0012-help.sh
> covers it.

Nice, this seems like the perfect compromise to me. We get a runtime
switch that kicks in at the moment we want, and we don't even have to
pollute the world with a new switch or environment variable.

> +static void parse_options_check_harder(const struct option *opts)
> +{
> +	struct strset long_names = STRSET_INIT;
> +	for (; opts->type != OPTION_END; opts++) {
> +		if (opts->long_name) {
> +			if (!strset_add(&long_names, opts->long_name))
> +				optbug(opts, "long name already used");
> +		}
> +	}
> +	BUG_if_bug("invalid 'struct option'");
> +	strset_clear(&long_names);
> +}

I confirmed on my silly pathological case that invoking rev-parse with a
real option shows no slowdown, and we now pay the same 10ms cost to show
"-h".

Your other email made me wonder how the sorted-array solution might
perform (patch below). It shaves off 2ms of those 10. Probably not worth
caring about for "-h" output (which is already spending another 5-10ms
to generate the output, versus a normal parse).

-Peff

-- >8 --
diff --git a/parse-options.c b/parse-options.c
index 0214c106d4..1ea7efd5a3 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -721,17 +721,39 @@ static void parse_options_check(const struct option *opts)
 	BUG_if_bug("invalid 'struct option'");
 }
 
+static int qsort_strcmp(const void *va, const void *vb)
+{
+	const char *a = *(const char **)va;
+	const char *b = *(const char **)vb;
+	return strcmp(a, b);
+}
+
 static void parse_options_check_harder(const struct option *opts)
 {
-	struct strset long_names = STRSET_INIT;
-	for (; opts->type != OPTION_END; opts++) {
-		if (opts->long_name) {
-			if (!strset_add(&long_names, opts->long_name))
-				optbug(opts, "long name already used");
-		}
+	const struct option *p;
+	const char **long_names;
+	size_t i, len;
+
+	len = 0;
+	for (p = opts; p->type != OPTION_END; p++) {
+		if (p->long_name)
+			len++;
 	}
-	BUG_if_bug("invalid 'struct option'");
-	strset_clear(&long_names);
+
+	ALLOC_ARRAY(long_names, len);
+	i = 0;
+	for (p = opts; p->type != OPTION_END; p++) {
+		if (p->long_name)
+			long_names[i++] = p->long_name;
+	}
+
+	QSORT(long_names, len, qsort_strcmp);
+	for (i = 1; i < len; i++) {
+		if (!strcmp(long_names[i], long_names[i-1]))
+			BUG("long name %s used twice", long_names[i]);
+	}
+
+	free(long_names);
 }
 
 static int has_subcommands(const struct option *options)
