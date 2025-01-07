Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FF728691
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 02:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736217549; cv=none; b=cwupSxiWoXJ8EveG3M670WO3eF0yYBQEIXzgNyM/rUMSrSYzvaWhQ8hhsHTEmjQ5SrkM+0+y8seD6dyGNfNwwna96qFCKWrX0/YYxOpOhet2TbHqQpdhHWRXTpjz5XdXaUAAuLLPEewMvFHL+06CP+zvyjYHM+enuivv/d4fmac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736217549; c=relaxed/simple;
	bh=5pgabxvilKyvT/4dF9F/ivmPy0DJhOQjjXTDQMpOajA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kBcfAYD6UaZ+H7LPTbzBsQBHoknvDTJ8+js8I81IBuezgtYiKQ+g1t8g+nsDF059JAzpY/rry/ovl7+VdLXqeKDVIUdRKzJgpM+2qM8+MZDCCdeAkNBPtW8FUD14/wExbLNl9i6LAp2YUfoHX+YbAODDxVwHxIWGe9G0R46fPPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=FCLT/W/z; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="FCLT/W/z"
Received: (qmail 26944 invoked by uid 109); 7 Jan 2025 02:39:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=5pgabxvilKyvT/4dF9F/ivmPy0DJhOQjjXTDQMpOajA=; b=FCLT/W/zbtJKJXDth74weEjWQjfZJ/vaN5MFgbvcMgTVHIRZn1bNP4fM0rQ1n52K2e1j8keZ/gXwpJwOdvpWaeqE+8DxSL2GduSp8niK9geXwEW8gChTe4UmSwyxxZgcOvBZZWMhDeIKLBj4SMdwWWmCuseTEh7fkWWQPhfZUlMAbeHWaNK+ITFWo3/50CUUS6gOVTpKvmz9475GxAdqSi2NJQJeSuVhEdQinWkZBhd+9rDBXKNteBk0QI3pzS8vT+RkBrlb9DlYfq18+rrmTfUn+FhK/tl3PLXPEuZQaxboJdV4fFNM32Nq5kB99lw3KYJt25TC8bS0s9CDlO9wPQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Jan 2025 02:39:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19162 invoked by uid 111); 7 Jan 2025 02:39:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 06 Jan 2025 21:39:04 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 6 Jan 2025 21:39:04 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 02/10] t7422: fix flaky test caused by buffered stdout
Message-ID: <20250107023904.GB2363@coredump.intra.peff.net>
References: <20250103-b4-pks-ci-fixes-v1-0-a9bb95dff833@pks.im>
 <20250103-b4-pks-ci-fixes-v1-2-a9bb95dff833@pks.im>
 <20250103181739.GA2527684@coredump.intra.peff.net>
 <Z3u6lj_bpM7N93Fd@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z3u6lj_bpM7N93Fd@pks.im>

On Mon, Jan 06, 2025 at 12:12:22PM +0100, Patrick Steinhardt wrote:

> > isn't quite right. Even without input buffering on grep's part, it may
> > be too slow to read the data. And adding a sleep as above shows that it
> > still fails with your patch.
> 
> Great. I was hoping to nerd-snipe somebody into helping me out with the
> last sentence in my above paragraph :) Happy to see that you bit.

I think I am a sucker for SIGPIPE races.

> >   - I swapped out "grep" for "head". What we are matching is not
> >     relevant; the important thing is that the reader closes the pipe
> >     immediately. So I guess in that sense we could probably even just
> >     pipe to "true" or similar.
> 
> I think the grep(1) is relevant though. The test explicitly verifies
> that `--recursive` propagates SIGPIPE, so we must make sure that we
> trigger the SIGPIPE when the child process produces output, not when the
> parent process produces it. That's why we grep for "X/S", where "X" is a
> submodule -- it means that we know that it is currently the subprocess
> doing its thing.

Hmm, I see what you mean. I don't think we can do that reliably, though,
or that the perl byte-stuffing is actually helping.

As I wrote it, perl always gets SIGPIPE first (because either "head"
exits while it is writing, or it fills up the pipe buffer and blocks,
waiting for head to exit, and then sees the pipe close).

And thus when we run git-submodule, the pipe is reliably closed and
we'll see SIGPIPE.

But with grep, that does not happen. The grep will run through all of
the data from perl (since it does not contain X/S), and there will not
be anything left in the pipe buffer by the time git-submodule starts. So
all of that data did nothing (though it fools the "sleep 1 && grep" from
losing the race because perl will block until grep starts, after the
sleep is finished).

And so we're left with the same race as before. git-submodule writes the
X/S line, grep reads it and then tries to exit while git-submodule is
writing more. And either:

  a. grep may exit immediately, before git-submodule writes any more
     data. In which case git sees SIGPIPE, which is what we want.

  a. git-submodule may write all of its data before grep exits. It will
     not block, because all of the stuff perl put in the buffer is long
     since gone, having been read by grep already. The data goes into
     the pipe buffer, and git-submodule has no idea it is discarded when
     grep exits. The test fails.

It's hard to simulate this one with a sleep, because it requires either
git-submodule to write quickly, or for grep to be slow after reading the
matching line but before exiting.

For the latter you can do:

diff --git a/t/t7422-submodule-output.sh b/t/t7422-submodule-output.sh
index 976f91b0eb..e2961e57dc 100755
--- a/t/t7422-submodule-output.sh
+++ b/t/t7422-submodule-output.sh
@@ -174,7 +174,7 @@ test_expect_success !MINGW 'git submodule status --recursive propagates SIGPIPE'
 		perl -le "print q{foo} for (1..33000)" &&
 		git submodule status --recursive 2>err
 		echo $?>status
-	} | grep -q X/S &&
+	} | { grep -q X/S && sleep 1; } &&
 	test_must_be_empty err &&
 	test_match_signal 13 "$(cat status)"
 '

on top of your patch, which reliably fails the test. I know that looks
kind of ridiculous and fake, but you can imagine it as that first grep
just taking a long time to call exit() and close the pipe.

It's hard to make git-submodule faster, because its output is really
coming from recursive invocations of itself. But you could imagine a
world where we do the submodule recursion in a single process, buffering
it via stdio, and then write all of the lines at once. And then
git-submodule always wins the race (it issues a single write() syscall
and then exits), and the test fails.

To make the test reliable, you'd need to pause or fill the pipe buffer
_after_ writing X/S via git-submodule but before writing the rest of the
data. Or to perhaps convince git-submodule only to write the recursive
data, and then pre-stuff the pipe as I suggested earlier. But I'm not
sure how to do the latter. Even if we ask for:

  git submodule status --recursive -- X

it will print out the status of "X" before recursing into it to show
X/S, etc, which will give us SIGPIPE in the parent submodule process,
not the recursive one.

For the former, I guess you'd need some hook that runs when we recurse
into the submodule and dumps a bunch of garbage into the pipe buffer.
But I don't think there is any such hook that runs here. Unless perhaps
you abused core.fsmonitor or something, but I don't think that's
portable.

So I don't really see a way to do this robustly.

-Peff
