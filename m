Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3F22206A7
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 05:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775625635; cv=none; b=q77yUJ85Fcu+Pty0wpY565AJH5I8pbpnux7BUeLqIaMNh4d9GRonhRnr3/l3HJwoRQ0Lusgq/PqfY7cGCGEtSRlhoPkiSzz0q0W5p96r9SPKeYPpXlxxLuHb7X/JQXYR6pqFjUcNY7jvmpJB4In/LQ8D6nlittqHicSA9ol9UKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775625635; c=relaxed/simple;
	bh=uwU7fdxjS/28N8Z52k7qjowdpWTWRnaOxyPQYD33vjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YmsXyGWY+i0ci0Wu1gugQbGVoBUD7ARVc/Ks2BtQaWqCiToX/hzvstq9vrUe/+CJNzAc14aTjwc68zSavfp8XQG0q8UAhyKe15XKCH1APfHC/Sjq4w1qPFlbE7x6JUoTBKug2bjL7n2VEV8zP3leQzwTQBPDs1OZ/jEfIbVA2Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=VgP8DZvr; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="VgP8DZvr"
Received: (qmail 279554 invoked by uid 106); 8 Apr 2026 05:20:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=uwU7fdxjS/28N8Z52k7qjowdpWTWRnaOxyPQYD33vjU=; b=VgP8DZvr2Jpxob+XPK7Nj133s0buXxyg0dbNZg+2NhXdNP4hEt00LFLJuBCU7XQckzJ8gdFFbdWyQc2HIV16K/L5/NfSpdHNYVF1PcvmCUPzQOW/Z8wOT8zuhysnGBdX7TT5IunyeyYGThDSGxL63KcvhJM9/W3fe4Q0xahNxxGrv4T8bK/5A4rHxT4od/5CInB4eHkbBSv/diNO4GohELPCONQLkUENenQOF8JUR29rAcC+GysbpqY8gmFhJPuQxq4Wx7q34539UWqn9/duHNZUE30aNMAzLLhXaB0fz/otAo5khcOIahQESaLJPXvHPReKpoOiOozgJ5Y4u3Uekw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 08 Apr 2026 05:20:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 457470 invoked by uid 111); 8 Apr 2026 05:20:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Apr 2026 01:20:31 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 8 Apr 2026 01:20:31 -0400
From: Jeff King <peff@peff.net>
To: rsbecker@nexbridge.com
Cc: Junio C Hamano <gitster@pobox.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>, git@vger.kernel.org
Subject: Re: Help needed on 2.54.0-rc0 t5301.13 looping.
Message-ID: <20260408052031.GB1324339@coredump.intra.peff.net>
References: <00f501dcc6e7$8ef295c0$acd7c140$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <00f501dcc6e7$8ef295c0$acd7c140$@nexbridge.com>

On Tue, Apr 07, 2026 at 07:37:49PM -0400, rsbecker@nexbridge.com wrote:

> Weird fail on t5401.13. Any opinions or advise on this?
> 
> expecting success of 5401.13 'pre-receive hook that forgets to read its
> input':
>         test_hook --clobber -C victim.git pre-receive <<-\EOF &&
>         exit 0
>         EOF
>         rm -f victim.git/hooks/update victim.git/hooks/post-update &&
> 
>         test_seq -f "create refs/heads/branch_%d main" 100 999 |
>         git update-ref --stdin &&
>         git push ./victim.git "+refs/heads/*:refs/heads/*"

OK, so this test is trying to feed a bunch of data to a pre-receive hook
that doesn't read anything, and we want to make sure we aren't killed by
SIGPIPE.

When the test was added originally in ec7dbd145b (receive-pack: allow
hooks to ignore its standard input stream, 2014-09-12), we just stuck a:

  sigchain_push(SIGPIPE, SIG_IGN);

at the top of the hook function. But now that function has been
rewritten to use the hook API, and that sigchain_push() is gone.

What does the new hook API do? It works with run-command's
run_processes_parallel() function. Which similarly ignores SIGPIPE,
courtesy of ec0becacc9 (run-command: add stdin callback for
parallelization, 2026-01-28):

          /*
           * Child tasks might receive input via stdin, terminating early (or not), so
           * ignore the default SIGPIPE which gets handled by each feed_pipe_fn which
           * actually writes the data to children stdin fds.
           */
          sigchain_push(SIGPIPE, SIG_IGN);

OK, so far so good. But that's not quite the end of the story. In
pp_init(), we then sigchain_push() another handler, but this time it's a
real function:

  static void handle_children_on_signal(int signo)
  {
          kill_children_signal(pp_for_signal, signo);
          sigchain_pop(signo);
          raise(signo);
  }

So now when we get a SIGPIPE, we end up there. It tries to propagate the
signal to any child processes we spawned. Which is a bit funny, since it
was the child process closing that caused us to get the signal in the
first place, but of course our handler doesn't know that.

And then afterwards, it pops itself off the handler stack and re-raises.
But that will hit the SIG_IGN we pushed earlier and do nothing. So that
part isn't interesting.

What is interesting is that we end up calling "kill(<pid>, SIGPIPE)" on
the child via kill_children_signal(). At least on my Linux system that
works fine, since we haven't reaped the process via wait() yet. But of
course nothing interesting happens to the child, which has already
exited. Killing it with SIGPIPE does not seem to affect its exit code.

However, I could believe that on some other system it might behave
differently. Possibly even racily. For example, if the child process had
closed its pipe (giving us SIGPIPE in the parent) but not yet fully
exited, could our kill() cause it to change its exit code? And then it
would look like the hook reported failure (because it died by signal).
And I'd expect the output you saw.

I think the root of the issue is that we should not be trying to
propagate SIGPIPE to the child in this case at all. Our handler is
pushed there only because it's part of sigchain_push_common(), which is
sensible: in general if we are dying to SIGPIPE we want to do our
cleanup. It's just funny in this case with the ordering of our SIG_IGN,
because now that SIG_IGN isn't on top of the stack anymore.

I.e., I think we want to reorder like this:

diff --git a/run-command.c b/run-command.c
index 32c290ee6a..8a95f7ff1e 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1895,14 +1895,19 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
 					   "max:%"PRIuMAX,
 					   (uintmax_t)opts->processes);
 
+	pp_init(&pp, opts, &pp_sig);
+
 	/*
 	 * Child tasks might receive input via stdin, terminating early (or not), so
 	 * ignore the default SIGPIPE which gets handled by each feed_pipe_fn which
 	 * actually writes the data to children stdin fds.
+	 *
+	 * This _must_ come after pp_init(), because it installs its own
+	 * SIGPIPE handler (to cleanup children), and we want to supersede
+	 * that.
 	 */
 	sigchain_push(SIGPIPE, SIG_IGN);
 
-	pp_init(&pp, opts, &pp_sig);
 	while (1) {
 		for (i = 0;
 		    i < spawn_cap && !pp.shutdown &&

Does that make your problem go away?

I suspect we could construct a related case that does fail on Linux
without the patch above. Imagine we actually have two hooks running in
parallel. The first one is fast and does not read its input, and the
second one is slow. We'll get SIGPIPE writing to the first one, and then
kill _both_ children. But that's wrong! There is no reason to kill the
second hook, as our intent was to ignore SIGPIPE.

-Peff
