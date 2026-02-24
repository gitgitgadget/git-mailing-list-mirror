Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB9B36BCDC
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 09:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771924690; cv=none; b=N2XlCTiLrIOwUq/yvq1sVjpgXXAxjxjD7zJTFJC+zXVf3koZKipBetWtwA5Enw3VwjgW+nVD/qlUeuXJgY2uVR7mxlZ9otxE+zYaqLx8nPlgubdL4+89J9EVGu17H7uZmFqPYrES8IpulpxVWxkY56e6oug+9pHNObGRvfwdZQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771924690; c=relaxed/simple;
	bh=yToWspXZleYDXxZb6xNqr2tDwn0/4GcOvT5tAGhpAkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XdiE4/QitsP+W/WFZyjvxxDGUVPaf0ExURVtUY7v1CApZdqV+gZ+UbTv2m6UVOazo8dARvRrHASg+jO1WOp2CEtP3mEDLXxHxaaZ7vmiGFekTWghor0BZhXdOH9R7LCtg1R5FGP4k20u8fbu2uWxzrA9h2e199xs7BKZ2cEY+nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=BTMCDPuZ; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="BTMCDPuZ"
Received: (qmail 59534 invoked by uid 109); 24 Feb 2026 09:18:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=yToWspXZleYDXxZb6xNqr2tDwn0/4GcOvT5tAGhpAkE=; b=BTMCDPuZ/hG6Bi1cAPjxA1DEnp0MMGC9qHNSpiRZAei5PeFzhqhPT5XYXM6voPyyQFzD3bx5IEjy+fCL7+l3Bue7C9Qimk20sK8AxKHHk/ZHPHKSWzH5MgnDf0bmgF/miL4vVYWNmzUjRP6z4Pk6PX2afz2VIOR2E62qHIR0I9IWhAOfNz2y4fG51IjXiBpICoUEJyyOvQ7c4NKhSCCAeZP5As7d93mj6iiY7FPt/V4frck9iBbN+o5oa/Mot080xDgNntaKmgNZVdyLooHZ2g0En3fg9vLZKTiCTr45n/HI6s90JRWfacLF2psLub1jWsjX+Nn7l8E26aZVbeq8rA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Feb 2026 09:18:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 143369 invoked by uid 111); 24 Feb 2026 09:18:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Feb 2026 04:18:12 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 24 Feb 2026 04:18:06 -0500
From: Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com, fastcat@gmail.com,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 2/2] for-each-repo: work correctly in a worktree
Message-ID: <20260224091806.GC986367@coredump.intra.peff.net>
References: <pull.2056.git.1771903950.gitgitgadget@gmail.com>
 <a47f9e9386badd83f0f5820f33f5eed68ca5fd82.1771903950.git.gitgitgadget@gmail.com>
 <CAPig+cQcpJu_Z6VXbn5cee2AHmPHQaOLG39HFRG1SGnnY1cWFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cQcpJu_Z6VXbn5cee2AHmPHQaOLG39HFRG1SGnnY1cWFA@mail.gmail.com>

On Mon, Feb 23, 2026 at 10:34:30PM -0500, Eric Sunshine wrote:

> > diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
> > @@ -60,6 +61,9 @@ int cmd_for_each_repo(int argc,
> > +       /* Be sure to not pass GIT_DIR to children. */
> > +       unsetenv(GIT_DIR_ENVIRONMENT);
> 
> This only unsets GIT_DIR. Is that sufficient in the general case?
> Elsewhere, we recommend[*] unsetting all of Git's local environment
> variables.
> 
> [*]: From the "githooks" man page: "Environment variables, such as
> GIT_DIR, GIT_WORK_TREE, etc., are exported so that Git commands run by
> the hook can correctly locate the repository. If your hook needs to
> invoke Git commands in a foreign repository or in a different working
> tree of the same repository, then it should clear these environment
> variables so they do not interfere with Git operations at the foreign
> location. For example: `unset $(git rev-parse --local-env-vars)`"

Yeah, agreed. There's another subtle issue, which is that this is
unsetting GIT_DIR in the parent process. So any other code we call that
is meant to run in the original repo might get confused. I can well
believe there isn't any such code for a command like for-each-repo, but
as a general principle, the change should be made in the sub-process.

You can stick the elements of local_repo_env into the "env" list of the
child_process struct. If you grep around, you can find some instances of
this.

There's an open question there of how to handle config in the
environment, though. Depending on the sub-process, you may or may not
want such config to pass down to it. For for-each-repo, I'd guess that
you'd want:

  git -c foo.bar=baz for-each-repo ...

to pass that foo.bar value. We do have a helper to handle that in
run-command.h:

  /**
   * Convenience function which prepares env for a command to be run in a
   * new repo. This adds all GIT_* environment variables to env with the
   * exception of GIT_CONFIG_PARAMETERS and GIT_CONFIG_COUNT (which cause the
   * corresponding environment variables to be unset in the subprocess) and adds
   * an environment variable pointing to new_git_dir. See local_repo_env in
   * environment.h for more information.
   */
  void prepare_other_repo_env(struct strvec *env, const char *new_git_dir);

Do be careful using it here, though. It expects to set GIT_DIR itself to
point to the new repo (which is passed in). But I'm not sure that's 100%
compatible with how for-each-repo works, which is using "git -C $repo"
under the hood, and letting the usual discovery happen.

So for a bare repo, you'd want to pass the repo directory. But for a
non-bare one, you'd want $repo/.git. And there are even more weird
corner cases, like the fact that using "/my/repo/but/inside/a/subdir"
with for-each-repo will find "/my/repo".

So you might need to refactor prepare_other_repo_env() to split out the
"everything but the config" logic versus the "set GIT_DIR" logic. Or
just inline the former in run_command_on_repo(), though it probably is
better to keep the logic in one place (it's not many lines, but it has
to know about all of the env variables that affect config).

Alternatively, for-each-repo could do repo discovery itself on the paths
it is passed, before calling sub-programs. That's a bigger change, but
possibly it could or should be flagging an error for some cases? I
dunno.

-Peff
