Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2292F20EB
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 06:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736748102; cv=none; b=bUQDdjle1/8Lxpk/7OpAJlCuSiBXVlk9puEC7tv1DV1vG/yAmGowetLFaJHTnCQQUlSyv4MCCEjhIi73A//AWigytFP+cUuv0RBVoa2LfI8Ek/LjPWqFxZYaLhpYw/P36sfBfCJmqtbrFs5/2Kjgdofwz+e7JCfTt2s6Fww8ix4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736748102; c=relaxed/simple;
	bh=2PZCn2b2XY/MMP2UqcSe3pCcghanho3aIXJDrNxnlcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQyusqvtA1KWRaJL2cWg8wLG/iQyPGRPaDWp6K6U/VOap0jsnmSaacLNKRTG/nrMa7rxiHMC0947+kZHfq+gL3YD+W23Sbea1cwJjnY7+Iz/8lR8tKKvyfS4JTxWHAv21jevEiXVktyY96wp2IWFgyRrLVrvfYXYanyfQ6Z46k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=X8pwkT4l; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="X8pwkT4l"
Received: (qmail 11868 invoked by uid 109); 13 Jan 2025 06:01:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=2PZCn2b2XY/MMP2UqcSe3pCcghanho3aIXJDrNxnlcU=; b=X8pwkT4l6q8hlj9todMG4nnT43QcxG3km6gwe1jlG3MduxDBgvEIXzgTL5L989BTRkyx8zVMDaNsWw2Czd0nzip49Kqx4xCOnQL3eJKQ5Bq3aecEejV/oOmqpUUEfwQFcuGpy6R954joX9xHkZF46HePJP7fcMlOgGfZjo9EKGy+b1hjXoXhI9SiyZ+/hqHvQML3dr4SQyb4iEwXwFZtF5qPQdSU2sjS/n3Qr9ifrJg1/TQkWO0L3CpcIQMsfpS3D2Lvjwc0u+mTEMLX4fa1YDnkMpUP3u9B8KL1L7DvHE9sBjjv88uHm2qVsuxoM17rfN6KW0y/br2OI6LC0FnHOQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 13 Jan 2025 06:01:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17329 invoked by uid 111); 13 Jan 2025 06:01:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 13 Jan 2025 01:01:43 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 13 Jan 2025 01:01:38 -0500
From: Jeff King <peff@peff.net>
To: rsbecker@nexbridge.com
Cc: git@vger.kernel.org
Subject: Re: [Question] etc/gitconfig and .gitconfig missing errors
Message-ID: <20250113060138.GC767856@coredump.intra.peff.net>
References: <021501db643a$9c5357b0$d4fa0710$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <021501db643a$9c5357b0$d4fa0710$@nexbridge.com>

On Sat, Jan 11, 2025 at 10:07:57AM -0500, rsbecker@nexbridge.com wrote:

> Question from my community. The standard git install does not
> automatically create the /usr/local/etc directory if it does not
> exist, so the git config --system fails.  If etc/gitconfig is missing,
> the command also fails. Similarly, if ~/.gitconfig is missing, git
> config -global fails.

It's not the missing file that is the problem, but the containing
directory, right? I.e.:

  $ make ETC_GITCONFIG=/tmp/foo/bar

  [reading returns an error, but that is natural because we did not
   find the config key in question]
  $ ./git config --system foo.bar; echo $?
  1

  [but writing will fail to create the lock file]
  $ ./git config --system foo.bar baz
  error: could not lock config file /tmp/foo/bar: No such file or directory

> Is this intended? I have been telling my people that they should
> pre-create those files with appropriate security. I have mused that
> having git auto-create this file may introduce potential CVEs,
> explaining the situation. Is this assumption correct?

This is what I'd expect. We do often automatically create leading
directories as necessary within the repository, but it gets weird
outside of that (and you probably wouldn't have permissions anyway).

It's less weird perhaps as part of "make install", but it still feels
like it is outside of Git's scope, and is more of a packaging issue. If
you're feeding /usr/local/etc to Git's build knobs, then you probably
should be the one making sure it exists.

All of this applies doubly so for ~/.gitconfig. We cannot do it at "make
install" time, since there may be many users. We could auto-create it at
run-time, but if the user's home directory does not exist that is likely
either a sign that something is terrible misconfigured, or the user in
question is not meant to have a home directory (daemon user ids, etc).
So creating it would probably be surprising.

I do think the error message could be a little more friendly; the
problem is not that /tmp/foo/bar does not exist, but that some leading
directory does not. But that is the nature of ENOENT.

We don't even get to see the actual lock filename fed to open(), since
it is done behind the scenes in hold_lock_file_for_update(). Possibly we
should be using unable_to_lock_message(). Or hmm, looks like we can feed
a flag to do it for us, like:

diff --git a/config.c b/config.c
index 50f2d17b39..5f8e0c667a 100644
--- a/config.c
+++ b/config.c
@@ -3206,9 +3206,9 @@ int repo_config_set_multivar_in_file_gently(struct repository *r,
 	 * The lock serves a purpose in addition to locking: the new
 	 * contents of .git/config will be written into it.
 	 */
-	fd = hold_lock_file_for_update(&lock, config_filename, 0);
+	fd = hold_lock_file_for_update(&lock, config_filename,
+				       LOCK_REPORT_ON_ERROR);
 	if (fd < 0) {
-		error_errno(_("could not lock config file %s"), config_filename);
 		ret = CONFIG_NO_LOCK;
 		goto out_free;
 	}

That is only marginally better, though:

  $ ./git config --system foo.bar baz
  error: Unable to create '/tmp/foo/bar.lock': No such file or directory

It does diagnose other problems like EEXIST, and IMHO it would not be
unreasonable for it to recognize ENOENT and see if we can even stat()
the surrounding directory.

-Peff
