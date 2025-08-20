Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC336FBF
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 22:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755727485; cv=none; b=pWUxSFwuxfMxg6P9DZk/kyPU8Czv9PVONMOisTVPzgVUIy33+YCp80v9zVMGWX3krUQ3tzyZZeZSk/lJd0EyXrYj+Fj7ujyVCL6tlR6YkIz+znfhbHCH5MSFWCDjdXeTXSf+Ko2YiQlc3hc0GwxiqDOIQJpqE5sPbjPvwxc2+I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755727485; c=relaxed/simple;
	bh=0kemD6Q6ap7HEx2gCU0JE/Zaozx3UCWH2RuICrcYpgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ns54jbPztXcwSBzFPupxXpWRXy/mlMnbPM/I5DOX1SWG2rOuy3iE1BK7Wp6DcFhOpT4uQNeb+KlD3SzyfqwKSP9xgyPTmz5OsDZFd52kZFxKTy9Nfq7VKs8u4FaQmnCDf7gDV+cDI7CdUzX2/gsHJyz5XFh+Ct3TMbHAAyzDGXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=hIa90k30; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="hIa90k30"
Received: (qmail 39641 invoked by uid 109); 20 Aug 2025 22:04:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=0kemD6Q6ap7HEx2gCU0JE/Zaozx3UCWH2RuICrcYpgE=; b=hIa90k30U7Xj2GOdvuheEXZm7VYiDXdw55mGE3nQUbXrrre0WyjqhaJP0JD3CMhwA2rKkomF6qpq5VON3bg/fdDHLnjUDeXCilQSPkbaCYlMsyZYTezMj0nes7/dUrKriyrwZ1UtXsr66dLB9mMWDfTpkfX5xSp4T6Mer7ckNbKkZJgd3UMFrlTRLNTtpKALUDj1WWK3MBur/lZ2v1+YtSCb25vum30tsRUg4TYT7sbBAmUmK4hMspZ1XU2bX+w9l5fu6Ti7qSkjj8sbQObGDnTIKR3iFZtdQqTWiQy7BKaEavq5Z/IqItOSofGiSB3PoICni/vZHZs7QPjEGBN5dw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 20 Aug 2025 22:04:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 65408 invoked by uid 111); 20 Aug 2025 22:04:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 20 Aug 2025 18:04:40 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 20 Aug 2025 18:04:39 -0400
From: Jeff King <peff@peff.net>
To: Isaac Oscar Gariano <isaacoscar@live.com.au>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [BUG] Some subcommands ignore color.diff and color.ui in --patch
 mode
Message-ID: <20250820220439.GA1668511@coredump.intra.peff.net>
References: <SYBP282MB296329544B33E3C16DD99FD28C33A@SYBP282MB2963.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SYBP282MB296329544B33E3C16DD99FD28C33A@SYBP282MB2963.AUSP282.PROD.OUTLOOK.COM>

On Wed, Aug 20, 2025 at 11:05:53AM +0000, Isaac Oscar Gariano wrote:

> Bassically the colouring behaviour of the interactive --patch option
> to the various commands differ.
> I'll call "commit, add, and stash the "good commands" (as they behave
> as I expect), and stash push, stash save, checkout, reset, and restore
> the "bad commands" (which are bugged).

I think this is a regression in the conversion of the interactive-patch
code from a perl script to a C builtin. Bisecting points to 0527ccb1b5
(add -i: default to the built-in implementation, 2021-11-30).

Without digging too deeply, I'd guess the issue is that the original
perl script loaded all config itself. But now that the code runs
in-process, it is depending on the outer command to have loaded the
color.ui setting. And indeed, the code here:

  $ git grep -A3 color.interactive add-interactive.c
  add-interactive.c:      if (repo_config_get_value(r, "color.interactive", &value))
  add-interactive.c-              s->use_color = -1;
  add-interactive.c-      else
  add-interactive.c-              s->use_color =
  add-interactive.c:                      git_config_colorbool("color.interactive", value);
  add-interactive.c-      s->use_color = want_color(s->use_color);

shows that we consult color.interactive correctly, but then depend on
want_color() to do any fallback to color.ui. And that is just looking at
a pre-set variable:

  
  int want_color_fd(int fd, int var)
  {
  [...]
          if (var < 0)
                  var = git_use_color_default;
  [...]
  }

which is expected to be set by the outer command loading the color
config via git_color_config(). And that's why it works for "git add",
but not "git checkout".  Either "checkout" (and other commands) should
learn to call git_color_config(), or the interactive code should itself
learn to handle the fallback.

I'd expect something like this:

diff --git a/add-interactive.c b/add-interactive.c
index 3e692b47ec..ad8b4907e1 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -50,6 +50,8 @@ void init_add_i_state(struct add_i_state *s, struct repository *r,
 	else
 		s->use_color =
 			git_config_colorbool("color.interactive", value);
+	if (s->use_color < 0 && !repo_config_get_value(r, "color.ui", &value))
+		s->use_color = git_config_colorbool("color.ui", value);
 	s->use_color = want_color(s->use_color);
 
 	init_color(r, s, "interactive.header", s->header_color, GIT_COLOR_BOLD);

to work, but it doesn't seem to. Maybe the diff code is independently
looking at git_use_color_default, and we really do need to set the
variable?

At any rate, I think there may be a simpler workaround for you...

> As for why I care, I was trying to pipe git restore through
> diff-highlight (this functionality should really be inbuilt into git
> diff)

Have you tried setting interactive.diffFilter to "diff-highlight"?
That's what it was designed for.

> A related issue, that is probably not a 'bug': all the --patch options
> ignore the diff config options (e.g. diff.wordRegex).

The interactive patch options use the diff plumbing under the hood,
because they have certain requirements from the output. For example, you
can't apply a word-diff (or a colorized one for that matter; the color
is handled specially by generating the diff twice, once with color and
once without, and assuming that the lines correspond between them).

So the interactive code has to manually interpret any diff options that
it thinks are OK and pass them along to the underlying diff command.
There are undoubtedly some that would make sense for it to handle, but
nobody has cared enough yet to teach it (I think it just learned about
diff.context in the latest release).

I'm not sure if diff.wordRegex is such a case, though. You can't apply a
word diff (and it does not have line-to-line correspondence with a
non-word diff, so you can't show one and apply the other). But there may
be spots where we'd use it for generating a normal unified diff.

-Peff
