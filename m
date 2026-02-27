Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA192C237E
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 22:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772232162; cv=none; b=mg8Oyf5GWNuw3W988BivvDZL4qAhvrHrssvOkZyVnDDZKUGrFp/63cMP95e8TWp9V8ETEfWC1rv9hltPqZwMrWsjQ+2wRTCKRvSay26O1zsNAtqODd1IW9XgNVSbpKvYQQJYolGiTMp+kovTnCs0gyzuGEI3avyLk+2Yt98MPao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772232162; c=relaxed/simple;
	bh=CHNB3e/3R+PaH9Gf4XRgzT1APTapfGUFKxW46+ftPzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQ0oko35sLu1gJqua5vqDBai6e5xlgoNrbBrhPLvA0F+Olllse8nuK3wUwIxJxTbUlh36R2l6sJE4uzfqVFDjoGSKRmWif+h6SK8+ewEb4vb2u/ZY4qVnTXfsMSP82yCxxVm7Leozum6RVb6iDxVE1MvVsw/FqcUq64ouzHSDwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=HvQ3L/cB; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="HvQ3L/cB"
Received: (qmail 83406 invoked by uid 109); 27 Feb 2026 22:42:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=CHNB3e/3R+PaH9Gf4XRgzT1APTapfGUFKxW46+ftPzU=; b=HvQ3L/cB7fgTVpHnpOh4y5Gq0kKM8LQoEkYf+wWtwlkRuZFGHxfvwDKiRYbkTNYR4vO2q3y7JHy5v/P8SMfLKKcpiWhN1zuJH1WknGtStQUTO7iwwdL5pQTdlAZO2GyD7g2fZiWiylpHdZeb+mhhrwn+3pVy1injVBM+/Jdbp3vAsmCBaS7wCbYGHSKS0o99+N5vplYQSKOAtSQEja9K6VYxJxqydbmZarR8rrz2nvSwvzjtyYWcL008v/tLppufmlUr9BLmILNPVqizJZWlyAoeQLQj66peZ4hV2GUkZ1y5snyN+HrzZv6mrAsMBerYzXyLXZCHdrLcKlNRqBA5Fg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 27 Feb 2026 22:42:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 281826 invoked by uid 111); 27 Feb 2026 22:42:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 27 Feb 2026 17:42:41 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 27 Feb 2026 17:42:38 -0500
From: Jeff King <peff@peff.net>
To: Derrick Stolee <stolee@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, fastcat@gmail.com,
	Eric Sunshine <sunshine@sunshineco.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 2/2] for-each-repo: work correctly in a worktree
Message-ID: <20260227224238.GA2956443@coredump.intra.peff.net>
References: <pull.2056.git.1771903950.gitgitgadget@gmail.com>
 <pull.2056.v2.git.1771968924.gitgitgadget@gmail.com>
 <4e3f4aa6cd36f779c6c1d6b4f30bb68ed807b9da.1771968924.git.gitgitgadget@gmail.com>
 <xmqqv7flervq.fsf@gitster.g>
 <eeebc30a-40bf-40ac-a16b-ca5e128c3c01@gmail.com>
 <20260225131344.GA2139176@coredump.intra.peff.net>
 <08c6e203-3444-45c7-9bc9-cc2590be30c3@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <08c6e203-3444-45c7-9bc9-cc2590be30c3@gmail.com>

On Thu, Feb 26, 2026 at 10:29:47AM -0500, Derrick Stolee wrote:

> Great point. Here's another attempt:
> 
> static int run_command_on_repo(const char *path, int argc, const char ** argv)
> {
> 	int i = 0;
> 	struct child_process child = CHILD_PROCESS_INIT;
> 	char *abspath = interpolate_path(path, 0);
> 
> 	while (local_repo_env[i]) {
> 		/*
> 		 * Preserve pre-builtin options:
> 		 * - CONFIG_ENVIRONMENT, CONFIG_DATA_ENVIRONMENT, and
> 		 *   CONFIG_COUNT_ENVIRONMENT persist -c <name>=<value>
> 		 *   and --config-env=<name>=<envvar> options.
> 		 * - NO_REPLACE_OBJECTS_ENVIRONMENT persists the
> 		 *   --no-replace-objects option.
> 		 *
> 		 * Note that the following options are not in local_repo_env:
> 		 * - EXEC_PATH_ENVIRONMENT persists --exec-path option.
> 		 */
> 		if (strncmp(local_repo_env[i], "CONFIG_", 7) &&
> 		    strcmp(local_repo_env[i], NO_REPLACE_OBJECTS_ENVIRONMENT))
> 			strvec_push(&child.env, local_repo_env[i]);

This is slightly different than what prepare_other_repo_env() does:

  - it doesn't drop GIT_CONFIG_*, but assumes that removing
    GIT_CONFIG_COUNT is enough for GIT_CONFIG_KEY/VALUE to be ignored
    (and then also removes GIT_CONFIG_PARAMETERS, of course)

  - it doesn't consider NO_REPLACE_OBJECTS at all

I think you could make arguments either way about what should happen
when spawning a command in another repo. But I'd really prefer for us to
have a single spot to specify that policy, and not subtly-different
behavior from different commands. So I'd really like to see this using
that other function (or the logic from it factored out into a helper).

And then we can consider whether to make changes to that policy.

Dropping GIT_CONFIG_* from the environment does make sense in general,
but it doesn't actually happen with the patch above (because only
GIT_CONFIG_COUNT is in the local_repo_env list; to find the others we'd
have to actually enumerate the current environment).

For NO_REPLACE_OBJECTS, I think you could argue that it should not be in
local_repo_env at all. It is more about the operation being performed,
not the repository itself. So for example in this command:

  git --no-replace-objects fetch

I would expect that NO_REPLACE_OBJECTS to make it down to any submodule
fetches we do. Likewise for other operation-level variables like
GIT_LITERAL_PATHSPECS, but those are already (correctly IMHO) omitted
from local_repo_env.

It looks like NO_REPLACE_OBJECTS got pulled from the connect.c code in
48a7c1c49d (Refactor list of of repo-local env vars, 2010-02-25). And I
could see somebody wanting to make sure that upload-pack behaved
predictably with respect to replace refs, but it already does: it
disables replace refs itself as part of its startup code.

> This comment details my findings from comparing the list in
> local_repo_env[] and the top-level options listed in
> Documentation/git.adoc. That's how I was able to find that
> --exec-path sets an environment variable that's NOT in the
> list and we want to be sure we don't set it.
> 
> Should we add the comparison to EXEC_PATH_ENVIRONMENT as a
> precaution to make sure it's not added to local_repo_env in
> the future? Or is that too defensive?

I don't think we need to bother. Obviously adding it to local_repo_env
would be the wrong thing, but that is true of lots of variables. Trying
to make a list is just going to result in a list that is out-of-date,
because there's nothing pushing people to update it when they introduce
a new variable.

You can imagine a different world, where we had a single list of all
environment variables, and new ones _had_ to be added to the list in
order to function, and each entry had a bitflag for "this is a
local-repo value", then that might force each new addition to consider
whether it should be added. But we don't have such a list, and I think
structuring things that way would introduce new complications and
awkwardness.

So IMHO we should just rely on review to reject a patch that tries
something silly like adding EXEC_PATH_ENVIRONMENT to local_repo_env.

-Peff
