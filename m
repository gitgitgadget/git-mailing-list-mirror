Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610585477E
	for <git@vger.kernel.org>; Fri, 22 May 2026 04:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779425042; cv=none; b=I+/RKWm+77noXyFBn9+OE+3+LLvPgUO8hj6iETbEp/tWxbf+s+W846ScoiiNDTTGIBVNyV4oucHgYPhO0lhsQZFS8WrDcwKUNJuGHjNrRxbzKmhU/fimw2Ki+SKDTFMWg3PPKNb87BNd4hQBnVdIWu5BAs38xi6CPxvv9NVFdwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779425042; c=relaxed/simple;
	bh=XCzEoNcn/qg5jeHChglGt60sYPY29FjESIm0ULvVPik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RhZUfuA5MhizpaITkrgAe/gn0bITuzeC+oChbSJyyMCn3a5aHUdsbBc4iNzW4ustxjfTCT6rxXvsOhIAI+XHtbd2XmEV2foLBErjmDYhxgurYHycKNSg7EAkT1MgnAqwliSPwD5zHrR6LA2x0W2quswtquyNLurnVSCeiIBdbpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=NdhllGm7; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="NdhllGm7"
Received: (qmail 46948 invoked by uid 106); 22 May 2026 04:43:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=XCzEoNcn/qg5jeHChglGt60sYPY29FjESIm0ULvVPik=; b=NdhllGm7Ai6MyIAKalX1dLOR+wJ813d0XxbuCAVelIfPEaAx4YNm5bnzaoM++CwyRtYmzz00vBBXejVL/H2/cNbPk7fk3hbyuldzu9l3A7sl3sESwDC0diqYMIrCthSTHfaubMj6UT1VbIwucUDce4IFmOyeQ15uBVPOrqJdz+s3iC6M6K1beEBaqQWBvS9oxPu5Wr2WNhHql9fKc531R7FVED0eLQLr0hxfMp1NLTywqalEBNzhUnvY8vLEYaFKc0CtXHMqhOnbhC05Yx2rPXo3jaaOOyNi6cCkcMgompbf89GRKXJ96N6XKjJKGjuRFHy8j4aclImUPUfcBoi25Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 22 May 2026 04:43:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 98709 invoked by uid 111); 22 May 2026 04:43:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 22 May 2026 00:43:56 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 22 May 2026 00:43:52 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] connect: use "service" enum for "name" argument
Message-ID: <20260522044352.GA861761@coredump.intra.peff.net>
References: <20260519052219.GA1703179@coredump.intra.peff.net>
 <ag7AJMbav6KgSCjj@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ag7AJMbav6KgSCjj@pks.im>

On Thu, May 21, 2026 at 10:19:48AM +0200, Patrick Steinhardt wrote:

> > +	switch (service) {
> > +	case GIT_CONNECT_UPLOAD_PACK:
> > +		return "git-upload-pack";
> > +	case GIT_CONNECT_RECEIVE_PACK:
> > +		return "git-receive-pack";
> > +	case GIT_CONNECT_UPLOAD_ARCHIVE:
> > +		return "git-upload-archive";
> > +	}
> > +	BUG("unknown git_connect_type: %d", service);
> > +}
> 
> Shouldn't this say "unknown git_connect_service" instead of "_type"?

Oops, yes. As you probably guessed, I started with "type" before
realizing that "service" was a better word.

The patch is in next, so the fixup on top (of jk/connect-service-enum)
is below.

-- >8 --
Subject: [PATCH] transport-helper: fix typo in BUG() message

We mistakenly refer to the git_connect_service enum as "_type" rather
than "_service". Users should never see this message in practice, but it
is slightly confusing when reading the code.

Reported-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Jeff King <peff@peff.net>
---
 transport-helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/transport-helper.c b/transport-helper.c
index bf37c5280c..b672801ae4 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -630,7 +630,7 @@ static const char *connect_service_cmd(enum git_connect_service service)
 	case GIT_CONNECT_UPLOAD_ARCHIVE:
 		return "git-upload-archive";
 	}
-	BUG("unknown git_connect_type: %d", service);
+	BUG("unknown git_connect_service: %d", service);
 }
 
 static int process_connect_service(struct transport *transport,
-- 
2.54.0.618.gdbb63b8024

