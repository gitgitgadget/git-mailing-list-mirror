Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67923173
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 03:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768360381; cv=none; b=ROMTrqeDbaNay2440Dn7WkI7WLatZOe8vKDrImtubkIJ6Hp26mWpW6tNl4XT8FkPpQ8EyElDZOXqzrSH2hllWReT0SB5+4DfeeXPslIKNBlSOYIgyHn5mUBZe2iTfOXHnGX98x2y5DgQO2um8eWmuWG1RP90irP9Yaq+Iijq5Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768360381; c=relaxed/simple;
	bh=9++FgaCAe4mgFl7uVtNJpHYrEQswxtstMl+vcrvPrsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HvAYb59dEPowcl2vIExg1YreRL7+3yW9V5g9FncXOuetyXGYxIHHr67OrDplKvc140efZ5iF+G9G3n6Rw7auiny7DaRv13Os5n2vX6jm8rusxuNPaTj1smzYoe5/X2yAzrKKP3VenZQEDoSMOrL0QkpiywOk0rDaeiAGvMXT3PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=GwW0xJR5; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="GwW0xJR5"
Received: (qmail 35431 invoked by uid 109); 14 Jan 2026 03:12:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=9++FgaCAe4mgFl7uVtNJpHYrEQswxtstMl+vcrvPrsE=; b=GwW0xJR5nnDTp/K2vjcL+jx35eaijouY32g6EMyuu8bz34Il6MCgEbYbN0c2zIdDVWPRBK3ny+QvcYBI1F0UBTvUeioZPC9VJ8lVIycM3dcmm5pIdKnvQPYYy1Jl57rRhm+UEIXf/MlUe2x1YyDtpwz5jwXAMPWmHm6YRRrCnKEd0YtTkP/bmCS0Yq7VzU89s17S+v09GYC74fwjQDk/1MNbKWYK6mi7/QiBCTeIxxwHwf8FRX8GkYFmPhEc6wHz/Nw8lve1A4ZbWGJQ5BPpNANIftLs/7GTY5M5Yr5uHxemIQzfloSEGbI4UdfN/O5BuTkK3jsyQ1Bl8ULu2s5rZQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Jan 2026 03:12:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 57702 invoked by uid 111); 14 Jan 2026 03:13:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Jan 2026 22:13:01 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 13 Jan 2026 22:12:57 -0500
From: Jeff King <peff@peff.net>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Emily Shaffer <emilyshaffer@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Chris Darroch <chrisd@apache.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2] hook: allow hooks to disable stdout_to_stderr
Message-ID: <20260114031257.GA858646@coredump.intra.peff.net>
References: <20260113115633.230479-1-adrian.ratiu@collabora.com>
 <20260113234528.1749921-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260113234528.1749921-1-adrian.ratiu@collabora.com>

On Wed, Jan 14, 2026 at 01:45:28AM +0200, Adrian Ratiu wrote:

> Changes in v2:
> * Extended hook test coverage to detect future regressions (Junio, Patrick)
> * Reworded commit message and added explanatory comment (Junio, Patrick)
> * Set ungroup = 1 because grouping overrides stdout_to_stderr (Adrian)

I have not really been following this topic, but I did read (and
reproduce) Kristoffer's earlier report about reading stdin. The fix here
was not quite what I expected.

In particular...

> @@ -93,6 +98,7 @@ struct run_hooks_opt
>  #define RUN_HOOKS_OPT_INIT { \
>  	.env = STRVEC_INIT, \
>  	.args = STRVEC_INIT, \
> +	.stdout_to_stderr = 1, \
>  }

...I expected to see:

  .ungroup = 1, \

here. The stdin issue goes back to 857f047e40 (hook: allow overriding
the ungroup option, 2025-12-26), where the "ungroup" field was added,
and various code paths set it to "1" to match the previous behavior. But
any paths that were missed, including run_pre_push_hook(), would see a
change of behavior (and in this case, a bug).

My reading of 857f047e40 is that it meant to give callers the _option_
to switch the ungroup behavior, but not actually change anything. So
wouldn't we want to leave the default as it was by initializing it to
"1"?

> @@ -1373,6 +1373,15 @@ static int run_pre_push_hook(struct transport *transport,
>  	opt.feed_pipe = pre_push_hook_feed_stdin;
>  	opt.feed_pipe_cb_data = &data;
>  
> +	/*
> +	 * pre-push hooks expect stdout & stderr to be separate, so don't merge
> +	 * them to keep backwards compatibility with existing hooks.
> +	 * run_process_parallel(), called via run_hooks_opt() below, will buffer
> +	 * and merge the streams when output is grouped, so also set ungroup = 1.
> +	 */
> +	opt.stdout_to_stderr = 0;
> +	opt.ungroup = 1;

The other unexpected thing is that these two fixes are grouped at all.
AFAICT, setting ungroup to 1 will fix Kristoffer's stdin problem without
changing stdout_to_stderr at all.

But I'm still not entirely sure I understand why the ungroup setting,
which supposedly only affects stderr handling, causes the hook to fail
to read stdin. Poking at it in a debugger and via strace, it looks like
we are in a poll loop while feeding stdin, even though we are not
checking whether the child can read! If we instrument like this:

diff --git a/transport.c b/transport.c
index 6d0f02be5d..7381450123 100644
--- a/transport.c
+++ b/transport.c
@@ -1342,6 +1342,7 @@ static int pre_push_hook_feed_stdin(int hook_stdin_fd, void *pp_cb UNUSED, void
 		break;
 	}
 
+	warning("called pre_push_hook_feed_stdin for %s", r->name);
 	if (!r->peer_ref)
 		return 0;
 

and then run the push from Kristoffer's recipe under strace, I see:

  poll([{fd=7, events=POLLIN|POLLHUP}], 1, 100) = 0 (Timeout)
  write(2, "warning: called pre_push_hook_feed_stdin for refs/tags/gitgui-0.6.3\n", 68) = 68
  poll([{fd=7, events=POLLIN|POLLHUP}], 1, 100) = 0 (Timeout)
  write(2, "warning: called pre_push_hook_feed_stdin for refs/tags/gitgui-0.6.4\n", 68) = 68
  poll([{fd=7, events=POLLIN|POLLHUP}], 1, 100) = 0 (Timeout)
  write(2, "warning: called pre_push_hook_feed_stdin for refs/tags/gitgui-0.6.5\n", 68) = 68
  poll([{fd=7, events=POLLIN|POLLHUP}], 1, 100) = 0 (Timeout)
  write(2, "warning: called pre_push_hook_feed_stdin for refs/tags/gitgui-0.7.0\n", 68) = 68
  poll([{fd=7, events=POLLIN|POLLHUP}], 1, 100) = 0 (Timeout)
  write(2, "warning: called pre_push_hook_feed_stdin for refs/tags/gitgui-0.7.0-rc1\n", 72) = 72
  poll([{fd=7, events=POLLIN|POLLHUP}], 1, 100) = 0 (Timeout)

So we are hitting the poll timeout for each ref we consider, and it
takes forever to actually write the whole input stream. Which seems like
a bug in using feed_pipe without ungroup. Either:

  1. We should write everything to the child as quickly as possible,
     assuming that we do not have to worry about reading back from it to
     avoid deadlock.

  2. We should add the child's input pipes to our poll() call so that we
     can tell it is ready for more input (without hitting the timeout).

Setting ungroup=1 saves us from this because it means that we'll skip
the poll() call entirely in pp_handle_child_IO(). So we end up
effectively doing (1), which is OK because ungroup means we are not
reading stdout or stderr from the child at all.

But it feels like this is papering over a bug, or at least providing a
dangerous interface. AFAICT you _must_ set ungroup if you are going to
use the feed_pipe callback. And it does not really have anything to do
with the stdout_to_stderr flag at all.

It looks like feed_pipe feature is new-ish in your series. Maybe it
should just be a BUG() to use it without ungroup?

-Peff
