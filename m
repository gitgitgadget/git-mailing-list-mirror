Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C502236FD
	for <git@vger.kernel.org>; Sun,  5 Apr 2026 19:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775416674; cv=none; b=kT20qvrevJ9VuJr6xGbsyGz4eds6sCs2mVozq5QQFWvmaw/49nbJaReIovHGyg82sBbHTZL8rIetykyZ5+OObL7/UHq6SBLkfoW8CUNzhjzoZdiqiCucV0UHh72wpeG4iIWeS5m9IpWnA4mWjg1lw9eBW028iZdHiiHuisGByBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775416674; c=relaxed/simple;
	bh=3CrXAhvJzrkzR0tK6vYw6TVPkVifFI4aui8GXZVJhRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B76JoJT/diawpaRsrhNr+nzSibOoPE1inTO5uaNPjS6N9VtSiEQlEJmEPYnjwqI/jbVXRFBbmLlzHwNqxB1IPzSTwnOha1J1dO9npTmaC1Z1CtT2qDScKKEt6wA0XcKIr69eWW0IgBHWmDHR93uYgKg6eLeZGLpN74D6TPxNok0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=QKBTJAQn; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="QKBTJAQn"
Received: (qmail 256648 invoked by uid 106); 5 Apr 2026 19:17:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=3CrXAhvJzrkzR0tK6vYw6TVPkVifFI4aui8GXZVJhRQ=; b=QKBTJAQnqrSo5x5u6h8k12WIhvRmu4CcjVdI9gx550FwUMIe9f8DZz75hvnhy5KauUltWgpGp6l37Z0T9AHp/gSkxd6iBbVl04bKOTHa9IuEfFx2TfGWx7Yu/3pPllvQBhBfnoEsV8eN60XzTQeYZ+Jm1KTMWbGCciektdkh+19MVqJRhOr5MNZIxhDCqXxq5CbY/xacvANLdv9EFVZyZW+JzCZOwaBQ+IXAjT3AJ8UB83ZbEv1rlv83PLzuiSMsvqd1vrrhau1MVIvqBLUUVeMI0y5T/YEtVF8/8J1A0Pygh6mYEuh8pI1XDMO5LXo1NbUWWZc0JBLG+/w2IK4Obg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 05 Apr 2026 19:17:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 413238 invoked by uid 111); 5 Apr 2026 19:17:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 05 Apr 2026 15:17:51 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 5 Apr 2026 15:17:50 -0400
From: Jeff King <peff@peff.net>
To: Luca Stefani <luca.stefani.ge1@gmail.com>
Cc: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org, cat@malon.dev
Subject: Re: [PATCH] object-file: don't use object database without a
 repository
Message-ID: <20260405191750.GA1525850@coredump.intra.peff.net>
References: <20260404172817.2995133-1-luca.stefani.ge1@gmail.com>
 <20260405064651.GA1452907@coredump.intra.peff.net>
 <145b6c7f-c037-4a87-b561-d2b4d8c5a0cd@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <145b6c7f-c037-4a87-b561-d2b4d8c5a0cd@gmail.com>

On Sun, Apr 05, 2026 at 06:10:33PM +0200, Luca Stefani wrote:

> > > Enforce the use of index_core() in this case.
> > I don't think we want to use index_core() for a large file, though. A
> > test like this:
> 
> I don't know what would be the right approach, index_core sure is slow, but
> maybe that's expected for those sizes.

It's always going to be slow because we're hashing a lot of data. But
the point is that we should be streaming it, and trying to allocate a
huge buffer (even via mmap). So it's not that it's slow, it's that some
cases which used to work will not do so any longer.

We want to keep going into the streaming code path, and not
index_core(). But the streaming code path has been broken outside of a
repo, by ce1661f9da (odb: add transaction interface, 2025-09-16) and its
follow-on patches. And we should fix that instead of avoiding it.

> This fix by itself simply avoids entering into the broken case, and it
> still gives me a working diff.

For some files, yes, but it breaks other cases (like the one I
demonstrated).

> > diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
> > index 15076dfe0d..7ef5604430 100755
> > --- a/t/t4053-diff-no-index.sh
> > +++ b/t/t4053-diff-no-index.sh
> > @@ -413,4 +413,10 @@ test_expect_success 'diff --no-index with pathspec glob and exclude' '
> >   	test_cmp expect actual
> >   '
> > +test_expect_success 'diff --no-index on a huge file' '
> > +	dd if=/dev/zero bs=1M count=4000 >big.file &&
> > +	echo whatever >small.file &&
> > +	test_expect_code 1 git diff --no-index big.file small.file
> > +'
> > +
> >   test_done
> 
> If you want  I can send a V2 with that, but given it's your test suit I'd
> rather you handle it.

If you sent a v2 with this, the tests would not pass. ;)

But like I said, I don't think we want that in the test suite because it
is too expensive to run. What we probably do want is a cheap
demonstration of the segfault, which is this:

diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index c824c1a25c..31965908a6 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -149,4 +149,9 @@ test_expect_success 'fmt-merge-msg does not crash with -h' '
 	test_grep "[Uu]sage: git fmt-merge-msg " usage
 '
 
+test_expect_success 'indexing large file outside repo' '
+	nongit dd if=/dev/zero of=big.file bs=10k count=1 &&
+	nongit git -c core.bigfilethreshold=5k hash-object big.file
+'
+
 test_done

But I think the actual code change in your patch is the wrong thing, so
I also don't think we'd want to just squash that test in. I'm hoping
Justin has some insights on how to do a more complete fix.

-Peff
