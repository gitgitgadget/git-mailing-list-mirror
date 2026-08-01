Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA4A38DC5D
	for <git@vger.kernel.org>; Sat,  1 Aug 2026 14:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785595531; cv=none; b=Ka6sOvtPM5iuyqrVpxsAhFFFG7CFJu1T+CfP5j44cHDesWTqseBM6J5XktUKr8lGfScOq+eD6xUrCAphtaxtW8szi+FCidYbq9WDvjb10IbXYRmmMGLQ3RciKqrrBC323sCeOwpotfaRXDqs57TSR2ZRnOqkoOxOjoAPRYH2yj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785595531; c=relaxed/simple;
	bh=xAMOCvmR1+sAHoFN0CF+aGMNyDIDbcj9x+oblc53/qQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KSoIapo1A6ripLH7JLO0l/3vBVubU/bRl5uuRwfRZFFojuLEqdXKB7WWwnBEkY2QsDqPdhosGnrPzd+R7b6l+obbt8fW2dDZJky/GrQXhZYr2iu8CRr1jh1m4lfMfzEpvPERge6WiuOqo5+5d74hWfl0h6+EEN4qymdOlN9h5mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=gkV/CGZf; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="gkV/CGZf"
Received: (qmail 9941 invoked by uid 106); 1 Aug 2026 14:45:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=xAMOCvmR1+sAHoFN0CF+aGMNyDIDbcj9x+oblc53/qQ=; b=gkV/CGZfI7r7VTwAiYERRgONlMI98uEOoqMXIUV6y9cfcLHTW//dsr87O3rPmcnhVMFNc9KqnOHvNqzOyiOgXziB8Q4EFImRwMlDDEPCYv3J2NUXtEGoMNV5XawpM9agbq2KFQilUa3d3JkcIHe0IeX7IhNgcbVMJIP9N6c+GE9IiUvh9TIsuJlbFESEH5XZd40CQj8J4hKX5c/ksDaad6X0+CxwIxBzm/IyNK3WfVBCRChCJucxnh3ENnmpgREfGWwbvDFxJbZ/PZW4Rz8oFyzc6uO9Cn/8l7CCzrExt8EJcAbl7zPWau3YIgUjzv3PTnqubuyG3BotqVmnRluRTA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 01 Aug 2026 14:45:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17780 invoked by uid 111); 1 Aug 2026 14:45:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 01 Aug 2026 10:45:27 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 1 Aug 2026 10:45:27 -0400
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH 0/6] Git 3.0: restrict hex object IDs to lowercase
 only
Message-ID: <20260801144527.GF2041176@coredump.intra.peff.net>
References: <20260729233215.398654-1-sandals@crustytoothpaste.net>
 <xmqqjyqclwf9.fsf@gitster.g>
 <amu_rzanuYc_2lww@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <amu_rzanuYc_2lww@fruit.crustytoothpaste.net>

On Thu, Jul 30, 2026 at 09:18:40PM +0000, brian m. carlson wrote:

> The situation is presently that Git will accept them and this leads to
> surprising behaviour, but almost all adjacent software rejects or
> mishandles them.  I'm arguing that we should stop accepting hex object
> ID formats that cannot be effectively used in the Git ecosystem but
> whose presence is effectively only ever the source of misbehaviour and
> security vulnerabilities.

Another interesting case is upper-case hex within objects:

  $ git rev-parse HEAD
  b85b9595a8136c79551340c3d73443a62eddd893

  $ git cat-file commit HEAD |
    perl -lpe '
        if (/^parent (.*)/) {
		$_ = "parent " . uc($1);
	}
    ' |
    git hash-object -w -t commit --stdin
  5a08c6b3f06d91c4a09c8d7ea6e9c8ce200b7698

Now there's a parallel history of otherwise identical commits. I think
this is mostly "if it hurts don't do it", but we generally try to avoid
multiple representations of the same data within the object model.

I think only commits and tags are subject to this (because the tree
hashes are binary). I don't know if you'd be able to stumble into this
accidentally with most Git commands. We don't intentionally normalize
case anywhere, but I think most code will round-trip through a binary
hash at some point (so "git commit-tree 1234ABCD" would incidentally
normalize the case).

-Peff
