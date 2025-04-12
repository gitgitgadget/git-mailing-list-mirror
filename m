Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50A54503B
	for <git@vger.kernel.org>; Sat, 12 Apr 2025 08:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744445849; cv=none; b=e0RLmrGcRUfEbMg45z2NnepNb4T//xeDk8wBEeV5+SCXjJC+zy4jOUKZQTpiQlqDW5sZCJnd/wT2uPoMHerv2iIzDeBXPmy3LU7Z2BUWprHDK3zPCNWPGx7dEX+qQn17Et7ZK8A3F9FrnzQuOc5xHQ7pxd0GQYzemOF8H49vd/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744445849; c=relaxed/simple;
	bh=aIoasfJP2i9c0eFCan64NkANpzvLc5qssp5L+j6mLy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJbIJpsy0FoQu/wvVIh+kdy8PiS9w5fRt/jGn3Zti17EE73kIxnvaFtqACq8Bbrvn1Lfx+FCR+xH7tdjnbZpcoRLnsm48tjfqBMJ5brIBXzFAJKCWUrOGceP/8Sjnp70MJQg40ITFvrWu2RETkmnVrKLq7jePjk+T1CL4V6Bfbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=XXgP0Cgn; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="XXgP0Cgn"
Received: (qmail 12435 invoked by uid 109); 12 Apr 2025 08:17:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=aIoasfJP2i9c0eFCan64NkANpzvLc5qssp5L+j6mLy4=; b=XXgP0Cgnns7RViFS8GSxabk7UPz63QbQiIsu3rj+87L84d9d8tW2qSG9uC014J1RntTsPNl6p3dn/mAkV1oX0+qmQSp21+2UTVz7SKcFYgPZdO/qONAJsE8/kdhOWUGwbQ/L8UpaQlJjaPJBRT8TJwzPCN9T2n9WqD/7jN+k3m54fGLU/mNyiN79IUkmDo0A0iBASKZaWbliacIYurTXYbLKmNHMgba4tET4dVY/W5EwDzhDTapf/IsZkTZNUQQ7AlivjT9qvv57wDIxhDU0Pr8R4qCC6YiXHxh9/OFHkoymjSL5BgiuY92VDWrNrtlwOsncL9ubBxIbmv3rEEBt7A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 12 Apr 2025 08:17:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7943 invoked by uid 111); 12 Apr 2025 08:17:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 12 Apr 2025 04:17:24 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 12 Apr 2025 04:17:24 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 6/9] object-file: split out functions relating to
 index subsystem
Message-ID: <20250412081724.GA109770@coredump.intra.peff.net>
References: <20250411-pks-split-object-file-v2-0-2bea0c9033ae@pks.im>
 <20250411-pks-split-object-file-v2-6-2bea0c9033ae@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250411-pks-split-object-file-v2-6-2bea0c9033ae@pks.im>

On Fri, Apr 11, 2025 at 11:29:55AM +0200, Patrick Steinhardt wrote:

> Split out functions relating to the index subsystem from "object-file.c"
> to help us separate concerns.

I know these functions all start with "index_", and they do take an
index_state variable, but I'm not sure they are really about Git's index
subsystem at all.

The term "index" here is more about "compute the sha1 index of the
content". E.g., the function index_path() goes all the way back to
ec1fcc16af (Show original and resulting blob object info in diff
output., 2005-10-07)!

Back then it did not take an index struct, or even care about having an
index at all. Later, they learned to call convert_to_git() in 6c510bee20
(Lazy man's auto-CRLF, 2007-02-13). And that function may check the
index for .gitattributes files.

It originally just used the global the_index variable for that, but
later commits like 58bf2a4cc7 (sha1-file.c: remove implicit dependency
on the_index, 2018-09-21) passed the istate around the call stack.

So having access to an index struct is mostly incidental to these
functions. Which makes sense looking at the callers: there are many
pure-object operations that would work without an index (or even a repo
in some cases!) like hash-object, git-replace, diff.

  Side note: I'm actually not even sure we would read attributes from
  the index, since we don't set GIT_ATTR_INDEX. So I wondered if we
  could simply pass NULL to convert_to_git() here. But I think these
  days some of the "auto" CRLF modes also have heuristics based on
  what's the content we find in the index for that path. See
  has_crlf_in_index() and its callers.


So it seems to me that these really are more about creating objects than
they are about the index. I don't mind splitting them out, but it seems
like they're equally weird in read-cache.[ch].

-Peff
