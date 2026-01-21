Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF616326D57
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 16:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769013569; cv=none; b=mZzHXqunOJ7lQRmZWpHjOIYGz844cRBsMT+5WwUQ7hJSWKgpAq6KSulxvWEjlGlhZJPJyDiwtsaRZzJx0XaNuAXY61JpvKCZXmNDtQCbOBPeTgPilPvWeOarCSMMo0P99rF+c+//5sneuSZjGrOavEo1+gnGsUAxfM2bahAsWBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769013569; c=relaxed/simple;
	bh=57NY4EjlKdUV9xd34NjMhAY5/ea8jZ7WTsr8FBVtQ00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tnwqPwIbqkDQhw6LUAq5y5wR5hrcareToLzCXZ1VBLxK1t2YYXRVvvPVGlXEgVDEtiPpz8SPUlN7zyoALlzcC8hZ54KioYXR93O0Yf+htIQYHGdX4I8wHNznzzI1qc8xNzaED/+/CR4xauEBCw+lV6riHZVqWdh6pH3P32cKVr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=L0xOz7H0; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="L0xOz7H0"
Received: (qmail 122561 invoked by uid 109); 21 Jan 2026 16:39:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=57NY4EjlKdUV9xd34NjMhAY5/ea8jZ7WTsr8FBVtQ00=; b=L0xOz7H0EVwJgvMt7iVBXIcipHhLoZPxSn+ofQLaHHh0QMf1i3FTC6qixqnS+gbBrFK1v2f+ntWCwXOfltdHF9aiWL9QQhmljwYY7xfiKJqJPJzsX5ZJZq4iRvzJrnXw/FV5nkFUZOERgM42Sk47f7rVCSbPg+jVleSDGTCw6v6bbNtqA3SRLF0m19oTgN8ufPff6Dgz9JtEWcsku91jjrUC/oJoL/7J/60o7zaHep+neht4daltvZoSM392bPhH2BAGWkfQcMqpKWlvQ0GXzm0k7SlWORyOH+W5qeiGwh6475VdxfB3bX7Okw5CbeY9GFCyerL6Z55WgVwAsviYaw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 21 Jan 2026 16:39:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 205723 invoked by uid 111); 21 Jan 2026 16:39:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 21 Jan 2026 11:39:25 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 21 Jan 2026 11:39:24 -0500
From: Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Paulo Casaretto via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	"Paulo Casaretto (Shopify)" <paulo.casaretto@shopify.com>,
	Patrick Steinhardt <ps@pks.im>,
	Paulo Casaretto <pcasaretto@gmail.com>
Subject: Re: [PATCH v5] lockfile: add PID file for debugging stale locks
Message-ID: <20260121163924.GA576236@coredump.intra.peff.net>
References: <pull.2011.v4.git.1767804355831.gitgitgadget@gmail.com>
 <pull.2011.v5.git.1768933954845.gitgitgadget@gmail.com>
 <20260121071344.GA570838@coredump.intra.peff.net>
 <CAPig+cSE7Y-MLu1PTdo2kUq_MztMQgm0eYby03cX2K5YAJLwsg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cSE7Y-MLu1PTdo2kUq_MztMQgm0eYby03cX2K5YAJLwsg@mail.gmail.com>

On Wed, Jan 21, 2026 at 03:13:41AM -0500, Eric Sunshine wrote:

> > diff --git a/lockfile.c b/lockfile.c
> > @@ -122,14 +122,10 @@ static struct tempfile *create_lock_pid_file(const char *pid_path, int mode)
> >         strbuf_addf(&content, "pid %" PRIuMAX "\n", (uintmax_t)getpid());
> >         if (write_in_full(fd, content.buf, content.len) < 0) {
> >                 warning_errno(_("could not write lock pid file '%s'"), pid_path);
> > -               close(fd);
> > -               fd = -1;
> >                 unlink(pid_path);
> >                 goto out;
> >         }
> >
> > -       close(fd);
> > -       fd = -1;
> >         pid_tempfile = register_tempfile(pid_path);
> >
> >  out:
> >
> > which would just let the close after the out label handle all cases?
> 
> Correct me if I'm wrong, but wouldn't this suggested change be
> problematic on Microsoft Windows? Specifically, if I recall correctly,
> Windows won't allow a file to be deleted if any processes still have
> it open, and this change eliminates the call to close() preceding the
> call to unlink(), so the file would still be held open when the
> attempt is made to remove it.
> 
> If so, then probably better would be to drop the unreachable `if (fd
> >= 0) close(fd)` after the `out` label.

Ah, yeah, you're right. Ironically I spent quite a while thinking on the
implications of calling close() before register_tempfile() and decided
it didn't matter, but totally ignored the first half of the hunk. ;)

The second half is still valid, I think, but at that point it is the
only path that uses the close() in the out-path, so we might as well
drop the out-path one.

-Peff
