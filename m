Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D036733BBC0
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 04:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773806668; cv=none; b=CPcik1c1GK59eqv2fxUUuccclE0ToD9SsC1kqRm6JssEbgss4GEGXBjQDZeVnMhL9PG4wqmWfnV0hGZYjaSnWdOeGLnu6yblAfXtDZF8aocUUSeactu0P1N9ycU9mp7mguGZIcnMW0I+xkUSD/UaKJ7n1t6iIG17mQ6yLHXTntg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773806668; c=relaxed/simple;
	bh=csEV0xBqTRU1lOFJVsyNeVjCd+4bUx6S8Aj700KHn9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfC38SyZIjcxjE5qDj1hlAnEWcGWcNWKJFEJ5j5hnpO6gzWuv7iyVYOc3LhUpBLeaMUoZ5SUUMndKbe+9j3Fv4SrjIZusXP2zuRrmrkeW5Fi0CPJQYUM3daU61WYmQZu7uJi77WHALKcDMxnkHFcWJi4hEKFIsFe1vCg+XyHzfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=CITjs5l5; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="CITjs5l5"
Received: (qmail 37635 invoked by uid 106); 18 Mar 2026 04:04:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=csEV0xBqTRU1lOFJVsyNeVjCd+4bUx6S8Aj700KHn9M=; b=CITjs5l5hhdR10S8fe+r9HfCKiMOUwI0NDenrZYAZrInbvyJr68h86hA3dFKUTxOl3Sb6OI0umMmBoSd0R0LfVH4xiegNr7O0q2OS3MfO1uemzUa4BI41yd1OGS3VHsf3JojX9vhd3bz9dAxAq8dbgTsqKnJY9l7TKzvuIko9PyYxoX5PKl+0us1c1hNxX0kFF2xQLCx/o5ZFHkMVqxVhesplH9ooGRYEpUlzqIP0o96xXAp+RZKQX4EVfAuCakNtuXG+GF+nz+iF5m2OykGKeLv4kKjLCTANU8diZ6704r7oGwtirVbxJIPjO5cqgt9KX0id/jW2uc6pdGy0jb0Dg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 18 Mar 2026 04:04:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 56310 invoked by uid 111); 18 Mar 2026 04:04:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 18 Mar 2026 00:04:24 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 18 Mar 2026 00:04:23 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
	Andrew Au <cshung@gmail.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2026, #06)
Message-ID: <20260318040423.GA2858991@coredump.intra.peff.net>
References: <xmqqh5qfmhdd.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh5qfmhdd.fsf@gitster.g>

On Mon, Mar 16, 2026 at 05:25:50PM -0700, Junio C Hamano wrote:

> * aa/reap-transport-child-processes (2026-03-12) 1 commit
>  - transport-helper, connect: use clean_on_exit to reap children on abnormal exit
> 
>  A few code paths that spawned child processes for network
>  connection weren't wait(2)ing for their children and letting "init"
>  reap them instead; they have been tightened.
> 
>  Will merge to 'next'?
>  source: <20260312214945.4050010-1-cshung@gmail.com>

I think this is responsible for CI failures on Windows in t0061.24. That
test does this:

  test_expect_success MINGW 'can spawn .bat with argv[0] containing spaces' '
          bat="$TRASH_DIRECTORY/bat with spaces in name.bat" &&
  
          # Every .bat invocation will log its arguments to file "out"
          rm -f out &&
          echo "echo %* >>out" >"$bat" &&
  
          # Ask git to invoke .bat; clone will fail due to fake SSH helper
          test_must_fail env GIT_SSH="$bat" git clone myhost:src ssh-clone &&
  
          # Spawning .bat can fail if there are two quoted cmd.exe arguments.
          # .bat itself is first (due to spaces in name), so just one more is
          # needed to verify. GIT_SSH will invoke .bat multiple times:
          # 1) -G myhost
          # 2) myhost "git-upload-pack src"
          # First invocation will always succeed. Test the second one.
          grep "git-upload-pack" out
  '

But after applying the patch from this topic, the second invocation of
the bat file never writes its arguments to the "out" file. I can guess
what is happening is:

  1. .bat files seem to write the commands they are running to stdout
     (it has been decade or three since I wrote a .bat file, but I think
     that is just a DOS-ism, and it happens both before and after this
     topic).

  2. Git sees garbage from ssh (really the .bat file) and complains with
     "bad line length character". This also happens before the patch.

  3. Now here's where we diverge. With this topic, Git will then kill()
     the child process and wait to reap it. Presumably this is racy with
     the .bat file running the actual "echo" command, and as a result,
     we never see anything hit the "out" file.

So I think we could perhaps just call the test badly written. It _could_
use a more realistic fake-ssh setup that would actually complete the
clone. But I'm not sure how, since the .bat file insists on dumping crap
to stdout. Commit 71f4960b91 (t0061: fix test for argv[0] with spaces
(MINGW only), 2019-10-01) seems to imply this came from a real-world
case, so maybe there is some way to make .bat files work better.

It could perhaps use some other mechanism that runs a command, like
ext-diff. Or even "test-tool run-command run-command $bat".

But it does make me wonder if there might be real-world cases that would
be unhappy to have the sub-process killed immediately (assuming it was
going to exit on its own after doing some cleanup, flushing buffers,
etc).

-Peff
