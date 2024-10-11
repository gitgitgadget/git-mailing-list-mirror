Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6B81C5796
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 19:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728673710; cv=none; b=HQ96Pnqa2n2qylfQk0mKyEb24ebYyrGj+pjnkHedGTJoSym2xFEkgoQYEKi7oWJuaICTBWBoXnbGiVTjXtFRgXWCm5g35Y4DiKxgU3r4zUFyGCEd4b0tLA7mCktPYgg5Ta/ZQxtFCIxe6bO6fcrnGzGS7oJMPHsTjIn6QArOOVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728673710; c=relaxed/simple;
	bh=BPXdi1tNDR6b8bIfNHNZUUFjojXXHOjnSxMHEvxEY4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LXWCjodJjIWSOGVsLzXa90LcIyrpIk+ku8hAIN2gHnmKsXadyoj0alyp/rvBdrGphtfyjpedPIfpxSukj0WUWVzq6MFd7ct8wercme6ldwn+vliQWOeUqR6UypejnrtnjTEL11+ezIL0nAdcW7H6i/Na0r1NutbVse7ipeEJ0OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=GurWtTxf; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="GurWtTxf"
Received: from localhost (CSAIL-SQUARED.MIT.EDU [18.9.64.19])
	(authenticated bits=0)
        (User authenticated as asedeno@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 49BJ8CjV024828;
	Fri, 11 Oct 2024 15:08:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1728673695; bh=iMKNBSQYzXaoxytEBK/0lFPzZ0Y0fuJEDgnbDQcVX5Y=;
	h=From:Subject:Date:Message-ID:MIME-Version;
	b=GurWtTxfA8CObTiSE+Vd9fKVu3869C92vXxZb0/grOtAdDY2IVn7FKFQqhgzTvqoj
	 7UAT2qDpToCL3yxe3C8MA79lSsTN7hBT4g/kP1EePmKbQ6LsVmj/3nrp3ZhtvFkXJP
	 a9TO5uYU5tuVhHWyeeO36VtxrQLPPbSx8yj+wJCAWt4bdVaJaruhAJZRPPwSQZc0cj
	 UbRYvqMHvkPyY4o+rYHLmSKOqgRKK+KzBswfOFGnTRASFF49Jt9p0wnKa1/A6wlQcx
	 445DOjOrcl7YLXYYKcRBfv/o3zRLW30S+E2tPNR9S+3+3vHVDFj3MZ0zLI0v8pddFb
	 b+IGVDAwTGUZA==
From: =?UTF-8?q?Alejandro=20R=2E=20Sede=C3=B1o?= <asedeno@mit.edu>
To: gitster@pobox.com
Cc: asedeno@mit.edu, git@vger.kernel.org, peff@peff.net,
        sandals@crustytoothpaste.net, sunshine@sunshineco.com, ps@pks.im
Subject: Re: [PATCH 00/13] Update versions of libcurl and Perl
Date: Fri, 11 Oct 2024 15:08:12 -0400
Message-ID: <20241011190812.2654837-1-asedeno@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <xmqqttdicws8.fsf@gitster.g>
References: <xmqqttdicws8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
> > I may be in the minority here, but I'm fairly negative on this entire
> > patch series. As you say, supporting these old versions is effectively
> > zero-cost, so how does this project benefit from these changes which
> > potentially "break" Git for users on older platforms? I see no upside
> > here. The cover letter provides no strong justification for
> > (potentially) inconveniencing people; the argument about being able to
> > utilize more modern Perl features is weak[1] at best and is not
> > convincing.
>
> While I agree with all you said above, one thing I find missing is
> that even with #ifdef, we won't be shipping what we tested in real,
> as nobody, not just the author that touches the same file with the
> #ifdef we added 6 months ago is in, but all other developers who
> looked at the change.  It merely is "we have #ifdef here and those
> with ancient version of the library shouldn't see this new code",
> which certainly is good enough for those of us who consider the
> ancient platform support as a "best effort" thing.

Should I go ahead and send the patch series that I had planned to fix
the breakage for old libcurl after all? I've gone ahead and built the
latest version for one of the ancient platforms I inexplicably build
git for, but am now dealing with breakage on another (SunOS 5.10).

(Specifically, the new unit test framework stuff was failing to
generate a suite file, patch forthcoming, and depends on mkdtemp,
which we check for in configure but use unconditionally in the
newly-imported clar, and which I don't have here.)

-Alejandro
