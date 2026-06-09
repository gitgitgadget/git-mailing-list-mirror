Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B381EB5FD
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 00:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780965823; cv=none; b=lUnltt/5/ztiG21hnv+fwhV4iaOxH6Q+BHymrBf46K/bceMS+C2YV9fkaj6/iGGND+pGvE4FXK+dwUlkkk5wH3fNsTq1C7S99f7Y6gRovNcOemqzEQ+93HdL4imAVpEObR731u+zlFlJVzKkWF12MafXUn5FDN8yrwlfnfgtu8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780965823; c=relaxed/simple;
	bh=Kg5s/rakPZgfAbgPEbCb9TvMlTrtCJ3DLN4huXaIMso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X902gJh2XHA6ql4E7DO1tKxK8Rpboq70WY0XLaZGLpssbv6ENnJflYhBuiVC/FzIpHkOH7NCEYU0RmeqfQjslNOgic6nvGPKScoa9fuzgGcBsG3QebZovfLTehNzRcsHwFpxPZ5xic5bea+F5wmC+bLbO3IY9ri7hbHqtEWFpxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=VKpgPLui; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="VKpgPLui"
Received: (qmail 84219 invoked by uid 106); 9 Jun 2026 00:43:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Kg5s/rakPZgfAbgPEbCb9TvMlTrtCJ3DLN4huXaIMso=; b=VKpgPLuiIFzePTGaed9sx9CCdKSpiDhdHcQ/iBxPmoRWPe3w1yJ3r6B0uSOLheql/amyCnqNE+dS6rqO+eoXMr7kPfK2XqZj4nGUF7wXXv+vqMKEi9CfTzBpZPy0CT4w6ma7YT2VrzN+BC8v9jWwTaVJdfsZCJrDBZeEhvSFxQmW7LHJrI4mOOmQq/j/ESZCg6WqPIjbxuXoqriMq54rChjqi7TNzmN/4ANLJEI/9iR96anFMPoSdYQa+qQoWo8ajCrRdSN3IwNRq+mbVl14Mlo6CHQP/6n7QbFA7lKK6UKkAt0ET4hgdgN1DttbSn8M/sUl0OKhgu+8AZI4oLN2Qw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 09 Jun 2026 00:43:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 246936 invoked by uid 111); 9 Jun 2026 00:43:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 08 Jun 2026 20:43:44 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 8 Jun 2026 20:43:40 -0400
From: Jeff King <peff@peff.net>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: trailers: --only-trailers normalizes URLs to trailers
Message-ID: <20260609004340.GF358144@coredump.intra.peff.net>
References: <ae4a32e7-bacb-4c88-b2a0-5aeaff60b904@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ae4a32e7-bacb-4c88-b2a0-5aeaff60b904@app.fastmail.com>

On Thu, Jun 04, 2026 at 11:27:51PM +0200, Kristoffer Haugsbakk wrote:

> The following is a bug that follows straightforwardly from the documented
> or discussed behavior. In that sense it is not a bug. But it is a bug in
> the sense that it makes things inconvenient and violates a design goal.

Yeah, though if you'll allow me to nitpick your subject a moment: I
don't think --only-trailers is really the culprit here. It demonstrates
the problem because it normalizes the "trailer" it found. But the loose
trailer matching is the more fundamental issue. For example:

git interpret-trailers --trailer=foo=bar <<\EOF
subject

body

http://example.com
EOF

will stick the new "foo: bar" trailer right up against the (now-broken)
"http:" trailer. When it should come in its own stanza, which it would
if you added a line "other" at the end, since that tells us that "http:"
can't be a trailer.

> > What's different between what you expected and what actually happened?
> 
> In an ideal world to have some special-casing of URLs so that they are
> not detected as trailers. Does anyone realistically want trailers like
> this?:
> 
>     file: //...
>     http: //...
>     https: //...

I could even see those as trailers, if somebody really wanted to allow
arbitrary values that might just happen to start with "//". But without
the whitespace after the colon, it is quite questionable.

> Just special-casing `https` would go a long way.

Agreed, though I think a rule like: ":// (with no whitespace)" is not a
valid separator. Something like this:

diff --git a/trailer.c b/trailer.c
index 6d8ec7fa8d..342ed81c78 100644
--- a/trailer.c
+++ b/trailer.c
@@ -635,8 +635,12 @@ static ssize_t find_separator(const char *line, const char *separators)
 	int whitespace_found = 0;
 	const char *c;
 	for (c = line; *c; c++) {
-		if (strchr(separators, *c))
+		if (strchr(separators, *c)) {
+			/* special case to avoid accidental URL matches */
+			if (*c == ':' && c[1] == '/' && c[2] == '/')
+				return -1;
 			return c - line;
+		}
 		if (!whitespace_found && (isalnum(*c) || *c == '-'))
 			continue;
 		if (c != line && (*c == ' ' || *c == '\t')) {

-Peff
