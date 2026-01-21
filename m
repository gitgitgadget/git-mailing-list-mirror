Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C946B44D03C
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 07:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768979636; cv=none; b=bYN7Tt9FlvOh7em8l2ybKwdP9FjmVCfHHMsMGkkYnF3ZUf5HuQQTaHj1JMuWfF0s3MtgED8b6sbmwDmNBK8p2tvX8yWCkP8wCAb5E8NxYEazTXPvR/KPpQMe9xvt/8Ut8mwO9J+MGsAwkxVii5P+JpEkGaOVXKbZhwk4BSrv+os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768979636; c=relaxed/simple;
	bh=vi5VNergCsZHyctA548bWHb0bUfeajL21T6Ig0sqfyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sV54I00xYmjRYempKi/4o/8xEa0TmIrsTUQwZ0/4LQvqML8QC695YaP2JOHg1Rbma7gSNxGfmdkqOWRnL/a+9m/z3T1i0Ykyf9V8mqQkqzVnjo0e5G5yJFUOTj+wDSu8HBWduI6UW2wxwgiFY0gzxiq6gWIbbiNS5GyXzhGyqrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=FFgoGFco; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="FFgoGFco"
Received: (qmail 119619 invoked by uid 109); 21 Jan 2026 07:13:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=vi5VNergCsZHyctA548bWHb0bUfeajL21T6Ig0sqfyw=; b=FFgoGFcoGftvDM1uvfnlABAOXTt63jd3qKJb2wiLt/zNrVrmYF2a5L6QQFqxwA9iVA5bEfLSIriqq+AUz/EiQ/vCVjLzu9d+Ts5vJn7jf+0USAjEtiJRZRZ03ObxBbP6X6ITTYkpkbqsBVcYLW6HaxEDNK9E1V2dkdnxlwApEANQhht44Dj6FYXGlbNhSuCUA09uXt+ULYliZa2grYeeo1lEgp1Cqzk2roqKcN4kMhiNRvKQPdHo6Zw8BOTg0znQuRgoBBGxBxlVP6PFfLX8FLLZJs8IUQrfogRjMWqxWajMlUu9hQapbNPdODGUYMXdhKUOFAu7k5XWwXaX/HYsqg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 21 Jan 2026 07:13:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 195298 invoked by uid 111); 21 Jan 2026 07:13:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 21 Jan 2026 02:13:48 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 21 Jan 2026 02:13:44 -0500
From: Jeff King <peff@peff.net>
To: Paulo Casaretto via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	"Paulo Casaretto (Shopify)" <paulo.casaretto@shopify.com>,
	Patrick Steinhardt <ps@pks.im>,
	Paulo Casaretto <pcasaretto@gmail.com>
Subject: Re: [PATCH v5] lockfile: add PID file for debugging stale locks
Message-ID: <20260121071344.GA570838@coredump.intra.peff.net>
References: <pull.2011.v4.git.1767804355831.gitgitgadget@gmail.com>
 <pull.2011.v5.git.1768933954845.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.2011.v5.git.1768933954845.gitgitgadget@gmail.com>

On Tue, Jan 20, 2026 at 06:32:34PM +0000, Paulo Casaretto via GitGitGadget wrote:

> +static struct tempfile *create_lock_pid_file(const char *pid_path, int mode)
> +{
> +	struct strbuf content = STRBUF_INIT;
> +	struct tempfile *pid_tempfile = NULL;
> +	int fd = -1;
> +
> +	if (!lockfile_pid_enabled)
> +		goto out;
> +
> +	fd = open(pid_path, O_WRONLY | O_CREAT | O_EXCL, mode);
> +	if (fd < 0)
> +		goto out;
> +
> +	strbuf_addf(&content, "pid %" PRIuMAX "\n", (uintmax_t)getpid());
> +	if (write_in_full(fd, content.buf, content.len) < 0) {
> +		warning_errno(_("could not write lock pid file '%s'"), pid_path);
> +		close(fd);
> +		fd = -1;
> +		unlink(pid_path);
> +		goto out;
> +	}
> +
> +	close(fd);
> +	fd = -1;
> +	pid_tempfile = register_tempfile(pid_path);
> +
> +out:
> +	if (fd >= 0)
> +		close(fd);
> +	strbuf_release(&content);
> +	return pid_tempfile;
> +}

Coverity complains that the close(fd) call in the "out" label is
unreachable, and I think it is right. When we jump from before the
open(), or if the open failed, then fd is negative (and thus no close).
If we get there when write_in_full() fails, then we close ourselves in
the conditional. And if we succeed, then we close the descriptor before
registering the tempfile.

I don't think it's wrong, but the cleanup is redundant between the "out"
path and the others.

Did you mean this:

diff --git a/lockfile.c b/lockfile.c
index 731cdd4944..e5d6ae0df6 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -122,14 +122,10 @@ static struct tempfile *create_lock_pid_file(const char *pid_path, int mode)
 	strbuf_addf(&content, "pid %" PRIuMAX "\n", (uintmax_t)getpid());
 	if (write_in_full(fd, content.buf, content.len) < 0) {
 		warning_errno(_("could not write lock pid file '%s'"), pid_path);
-		close(fd);
-		fd = -1;
 		unlink(pid_path);
 		goto out;
 	}
 
-	close(fd);
-	fd = -1;
 	pid_tempfile = register_tempfile(pid_path);
 
 out:

which would just let the close after the out label handle all cases?

-Peff
