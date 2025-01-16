Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431FF153598
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 21:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737064481; cv=none; b=k0Es3G3sbW7nHVkNsibQKhpqpBwBjaPW1x9EQmHY2GL/h/huJRo+4CQU1mIa4+xcoC8uIgq0iNMfXQlAusoyQdtyliiofxIVBVrrJvi8fL7ZThXxxaRFOxmw68bf5iJCvPfSdHeSulV1dnl1xqi2d1pTYVo3hkWupUYBDTeAGXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737064481; c=relaxed/simple;
	bh=osBLByBYZD0D6OHje03HVBfPdUGMKn8W/wmWavb9F/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AbIKfszwziQuLJG113dF0gOr2KZ9ZR78EkIHXD+csUXyBNOMApxOv2MWerEpOw1q71j/Tzo8B25b6W9gQUAVjhr8BVVqHXg/B9r7DCZaP/0+xou/n7XKMbaeYFLseMxMdhIiTl1d0Yt/HPpqwKbvjuFy8WGKpKTJh3GEW5RQmZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=QaSzeOmR; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="QaSzeOmR"
Received: (qmail 16615 invoked by uid 109); 16 Jan 2025 21:54:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=osBLByBYZD0D6OHje03HVBfPdUGMKn8W/wmWavb9F/4=; b=QaSzeOmRlnsGTnE8VDzQw2O8uMWfiOh1euZuIxIrt3/ILDBUGYQjudflNVauaPGIoGmtrGm9eEFDmyksNJdHblgoQXgWaBOFUfbTPR6RnjH4/RsgWiToKXvDN7w/MJsl1nRXf5+iha9+PoPTN50FHWUSSiAQDyp57Dv4pAgBgluV1P4ZO+jSMeBG91is57sCkKi/fc4vrRzNjbVLQUScWqNwLvgFNGoXqgzUrZSVTgOB2SqVTsWzrj24vJjBKogETannOeCL6V6gxP/7kYNP4wi9rQUz3AzDNNH2QiH+EXMBnIdQbKKK/yAnP25KfNhWnS3J7aBcTH1BTx93US3hEA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Jan 2025 21:54:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31643 invoked by uid 111); 16 Jan 2025 21:54:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Jan 2025 16:54:34 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 16 Jan 2025 16:54:31 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 4/6] usage: add show_usage_and_exit_if_asked()
Message-ID: <20250116215431.GA2338133@coredump.intra.peff.net>
References: <20250116012524.1557441-1-gitster@pobox.com>
 <20250116012524.1557441-5-gitster@pobox.com>
 <20250116103620.GB773990@coredump.intra.peff.net>
 <xmqqbjw6u101.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbjw6u101.fsf@gitster.g>

On Thu, Jan 16, 2025 at 09:22:54AM -0800, Junio C Hamano wrote:

> >> -	fflush(stderr);
> >> -	write_in_full(2, msg, p - msg);
> >> +	if (fd == 2)
> >> +		fflush(stderr);
> >> +	write_in_full(fd, msg, p - msg);
> >> +}
> >
> > Gross. :) I think the existing code is conceptually:
> >
> >   write_in_full(fileno(stderr), msg, p - msg);
> >
> > In which case vfreportf() could just take a FILE*, flush it and then
> > write.
> 
> Sure, but these "stderr" are real error reporting that need to stay
> to be stderr, and flush needs to be done only when our true payload
> goes to fd#2 and I do not think these fflush() are about stdio calls
> made by the caller _before_ it called this function.  It may become
> a bit tricky to read the resulting code if we pass "FILE *".

I think the flush _is_ about earlier stdio calls in the process; that's
what 116d1fa6c6 (vreportf(): avoid relying on stdio buffering,
2019-10-30) says. I do think it's unlikely for the process to write to
stdout() before processing "-h", but it seems like we should do the
safer thing as a general principle, unless it ends up hard to do so.

You said "may become a bit tricky" above, but unless I'm missing
something, it's just:

---
 usage.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/usage.c b/usage.c
index d9f323a0bd..533d296e41 100644
--- a/usage.c
+++ b/usage.c
@@ -8,7 +8,7 @@
 #include "gettext.h"
 #include "trace2.h"
 
-static void vfdreportf(int fd, const char *prefix, const char *err, va_list params)
+static void vfreportf(FILE *fh, const char *prefix, const char *err, va_list params)
 {
 	char msg[4096];
 	char *p, *pend = msg + sizeof(msg);
@@ -32,14 +32,13 @@ static void vfdreportf(int fd, const char *prefix, const char *err, va_list para
 	}
 
 	*(p++) = '\n'; /* we no longer need a NUL */
-	if (fd == 2)
-		fflush(stderr);
-	write_in_full(fd, msg, p - msg);
+	fflush(fh);
+	write_in_full(fileno(fh), msg, p - msg);
 }
 
 static void vreportf(const char *prefix, const char *err, va_list params)
 {
-	vfdreportf(2, prefix, err, params);
+	vfreportf(stderr, prefix, err, params);
 }
 
 static NORETURN void usage_builtin(const char *err, va_list params)
@@ -184,7 +183,7 @@ static void show_usage_if_asked_helper(const char *err, ...)
 	va_list params;
 
 	va_start(params, err);
-	vfdreportf(1, _("usage: "), err, params);
+	vfreportf(stdout, _("usage: "), err, params);
 	va_end(params);
 	exit(129);
 }
