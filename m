Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00D3192D96
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 17:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725556878; cv=none; b=hOXj7geiTth0rY/RnkQnNEnvs493fLQh95SYvlkz8aYv8Wrk80pOJ7Q7SItT6V0/oY133lVdzq8mOXbpx4UHJwH4CqEW6ytmKnVKBkewtZUdW4CPH1LUeEWu0icCf0o6rQJfbqANzkdH/TdRBfGHZdD3Re55jQ4sVB4XGixS0mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725556878; c=relaxed/simple;
	bh=n/Olp2tZY9ayuQepNEibQsgHF3eBvWklSeSQSGZhsl0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=btwSd7wSrA7FNoefcVf8B3NHiPZkevq9mHaOtk/VFlZcGTWg9rxNx8MnltHJrnzpxyfanvFSZDzKjqUhvN+ckQKfHVHW6bf4i9PvcRZpVY5qd39Mg5g0ovZk8a89dqHldD4fMIFfTn/UUJ7PcbL2EtEvPxd4RNqwPIo6zElObmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=TuRWeU7E; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TuRWeU7E"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 540E426561;
	Thu,  5 Sep 2024 13:21:10 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=n/Olp2tZY9ayuQepNEibQsgHF3eBvWklSeSQSG
	Zhsl0=; b=TuRWeU7EXlPngDDL7Ymf5pJ5i7klulcdxT+qAj8O8eFCoLljZE1i/X
	WeeUXsedHTr+FXrZJU6IAumgLu+P4jadPJJrJTSgoSZvbh36PF1CFVKcdIz38ehX
	mrimmjGkHvpRfSXGJzZlNOjgUOMQXt31kz/9AYD1z2toEXtMcSSMY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 34D2A26560;
	Thu,  5 Sep 2024 13:21:10 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 591442655D;
	Thu,  5 Sep 2024 13:21:09 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 0/3] Add repository parameter to builtins
In-Reply-To: <pull.1778.git.git.1725555467.gitgitgadget@gmail.com> (John Cai
	via GitGitGadget's message of "Thu, 05 Sep 2024 16:57:44 +0000")
References: <pull.1778.git.git.1725555467.gitgitgadget@gmail.com>
Date: Thu, 05 Sep 2024 10:21:04 -0700
Message-ID: <xmqqjzfq2f0f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3DE5EF62-6BAB-11EF-B677-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> As part of the effort to remove global state of the_repository, add a
> repository parameter to builtins so that a repository variable can be passed
> down. The patches are ordered as follows:
>
>  1. Changes the signature of builtins and passes the_repository down in
>     git.c to be called by all builtins.
>  2. Remove USE_THE_REPOSITORY_VARIABLE from builtin.h, and instead add it to
>     each individual builtin. This paves the way for a migration process
>     whereby each builtin can be migrated away from using the_repository.
>  3. As an example, migrate builtin/add.c to get rid of the_repository by
>     instead passing the repository argument down into helper functions.

As most of the commands require a repository (as they should---those
that work without a repository ought to be outliners, things that
are needed to bootstrap like "git init" and "git clone", or those
that allow us to interact with a remote repository without having
any repository on our side to be affected, like "git archive" or
"git ls-remote"), I think this probably makes sense as a good first
step.

And there are commands that are primarily for working with Git, but
optionally can work outside a repository.  They need to do special
things in any case by calling setup_git_directory_gently() with
nongit to figure out if they are in the repository, e.g.

	prefix = setup_git_directory_gently(&nongit);

	if (!nongit) {
		prepare_repo_settings(the_repository);
		the_repository->settings.command_requires_full_index = 0;
	} else {
		... do whatever it can outside a repository ...
	}

(note: this was taken from "git diff" with a bit of tweak, but
others in the same category should look very similar), so I would
imagine that we may want to update setup_git_directory_gently() to
be more like:

	const char *setup_git_directory_gently(struct repository **repo);

and the above snippet would become:

	prefix = setup_git_directory_gently(&repo);

	if (repo) {
		prepare_repo_settings(repo);
		repo->settings.command_requires_full_index = 0;
	} else {
		...
	}

IOW, "nongit" Boolean flag we use to say "are we working without a
repository?" becomes "the dispatcher in git.c usually gives us the
repository in repo, but we asked them not to do the repository setup
and we will call setup_git_directory_gently() ourselves, allowing
the call to overwrite the repo parameter given."

Thanks.
