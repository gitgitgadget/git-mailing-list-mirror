Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7C1303CAB
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 22:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776207130; cv=none; b=NzV7zvbNARsNU5aTLJvvyU2maTMZwI9RFgjT1n7TBQ/cIFVCoXnU+WjEsfyfaXzybY3mHTnTNS3V0CPFBFQ4TIQfQOypPPbCh4J8KwsVJVniPTbEO6Gno8AVxx0mG403/Hk0IkvYiuhe4ZLohqeQ2l1ltHvY0PC6k/wAT7qJTFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776207130; c=relaxed/simple;
	bh=IEubRKIgk5PpwHGFw7YPY8NTfpLiS6uq4N/MIWjEcuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kYfOLdG1e6AGHe+csA3zlf9RiP2LlQhO4J2Vyb2sHaW/hszm9Ms3YsaNdwo5Ap2AkHRVqpTO8uXPGFFGp0G3Pu4d/3KlKW7bolXX++zSNFHf4Yg6OhE0GoFojELAap0AvwHeYHRnLFiqLqJmQzBb0RL5CwJKNu8S8GhmNRxXNfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=TxGn/c//; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="TxGn/c//"
Received: (qmail 350958 invoked by uid 106); 14 Apr 2026 22:52:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=IEubRKIgk5PpwHGFw7YPY8NTfpLiS6uq4N/MIWjEcuA=; b=TxGn/c//jGfSXlvJdvHiljsKw672JLRyq5NuN4nLuSCdJQa3SWntJJV1B3OhOcIF13oCdazE77/mATarc5OVtf/tgaGlrL8lZd/h15kOhDXQJcCtfkrRfgLRTGlYGoKhLQ+PqsiULcoJhlNtGPPPPCllTvu8AqSyzeeS54yUeRiMixIliqbfy6IAZnpkLsLjiDPpTQ4nM23BGC755uE9CXifzO6HYG+uUKx2Qnk/tlA2oOHDkuXxnEVA/GkFb05WW+ZsWDBDmDXEeY775RQ34cg8hTmJMECtw9+HjMgSiVR3Jj1gUoYrFEG+/1OaFWaCKdpZFYll9+Y9WEcxqOgAyw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Apr 2026 22:52:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 587508 invoked by uid 111); 14 Apr 2026 22:52:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Apr 2026 18:52:07 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 14 Apr 2026 18:52:06 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 06/12] t: prepare execution of potentially failing
 commands for `set -e`
Message-ID: <20260414225206.GA3486072@coredump.intra.peff.net>
References: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
 <20260413-b4-pks-tests-with-set-e-v1-6-5b83763a0e84@pks.im>
 <xmqqeckifq59.fsf@gitster.g>
 <xmqq340yfivf.fsf@gitster.g>
 <ad3rgbgadjIZRgaz@pks.im>
 <20260414220347.GA3475127@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260414220347.GA3475127@coredump.intra.peff.net>

On Tue, Apr 14, 2026 at 06:03:47PM -0400, Jeff King wrote:

> > -perl -MHTTP::Date -e 0 >/dev/null 2>&1 && test_set_prereq DATE_PARSER
> > -perl -MTime::ParseDate -e 0 >/dev/null 2>&1 && test_set_prereq DATE_PARSER
> > +test_lazy_prereq DATE_PARSER '
> > +	perl -MHTTP::Date -e 0 ||
> > +	perl -MTime::ParseDate -e 0
> > +'
> 
> Maybe I am being dense, but I don't see how the original would have
> problems with "set -e". The perl command is on the left-hand side of an
> &&, so "set -e" will be suppressed.

Joy of joys, it looks like a bash bug. Using "command" re-enables "set
-e", even on the left-hand side of an &&.

With bash 5.3.9 on my Debian system:

  $ bash -ec 'command false && echo one; echo two'
  two

On bash 3.2.57, tmate'd into the GitHub Actions macOS image:

  $ bash -ec 'command false && echo one; echo two'
  [no output, we exited after command failed]

It triggers in this case because perl in our test suite is a shell
function which runs "command $PERL_PATH".

But I don't think switching to an if/then conditional helps. Doing:

  bash -ec 'if command false; then echo one; fi; echo two'

likewise exits early (but prints "two" on modern versions).

Sadly I do not think we'll see a fixed version anytime soon. Apple is
sticking with ancient bash because of licensing, IIRC. I don't know if
they're backporting any fixes (and even if they wanted to, there are
probably license complications).

Short of requiring a third-party shell, the only workaround I can think
of is to manually "set +e" before using "command", and then restore it
with "set -e". Gross.

-Peff
