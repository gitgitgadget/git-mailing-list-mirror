Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B64F2AE96
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 11:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734693440; cv=none; b=WaoZ0SZNf24x3f3/t4RN8aPlWezIm2X7Rxpwq81PrkNeARboOutrCN81KHqcPhSYU3ZsaSW2XnW6x0hxI0pFnSdf4HfDMju6L7xy//T+Pm6L1Na3+7Nl0Lmv/xVLUg9PO8dxm9lQQHkpwaVvDQmv1naNe81kzGPZGHLYzq+WQNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734693440; c=relaxed/simple;
	bh=AAkAWU8CwBrB9eFQXiraXVXWgImrcIRfBtsGg2YI7E4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hG7L7rLDWv5bEtYCYfvU2ZGEF9h8Xr7vDRoEiYU14fcVUL06nIHi2yiVQEv6GQMlhU2o81fVi8yQT8vUjVGKpUihv0phUOjPXnwtNb8UNiO6YaIyOYKsuQJTOvdWZLfLDl1Cci0ENqCJ0fFpSb7afHWp6r9ZzdWY+uv3HZEWvV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=E98bClaQ; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="E98bClaQ"
Received: (qmail 10136 invoked by uid 109); 20 Dec 2024 11:17:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=AAkAWU8CwBrB9eFQXiraXVXWgImrcIRfBtsGg2YI7E4=; b=E98bClaQmrSD0OFtTGIckqlPntXEHiF5OKJpKPpLV/YKrYgzU9aO9MQCbqFemTLpu3JElDhzQMxuY/BR6jRGmchqBPOGMXHcjQicwNJhmuSmdXdfHKQiyhpjfw46HMJcTtAAsZPCLUnFy7WreSlrJMa6jl5nTMwWPdI5/pEkAmhLYYHIbn1yJQGDr9lP5hi9XhMz4ND6s6hiiBJ5QA1ZVzFDrgfmquVk14bKlr4Qmo3imuYu6RsU+hg9LC/DfYsy1x6YDaDVmcBb+IBfzCFfcnYakWZSBmBFym0M5ID0hGowiPM1lufeioyDek9117QSJFNShq1WcTXblCQnfEh/rg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 20 Dec 2024 11:17:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15543 invoked by uid 111); 20 Dec 2024 11:17:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 20 Dec 2024 06:17:16 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 20 Dec 2024 06:17:16 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>
Subject: Re: [PATCH 1/2] GIT-VERSION-GEN: fix overriding version via
 environment
Message-ID: <20241220111716.GA140368@coredump.intra.peff.net>
References: <20241219-b4-pks-git-version-via-environment-v1-0-9393af058240@pks.im>
 <20241219-b4-pks-git-version-via-environment-v1-1-9393af058240@pks.im>
 <20241220073437.GA2389154@coredump.intra.peff.net>
 <Z2UlpaDFjvl--zau@pks.im>
 <20241220085626.GB133148@coredump.intra.peff.net>
 <Z2U5cslf10hs_-Az@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z2U5cslf10hs_-Az@pks.im>

On Fri, Dec 20, 2024 at 10:31:30AM +0100, Patrick Steinhardt wrote:

> > > I guess. It'll become quite painful to do this at every callsite, so
> > > I'll add another commit on top to introduce a call template that does
> > > all of this for us.
> > 
> > Is there any reason not to just do:
> > 
> >   export GIT_VERSION
> >   export GIT_DATE
> >   export GIT_BUILT_FROM_COMMIT
> >   export GIT_USER_AGENT
> > 
> > in shared.mak? Then you only have to do it once, and no need for
> > templates.
> 
> You could do that, yeah, but the user needs to be aware that they can.
> I'm happy to not go down that path and live with the above solution.
> Alternatively, this would be what the call template would look like.

I meant that _we_ would mark those variables for export ourselves (in
shared.mak, which is used by all of our Makefiles, not the user's
config.mak).

I.e., this:

diff --git a/shared.mak b/shared.mak
index 29bebd30d8..4aa7dbf5e0 100644
--- a/shared.mak
+++ b/shared.mak
@@ -116,3 +116,5 @@ endef
 define libpath_template
 -L$(1) $(if $(filter-out -L,$(CC_LD_DYNPATH)),$(CC_LD_DYNPATH)$(1))
 endef
+
+export GIT_VERSION

which makes:

  echo 'GIT_VERSION = foo' >config.mak
  make

behave as it used to (when coupled with the fix you already sent to
respect the variable within the version-gen script).

-Peff
