Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53455199EAD
	for <git@vger.kernel.org>; Sat, 26 Jul 2025 07:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753516308; cv=none; b=gqblzaA8g9Tv8/2+8IL0aTiodPkTcPdWvjQ/e58cb+ZaUr6UqKRJ75MK5H0OtUJ13J6gCaPXXvitovmxsfe1FZ49H7RyQ1bIHqN2XA9G+JEu82HRaa/y4Qr07VpZ8WVkkunJy2jKns1fGSHmae+/9fj7GJNvVY4JJgMCLL8OgHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753516308; c=relaxed/simple;
	bh=qBlwE7SEPvJRutph5Q2V1Dhf/uNQd78zYWh2TqB8TGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6yzK1BJmaTV/DLVL9SL7sOUOevY6o4+xDwFM6oeNgKUKX64rIpP3/o9IRz+MCb8ykPzhbAQ+SWwGZCv5SWh6uKEpA9rJjjkKLpD4IxXOdU3nzL+VXRf2eLvV/IQ/4LJ0FHBD9n/kuW1WdrWTZB+y4ERxrisOGD9CgQAgcTqP94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=VN3um8X/; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="VN3um8X/"
Received: (qmail 2078 invoked by uid 109); 26 Jul 2025 07:51:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=qBlwE7SEPvJRutph5Q2V1Dhf/uNQd78zYWh2TqB8TGI=; b=VN3um8X/dQi7ejEBNIShVwZ+mfyi7QzBXodeAEb7GqeW0FmVzeWoBW3+TXrcE2skkimk8PRRXermnoLQl09YiNwXLcIEAM3IlldPsfvs85N516IhUKs3lnjwwTb2FJfKholAEEATY068hIK+jc74eTZhcJFIi8lOyCxzfbMFPD/MIcVgQPC2ITmF0rruUeyAi3IpaVE+qJ1ZEqvRnchBRCwBQgEWp8Ay15L70JI0aRDunvUd9MmSGXEX5V7f/rTMcixm1vq/qVWhq2CRdLfuHm0cDilMv5LfQAhQuxEZnb9Hc7sw1QYIhCkZGxvGe+yGneSmOJ+jBd2DJtBF7jPJDg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 26 Jul 2025 07:51:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6914 invoked by uid 111); 26 Jul 2025 07:51:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 26 Jul 2025 03:51:41 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 26 Jul 2025 03:51:36 -0400
From: Jeff King <peff@peff.net>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: git@vger.kernel.org
Subject: Re: [BUG?] git-daemon 2.49.0 in F40 no longer exports user
 directories
Message-ID: <20250726075136.GA3032762@coredump.intra.peff.net>
References: <aIOslkzu-x8K9o_C@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aIOslkzu-x8K9o_C@shell.armlinux.org.uk>

On Fri, Jul 25, 2025 at 05:11:02PM +0100, Russell King (Oracle) wrote:

> While I've been away on holiday over the last three weeks, my co-admin
> updated ZenIV to Fedora 40, and now I find that git-daemon no longer
> exports my "public_git" directory. My attempts at debugging this have
> failed - I tried adding strace to the git@.service but I get nothing.
> This is a regression.

I'm not aware of anything changing here recently, and ~user expansion
does seem to work for me. E.g. using v2.49.0 and running:

  git daemon --base-path=/tmp/foo --export-all --user-path=public_git \
	--verbose --log-destination=stderr

and then running:

  mkdir ~peff/public_git
  git init --bare ~peff/public_git/repo.git
  git -C ~peff/public_git/repo.git --work-tree=. commit --allow-empty -m foo

  git ls-remote git://localhost/~peff/repo.git

works. I get a similar log message to you here:

> Jul 25 16:56:55 ZenIV git-daemon[4046439]: [4046439] userpath <public_git>, request <~rmk/linux-arm.git/>, namlen 4, restlen 15, slash </linux-arm.git/>

That is, even though we print ~peff (or ~rmk), I think we still look for
repos in /home/peff. E.g., if I strace and substitute "none.git" (to
make the trace smaller, since we won't find a repo), I see it looking
at:

  
  newfstatat(AT_FDCWD, "/home/peff/public_git/none.git/.git", 0x7ffc1cf9c8d0, 0) = -1 ENOENT (No such file or directory)
  newfstatat(AT_FDCWD, "/home/peff/public_git/none.git", 0x7ffc1cf9c8d0, 0) = -1 ENOENT (No such file or directory)
  newfstatat(AT_FDCWD, "/home/peff/public_git/none.git.git/.git", 0x7ffc1cf9c8d0, 0) = -1 ENOENT (No such file or directory)
  newfstatat(AT_FDCWD, "/home/peff/public_git/none.git.git", 0x7ffc1cf9c8d0, 0) = -1 ENOENT (No such file or directory)

If you strace, do you see similar stat calls?


But of course I don't get this log line:

> Jul 25 16:56:55 ZenIV git-daemon[4046439]: [4046439] '~rmk/public_git/linux-arm.git': not in directory list

which isn't too surprising since things succeed for me. But the "not in
directory list" part is interesting. If we could not find the repo on
disk, we get something more like:

  '~peff/public_git/none.git' does not appear to be a git repository

Looking through daemon.c:path_ok(), if we see the user-path expansion
but not "does not appear to be a git repository", then we're getting
hung up on this code:

          if ( ok_paths && *ok_paths ) {
                  const char **pp;
                  int pathlen = strlen(path);
  
                  /* The validation is done on the paths after enter_repo
                   * appends optional {.git,.git/.git} and friends, but
                   * it does not use getcwd().  So if your /pub is
                   * a symlink to /mnt/pub, you can include /pub and
                   * do not have to say /mnt/pub.
                   * Do not say /pub/.
                   */
                  for ( pp = ok_paths ; *pp ; pp++ ) {
                          int len = strlen(*pp);
                          if (len <= pathlen &&
                              !memcmp(*pp, path, len) &&
                              (path[len] == '\0' ||
                               (!strict_paths && path[len] == '/')))
                                  return path;
                  }
          }
          else {
                  /* be backwards compatible */
                  if (!strict_paths)
                          return path;
          }

My command line does not set --strict-paths, and neither does yours. So
presumably you are stuck on the ok_paths. But those come from non-option
paths on the git-daemon command line. My invocation does not pass any,
and from what you wrote here:

> and /lib/systemd/system/git@.service contains:
> 
> [Unit]
> Description=Git Repositories Server Daemon
> Documentation=man:git-daemon(1)
> 
> [Service]
> User=nobody
> ExecStart=-/usr/libexec/git-core/git-daemon --base-path=/var/lib/git --export-all \
>           --user-path=public_git --inetd --log-destination=stderr --verbose
> StandardInput=socket
> StandardError=journal

neither do you. Is it possible that when invoking git-daemon, systemd is
adding more arguments? Can you check with systemd logs or via strace (or
maybe even ps, though I guess the process is short-lived in inetd mode)?

I'm not very familiar with systemd, but IIRC @-services are just
templates that expect an argument. And in this case the argument is
filled in when the git.socket service runs the git@ unit for a single
connection. But I think that argument is only expanded by a
%-placeholder, not shoved onto the ExecStart line.

So I dunno. I am just guessing at the systemd connection.  But it seems
like somehow an extra argument is ending up in your git-daemon
invocation.

-Peff

PS My invocation above is obviously not running in --inetd mode like
   yours is, but I don't think that's the culprit. If I put this into
   /tmp/proxy:

     #!/bin/sh
     exec git daemon --base-path=/tmp/foo --export-all --inetd \
	--user-path=public_git --log-destination=stderr --verbose

  and then invoke it directly:

    git -c core.gitproxy=/tmp/proxy ls-remote git://localhost/~peff/repo.git

  it works the same.

  I also tried taking the FC40 git@.service and git.socket files and
  sticking them in my systemd setup, and it also seems to work. So I am
  all out of guesses.
