Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776DE30FF31
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 07:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760684959; cv=none; b=k8a/XM/VgOI9zCYYR8lTBUWrCtfLO8NtHtjjQRDhaS6n9ud/seZ4VO/SRic/fkGNkxRbRLnJAt2L+DKf2LvN1fkl9z6eG4FTS4RjJDjrcbzc5iHX6IycKC+kWgFQJ4unRHgdYnswWsFsAa+mAgr7sAehDvnMZL5d0UU1Y3tA94o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760684959; c=relaxed/simple;
	bh=c3BL14xitQ6pTwe7beyfWc2bQp+EVZnBYw2EGz/HCOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hd3+mmBc6qgIZomumrgdRNsVjuCAlbWjiyGp7VVkfa+ZdQ67hRIkT3xH0cFtXyIL7u1HbniP1YdvB5IrJhBzKwjucMG1UabA4YBF4gdJ1kMdj701ffE48o555VsQHbfUUoZ6rrl0WpI/hcnSnMRR3jZi/o5p4AM4DBmOjvv3dNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=IReTKVBf; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="IReTKVBf"
Received: (qmail 251907 invoked by uid 109); 17 Oct 2025 07:09:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=c3BL14xitQ6pTwe7beyfWc2bQp+EVZnBYw2EGz/HCOs=; b=IReTKVBfvWd4n1wto8gbh57jD3KN11gr5/lQ4vex/Ec7ZrL7Rx634VcIQD/nDiT3irX1NJR8ohylySVXN6+tPnwCd6jj1g24hE8b6m/xlmIaZr+QuJwKA2IyB3rm5fiPZVQf37DGNmNw0Je6xtPIHZX2sw/uQsrNf0pLSNs1gh5a7Y0lWwSdt0KJpky6aVcj7Mhu9SprfyQjasIBebxk3wM4RV9HnofnWgrj1dM+MUELLEPAddFFE3e9OXVHxzdALPcLtkPnZX/S1uizRerK+YeMfO+jVUw17aBEduCHm+vFKAESIWsW6pZrx0Oelwj4NsC7h0NqK9hPmwnl1AieNQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 17 Oct 2025 07:09:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 392683 invoked by uid 111); 17 Oct 2025 07:09:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 17 Oct 2025 03:09:13 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 17 Oct 2025 03:09:12 -0400
From: Jeff King <peff@peff.net>
To: Collin Funk <collin.funk1@gmail.com>
Cc: Xi Ruoyao <xry111@xry111.site>, git@vger.kernel.org
Subject: Re: t7528-signed-commit-ssh.sh fails due to ssh-agent fails to start
 with ENAMETOOLONG
Message-ID: <20251017070912.GA4068463@coredump.intra.peff.net>
References: <4e2952e512afc780b621d2c153b3e6e4eb7ed89a.camel@xry111.site>
 <87o6q6nux7.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87o6q6nux7.fsf@gmail.com>

On Thu, Oct 16, 2025 at 07:06:44PM -0700, Collin Funk wrote:

> Xi Ruoyao <xry111@xry111.site> writes:
> 
> > When I test git-2.51.1 I hit a test failure in t7528-signed-commit-
> > ssh.sh.  Running it with -v reveals:
> >
> > unix_listener_tmp: path "/home/xry111/sources/12.5/git-2.51.1/t/trash directory.t7528-signed-commit-ssh/.ssh/agent/s.fTyCxA5V6V.agent.dX2yNWQUX5" too long for Unix domain socket
> > main: Couldn't prepare agent socket
> >
> > So this seems an issue in the test harness.  Is it possible to fix it?
> 
> Unix sockets have an unfortunate historical limit of ~100 characters on
> most systems. All the derivatives of 4.4BSD have a limit of 104
> characters. Linux has a limit of 108 characters [1]. AIX is nice and
> supports 1024 characters, but I assume you are not using that.
> 
> I guess this test can check for that error. I'll have a look.

Git's internal unix-domain socket code checks the name against
sizeof(sa->sun_path) and will temporarily chdir into the surrounding
directory and use a relative path if necessary.

The errors above aren't from Git, so presumably they're from ssh-agent
itself, which is pulling the name from the $HOME we set in test-lib.sh.
So probably we could use the same trick like:

diff --git a/t/t7528-signed-commit-ssh.sh b/t/t7528-signed-commit-ssh.sh
index 0f887a3ebe..214908b2eb 100755
--- a/t/t7528-signed-commit-ssh.sh
+++ b/t/t7528-signed-commit-ssh.sh
@@ -82,7 +82,7 @@ test_expect_success GPGSSH 'create signed commits' '
 test_expect_success GPGSSH 'sign commits using literal public keys with ssh-agent' '
 	test_when_finished "test_unconfig commit.gpgsign" &&
 	test_config gpg.format ssh &&
-	eval $(ssh-agent) &&
+	eval $(ssh-agent -a ./agent.sock) &&
 	test_when_finished "kill ${SSH_AGENT_PID}" &&
 	test_when_finished "test_unconfig user.signingkey" &&
 	mkdir tmpdir &&

But that does mean that ssh-agent will produce:

  SSH_AUTH_SOCK=./agent.sock

which is only valid from that directory. If we wanted to protect
ourselves, we'd have to further set SSH_AUTH_SOCK to the full
$PWD/agent.sock. But I'd guess that just pushes the error onto ssh-add
trying to connect later with the full pathname. Using the relative path
does seem to work for me, at least insofar as:

  ./t7528-signed-commit-ssh.sh --run=1-2 -v -x -i \
    --root=/tmp/holy-smokes-this-is-a-really-long-pathname

triggers the length issue before but not after.

But looking at this test, there's something even more funky going on.
Our $HOME will always have a space in it, because no matter where you
set the root, we will create "trash directory.t7582..." to work in. But
AFAICT, ssh-agent does not quote the path in its output. So for example:

  d='/tmp/has spaces'
  mkdir "$d"
  HOME=$d ssh-agent

will produce:

  SSH_AUTH_SOCK=/tmp/has spaces/.ssh/agent/s.IcPuGe26YY.agent.6PtD3uhM4O; export SSH_AUTH_SOCK;

which is nonsense to eval. And indeed, the "working" version of this
test (without a really long root path) produces:

  ./t7528-signed-commit-ssh.sh: 1: eval: directory.t7528-signed-commit-ssh/.ssh/agent/s.IcPuGe26YY.agent.sOzoazWiDc: not found

I expected that would cause ssh-add to fail, since our SSH_AUTH_SOCK
would point to truncated garbage, and we can't talk to the agent. But it
doesn't even do that. The extra space turns that line from a variable
assignment into a one-shot variable attached to a command that fails to
run. And so we're left with the original SSH_AUTH_SOCK from the
environment, the one in my real $HOME outside of the trash directory.
Yikes!

If I unset SSH_AUTH_SOCK in my environment, then the test consistently
fails. But I'm somewhat amazed that nobody has complained about this
before. Surely somebody somewhere (especially CI!) is running t7528
without SSH_AUTH_SOCK set in the environment. Which makes wonder if I'm
missing something.

-Peff
