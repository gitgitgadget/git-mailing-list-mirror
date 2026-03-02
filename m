Received: from newcloud.peff.net (unknown [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5FE3161A3
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 18:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772474607; cv=none; b=VOfneWDVH7uyLMh6W1A9wFjQxkLjsq1RsLcCgth/aKq99USXuSIFWx9uu/JhG+bEvCN0CxJ+o9LNiAZHa4odjM87ZrliIK1kLGt03BNPEv6iGdEl9fvvkzv50uK39Vu6Wuvyxbxi/KnhVP8//DaimVjxvBJbhMjhNjLBlkg862o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772474607; c=relaxed/simple;
	bh=tOOWI/WNLxab2CgTcyiorPjGTS0qaaL0FgRX897doH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqXf1mE4GnO35JfC4YT8d+Q6jTtRkNplC/924BFT8JyNAS3oOSD6d86eZeMy1RLDq9dXQm4Hc2/TkCsAZMuQoE+xND0GO4VtTsJZc0ympQBg8ef2quNF9Fprak47yMe/jI2DbGh0arWqJCzYEBNQ3mhcVZU4vS0Y0UUI1RVb8Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=IN7rh/ac; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="IN7rh/ac"
Received: (qmail 29064 invoked by uid 106); 2 Mar 2026 18:03:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=tOOWI/WNLxab2CgTcyiorPjGTS0qaaL0FgRX897doH0=; b=IN7rh/acN2aPICvvdnrS7BTpBsbpLCiDA8qJocI74+Z6q7aHHYSjRAHzTPiPc0Mwam+9/qTiAX7NnDFBVqVi7AQiFk8d21vaSViqhd7eQwhrMiWNKHpLsSeMZY06CpbJK7OYVtm+1MMwa7d+pchLSXTD7ND3MOzUfQmQFLgsRP+NUXJqruGwkFOM+D+dPKU2Y2Ymu+w+xmSMr509ngCJpu5bmDpFFo4a/Irtl6g5tLc3qTOufXixpQmxXcxfXIiYbTv1IDi2oYWLha7cM4ZAKCxmXj8R+EScEgaSQDdAttLpRLmN2daxE6cJ+n5j6nvNqzxZKnyNmC3EfTj1xn4obQ==
Received: from Unknown (HELO peff.net) (10.0.2.2)
 by newcloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 02 Mar 2026 18:03:24 +0000
Authentication-Results: newcloud.peff.net; auth=none
Received: (qmail 333862 invoked by uid 111); 2 Mar 2026 18:03:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 02 Mar 2026 13:03:25 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 2 Mar 2026 13:03:24 -0500
From: Jeff King <peff@peff.net>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, fastcat@gmail.com,
	Eric Sunshine <sunshine@sunshineco.com>,
	Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 2/4] run-command: extract clear_local_repo_env helper
Message-ID: <20260302180324.GC28275@coredump.intra.peff.net>
References: <pull.2056.v2.git.1771968924.gitgitgadget@gmail.com>
 <pull.2056.v3.git.1772465805.gitgitgadget@gmail.com>
 <13d783dbbdd77b14fed651f0508fa0e668d98c63.1772465805.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <13d783dbbdd77b14fed651f0508fa0e668d98c63.1772465805.git.gitgitgadget@gmail.com>

On Mon, Mar 02, 2026 at 03:36:43PM +0000, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <stolee@gmail.com>
> 
> The current prepare_other_repo_env() does two distinct things:
> 
>  1. Strip certain known environment variables that should be set by a
>     child process based on a different repository.
> 
>  2. Set the GIT_DIR variable to avoid repository discovery.
> 
> The second item is valuable for child processes that operate on
> submodules, where the repo discovery could be mistaken for the parent
> repository.
> 
> In the next change, we will see an important case where only the first
> item is required as the GIT_DIR discovery should happen naturally from
> the '-C' parameter in the child process.

Yep, this is the refactoring I expected.

> +/**
> + * Unset all local-repo GIT_* variables in env; see local_repo_env in
> + * environment.h. GIT_CONFIG_PARAMETERS and GIT_CONFIG_COUNT are preserved
> + * to pass -c and --config-env options from the parent process.
> + */
> +void clear_local_repo_env(struct strvec *env);

I worry that the name is potentially confusing here, since it is not
just clearing local_repo_env, but making a few exceptions. But I don't
really have a better name. We called this "other_repo_env" in the
existing function, which is equally opaque. I dunno, maybe the
documentation you added would be sufficient.

Speaking of which, the documentation for prepare_other_repo_env() is now
somewhat redundant. If we ever change the behavior here, we'll have to
remember to touch both spots.

So what about squashing in:

diff --git a/run-command.h b/run-command.h
index 76b29d4832..882caeccc8 100644
--- a/run-command.h
+++ b/run-command.h
@@ -518,11 +518,9 @@ void clear_local_repo_env(struct strvec *env);
 
 /**
  * Convenience function which prepares env for a command to be run in a
- * new repo. This adds all GIT_* environment variables to env with the
- * exception of GIT_CONFIG_PARAMETERS and GIT_CONFIG_COUNT (which cause the
- * corresponding environment variables to be unset in the subprocess) and adds
- * an environment variable pointing to new_git_dir. See local_repo_env in
- * environment.h for more information.
+ * new repo. This removes variables pointing to the local repository (using
+ * clear_local_repo_env() above), and adds an environment variable pointing to
+ * new_git_dir.
  */
 void prepare_other_repo_env(struct strvec *env, const char *new_git_dir);
 

-Peff
